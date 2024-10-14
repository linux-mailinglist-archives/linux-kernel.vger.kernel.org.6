Return-Path: <linux-kernel+bounces-364844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2D99DA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4BD1C210E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD18D1D6DA1;
	Mon, 14 Oct 2024 23:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BL7Bc05R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACF17BD3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728948452; cv=none; b=dy1mBsfEXUkzv81tAoL5ilu1L+xzwWkRTcLlS+in2zK3sGkm8RnPV4rncPYH30JHVkFl+4iF036+nZ/Q3GLZbgIA7hHw1yxB4NBY6bAcBE79HBbbycpOrKIATAwRbl+D4z8qFnywvw0izZfXQJYc+jaFwQxBAVuV54ATuosXy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728948452; c=relaxed/simple;
	bh=1VtNGbXZaQAM0U0mRZHS9DjszaFz7prhsJk/aVTmoUU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mAdRJWouPTatgc3PBkH7aJdnI8Xh2cuoUa8yssUUlqBmtYaiYp085iOkIABcQy26Wj191MiCx255klRFH10S/Zn7b/PEuwEOJIm1KUeA5gEtQLLOPf9eMYE9r5qkG0sbBAKd7X3DeR10Ad4uKhFTJAbZFm+aVKTUBdiskYnJCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BL7Bc05R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB6CC4CEC3;
	Mon, 14 Oct 2024 23:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728948450;
	bh=1VtNGbXZaQAM0U0mRZHS9DjszaFz7prhsJk/aVTmoUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BL7Bc05RKO7vSIUnM2QkJnnXtUpHz4PbmyuPl/jMYK+h2msR/Ad8DRMZuBuf1NfBb
	 flSYcvKdSl7JLdpuQO37IF5xPR2JchP0UmYHCgk3r14P5y/CILJOIk4CuSK+fA5fgG
	 GJyg5A3ARfbqGFWR0YQt6NGiG8h5NA3A5Cxx1klc=
Date: Mon, 14 Oct 2024 16:27:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Xu <weixugc@google.com>
Cc: Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>, Jan
 Alexander Steffens <heftig@archlinux.org>, Suleiman Souhlal
 <suleiman@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/mglru: reset page lru tier bits when activating
Message-Id: <20241014162730.fc48f2a53b89639a6207ba9d@linux-foundation.org>
In-Reply-To: <20241014221231.832959-1-weixugc@google.com>
References: <20241014221231.832959-1-weixugc@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 22:12:31 +0000 Wei Xu <weixugc@google.com> wrote:

> folio_activate() calls lru_gen_add_folio() to move the folio to the
> youngest generation.  But unlike folio_update_gen()/folio_inc_gen(),
> lru_gen_add_folio() doesn't reset the folio lru tier bits
> (LRU_REFS_MASK | LRU_REFS_FLAGS).  Fix this inconsistency in
> lru_gen_add_folio() when activating a folio.

What are the runtime effects of this flaw?


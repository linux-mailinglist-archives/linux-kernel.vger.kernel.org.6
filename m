Return-Path: <linux-kernel+bounces-249847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1492F0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D5282067
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E119EEC5;
	Thu, 11 Jul 2024 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D9zNZG6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216C2836A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732063; cv=none; b=XkwChwoBzsb+0lrFs7Nxr3FPyAJqVXPNJLWr6h32j59djPZaMsFpeqQgpRWgYXd79bpBZlgUk/kFWYvdWYfcIEK78V3oom+SxZ7UCwObem0GuWbcAKZlx2miXavIVCzjHr0I6ENclnKhGI7Y1Py14hS36upG+wivzgk7i3hBOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732063; c=relaxed/simple;
	bh=hUkzMfgfk3Jb5blmtmmKkdb94ztGlZaEz0LGll+XSww=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L1kRknneDNz1CpNiHDKC0Bcbsf3W5jrkc5EYFJefrWQhk3i3uRdmrEybBbAOOfN7jRm9aa1J9lQQrdbtIaIntt7ZwCGAqZLqz6iJ0Xf44sb/dzWjQMeLFyPsbxfsq0KWXUUkUF46bvyZac2orUO8uMe7NVt8pnGkaujOtqo1zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D9zNZG6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B303EC116B1;
	Thu, 11 Jul 2024 21:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720732063;
	bh=hUkzMfgfk3Jb5blmtmmKkdb94ztGlZaEz0LGll+XSww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D9zNZG6kCkB0zqQElMgduLONUwogGrZPIfZm+8fV9KoEvX+M7uWRGym/lxiE/JW/A
	 Kzq6oBdUpTZ/KSoj7QgNFhvjKjQiuhLtNAMMMV8k8eIxucic0TEkDoLFH60na78DD5
	 JJI8eEvHQ/cCLXLLR3S5lUxrMo3b/fnu7pfTZIx0=
Date: Thu, 11 Jul 2024 14:07:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH 1/1] alloc_tag: Export memory allocation profiling
 symbols used by modules
Message-Id: <20240711140742.b2c536fb4de2800534a99980@linux-foundation.org>
In-Reply-To: <20240711204626.1669138-1-surenb@google.com>
References: <20240711204626.1669138-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 13:46:26 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Export mem_alloc_profiling_key, page_ext_get() and page_ext_set() symbols
> as they can be used by modules (mem_alloc_profiling_key is used indirectly
> via mem_alloc_profiling_enabled()).

Thanks, I'll add

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling").


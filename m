Return-Path: <linux-kernel+bounces-512082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB7A333D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750C93A8690
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24F6FC3;
	Thu, 13 Feb 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eEuCi3Pp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115B4A01
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405398; cv=none; b=CzndrHtp2V8CRMQhgxigz87rJ6NcBgpF+MeIr3OaL3bpEhlAfqHcOjHKrz141zktpKMAcB2my+lAqDZ1sZQEyKOMMUfiD8f1auQpWNJ9t6lOwVvHINDg+pOC/TZWyMAuf58jHt9NDVLqQcizvvL46fvu2aohbJuBZwpA9J0gsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405398; c=relaxed/simple;
	bh=W+6JVy/Yr08AKhdPCEqUUiMejboNNHm9HKHg7t8R0rQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OKOwa1FOWJt5000WNgJtbJ49prBqGF91RSlUhNHC6iDDOBg0uExdrqIUdhCodf3vDCcI623KHP/8b6A0a5Klrx/oLUk95rW567fLcyFgoLPD3PyTfWO14mpIAhf57boTZW4Zwd+sBzGu1R+FvzYhQbPt71wCvlmbP7XCR13/oVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eEuCi3Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462C3C4CEDF;
	Thu, 13 Feb 2025 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739405397;
	bh=W+6JVy/Yr08AKhdPCEqUUiMejboNNHm9HKHg7t8R0rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eEuCi3Ppf3cCDocwnnreieMvJ01hjMCDynekw6cgXFCg5raNVlXdCv+arMHgzna/C
	 4cTDFIRk0D79AhSk3m9XNSCI0kMZkpBJhv8kECPUGtWHH4kGUH4DEfH7g5B8UQvUDv
	 ozKDJxFxtPSuuj3Jr1Mh6PPz8CclUZLcalOcfnXY=
Date: Wed, 12 Feb 2025 16:09:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Kairui Song <ryncsn@gmail.com>,
 Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/18] zsmalloc/zram: there be preemption
Message-Id: <20250212160956.8bc390876af3c6669b8031d2@linux-foundation.org>
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:26:58 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> First, zsmalloc is converted to use sleepable RW-"lock" (it's atomic_t
> in fact) for zspage migration protection.

This sentence is stale?




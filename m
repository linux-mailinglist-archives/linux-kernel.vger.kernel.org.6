Return-Path: <linux-kernel+bounces-310453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC0967D42
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2462D1C2122C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F66179AA;
	Mon,  2 Sep 2024 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MbAYQRFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532168460
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240016; cv=none; b=k3rMze2uOHJG3nun0EDAyjVPMS4al/C/BRLGf4dHUmeVzKUYNO9oYaQElXWWdv43ZLoMhxf+OA1k4vn1rOzdkSJRe2E7YJFbrjZ5yqdC22dUGNHXzgc2JWVsIeFGEEXzXP1RizNoTklP15oF8/CFTJJZEy+NzC76wm5M69/fhIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240016; c=relaxed/simple;
	bh=GqUXs4xVcUDFOljdnRBw1sWw73ZCq55GneuW1ZNi/bs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kchg9lKzLq0r29VUS4z7XF0VWVlWMZc5n+JRsYUdQ47I81BfEwhCHhFpi4bazeH2TH7a027FRlxqgHlEgiGBNGwi6BwH3cQS1OLfTrqjFMzzuuAQ48LwKXAUeJKw3HaCuO/lWSwgwxf3dQdyHwEAPoLCf0VLHmAT2EfVrnRutEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MbAYQRFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A175C4CEC3;
	Mon,  2 Sep 2024 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725240015;
	bh=GqUXs4xVcUDFOljdnRBw1sWw73ZCq55GneuW1ZNi/bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MbAYQRFdxGKZ3Lg72rs9hbSYMxBZ3hj1ULHRLJd1dlobkub7A14MzgApe/SX/ps1Y
	 UEOJ/TPfWWWKWHUqm4KwTX871N0yR+GMzBFpRH4yIhcW29rh4FlSv342IvM76sslxN
	 eFrJP83mS8UbKLQsf1FHijrUVDdqMoYKJ7hPcai4=
Date: Sun, 1 Sep 2024 18:20:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, Ryan
 Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap
 cluster order
Message-Id: <20240901182015.854b470ca8ecf454bd42bf60@linux-foundation.org>
In-Reply-To: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 23:49:12 -0700 Chris Li <chrisl@kernel.org> wrote:

> This is the short term solutions "swap cluster order" listed
> in my "Swap Abstraction" discussion slice 8 in the recent
> LSF/MM conference.

Well this patchset hasn't needed a -fix patch since Aug 5, which is
hopeful.

How do people feel about moving this series into mm-stable for the next
merge window?

A few notes I've made are

https://lkml.kernel.org/r/CACePvbX1EWQk03YcC47s7+vn40kEFb_3wp3D_GmJV-8Fn2j+=Q@mail.gmail.com
https://lkml.kernel.org/r/87bk23250r.fsf@yhuang6-desk2.ccr.corp.intel.com
https://lkml.kernel.org/r/CACePvbU9NUgfD-QC-hdYEmeMbLc5whOKeW4hb2ijcPonZ4i6mg@mail.gmail.com

Have these all been resolved?

Thanks.


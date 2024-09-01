Return-Path: <linux-kernel+bounces-310148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2625967583
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5C282A5B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57E14387B;
	Sun,  1 Sep 2024 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tem68Smi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043047F5B
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725177840; cv=none; b=rH3sVbzHKd9Ik68h5Cf2WKSoZ8dk2ZPLkyUID8EjwWoK1tDPEzDJWXDo/U6JQlerz4N0LjOINvgC6o6C1g14hx7N3OVM4ki6eSThBX9idXZWDD87Qcx/5e9yrzumImTRJw1rfT1CUjh7mhxbrft+0l2ZuyNq672pQhg9MbNsIaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725177840; c=relaxed/simple;
	bh=/ehL7wPPW3RWUjelV1QLYbzcCwCJm4smDIr9vhFB5Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj40u14rwI+ACjNMhDnin3xPDybXbCKu0H88V5wMbcyi4L2nDekGqgCM3WYY22RF1GhJdSd9M0a7yDTCoa/zNrRx+UQQHQxzjX8G2xavibhNDJPPDBZ0d8Br8ikra7g7qJIBkMBhdfn68Q78BqfFR3/8PmI8lWWTyQnQ69CTuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tem68Smi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7273DC4CEC3;
	Sun,  1 Sep 2024 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725177839;
	bh=/ehL7wPPW3RWUjelV1QLYbzcCwCJm4smDIr9vhFB5Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tem68SmikW0Ch9kxdmzk7U53dJxaRr0mdcP6lNdG9qNvYyRZJO4P5RDeqIL/ySqr+
	 bnKcoB+TO/E14CmYDBTBTOP+3OpuMp6SYk5wDvJspm16A+kexj9XhqlfIUbYpLT/vi
	 6qyYg03cbqVKHPpGxDJyx+gVz5wgko3F0Q4IhbqDP6k0Io1gu1qPexlCip4Uqyc54B
	 uIkFI3TXVOWOUjEk8qjzXblhFgjy16h2MzYkpSHiptiocmKWER2Ok5h/qX8ledT5C6
	 0LaCumKo0AIrQRXJsoSzzfRArbBtHcWwStwAag85hjLvZvDX8RwUWvTLtuDqPeoANa
	 Cn/SjRwKObiyQ==
Date: Sat, 31 Aug 2024 22:03:58 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] sched_ext: Fix processs_ddsp_deferred_locals() by
 unifying DTL_INVALID handling
Message-ID: <ZtQf7jPR3He48jLH@slm.duckdns.org>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-5-tj@kernel.org>
 <ZtIFDmWxIO0nXCZA@slm.duckdns.org>
 <20240901005337.GD70166@maniforge>
 <20240901005639.GE70166@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901005639.GE70166@maniforge>

Hello,

On Sat, Aug 31, 2024 at 07:56:39PM -0500, David Vernet wrote:
...
> Sorry, should have been more clear: the testcase dispatched all tasks to
> the wrong CPU, which is why it's a kworker in the print output below. I
> believe that ksoftiqrd hit the same path as well and just wasn't printed
> in the output because it lost the race to scx_bpf_error(). Let me know
> if you want the testcase to repro and I can send it, or send a separate
> patch to add it to selftests.

Yeah, please share the repro.

Thanks.

-- 
tejun


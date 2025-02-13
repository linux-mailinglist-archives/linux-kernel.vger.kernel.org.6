Return-Path: <linux-kernel+bounces-513740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA166A34E14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15677A460A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C500245AF9;
	Thu, 13 Feb 2025 18:52:45 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A8245AF2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472764; cv=none; b=AZGhwuzaGpJHN9JS9K/PWK86AJNDMssDUFkhrGCda++4gL5V0AoI01ATfyzcquR9dsvk3L8IKnPHh7Ek+XxiyABBHNkz0A1DJS+pwL2ZuswXtAdJTMpvuvh69kza5K+5hPz154cFyaDJLbWiElf+UxSttGKQ/mAr4jMNpj3t8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472764; c=relaxed/simple;
	bh=RSALijCH6oG8xA04buFXAlVZne7UppEJdwslExTCEsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUiqVl/7cSGffQJwCLaFU1+iOSUOL7bKAA/g4HhSVK8BwcOQV/T3w0q2ovYxh51quB+5TgWKmI8UGhmwuV0oLS0lf7X9ZcITwvYE+puKZFPhfFn0iDoLit7Z2hrCxQhJ/ifcEJHFLSCBYectobztV6UTHjA7jG4usOxaiBQ/SvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51DIqMsE001272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 13:52:23 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6A78515C0009; Thu, 13 Feb 2025 13:52:22 -0500 (EST)
Date: Thu, 13 Feb 2025 13:52:22 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [next-20250212] FStests generic/451 on EXT4 FS resulting in
 kernel OOPs
Message-ID: <20250213185222.GA398915@mit.edu>
References: <6f43bd29-d72b-4a39-b931-7b1b47c7cc06@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f43bd29-d72b-4a39-b931-7b1b47c7cc06@linux.vnet.ibm.com>

On Thu, Feb 13, 2025 at 11:21:22AM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> I am observing kernel OOPs, while running FStests generic/451 on EXT4 with
> linux-next kernel(next-20250212) on IBM Power Servers.

I'm running daily spinnner tests on the fs-next branch on the
linux-next tree, via:

   gce-xfstests ltm -c ext4/all,xfs/all,btrfs/all,f2fs/all -g auto --repo \
       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next \
       --watch fs-next

The fs-next branch is a subset of linux-next which only has file
system related branches.  This avoids instability caused by non-fs
related changes.  I'm not seeing any kernel oops on today's fs-next
running on an x86 cloud server, using a standardized config.

Looking at the kernel stack trace of your report, it appears that a
linked list used by the workqueue handler (in process_one_work) had
gotten corrupted.  This could be caused by anything (which is one of
the reasons why I test using fs-next instead of linux-next; we didn't
want to spend time debugging problems that aren't under our control).

Is this something which you can easily reproduce?  If so, can you try
seeing if it reproduces on the fs-next branch, and could you try
bisecting the to find the guilty commit?  If this was something we
could reproduce in my test infrastructure, the bisection could be
trivially accomplished via:

   gce-xfstests ltm -c ext4/4k generic/451 --repo linux-next.git \
      --bisect-bad linux-next --bisect-good v6.14-rc1

... and then wait for an e-mailed report to land in my inbox.   :-)

Can you do something similar using your test infrastructure?

Unfortuantely, given the stack trace, I doubt kernel developers would
be able to do much more with your report.

Thanks,

					- Ted


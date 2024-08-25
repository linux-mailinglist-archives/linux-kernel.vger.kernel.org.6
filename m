Return-Path: <linux-kernel+bounces-300508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647FB95E496
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C49F1F213EC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177B615530F;
	Sun, 25 Aug 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eNMRCR59";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CBmQ0yUK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B51118C36
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724607083; cv=none; b=dt6HemEosK9jWtpwWJ55ybx/1AWq5/ydys/oy7ja6A/UtlECjN4EivpyDWYaiD0NwiLGv/5v7qqhUYttFEIx6EphID2eEnmZ/iVtSxiM5inlzll6J2xublvT/xB9IbGVQraUFu100U6bZMTPbU6bOf8datpNz17cqYfbDSBrbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724607083; c=relaxed/simple;
	bh=wmtWUfpmfCZGEMQdVRnTrLIYzG+Q2zI2WQxByn/Uy8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kn2AYSyFE2h9aPmT5Gz3jVoU1i0NAfF1rfrG2/7k1IV+JwfDUXODznsDdqN8UZqLs5fxWWi0qXKuQH/knJ5IVR9k/+QUanbiXZUk+wSn4H72P+6u29dR8Otkq2tFTehpRE9jPx0ZHPqMYLFN/ccaBRlTzOnLaOSZFWTCD02yJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eNMRCR59; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CBmQ0yUK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724607080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rifzP16A2yr95plgYd6zfpZQqnQuyygW57qXYWyKsyg=;
	b=eNMRCR59PFJvK1Drkdb9KpEB8NRNi2WrmAYMWE5M9huxwFGfMSU6qJi3uu0A3lgs5mT0B1
	lq0i4MANemreAUXxhWeuxtxigSyk3f/Kwxe/2RoCt3VeHc2JfFb2/IMl+GLOfazQd7ckwF
	DjIOpAdQ3rBCjJmJDSIbCkhQO1puNwifH6aJbrza2uo8CxKMjzQTV8kGivkr3Z2cHBYqXt
	XmeOC0sZnGU6OOXumvhDtpuDCrCC4UuQ+1jxhQ7rY+0mui58LrfQSP0ABxp2G6Maz4D53k
	vx/JiGmloQVF7PcjE/1JIhMd6lnpGWPQ5HnkNG86cAKtMepxOJ6EmzOq/BXueQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724607080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rifzP16A2yr95plgYd6zfpZQqnQuyygW57qXYWyKsyg=;
	b=CBmQ0yUKYOsYJEOi4kMVjHlJPXOs8H243l+QRvk4dMqygWkrrumlQ29Np5PVDI0DV0F2zs
	843zjwSLsXLBwpDA==
To: kernel test robot <lkp@intel.com>, Chen Yufan <chenyufan@vivo.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:timers/core 5/5] kernel/time/timekeeping.c:220:7: warning:
 comparison of distinct pointer types ('unsigned long *' and 'typeof
 (tk->last_warning + (100 * 300)) *' (aka 'long *'))
In-Reply-To: <202408241701.NSEI3MOV-lkp@intel.com>
References: <202408241701.NSEI3MOV-lkp@intel.com>
Date: Sun, 25 Aug 2024 19:31:20 +0200
Message-ID: <87seusecgn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 24 2024 at 17:58, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> head:   42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7
> commit: 42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7 [5/5] timekeeping: Use time_after() in timekeeping_check_update()
> config: i386-buildonly-randconfig-002-20240824 (https://download.01.org/0day-ci/archive/20240824/202408241701.NSEI3MOV-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240824/202408241701.NSEI3MOV-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408241701.NSEI3MOV-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> kernel/time/timekeeping.c:220:7: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (tk->last_warning + (100 * 300)) *' (aka 'long *')) [-Wcompare-distinct-pointer-types]
>      220 |                 if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Indeed. For that to work tk->last_warning must me changed to unsigned
long. Zapped the commit for now.

Thanks,

        tglx


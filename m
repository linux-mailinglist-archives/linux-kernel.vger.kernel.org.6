Return-Path: <linux-kernel+bounces-412079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D01F9D038F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEA02844F6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE251191F66;
	Sun, 17 Nov 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="LB3+6679"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00994167DB7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846318; cv=none; b=qFSHq2LHSoLTaVb0Qs1mjpMD5eIHi57SJNvMz5KFirb/zxDQmy9gFu1/7ZgOOYhoW4T+nvaPdgYosvbvNAY8bJMJ54+GT6vgTNSyKzq+NJ5OYwuLwFpQJeYXyq39X5gBhHKPGaZftGgYrO9eDa12Pn5TN7hfX4p8W41E6/6l1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846318; c=relaxed/simple;
	bh=DPZEAE5Prz2euqWcCRFAaqF4BGDV8ZAF5eMCKYAbcLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hcAHNezXTVphPzsqoII/DrfvyrBAv9YXSoobYkF3llaq0DEqGbN4W4RcOIQoCCKvWspElr/lBDStwt9ieQgdWx/Yp46eJt6JWCQsWe9mJC2vc3UHSiRQJ6vgnqNbZ18x9ByqAuhSeEQNjFNJ0zfJbPy8vdIdxSdl65Pt68ovoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=LB3+6679; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846311;
	bh=Whwznt8AGTFflVnnQEX7dgo8jQXeAZc+kZEuI8J0BII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LB3+6679yJHY/ctV5rALLE25zQb2KH3hvYCgRGl/4YAML6eUQr7czEwhMGCFbOroG
	 fJM1YmmKRHjjWzHk8y/AGZEdZvN3Vh+i86Ir3PTrnx4AhhExwy2bcyi9uuhNlP8N5J
	 Lk+KC0loly16CrZU1w+WDH3S6ox+C/cRjTHlByC4SJSTzM0boT/K3Ss2pqWdMyKB8y
	 4SZqPdJQcLgL/5uuejezacbh9/xKO5Y1Y/HMC1aQMZLU2tzu3NxzoyN6pgdD5YicEK
	 rjnPyoB0uWaKadxR74mq3RL7Y2sAUKGvDBFGjX+gPAlojiRaZ/adzOewwSExbiKFwz
	 V8nXUCUWu5z3g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqhl3PCYz4xdw;
	Sun, 17 Nov 2024 23:25:11 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, vaibhav@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241108094839.33084-1-gautam@linux.ibm.com>
References: <20241108094839.33084-1-gautam@linux.ibm.com>
Subject: Re: [PATCH v2] arch/powerpc/pseries: Fix KVM guest detection for disabling hardlockup detector
Message-Id: <173184539747.890800.11538594220662178668.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 08 Nov 2024 15:18:37 +0530, Gautam Menghani wrote:
> As per the kernel documentation[1], hardlockup detector should be
> disabled in KVM guests as it may give false positives. On PPC, hardlockup
> detector is enabled inside KVM guests because disable_hardlockup_detector()
> is marked as early_initcall and it relies on kvm_guest static key
> (is_kvm_guest()) which is initialized later during boot by
> check_kvm_guest(), which is a core_initcall. check_kvm_guest() is also
> called in pSeries_smp_probe(), which is called before initcalls, but it is
> skipped if KVM guest does not have doorbell support or if the guest is
> launched with SMT=1.
> 
> [...]

Applied to powerpc/next.

[1/1] arch/powerpc/pseries: Fix KVM guest detection for disabling hardlockup detector
      https://git.kernel.org/powerpc/c/44e5d21e6d3fd2a1fed7f0327cf72e99397e2eaf

cheers


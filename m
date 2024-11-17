Return-Path: <linux-kernel+bounces-412086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828299D03C1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B395B26882
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC31A9B2E;
	Sun, 17 Nov 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="m6AEAp4/"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBEA19B5B1
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846333; cv=none; b=GfBmOylWVc9I12M+OUXSFejaDtfw5SPpR0fZTxSm7oI8yoUrtNaVnKcTmITgaWu2PqrduOyO7d2xFYc6C+Tt6cD8ltPkt2NyJV+JTlvPTI+R1+nyYRt+UaCzzA2n0qwKnvqJbFx4twWXq2XVC/pk850zWwkwrxJ9rkO9oPqdzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846333; c=relaxed/simple;
	bh=Ghcdejmzfy5TcOI89G5dO9YF+92TO+yEx00TkWjo3OQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rO+n251VpwjZJUn/xgFoz/xTOJaAq28hYBHFc2Cmfu7or9lIGz9NkZL6N/+t0zTBxXciC0YR+TDYHSZkYYKKcaQjBiE9BBPGs5SwnpQwXPF9C6ATVlQUaEDAUMR4t5cUAiBym21zP/NipA2445Hh1VunnOocaebRcVxRocQeg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=m6AEAp4/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846327;
	bh=s1pfaH78Q4Z5nTxYQuW66jgoyL6wLcHOJH/KOWNhcEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m6AEAp4/cGF+UAYnFVvSmfXDnNlhkYWEh+RyaC89VBTaRl/4Co/F2iFC8QcEkCmF0
	 JjaX/Jh6NhqQArpyjbEs8gp3vdjmMaVNlJmsGGVW1B/mktIssBNx6NHVdNYfcWbKMM
	 RtWEMJZIgw/CMAC7Ziuog0jODSqFoTmsSYUbWjGWbUQ6B4Mv3Z/A5Jmx8v9/oR+hqT
	 a0AfSFCjPGQUbLLFnp1/z9NKTCeDxMcNYfdevnW078kQPA4bwNNGTX4sb4J8X2NMei
	 MtVbgqFA43yPRGHk010xk5T6l+bMfCp6TUKJGNdrNAqjlM8qw1Ju+s/NC3U7ktoUYv
	 qnlGhrHH8WZYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj33JF2z4xf0;
	Sun, 17 Nov 2024 23:25:27 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, peterx@redhat.com, groug@kaod.org, sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241024191232.1570894-2-mchauras@linux.ibm.com>
References: <20241024191232.1570894-2-mchauras@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/xmon: symbol lookup length fixed
Message-Id: <173184539762.890800.10077987479160659193.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 00:42:33 +0530, Mukesh Kumar Chaurasiya wrote:
> Currently this cannot lookup symbol beyond 64 characters in some cases
> like "ls", "lp" and "t"
> 
> Fix this by using KSYM_NAME_LEN instead of fixed 64 characters
> 
> 

Applied to powerpc/next.

[1/1] powerpc/xmon: symbol lookup length fixed
      https://git.kernel.org/powerpc/c/b196db2f536645eda7684655f3fae913e33fda4b

cheers


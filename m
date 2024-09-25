Return-Path: <linux-kernel+bounces-338180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A266985467
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB3A284527
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CF615574D;
	Wed, 25 Sep 2024 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SpwumqId"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506C768E7
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250353; cv=none; b=SAZou0v+5aofBseq3qV9LLwQYelaWNtUZjRtRRZVWQhjr0SahR2yHz89rCrXuM7Ye9Iz7NY50YrMaj4b1n98yFSM8/szj2fQ56rBXnIN9cYomw+CkrhotT1TTmAmP1sgdPhrBWpRsxpzYT3W/Np4bTd1uUmCZv78h4yAyRYAqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250353; c=relaxed/simple;
	bh=J0RAPoigd5KKC1Ko2ieOXttsGU7tV57h1rdcOVFh1cg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eh+FL5Ncnfa/ChTgRB3EUYVlp40hI58pyGF9aO7gz9C3uTzis6bUPW3AOKAxY7ZHBxzK1pQUjj++chCk48xM1y0UBJgy6+hGOadoZCrN9hBCNMrTcucgQSRvd729gO5Kk8xV9IXtvyD01k0VgI8XaDSYgG/JT/doZRrP1yGsbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SpwumqId; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D6BBB40E0163;
	Wed, 25 Sep 2024 07:45:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 14nJ_dZ7xQnH; Wed, 25 Sep 2024 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1727250334; bh=So/JrPspzdG0bTIuMidCmGx4AINjGsMTR+Dkzw71Gmo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SpwumqId4H+Ti9bYaShKwqoxv27CiWy3JXbXGcF/m0vOtSa7Ld1WEu2uBAlbw8yJG
	 +4RE5RtUUV4PJ0svoY1tbeQrMAUFOUHZxR86Gj/gNRK6+OqW08whmbLNSf/xkHxJXr
	 FW67EHa0rskMl/lida/QF3CXhM/bEdLvSMKITbPlTIPe6wnDhBckf8GyHRwUnWpiks
	 bgOMQVwE6ebjXYm/nC4AanqjfbeEa4nawfmaiHyfANpakc6P0dp3wfL4w6urbYyG+M
	 fGdDxM3/2/eETq0gjEiybVaz3yh8Xu7LpZU4Jabi1S2ZtPKjkexuaj2JUzJLObF7yb
	 9b+bquMogIvx5jmWSlLI+b1+66qzjROCGGGwPFVcOIvHq6+bXq6S3PACJmlINh4rw5
	 /9bKrLkMWiW3dcrAzhS8yVqxTvXFskOJzKratIYJzhV3SuJLkBskCEv8w9Yga5OEQ8
	 9GA01mtQQGH6q8dPvexwNx6DyNBQlNO5hiP/4AgFySzi/QBVTcjwp8EMkPscHiB0dl
	 CpbK5TvpgKbu967Fb5pr38aMaSb/0jms3EOeATmSWTVmenyb2i6uam5x9s5oO6C877
	 Pa0rGBDzmQZZXHIcuQOD/y6PoFpKQYvj16EYZVkYmSJwv6u3ElB4rA2/ARdq2HBHhB
	 xdHLbqS9u5AeCLPePBrf3Ou4=
Received: from [127.0.0.1] (dynamic-176-003-146-179.176.3.pool.telefonica.de [176.3.146.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55E1B40E015F;
	Wed, 25 Sep 2024 07:45:26 +0000 (UTC)
Date: Wed, 25 Sep 2024 08:45:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] x86,cpu: add X86_FEATURE_INVLPGB flag
User-Agent: K-9 Mail for Android
In-Reply-To: <20240924180013.388c1699@imladris.surriel.com>
References: <20240924180013.388c1699@imladris.surriel.com>
Message-ID: <24A7815F-E21F-45D3-9784-109B5932B41C@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 24, 2024 11:00:13 PM GMT+01:00, Rik van Riel <riel@surriel=2Ec=
om> wrote:
>Add the definition for the X86_FEATURE_INVLPGB CPUID flag=2E
>
>Tested by booting a kernel with this change on an AMD Milan system,
>and making sure the "invlpgb" flag shows up in /proc/cpuinfo

Why?

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 


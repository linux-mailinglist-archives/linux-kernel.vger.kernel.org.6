Return-Path: <linux-kernel+bounces-387265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4E9B4EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6330F289736
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3CF1925A6;
	Tue, 29 Oct 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UEOrwIur"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673B187FFA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217622; cv=none; b=mbQqAmOD57AEhhnx2+YdR2sdvqMMKPbGE43eaHh9pw2450h2Y3tjrSbEzR7ne/Tr9FGLZM2p382wjq9OOagdTjH8QcDODbS9Z4SBXyxy6BMx4CF1cvedUgXs3X+RqYX0WE4SV3I4XivLO48rTy+Mgu7iL2j+FzBNJzU2+vApzHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217622; c=relaxed/simple;
	bh=ccJ96qGwL823lUKZpCRbplNexfWDq+omJIkZ9xT0x1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmte9j/9kTYA5KDlf5SDiiIyuiI95nCL3tNaeFGBEmqmP7XSwiyvnwx/73782EA6BuIPnZ5be6QojcVZIkysXKl1hLMTKzFJ0qx2PtsJxnWigo2qzmrbdaVmB2UF4sdQqS8N+DJX8xDDWGCbJDd10j/9jjZnwsLDqiAAhBdyXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UEOrwIur reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6FEDD40E026B;
	Tue, 29 Oct 2024 16:00:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A33vOxF_4v28; Tue, 29 Oct 2024 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730217613; bh=Ne64uWydC2q7JUQNAPuzhl3N6dUZmzJ5xWQBvky0f7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEOrwIur1NNvE44wciIrUpTYTZonFJkgU8+qaoLIQKQON+iduv4IWDv1PxXzMG0Jh
	 LLfu2efMwwKDmjPJR8i/a29OU0UV3SgVZSw/JCzFt9jfDSL1qUW52BJquRpNqK6bMV
	 2y+c3afXzIubzl8w4r7JVCMW5bT4VBPTeof6xCuBwaMrzgBnSsLxzb11lIm072UQnK
	 WVeFEPrwKmJZYIZ4siOYs1WBHz7OZMRkVaG++GshvThIcJ++lFtIIMCoB+W05BvDXS
	 FGQKrT8EZuP8dJP4H8LPoauO8MtPYawa7b664xqJ12GL9Kpk6InQ64pJrwq7pNOF7a
	 n46w9wpOCCTObdCfOtgSP+P3p9pIo7xXW65AkXuiZU616oOm4Rw8z1Z+HPt+HO7tMA
	 6Ktoa2W/ptK30t1w6FhQ+LEiA8s7jAfPZiMy00yCid8XN0TLb3gJYoaeGNclYKtrZt
	 ZH4WlPI35jLXiZKyhbKYfmez9q9Z/cUMzT+YFWDUKWzUNIrr7VA5yQV2Ekxacj76H/
	 1kIlBnlSUKvH3wixcSnwNsHS+p2dtoMSVM8wjePdH/tqPFT4atOCvAxBwEEBVhhr3w
	 4uEAHoiDHqYHPGI0X+AX+4/wQSXZ3w6tFpRmBPiSLENHGVb8hp9nqQIAVHHouQ6OA1
	 UumuioKsCNk05oOpTzQrBG9A=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF31940E0192;
	Tue, 29 Oct 2024 15:59:58 +0000 (UTC)
Date: Tue, 29 Oct 2024 16:59:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Suma Hegde <suma.hegde@amd.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without
 CONFiG_AMD_NB
Message-ID: <20241029155957.GOZyEGfYi6a-hbOgiX@fat_crate.local>
References: <20241029092329.3857004-1-arnd@kernel.org>
 <a6f9a5aa-3208-7d03-93a0-768fd0805fdc@linux.intel.com>
 <20241029151149.GMZyD7NakGOHgkEw4f@fat_crate.local>
 <d93061b0-8cdf-a427-dc93-707af6282886@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d93061b0-8cdf-a427-dc93-707af6282886@linux.intel.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 05:19:30PM +0200, Ilpo J=C3=A4rvinen wrote:
> It's the COMPILE_TEST that got enabled in 7d3135d16356, before that hsm=
p=20
> depended on AMD_NB so the condition could never trigger.

This COMPILE_TEST thing is only causing more trouble than it is solving..=
. :-\

Lemme fixup Arnd's commit message and queue it.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


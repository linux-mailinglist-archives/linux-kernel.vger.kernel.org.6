Return-Path: <linux-kernel+bounces-361512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F4D99A91C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A25D283E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2D08002A;
	Fri, 11 Oct 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GJUwTGDV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF318027;
	Fri, 11 Oct 2024 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665333; cv=none; b=t2DEJjoaAuXybHMpGLhuToMkxcfDh7EQm5EvstxCcpOV3WqsNn7xEVsviLx1Y6lva4zTeKcmegzXZ0HufHLKToNr12QiaHUfw3HxZwNPe/d8ZKSrDtp7wtcr+gunCVZVsOQ8w2DwalDhZGJvUrrrIBsjQSmPbvpQ/LyLwMh9WnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665333; c=relaxed/simple;
	bh=6q+1SK1xIUmK84fXEESD8ijqvjK/EpQkRalBPiLG0nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaDMgQ2VaE5jkE2Yuy6EfwPL99YN+BUqnv+85LiOe58kcxPgB2jn0WZmk5jGON+wd+yepKFVqfAlKve7wGkVXKwjLoI8SxcNMLHXzbTAjMr3ZVLiOxrpO2B5CVo5cwMcM+/aOCWhdqn0nI49m6C9JcMVvengABpX3WsEkFiZRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GJUwTGDV reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 170CD40E0163;
	Fri, 11 Oct 2024 16:48:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E04BrBy-BaBI; Fri, 11 Oct 2024 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728665325; bh=qRnUcuc6nCxtZwaXGHTGhPN7orQLIvjw2b9ZSLeZhaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJUwTGDVGptr0K5JCt5T7WoZjBvfOdXCZgeX5yOzZcweGf9EavIMnVM3meG00N3fG
	 MwOrksSlw63ucwNZ8kyGIliJAN1JjrQCu8rU55FPTXLRvY/lbCITu6oZtFjxeOSWwc
	 itnWb7KVyVCN2AKVW3f9OvftsgWjMJ/wGho/NmoHte8HHyXBiAsA2Hpxmr0FP5t0ic
	 c42vlyMGGnenE10QUXbj/+JFb813Cta4EQXh5QUnPOOTb0LuC/TmnBJuGnG5Wt3OE1
	 rmmtYBJqJW0SAEmYA7AmnwMSD4fcsvPM+LvZaqtfmlVAcQmODTGgIf8yfCb6/JFenp
	 /51fuZ8X5rx7MgEhauZL2BZV6A3+ETL+oAkinnAEVU+PNlbDyAgUnCW9I4SW4z02Bg
	 l3fQCQHRmyHZ4RAAaZw6q22XS6Za1aqOc92SGkAi2YTDIEUcl14Q+zN+0VKzydTTwz
	 zv8tRpZdFcRy94JlzJTBurg6xRM1YMAGQG9I17hQHk54xxf9swY9flguheoJ+csF6X
	 ADQYyyiBcBkrlNPdGbgd/NbtqbuGtG1Z1gcTYuuOagBYmMgM4MF+HL9uEIq53hHnm7
	 tL/lBKSQsceb0YZ1UjQ+g9qECAeJ5i6tPbcxuiMO6/QrnAHhFVNeCaNc8ZpM1GRX0K
	 n1+N3agvgFF3nmtRTHoKvbX0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B1FF40E0169;
	Fri, 11 Oct 2024 16:48:31 +0000 (UTC)
Date: Fri, 11 Oct 2024 18:48:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Pavan Kumar Paluri <papaluri@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-coco@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dhaval Giani <dhaval.giani@amd.com>
Subject: Re: [PATCH v6 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Message-ID: <20241011164825.GEZwlW2XggpAMsZ3P9@fat_crate.local>
References: <20241010121455.15795-1-papaluri@amd.com>
 <20241010121455.15795-2-papaluri@amd.com>
 <20241011162120.GDZwlQgKTFi22JZ5If@fat_crate.local>
 <f8a3a683-0cdd-d1bb-1904-521ce5a96dac@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8a3a683-0cdd-d1bb-1904-521ce5a96dac@amd.com>
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:35:40AM -0500, Tom Lendacky wrote:
> But the patch includes the new file, so how can that be?

Ah, wrong error, sorry.

This is his error:

arch/x86/virt/svm/cmdline.c:15:27: error: expected =E2=80=98=3D=E2=80=99,=
 =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=
=98__attribute__=E2=80=99 before =E2=80=98__read_mostly=E2=80=99
   15 | struct sev_config sev_cfg __read_mostly;
      |                           ^~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:229: arch/x86/virt/svm/cmdline.o] Er=
ror 1
make[4]: *** [scripts/Makefile.build:478: arch/x86/virt/svm] Error 2
make[3]: *** [scripts/Makefile.build:478: arch/x86/virt] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:478: arch/x86] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1936: .] Error 2
make: *** [Makefile:224: __sub-make] Error 2

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


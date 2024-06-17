Return-Path: <linux-kernel+bounces-218133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA290B9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E84E28B8B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0CB194A7C;
	Mon, 17 Jun 2024 18:25:17 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E1198E84
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648716; cv=none; b=XAx5fno2q69G38mRGHN/KS/SxLreE81xwbGXYbxV5v2CfVmBgbGuggtd632So2z6BWMoISAEH30vbEJov/zNLg0MSUZtHX1I6cs3p6RpWgcPGAwh0eCzHdL4bokGdSO8GLLofIqEaiH4b30Wzhk88WPeCaP382VVyeYe7hHRkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648716; c=relaxed/simple;
	bh=ZujwxhU0fzmG232AYTsvdM9y++5f47AvLo4FCkYzn9M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RjM3XX5i5Xd0Lt1rm0DtuYmBuGwXCK6VPx2k2X8+PGhESLaFRs037/TE7G2ktMLEIYUf9jyjbacS5Osud3M0mg9z+N4+Y0fsZcpzsHeTXqo8YS7GLMQ+WV5JXtGePgBrdvm6VlHps8tM4IhomCHMhNLZgFDIug6XyuOUTkpE4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id C8F01601A1;
	Mon, 17 Jun 2024 20:17:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n6JXneNXu9Ca; Mon, 17 Jun 2024 20:17:04 +0200 (CEST)
Received: from [192.168.178.20] (dh207-41-66.xnet.hr [88.207.41.66])
	by domac.alu.hr (Postfix) with ESMTPSA id 293E86018F;
	Mon, 17 Jun 2024 20:17:01 +0200 (CEST)
Message-ID: <fbcbe79b-5447-4ff7-af6b-a0398d944155@gmail.com>
Date: Mon, 17 Jun 2024 20:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: Re: [BUG linux-next] Hang in boot on Ubuntu 22.04 LTS
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
 Vineet Gupta <vgupta@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
References: <4b7cad0c-0c8d-4341-a822-6b249cd74565@gmail.com>
Content-Language: en-US
In-Reply-To: <4b7cad0c-0c8d-4341-a822-6b249cd74565@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/24 00:51, Mirsad Todorovac wrote:
> Hi, all,
> 
> Between next-20240503 and next-20240506 there was a problem that prevented booting in
> Ubuntu 22.04 LTS on an AMD Ryzen 9 box.
> 
> The symptom is stuck boot with blank screen and an underscore blinking. After CTRL+ALT+DEL,
> the kernel shuts down and reboots back into grub.
> 
> After next-20240503, the boot never succeeded on this configuration, but I am unable to
> see what went wrong.
> 
> Please find attached the config and lshw.txt.
> 
> I thought it would be
> 
> # good: [f25eae2c405cbe810f8c52d743ea2b507c3fc301] arch: Select fbdev helpers with CONFIG_VIDEO
> git bisect good f25eae2c405cbe810f8c52d743ea2b507c3fc301
> # bad: [2fd001cd36005846caa6456fff1008c6f5bae9d4] arch: Rename fbdev header and source files
> git bisect bad 2fd001cd36005846caa6456fff1008c6f5bae9d4
> # good: [f178e96de7f0868e1b4d6df687794961f30125f2] arch: Remove struct fb_info from video helpers
> git bisect good f178e96de7f0868e1b4d6df687794961f30125f2
> # first bad commit: [2fd001cd36005846caa6456fff1008c6f5bae9d4] arch: Rename fbdev header and source files
> 
> Best regards,
> Mirsad Todorovac

Hi all,

FYI: Now, after building 6.10.0-rc3-next-20240612, the issue with the hang in Ubuntu 22.04 LTS
appears to be fixed.

In case of the requirement, I could try to bisect to the exact commit which fixed the problem.

Hope this helps.

Best regards,
Mirsad Todorovac


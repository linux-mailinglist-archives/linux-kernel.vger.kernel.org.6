Return-Path: <linux-kernel+bounces-372860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351779A4E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDDD1F26B67
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A841E519;
	Sat, 19 Oct 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bBHQ7mUb"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97503623
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729346796; cv=none; b=qhdvvwiDpMuIW9EOhKlAmpknuFbXsyCv3K/jtk7Q2ju+nR7zA6zgKxgnjA6B5o9x6aZMIYKiRuirQ7D9gR0TrIvwpMpOOOxTorDOPPqfT0kR/inHev3NJNuttnq+1yvY4LNZPgIJKp/iFnSKzjtkbcSVXCmG++nKvISg93T27NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729346796; c=relaxed/simple;
	bh=6imqt4IQJxLQzadQdeDU/hCrGd5US8rq3827kAgLVFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVzNFAlFHLs5441EKdN1udQ7YsoNBaEXid92Uli6TixNBzSgMbfQSi2d0DBtTQr8cc+FeV2hy+XKOo+RK/Q2sTqm9O9XLF3Az7pGNA5LCwYBM+gwfyUCLK6i6ba8c7IvjNbbhcXNcT6mchQLMcqb6Ztf/0xzrLFp8EdKYTd/H3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bBHQ7mUb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f72c913aso3733245e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729346793; x=1729951593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crK6XhOBA8h6wC8r5cAJDekI1Q+rToCUbYBScBwus64=;
        b=bBHQ7mUbxvVBDS8Mf1nI4D+MGjhB9XpA9XDszatMKx4fHPQmYqqQcDL8rwm9SVJGPC
         axDRrTXerL72vCCbUOnjD8CEhQmZOH9y+h1TDAXRspQuM6Br/dKRC+1jjqw7zAirvzl0
         0YDIVVgg313sUS0HXjqa6bxh1ZWJshmZiqMcR1vyfnNZApKMymM7YDKnc+/hzsyeDnt5
         AOKrsYQ47ZvNpIhfzLbxDlDbCUs2ELuPPrz8apXDsmTC0F3FnbK3jXylrRS3FI/OVKG+
         D+UZTGIiz/mvuZ/g17oSLUagwhWlI3Xe3cHH3w6Q5CNrHJLqm3lydRVf1GWSnNDrdpLu
         69lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729346793; x=1729951593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crK6XhOBA8h6wC8r5cAJDekI1Q+rToCUbYBScBwus64=;
        b=ra4zxK5TAtxc/7ji6UZmwDRXGqeRgW9VUFwjdf865BnKDs9Ac3Q6ePcaQ2YyQbrhvl
         KSk52uhk4jcqt33WJhS09F6OickucQ+EFnaoeIgAgsFH5MTAPGhcjuJ9l4YJEWG9M2BQ
         6IIPIANje8TABgUTq6tIUVPrNrwty/Mqt+d29N7ehLN0hGqkNAwVlrod/BXu7P6J5k+v
         9xKsgx9PEW/cOuvvqASGOa1xoclNBRH3AKNQtrfiI0OUU9x6XL7xCTDuaqHNWUQpjIeR
         8WiStFIhxy45nvPQq0jrSGE9H802ceDm5eRSVvqEcInoZvwqADaTOkJzMtF6AOKnXnnm
         MTCw==
X-Gm-Message-State: AOJu0YxEfep3uUaj+6x3+j1Y1R7sqQK2p/ksQpJ4wjDlslmmL9mpgB/v
	/sukwYW39vxuXkJjs7dj+krBxYq7GB0sJ/Hx7b9LRKb7Knzusx3/x+2zaYCmKt/K79n3opMnvN6
	FK5qNvSAJxj+4ht6iKfE/zokVeXM=
X-Google-Smtp-Source: AGHT+IEvBpZBfcCj54n1MnDJUbBe+DaRvFsBk2EAhL5yQrHN4Y5KlIpdbDjf3TJU0dumntmBLip2Y+Q5cHklUB025rg=
X-Received: by 2002:a05:6512:e9b:b0:539:f807:ada1 with SMTP id
 2adb3069b0e04-53a154a28eamr3519658e87.58.1729346792235; Sat, 19 Oct 2024
 07:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>
 <20241019094900.GBZxOAjKWsvPpHJQ0w@fat_crate.local>
In-Reply-To: <20241019094900.GBZxOAjKWsvPpHJQ0w@fat_crate.local>
From: Oerg866 <oerg866@googlemail.com>
Date: Sat, 19 Oct 2024 16:06:22 +0200
Message-ID: <CANpbe9U1OvXJWGEYAcmxZeNe=aU32vQ6upc212DnsMjvzB-8cA@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode: Fix crashes on early 486 CPUs due to usage
 of 'cpuid'.
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

apologies, I had forgotten to switch to plain text in my previous reply.

This is my first kernel patch submission, please bear with me :-)

> Are you running some weird guest or is it real hardware?

Host in this case means the CPU the kernel is running on, so real hardware.

As far as I'm aware, common emulators used for kernel testing, such as
QEMU, do not exhibit this problem.

There are however emulators that can somewhat precisely emulate the
affected CPUs, such as 86Box, that can reproduce this behaviour.

> Any chance you can share details so that I can try to reproduce here in a VM?

I have prepared a small archive to help with near effortless reproduction:

wget https://kext.de/dl/486patchtest.tar.gz
tar -zxvf 486patchtest.tar.gz

- Use the included .config file to compile a minimal kernel for 486DX,
  in this example the kernel has been cloned to ./linux (I used tag v6.11):

cp .config linux/.config
pushd linux
make -j16
popd

- Then, proceed with emulation:

wget https://github.com/86Box/86Box/releases/download/v4.2.1/86Box-Linux-x86_64-b6130.AppImage
chmod +x ./86Box-Linux-x86_64-b6130.AppImage
git clone https://github.com/86Box/roms
./86Box-Linux-x86_64-b6130.AppImage --config 86box.cfg

- Click the little CD-ROM Icon on the bottom left
- select "Folder"
- select linux/arch/x86/boot

The machine will then boot into FreeDOS, load the kernel via LOADLIN
and you should see a kernel panic.

The patch is included in the archive (486.patch) for convenience.
After applying it, the kernel will boot all the way to init (which
expectedly fails, as it is missing in this case).

I hope this information is of use to you!

Best regards
Eric Voirin


Return-Path: <linux-kernel+bounces-180398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1068C6DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4471C21F48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191BB15B559;
	Wed, 15 May 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CPWJlKnv"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CC1591EC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809457; cv=none; b=GOOujOu1XyqdGcjM2AdOoo1Gz+GnfStmWrTzHLrYES5LqnSROBNmYgPIvyPPj1SYlOFRjE+4WDPTJtPFkUAW/Goc27vqVDvXMf4koWt/CnXtPGfnQMNnma/Sb18XPMoBuQgj3croTytaO7tWqXXrcxrQNbBO5NmqxYhjRBlNWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809457; c=relaxed/simple;
	bh=ApuZNMJslBQLqy7HHjl6yRMqhIQCdRkH2uclIOB/2f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OknnGqz2g8mvOlYPpfz5wNlv5d7XwfOyb++ZVxQ33UBgOaonBhSwI/PKEknEAwpjdv1g7330Am5eaaTSXiovEBJ2esnIIM/C/oJ2CsfXF87Sd+oKfCoF00A/566ztPJ4AsD+orxavMhi0OXekGGfgf6Nf2g+huCsJSW66M7P+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CPWJlKnv; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-481f046f077so1373499137.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715809453; x=1716414253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LhmIS1ZUKIMCKnNa20yLc90W6YIAkEHSgeorRThhcY=;
        b=CPWJlKnv4hEUzsibh2z3eYSklUuazrA7HT/mMDX//byKQpVsmJ3ca/2etSMEP5m4xJ
         D3R7IcOkdO3GDUSi/OpLs1mHpckh92WvRLHg9QKQbV/ifJzOM5FgqN98q037PEw9fsBI
         KgcM7zEvCSakt6Hav4xl6kiytdOs8DrcrVaII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809453; x=1716414253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LhmIS1ZUKIMCKnNa20yLc90W6YIAkEHSgeorRThhcY=;
        b=wUJHcDqh+6xQkkuFLwXmyvt5LFRYlG9tseGxhaZRuAXEUCYhzrWYKPaKbUSfodaN3j
         6qwuY//zcpssnuudF5/ANr7V1lDa0pfn11OTUMr/MfQ2aliYDSmhbcnCVbAN2Cw3oBkr
         yr92KJJs+VND2b5w8+6VHih8sJwjwEEOeIJmEVBypUgf5YpY1wu/Y9KirfWEWp9lANr6
         MjjZeRCPKZbozDTnT05T+8CgNKUcD3XKLuFE9IFoIUwhabWb/qRJMPY7VsKUy/Bhx58T
         Ep04YINV0I9BGAjZdYvYHRCwROfHMIg67nka+4qcabHRgnhA5ffvZuEqbyytni6ovSJu
         Ar6g==
X-Forwarded-Encrypted: i=1; AJvYcCU3K1OMjGTmZT76wSKC8ZsxP22UhmdWlxmRrYVmYoxEC6okkZv/zWZI8OusS8Ar1r0nJdx0EKl2wS8zwp3e/Bwokd8sV9mpGwj2U0MR
X-Gm-Message-State: AOJu0Yyx8QHoi8fnl+8BxkZJZWYnVY8+vGVG/QklBMhlPKADPhxaI4n9
	eDQ3ZJMiWA56NYiPfzdDCEvRo3BG1wbaESeHWbLRbiRW8TpPmU6Zdba3xeSiXi7RG8iOYSKA1rM
	tqK0P7z0U5nK17OyBjbKuKghQzm/TadwfjmzK
X-Google-Smtp-Source: AGHT+IGH16ZmySUrlqY8aaHs9apVSVlN1Qm8fPJYMVvOFAgI7l+LReVhDSnkNZV7XZ+ktVhsQMcI+Rmk16oMO2qRKfA=
X-Received: by 2002:a05:6102:dcf:b0:47c:5dad:a01f with SMTP id
 ada2fe7eead31-48077dff8b5mr18693854137.10.1715809453364; Wed, 15 May 2024
 14:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de> <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de> <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com> <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de> <ZkUgX_bslFMbL5c-@wunner.de>
In-Reply-To: <ZkUgX_bslFMbL5c-@wunner.de>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 15 May 2024 17:44:02 -0400
Message-ID: <CA+Y6NJGemB2Jue6hK766571AxxFSZKissRFt4C9y994xRQ2_MQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hm, why would I have to distinguish between the two?
>
> I distinguish between Thunderbolt PCIe Adapters on the root switch
> and ones on non-root switches.  The latter are attached Device Routers,
> the former is the Host Router.  I just set the ones on the former to
> external_facing, fixed and trusted.  Everything downstream is untrusted
> and removable.

Thanks for the explanation. I'll try adding the kernel config and
command line parameters you mentioned, and share any additional debug
info I find.
What I did previously was use a pr_info line inside the tb_pci_fixup
function. That's how I knew that the function wasn't visited.

I am testing on ChromeOS on a non-ChromeBook so there might be some
additional security settings that prevent the Thunderbolt driver from
being loaded. I remember running into them when I first tried to debug
this.
That may be what is preventing your patch from working as intended on
my device. I will have to look into what could be causing that.

On Wed, May 15, 2024 at 4:51=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> Hm, re-reading your e-mail I'm irritated that you're referring to
> "that patch" (singular).  You need at least these five commits:
>
>   thunderbolt: Move struct tb_cm to tb.h
>   thunderbolt: Obtain PCIe Device/Function number from DROM
>   thunderbolt: Obtain PCIe Device/Function number via Router Operation
>   thunderbolt: Associate PCI devices with PCIe Adapters
>   thunderbolt: Mark PCIe Adapters on root switch as non-removable
>
> on this branch:
>
>   https://github.com/l1k/linux/commits/thunderbolt_associate_v1

I should have specified "patch series" instead of patch. I did include
all of your patches, and I used that branch you linked earlier!
git log --pretty=3Dshort --oneline
2e83bc05d285 (HEAD -> integration) thunderbolt: Do not bind to Host
Interface exposed by Device Router
01782fd462f2 thunderbolt: Mark PCIe Adapters on Root Switch as non-removabl=
e
814d0a7b0da8 thunderbolt: Associate PCI devices with PCIe Adapters
06b2f200532f thunderbolt: Obtain PCIe Device/Function number via
Router Operation
03d532c8a59f thunderbolt: Obtain PCIe Device/Function number from DROM
d710d8b828c5 thunderbolt: Move struct tb_cm to tb.h

I very much appreciate your help with this! I am happy to dig deeper
to figure out what is going on, I just wanted to share where I was so
that I could get additional support, and be guided in the right
direction. Thank you!


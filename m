Return-Path: <linux-kernel+bounces-177821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E298C44FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D60280FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6E155349;
	Mon, 13 May 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUfiKUER"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4323CB
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617320; cv=none; b=THz0ReFhB21tDqIpXX70FouZ4+WQeAicvufa0QJ32fn4szN515nzFlQZEh4sDjtJt3dV0b8JMcBgOTO/P8wIss3ic1p+mBsgpGeaofSJDGuFob7Xtvo75pSCJaseQvvZC0nd4in0LdMOm9ML8bYtRkEMKdo+ld0XS9puEDxR5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617320; c=relaxed/simple;
	bh=L9lWyO8B48jFnwfohs/Hc0y5GdapgO297Chc8yYX3go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSjInxtSBmsmn+DMemKRDgJb3voouZQQ5lGU6rP2DCxB/nXeMArRB0ZRLQCJTmIokDbpyiHaVxDfftPPLhaI328WKj3VpmzHh+iA6id6QFvIxGNHoo2KzdfXFWcLOh4CXQIdX156c3UEF7oLb4M2fqqipmA9fwslD5P9DMq4oEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUfiKUER; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f174e316eso5449911e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715617317; x=1716222117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/kym98WMSrjbPIHX8NWni0cnKfqOVf0cSKMKErv+0E=;
        b=LUfiKUERMtXLsM/hzUnWr+djFVXYch4EIvJWpHHsX0QctDuZSK6FmKMLzDskCA3Mif
         MAUCnlkQzMTQC7elE/PFCwqPRXdFOjcgSoH7UhdDi8QXPBQkNv0SOqKoieOxQ01SVwbP
         LFOwYIJp9Ile5ZGVfwO4ovlQGRLgbitr4pXaszgr7eGcDipc4gpRMtuo383t9OF8esRU
         aBDmmeo5YN2J7uwBxIqsV02WVCGYy/+ya9orwHLRsres7Hmf2MFN8zz/x2iu6153TCUs
         LFCYGUAQmh3df9O8C5I/g8j8Lfx2qmRnrsXqutcBazrgCUqfJEdHS5zGzy3GhPhUtoh5
         3Kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617317; x=1716222117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/kym98WMSrjbPIHX8NWni0cnKfqOVf0cSKMKErv+0E=;
        b=B7EUpPzMFTk1YaIWMmpPUIM14AkqO6OR1dJpXtDQ35vLBE6fIxA8mwVqTGMSdMxhcf
         M3Ye1+EQAd7kdR5gm2nBKfr1pN4XtuHnfg8PXZHFSDcXY83oODbpO44S/0MdyNLv8/8l
         +hzWcAyhejIcoS4B6OAYOSHaX+P48xW8p3lBB7jSLI1EiMQLk5ksJjREjZAkmqL0KCbg
         +sjxN8neQ4SebT8DsE57mqYYKCu/PeTBNRo+vp9cHNZNKoq5nvRqusTCwU7DuDoL/BWN
         nhlFXF8KtWBa04VBZkg4Fx7UJI/qPDyYzeB+g9kR+qjZOEFPKVxOC6UlmWot9lCvWV5E
         abKg==
X-Forwarded-Encrypted: i=1; AJvYcCWXcxhH409Nwda2E9/Uu2T5MSXODDcz68RFMoBuO7Nb0LfZ9r9CH5/vq591MZrdiWEfvxvO1l0QaALVwHqp52m6DlH7yzjw9WGuUgF4
X-Gm-Message-State: AOJu0YxMM+XybC122SKo+DCo41Px7JvPnrr/d4Ul7dXJS21GYLg684TL
	sCICXk8+MSB1RPumAC73m+bY0m9RjGbFLIiCPwum8EN2FnvhoWEELU989c0oW+HO0SoMtr3HHcm
	08qxa2b1dH+oVnQ4fibjaTLsLavo=
X-Google-Smtp-Source: AGHT+IGcwS8Pks6gzxlbLsjju7laLVvD2+f27UQGlta4edShlW0rkxYCYVD2J0JoLGnBF9UGzP9F0cVyTRXk0RAduNg=
X-Received: by 2002:ac2:5b84:0:b0:51f:4096:dbca with SMTP id
 2adb3069b0e04-5220ff72e46mr6673842e87.62.1715617317242; Mon, 13 May 2024
 09:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com> <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
 <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com> <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
 <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
In-Reply-To: <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Mon, 13 May 2024 17:21:45 +0100
Message-ID: <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org, 
	"OlteanV@gmail.com" <OlteanV@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 4:50=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
> Then dsa_loop_bdinfo is going to be built into your kernel image, and it
> will register a mdio_board_info structure which will create fixed PHY
> devices and it will assume that the DSA conduit network device name is
> "eth0". If this is not correct for your system, that needs changing.
>
> What are you trying to achieve? Can you be a tad more verbose about what
> you have tried and what is not working?

Sure, sorry I was being a bit terse.

In a 6.1.55 Linux kernel build, after a full make, if I touch a file
marked as "=3Dy" in the .config (e.g. net/devres.c) I see that the
compiler rebuilds the corresponding .o file, as expected:

user@machine:/opt/linux-imx$ touch net/devres.c
user@machine:/opt/linux-imx$ make
  CALL    scripts/checksyscalls.sh
  CC      net/devres.o
  AR      net/built-in.a
..

If I do the same for drivers/net/dsa/dsa_loop_bdinfo.c nothing is rebuilt!

user@machine:/opt/linux-imx$ touch drivers/net/dsa/dsa_loop_bdinfo.c
user@machine:/opt/linux-imx$ make
  CALL    scripts/checksyscalls.sh
user@machine:/opt/linux-imx$

What I am trying to achieve is to use dsa_loop to connect a CPU
running Linux to an Ethernet switch via a "conduit" Ethernet link
(e.g. eth0) using the port-based Ethertype DSA (Marvell) frame tagging
protocol, so that the Linux kernel will present the userspace with
separate Ethernet links for each of the switch's user ports (e.g.
lan1, lan2, lan3).

As I understand it this is usually done via a fixed phy-less conduit
(e.g. xMII) and an MDIO link between the processor and the switch so
that the processor can configure and control the physical user ports.

I want to do some software development ahead of receiving the
hardware, so I want to "fake" the MDIO link, or in some other way
configure the kernel, such that it uses port-based EDSA frame tagging
over an ordinary (PHY-equipped) Ethernet port and it looks to me like
dsa_loop should be capable of doing this.


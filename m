Return-Path: <linux-kernel+bounces-410432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9679CDB89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B7C1F22506
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE32618FC67;
	Fri, 15 Nov 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="2bjwkN9u"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC418785D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662916; cv=none; b=pa9nqi29EILrDaj6Cv1ZkjI0tzVMvboPuHtGEHJ3Nw8WiweJ5ptbfpp51wUaSSFarngy02xHwDOEuPSK42rNIY16HnLB8trfSzJcEZ5fAv9XHQSM48kKd+Wc81HV2mEokKf0ULZZU133lwqIkXNejDTBVTZE6lwUAtQqcQsuCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662916; c=relaxed/simple;
	bh=1saefCUChvEhGZXcAc9PO3UWP9KsoqvaJTxye4PNbnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tt+IzBikArnG6UPNe+BLSdULmsLgdrMPu8gHG7DEcMyW52oQAHpS9dLk2ppS0LMqUKQ7HRXx4b5O5REskcRNlDZgeVWKSLo2OJxswUkpneLz4AuqoTm6yNhitgcsDxgqgKw0sQUeXbHvnxSxl1T2vNofuOJya4Otf2ofhkUQLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=2bjwkN9u; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ee55cfa88cso5234817b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1731662911; x=1732267711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw7NeD1/kSkLl42Ng22aPPWvXyQP8eKPKhV8K/hAOx0=;
        b=2bjwkN9uPFNzYTwDVkwCWykg/GNLaUPM/rj2EaX1o87IGURojL6CZrKbSAKyuS8Z+I
         BhpMK3+C0UCJOpRYHCBHBLr9bilFbfxgzoXBtISbe7NpxtWqpQnAFMf5YaaN4kPeh+FA
         H14okcHqE454lgWlUN3opeKhcI2LWM0FhrB2rK5sNyUNjKK5tVO0KZ+ap+S0CuI1dL/P
         RckJV0GNkZHdiqxnN3QZNk1IL2CgDeEZObvfgJSHKRqYo3+4FAPzIT67rdYMvk9sYUIt
         HSaPv05H9aBf9WWLDJUCY5QWX8YGmZdmkM5oi4wG448hGQbMWZ48sdzP2IYDJTYJNild
         TpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662911; x=1732267711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw7NeD1/kSkLl42Ng22aPPWvXyQP8eKPKhV8K/hAOx0=;
        b=QyOxkihqN8L6ViDj7m40XOLAzm44mr0CDbcxCtofbIB7SuNNhYlDWKk1AySuw/E12m
         9In/Tu+MJYfvUoo2LdiTzinCMI5kZv52OTO8LYBQzSJ91+M7edJ/4TaD/XqNnlAWLG/a
         ehYfupqpg1TfOf6iHkaKbvK/+Qd6zh13oGRVvO6OFM9cVscMuE5FK19wzZ8RYkKggn88
         ZdlEnbuRuU6iFgqGQ4SYpi0g0rn+qKpzD0JS2sMer7oXS50S5ykFlg/0ZXZSkOjQRmF2
         SwTODjtuD/jE0H1e6AntnVzkZI7v+x/peSFRRzY+c9298fJmo4PlWFNOEiIwazPZF3NM
         OItg==
X-Gm-Message-State: AOJu0YxNiIdPnMws6c9USqdNL2tLG8B5zHHS2KF3NhMlMDGmjrhN1aZP
	1UNKBqVDHwx/sm5kGzEw3k5mH9xPAWtIMS3oGN9uuqZwLtqlaz6FNEKXoW+unx+loxvW/ktzn+z
	pipq3vfDUnCcXot8C0/633yuYSUBIIhZ37W9DzuJMX1S+kx0vJQ==
X-Google-Smtp-Source: AGHT+IHggNczWxL1cX0MfUC81Iuopw3yFOo11zb+X0CvuQwZIjjbkP8RtzFM/W+MbKw8506qt9/vpbynxciqz+5r0m8=
X-Received: by 2002:a05:690c:60c5:b0:6e2:1527:446b with SMTP id
 00721157ae682-6ee55bba6ecmr25603267b3.3.1731662911410; Fri, 15 Nov 2024
 01:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114224649.57946-4-thorsten.blum@linux.dev>
In-Reply-To: <20241114224649.57946-4-thorsten.blum@linux.dev>
From: Michal Simek <monstr@monstr.eu>
Date: Fri, 15 Nov 2024 10:28:20 +0100
Message-ID: <CAHTX3dKYrSqLk+1nODm+yMVFfEeW_WvfboiZ_A13DN4_iCeuag@mail.gmail.com>
Subject: Re: [PATCH] microblaze: mb: Use str_yes_no() helper in show_cpuinfo()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 14. 11. 2024 v 23:49 odes=C3=ADlatel Thorsten Blum
<thorsten.blum@linux.dev> napsal:
>
> Remove hard-coded strings by using the str_yes_no() helper function.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/microblaze/kernel/cpu/mb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/microblaze/kernel/cpu/mb.c b/arch/microblaze/kernel/cpu=
/mb.c
> index 9581d194d9e4..37cb2898216b 100644
> --- a/arch/microblaze/kernel/cpu/mb.c
> +++ b/arch/microblaze/kernel/cpu/mb.c
> @@ -66,10 +66,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>                    " MSR:\t\t%s\n"
>                    " PCMP:\t\t%s\n"
>                    " DIV:\t\t%s\n",
> -                  (cpuinfo.use_instr & PVR0_USE_BARREL_MASK) ? "yes" : "=
no",
> -                  (cpuinfo.use_instr & PVR2_USE_MSR_INSTR) ? "yes" : "no=
",
> -                  (cpuinfo.use_instr & PVR2_USE_PCMP_INSTR) ? "yes" : "n=
o",
> -                  (cpuinfo.use_instr & PVR0_USE_DIV_MASK) ? "yes" : "no"=
);
> +                  str_yes_no(cpuinfo.use_instr & PVR0_USE_BARREL_MASK),
> +                  str_yes_no(cpuinfo.use_instr & PVR2_USE_MSR_INSTR),
> +                  str_yes_no(cpuinfo.use_instr & PVR2_USE_PCMP_INSTR),
> +                  str_yes_no(cpuinfo.use_instr & PVR0_USE_DIV_MASK));
>
>         seq_printf(m, " MMU:\t\t%x\n", cpuinfo.mmu);
>
> @@ -120,7 +120,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>
>         seq_printf(m,
>                    "HW-Debug:\t%s\n",
> -                  cpuinfo.hw_debug ? "yes" : "no");
> +                  str_yes_no(cpuinfo.hw_debug));
>
>         seq_printf(m,
>                    "PVR-USR1:\t%02x\n"
> --
> 2.47.0
>

Applied.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


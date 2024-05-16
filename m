Return-Path: <linux-kernel+bounces-180837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69F28C73C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F851F23CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CEE14374D;
	Thu, 16 May 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ems0LfIf"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4B2576F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851684; cv=none; b=KUbH4NRwno1ZWeA/YM+94RgiG3exQXSoIGBTucm8CK6YsxGStN+UX14n8ga52TgPT14t1kRkIsJqseL7jtDCG+U+KCLVTDl1QtdNc/qL4lKq5iQIBlOZX8u8OgGzy16PrZbX5Zca3C4/OxiCZ8/BMGjeGVP/rTZyVrw3vgbcA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851684; c=relaxed/simple;
	bh=CD5pJH6BvK5fp8EhPCUsBKFQmAv0wh7P06/iCc0Eh1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bz/Js3u/kKDb6xzs/r1WvJApoVfBuTLWM1AyMjDZJrgjVrhmyO91czK6WzlqMGHnf5GqeGYM3YfFHDpInlEe734Y+kkXCSyE3k0ZBtT0C+1HnfnP5Y66w7PdIujcgDTODbPNByzF1LP/XD89mFM8t4o8orJWerCp0ixuXC/Ci68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ems0LfIf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f60817e34so667549e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715851681; x=1716456481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBQbQB4BJv6I8rVVrg3uUQxRil7xE13pAUI65M2O3CY=;
        b=Ems0LfIf88Cb5y4ZZYGCVp8tvyynbqorIsQ6toWud2j5uj3ljyyFzG8n1A2LoRqkXg
         KjroYP6zsltIVR0noeLW1gRfA4n5/gClM+8zWpToi2WSQne0EXrCy1E8Tur2pUsTCwkV
         p0XYw3aalHABilUHpkTDFwTtIAVovhSxdphEcgzH/crn6juqpgXRVYP3nYaHTytR7bBZ
         qxvNo7ZTvKwc6ItFebr+rD6RO4RdPjQTHlEGqk9j3ObQktoOu8zEKxQ7V2sU4eA/1m5r
         afulgYAU3DbfFXLiH9Ep3Glfu0eqq0le+Rq3bl2NqV3aez91ICPuDq34oB1ncwRTUqky
         VWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715851681; x=1716456481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBQbQB4BJv6I8rVVrg3uUQxRil7xE13pAUI65M2O3CY=;
        b=RASTgea/wWKbRcoOrseRwspzvcSdzl5KePfszeJZCQRLGiXG18+TN/ZxR3HtoWPmuH
         vWAW4U4nuLBw1P35y4xdH7ryJZeuIWrlRrZMIIoi2JxiqoOsr8kv6/kR0ZyG1zG16rCv
         uGCuBK5Icfaz7j6pIG/b0rqiwDjj3DmAoCDyo0q6mJQIIRFl+wqdOWTuPFqVyxIL7d/E
         8yfph6ANvH1cuntIJYDio8BcLQg+Mgi04jztWjSn1xfWdaK6jPGlKL6p/tKVerYTVBVI
         Qsppqz6G7EZngNOrsrXTs57kIS17nHKD899WsPvbrNH4GTPitBx/mIS8T3VkK5IWGGAQ
         O4rg==
X-Forwarded-Encrypted: i=1; AJvYcCUxdfbU1slfh3TB7y+24VXbTpcuKkyutmS1BJmEnRTRQekA0IpTMfIX/4oyBzorjZGV7ZmGQNtN+R3oeGnI9ohJzArphwSMcikOxIm2
X-Gm-Message-State: AOJu0YxHh2bazUK7O+FKs+pOiaRl1X6KWofnHPH2VRWF6Vxxxz5bEiXm
	5XQUblScwe6szoiXMG7wlgfg+cCaEhh7QZOL66lHNWA/cfW+jNTff4Klmp/QdG8TldNOEtg1zN4
	1PvP2mF8yKHNB/CCU574uYSj30uk=
X-Google-Smtp-Source: AGHT+IEE/V/zIX6jMESAZCo5U6n5vHqiBnuoPYW1nKfUSBtdhaT/7QROXyDduokumF2XPeJijWE9oN7xE/IJRhP5zO0=
X-Received: by 2002:a05:6512:3447:b0:51d:82a2:8d72 with SMTP id
 2adb3069b0e04-5220fc6d7fcmr10228789e87.40.1715851681124; Thu, 16 May 2024
 02:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
 <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch> <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
 <e307a237-68e3-40c9-be31-4fe3d560ada2@lunn.ch> <CAHx5RXCF0=Soz_k88RGvJFGrajaxn=mVnqpb99GAQ=b7XOcWiw@mail.gmail.com>
 <732d8bb2-1d4f-4958-b130-0bd15a407271@gmail.com> <CAHx5RXDaweFTF_Qt0GdBH4nBeMqwL4VVto7xzHBvFgFL5n=Ebg@mail.gmail.com>
 <c8c01e53-0a45-4319-88ff-bfb0caba150c@lunn.ch> <CAHx5RXDzN93WaYFe2bk6m2TmMC+A9vsmhodRFmZi17cFY5CrWQ@mail.gmail.com>
 <949fcbea-23dc-44c1-9146-c358b15b9253@lunn.ch> <CAHx5RXC44V-qsN9QiuhKrDdGZ4ppXpT_cQz3XNAa2aQnf7Pe5Q@mail.gmail.com>
 <cb0f929b-75aa-4ff6-98dc-217b34421e5a@gmail.com>
In-Reply-To: <cb0f929b-75aa-4ff6-98dc-217b34421e5a@gmail.com>
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Thu, 16 May 2024 10:27:49 +0100
Message-ID: <CAHx5RXCaiHav5fbUwYe40_7XJbNSrTDO90fUD8ZMAryUovH0gA@mail.gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, OlteanV@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 8:27=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
> What changes have you done to the dsa_loop.c file for this error to show
> up? Currently the driver does the following:
>
> static void dsa_loop_phylink_get_caps(struct dsa_switch *dsa, int port,
>                                          struct phylink_config *config)
>    {
>            bitmap_fill(config->supported_interfaces,
> PHY_INTERFACE_MODE_MAX);
>            __clear_bit(PHY_INTERFACE_MODE_NA, config->supported_interface=
s);
>            config->mac_capabilities =3D ~0;
>    }
>
> which is basically to say: I support everything, except
> PHY_INTERFACE_MDOE_NA.

I am currently on kernel version 6.1.55 which does not appear to have
this caps code in, and neither does 6.1.90.

The following commit to net/dsa/port.c, backported to the 6.1 tree,
appears to fix the issue
https://github.com/torvalds/linux/commit/9945c1fb03a3c9f7e0dcf9aa17041a70e5=
51387a

Steve.


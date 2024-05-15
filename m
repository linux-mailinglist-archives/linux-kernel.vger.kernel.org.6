Return-Path: <linux-kernel+bounces-179698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D938C639A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91501F239C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0D58AC3;
	Wed, 15 May 2024 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFu7xsDd"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16D57CA1
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764999; cv=none; b=sSUENbblNAW41c8uIyhScje5Skp3E5Tyj8fhoZbeVWtjlI6k0vtQFS/lCIY/+uHHHjVsYolCegI8mOJdhNNu9Zh0HVzPFiadLYXIUMj1LsH0kamdC+kymzRSlTlHDgHNwjfY8a0jf4xozWawkigUxCzTTDbJoV9a9rbXthWsafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764999; c=relaxed/simple;
	bh=65UxLBiLIguU6F61q4txlPxkZg4EJEO3OTuaMnF8Qec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtFnchxpapnsnxCne4Vup02tKqU0ifHfSat6GwiXCd0iaM/B29A8zNEOOvvXMrMojVGKHH4JvUre+CRZ6BbtYh3g0/MVvM3N04fKXghqYIMMapPJBZx0srZom4X3GxZ3u+G2V7sa1cZpJNlQ8nIJIIVDrZmGq6Y2Bg4R6qFge8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFu7xsDd; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e564cad1f1so60729191fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715764994; x=1716369794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BqZuPDM/p9ZLDXpdftwTIocAvrQ3aC8nBumJmkanCM=;
        b=LFu7xsDdPpyyP25qBlvIfrc/GUzX9uiPWi69J/RkBQbhkh6+Ap9hCW8MZmV9ujze+B
         n188CZlOppWN4MCFe8xOByLkquqo7+f+XcBt3WdchL6Mw6f8Oscee0qMxOBIUInht+6L
         D4XnkYM+GNGiDFoC2iztRMe0uCm3bFq31J5zm8TW/P3q8+Cl8D2NYsgPhMu5gyOM/F8z
         Av2FYvL0scVSnXETNAjedqmBBjVrPiaSlhWEoHTWtb9GkaK3Z7YEHOAIUWoNlysjxlxE
         vqsxr3COEqUem81U0Cupxzi0fb/jAU+AMr89yHd+jIugyRNxBID5K3WtJFg/h8+8hSu0
         zjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715764994; x=1716369794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BqZuPDM/p9ZLDXpdftwTIocAvrQ3aC8nBumJmkanCM=;
        b=iehYlwZKRq7rNclZyD/349Fl3FzId1kN3UxNkgoxBi9dVSlMtBuSR/D4B3h+7TTOgb
         fsfvnbXr055wHTQcEEoYTqbkCJKVVpAZASBy8o6Zgprcb+BZHavo/kvnTMsaT22CBABS
         YRSsy49jp9xM1NsyqAcz2wTlBYBsfvemdr0ujPaYijtV5FObiUgQjw9hUooW97CIYclY
         /IOY06qnWXOFEkGWnM9HqEjnPGPxH46WlrOCG2Fmw0ifoYLqZS5GK/rVmj9s4qRiuR9G
         hw6Tx91xTPLO8YEv1OAi9Tp8OootvpRGU69Zw/fBHrIMqyna/uqoL/IWXvshG2tifxnx
         jSEw==
X-Forwarded-Encrypted: i=1; AJvYcCXoZatI+/+Zr5h28XbFNu/Me6RpbF4EMUvfltPeBeGmi96AU3xERzwhbJpJ9ejyXludda6kZCRJRDFBakwUTp/pz8gloaH79rWRGOZL
X-Gm-Message-State: AOJu0YwtseOJIBLvkQODqBRU8FlDNUEfhiBU/P0/25UquptTZkxw8eBe
	HcFOOCqlkaSKSkiA837BehAOnUBf1P6R9tAa+fy+y+7vikU0umqEUEsN9EobNxk2Sbv2GpX2Y9d
	OpTDow848KqiT64vzM++/u+d6f24=
X-Google-Smtp-Source: AGHT+IE/mlQSOFZ99/fmFo4uCLq+nuJD5Fwjkh9UoDIshqF37ENY4lhx5pJRnJhdXjVfJTao2RDgMbe6hSMAYBdxZJ0=
X-Received: by 2002:a2e:d02:0:b0:2e6:f5a2:1ec8 with SMTP id
 38308e7fff4ca-2e6f5a21fe8mr8831551fa.51.1715764994115; Wed, 15 May 2024
 02:23:14 -0700 (PDT)
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
 <949fcbea-23dc-44c1-9146-c358b15b9253@lunn.ch>
In-Reply-To: <949fcbea-23dc-44c1-9146-c358b15b9253@lunn.ch>
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Wed, 15 May 2024 10:23:02 +0100
Message-ID: <CAHx5RXC44V-qsN9QiuhKrDdGZ4ppXpT_cQz3XNAa2aQnf7Pe5Q@mail.gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, OlteanV@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 5:17=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, May 14, 2024 at 05:08:24PM +0100, Stephen Langstaff wrote:
> > If I sorted out building the dsa_loop_bdinfo.c code as a built-in do
> > you think that would solve the ordering issue?
>
> Probably.

Well, some minor progress... when dsa_loop and dsa_loop_bdinfo are
built-in to the kernel then it appears that, at least for this
configuration, the driver probe function is called:

[    0.053068] dsa_loop_bdinfo_init
[    1.509255] dsa_loop_init
[    1.513178] dsa_loop_drv_probe
[    2.633673] dsa_loop_drv_probe
..
[    3.273496] dsa_loop_drv_probe
[    3.276589] dsa_loop_get_protocol
[    3.281608] dsa-loop fixed-0:1f: skipping link registration for CPU port=
 5
[    3.288558]  (null): phylink: error: empty supported_interfaces
[    3.294500] error creating PHYLINK: -22
[    3.298343] dsa-loop fixed-0:1f lan1 (uninitialized): error -22
setting up PHY for tree 0, switch 0, port 0
[    3.308145]  (null): phylink: error: empty supported_interfaces
[    3.314070] error creating PHYLINK: -22
[    3.317907] dsa-loop fixed-0:1f lan2 (uninitialized): error -22
setting up PHY for tree 0, switch 0, port 1
[    3.327677]  (null): phylink: error: empty supported_interfaces
[    3.333609] error creating PHYLINK: -22
[    3.337449] dsa-loop fixed-0:1f lan3 (uninitialized): error -22
setting up PHY for tree 0, switch 0, port 2
[    3.347223]  (null): phylink: error: empty supported_interfaces
[    3.353145] error creating PHYLINK: -22
[    3.356983] dsa-loop fixed-0:1f lan4 (uninitialized): error -22
setting up PHY for tree 0, switch 0, port 3
[    3.366855] device eth0 entered promiscuous mode
[    3.371497] DSA: tree 0 setup
[    3.374474] dsa-loop fixed-0:1f: DSA mockup driver: 0x1f

The -22 error appears to be related to the issues mentioned here:
https://www.spinics.net/lists/netdev/msg922961.html so I will now try
to apply the suggested short-term fix.


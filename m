Return-Path: <linux-kernel+bounces-416598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF689D4765
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD4C282E52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 06:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954121A76C4;
	Thu, 21 Nov 2024 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="CpJU8sRz"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AB13AA53
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168896; cv=none; b=n/VjMnLML3Gu7l4Rkd1LxYiQFDWlPWbm96X0ZUnb00CzRh4yKc21CoWtsB0HOcrMnYGVPM/UjTRJhDSOSpQDm56ij9OVmV4negOWMSkVlqtoqyAtiisEEGmYLqrFZ5TYHxPqkM00n7A0uG18Zb5rZ7ugk6GVuMdaxV5MKFF3ja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168896; c=relaxed/simple;
	bh=ayAF/Veqgd3KzXVypEg2pEzxccluRkLQTpGNhJAtHko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UENz1GObcA1k1Kmlt6xChb4K33MwjiIJQgOEEdTIaTGcXMmFjL6B6GZoDRdKRcfZDQKNBWaNH94z6EnfpNb3Dyez32meRNCtvyPc/hohvwOkRoJsNvwTOm28u2E028tclpLONIdpj7fAUFf+1kpt3XEPZ2hB8Pgau6TK3wn1POc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=CpJU8sRz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso2937455a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1732168892; x=1732773692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXBYO7IREaqcFC1AY+U6gH0DW+PukJ6oZRwSeQifutI=;
        b=CpJU8sRzY2EEa+z5YeRkrhaF3FQjLdDh7emQQT/LnPbqFAf8CPIiYAHlrripuJUR3B
         Gdcz/najSPZKLBTkEqYZFVTIP5RRXLA/4//XfEk/divhYiRVba0sPXLyHWW+slEYFStl
         0h4LI9au/JIv3UBWVzapthJrquo3+7jZQjC09QUPi7Tj5hR5OhzZv2tiCUzUIuwtHEpw
         0bzyOQmMPmYW++s0IgjIxzgJMwos/6Y2ba/i9FwWjj4dqzvOzYNmL+V/ZmqO9TJxB53I
         oRhc7HV7iXo26jWR1QeVR1qpQXTX4yb7Dm7otAsF4r8jyjPwaAq4+aX2K4miuLTlJFM1
         kuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732168893; x=1732773693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXBYO7IREaqcFC1AY+U6gH0DW+PukJ6oZRwSeQifutI=;
        b=us/6uKJTpttyiHosNR1eJkdTqteBsAx7S/4hz5pkUxlGRBmg1JbX1Hi0aEJ+yNK7tF
         5vw6jZm5bZcN+NtuKWgKLPqNWv0ayDiR+vK3mGXbzbCmLh7mYX7tPOWEb71wGFL3w7KK
         /7zk0M8tPCUIWf6KzM41ArcQepQerAPUzFmuuF0Wgu4yK/hGD2T4mgYu6mQlKmAaZ9I6
         Qme/CPl1fW5rTTlv/njTBrpxe/ZUJoTL0VazEoR/0oZfgYd6q3DsYhy2MdpgjJ0C/kPn
         oXtHq9gk7IFmrlt04YoQd25vJMzI0cJOJsAyoLI2ZPVKYaZ6hRwoGtQPyXvj4XyMko1M
         BpDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjUNVXyxQ+fmt2oSDZgo/hR1edcbOwlmSpuUFqT1km+3ohRI2WhbB43EYXVmL5g2bsWl5AhVjVHkKi1OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRM3XI5H5Asw7I37d/pUmSc4u8a+lA5Wt6R/3p2X09wrwlPjd
	E/2JJbSkl0qFqTgHMb4zr2TtHYHwZksgu6pXtbW7f2peZzUJilvVtMQeQ08JxY4qqyOp6j1xm7V
	OOb8R34AQvCUU4V8XCEqpikgO+wVWw6AZIS4=
X-Google-Smtp-Source: AGHT+IErmyO6Auj29nMzsQsciAeQieUSQ40mWvouilmqn2J8jN6CWiJnyXtOkmFurSkWnL1C/48LjVI6yqaWSkbNQBg=
X-Received: by 2002:a17:907:3d92:b0:a9e:85f8:2a6d with SMTP id
 a640c23a62f3a-aa4ef969eedmr214855766b.11.1732168892228; Wed, 20 Nov 2024
 22:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004061541.1666280-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <CABMQnVK_RUC84QQ5zb+ZpuMOZcFMNV6HzEYAfmX4bOrRm+rvTw@mail.gmail.com> <90978892-2086-4c70-9698-0957cc71abb8@lunn.ch>
In-Reply-To: <90978892-2086-4c70-9698-0957cc71abb8@lunn.ch>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 21 Nov 2024 15:01:06 +0900
Message-ID: <CABMQnVJES+VoqNYNgo3zxFkTJVYkR=ZCwWsEFEe=QhKyaYie9w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY ID
To: Andrew Lunn <andrew@lunn.ch>
Cc: dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for your review.

2024=E5=B9=B411=E6=9C=8818=E6=97=A5(=E6=9C=88) 5:06 Andrew Lunn <andrew@lun=
n.ch>:
>
> On Sun, Nov 17, 2024 at 05:53:51PM +0900, Nobuhiro Iwamatsu wrote:
> > Hi Dinh,
> >
> > Please check and apply this patch?
> >
> > Thanks,
> >   Nobuhiro
> >
> > 2024=E5=B9=B410=E6=9C=884=E6=97=A5(=E9=87=91) 15:16 Nobuhiro Iwamatsu <=
iwamatsu@nigauri.org>:
> > >
> > > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > >
> > > On SoCFPGA/Sodia board, mdio bus cannot be probed, so the PHY cannot =
be
> > > found and the network device does not work.
> > >
> > > ```
> > > stmmaceth ff702000.ethernet eth0: __stmmac_open: Cannot attach to PHY=
 (error: -19)
> > > ```
> > >
> > > To probe the mdio bus, add "snps,dwmac-mdio" as compatible string of =
the
> > > mdio bus. Also the PHY ID connected to this board is 4. Therefore, ch=
ange
> > > to 4.
>
> It is the address which is 4, not the ID.

Thanks, I will fix it.

>
>         Andrew

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6


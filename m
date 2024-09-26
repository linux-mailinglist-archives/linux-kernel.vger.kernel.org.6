Return-Path: <linux-kernel+bounces-340375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A85698724B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6CB1C2212A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA4D1AED4E;
	Thu, 26 Sep 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvOGZCCS"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1101AE86E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348599; cv=none; b=aL3uwVFwChle7ogDqcvWPAI8/l+NswWi3OFjeRK2DOJylB2qxosvDLn00/UbQdHCQU7F687KxG417zBJSXhgkfuvTcuoKEaMkTQGtzMuA9UMaDfo1il+bwGPjeM6CGarEccXljiUNCqGhGC/CapEXXJHAku6R3E37RigNToDDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348599; c=relaxed/simple;
	bh=bXcpT7QniCsY3WmCQMjDM6v5kutIfKh/CwTX1byPf8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWrZ5YmOkcPge6jFve0SCF7j4ZcQqiA5rR9iApB/c5diAKR0wIbkDpKrM9RymNM+/Aeu7gh7I4oTkd+MQf3FnLW1jke2Jp6gyI5IuSgjPSm6ip0tVy0aVV+uP8IF8nLDh2qebsxgO5ry2YFfKAxETNkIsUDhX8P+3G0wae2k3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvOGZCCS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365b6bd901so1000366e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727348596; x=1727953396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bXcpT7QniCsY3WmCQMjDM6v5kutIfKh/CwTX1byPf8I=;
        b=PvOGZCCSJoxC+FII3p/uYAKVh+muy0OnGvKftMeJKDSxUpkxLUmnA5bpGRCqMlhKmn
         RTVa5jCkj3ArgPOwYqZgK0IdYhbaSinHEv9kw/ycfyYX34tFxEu0FyasaDVKLgq+xiDb
         zAgAKy1ZLDgTji74PzvT9iCL54XWmGj/UpNEEzcp1A8VE3yge498xwJpvnjXw3i5JjcE
         I4Avo/j45zyep8f1GpvpAVBOy/xVWiPnIaif10qOs07P8C763Fb/ivDJskro0GzLuC+j
         iBpEZ5qCoyYAZtvE6x93RMalAYBcCHlYiGCxONCtDIlh6ZvH4I2q7elVDwxwL3fwiOFu
         gFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727348596; x=1727953396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXcpT7QniCsY3WmCQMjDM6v5kutIfKh/CwTX1byPf8I=;
        b=fNQMosRb2d82WE4ozVGo0fGUyBdaupK5QrCRyBqYyNlFP7FLYpyWNJyFJp/4T0HP+F
         KC0h4fNQHb+EZ8+jCEUygn2jOGPwFuzEuhLsT+Jde0uh3IAolkUGRQMryQuYn/wyRbVk
         BeJxCbFf3YsvKiVGzwph/IDoaoutb/G7qOtpeTq2a+qQN3n+iizCyVBA/HcKCxJ4YSm4
         ovKyJDRGaqvgYSU68/lxiQEdOTvGT7RpTVe0+OIoiRf5Df7U+6ae3ll6D6xRS1VbxME8
         eoY4gE+9XCQk/kuN1Gx77MSIbcWWSvFokWmjts+OlZ+nrLxN6ylKcSI3Oy/Fw8mGI77+
         1h6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUQcNu0rOIUHV/zIxY5CV7QVVif/baQT1EnHrET/M//OSpp+zTHM9PR0Cy63wxGe0dAj9vsZD9kfz0LEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Pa+dNtTtaoo4omMrEO/heI06HMuS0yCSoQ1tR+TewYdVJdfc
	oxFpVhAiEt6uDiA8gte6lng7vJvzbGNGVTAzZND4XruQH4bkoxOzOsVn/kY+D7J//ufBO7EVo8F
	J21kLHFIUcQRxpVjT4PNLaQ+aqw==
X-Google-Smtp-Source: AGHT+IEs5w6c2apFprxZ/aKHJmYlnZdJTzEmSfMV5EYSNk9OWdGaIAdSiJTPKJTFI9FYdw4cYr+wC88Yaq6+PnwZMpg=
X-Received: by 2002:a05:6512:3b0e:b0:535:6cca:9453 with SMTP id
 2adb3069b0e04-5387048ab7fmr3663974e87.12.1727348595720; Thu, 26 Sep 2024
 04:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925074903.1983601-1-erezgeva@nwtime.org> <877cayj2va.fsf@geanix.com>
In-Reply-To: <877cayj2va.fsf@geanix.com>
From: Erez <erezgeva2@gmail.com>
Date: Thu, 26 Sep 2024 13:02:38 +0200
Message-ID: <CANeKEMPfCk1R1pc8s9MwNniLJUKGr_g99U5EtNmJKsLLty-9Qw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mtd: spi-nor: macronix: reading SFDP by all Macronix chips
To: Esben Haabendal <esben@geanix.com>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 09:22, Esben Haabendal <esben@geanix.com> wrote:
>
> Erez Geva <erezgeva@nwtime.org> writes:
>
> > From: Erez Geva <ErezGeva2@gmail.com>
> >
> > Add reading SFDP to all Macronix chips.
> > All chips in the Macronix competabilites table
> > have a replacement chip that support SFDP.
> > Macronix stop producing any chip without SFDP 15 years ago.
> > The benefit of reading SFDP is by supporting
> > fater op-codes for newer chips.
> >
> > This patch do not add an all flashes support.
> > This patch extend the already support of SFDP to all Macronix chips.
> > The new chips that reuse JEDEC IDs and chips that
> > are absend from the Macronix competabilites table.
> > The patch just remove the restriction!
>
> Hi Erez
>
> Did you see the response I got to the last revision of my patch series
> that tries to resolve the same problem that you are adressing?
>
> https://lore.kernel.org/all/D2NGXHZ2VTK0.M0AOB4CM7MHM@kernel.org/

As for .
I agree that doing SFDP first is a better approach than mine.
If Tudor Ambarus. Pratyush Yadav. Michael Walle agrees on that.
Than let's do that

>
> I think we should try go go in that direction. It sounds like it would
> be a simple solution that would improve the overall situation, not just
> for Macronix.

Again I agree. Doing SFDP first seems a better approach.

Tudor expressed concern on sending RDSFDP as no-op to chips that do
not support SFDP.
I did a search on the Macronix chips that appear on the table and all
of them have a new chip or a new version that uses the same JEDEC ID,
that does support SFDP.
If other Vendors reused all their JEDEC IDs with new chips, then sure.
I did not check other Vendors, so I can not state the same on them.

Erez

>
>
> /Esben


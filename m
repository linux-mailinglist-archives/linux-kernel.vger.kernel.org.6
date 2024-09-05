Return-Path: <linux-kernel+bounces-317062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B77096D8B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513E01C25787
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6719CC2E;
	Thu,  5 Sep 2024 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT5DTeDb"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB219AD8E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539756; cv=none; b=ccXXKE6SOTu4w2Qdxj6LB2rKDjql7IGCEqt6T8MmXi1qVCYgUHEewxA2b2ygmApFHnpqyLK3LdJJMtkX6foSl9A94N7a9mwwFrwMTO1P72WyqsUZJqnF4P4+FFjnRIrtrRNlfgJYATvNDfcT40n/Q6RB8exlNzQhVBOaTsdi71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539756; c=relaxed/simple;
	bh=k3pldw+fWAY+PRKRpdhMqFzspmXtlNJdm5kIrzPjYks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beM+MhPE/v57tOgOIkMrcClMZUJxa+2wQCwtuWfh5OnKNrNipDgrmIDvnGK1TbVia0A7UUWyKJFMsT0W4VjwDZ+SPfDdGQwu6kcemu79q3AHIwmyiMZ4BujVDM6lZJUSbQOVctpcR1nGtZgH37kQVroLybqwPQZzIAGggF9HCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT5DTeDb; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8a4bad409so545048a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725539754; x=1726144554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQGDNoElnqbegbI87nipULY8XnKrQyvD+TCnZ/Vzi5E=;
        b=nT5DTeDbNseEKDrKyXYKWdwiFq52Rlw3K8nHIwYdDtPM7EF09XGS9UpifkvWEluMN1
         Jv62166bsT1TDsU4J8Ff+701GSUXNTN58dDv5esGwGkbcNYVrbWVnwJBigXYDoecqhpB
         5DcVgvlygEYesGaDyUB7Cpwpa7yfFuU3KiD9hjImlmP3qk731+7LBprtNJmFWrlWUZ12
         YqBfCIBDDCmFV/CjqIfwr0uz/S8PAbvfSwD3eMLBWi11VE4JHDGVvjXxD//WXhVCEwWz
         NxrK4+c8641ftIIEkfz47+v6kM3EfoSRMM72eqGN3PgDP8AM1qBPzDnzqZQETHkW7bV1
         Rbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539754; x=1726144554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQGDNoElnqbegbI87nipULY8XnKrQyvD+TCnZ/Vzi5E=;
        b=qnSO3bg+AD7DBnqJWqajzz5pesLYHcZ22TUPDaum7baqzlPKPCGC2OeVUm3O7S6wNb
         SJb1czsmfMyyZ6vQKDBgfBuuzGdt28TSmvK/75qASY1IjVmEOPQYK1i6A0LQqv1fFfRs
         r4lS4fgOl+B+h2S8pjWJxE89wzMqTqaL+AmwqpXohvupz4ZmBNYswunpEjkF9LDdIfHr
         FlcjW40E/ZZLcGUviaBrh+ad5YQoKAzovZ3JC1Y93sELS6pBaBVFJ3tBPh6KJSfZPvOF
         3hJ9FYsd6tjNVVUVXnxn0WDIlP5zSTzvRvqU0kDr/axCtPiCo7aZdoEcFeee1xmB5Jd6
         JrYA==
X-Forwarded-Encrypted: i=1; AJvYcCWMEiR1SQjYbhyISguX4TzAenUN2w7iQaH2O59BKo0jjZld8Wr/Dg05Q1W9KTxMI1cJgW6DClumINcF5TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zWLfnfKJxiel6O8speffetldJqiVMq0RPuNmfxJICnN0KFCh
	pw71xc0P7S6xsH9i2vBxn/IKbLFnz+hyx9cO41gW2/N8srZcVFkQRxR2yp2HiwsBPf5C9glJcJB
	zqsMbDp4+11Apybmr2uvg1CFLNrg=
X-Google-Smtp-Source: AGHT+IGvDYTD8AVzIiC+FlSbrzC19PS2fSql0s7cno5KAr88iWzFMRtbmqTaV1IV0QyNFtPrDG54MCS5neloF/m2xSQ=
X-Received: by 2002:a17:90b:4b10:b0:2cb:4e14:fd5d with SMTP id
 98e67ed59e1d1-2d89348e171mr15508849a91.17.1725539753743; Thu, 05 Sep 2024
 05:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904233100.114611-1-aford173@gmail.com> <0f9c3794-6bb4-41fa-8bc6-c00ecaf506a1@kontron.de>
In-Reply-To: <0f9c3794-6bb4-41fa-8bc6-c00ecaf506a1@kontron.de>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 5 Sep 2024 07:35:42 -0500
Message-ID: <CAHCN7xK_chbt3t2YkHRLmu+5wNg7KpDuJ0esLAMOav-2w5E4Uw@mail.gmail.com>
Subject: Re: [PATCH V6 0/5] phy: freescale: fsl-samsung-hdmi: Expand phy clock options
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com, 
	linux-imx@nxp.com, festevam@gmail.com, aford@beaconembedded.com, 
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:49=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 05.09.24 1:30 AM, Adam Ford wrote:
> > Currently, there is a look-up-table to describe all the clock options t=
he HDMI PHY
> > can use.  Some of these entries in the LUT are using a fractional divid=
er which does
> > not have a well documented algorithm for determinging values, but the t=
he integer
> > divider can use an algorithm to calculate the integer divder values dyn=
amically
> > beyond those listed in the LUT and also duplicates some of the entries.
> >
> > The first two patches do not do anything functionally other than simpli=
fy
> > some of the register accesses and de-duplicates some of the register lo=
ok-ups.
> >
> > The third patch adds support for the integer divider and uses it whenev=
er the
> > clock request is an exact match.  Otherwise, it will use the LUT as bef=
ore.
> > The rouding is still based on the LUT if the integer clock isn't an exa=
ct match.
> >
> > The forth patch updates thes set_rate and round_rate functions to use e=
ither
> > the fractional clock LUT or the the integer divder mechanism to determi=
ne
> > which ever clock rate might be closest match.
> >
> > The last patch removes the integer divider entries from the LUT since b=
y then
> > it'll be comparing both the integer divider calculator and the closest =
value
> > in the LUT.
> >
> > In my testing with a AOC 4K monitor, I was able to add 4 entries in my =
modetest
> > table.  I do not have an HDMI analyzer, so I just used my monitor to de=
termine
> > if this series worked.
>
> So I tested this series and it works fine. With Dominique's patch to
> allow for 0.5% deviation for the clock, all the 24 modes of my monitor
> and 30 out of 42 modes of my HDMI grabber are working now.
>
> I still have some issues with LCDIF underrun errors on modeswitch with
> v6.11-rc6 but these are unrelated to this series.

I was comparing the LCDIF driver from the NXP downstream and the
mainline, and I noticed the panic threshold values are different in
the NXP downstream for the LCDIF3 which generates the video for the
HDMI.

The downstream threshold states the default low value is 1/3 and the
default high value is 2/3
It appears the mainline matches these values [1].
However, there is an option to override the defaults and change the
values to 1/2 and 3/4.  I don't really understand what these values
do, but it might be worth some investigation to see if playing with
these values helps or not.  The notes in both versions state the panic
isn't designed to trigger an interrupt, but to get the Noc and QoS
modules to handle it.

Either way, it's unrelated to this patch, but my monitor doesn't
always sync values from the LUT, but sometimes it does, but I can't
tell if we have an underflow or not.

adam

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/t=
ree/drivers/gpu/drm/mxsfb/lcdif_kms.c?h=3Dnext-20240905#n350

>
> Thanks Adam and Dominique for the great work!

I enjoy puzzles.  Reading through the tables and looking for patterns
was fun.  I did spend some time trying to understand the fractional
divider stuff, but I didn't make much progress.

adam


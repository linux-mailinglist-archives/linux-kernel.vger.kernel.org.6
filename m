Return-Path: <linux-kernel+bounces-374889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790B99A7192
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84BD1C21A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0F1F8EF1;
	Mon, 21 Oct 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu5d4eMU"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCEC1F706A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533478; cv=none; b=pxuLuqfPO0ZHEEximrng8gFe/ZeKhQm5kUOku7vVUh43aIMzQGkUmPUmlmmyc/Ii3/zDX5VoBhVPW0rhSUBsvcEsYJjGwX3dwzO0rvwJsPAB9RlJsyBO/l+45rqwWafj3q4ROCuOoiixHakC9xWBdrA4e2CVeCib83hI6jOvqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533478; c=relaxed/simple;
	bh=hUBrKHUue/F3C9xrqq+VTIw9HsNDgGEP/rpoJC1S40I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyEDGDaZt4MxHvLSPiHCIj9UiFV59NinhIicNCfRrkPZMFyZuGtTsF4etqjw4AnBHS0Hbw7B+I3yAtm0kE0NEdy07p9iRzBmp4/eSZcsT3vLOiIaM2gAVBfiU6LNOM/J/16r0pIixB9G1NelFwNmj/rZpK88n8IdYipJGVI/28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu5d4eMU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a5f555cfbso307099066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729533475; x=1730138275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1ifdON4eh/u5fY3MrqRCTjWGevh8FxLOdp4ppnwvkc=;
        b=Hu5d4eMUeP4bBO/ly8G3EvHr45GVcHsPpFMeydF+ewuINqdgbnj/q3yfuDO2fmz+Vk
         KO7L2nLPvmIZRGzHIjcP/7HOWHLQIk+EjZ0zXGi6hUIjdJ5f6tMq6SdPSWPVn+wDbEG5
         6PdaIwFSmVR4CsF2bCBQLgNOD3KnruyYcpmFV0+7vBpNk/oLUj5dNq5Mer25jVlc+s+3
         P/WBJjy4cjpQIpYX52+L4cP8VWFnObLkRGi+ovnsY82isKQ386HOzB9pfsDPTo7BgXuZ
         k1y7ZafuMCNGcphvMHNVgZyFX3GO7Qb0GxU5xAcdlMExjWs1i81os8LOAtDY+87Iu5Av
         qmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729533475; x=1730138275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1ifdON4eh/u5fY3MrqRCTjWGevh8FxLOdp4ppnwvkc=;
        b=VLaNtqhtP/sIUrXTUpI7MtbPaJhQWbagdNQtUCL4OU0urb4ZS7gPaWmpzwFEctA4l1
         nxhPmAdaLUMGaEKHtKEg4bXYOFr8LH/3hCQSA5iZ685H5pt8jQ0F5sZgYif1FFjn1IHB
         N04gDEXUYdWTXwvsozxjRJqSt84xYr9qgRYqQGwVFyWyHozGfe8q3xrWqbJ2CHbk0s59
         VLddrwPXU25JR5kLzMf1wtbAxSdtBP5Ly7Y4D/KXUzTo0xS9teSy+tEm10gpwTyT7dat
         5Js0WiL/G2Q76GDSZgs+pLrbptHYzHpsKf4iKhb6s6+viet1y2wrfMJdI47ULiubbYhm
         wtfA==
X-Forwarded-Encrypted: i=1; AJvYcCU2/VvlyJa7RwJKs8ivX+y+lc5Qe16TUijwA14dekwBXQckZPIKAk+JWn00K7ROLyfikGpRWLw1SSHuH0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHdpVfz7fcEblif0kPtT1GumIxZC7byQ65S66cY7VXU/8EyH49
	c15S19NphJOhymydihhTCd+IWHdvsvO8k7RLI2M5LNo/8UidbP6b59CNKppC+IYrvPCZMyc/0wt
	ErTIPnKaWQysYJ1X6P+ywk7dJOMiBPG9Z
X-Google-Smtp-Source: AGHT+IFW1zvlp2HlIOHfjmyNzv7TX3z0W+1p7fBqXXB3xdwmNPwA0PFnWRuImB5wo7HayPPk++WhjmuQdrLp1Af9xqE=
X-Received: by 2002:a05:6402:51ca:b0:5c9:5928:970 with SMTP id
 4fb4d7f45d1cf-5ca0ac61c0bmr14063909a12.19.1729533474949; Mon, 21 Oct 2024
 10:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com> <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com> <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
In-Reply-To: <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Oct 2024 18:57:43 +0100
Message-ID: <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
	linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

> > > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
> > > >
> > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Changelog v9:
> > > > - default to BLOBLIST_ALLOC on arm
> > > > - Move default for BLOBLIST_SIZE_RELOC up
> > > > ---
> > > >  common/Kconfig |  2 ++
> > > >  lib/Kconfig    | 15 +++++++++------
> > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > >
> > >
> > > This is fine, but please disable it for snow since it needs the FIXED
> > > option for now.
> >
> > I cannot follow. What needs the FIXED option and what to disable?
> > I run this patch on the CI and test_py_sandbox tests are still working.
>
> I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED so
> if you make ALLOC the default you need to change the default for snow.

Simon by snow do you mean the device (configs/snow_defconfig) snow, I
think Patrick doesn't know you're referring to what I believe to be a
device config.


Return-Path: <linux-kernel+bounces-399755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBC69C03CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0F1B215E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD01F4FB4;
	Thu,  7 Nov 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIvdzGVU"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554511F1303;
	Thu,  7 Nov 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978548; cv=none; b=FGn2OjAEEvbKsx/w55pHb5d8HwU6Fc1R5XshsDAikltaDVRDTFMGfKwAKGWh4pdCqvia6HhH2IKnz/nymGHdOEKlP9SaafVm5qO4ghmdoc9/4AJeyOTgoVJYyFN1l+TZcbzQwQ98ugTTsIv7nN+L6CfSUDWYDEfzw3ts9kyd5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978548; c=relaxed/simple;
	bh=iyCDl7ZPUt6a//yr/835EBnfK0zGbZXT8k2phIEStMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfN2jZFS2KoW/DQHnqXvQI0t+OFdYm/7rX/xjfQljBPq+fPKsDuIenlHj8+Rd/KVsSf/8QvY2+CQuZjtZBIePo1O2wqHwX822sCIcIpTQ241DWn3PYp3SJVa2KOH/BqE/LOY4+BJxwQm3R5Cn40pTtcDKZE73YN8dJO4u9iPDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIvdzGVU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so116282166b.1;
        Thu, 07 Nov 2024 03:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730978545; x=1731583345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyCDl7ZPUt6a//yr/835EBnfK0zGbZXT8k2phIEStMM=;
        b=FIvdzGVU/5lKGIufePv9mlEQxNuHIK1dcaf/4A5K55LtQBW4ANCjtLCGofd5rBNuCj
         BcIA1xsdCFsmgoQyBj6Wj/mfD3cGzrHU7skKVzy7z+U1GBiYLv9VrYHAc5uCSxq5hqM/
         Rn2mDFMdgy0LLyxGxvp+6JteT+VwkkZ/469rjANoaqDXjVFwD4mvY8g/ME1QcETtya2P
         cLdq/Z0CpdIIV2ik4cbRv0Fw6lZOHKlmS6idjZT38md7EpfmbAAxsIo7ENzJsxy6eWIm
         mJeTti+pw9cCUY2AhxbXAFI6wMuU83B6kO+MOLIrhOofrBvztmJ6UpRSFqT427vWcOjT
         IQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978545; x=1731583345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyCDl7ZPUt6a//yr/835EBnfK0zGbZXT8k2phIEStMM=;
        b=hiKART7sXAMY8SGwOaRZhwYvV5YW1bcrKOKnynwBlNNeFYp56HlOUjz3TVfFR/Fmgp
         0IOtKvgodSCsg2z/uPUEfENzy1aD+mSiLh7J6eSEY1ElPShj/Sh/QFqWOgHoVQeYMiw2
         11e/B1uST3xZSC3+oLLVjpvW9g30/U8X5HUPGQPaJDH+jqwdXTwn+wdl7FKinkgAY46r
         bMd2ac8ewRyU8J/REGaZNTaAsi5XejVlQfyCKMA1b3OpMMLDyEJPZ1ZH3k998AztVZdm
         c/65+bbgcTiaa8tIwA3DiSpjhf7Ewvm6xaCQU/Xbz1JZtTziz8smxUffGtKXdv0PncnC
         Ed1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJP74vg9EWW3/duiH1iolZtakr8Z6v+mqQVak+elqGsGz3UNr6duqweVwFO8cCXT4gUrwcR683tyzWak81@vger.kernel.org, AJvYcCWnN4MECNEmJtCX4dGqaViT69mzsmhqnItcs5CnTJATyeAwNx6z5OmaVGIHm5fFlaojcbeAkKchwA1h@vger.kernel.org
X-Gm-Message-State: AOJu0YxqW5swiMagAlhuUkHHaLXfatMu1jr1j0KA1JTzi9ywDabPDsKv
	r7NK/ukGWX4blAi2ZeRnEPJ3bjRM0M/4cUOH2zldBel/vBUii5JHntiIcfwgTaVJgD6cUcGg1Zb
	BhJpEFdadKko9ClGN0JvV/6Gg7vU=
X-Google-Smtp-Source: AGHT+IHGsPapN8RHF9Qpx6NuCKBBsmhdkYBPLxie1jdxHa0MnvuH1vKs6Dy7tAmC0sQgjvTv9FyEtEoss4jejQxSaY8=
X-Received: by 2002:a17:906:8415:b0:a9e:c940:d154 with SMTP id
 a640c23a62f3a-a9ec940d1ebmr412325866b.17.1730978544331; Thu, 07 Nov 2024
 03:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
 <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com> <8e858e760c78ddf533e9e03c20b34fce29862c2e.camel@codeconstruct.com.au>
In-Reply-To: <8e858e760c78ddf533e9e03c20b34fce29862c2e.camel@codeconstruct.com.au>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 7 Nov 2024 19:22:13 +0800
Message-ID: <CAGfYmwVxwaZk-si1OkP4xeaODhAO74Hv43U=SpzOsGOBkTH8Bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: catalina: update pdb board cpld
 ioexp linename
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Potin Lai <potin.lai@quantatw.com>, 
	Cosmo Chou <cosmo.chou@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 7:41=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Wed, 2024-11-06 at 16:58 +0800, Potin Lai wrote:
> > Update the GPIO linename of each PDB CPLD IO expander based on latest
> > CPLD firmware.
>
> What version is the latest CPLD firmware? What was the previous version
> with the old pin assignments?

Because the hardware changes from EVT to DVT, the CPLD firmware
reallocated the IOEXP pin mapping in DVT version.
I will add more description into the commit message in the next version.

>
> I'm also interested in some discussion of the coordination between CPLD
> firmware, the devicetree and the BMC userspace configuration. This
> change feels pretty painful.

I am not from the CPLD firmware team, I only know our CPLD team was
redesigning the entire struct which causes the huge changes of IOEXP
pins.

This is probably a different topic, I am curious about is it possible
to assign the linename in userspace?
In OpenBMC, there are many services that depend on GPIO linename, it
will be more flexible if I can assign the linename before service
starts.

Thanks,
Potin

>
> Andrew


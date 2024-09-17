Return-Path: <linux-kernel+bounces-331281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71CE97AAED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039011C21BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1B64503C;
	Tue, 17 Sep 2024 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqbNMl2S"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0A1B5AA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726550165; cv=none; b=R4ZguX7fiB7hI6vGXOK9VHzo8Rr4cSzgaQDDUGgQWV8Ql7q2aztlIIa5vKLHE/BAoAvQogiFLxapRAkVvuX0Wfln9E84HtZAYr3otCOkG/PX4WFzI5IN+dyS7R4OF8w50y5skgnDL7cxcfeH5E6gYyaB9bjnbuRsfg073r6nYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726550165; c=relaxed/simple;
	bh=2TTB7wAEj5T66egfXzELpAqCFa2m6r9RCcwd0KSOwxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WCXuUjUnIF/uxIPZr7EKzmWTulroQsBiqdefcY8XRp+G6SgZjYa07yismNsbNTJrncvwssQWkVRocLJjP48n9GbuDOnQh6WxC6zErG/yG0EsRJaAjv9v99krBrI5tLgFBqp+F4vWSI2u3PsYqhd421mCLUxs4t/10DnakiYhOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqbNMl2S; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so667590866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726550162; x=1727154962; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TTB7wAEj5T66egfXzELpAqCFa2m6r9RCcwd0KSOwxE=;
        b=oqbNMl2Srw+0CPG/qQtj09hvzDwL21/FMgSMMZRDXkR3K3jJwJwzmu6Yd2cuPoVEaV
         qWhkb2YwHhMEZ2S8kKkwkYWOzaFm894Gek/rAcww18V8mmni7u0oEDxjiF4y1zdQ2jHQ
         ZGll//Ms8rmdYfkAk9+vttwLySpnfuIrftdBQiEzPagK6n8cbQL+q8FfDGgu+0lqfjT+
         4pf1LHYWES/QE71J8HMLLGDo3QZg9SeHvN4do0id1wpXJ93g9QvGkMHglLeihLyyGhFK
         BAFbykec8V4wZIR9YqMnFtnUTc9H7qozi7icfSpf4Qg+3XVhahWES8Te0/BX0bqlyLWA
         6rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726550162; x=1727154962;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TTB7wAEj5T66egfXzELpAqCFa2m6r9RCcwd0KSOwxE=;
        b=wV0mARDF/xJThu4aqXB32oPfUkrwOJUdZaUpLRWEo62cpsdAOZkjwf7rXBBvWVTScc
         06P1u7PWyx0wuiCYdaSqgyx/6mKKLYydogF/D8jHkN/dUD4UD7qB0Ja3N7CZx0PXbSxi
         QEhDO0gUSQ3bf8la2LnYP+qp1RJvnLaJDD84DOs5vd3kTxNx58pI0ys9Js50lXobWW42
         Rt+47to0yPKPX7t0EEd6gjKRAzB54arXI5xsBsqDkqfvVTQZXjr6VCsyh5PlG1yGA7IB
         uKBO+CACokseqM6KKQ3muK1J+SMlGITfm16SMtdLh/3LGCFBIu3ddYLQsqkM01ovrgOW
         qunQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC7wOoHhDt7eWyB5FIe1tChqi1D3lcVcKi6fqXDCV/11PvezZ7ogt/HgHJg08+jTaWFzC71/HhgTA35Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HlWVrI06FTDa4932XOL0ayp+MxiMazUDSmV5JgTgFzqfdBOV
	MjLsevHSeSICpzELCVnW2A0I/m1/cnPhcQb1I9CyzADrDrdR7+DiMwuwn5wggeU=
X-Google-Smtp-Source: AGHT+IGU5G6rYzZj+qUSKxMD6QccfUPU5XJPeVbknYBxvKJlQGaCF1SJJe/Dc+rxOPuDLI4kUfVvhw==
X-Received: by 2002:a17:907:7255:b0:a86:8f7b:9f19 with SMTP id a640c23a62f3a-a902961754cmr1727820266b.52.1726550159121;
        Mon, 16 Sep 2024 22:15:59 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f151esm398242566b.48.2024.09.16.22.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:15:58 -0700 (PDT)
Message-ID: <2600a8780580b16ce9707a504cf02e4204cdb83c.camel@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: add max20339 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Michael Walle <mwalle@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker
 <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 17 Sep 2024 06:15:57 +0100
In-Reply-To: <CADrjBPp1Esr_y7nuMgEiknDQbDzW7bKu5UKaoRQ7jGYRAFr_Uw@mail.gmail.com>
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
	 <20240916-max20339-v1-1-b04ce8e8c471@linaro.org>
	 <CADrjBPp1Esr_y7nuMgEiknDQbDzW7bKu5UKaoRQ7jGYRAFr_Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Pete,

On Mon, 2024-09-16 at 20:53 +0100, Peter Griffin wrote:
> Hi Andr=C3=A9,
>=20
> On Mon, 16 Sept 2024 at 17:48, Andr=C3=A9 Draszik <andre.draszik@linaro.o=
rg> wrote:
> >=20
> > [...]
> > +
> > +description: |
> > +=C2=A0 The MAX20339 is an overvoltage protection (OVP) device with int=
egrated load
> > +=C2=A0 switches and ESD Protection for USB Type-C applications. It pro=
tects low
> > +=C2=A0 voltage systems against voltage faults and surges. It also inte=
grates two
> > +=C2=A0 load switches with current limiting, configurable by hard- and =
software.
>=20
> [nit]: what does "hard-" mean? should this say hardware?

Yes, hard- stands for hardware here, it is a suspended hyphen.

Cheers,
A



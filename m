Return-Path: <linux-kernel+bounces-340504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70F8987451
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5863F282826
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6243B1A2;
	Thu, 26 Sep 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYubRVYW"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BD19BBC;
	Thu, 26 Sep 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356633; cv=none; b=hNkADxnYyFWE+/thCEbRKPRcpDhZByzadg9rm8sET7RRA3EVH/ltJ0w3LJepNWi0ySg7ES5BTFjw8DHH0Q2s5yQEN0ZyLBQI1kznvE4YUeMHiWRw31Oafz9/cwZ2hFOPBIh/iFO1oERkFDvbJmnUWY2zWeZN4TiD0XmQB5rSILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356633; c=relaxed/simple;
	bh=cnx4zIAWJtFq9rSTLb7/0r8of7OoZslMoGPoymhstBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqAZH7lruuI5JRuMk7Mu7DFIXwZuGRwkjmuDONjBOU/zUxeRWlcA8VQpUXWulVx7vB6+41CNV3VKr9QPnFci6yxCYQycgisCBE4YFDqxd0EaA+kHDJXzRFR784PD/HaeClW+7RGXfDox+e1z1p/flS5Nu9JlQxGqIhgL/fynuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYubRVYW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86e9db75b9so149989166b.1;
        Thu, 26 Sep 2024 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727356630; x=1727961430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cnx4zIAWJtFq9rSTLb7/0r8of7OoZslMoGPoymhstBM=;
        b=jYubRVYWlI8xnkRYhiaYPGkoF5onHEuoGFmcfxkkqIpP2xIucfIKk/oG5joDih+xzK
         3GEclYWLZLUAs191NLdpiB+INYiBVLf2bSL+ATfuEY/FmE6DBjN0F0tn2kwYiuvb56g0
         cFulPOwabdsnbUu2o+Amp7fjzTIR5MXMfuYel4AnjiU2QcFUdb3g9nzTH8AWyL8lK2Oj
         zUAp2b49SDO1UXEK1Nm0RmGUJrIVscDZqd2BRlmDsBGCvLpWVHRtFfNfS0IZN4ceck85
         aj9LRJwHip+Gnh5mpAjOf4xdnEEsUMr6nHNvs9P5LlF24uxTuVkOzcucTH3Xlbj/KjRC
         JdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727356630; x=1727961430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnx4zIAWJtFq9rSTLb7/0r8of7OoZslMoGPoymhstBM=;
        b=GcDlPE1+lhpfxTz9CtyETDIwwu9WsgrxgYHKqqw6vNu+hFlTtXkR+adQuXJRc3aAnE
         K/KVYUslrwLi9rF3RTpXdKVhUpDj7eeHbyPfct+cH0DlPUXOLhag1IJmJNNPry4JvWUg
         qMqzOcAxymV3oUXP+LCyjJVkaEeITjOYRrj8H6al4TUp6aM6Gwq6l0GP8imiBDuDad5j
         Dw9hXaj5wvapAeldM1gE6giw/ozkRgcaHUySGJ8tsw+l3P/bjRMi+VqRfYUiFV/FuJaC
         NpnEYxj+NdCgW3OCfjA2/xUxDzJfffE1oHHBCRRCopO1TWUeEra/6xEO9XKBqH9NLxAP
         d8gA==
X-Forwarded-Encrypted: i=1; AJvYcCU2eOfKn1zjIInEKL7yZworDTL4SqutGAA0FqRWGIlzkE7pbWowdgeqoLjfTJtSPyo4jDJcCyDhdrl0@vger.kernel.org, AJvYcCX1l0mzVF33QrM5lBXyT6ZQTu5e8aSWKrdfGzk9PFyqfKXnwhEV71upVM6ZSTqyBbI0fK1Y8ThREMbYTBl5@vger.kernel.org
X-Gm-Message-State: AOJu0YxaahxyIMUiZYDtJUYacwUcYl0vt50OXRaHzMcD24ktfUctJh4H
	/L4piYzg61DD1oTIAKAiYmbPwDfusEJ0ph8V2Ea6fjbbkkDqho6erqzyPdRc+subl464IraMvEk
	tFRuht31XngMJd4v7N7T7reFZVQ==
X-Google-Smtp-Source: AGHT+IGxkuSZn14CGeSLBxg4a20MxMh+vZrJ6S9Uv0v7mFLjFUHwBvjRSVie0JOJ3Q7qB7rPKyG5eEcor9Qu4RuwHOI=
X-Received: by 2002:a17:907:e28c:b0:a86:6cb1:4d49 with SMTP id
 a640c23a62f3a-a93a0322a58mr558075166b.13.1727356630231; Thu, 26 Sep 2024
 06:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920181231.20542-1-erezgeva@nwtime.org> <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org> <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org> <CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
 <D4DSTDA3HE2B.20ACE70SQAL7A@kernel.org> <CANeKEMO1nyzEKGCt8N8_UCmAcQ3L53=H8U07AdJzcnFaVuwjGQ@mail.gmail.com>
 <87y13ehn6y.fsf@geanix.com> <CANeKEMMcZ+Y-f8Kty_4Nk-kRu+F7ZXBbxpAG1Bd_P1vcju1mUA@mail.gmail.com>
 <8734lmhcil.fsf@geanix.com>
In-Reply-To: <8734lmhcil.fsf@geanix.com>
From: Erez <erezgeva2@gmail.com>
Date: Thu, 26 Sep 2024 15:16:31 +0200
Message-ID: <CANeKEMMMYu9ugZksnJscCPROAS2vbi_BXHnJcc-MsDZMwJeTvg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Esben Haabendal <esben@geanix.com>
Cc: Michael Walle <mwalle@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 13:37, Esben Haabendal <esben@geanix.com> wrote:
>
> Erez <erezgeva2@gmail.com> writes:
>
> > On Thu, 26 Sept 2024 at 09:46, Esben Haabendal <esben@geanix.com> wrote:
> >>
> >> Erez <erezgeva2@gmail.com> writes:
> >>
> >> > On Mon, 23 Sept 2024 at 18:19, Michael Walle <mwalle@kernel.org> wrote:
> >> >>
> >> >> > > > I would gladly remove the obsolete mx25l12805d.
> >> >> > > Why? I don't see any need for that.
> >> >> > Maybe because we do not want compatibility table?
> >> >>
> >> >> I don't get this? Anyway, we do not remove support for older
> >> >> flashes for no reason.
> >> >
> >> > I did not insist, you asked.
> >> > Macronix stopped selling these chips 15 year ago.
> >> > How long do you want to support old chips?
> >>
> >> It is not unusual for embedded products to have a support span of more
> >> than 20 years. And chips such as these flashes might not be entirely new
> >> when the product is introduced. So dropping support for SPI-NOR flashes
> >> that are newer than 25-30 years is definitely a risk. Somebody out there
> >> might not be able to upgrade to latest kernel versions anymore, which is
> >> not a position we should put anyone in. With the increasing pressure to
> >> upgrade product for better security, we definitely should not make it
> >> more difficult to run newer kernel versions than absolutely necessary.
> >
> > I do not insist. Nor send any patch in this direction.
>
> I did not say or imply that you did any such thing.
>
> You asked an open question, and I gave my response. Nothing more,
> nothing less.

+

>
> > Each project can define the extent of backward compatibility.
> > In terms of compilers, linkers and tools, i.e. build environment.
> > In terms of standards like the C standard we use.
> > In terms of network protocols.
> > And also what Hardware do we support.
> >
> > There is no harm in asking where the boundaries are.
> > All projects move their boundaries all the time.
> > The Linux kernel is no exception.


Return-Path: <linux-kernel+bounces-235955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B12E91DBB5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397041C2148C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBE912DDA9;
	Mon,  1 Jul 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldTD3weu"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDE12A14C;
	Mon,  1 Jul 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827218; cv=none; b=YdgMzyEQEhV5rY8EHEP2bnIIHyTM3/kkOghA5qEPn9BsUKsaKa4xM61R8lmUmpBufPrjl8Dru0zFRp2RkXaWE37rHDViJQaMBzeGj7YGalWVhpbNHsy+6v3yo5wwRR8TE8M0aY4HWy3AScattsnIdvp8lfLboUYZHWT5GhTHvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827218; c=relaxed/simple;
	bh=1mdbcvOKare6fTE6pXiojzL/q9PAeyXp0dtBoiv77Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi02L9mxzueLk0+8R0Nixlg6fDIMh6ZNJB2IYI1QytUSPW7f2JIG56V2X+Dliy64DUhtzgynzCN9RGB4rpe8JDC/+0BFTUYyXSft4RrrzA0oky958p5qGaIBekuSt8n4++D2xcAgpMtl252DZAD01ALi+8fXw94x7fEJRJjsUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldTD3weu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7527afa23cso82690266b.2;
        Mon, 01 Jul 2024 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719827215; x=1720432015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ8hznQdBSpW/pK4jDinmZ2F4dwUUNDMvQFJh/2PnF8=;
        b=ldTD3weuvLRSVhT5KFsSa5RBDf/KzvCXcZMJHkEaPOZvzasU45SRIAXiGAEK5Vxci2
         ft8YAYIDLFYxx2co/pk96ve0IP7VNJm3qiDanz3z7KEQNBTUvK4EgyXGDvz6ATqtTp1H
         FWUKUK1o8ePZCbqpOoewldqi7Q22S3sdrVCzUs4qG7rLLIfHYrLYoBZD7d1u0e5/UI4V
         7okpmYz6N0iB68MYTOUWRIO4XTDB3twtU1TayI7MW2RvvQc5bXL+1B/57g0giJqI0qIT
         98JPTHlRYLSOLQNuls2HB0/ZJ+C9IElr5IQ8slaL2jEDDPfdZhoWl6GYZE2sDN+XpTJO
         wKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719827215; x=1720432015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJ8hznQdBSpW/pK4jDinmZ2F4dwUUNDMvQFJh/2PnF8=;
        b=RqSrsFkOMXbT9mGAXf67yPdLUGqoDahsya/m19qvxgE+Ka5eLmRU6mi/5lPbX1S8Af
         SSSJGXLe4+SqvaJoiLFAgGPQF+KJz7GyR9EPnPkn914zj7IC5yTr5/JQ/ESvKr4HC2iP
         7glcCKNvR/vBd2HKkjlhQQNuAMOwGfxqsNM0LDRMJMHq1+aHLDsWntoSZG/T7QWhPEa4
         KuXf1VQHkQsNiPgrxXc1f88Hly8JZDpQM0sAaHC4Z2soo+KKobAuZjxIwvzUvXM1ugBv
         k0ad+n2C3eZRTbc549sbrfQeqLYa2uov3fEOae1lnLsdf3Xt7j7AFDZf+e2ww3PyohQD
         gtew==
X-Forwarded-Encrypted: i=1; AJvYcCUmpLU8RA743Szu9RzzzDgsJn3V7rBME7pLbZYxilZy7TLqpfFZgu7ENE0LTLBLvRcq4ZkI8o45uBrp/nQVHEODoIktXdLky+oslbmAm1bBOddI9IiX5JM3jQaTQtXP7PozdyB3F/NqiQ==
X-Gm-Message-State: AOJu0YwsTnSQwGlWqelN4yv4ZzIBup8jlW6Fuqinh5L4NvFqPDFpjQlj
	1TiVbj97YZDsxwEhEzdvlVRWwVTNLw+5XE8wVFBecOzNIWA2CbemL2p+KBrS0AUVxhW5yysVztu
	ABRYFXUtjH03OviUwDYjRHtdYOg==
X-Google-Smtp-Source: AGHT+IHDggheRf09W9QEoK9AQzFlLZt2A//Iiql249o+YW7xCeGM2QIwLllRZevmRIDL1Bw4ZPjbtWr2EPs32Qz1SSA=
X-Received: by 2002:a17:907:7207:b0:a72:7ffc:f54a with SMTP id
 a640c23a62f3a-a7514467505mr469201466b.5.1719827215242; Mon, 01 Jul 2024
 02:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629103914.161530-1-erezgeva@nwtime.org> <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org> <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
In-Reply-To: <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 1 Jul 2024 11:46:18 +0200
Message-ID: <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Sorry, I resend the same mail, as I send it again as HTML.

How?

When using mx25l12805d, we do not read SFDP.
As it uses the no-SFDP flags.
When using mx25l12833f hardware with mx25l12805d driver, it did not
try to read the SFDP.
Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
driver fetch the SFDP.

Secondly SFDP does not contain OTP information.

mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
While mx25l12833f has two OTP regions of 512 KiB.

How do we handle it?
I would gladly remove the obsolete mx25l12805d.
And skp compatibles all together.

Thanks
    Erez Geva




On Mon, 1 Jul 2024 at 11:40, Erez <erezgeva2@gmail.com> wrote:
>
> How?
>
> When using mx25l12805d, we do not read SFDP.
> As it uses the no-SFDP flags.
> When using mx25l12833f hardware with mx25l12805d driver, it did not try to read the SFDP.
> Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the driver fetch the SFDP.
>
> Secondly SFDP does not contain OTP information.
>
> mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
> While mx25l12833f has two OTP regions of 512 KiB.
>
> How do we handle it?
> I would gladly remove the obsolete mx25l12805d.
> And skp compatibles all together.
>
> Thanks
>     Erez Geva
>
>
>
>
>
> On Mon, 1 Jul 2024 at 07:23, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Hi,
>>
>> On 6/29/24 11:39 AM, Erez Geva wrote:
>> > From: Erez Geva <ErezGeva2@gmail.com>
>> >
>> > Add Macronix SPI-NOR mx25l12833f.
>> >
>> > mx25l12833f uses the same JEDEC ID as mx25l12805d.
>> >
>> > Although mx25l12833f is a new chip that support read ID and SFDP,
>> >  users might want to specify it in the device tree,
>> >  to differ it from the old mx25l12805d chip.
>>
>> As Michael said in a reply in v1, we try really hard to don't introduce
>> new compatibles and instead rely on the generic "jedec,spi-nor". In your
>> case you can differentiate between the two flavors of flashes based on
>> the SFDP presence. We won't apply this.
>>
>> Cheers,
>> ta


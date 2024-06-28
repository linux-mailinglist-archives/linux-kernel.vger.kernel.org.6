Return-Path: <linux-kernel+bounces-234228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580A91C410
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B91F281286
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B2F1C9EDF;
	Fri, 28 Jun 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/7OVUFY"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2BD2E5;
	Fri, 28 Jun 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593116; cv=none; b=jC21yKGdwW2XlZFmWXxy4wJCPCDDMPrnnBX2jlet2YJvRV+cvBFnoxikYT1EyQyYZieiVQq8yBtvRzrpOCm9qXCkug4UKHu19I/eYc3q5drmMO0pM7IqMhihCPDmRECkuhKXn2HCMoFQiAkCVwi7m6FDVpaG8lc1WaXkD1Hc8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593116; c=relaxed/simple;
	bh=mO+L0yvC60vMhtCoipGkdzIY7TPHWg+4f4+4ccnL1Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnwD+YYzOvHAzsAItCV+F/R7HXjazxlLrlgYaP/h/wawl+eJvhe4eV3FvLmFSApzo8djmvftB0h+KCpVJXXwoo4MrD3h6dft8n3K5N2Sr7Rm6tCipVGQYXw3JzIPP7+cXGyZPZ53cnfcsCs8SwgbitXZ2wvyvMBqMHILd5uPTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/7OVUFY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a728f74c23dso96222866b.1;
        Fri, 28 Jun 2024 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719593113; x=1720197913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6opEP+oxPf4EYU4j61G6/Gb7Qxsmf3nFQOvrXXgQuQ=;
        b=l/7OVUFYooXbNsV77YW1R/nkf0LOf+KSVwN8DeqkwrXJLc/v+t3/v8RkkJKO4y8KMC
         V/MJ35LCkFTd6twZ/Nhwal3fmSQ628GfonD0Q+W6o55aNyQnix6enkya1U39ksx0OPcH
         XFwJvgJbcuL0fzgG2/XtEEJiKD2T7kZPTHsqEPgPSaLd4tYV2tY9WnWHJ37IjUIh93q2
         smoxkpQjsYqbNBAEj9fhAMULxUJ1dskdfnkz2SQgVtKHOcuPp+1tXu8utb51JQ53AX2p
         hnQEJtocfSpZAQsHU/UZKlab/agVKQU69XFPZmOJQ2nlUgB6b8DB93lkzUJ7nie0yz/n
         4aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719593113; x=1720197913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6opEP+oxPf4EYU4j61G6/Gb7Qxsmf3nFQOvrXXgQuQ=;
        b=COgTYjrw0WuDVH9z8xS20dwhHUhOyx5dpEULwaXvqc3wmAii4XooZl/U6swaHnW6gX
         gumQc6cMy74gp/Gd953Pfy0sirSj4GKuRPSo8Ic4CXTawK6h7hbiCt+XE+qkMMY/lDBo
         UBCceyZi3L88Fx2+ut7VZbSpED5/r7jbcGWNBX3dTnV2iGwzyXVcD31OxjEKYYZ7hhMH
         usRKTsfvSL022J3iU/22bXXJ9SnXJZKSpeeGozgW4mUOGY85k1bTF7UugF9IY3rnwGl6
         ia4kYIFg523ZSEqpLEQt+0zw7sPm+R3n3EKOP4F+nlQl318ZPyzp/hVWiN4IsZLe3vk6
         oNZg==
X-Forwarded-Encrypted: i=1; AJvYcCULpANSg0gp7Cgl1W3D9BHn0EK+V2ilSeykcWF3f6RgaLbfpgSof9SVAhWv/tok6kyVD30dcCpt8Hbd/4pFTEplrRjXBnsb08arOLED1bBLjmqnXkdFLciYnvjlIIgaRxxtT0tfeHv4oQ==
X-Gm-Message-State: AOJu0Yx9Vd52wlNw5kbj/JBIBBSZPbxly0wOj3u5QwgnLSvSswcravD0
	Adid6UMtzyOs0LQDOLOOD63YHEo2V4R154E8EdBow/KFiSJWqaf3xS3h2o7QIE34L5Tac5BgvDF
	8NDtLiPERRcgWMwBaxejInIfjlmr+HOFNTw==
X-Google-Smtp-Source: AGHT+IETF8QqAle/XkSXEMA6ZayfuArJ+Hq5jcKLkHKXXN/m33bSmDsyVwGe1XbiT9NZr31/GDrpxiJSd9Q5Xul+La4=
X-Received: by 2002:a17:907:a607:b0:a72:744e:670d with SMTP id
 a640c23a62f3a-a72744e6a5amr871187866b.60.1719593112739; Fri, 28 Jun 2024
 09:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628140328.279792-1-erezgeva@nwtime.org> <20240628140328.279792-4-erezgeva@nwtime.org>
 <20240628-refuse-actress-b76985aa020c@spud> <D2BS0YMA48BG.1PEPFC3KMFV8N@kernel.org>
 <CANeKEMMrXK=mw=n=9DuTnprkTs3ct446oaC2QTJyst8Nd+D6rw@mail.gmail.com>
In-Reply-To: <CANeKEMMrXK=mw=n=9DuTnprkTs3ct446oaC2QTJyst8Nd+D6rw@mail.gmail.com>
From: Erez <erezgeva2@gmail.com>
Date: Fri, 28 Jun 2024 18:44:35 +0200
Message-ID: <CANeKEMPAv-jXuE2OwRQaEvru3yPt0rgBU8=p35ub8nK9UtnbQQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR chip
To: Michael Walle <mwalle@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Jun 2024 at 18:30, Erez <erezgeva2@gmail.com> wrote:
>
>
>
> On Fri, 28 Jun 2024 at 18:04, Michael Walle <mwalle@kernel.org> wrote:
>>
>> Hi,
>>
>> On Fri Jun 28, 2024 at 5:57 PM CEST, Conor Dooley wrote:
>> > On Fri, Jun 28, 2024 at 04:03:27PM +0200, Erez Geva wrote:
>> > > From: Erez Geva <ErezGeva2@gmail.com>
>> > >
>> > > Add Macronix SPI-NOR mx25l12833f.
>> > >
>> > > Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
>> >
>> > Should the email in here and in the From: field be your nwtime one?
>> > Otherwise
>> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Actually, you're not supposed to add any compatibles to this list.
>>
>> From the binding:
>>     description:
>>       SPI NOR flashes compatible with the JEDEC SFDP standard or which may be
>>       identified with the READ ID opcode (0x9F) do not deserve a specific
>>       compatible. They should instead only be matched against the generic
>>       "jedec,spi-nor" compatible.
>>
>> I presume the Macronix flash does support the read id opcode.
>
>
> Yes, they do support.
> The new mx25l12833f also supports SFDP.
>
> I do not know why they decided to use the same JEDEC ID for two chips.
> Your guess is as good as mine.

https://www.macronix.com/en-us/products/NOR-Flash/Serial-NOR-Flash/Pages/spec.aspx?p=MX25L12805D&m=Serial%20NOR%20Flash&n=PM1310

End of Life (EOL)
https://www.macronix.com/Lists/TechDoc/Attachments/9861/PCN31_2009%20PCN_MX25L6405D%20and%20MX25L12805D.pdf
Macronix will continue the support of the existing MX25L6405D and
MX25L12805D as the following schedule:
The Last Time Order Date: 31st Aug., 2010
The Last Time Shipment Date: 30th Nov., 2010

Erez

>
> I know the two chips have the same flash size.
> Though the new mx25l12833f chip has a bigger OTP.
> Secondly, the old mx25l12805d has an asymmetric OTP, the 2 regions are of different size.
>
> As I see it, the first 2 patches are the real contribution.
> As I remember, the kernel maintainers usually like to see something using the code.
> I don't care if it was another Macronix chip. I simply tested it with the mx25l12833f chip.
> "[PATCH 1/4] Add generic functions for accessing the SPI-NOR chip."
> "[PATCH 2/4] Add support for SPI-NOR Macronix OTP."
>
> I did not think it is important to have a kernel configuration for choosing mx25l12833f over mx25l12805d.
>
> Erez
>
>
>
>
>
>>
>>
>> -michael


Return-Path: <linux-kernel+bounces-335897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4B97EC3A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9664CB20797
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00031991B0;
	Mon, 23 Sep 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ59gw2f"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057D19644B;
	Mon, 23 Sep 2024 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097970; cv=none; b=RQOnl8Ejc8QgmmMuJfKJuq310tIodb35ASSmOwahqQ0y5lLVwgARbtI6UMyhSbagiS0FaTb6EZkt9NyVQPbd+G4P1mPjR1iMMvGz7lcrYpOHUZxZJXWg62NV5fjyXNd/v1iHjF4Pb0XO6z8++GQOuyVpmjsjWpD9oAsjj+Qbc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097970; c=relaxed/simple;
	bh=Yf4/nRvCuEzmaiaVcScrGIX1Fqwwbl2EfrCWoGhAWx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kh+EnEy4d2euvcsllot/4xtsfIMtZCmq9MQwdgEK3cOq53Lx2cdp0aoueUPDrjXdpqKqtDinuQj5Ht6177sG+kcdm6BkrmyHMpSTeWXzcLnoIXtnsbklr8+RuavZSt3CiIelB5O3fRtHopMFqjOLTgU74YbTtwxMffwESiapmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZ59gw2f; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c5bca59416so1736958a12.1;
        Mon, 23 Sep 2024 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727097967; x=1727702767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf4/nRvCuEzmaiaVcScrGIX1Fqwwbl2EfrCWoGhAWx8=;
        b=nZ59gw2f5RQ5AFdV5MsNKjZ+sRBVGMWhZHw9etFOoKaKdEX5h0fyYZDG23e2EQmzRp
         RBxBmtNus+WF8k/DWeT7Ct9qeayVIsRiS69fC+fIMn5SCal1v4ZlKCQ2j3DVGZLMBB0D
         1044IunqJtMVIGcElbY5UouZP67Y2f0LkaDzlJ2GNXHyHkQpg8H7b1yjGbnLBfkjyexB
         xQvTlzyKZEZGRCpo4q2vqyk0KazIf7d+RHk/jNO+tr7VIqZ267AyjOUuG3Zrvy2WwQE9
         1pZa9I2cs+sOffAhLjE6+cSEbiutKZkl9pKGDc4HvIWhKd1/v0QsQcS0gN0C7/7mnt5H
         pm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727097967; x=1727702767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf4/nRvCuEzmaiaVcScrGIX1Fqwwbl2EfrCWoGhAWx8=;
        b=MtDRI1v6yXfb8hWGLmJUOtUQiXYLZ0TDrGuUIYvketzO5fyPZvgFojn4uLamJOlG7H
         tP6Gp2rF1U+fZe2dp/hwrY6U5/ZFXiCyfeIrW6756QdgRsu0RDBqARYal5Cw94Z5g9da
         86Vc5YElHbsFgQ+SeyfABRgOS+qBRMKUxaApVywxda1Jz4iK/wIrWWy5Eze3kytReuxy
         CCdpRcry6Mcmq9FGGjqvirvmT/3P4NMMgnPeJj6rgHT+441HdUHdBS6Rn4XtZZHXkfjt
         KUhT9zbvYqkci6PeW7+0u1qSjvjpTIli3qa31PaAgtk5kKlKxJE8Cfn6hOTzhBYEtiup
         3urA==
X-Forwarded-Encrypted: i=1; AJvYcCU8XHJ9KZhorgB0FZ2MBVwPUL4Yn4zjiy4nc34e+wsF9UFp4NATEy8oQTg7m4LJKvD/tfYkIhX/1/Gu@vger.kernel.org, AJvYcCWorGUYHLeoffahUF9dXM5nm/84Px2TU6qIpeRZFYJhlaL8n+a1TxOn1Iz7yWnavSIClCwU3Wp5bNKV1feT@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhHMMh3pN5o115oncGt/vsrPnI2rA9DJP3Rl1KWeUHRK4rSDv
	uOV0LmmfWrbzk+AEzb502tINz14mOfgKzggEksYszSp77HhRY5ISKEumSVZ21ybnuwYg/vpkwHJ
	nfvjneXniWpTv4kWrEUzveutslw==
X-Google-Smtp-Source: AGHT+IFX6LAbjPZNPZbNmSp+ctjB+4B1CfWLMYqjFYMdeclx8ePL73CjwOMiK5uMOzSTV+LApwjbnwaYTbCyXr4+vi8=
X-Received: by 2002:a17:907:9443:b0:a8a:7062:23ef with SMTP id
 a640c23a62f3a-a90d561ffd8mr1198840866b.32.1727097966528; Mon, 23 Sep 2024
 06:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920181231.20542-1-erezgeva@nwtime.org> <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org> <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org>
In-Reply-To: <D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 23 Sep 2024 15:25:29 +0200
Message-ID: <CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Erez Geva <erezgeva@nwtime.org>, 
	linux-mtd@lists.infradead.org, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 12:46, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi,
>
> > I would gladly remove the obsolete mx25l12805d.
>
> Why? I don't see any need for that.

Maybe because we do not want compatibility table?

>
> > > If there isn't any way to distinguish the flashes at runtime (which I
> > > doubt/challenge btw), then as a last resort we introduce a dedicated
> > > compatible for the flash in cause and specify all needed parameters in a
> > > dedicated flash entry. This shall be more generic as further flash
> > > parameters can be statically specified in the dedicated flash entry,
> > > less invasive for dt, and less confusing for people when they decide
> > > whether to use OTP or not. OTP params in device tree is a no-go.
> > >
> > > But again, you have to prove why you can't distinguish the flash at
> > > runtime before introducing a new flash compatible. So don't go this path
> > > before sharing with us what you're trying to achieve.
> >
> > You keep sending me contradictory messages.
> >
> > I told you we can not "guess" OTP settings based on JEDEC ID and
> > SFDP existence.
>
> What are you trying to achieve here? I've told you we are trying
> hard to figure out everything out at runtime. I'd suggest you start
> with one particular device where you want OTP support for. If the
> flash id is already in our database, find a way to distinguish
> between the old and the new one; probably by looking at some SFDP
> parameters. No need for any new compatibility. Don't try to solve the
> problem for all the chips out there.

I start with "Add support for SPI-NOR Macronix OTP".
With one flash chip and move to another one chip.
I never suggested adding multiple.

Yet, after some research I find that all Macronix chips in the last 15
years have SFDP.
So I added a second patch to always read the SFDP of Macronix chips.
Perhaps I should send it separately,as it seems to confuse you.

And no, I do not try to support all chips, just to remove the
restriction that if
Macronix reuses an old chip JEDEC ID, we skip the SFDP of the new
chip, because we have the old chip in the compatibility table,
although there are two distinct chips. They use different model names.
There is no reason to differentiate chips in that way, at least not
with Macronix chips.

>
> Again, the reason why we are trying hard to determine that at
> runtime is that these flashes are usually second source devices and
> a manufacturer might just replace it with a (more or less)
> compatible one. Therefore, the less information we put into the
> devicetree the better. So before you are sending a new version with
> the flash compatibles, you actually have to convince us that there
> is no other way of knowing what kind of flash there is on your
> board except for providing the name by the firmware.

No, reading the SFDP is great.
Except for OTP parameters/configuration.
As there is not way to find OTP parameters using JEDEC ID/SFDP
So as I understand there are only 2 ways to set the OTP parameters:
* Use a compatibility.
* Use dynamic OTP configuration, through DT, sysfs,

Erez


>
> -michael


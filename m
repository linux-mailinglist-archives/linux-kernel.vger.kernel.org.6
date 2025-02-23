Return-Path: <linux-kernel+bounces-527765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D8A40F3B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDD8188B9D8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A14D206F09;
	Sun, 23 Feb 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHG5OOj8"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402CB26AF3;
	Sun, 23 Feb 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320356; cv=none; b=Z4TFvaBsPwboqF8I2wOcnWQGThROEXaLwSPVlASm9fZCZ4bjOWBzHY0oLyK2ELsPNddPELisx9QvwFHAzanDqXSUqoqvvgioVcVL0pUwPjO0Ca5m3LHfCIAw93+eR6plLJvjCy5AUzF0dJ8We16mr54pH1zIZ+1DQ/AuV+QAfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320356; c=relaxed/simple;
	bh=LuZNJruL3UThU6C3fLXq587WB7mNECeN2IMcN7cT0rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8jsSpSoFfa/alD/z1wiPkwpRrahzdax7NqeU0lHJv+n4oURmelX8Jb8k98nAAbmvoY2gpyN7jciHePHkvSINjDWzVNLO9qpvXEULHrAcnxHCpBKYxX3YIzqpFJyzCbQw3OAYB9/fEOymxLBm4E1ABmJVYib7xbc9AVOpvLGLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHG5OOj8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so1747960f8f.2;
        Sun, 23 Feb 2025 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740320352; x=1740925152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnxh1Cm176lLJ2V7DKKw9R4VayIb0E3sW44cPE3xIR8=;
        b=VHG5OOj8Df1BWRlFjvpwTX7zDzFtmrJd7u3bQkXg14zy2YzBRY/p9HKx09PUREe2Xv
         khvgEND6LK/pemdNakowtmhMCIXWFF/PZSRMF44pUQCapBdemi2rcwbM7TXBp9qgKNQH
         J1rZ9e4q1dXDjGJ28XaxUHNHD+5Ebaww0SNBD6DP/kj3ieJyCGDZUpj/o3k/eScPMF6Q
         0JCgB8oGzVdF0ZK3U3uG1gAFQ1ij7JcFXXOtg2pwqRSp9EBfNeCtU2+/VITBAlLj+3zn
         Ft+c06XraUVNDg+CkAkqReyTMEKJjssmAawWnxmh0G+osTx1uwvxlkPP3ltjxMBC7CeW
         2X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740320352; x=1740925152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnxh1Cm176lLJ2V7DKKw9R4VayIb0E3sW44cPE3xIR8=;
        b=dXel2ll1PWXMRBjFOmzF+upl7dAwGeZsAuGgTWshYBId868CReJvFldrRWqv2/aC1V
         xB+PvGwN1lI0CXqXiXRWpwwrZGoeNSDoO2gX5Nde8aGZGGLqHJ5hL3odWs0emgzz2Mvw
         hdDsMosg977XqESKIhGc5f5pdhjb0QVP+KiLLwPObRLZ5gZNGK0oaH0h41+loV5HtzQn
         m7Qu6rJ+ifYNsFRyLEiWielolfaNIjwnPca7iYtImhBtC2zRBkbc14CQDleAy0ZW6lbd
         ddWCqYSUnqOulGo7X1BFffnB8qySdbIDUNB02zFz19FX5QDbAwXb2bO9nJDbFE4H1xiG
         rQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5iRSDQ23c8Rte6oamfBe8W9NEm1Obq0kDCKOG9RzlCYirQAY65h1UJODfgXDbqh6PCH7aTS84BDizZix9@vger.kernel.org, AJvYcCVRNNAkF7PWIP5juHSRi3bvVyBijGBqRULealX+yWyE66X805y8T4NTp5e8XGKpPDnR6pQ6xQKfO+pY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DCn0VhmV4aWJNae7vy3cKBR9T16aaUXKRYJQ0jAdrWIsqQvf
	ww3w+l7uvCHxxytHyYSSKkxgFRLnbTvfKAjq9CtPpo+1GyO2xoPqtk7fUPL7Pg7ggWIG7UKwlPN
	taOAwuqIckMZs5T5L7cW3PHMKeAg=
X-Gm-Gg: ASbGncscaGYak6HihzGdQ+s6FZMcVVmvrLW/6rdDTqh1ssLCwSWAXsFL9h24UUNI2yB
	PAW4ajZAmK9cCKHrwtqvcQhVJbSQUFgyY4Vtb6GQ0pANRtd3jaDkG+nHX+i4MQ587Kh5kmuWzbQ
	OEuxkXuQHC
X-Google-Smtp-Source: AGHT+IG8qLBGBeQq8XnAK7zUoJ+gAUZKnUrwGwfw3w9JHdIDJuCBqeOPp1ldtANXvqMRYy2pjmznSfQYfvqxzRcC1o4=
X-Received: by 2002:a5d:5985:0:b0:38f:4808:b9f with SMTP id
 ffacd0b85a97d-38f7085c617mr8237045f8f.47.1740320352293; Sun, 23 Feb 2025
 06:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219083724.56945-1-clamor95@gmail.com> <20250219083724.56945-2-clamor95@gmail.com>
 <20250223-giga-moose-of-abundance-8e5b9f@krzk-bin> <CAPVz0n1v1BissCuD0DCmQHbr7O_Uymt-ZebXE=37jgjzj7wM0A@mail.gmail.com>
 <dc883484-1557-4c30-b1f2-dc98e9faebde@kernel.org>
In-Reply-To: <dc883484-1557-4c30-b1f2-dc98e9faebde@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 23 Feb 2025 16:19:01 +0200
X-Gm-Features: AWEUYZm231wQDZv7xelIFAwWLdRXnu2BHB0xljENQF-8tSv7p03-xh7b6u4-pTk
Message-ID: <CAPVz0n1PVfXdvLGZMk32C0-d-QwLTsgGbNm3PTzbA03EgJvhYA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: extcon: Document Maxim MAX14526 MUIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:13 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 23/02/2025 12:51, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:38 =
Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On Wed, Feb 19, 2025 at 10:37:23AM +0200, Svyatoslav Ryhel wrote:
> >>> Add bindings for Maxim MAX14526 MicroUSB Integrated Circuit.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>  .../bindings/extcon/maxim,max14526.yaml       | 46 +++++++++++++++++=
++
> >>>  1 file changed, 46 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/extcon/maxim,ma=
x14526.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/extcon/maxim,max14526.=
yaml b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
> >>> new file mode 100644
> >>> index 000000000000..87cf7fd19ee9
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
> >>> @@ -0,0 +1,46 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/extcon/maxim,max14526.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Maxim MAX14526 MicroUSB Integrated Circuit (MUIC)
> >>> +
> >>> +maintainers:
> >>> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: maxim,max14526-muic
> >>
> >> Is it something more than muic? Why different filename than compatible=
?
> >>
> >
> > No it is only MUIC, nothing more. How to adjust it then?
>
> Compatible should be only "maxim,max14526".
>

Fair


> >
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>
> >> This looks incomplete. Missing ports/connector.
> >>
> >
> > It does not support OF graph model. I might look into adding this
>
> You mean driver, but I mean hardware. Hardware is connected to USB
> socket one one side and to USB controller on other. At least, it might
> be more.
>

Yes, I mean driver BUT we are talking not about the extcon itself but
about an abstraction of its connections. Anyway. I can model it in
graph form, but its links do not support graph type of connection
since extcon device class framework provides only getting it by
phandle. Moreover, tegra usb controller supports extcon link only in
form of phandles. How to model this?

> > though it is just a single port.
>
>
>
>
> Best regards,
> Krzysztof


Return-Path: <linux-kernel+bounces-215790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E94909700
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CC11F2224A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A6D1B28D;
	Sat, 15 Jun 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XybUbXtZ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C64179A8;
	Sat, 15 Jun 2024 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718440618; cv=none; b=pTqDd+tutlbzbMhytfET14u28xE22WWGMR87oqOtdd69ygW+52zHSkEpiR9vUTHgg1zfzcbqFtbNMuYywhP5kze1d6rgt7ibgWKBc63xDhDct77ln1+dI/c9EM/tbj1NpOoYo8avryekylBID7GyGsnZxT1vPTBC6YKXpVsEac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718440618; c=relaxed/simple;
	bh=aUXscVapmn0e06rGE9tk+uGF0ocyKrnFMI752XgKepA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJ7n7N95PX1tU1k5tW4N2aYM4SCbeEuM/iqKF6uIHAz3ZlYLw8j5A+JnMxgObYAv5aZ0LaKVjVt0aT6NtsufjE9HK5av70adgLBOj/FXNPLWB+jgO4TxuXfLQ1BNzKg2XNmSCUFpRZKTh5mpfoWUz4liTRzgDkRrbfDwfBRUV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XybUbXtZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so2321292a12.0;
        Sat, 15 Jun 2024 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718440617; x=1719045417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6cauRvhda+JnAgNItfcWCYZCuvzzw7uDiKK0pce0LM=;
        b=XybUbXtZzHj59TZ3Ce+q9md9qOkrdEyS4I6LWqowbethQckicYb4xIpAmv0QJUZM9O
         5a5t2Spj1G8LByJRioqDmW5RuutJJffPIsVlRjX0/0m36I6Sdep+FPKr7sRTesmJgm0r
         Tixwr/thDskFqBOK2RaUoKLStcQJMb9WqKRu2krWCLsQo7/Jx2NOLa2vOG3F8XwMq4vL
         TGQp2dDXLRBflJHYCxW/eat3pg05KFArfVsB6o1XzMTliqB88CcaCSVNrZg7Ci0MpSm9
         srgzxMlluGWQpjixjJz76TvSMwrVK80rvL779uuhN/pgtMcLWGdBxkiQjf0XRpcrKqTD
         aqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718440617; x=1719045417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6cauRvhda+JnAgNItfcWCYZCuvzzw7uDiKK0pce0LM=;
        b=tlPQUzrVHsXmlR0Ix2u9gjXDGr7sEKa+6Rde4xKlE8HrfOaad+636UejyUPSQRdR3F
         bodfiq1RrAgzw6Vb6ja62k0LxMAKtHhbn+gGKP2HEfnGYIhWrCFAuHJcuP+mCQPqZS3u
         Sfyo6g1E61zT0u34V3q2QxQAnPgfHVUA4MQiBlW9MJxMYosvwE6qFEs3a2Z1kkOnxbqT
         uBtWkeWhaMVp1vQA1YyA0KWlvhH46gRIihcBKFsuzZDWga7NfdRFkOkZ5Ger/Piy6zUk
         M1fe5ZYaV7+MEnQ7eFILu4XTyEBp9KFphkKKB++txfdtb9adDrOGGazsYltDQ09+KrWz
         fYGA==
X-Forwarded-Encrypted: i=1; AJvYcCW5iNkNDzL04CCvPZpT0Sxjv6kdPz7wCwIHWcCTjNBrdXA5KMIXRO7KZE7MkUHZ2vzH1ozn/6iFLIqEOgvjvGOB1NmuMhUyq+C4gfcug0+hrvsnIv7lEm4z8++vT4dX0YjfVa3cCGIhzg==
X-Gm-Message-State: AOJu0YyXmxxIk0DGsOeOKEWyxo5DUEqIMkpisHVz8KelZz+HhLmXr/rW
	zW20FvtYrCWE+8jt0uDCvc3v75mYn7n45jz7KRBoK5XW0adNzaE1C6mOxncnhiB65N3bjFVH2Gf
	h87xmlhsFjvgngrfOd9nl7KivgM4=
X-Google-Smtp-Source: AGHT+IHMed/d8CkZg0P/+1OQf0QLEAhLJg4VsE9JGr9ZPMppdYoTbTVwETOWfMQGxLVysh3eo25tlOzsxlMzl4CRAl4=
X-Received: by 2002:a17:902:a5c8:b0:1f8:5185:1cd4 with SMTP id
 d9443c01a7336-1f8627e4305mr49312995ad.33.1718440616531; Sat, 15 Jun 2024
 01:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613085812.4020-2-shresthprasad7@gmail.com>
 <cc66cca1-33db-4f30-afcf-d256a959896b@yandex.com> <9ce15b81-a8bd-4833-b15e-3e6f240dcf03@kernel.org>
 <495e50aa-6819-457d-8503-00440abc97e3@yandex.com> <58e85008-a268-4555-bafb-f948ade16a63@kernel.org>
 <20240613195629.GA2359753-robh@kernel.org>
In-Reply-To: <20240613195629.GA2359753-robh@kernel.org>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Sat, 15 Jun 2024 14:06:45 +0530
Message-ID: <CAE8VWiJr6tTNVmRfxHwYueC6xcNs1sLjw0gASamTaooAmcBnPA@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Johan Jonker <jbx6244@yandex.com>, vkoul@kernel.org, 
	kishon@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	sebastian.reichel@collabora.com, s.hauer@pengutronix.de, 
	cristian.ciocaltea@collabora.com, andy.yan@rock-chips.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 1:26=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Jun 13, 2024 at 02:52:46PM +0200, Krzysztof Kozlowski wrote:
> > On 13/06/2024 12:33, Johan Jonker wrote:
> > >
> > >
> > > On 6/13/24 12:12, Krzysztof Kozlowski wrote:
> > >> On 13/06/2024 11:44, Johan Jonker wrote:
> > >>>> ---
> > >>>
> > >>> Add ack request from phy maintainer here.
> > >>
> > >
> > >> Why? What do you mean for that? Why phy maintainer needs to ack patc=
hes
> > >> he is going to take?
> > >
> > > See my text below:
> > > From my past converting phy documents experience asking was needed to=
 smooths things up ...
> > > Let me know if things have improved.
> > >
> > > grf.yaml can be busy at times. Let Heiko take care of the merge order=
.
> > > Ask for an ack from the phy maintainers in your commit message below =
a "---"
> > >
> > >>
> > >>>
> > >>>> Changes in v3:
> > >>>>     - fix `reg` in example being too long
> > >>>>
> > >>>> Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-ora=
ngepi.dtb`
> > >>>> and `rockchip/rk3399-pinebook-pro.dtb`.
> > >>>>
> > >>>>  .../bindings/phy/rockchip,emmc-phy.yaml       | 79 ++++++++++++++=
+++++
> > >>>>  .../bindings/phy/rockchip-emmc-phy.txt        | 43 ----------
> > >>>>  .../devicetree/bindings/soc/rockchip/grf.yaml |  2 +-
> > >>>>  3 files changed, 80 insertions(+), 44 deletions(-)
> > >>>>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip=
,emmc-phy.yaml
> > >>>>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip=
-emmc-phy.txt
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,emmc-p=
hy.yaml b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
> > >>>> new file mode 100644
> > >>>> index 000000000000..85d74b343991
> > >>>> --- /dev/null
> > >>>> +++ b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
> > >>>> @@ -0,0 +1,79 @@
> > >>>
> > >>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >>>
> > >>> You are converting an existing document, so GPL 2 only.
> > >>
> > >
> > >> Which copyrightable part was copied? This comment is not correct in
> > >> general, because conversions are dual-licensed (there are exceptions=
,
> > >> but that's the generic rule).
> > >
> > > Was told to do so in the past by the maintainers(Rob??) for text
> > > documents conversions.(Can't find exactly were in lore, must be in on=
e my first conversion patches)
> > > If someone was submitting as GPL2 long time ago then the derived/conv=
erted work still hold the same license.
> > > Let me know if the consensus has changed.
> >
> > Consensus did not change but I am no sure if you got it right. It was
> > about copied copyrightable text. Which part was copied here?
>
> It is derived from the text binding, so strictly speaking that's derived
> work. Are descriptions (because that's really all we take) enough to be
> copyrightable? That's another question...
>
> I don't know so I err on the side of keep GPL-2.0-only *only*.
>
> Will anyone ever care? Not likely.
>
> Rob

Just to be safe I'll change the license to GPL-2.0-only then.
Thank you everyone for the feedback, I'll fix everything and resend the pat=
ch.

Regards,
Shresth


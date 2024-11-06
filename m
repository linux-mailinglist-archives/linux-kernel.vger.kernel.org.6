Return-Path: <linux-kernel+bounces-398754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA29BF578
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AB5282978
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18E20823B;
	Wed,  6 Nov 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiaX0aVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E936D;
	Wed,  6 Nov 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918402; cv=none; b=k1K1jirokJkvTHAwSzwnb3hJ+TOcLhQR4kGGxW4ZYi8Eq32D6lF4tWrsWgOGhiuZ4YKGJikTfSTuYmq+UD2VwMDM179TfSymU7EmaUBiiVxXGV2myIfwUNY88OeUBs9aPYC90OLq63NFD8bN3OkDlm1s5aSoi3jgSm72qeVIUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918402; c=relaxed/simple;
	bh=SmGjdX560phYOMnUGNxDLQ5D/ndLDKNLI3vEydTFtCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmtfcVO4ch+z+o0B1GGYgKymvDhzDzL96AbOBcrR2QXRGqpmTNfbWjF2KM34k112HO+XUAvmc9ntI3Y4F6mWzmJAvI2sJ343BHc1y9XzDrAiKQ7hU8nbF7B/xSTK8/qzKADbd41v6wXLSHkXKsCJsYW2+dxUgJWfKjSamSinu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiaX0aVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD89C4CED6;
	Wed,  6 Nov 2024 18:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918402;
	bh=SmGjdX560phYOMnUGNxDLQ5D/ndLDKNLI3vEydTFtCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HiaX0aVmnYDwQi1Mprx35gxtFUh51uKtM3AfDW7o9VCSmYB3XVRFF/M8U7HPXF0vu
	 FAmDvyhuKkGkdhrT3RmsPz55QO/y3EGQCBhtgvtFCa+KjFHdRy/afetwGs1Rw6gSKk
	 r/OIZzxh0BimPBhaOLQUwxuin3luyclt+SAcxs6y9y6GmXff+jhAGImPeQi1VHxV3z
	 pvsb39HX+2U708QRqNamTBvNYqMzGl4dl1H/CcOvkx6PgnKNhMnWxwkpK6yAgpijH/
	 CMipdIGWnj1AbbzP7kpyYau9eqkHOlLDbZDtA0AC6HFXEnj9Zi1L/vsuiIpF8RuL4q
	 JILh5dvYzWqdg==
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so113174276.0;
        Wed, 06 Nov 2024 10:40:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/xqpMEr2ejBNzGlMknv0W2p/I/03IUxCG2fRz6DZADpL3LlQTx42AcmtVQdmDDeaeBb3uQB/jD4RHDXjS@vger.kernel.org, AJvYcCX0AqtF1Atpzxjb7MwRhQezDHA/QVAZSmDywHmwf+6z/+PPavOdY8aWbA/mVYJxVzTsaO1BT3l1xmqS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi74YV9Uy7Psnze/OPFp3fvOhLNQak3QR4Rq/UlgAdDhbcKVXO
	MfqrC1T90oX7Qgp2ZKZ6jf2Nq7NavfpAPoGTsk3t1SMY9qVy3nlaRjhfKomvz9IjT2qEdUUeoM3
	PiyxThqRBQ/1i1/+2quHr1Kq1Dg==
X-Google-Smtp-Source: AGHT+IHqHyWQZr3Kb4+lAVzkmrlMi6Kb562fzbCmjQZmI/dxFlh/J4Eg8RThK7adMjkoNv6+1SjeqeFuuO+ig4Pv6ms=
X-Received: by 2002:a05:6902:15c7:b0:e2e:3431:b754 with SMTP id
 3f1490d57ef6-e3302696128mr18078053276.50.1730918401410; Wed, 06 Nov 2024
 10:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014193528.1896905-2-robh@kernel.org> <87r07p8x12.fsf@BLaptop.bootlin.com>
 <0A5AFF77-D888-4151-9C15-15A408709857@fw-web.de>
In-Reply-To: <0A5AFF77-D888-4151-9C15-15A408709857@fw-web.de>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Nov 2024 12:39:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKfpVVVh6L0PLmieBO3qMFpcDfWFwd+5=qzH_MbeZt31Q@mail.gmail.com>
Message-ID: <CAL_JsqKfpVVVh6L0PLmieBO3qMFpcDfWFwd+5=qzH_MbeZt31Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: Drop undocumented SATA phy names
To: Frank Wunderlich <linux@fw-web.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 12:34=E2=80=AFPM Frank Wunderlich <linux@fw-web.de> =
wrote:
>
> Am 5. November 2024 17:28:57 MEZ schrieb Gregory CLEMENT <gregory.clement=
@bootlin.com>:
> >"Rob Herring (Arm)" <robh@kernel.org> writes:
> >
> >> While "phy-names" is allowed for sata-port nodes, the names used aren'=
t
> >> documented and are incorrect ("sata-phy" is what's documented). The na=
me
> >> for a single entry is fairly useless, so just drop the property.
> >>
> >> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >
> >Applied on mvebu/dt64
> >
> >Thanks,
> >
> >Gregory
> >> ---
> >> Cc: Frank Wunderlich <linux@fw-web.de>
> >>
> >> There's also this 2 year old patch fixing other SATA errors[1] which
> >> was never picked up. :(
> >>
> >> [1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-3-l=
inux@fw-web.de/
>
> Hi
>
> How to deal with my patch pointed by rob?

I believe it will conflict with mine. Can you rebase on top of
mvebu/dt64 and resend it.

Rob


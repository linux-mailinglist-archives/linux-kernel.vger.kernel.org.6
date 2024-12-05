Return-Path: <linux-kernel+bounces-432603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742F9E4D93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E09188129D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC61922D8;
	Thu,  5 Dec 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0Lxr09E"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8483EAC5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733379743; cv=none; b=rkwKiSo3i6SxrRg/yPfdkpjq0ysh8fKcSUnAIgxFPBffO0XwM0ICqOi3ii9PjLGxDQJc5WmjU1knK/0Bf9hNWmOkj3kySAkxHRzUUfA+rt5s4QZKoLBazD1ExYWslZ/q7JWYx15DrbUiSCy4O8c1vATIvJD6qbPdPvFjUsJErhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733379743; c=relaxed/simple;
	bh=635HXEH9z9+euuYtdUWAXhck3oezPbylgKy1CXvtRrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9qpxtijBw/HKXymGZLld3dNMSeS7e+1v08e/BEeSt4RjIH/ruyMSWRCqJ0YOaC4l+1TRZoHQ5QqvgbV93fSYA4GLtxDlro3VyrosDxkXAF/yW1ZoWCjYmASIpEcxPC8vTrTQ6cWZGzllBA0CrKoeW5dtcPLN4pKpnydC7YkMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F0Lxr09E; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385d6e36de7so473172f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 22:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733379740; x=1733984540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=635HXEH9z9+euuYtdUWAXhck3oezPbylgKy1CXvtRrE=;
        b=F0Lxr09Eak/GQOOtKyld0TH0mqp9lKCKMeFYoQy5C38t/jyhTIfeqOqlCPDyxW2idp
         cV5prbbduYU9eMw5+en+nvAC384BJX83WxO5uM+ycbQc7HOs1bthBHKKFiBzN54Ym+9a
         stqvPQ/mP+M4Aa1FDarvd9cOuLF8ncFDRcqi4nWcou9o3JYITTVRy4eQiV9pZcHl23dg
         hsaOBu01gHSTJ1fhokbY8n7WUcMnsQRMrO8+MUgL3szPivTnn0IbbwAxrG5h/u7hIn6j
         ZiRiEsKg74IfhxnJ1B0MBeK5HmvC/J3zOOKyITXdJaaDgrKYRRqN8NInvIkDqTJ8b3O0
         r+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733379740; x=1733984540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=635HXEH9z9+euuYtdUWAXhck3oezPbylgKy1CXvtRrE=;
        b=pHXBqdJYSbiIcyaZ/tKAXQsTfQRMJ0M3QMCwIx+vR6akexODU3Z1jVt5Qah0b3+nTg
         tosdRHKp46hDV9joLy38Pl6+BEUGTzaM5qkUCt8N5OeRWq7OtoZ+Q5Y4jWXL9MXKQ+Qd
         P3b7WiJmDMSyoCzdM5yg9yfyjXQsVDmzUUnL+9FZZVMj8+UfYF+LtfxCKbBIwTnm7d5E
         Hnaz6soHJRXyTOeIG0TEGTEfPzajU0IX3fz/j5igYJziJaC2R4RmzT3jnxRehfGgr5xs
         PJOf24JArpD3TGgBiIyzmRYmZY2aV0OM2bOF4IhUk/Hu/96g9r7rdKHiJByRdCaOP82X
         64Yg==
X-Forwarded-Encrypted: i=1; AJvYcCX+mHP6yROz77jH1flOo8qL/nR25fvwZ3yaTd1BolQaYzMePZQIhiPshx/gsvCnMHkRejzBNPk1d8tmQFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMs+P/CXlQ9q2Ku8M7/deUYeTYRYJ9CSN0xcUhWdwjhTFTi6g
	tRMNtcATGypJQmQ26mUu6gmdC+U692oY3gn/iblP2eBvmT9k8E0nraGnQI47deg=
X-Gm-Gg: ASbGncsUFY58rPLopX+FSDriNQgIf8e66mxlIeazHXbtZIlpGnijkFFl3QfrGEIXMnO
	jj+F+t3NcHRVDY4jIWzX9+J/FSrkQipRZY2c6eTbkRwFly/tD3tKuIx/x5yMhx0K5hfQd+X1bX7
	fYkItYk2TliGHV0sM413/m7MTlBn4x9VwCZLew4cCU6GQ67HxVA+o+zUk+lL8P6MRGzXbnXTTcm
	qVBHCDbxIRNzb5bB2B9RE84OH/UMJb0JMMV+cojPZGXj5EKgB978A==
X-Google-Smtp-Source: AGHT+IGp/jNJTmdaFQ6E6rKRxd5mOl5DWkdNmDAnwmLFHgFS6wCHCx0RvANhN0Zro7KAfaQqmMGFCA==
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr9424928f8f.56.1733379739965;
        Wed, 04 Dec 2024 22:22:19 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52732casm49399175e9.13.2024.12.04.22.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 22:22:19 -0800 (PST)
Message-ID: <2a20b243ade39fa240f75baf22a13f02239e3411.camel@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor
 and don't require nvme address
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Antoine <t.antoine@uclouvain.be>, Sebastian Reichel
 <sre@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Dimitri Fedrau
 <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>,  Peter Griffin <peter.griffin@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Thu, 05 Dec 2024 06:22:18 +0000
In-Reply-To: <5281f86d-6917-4f4e-b85d-70502a24c5bd@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
	 <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
	 <e23721ebd766f410103ddfb8705f3d7d6e5ae3e9.camel@linaro.org>
	 <575b3275-b2fa-4e5c-bb6b-759394b02e18@uclouvain.be>
	 <30b0995903fb7db3f866d1304783d878f563fe2f.camel@linaro.org>
	 <5281f86d-6917-4f4e-b85d-70502a24c5bd@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-04 at 14:13 +0100, Thomas Antoine wrote:
> On 12/3/24 11:40, Andr=C3=A9 Draszik wrote:
> > On Tue, 2024-12-03 at 11:23 +0100, Thomas Antoine wrote:
> > > On 12/3/24 08:12, Andr=C3=A9 Draszik wrote:
> > > > On Mon, 2024-12-02 at 14:07 +0100, Thomas Antoine via B4 Relay wrot=
e:
> > > > > From: Thomas Antoine <t.antoine@uclouvain.be>
> > > > >=20
> > > > > As the Maxim max77759 fuel gauge has no non-volatile memory slave=
 address,
> > > > > make it non-obligatory. Except for this, the max77759 seems to be=
have the
> > > > > same as the max1720x.
> > > >=20
> > > > What about the battery characterization tables? Aren't they needed =
for
> > > > correct reporting?

[...]

> >=20
> I looked into it. The probe function launches a delay work
> max1720x_model_work which will try multiple times to run
> max1720x_model_load which leads to
> max_m5_load_gauge_model -> max_m5_update_custom_model
>=20
> This last function writes 0x0059 to 0x62 and 0x00c4 to 0x63 which unlocks
> the addresses from 0x80 to 0xaf.

OK. The regmap I had proposed was excluding those based on the
datasheet I have, but you probably noticed.

[...]

> If it is indeed the case and that all of those are equivalent to their
> max1720x counterpart, I think the management of those values should be
> added in another patch which implements it for both the max1720x (and pos=
sibly the
> max77759) as the mainline driver does not do anything with those values
> currently.

Thanks for the analysis! And yes, I agree.

Adding new required properties to a DT binding is an ABI break,
therefore I was trying to ensure the binding is complete from
the start.

Cheers,
Andre'



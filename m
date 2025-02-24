Return-Path: <linux-kernel+bounces-529044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED19A41F28
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B13A1886DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EBE23371F;
	Mon, 24 Feb 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib0qfIDe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A818B46C;
	Mon, 24 Feb 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400374; cv=none; b=ZxpFPfpIcFC2g9M6N7lvKsRQo4IKUBqdeqXSeLlAKIWnI4W9efpmDmTEwwyWChaQ7e2z6iGP5GND8DwFZ6qUzr6G2P+8BJwH1VtLNf+sCc6JMDo+b3pQyZC3gRvwHAyJOqW2K7O9lccbJLfN3UfupzpDfjDCKSTI65tZdvJAFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400374; c=relaxed/simple;
	bh=UQ+8Z+wAgnnwuuJhQbev2mb59lIpjo0E70e/qGy4/4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL0beXms9LV5HGxC3zl5sa3isuvEQhJ0t0lfvgRnhTZv0IZRIodyPZiWWU4sOFJCm4k8neAVGivKhkFoECGHLwFOTuTkM0J/tlmdm7v7/DsOYxKLJF0d5KzfCEXWUfTJVDnK3lHPvaL9ZdXrroBc52+6cnc1nKQIPphFJB3bs4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib0qfIDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464ECC4CEE6;
	Mon, 24 Feb 2025 12:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400374;
	bh=UQ+8Z+wAgnnwuuJhQbev2mb59lIpjo0E70e/qGy4/4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ib0qfIDe3OOuvBzVrWCmmLH460v2SIM6VasAJBujRptEfcHm3PqnGr7L9iVznDLEF
	 3jNDpzbqBYg1+hoZ8Xhg3A20IB0NkMmJRhRBqTGpMrvie/hKD1TIUYcrFsQssqKrCi
	 +3HcpOCVVKvyD9locSrHHN4yFMfWolOe48dyWPFs0f09Do1J6BFwD78Afcsu3CizX3
	 xCYWkxxBfNhrCkXtgO/HSCmCznepYHTU50RX/yS89U/2YFOLD74r8t9QfElzkxzqpV
	 g2Vk4IOfwL3b95IJIGFR6Y+Hh1z8EciEw5scW+Se1SwnB/boOa0hAOrfCier3qkCSR
	 g5Mj9jQaPVc8g==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb892fe379so689579466b.0;
        Mon, 24 Feb 2025 04:32:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2agcYkkVW6qtHrnoAYU92N4kjf3CP0sQ03ebmBOFcYNz1vT21N5isNsSoCo/vNu3bAVzBf4FqDZCA@vger.kernel.org, AJvYcCWrVRaA1uxMlaVCD/DjXeVTlvhLxXWHWoodkyeZ2tfnoO1ZKnYwkZFc7Xm7KH9MeDnn1kF7x+Wu9B+7svmV@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGZa5G424vyHAFoCjO39Cg4OZEw/H5K+M6fyk9ZGbx9bsPsMy
	ecyphmg9Y/4DlOrPLIBMKXUAfRXcNqvRXnAcRCycPG2Gkar40aASkPv4UJ+kmtuFHsS2r/JuMkD
	938hAt+SU4oSEQC9fC7fpO1xhNA==
X-Google-Smtp-Source: AGHT+IHL3KrJSkqIVBufq5WKDsEAyCjHw9G4sSu2AxzVPr1GREze63H6Wcwa6uRBFUk5VisJGiZga96347ickz870Fs=
X-Received: by 2002:a05:6402:26d2:b0:5dc:80ba:dda1 with SMTP id
 4fb4d7f45d1cf-5e0b70df049mr27708183a12.9.1740400372901; Mon, 24 Feb 2025
 04:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224114648.1606184-1-vincenzo.frascino@arm.com> <20250224114648.1606184-4-vincenzo.frascino@arm.com>
In-Reply-To: <20250224114648.1606184-4-vincenzo.frascino@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Feb 2025 06:32:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJGHnZpJ_rLEj3Q_wwXB4Esh6roUwgcen5dd3SY6BMoMQ@mail.gmail.com>
X-Gm-Features: AWEUYZkblcUi0AUvyNMYBv_8CKhFt0PJZbd08-zFgoDnv6Yjm9EHCszL8R47ptU
Message-ID: <CAL_JsqJGHnZpJ_rLEj3Q_wwXB4Esh6roUwgcen5dd3SY6BMoMQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ASoC: dt-bindings: xlnx,spdif: Convert to json-schema
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-sound@vger.kernel.org, 
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 5:47=E2=80=AFAM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Convert the Xilinx SPDIF 2.0 device tree binding documentation to
> json-schema.

All the same issues here.

> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 ------
>  .../devicetree/bindings/sound/xlnx,spdif.yaml | 92 +++++++++++++++++++
>  2 files changed, 92 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.tx=
t
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.ya=
ml


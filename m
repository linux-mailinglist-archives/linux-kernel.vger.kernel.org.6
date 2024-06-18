Return-Path: <linux-kernel+bounces-219036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740B690C916
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FE6284985
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CD77A03;
	Tue, 18 Jun 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3Gw0NZX"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A97172F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705574; cv=none; b=V+UpjVxMMwLjUdYkxUxB+gziXLmQB7EVXILafmAQwzkbIDHGcx5oHDiOu1wRWrflEGx6LUEdBkAg2HeQLCwR77VUbv4r1qyVoV//tFgl1vCBmtCgR/YQUbxwyaZOF/Fy7l1oyWYkay2UOiGGoNfqm6nuNYyR5QtxfXl04IpGVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705574; c=relaxed/simple;
	bh=6mJGdO91RXcGUUmpTMS5iulnchhEDhRErBL2SBn7y1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBnQAIDLegVA5ErlmjqkVF7j2BnOg6x9gIISZovFRpGOL/gzF26ZleQzqQGafo63legnyUO8grfkPjq4wPWPoU3PVHyPLJprOrWeLq24I8JS5/ilIQzlY5YeqCvWgbqym/B591RNanLlOSTln466OwUfMNkeDs2JLb2iJqs5qe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v3Gw0NZX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5295e488248so5785850e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718705569; x=1719310369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mJGdO91RXcGUUmpTMS5iulnchhEDhRErBL2SBn7y1Y=;
        b=v3Gw0NZXO1jsVwmU74+EYrvst9h0EqYrhmWX5XckwBNSX8bEpBKScxgslTCZj7dG0v
         u1dHJZmM54Jk0gqL14R5aibdDgOj+Sq1dVwI/3DtNB3LgbqoAJnUM8YoHR57FkhrIgAV
         3aeuzBrTav4PW02t7xL9LqU71plj1zZ8kaxnUL0JIbgvckbK7WBWkwmDaH+mD+1Q5rSf
         xAiIIraUqzUuqbp6CutiWzQVHkZgC0WARo3r011HZMsjkduFGO9pVCwE3B74mCedffKH
         pMLq06RiKXPkW7h+Gr6LbY/KKxfMfLW++jhbL/aIv2QyAVyPVxRxeXD7dCz2ABC29Cwu
         ZCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705569; x=1719310369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mJGdO91RXcGUUmpTMS5iulnchhEDhRErBL2SBn7y1Y=;
        b=F85Y1gax8558kvWtUbGn80T4nnIn9BopZ74OlYDiCenX3XZr4xay1tL7qPr3NBZYiv
         R/A01JO7JX/nsMoliGIEl0fRebMip+e6xN9Wqz9CnTSz7FxCxMMDBjK82viU3XAMIwEU
         vLS8KmDbh2Q/zVab9Vsd4Hwn6gjMs2OtcTXg3/Q4HT+qufpRNC809p9TtM/nH6SOa5eQ
         WjE6lRLUqbErCX1ExSHS42cwTl0b9buwzCR3kvW4cyHxR0/TUPalzQrEBpZVKcnu7TuJ
         V+VCcdJEZtP+LnKQRmuP+WdyYzfsVKcZjya8eQrH4iEommr5sdpp8SanppC+gxnG0xPn
         ABFg==
X-Forwarded-Encrypted: i=1; AJvYcCURy8Ts2qm366Y9rn/2gH/21jdGazuQTsvUw7FaYCc7fk5kndm1M6+hbgLWcALBsZb2pvE4nguB0m1/a/5zOYeqagHO+tMK10IFjI78
X-Gm-Message-State: AOJu0Yw269oImy3954/222UQR2hIAtjQgOFSM3VtJXQ/jUZsqKphYQ8a
	P+HSMayTe3TITxSUNmrG6EvNopB32FW4uu+xr9ssDVtjbr11WU/RD+THlbjh05Kyq0KI3WJAzD1
	tqXhaHHJK8hrJ1tvTbTe0p7ntMdivw4LDSDZbww==
X-Google-Smtp-Source: AGHT+IEKxSYIL7tUGgByZhiLAFjBAQVY6s4nNE+5nGraekK5gKASUp0MAAKFzLc/2g9E9O4NH5x6/Qwg+Tbi7p1WJE4=
X-Received: by 2002:a05:6512:ad2:b0:52c:9468:c991 with SMTP id
 2adb3069b0e04-52ca6e55dfbmr8037884e87.14.1718705569563; Tue, 18 Jun 2024
 03:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-pinctrl-scmi-imx95-v1-0-9a1175d735fd@nxp.com>
 <CACRpkdbpL=HUXj0hFAo+JNki_RA9aix2sW1cg13g9=89d93PZw@mail.gmail.com> <AM6PR04MB5941328E3343E5263C87528D88C12@AM6PR04MB5941.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB5941328E3343E5263C87528D88C12@AM6PR04MB5941.eurprd04.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2024 12:12:37 +0200
Message-ID: <CACRpkdYprmc2vm8fVHBSYD+LtJavZ1tj7uQyTeVGkSv88RYF=Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: scmi: support i.MX95 OEM extensions with
 fsl,pins property
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Aisheng Dong <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:30=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:

> Just checked your repo in git.kernel.org, not see the patches.
> No big deal, just wonder if they got forgotten.

I had to figure out some bureaucracy around the git branches, it should
be there now.

Yours,
Linus Walleij


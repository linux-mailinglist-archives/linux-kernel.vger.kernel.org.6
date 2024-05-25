Return-Path: <linux-kernel+bounces-189301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFCC8CEE26
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 09:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA651281CB8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 07:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0D17996;
	Sat, 25 May 2024 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d/QKjmuN"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A4101F4;
	Sat, 25 May 2024 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716622065; cv=none; b=nULokn2ZUU0czvwGXDUWSSvzZQ2PQBn5hQoOfbvn251fj/7yhvfPqDDCC1DgVFACCgiGDmiOmJOuhRgNR8W4oxzjUKV5MTqORaEOBMgGQ8cxVFqKS85O6xZ2wvr3lXoSr0JgSR3EoWhvB/Z9Nmr6gIIoJI7TjJDQC3HYxYjSHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716622065; c=relaxed/simple;
	bh=1vV2rcZq7Yv8cvgatVorPcVsxAzQmPjkjKoLUVSD/9s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ed6/Dl8Nzuxe+qlXjU7q1ot4ksgvd5+pQ9/N+mIpAaZBxxLZQ+amFrg1Ws/PocXqoZyWdOhJ8+tQQ6Rmv4gAnwqiegTAyrJvn5Qc6dzn17M+b+KKTVeteTNv1tzAKTAUrmav5H3TEJgMDuZHUWcoAU1pW2Rth8kIuAXNS9EWizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d/QKjmuN; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716622028; x=1717226828; i=markus.elfring@web.de;
	bh=6INwEjwgOCmGgOy8ZeWOLJOHl6t8dOZTr0bTagI6Hpo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d/QKjmuNUNl6skSonlt7xy84QrYC/aZ0HCBqQG4gmpdqxUSK84BhZD1yhSfvSlU+
	 O64klxkS96ENhWSFFe7YZ4ONRBSLXxjG6ofmL/mMKMwWy4cBOA0ShKgoxbkCV1JK6
	 OhqSbau51ESD5fyaVUrMmUZa3znhsRCECtrfDfDtlDzVw8dbHCrtsDpHzjvC0SPaN
	 YdDIKSeceeeJRpIgSlkAgdS9PxX3t/OOmoSAoDTtDxApVeSidrISVtBDLWPUkvphY
	 tZZCoInsRQXcRK1+2KWKXiec23+QW0LhgyPbCYgiEDsV8qOy7cuF24UPHOv9jQ7Bj
	 rlizL3NhTPz/meEUow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMGyA-1rutLe2qpi-00JTf8; Sat, 25
 May 2024 09:27:08 +0200
Message-ID: <4c53b063-ad12-405d-b088-9b992284ba08@web.de>
Date: Sat, 25 May 2024 09:26:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org, imx@lists.linux.dev,
 Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sascha Hauer
 <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de,
 Shengjiu Wang <shengjiu.wang@gmail.com>
References: <1716458390-20120-3-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v5 2/5] clk: imx: clk-audiomix: Add reset controller
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1716458390-20120-3-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7xxTsM6Kf1mc/B2+VvsoIat3BsnLAt64foHiT/NelZ+ffJkbhTB
 jRZhxyhS/V83g6c87aCUT7I6AaL9YMRyuQb+mjx7nHxlo1ILCOYgD5SkAPBH5K236dRojH8
 DkLl0DLpgSDFicN/cR1Ou/JiQTCBCjOMtLzDjg4za1pLhDiuIPtheIBUamPhP4+9qKACOs/
 bEEQNF+ZAvhtPwcLVSO6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UOryPKNMsTk=;uYxEyA1BlH+rnEbdOgIk74ncs0l
 M6cbmCB5kSEPC2OR55JRYwah+nhOnwB6z8Fr5WvrcLlUHtV6S0edcGimlqIVtuDxp89HHtOOW
 WfrSntW2IVbigwWt244GTuRRf9zQTmdL5A1H7IVnNhGfhupT5MlEzQ74Wc6uRowrM1w5rXCN5
 0HwhhCDJ+mj6UDnUY6NrGD+zof3NzOmzKZd3FaGctVxBmhbmimlHEpJYNLRc0DyFUoJpy6T0i
 Bpt2zFT82/TzCHWETZmecYCSQERCyOn77TMWe3X42WDb8MKp7YlwNEw/NcTjJ8tUnmaDmJTGV
 M+BnC/hZsblGTY3xcYQJ+K2aIWie/J8MmqjfhN+eX+MyGBejnXmkgWu5Xxn0NApsAimdh54Lk
 ozxurWtoqjMydj7PzVZ5anpl/4f2msb+szhJGD+LYp4Qbge23NIb2NmJMDvB2v+YIDKqWIqco
 ju528YTrrTUhIcWVXaxSSwhPeXCZTeYM9dq88bcahk27mzEjkoYJ0CMeQHL35K2BioaSLeBr0
 OX2Rf7LJv7+YkUmtL5rK3uuFactKgZT5oV8Fta+F0MMbfs/YoToXDY6VNvgtwvMtHKeCWZb8R
 N3HpW9mbiMUgyzw7p2yO85rOD09HT521s5yB9iknZavcZ5bOQr4mWnYFCIzfZ3a9lrcjJnssd
 Aw/H3r1yNyPsp+94J9KZwPh5FFgUDphqqlHj0vLRzlvt1sGQWWfY/13glClPpNscJe0blf2SO
 O14rVbN+L62Kmq9DsNfuO0kU651ZiCY6o1mXaTCopjTKizw4h3wLvIzkYseUAstv9bIREnhzD
 ORo7QH9ejyKjr0vo74zMw6ZEDT2pgYYo4CEgqsZLnXffc=

=E2=80=A6
> The reset controller is supported by the auxiliary device
> framework.

Would you like to add an imperative wording for an improved change descrip=
tion?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94


=E2=80=A6
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
=E2=80=A6
> +static int clk_imx8mp_audiomix_reset_controller_register(struct device =
*dev,
> +							 struct clk_imx8mp_audiomix_priv *priv)
> +{
> +	struct auxiliary_device __free(kfree) * adev =3D NULL;
> +	int ret;
> +
> +	adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
=E2=80=A6

May the following source code variant be applied here?

	int ret;
	struct auxiliary_device __free(kfree) *adev =3D kzalloc(sizeof(*adev), GF=
P_KERNEL);


Regards,
Markus


Return-Path: <linux-kernel+bounces-226895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A5E914559
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E87E1F22DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFAE12BF1B;
	Mon, 24 Jun 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="ZF75jHtR"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B394461FF9;
	Mon, 24 Jun 2024 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219112; cv=none; b=TKrEzxLAVb8mLAkvG7OAXPPDbDXv1tR+wxtwkvTupA57OHRSvnjQ1IrUiLB8HqMxnquHSe7hkoaRTtgp2pKJeXbEHlomfUMtgOI7SqBn3Y4w+1k1n1EBacs5uh5QnQ4vxkQr8G0qdxxHgci4AoIoHjhLKofEsJ5OMUQwFdr3jcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219112; c=relaxed/simple;
	bh=uQyn0xy29YFUanE0wG8ZI/is3ZrZ9f3UQZpwTIzoISM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=X13xuAWxmxe/NoR+SnAzJ7cb1A88ztomGEZQQDceKR2krYwDTlnjSZZfMM19UHh/tn4nn5L7+8cmqg+CGQXonm2jnwx17E3gbau5GUZ1mrg1JuhDaCIIRfIUYUnTjJNj9WDGvs+3jIE1x6m/ksJBBvyKAVpKwdr6PE1UWrIaADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=ZF75jHtR; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B13679C5B22;
	Mon, 24 Jun 2024 04:51:48 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Yay1jmjOC1gx; Mon, 24 Jun 2024 04:51:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 124E39C5B37;
	Mon, 24 Jun 2024 04:51:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 124E39C5B37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719219108; bh=+ewUDykI/UOo/DB+dq3CVz3C8NuvvWDy733CasIbz4A=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=ZF75jHtRyN/E+RU5Ga21+MkO2BXXJSV6H2W+pCjcTgNujcFmOIXVqY7JjqZ9vwvFO
	 M6t28Bvegah97B/e3A6ci9Tuz9FC4Fz45HTdnASJQ/UYgSECWsk9QNtKhyKmXi67QN
	 ZGHHMYMKF84OOipXbCu5stuV+2k9KLWMFKXFrRTaat2k1Py1ktCbIZ+pyBdx5RFFCf
	 r4q/lCcpIdaPfshIVVcj+KE4UhRPzv3wjWC9dxMMu4bhDseYxbJ3EdkjIpRg4jMJMI
	 m+W7Cp2+7l7erRK0wqedzzhmDLFHVkqSE+wtSjyWoEQzpPzEufpPSXy1x8m4ZTGK6b
	 B8k0VV056KtmA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id m5StIy1xy9No; Mon, 24 Jun 2024 04:51:47 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CA5529C5B22;
	Mon, 24 Jun 2024 04:51:47 -0400 (EDT)
Date: Mon, 24 Jun 2024 04:51:47 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, 
	shengjiu wang <shengjiu.wang@gmail.com>, 
	Xiubo Lee <Xiubo.Lee@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, imx <imx@lists.linux.dev>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.com>
Message-ID: <1566099232.1714447.1719219107779.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <17a0efe3-72fa-4d13-b3b0-90e6640308f3@kernel.org>
References: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com> <20240620132511.4291-8-elinor.montmasson@savoirfairelinux.com> <17a0efe3-72fa-4d13-b3b0-90e6640308f3@kernel.org>
Subject: Re: [PATCHv5 7/9] ASoC: dt-bindings: imx-audio-spdif: remove
 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: ASoC: dt-bindings: imx-audio-spdif: remove binding
Thread-Index: SJweIeCS/c+5zCPba7GA4ZNFgX6eoA==

From: "Krzysztof Kozlowski" <krzk@kernel.org>
Sent: Sunday, 23 June, 2024 13:09:33
> On 20/06/2024 15:25, Elinor Montmasson wrote:
>> imx-audio-spdif was merged into the fsl-asoc-card driver, and therefore
>> removed.
> 
> So what happens with all existing users (e.g. DTS)? They become
> invalid/not supported?


Next commits, 8/9 and 9/9, update all DTS files that currently use
the "fsl,imx-audio-spdif" compatible.
From the users point of view, currently configured spdif audio cards
will behave just the same.


> After quick look, I do not see backwards compatibility in the driver and
> above commit msg tells me nothing about ABI break.


For the next version I will state in this commit message the upcoming modifications to DTS
and compatibility, why it will be done, and that support for existing DTS is not dropped.

Previous `imx-spdif` driver used the dummy codec instead of
using declared spdif codecs. It was discussed in previous version of this contribution
that using the dummy codec isn't good practice. So one to one backward compatibility
isn't really possible.


Best regards,
Elinor Montmasson


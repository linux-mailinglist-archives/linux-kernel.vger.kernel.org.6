Return-Path: <linux-kernel+bounces-226936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3296A91460E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C90286CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A01304BF;
	Mon, 24 Jun 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="dQMmv2nS"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116E18E29;
	Mon, 24 Jun 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220724; cv=none; b=bRY0x6KCovi4Oy1L7jW17dkuXGAWvOoHmAHU1nUdrlDVmJOERR6Uu0B7I7zuLBdbQJvahIQQE9+39Z8PLjV1BAe5Jdc0N0xBmCAQjVAd6gyVtm2EjRMMtt6r+GZsK8agT8dZz0EVnL0D4CS1oBtnHbdrZ3eV8xQgmwrQlzITk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220724; c=relaxed/simple;
	bh=8z0Me58ofAkCeMYK+RbmJRN1l1eSvoaq0OwoETOXuEI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZnG3uKj+9SbIjBAkqgVIA3u/5/TkvGMnzh+cWslOIcOXg8spGjrsbb17HY8cLCrYJQJ6c7+Cyo4ahVq4h6K/+kDlJ+oX6zgTbKm5dR00FiJLSJblcEcoxZwih0JLqJpzu5/IxJTRmWwuTHlx8gYMn+P8Hsm6uZyJOZF3rn/c3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=dQMmv2nS; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B63739C3240;
	Mon, 24 Jun 2024 05:18:39 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id HR5yBegFxqJ5; Mon, 24 Jun 2024 05:18:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 492A09C5B61;
	Mon, 24 Jun 2024 05:18:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 492A09C5B61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719220718; bh=4JOrFwNYAzMjJc3yCOi7qIx5d2JoABbFOVFqt1WuodE=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=dQMmv2nSrtJBDMOLXfbnYdr0xEsQ+JPCN2ISsqaHfK0rFiK0iVxB7g3L69NRikKSF
	 tFs9D3pn8s8IrJT0B8gBXrghZesBG0biCOcu54hq0wciU5P0mB0DqJzghiLCD4GHdP
	 AMp+VJD/fXUB64TKqeZowTL1e2NWWAuHvxalaXKz4yMRxBqj6XRpaaeL019JzRMbrc
	 Xt8NUIaDhSAFLqFQU9ufuJqullhXIzBF96BK6f0WwRh5+a+5XdxVEesD20tbVhIBld
	 Lafq1lysngw69xaWD5/bUlPMWd5pYLunOPrmkZ7Vg8a9GBKgukkSz1IH2wvpn6Cm74
	 c6Y3zVSYLCvIA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id VquOXrQmnN-2; Mon, 24 Jun 2024 05:18:38 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E46679C3240;
	Mon, 24 Jun 2024 05:18:37 -0400 (EDT)
Date: Mon, 24 Jun 2024 05:18:37 -0400 (EDT)
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
Message-ID: <1048207382.1714780.1719220717882.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <42b32958-89ee-43b6-96d1-f3e18c7d8955@kernel.org>
References: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com> <20240620132511.4291-8-elinor.montmasson@savoirfairelinux.com> <17a0efe3-72fa-4d13-b3b0-90e6640308f3@kernel.org> <1566099232.1714447.1719219107779.JavaMail.zimbra@savoirfairelinux.com> <42b32958-89ee-43b6-96d1-f3e18c7d8955@kernel.org>
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
Thread-Index: ewOgNpthlCv+G0hUX/mmtwgvLix7HA==

From: "Krzysztof Kozlowski" <krzk@kernel.org>
Sent: Monday, 24 June, 2024 10:55:31
> On 24/06/2024 10:51, Elinor Montmasson wrote:
>> From: "Krzysztof Kozlowski" <krzk@kernel.org>
>> Sent: Sunday, 23 June, 2024 13:09:33
>>> On 20/06/2024 15:25, Elinor Montmasson wrote:
>>>> imx-audio-spdif was merged into the fsl-asoc-card driver, and therefore
>>>> removed.
>>>
>>> So what happens with all existing users (e.g. DTS)? They become
>>> invalid/not supported?
>> 
>> 
>> Next commits, 8/9 and 9/9, update all DTS files that currently use
>> the "fsl,imx-audio-spdif" compatible.
> 
> You mean in-tree. I mean all users, in- and out-of-tree. Other projects.

Oh you're right

>> From the users point of view, currently configured spdif audio cards
>> will behave just the same.
>> 
>> 
>>> After quick look, I do not see backwards compatibility in the driver and
>>> above commit msg tells me nothing about ABI break.
>> 
>> 
>> For the next version I will state in this commit message the upcoming
>> modifications to DTS
>> and compatibility, why it will be done, and that support for existing DTS is not
>> dropped.
>> 
>> Previous `imx-spdif` driver used the dummy codec instead of
>> using declared spdif codecs. It was discussed in previous version of this
>> contribution
>> that using the dummy codec isn't good practice. So one to one backward
>> compatibility
>> isn't really possible.
> 
> Heh, that's not good. This is improvement, cleanup. While it is
> important and useful, it should also not break existing users.


Should I introduce then the use of the dummy codec in `fsl-asoc-card` to
assure backward compatibility at least for a time ?
With maybe warning messages in code to indicate that spdif codecs drivers
should be declared and used in the future ?


Best regards,
Elinor Montmasson


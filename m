Return-Path: <linux-kernel+bounces-226897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BF291455E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E19B23B15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8A54D5A0;
	Mon, 24 Jun 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Lb/JDqYv"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFC130495;
	Mon, 24 Jun 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219118; cv=none; b=tcPK4XrXKt/3J9z1uitPPnkU/aovxZVOtew1RRh0Bszc4bx0EPteDlwNacLh3vEvA1Dq+i2vHd0tNX8oHwiQqMpUNhAYwVFFLiMkRJZzOT1EhNJnasOz6t4GF926GBeXDxw9/3ke0HAwOn0/mhH9PW3fj7huC7NRSC1q7T2z+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219118; c=relaxed/simple;
	bh=tbtZYVbQLro8sFxxPVvhwFiL36HLsgTQevnhEb2DJJc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HkIBAxF8ygK4omvIJtPQ6ENypGN4uWmrbXEhAFsTqXlOLJqzdWvvJSyCKHYhef9LHvQ/OOO4oX5nmasrt1G76KNc+S7XP8+B2j2mLdBEJ3Md+LDrCQJKre6RavmcFqtKtymikJbQvh9ZWJ2awfRh9/s9EOaCaRItPcC/MoR9UDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Lb/JDqYv; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A16229C5B37;
	Mon, 24 Jun 2024 04:51:56 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1bgfUhXbQxyf; Mon, 24 Jun 2024 04:51:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 12A3E9C0760;
	Mon, 24 Jun 2024 04:51:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 12A3E9C0760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719219116; bh=ywUot3rVde8QyC4XFzB69VkfFZ81TabakSY7pKOGwNI=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Lb/JDqYvbCLOxwHnIAGfWllK8kIIRjuyG8PuIPzCh1ronj7Exjf3inbdEeyFSMJxT
	 M1nnT5HyczGirf+cvKnulquvAgW6pOcmEkt/VI0W3lVYe6qhNYmAH2aHuoRQViLaag
	 f21KX2A7RMc+uoZTixi1gMnHxKh+xvQ8Tme5n11IzQSxN3axsXCXOIrvM+R8OsswRI
	 t1j8EVj0Tx+x5OFtnLHH08HckNFlENjyeGYu2szqnCUBcehEIsJ+GjMMmQG2ApOnDY
	 nLgA8h7svYlxiGkAdxU3cVIsPIk88YTHxq5/RA7BmIpGEaPTDx/l2UJCuIuZfDU+OF
	 TIVWSVv01UkAw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id qeHu2LUwBW_G; Mon, 24 Jun 2024 04:51:55 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B87A49C5B37;
	Mon, 24 Jun 2024 04:51:55 -0400 (EDT)
Date: Mon, 24 Jun 2024 04:51:55 -0400 (EDT)
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
Message-ID: <676829420.1714448.1719219115719.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <2c32e077-48ef-4d08-99ce-9072a339740c@kernel.org>
References: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com> <20240620132511.4291-9-elinor.montmasson@savoirfairelinux.com> <2c32e077-48ef-4d08-99ce-9072a339740c@kernel.org>
Subject: Re: [PATCHv5 8/9] arm64: dts: imx8m: update spdif sound card node
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: arm64: dts: imx8m: update spdif sound card node properties
Thread-Index: OrrUPkiV572zhM5QFQUzINFUm+660w==

From: "Krzysztof Kozlowski" <krzk@kernel.org>
Sent: Sunday, 23 June, 2024 13:10:48
> On 20/06/2024 15:25, Elinor Montmasson wrote:
>> Following merge of imx-spdif driver into fsl-asoc-card:
>> * update properties to match those used by fsl-asoc-card.
>> * S/PDIF in/out dummy codecs must now be declared explicitly, add and
>>   use them.
>> 
>> These modifications were tested only on an imx8mn-evk board.
> 
> So new DTS will not work on old kernel... Can you at least explain why
> this is needed and what benefits this make? You change hardware
> description, so whatever you merged in drivers is not really relevant, I
> would say.


Ack, I will explain the reasons in the commit message,
which are in my answer to your review of commit 7/9.


Best regards,
Elinor Montmasson


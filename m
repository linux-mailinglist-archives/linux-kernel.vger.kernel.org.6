Return-Path: <linux-kernel+bounces-204589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E088FF0DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76461C22345
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AF9197523;
	Thu,  6 Jun 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="MNHRvRGF"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C91974FB;
	Thu,  6 Jun 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688376; cv=none; b=SYF7sVvtweCNnefbDgNWWPVTxovTBaFYRcwmNocHYSCHKy1MyOcJbkpjSF5Zd26IW7EHjVW9gUuVxX3GgaQU+DJoPP0xDpzLFIAlzTIq3STEWWwXwh0mB65Mqvor5WnMlSh8GwXTfw313ipxvFdJg5Y6N4oG/IYK4rh7g7E+bIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688376; c=relaxed/simple;
	bh=gE1Kj3xuMoCiY4bdyzCrXSApgzBD60tymyxKW4bbTTM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mWT6x9ZUYGLParqhoaRiWcNF/xt0mPWaCUnNFKtQHPt6ctkayM1pQynuLNnMb/r2M33SBNjFngPDTBXWEOZiLzIH+8SjAF0U45WlPZroilMy7RO/0DkiZWxQ4ML8I6k3YOMlpkiNVZbnaWlEsETGveA1a6KlLun0/Ja+r4WCHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=MNHRvRGF; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2698D9C2AA2;
	Thu,  6 Jun 2024 11:39:25 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id HrID-BG8ze49; Thu,  6 Jun 2024 11:39:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 888079C5ABA;
	Thu,  6 Jun 2024 11:39:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 888079C5ABA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717688364; bh=rYRVIIw22ZVkSQXnTBWHvN7qfAPVVfCh/LRBnQMA1mw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=MNHRvRGFyj67QeHiozGPa24sXXRlCMyLfd7jNHNA5jveZIw1fEh2VzMUM8F1eT+rD
	 lwk4iYhNLjA70F5wA6ZGWuYV1MwyONWNZ2Q1TL0NzdGiF/A9Coxc95tA+hAB7T/QgI
	 kmBgd1NfRVqUpiQYsNGpvBhNTskeGmFZiWy5RGkC1qoLweYdojg5mUdmi+fAy0oLpN
	 M0eDRwuz8BImBwfN/U453mrzZAC6ZxfpCbriv2KLdHhPn7ez/mfuhAFaKY/4oA/lBe
	 s9Ra9Q6ckJDy1JDMXHijrmuj7Hm4RpGtGTPK5RfzonZdM6fnBRN9O9STLBPYkp7KoY
	 gbNO0HthXgqYw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ijXDkcF8BT_c; Thu,  6 Jun 2024 11:39:24 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 457D19C2AA2;
	Thu,  6 Jun 2024 11:39:24 -0400 (EDT)
Date: Thu, 6 Jun 2024 11:39:24 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	shengjiu wang <shengjiu.wang@gmail.com>, 
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <1976575756.1264121.1717688364234.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <47a7a618-31d5-4dfc-9b6b-9426c6409e80@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com> <ce9a87c6-4a5c-4f0a-a8df-1fdce8c1f5df@sirena.org.uk> <599489232.349333.1715936741672.JavaMail.zimbra@savoirfairelinux.com> <500db9de-6113-4e73-ba92-6e52ea292b32@sirena.org.uk> <1598202415.701258.1717159684103.JavaMail.zimbra@savoirfairelinux.com> <291daed8-a2e1-44d4-9a71-5bca2c585720@sirena.org.uk> <1220272166.706254.1717166894551.JavaMail.zimbra@savoirfairelinux.com> <47a7a618-31d5-4dfc-9b6b-9426c6409e80@sirena.org.uk>
Subject: Re: [PATCHv4 9/9] ASoC: dt-bindings: fsl-asoc-card: add compatible
 for generic codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: ASoC: dt-bindings: fsl-asoc-card: add compatible for generic codec
Thread-Index: M+CiOw9Z1pP82SMivcOcvVDKOApGiw==

> From: "Mark Brown" <broonie@kernel.org>
> Sent: Friday, 31 May, 2024 18:06:30

> On Fri, May 31, 2024 at 10:48:14AM -0400, Elinor Montmasson wrote:
>> From: "Mark Brown" <broonie@kernel.org>
> 
>> > Why not just use the existing compatible - why would someone not want to
>> > be able to use the ASRC if it's available in their system?
> 
>> That's true but it will be a problem if both `fsl-asoc-card.c` and
>> `imx-spdif.c` drivers have the same compatible, and they don't
>> have the same DT properties.
> 
> So merge the two then?

It would avoid having duplicate drivers yes, I will do this for the v5 of this contribution.
Thank you for the review.


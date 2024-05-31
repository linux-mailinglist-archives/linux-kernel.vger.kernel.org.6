Return-Path: <linux-kernel+bounces-197001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D068D64C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1213128935A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056C62A02;
	Fri, 31 May 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="SdiCNzQZ"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453C55E53;
	Fri, 31 May 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166899; cv=none; b=XH+p+KHl2TLTc8gneM61lBy3cwLWk8FTZx8fDXgBR/VB8l6FBCCrEjIkTx1SbYX9SIs7ZQ3VgtHMg5iY/FyUtoM/7tuDzaoAnQFZmFzTlqX0fm2GC80JYxHWyvfgYcSi9lCZ9iP0R/klJTIH2WD2Dn2Frtr0rPMnYV/aNQFy1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166899; c=relaxed/simple;
	bh=qjG5sk5AW4DnjPOlkdayQAmvAKdwXxis0W1RtTvM0YY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MUBgTpwYxE13+1wcu2T7D4AQkTh/tg74KfZNrLSyG4TiJfJlSpB5A8moBB+u9ZVre55DmGIFlIXDrb4bpCL6tDnxCgDmbqoAFHQsjaYvaB+NCrY41sRZ34FYM4l3nhssnMq0o+qC1D4gcvu9l6oMULimW7hR3qmPGliWymsbNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=SdiCNzQZ; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 652479C584C;
	Fri, 31 May 2024 10:48:15 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id X9AwXBwr79HS; Fri, 31 May 2024 10:48:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CA82F9C58D5;
	Fri, 31 May 2024 10:48:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CA82F9C58D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717166894; bh=kchiTinbtwESPzQeP7Vb31GmvIj0rK/lVr0ouZd4gSo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=SdiCNzQZ1hd90TLzQQg+YhNcEKlzhtyi0dMmWZsuakVAg4zC8oa8Ln/wuzFtjnZK6
	 umuqOtoS5gkAHEBujnoCEOKYsXDvBh7k4WB/XCvwIBLWucfTHY73fNM4O9rU+BqSur
	 biWGtwErgzOoA/ZiQJHHv24hgOQZUfQtinNump2ygkCTh6ox6DlEHxwE85rJMdAjBk
	 cj9wBia7YVfb9fgXSVg18pbAViYC196NYW9D6jWI18BvnfTAn9m4XWsvWiwaGZEBGM
	 NVyq3W/ZG6KUkux0S4tKghCh9c2/NGndA3PTc151uQ9mRgg9k7xn+nLrLuDs/1Kzb1
	 s9Ne6y55WTWOg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id f6p0tkYRN10f; Fri, 31 May 2024 10:48:14 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8F58C9C584C;
	Fri, 31 May 2024 10:48:14 -0400 (EDT)
Date: Fri, 31 May 2024 10:48:14 -0400 (EDT)
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
Message-ID: <1220272166.706254.1717166894551.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <291daed8-a2e1-44d4-9a71-5bca2c585720@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com> <20240515135411.343333-10-elinor.montmasson@savoirfairelinux.com> <ce9a87c6-4a5c-4f0a-a8df-1fdce8c1f5df@sirena.org.uk> <599489232.349333.1715936741672.JavaMail.zimbra@savoirfairelinux.com> <500db9de-6113-4e73-ba92-6e52ea292b32@sirena.org.uk> <1598202415.701258.1717159684103.JavaMail.zimbra@savoirfairelinux.com> <291daed8-a2e1-44d4-9a71-5bca2c585720@sirena.org.uk>
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
Thread-Index: fUODjmUMbozLiD+24hweZL0h4n337g==

From: "Mark Brown" <broonie@kernel.org>
Sent: Friday, 31 May, 2024 15:14:13

> On Fri, May 31, 2024 at 08:48:04AM -0400, Elinor Montmasson wrote:
> 
>> Then maybe it's not be a good idea to make this compatible generic
>> for this contribution.
>> The original intention is to bring support for the S/PDIF,
>> so maybe the contribution should focus on this use case?
>> In that case, would changing the compatible for "fsl,imx-audio-spdif-card"
>> be acceptable?
>> "fsl,imx-audio-spdif" is already used for the `imx-spdif.c`
>> which does not use the ASRC.
> 
> Why not just use the existing compatible - why would someone not want to
> be able to use the ASRC if it's available in their system?

That's true but it will be a problem if both `fsl-asoc-card.c` and
`imx-spdif.c` drivers have the same compatible, and they don't
have the same DT properties.


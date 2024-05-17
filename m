Return-Path: <linux-kernel+bounces-181895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515568C82F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6CB1F2181C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AC529417;
	Fri, 17 May 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="oG1T2vdH"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14E1EB25;
	Fri, 17 May 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936750; cv=none; b=iWCCiWXmp8kluvH86n/61Atio3LE4Rx1jQ4XtXDXm7WC/Zldqv2FePwng75CKG3a06XaPHcvV6aZ/pfwyqKUfjaXmj0v8JfQTzyD0hz1J9YUc4WqBhuZmJdeNBIzzgGUDlzk8DhKa9shKuZyySKXzOXDLJbXp2T1i1bExrWCTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936750; c=relaxed/simple;
	bh=TlQMwSG+/gBY7QDcpZ58FdFlwzxX6d2C5yctN9arRp4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fg5/gAEYt85ydWXJAjdLqdBeG5qu0d6m9wUprTL3pFr14hWDJcFFqcAOLWqILyw3/uzHwKVJ3hX692I6sC0PZYmT4RNJAsqCnXMacGmzjsik9k0kaQ8UHO/ozyjJshens2ztRTgOLZ1QxT+qsLenEoJR150jFqtz/F7R7hp2xlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=oG1T2vdH; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8B8DB9C58EA;
	Fri, 17 May 2024 05:05:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ycSku0e4je0q; Fri, 17 May 2024 05:05:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E1D8D9C591F;
	Fri, 17 May 2024 05:05:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E1D8D9C591F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1715936741; bh=cx6CQV5YfxghVjmPjejucL2olCe90bCSbFqa4g71+0M=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=oG1T2vdHJ7olkf/IEQ4rw1h56wPiTy9nafFlLPsGCZwsqEJt/hBQwoXKYfPbmqn2h
	 qZu2NlE4sQ8A4gbFeK5DUxGaN4+8TNLmbIKDfM5+i/QQN7IS+ya2Uh+JmKsmsSkqf5
	 MBGTtuIp7xLTlE+3yW/sFKWA4LY7drC0AoeY8TdAT7jSKPSGqa4jIqgy8pHLsrqkyh
	 yAcrOiTjeSJLLtXbpZhHcSON6ooFo3JQVIidV1+HLSXl00uXRf6t6r0H3XspC0vWKO
	 wEcQ2mrCYmQ0xuC6DEzFord8S+Lfc/I7cQ++SWegOi5kEYBQ0bQ2PDnlLdkJZIuoH9
	 7VWRve/a3Uxng==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UkPCSXxrdA7W; Fri, 17 May 2024 05:05:41 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ABB829C58EA;
	Fri, 17 May 2024 05:05:41 -0400 (EDT)
Date: Fri, 17 May 2024 05:05:41 -0400 (EDT)
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
Message-ID: <599489232.349333.1715936741672.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <ce9a87c6-4a5c-4f0a-a8df-1fdce8c1f5df@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com> <20240515135411.343333-10-elinor.montmasson@savoirfairelinux.com> <ce9a87c6-4a5c-4f0a-a8df-1fdce8c1f5df@sirena.org.uk>
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
Thread-Index: 5nXwooIVrjUMUfEG3TeQl8yJKNJb9Q==

From: "Mark Brown" <broonie@kernel.org>
Sent: Thursday, 16 May, 2024 14:11:11
> On Wed, May 15, 2024 at 03:54:11PM +0200, Elinor Montmasson wrote:
> 
>> Add documentation about new dts bindings following new support
>> for compatible "fsl,imx-audio-generic".
> 
>>    audio-codec:
>> -    $ref: /schemas/types.yaml#/definitions/phandle
>> -    description: The phandle of an audio codec
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      The phandle of an audio codec.
>> +      If using the "fsl,imx-audio-generic" compatible, give instead a pair of
>> +      phandles with the spdif_transmitter first (driver SPDIF DIT) and the
>> +      spdif_receiver second (driver SPDIF DIR).
>> +    items:
>> +      maxItems: 1
> 
> This description (and the code) don't feel like they're actually generic
> - they're clearly specific to the bidrectional S/PDIF case.  I'd expect
> something called -generic to cope with single CODECs as well as double,
> and not to have any constraints on what those are.

I proposed, in an reply of the v3 patch series to Krzysztof Kozlowski,
the compatible "fsl,imx-audio-no-codec" instead of "generic".
Krzysztof thought it was too generic, but it would convey more clearly
that it is for cases without codec driver.
Would this other compatible string be more appropriate ?

Best regards,
Elinor Montmasson


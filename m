Return-Path: <linux-kernel+bounces-226896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7948691455A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76A5B22BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3812E1D3;
	Mon, 24 Jun 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="LJ3oP58J"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249284D108;
	Mon, 24 Jun 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219112; cv=none; b=kv9w/PZhsLsHjylnBjhdx+7tZaHk8ux1lfvhAOfm7U6qVxxiBuS09dSJU4gV1dWztXnXE7ldXQqBxcGPw/TUs7slOr0S2YXcUNT3PcyxtEFefr65GsCeUTlMaF6TLss6bycjNK8qgjguYuQ4MDqo/wqbwBk/bTSH/QMiS4LKok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219112; c=relaxed/simple;
	bh=12KblMR0lvQRAfXHF0Dq4rTSUBeNqIJvXxWeiiTICd0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ikCeaJ1x1fd1rRjssI4Y3R3n9CgTO/Bij0Q7Uu0EyuRuITKK2zfBPwxQqzgC1gkzeVi4ZWKHeBVpBNRt9pZ8jaHeQU5o3oIQhV9eJXcKg9DK2G3FmSQ0oTGUukwifgKtr7I0BpsIhYwbvjQyEqORRJISkEvR7qzxAkIA+gnqRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=LJ3oP58J; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C2AB69C0760;
	Mon, 24 Jun 2024 04:51:41 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id l-RopYeFgXC4; Mon, 24 Jun 2024 04:51:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AF4929C5B22;
	Mon, 24 Jun 2024 04:51:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com AF4929C5B22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719219100; bh=a1b5vrBz8D1hFrcHDlPiNjC4drILw4QgPGHNsbulLy8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=LJ3oP58J27UKF0zNSSV68BId3PNm+CFg4j/XjBb7RPo+I2qJzahp6D+6n8tuTj44Z
	 8QO9uwrbEK8Ct9ftBW+xDsS7pvHxNmTaJ7Vz+ZPWzzWGxnyYDG4hKSnJDR6BqyqfqT
	 aKMvkDeyE3UySrLZ5dtjNhDKtvRB9XcRpgLs38/X8ZFG6IAizoGQnSCW3qYmOXMYW8
	 EWWwPr/O/ZkpZUXoAjYmc4hAb/KO8BRTfRnrU9t0FEzdghxzTurVoRxrTXdtKmzVA1
	 ocwPg6fi0EqzlfcJVjZmSgIAuHJRM3J7QUUV3OGWWWvW4zy3ILfNKhH1N5UbolwFP7
	 Wta8qqaVcTY3w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id TBS6RH3a0UlK; Mon, 24 Jun 2024 04:51:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 601DB9C0760;
	Mon, 24 Jun 2024 04:51:40 -0400 (EDT)
Date: Mon, 24 Jun 2024 04:51:39 -0400 (EDT)
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
	devicetree <devicetree@vger.kernel.org>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.com>
Message-ID: <1327841247.1714446.1719219099909.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <6fcbd97b-4172-48a9-bcdb-3bdf35aba8f7@kernel.org>
References: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com> <20240620132511.4291-7-elinor.montmasson@savoirfairelinux.com> <6fcbd97b-4172-48a9-bcdb-3bdf35aba8f7@kernel.org>
Subject: Re: [PATCHv5 6/9] ASoC: dt-bindings: fsl-asoc-card: add compatible
 string for spdif
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: ASoC: dt-bindings: fsl-asoc-card: add compatible string for spdif
Thread-Index: mXPND1rvWgYNEmNI1MozJM8+FSSA0A==

From: "Krzysztof Kozlowski" <krzk@kernel.org>
Sent: Sunday, 23 June, 2024 13:07:46
> On 20/06/2024 15:25, Elinor Montmasson wrote:
>> The S/PDIF audio card support was merged from imx-spdif into the
>> fsl-asoc-card driver, making it possible to use an S/PDIF with an ASRC.
>> Add the new compatible and update properties.
> 
> Please use standard email subjects, so with the PATCH keyword in the
> title. `git format-patch -v5` helps here to create proper versioned
> patches. Another useful tool is b4.
>


Acknowledged, I did not know this option and will be careful about it
for next versions.


>> @@ -33,6 +33,7 @@ properties:
>>        - items:
>>            - enum:
>>                - fsl,imx-sgtl5000
>> +              - fsl,imx-sabreauto-spdif
>>                - fsl,imx25-pdk-sgtl5000
>>                - fsl,imx53-cpuvo-sgtl5000
>>                - fsl,imx51-babbage-sgtl5000
>> @@ -54,6 +55,7 @@ properties:
>>                - fsl,imx6q-ventana-sgtl5000
>>                - fsl,imx6sl-evk-wm8962
>>                - fsl,imx6sx-sdb-mqs
>> +              - fsl,imx6sx-sdb-spdif
>>                - fsl,imx6sx-sdb-wm8962
>>                - fsl,imx7d-evk-wm8960
>>                - karo,tx53-audio-sgtl5000
>> @@ -65,6 +67,7 @@ properties:
>>                - fsl,imx-audio-sgtl5000
>>                - fsl,imx-audio-wm8960
>>                - fsl,imx-audio-wm8962
>> +              - fsl,imx-audio-spdif
> 
> This does not look right. It's quite generic, so now you allow any
> variant to be used with this fallback.
> 
> Please do not grow more this list of all possible combinations and
> instead add specific lists. Otherwise, please explain why this is valid
> hardware:
> "fsl,imx7d-evk-wm8960", "fsl,imx-audio-spdif"


I wanted to follow the current style of this documentation file,
but I agree it's better to prevent using "fsl,imx-audio-spdif"
with any compatible, I can use a specific list for the next version.


> 
> 
>>        - items:
>>            - enum:
>>                - fsl,imx-audio-ac97
>> @@ -81,6 +84,7 @@ properties:
>>                - fsl,imx-audio-wm8960
>>                - fsl,imx-audio-wm8962
>>                - fsl,imx-audio-wm8958
>> +              - fsl,imx-audio-spdif
> 
> Fallbacks should not be used alone. Why this is needed?


"fsl,imx-audio-spdif" is used alone in most DTS files.
"fsl,imx-sabreauto-spdif" and "fsl,imx6sx-sdb-spdif" are used with
"fsl,imx-audio-spdif" in only 2 specific DTS files. 


> The compatible is already documented, so now you create duplicated binding.
> 
> This is very confusing.


The double compatible documentation is only temporary, next commit (7/9)
removes the previous binding in "fsl,imx-audio-spdif.yaml".
I separated these changes in multiple commit to ease git history searching
by subject/file.
If required, I can merge commits 6/9 and 7/9.


>> @@ -195,3 +208,12 @@ examples:
>>               "AIN2L", "Line In Jack",
>>               "AIN2R", "Line In Jack";
>>      };
>> +
>> +  - |
>> +    sound-spdif-asrc {
>> +      compatible = "fsl,imx-audio-spdif";
>> +      model = "spdif-asrc-audio";
>> +      audio-cpu = <&spdif>;
>> +      audio-asrc = <&easrc>;
>> +      audio-codec = <&spdifdit>, <&spdifdir>;
>> +    };
> 
> Do not introduce another indentation style. Look what is above.


Ack, I'll correct this for next version.


Best regards,
Elinor Montmasson


Return-Path: <linux-kernel+bounces-184999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053D18CAF35
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B801F2324A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8678C7F;
	Tue, 21 May 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="p+BndcQU"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE278C6E;
	Tue, 21 May 2024 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297314; cv=none; b=Fr2peWcEXK0AG4pmybnXBNv2shSNRCzo0aM1w5svt99dya7iAeENLgCTmdzqfzR85Tm5cFZaSqPlA8FzbTIEQUJbJc73BQUzXsPtdgMqm6zeQ5XEE0B1Gs7w8Xpz/Cooeswe0m8rDNeKKmCM8jpT8tYsfr76XJPhIHDC8psjmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297314; c=relaxed/simple;
	bh=xBzALiC8QpbiUZ0vIp/DDNJUn3RjiTwJaSILiRdd+3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qm2a14Uq37D5150su81Oyhv0AkPqyXmH/h28ZN2aox4EHbH61mR/qX7KgjSZIfEhzMy6jsaG2FCC1pXHl+6gaQ2LSU44TyKCKW8pXOvb8tz6+ApSljQSOJLKBCwKFY9rSuBg4dS/d/MptnKbycblPAcfI7MtESDRW2ApTyVC2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=p+BndcQU; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LBRiTd019430;
	Tue, 21 May 2024 15:14:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=/JwugDw4q1sV/Kf5SJf4M3YRla9SOKHNH5flwjaLMV4=; b=p+
	BndcQUREV6vnAs24JULfWquhsrWpIIlgDhAF1nYhHkU7hU+WmPGT9NSS+AuVj3qv
	IqMklPxg4JOrbgrn8VqHONaWyexs/qy3qJX6aNKBTIMEE3X57GTPfPoyizgzcE1F
	6Jpuy06CHFYp1h82UjBEQ79OOwH3bb3eNwBjpbead9ZepN0naqcaD+WvNJne7ViK
	cTrc+Fw5s0Y8PSIA33CfDnt6Tksw57cbmuMi/rfMpMKJDH1LwnoaJnEt3L39Nl9n
	acn6SklqU2i1tNW0AqfzpbAiyFoNhT3FXgLNEi+QtKSLYsC+Bf6I9kLBzqVF5+M0
	8isqx80pqOqhLIgV/PXA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y6n42cc30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 15:14:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 944294002D;
	Tue, 21 May 2024 15:14:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0DDD321A8FD;
	Tue, 21 May 2024 15:13:54 +0200 (CEST)
Received: from [10.48.86.132] (10.48.86.132) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 15:13:53 +0200
Message-ID: <7ba9113b-7360-4201-b983-e53e90f2be06@foss.st.com>
Date: Tue, 21 May 2024 15:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: stm32: Ensure compatible pattern
 matches whole string
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240520222705.1742367-1-robh@kernel.org>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20240520222705.1742367-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_08,2024-05-21_01,2024-05-17_01

On 5/21/24 00:27, Rob Herring (Arm) wrote:
> The compatible pattern "st,stm32-sai-sub-[ab]" is missing starting and
> ending anchors, so any prefix and/or suffix would still be valid.
> 
> This also fixes a warning on the example:
> 
> Documentation/devicetree/bindings/sound/st,stm32-sai.example.dtb: /example-0/sai@4400b000/audio-controller@4400b004: failed to match any schema with compatible: ['st,stm32-sai-sub-a']
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/sound/st,stm32-sai.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> index 59df8a832310..f555ccd6b00a 100644
> --- a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> @@ -68,7 +68,7 @@ patternProperties:
>       properties:
>         compatible:
>           description: Compatible for SAI sub-block A or B.
> -        pattern: "st,stm32-sai-sub-[ab]"
> +        pattern: "^st,stm32-sai-sub-[ab]$"
>   
>         "#sound-dai-cells":
>           const: 0

Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>

Thanks
Olivier


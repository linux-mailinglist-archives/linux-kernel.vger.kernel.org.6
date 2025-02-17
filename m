Return-Path: <linux-kernel+bounces-518044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8092A3890D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626D8165771
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB56B22576A;
	Mon, 17 Feb 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEAEMI5f"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4E22540C;
	Mon, 17 Feb 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809487; cv=none; b=NN/n3O17FHqpyPRn7qZkz9x8fOA3Cf7Mx3BouXC0754q1pL2aK3c2mTkutsXcVumB8f0KTxnoI2PPyvI4nwXSu+zflzcliAJqtiRwkzSgyY8M72YKB6D40+Dz6JFU9K+69TGL2KnB08mZ2aq1OpO1h0tdOFj2RFtkZMObRPMREU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809487; c=relaxed/simple;
	bh=IMJW+363IVg5kD8bsAouG7m9/UBKsClnNgoauqWSL/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV5LacGRFguRFv9yW376GsUS3waIA5ZQPkRuMLLtX01W0EupQ9DbdGoJzA/IJ2PdGxng49KIp88nEGXRAZPsDan0FN1pTl5Pb3HA/wxs3M+eyno57TaWGXO8V4G2YYmGFNaKAaiJq2b9qXvyPuKMY92iDTn0uj/hf+Ng2OjBjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEAEMI5f; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb86beea8cso320718166b.1;
        Mon, 17 Feb 2025 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739809484; x=1740414284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6Me8ZURi9BHMA5VBv/dcrhQFM3Dtg/x5OSHUQbvC6g=;
        b=nEAEMI5fGgUMlSb9oSB4W8JFUNdkAQ9hvgoaCVUomNnx9SD+laJYho3GTDIW4W9sGn
         rdLtG2SbXgqOzQaz2hxrxZIaeb7/DukBOYswUStwCzK+yt75Dv3ikJR8R+/QkGb+6LUs
         QTFFT3dmn18yGTO7pDewuL4TQpjYGJBoRDMv0P/uOFJU5QF2idgPBjMlh9MDxrZKIMHT
         0LrCeJUZqv4Pqu7N8GHquIjfCOIgLuSsH4uufvLFTeObKdHk1lcO72TS0ho1VRUjVkKw
         zhKMaOVrAaF3I/piHmrUf/RFypSaRp4F7kzuhmFM+M9Dmz1jn7KcFZX+qMo3YPPN9GD9
         L1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809484; x=1740414284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6Me8ZURi9BHMA5VBv/dcrhQFM3Dtg/x5OSHUQbvC6g=;
        b=DpUkfRDrj5nZEa7zB+0WaHDHEq6OVeKBvCJCNS3BF9Xdap9hkvzsmkcOwvaRIByjuj
         eTOODoIDEGVJeUwGGrn8iI7JUPzvF9bXIEXTNzbEMw0rvSGruOmihJoQfeEWXJEUa/yb
         VRi9EQWFk1zhEgXu0xUUSnIExNn6zB22BbLp7rbLhLx00J782erqYLhlPMY1tpJIUmgU
         YuHdWFklPBj7cIOGo0lkf9EdUgY6oZALMpcgbm14pn/lsskbPOAmHzRibGMdeHoWdcun
         PsF6OR7W3p/IGX92ykEKrLLn6bzo4amcq5fPh2Y2ij0gfP+ITcQ+4MdtIvENrOa1d0bz
         bB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMbxHjebN6Fr+pPOZD5QVqk//Dh/QPERl+1UMDB6BjILI+WJjACu5MsNH4YaR46C+laq1S2z8QovVoeZM=@vger.kernel.org, AJvYcCXwscf3QOi+QZg7+OGoxf29vJXyIO9Ds38H76jU7H2P9pPQtwLCipknzTM8J5xGUo9uKJrbhgFahqPyOBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeM+C4a5BUGWeZxnyVWf5oyVg6sDOyTimjoZwM7UYOUDmmhMjF
	VF8LLWw8u/EWDToPi5BzmMRiSlw4Kf6F5Py2P0mmGx18GJZ8Ruhr
X-Gm-Gg: ASbGncuTUv0bU+Q7uD2Bie3QVvdfdZwTD3g/wniiroy4e76bCtRMLqb3/o//2R1qxKt
	DMJmgSu8Bwh2kMPO5cQFLaHQ2e70uWmCC33Hfw74TAJzNWlKwjIt2LZ0ZY3PxB5ZmzdCsEkfm/b
	S1Xjom4s8ZZLD5v8tw972jDW+0Md0FNoGpkvP7MnX443HYBA+If8kmNbGSzgI9iamSJ8L1yBh/d
	tcZOMv8FX909xM4NPFCmJiO96bfPYQG5lQCm3LZypvyo0ljG1BkSAp1rkEBKVu0Dag3aK/oZy4q
	CzLvFA4LWhGgWcIs3r6SASbIJvWt/M3uNiGoXGni5Aly
X-Google-Smtp-Source: AGHT+IF485TpglsHoYcM2qPJw/DdadQMT0idtEVOh9tCPnUieChDKELqnF5ni403s2wOT43n83j0+A==
X-Received: by 2002:a17:907:1b04:b0:ab7:d66f:c86d with SMTP id a640c23a62f3a-abb70df5d76mr1030222066b.34.1739809483644;
        Mon, 17 Feb 2025 08:24:43 -0800 (PST)
Received: from [192.168.1.130] ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb837378e7sm421915566b.52.2025.02.17.08.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 08:24:43 -0800 (PST)
Message-ID: <c6c5e039-7c86-4813-a880-89b864822d80@gmail.com>
Date: Mon, 17 Feb 2025 18:24:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ASoC: SOF: imx: fix a couple Smatch bugs
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
 Jaroslav Kysela <perex@perex.cz>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 sound-open-firmware@alsa-project.org, Takashi Iwai <tiwai@suse.com>
References: <fffa1613-72e8-4cd0-a4db-b6b13a5222e9@stanley.mountain>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <fffa1613-72e8-4cd0-a4db-b6b13a5222e9@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/17/2025 9:32 AM, Dan Carpenter wrote:
> Fix a couple of bugs which were detected using Smatch.
> (https://github.com/error27/smatch)
>
> Dan Carpenter (2):
>   ASoC: SOF: imx: Fix an IS_ERR() vs NULL bug in
>     imx_parse_ioremap_memory()
>   ASoC: SOF: imx: Fix error code in probe()
>
>  sound/soc/sof/imx/imx-common.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
Thanks! For the whole series: Reviewed-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>


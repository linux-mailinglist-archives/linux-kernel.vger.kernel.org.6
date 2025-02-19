Return-Path: <linux-kernel+bounces-522182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA98A3C717
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527601889A20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE0A214A6A;
	Wed, 19 Feb 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhktd3B3"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94121423A;
	Wed, 19 Feb 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988704; cv=none; b=rSIZm4YlD/zUmkg0HNgDf57ONDebvO8lqKz5N9GM/utcy2zmPiQjXNvFcb/sEeQMpMfGWzjkRmyUQPT7RkIfpiufGeT/DuU3hDfdEPZUp3FlZvp3dibmtIqJUI/n2xN5wsofrOTt40CK1HTKsfIHGrFiJOlBvKr6UmUuq+lfnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988704; c=relaxed/simple;
	bh=3LZDiVVNFHrrTvKMy+aaUFJQiQjaTqA2aBCNOTEezAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7KtoOh7KJ/OWQqtrSoLJOTsrwll4Rk4l8TVhf4D/oVgW8tP9yGXoSvM4XvVWMK8ry3FeP5Fw/X7DM1leWb/IkeDaQaMhDUijWAdSasqor7fgfHsY5oUQhLxFYfol4ukemKoq7cQf49uBB06i32WbeiLUOrnx2B/Q5pVBUwuNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nhktd3B3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb90f68f8cso21412166b.3;
        Wed, 19 Feb 2025 10:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739988701; x=1740593501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EX7iW7aQk19gr4mr35uOFeWPZKaps87azPiJHXGQMpU=;
        b=Nhktd3B30VsiOGUO/lkf7lStQAHGwpc0v9juMyRY3zjMNjbg3hRdmu74xPXeJtdQcG
         lYlzF5djsgtLSTucQCfnCpmHl8o4Xp0Mthrkn0SWS3pqXydihpuUQOEVVnL7YPe9ieFM
         w+W7KI1ALy6oYhvo+RE9CegA4Z5+zyjDNCyzRiEk10Cet5U0ffK8eR/bQxPg2AqbKHp0
         INAxhCkVe2vTmwJVGVo7YdI+drRv948Os/aFBANKLiDND79BHRZj5eZEIp3I6YgNOfMZ
         wja5yrjdNiv565NafV8sFCHiKF3ahjYIb36Ae6iroqP066FGZzWNAML7lY9HJAqN11Og
         grXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739988701; x=1740593501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EX7iW7aQk19gr4mr35uOFeWPZKaps87azPiJHXGQMpU=;
        b=BIZK5NMV5XuVztgajVyRXSDSiOdYRfdlx9C9SLz/S7AJP0MO9grcl8KfoY/NnOSuAg
         vyXq2NX/iqYi51yff22XPwueQJRNOHWdZLkVQ6RdE5fFUVA8+9zBDh3S0Se08OTufB05
         +nqh5xbUO7awhwnoE3SSabf197P0I+qRSJIYzbeDx2R7gCvnTQJ3pBd1MDT8n1bfOte5
         nQyWolwp8QTXFOwD9gGJbY2BZNAJhjjX+uhJVWEBvvskdo1Sm9RynCycqpbYiDLrAgAu
         dCdkvFv69E2U6imZqoyAdZmj8BE4ZFZOR4ui+bqEZHjjR2h2prECpprzgUNuxayE3Bge
         Xmtg==
X-Forwarded-Encrypted: i=1; AJvYcCUjHQqXBlZHV5Q86wUjiLfcDryYnlJOEpTTW2P5PY2tkqVen12UTsIT2+EpgJurYHRFdRUrK50xYjCfXqwJ@vger.kernel.org, AJvYcCWyz8cdoZOMIfTsUJcyVq6DIkxChyNsl4HjMcskxw5Cb0csNfWIUKqGcQIbQ6NIYBkbIlv54wziHdoL@vger.kernel.org, AJvYcCXxXM6E+9eoSIaHp65NqXvBPdlDRk7CNdomGCFRgE59jWXFyMl36ZDHYuMZ6H7A08HLJEZ9EkrH4tXn@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQ2xi0GXMePu/MjNgc+VZj2rWsNbBW1y2MPOmZI1/g7Z1H6ma
	dwa851UuSADhMOH5nwRmrSlyYT2VJNIBD/08ewxD1jQMkeV0nx1ZdNk5pR5B73g=
X-Gm-Gg: ASbGnctu2sP7qCJqAL5EC8N0PGT2X2KzYzqdJNpgwdO77zWkal+TA3929by/Ld0N55G
	Uuw+gb9JHv7SM/PKZDk1nmA/gJYrqeN5Tc8WtJacLacoud96Rf4HG5XLN9/nsSqwVB36hvK2s+3
	/rEuCuHlsbRxtzE7BhgPwT/imUewC3S3EPfBDenxwoNPYU+TyOmGeQY7VrAsaHBgvnp89COK+nl
	oXpMI32CrVx7pNyal3THZuZ2W/0JV+ArIsHUraZHbk00PBwA6blP0u0CSuBIdMp9J0CKN5hFUV7
	QX5chRRqTFJ1BH5rZHTWJkOff359fgzo+eAmFYh01dEIJ68=
X-Google-Smtp-Source: AGHT+IEJpTPW7wSmUpDukWtijT9eGXBjCmFlUxZGRjvR2GsGxyDjjg4XrIW4SthKGdN7ujvQTG+O+w==
X-Received: by 2002:a17:907:934a:b0:aa6:9461:a186 with SMTP id a640c23a62f3a-abb70dd663amr1847442766b.46.1739988701033;
        Wed, 19 Feb 2025 10:11:41 -0800 (PST)
Received: from [192.168.125.132] ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba7c63162sm524674566b.182.2025.02.19.10.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 10:11:40 -0800 (PST)
Message-ID: <ceca2d24-78a4-48bf-872d-71866ad97b92@gmail.com>
Date: Wed, 19 Feb 2025 13:10:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
 Stephen Boyd <sboyd@kernel.org>, "S.J. Wang" <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
 <DB9PR04MB8461866A0B6A068E49D53FBE88FA2@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <DB9PR04MB8461866A0B6A068E49D53FBE88FA2@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/18/25 08:43, Peng Fan (OSS) wrote:
> Hi Laurentiu,
>
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH 0/4] clk: imx8mp: fix parents of AUDIOMIX
>> DSP/OCRAM_A
>>
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by
>> setting it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT.
>> Additionally, set the frequency of AUDIO_AXI_CLK_ROOT to 800MHz
>> instead of the current 400MHz.
> The patchset looks good to me, just one nit, 
> Should fixes tag be added for the patchset?


sure, will send a V2 with that



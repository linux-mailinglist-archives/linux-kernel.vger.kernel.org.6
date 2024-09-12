Return-Path: <linux-kernel+bounces-327239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43669772B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EC91C23E86
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6051C1738;
	Thu, 12 Sep 2024 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMVXo/Wf"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779BA5F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172948; cv=none; b=WttQyJ8xz4CNHJCipp5Gj3KaPlGJE4/+JfNEtSxh2zNy0ccpSwS+x/NBiu7KAFv7c+JAuWtoFfDSpwlT58MibllZXzMEss1loI+9vxRhmjYxYRvZEWOt+sgwSXPNDZxcFdql7HClGlbi5XHk/uIeL+97xD5hWT5mIBsVjbwt5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172948; c=relaxed/simple;
	bh=KmmGWlcI3nEcpRk043DrxsE+vVZ714DapyziPn5tPug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8xsb16fUTNTQQnw45Ni1kDYGml/ZuvDHtFou63U4O/H4XbRopFRNSqppSCNto7gbguX7N3ZHqQuyEnh5+z2RtotSSOjj7tk4J8+blsO3JfpskKO6Ee91le8I8r++orJ/jgbCUKKh2daMzpc7nqxuHKLJRMPw//kK31WbrkP3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMVXo/Wf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374d29ad870so141127f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726172945; x=1726777745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+Vvlq6kPIRv3v2sNDT50A07Twv9J2TV9GHlO+JqyOA=;
        b=lMVXo/WfywyXGRq1MjlrpJqSVzi70YzscfqkS6by3nkxmEiKw835dXK7PWJznoAMfJ
         nPUmiZ5foXm3OukpDDJ4VSP895FrQAPniS/JhwlDGk3fWZ8UODvq3u5MDJo0BXWSVU0w
         B17OF4V/Udm0NH+vi/LOSbQfoxKQ/OR+hau4SSo7UP2/xZ6Rb+BrZq9LbyIrKEg0Qhx4
         nkn4bf4Jq74oesZWTjKfwwWVbXurdlAWJenXTTf7WGoax20A4mnBpQKGKRe2QnAOdt+V
         Nxr8egWon1m58MjEsaI60s/FL62+ISBsYUmtGXCJXsQaNQTWnsnrZ5rGNhzddsyeQchg
         xuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726172945; x=1726777745;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+Vvlq6kPIRv3v2sNDT50A07Twv9J2TV9GHlO+JqyOA=;
        b=he58qmXKGjmM+p3NvGpmjW/cY/Yz9U/YIQAYk6sln9ohye1D4jLgxaoyupnG95MuAG
         sqinG63qRCSvjmZra9W0b1kLVNdOdr5tnmnl2G86a7zJWWrovPzYlKTfRdkMoK6hsuiD
         ABwaLTuWVAv6D6IchPplH+jqkjrlAgGFoRRzY+D2cQ9cbztoQntC2RC8ZNnP1vkra+G+
         hj9L9TJFTtbrOig5i2h9VL1QD3ZBcHjA0vK1lHl05uBFaygSs/QUPxMibttvhPIE0oFE
         ZKCd6pTXZyfF9pExKQZ9+j/KToGgnRIKedYv9PNqpsM8rVXsMFgwSJu6sUiHmzVxeQQQ
         UDJg==
X-Forwarded-Encrypted: i=1; AJvYcCURWDQHNASFoFzawGzHQcxElaTyX4MievXzfdWZAAW+HBY/MV27aaJ3gYysekn8g8OGypcPR0JaqPbR/4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQByngW0i2gRk8Zcg1LAT4ksV3vUHd6gzXhHqx+5mwRlUkrOvJ
	bsw/ppHevvplDsXTKzdxDR3dRh9Q/Fs3LvjzE1AAVe4I8riG/MiX
X-Google-Smtp-Source: AGHT+IF6AGfDleGr42k1egNIDn9NzhhgPE6NVPwmZsDi9VTBrErzhGtAmkQv7+/UngllSM9A8ndaPg==
X-Received: by 2002:a05:6000:1445:b0:374:b9d7:5120 with SMTP id ffacd0b85a97d-378d61e2adcmr279407f8f.23.1726172944504;
        Thu, 12 Sep 2024 13:29:04 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675c11sm15086968f8f.55.2024.09.12.13.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 13:29:03 -0700 (PDT)
Message-ID: <6c9b7f85-f92d-44ed-ae9d-00f6d55ea614@gmail.com>
Date: Thu, 12 Sep 2024 23:29:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Support alpha blending in MTK display driver
To: linux-mediatek@lists.infradead.org,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>,
 CK Hu <ck.hu@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
 <CAAOTY_8ThuusfHk9Gd5pFP8VhJkG2seuJmkFiruK1rPQFZGBzg@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <CAAOTY_8ThuusfHk9Gd5pFP8VhJkG2seuJmkFiruK1rPQFZGBzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2024-07-31 16:34 +03:00, Chun-Kuang Hu wrote:
> Hi, Shawn:
> 
> Hsiao Chien Sung via B4 Relay
> <devnull+shawn.sung.mediatek.com@kernel.org> 於 2024年7月17日 週三 下午1:24寫道：
>>
>> Support "Pre-multiplied" and "None" blend mode on MediaTek's chips by
>> adding correct blend mode property when the planes init.
>> Before this patch, only the "Coverage" mode (default) is supported.
> 
> For the whole series, applied to mediatek-drm-next [1], thanks.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/log/?h=mediatek-drm-next

I am seeing broken colors on an MT8173 Chromebook with next-20240912,
which goes away if I git-revert this series (commits 1f66fe62cc09
eb17c5909481 a3f7f7ef4bfe 59e9d9de25f0 4225d5d5e779).

To illustrate, I took a picture [1] of some color mixing diagrams from
Wikipedia [2]. Do you have an idea of what goes wrong?

(I'm busy with too many things so I don't want to debug it now...)

[1] https://i.imgur.com/tNFvovB.jpeg
[2] https://en.wikipedia.org/wiki/Color_space#Generic


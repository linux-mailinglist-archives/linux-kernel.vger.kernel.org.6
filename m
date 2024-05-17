Return-Path: <linux-kernel+bounces-181791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE68C8157
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C492825E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE95F179BC;
	Fri, 17 May 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3BAVl3/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E9171C1
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930588; cv=none; b=eDk5R7PKQIYaJBY/kTIspgioQ/x6yVvsRD9BGxsknI8u5gkeKgEiViGOizbPZ2babBvTZwylhsNdwgsE3Z1M+12++WXCe6S4sWCXHc2jP8aANzeIwx2VS56XdcGxUKwZvBSvMCFtLkBto97leLLD5ufkbvp3eq5wFKJpyPK5nw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930588; c=relaxed/simple;
	bh=AnWeLBQt5ac+tcuC2FaZYK43qTCgCb5yG5KTMVRwPTU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HGPbI+5GEjSXSEOpaermEJqGvbbrBeJnQLqLJ+Sw2kTprgAOjn+Oft79H/eXT34F8w8kitStXReuToQ6ZvWxbUIwllFAWS0/vgZP5txsuNXWHZqLuoaZQEpbLsiNoSxkuCMMTTaHa7V0UqngyeZFPAGgzB0Z0KEHW3WjCGTPh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M3BAVl3/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so4778904a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715930585; x=1716535385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/XVqZNav4jeDccL5yKKaBFZcarnd4dPclOkrq6OyOY=;
        b=M3BAVl3/As8CDTbGlpJZrJ3BxEP+Q4d53yCLc/d+0uSTFbVErFjhiBvlkSyBVzQbTw
         6Dt+U4wCRnfKGBe99HML5qbJJJetREEW6Wz/pdL/k9sQ//RBkhONnfbTllwyk9hvpSVc
         NIy2fMAXYxR9qvZmy05V34iIq6cEFaGBdXB641BW/vAAS1GqPE2Nm7SGzfYgemLusrUZ
         pm+9zWs4ALPP51mXrED4TdYCnh91bIQXuUBsqb/+HGLT2pDqTwev+Ic4GL/Q/pr9jkvB
         0C/t82luF86DCDzki3mMti7k7WXRn5Jd5PWhkPN+imQOV0ot4UZKd0FlFxBIZIsXpcVe
         dSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715930585; x=1716535385;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x/XVqZNav4jeDccL5yKKaBFZcarnd4dPclOkrq6OyOY=;
        b=rbSrfDQxK9EVFKqkwrqEWJS3muWRpfq1943SkfQUuL/JfKqC2jsXMBzotodMD7nR2k
         KM5d/Snwf6eviMmAepadZ1fEx4b2yVGO0B6Jh5NTIIr0yi6L6Io/QpiVP72lYZbzKQET
         feZaIrwkrVSBXi+NIRBBBA35FHHpC3V6G6FpGvHtUqci7gBp2wg4WT6pKk7wUpmrkOQG
         aCFephK0RWMng1/5pFluWLFZVULq1H8TFl5zgg+8oxJpxdyfkmvCCZ0OdVdrkpwXSewe
         kbsSOthuLQtJa4dHmTt+0eJ9kMqE+ONbhInhV9CR0siFvXgUzMiaungiJS8J9i34dCMx
         IxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVS9aAHDAS+HFor/1vHaHIxTn/mUZPgg6YCBkQuGc6ymJl7lBUdhtYP0FpSZ5R0ofj8+O3nuFPLutsWMECGmXgKgWLWBMTKj2e3DID
X-Gm-Message-State: AOJu0YwRIw80lXqj39wFD/qKrnvnRCBeWnMqQUnkHQ74rtW+bkUoyY2k
	VnopGVFoQc/5/liqh+238FZfsY52IQQsa3GuntyZ+2rMuBxouvnBqwEpIr3Yt2o=
X-Google-Smtp-Source: AGHT+IGevcFSUYvf1bUw8ixrHIf9cut7/bdOTveY3eTYS2It7gi7T93mcyQrJSe5Mtp5z+Tw/6Q5Iw==
X-Received: by 2002:a17:906:3512:b0:a59:a282:5dbd with SMTP id a640c23a62f3a-a5a2d676474mr2051833166b.66.1715930585310;
        Fri, 17 May 2024 00:23:05 -0700 (PDT)
Received: from [10.91.0.73] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d4b2sm1070364066b.27.2024.05.17.00.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 00:23:04 -0700 (PDT)
Message-ID: <244ceca4-0863-436e-bf9e-335ab74d1e67@linaro.org>
Date: Fri, 17 May 2024 09:23:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v8 0/6] Break out as separate driver and add BOE
 nv110wum-l60 IVO t109nw41 MIPI-DSI panel
To: Doug Anderson <dianders@chromium.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 dmitry.baryshkov@linaro.org
Cc: sam@ravnborg.org, daniel@ffwll.ch, linus.walleij@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 xuxinxiong@huaqin.corp-partner.google.com
References: <20240516072039.1287065-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WNgF7X2=Q-yujVfbTpir3-5nN85Gc+hV+xXY6ZOWSwSA@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAD=FV=WNgF7X2=Q-yujVfbTpir3-5nN85Gc+hV+xXY6ZOWSwSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/05/2024 15:31, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 16, 2024 at 12:21 AM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
>>
>> Discussion with Doug and Linus in V1, we need a
>> separate driver to enable the hx83102 controller.
>>
>> So this series this series mainly Break out as separate driver
>> for Starry-himax83102-j02 panels from boe tv101wum driver.
>>
>> Then add BOE nv110wum-l60 and IVO t109nw41 in himax-hx83102 driver.
>>
>> Add compatible for BOE nv110wum-l60 and IVO t109nw41
>> in dt-bindings
>>
>> Note:this series depend Dous'series [1]
>> [1]: https://lore.kernel.org/all/20240501154251.3302887-1-dianders@chromium.org/
>>
>> Changes in v8:
>> - Neil think need sent separately to ARM SoC maintainer with "arm64: defconfig: Enable HIMAX_HX83102 panel patch ", so remove it.
>> - PATCH 1/6: No change.
>> - PATCH 2/6: Fix Doug comment "return ret" change to "goto poweroff".
>> - PATCH 3/6: No change.
>> - PATCH 4/6: No change.
>> - PATCH 5/6: No change.
>> - PATCH 6/6: No change.
>> - Link to v7:https://lore.kernel.org/all/20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com/
> 
> This all looks good to me now.
> 
> Neil: do you want to apply this series plus Dmitry's [1] atop it, or
> would you like me to? Dmitry's series has a fix in it but I don't
> think it's critical enough to warrant the merge conflict that would
> come with putting it through drm-misc-fixes.


Yes, it's not critical enough, I'll apply this one now and switch to Dmitry's one.

Thanks,
Neil

> 
> [1] https://lore.kernel.org/r/20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org/



Return-Path: <linux-kernel+bounces-362762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24F99B918
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491581F216AE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAC013D619;
	Sun, 13 Oct 2024 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/3WvY/U"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80B13C9A6
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728816271; cv=none; b=AUqaGpDjeNkR7AfoO71GUtBWgpiNyzk8LTl0MZlkajRytW9iukT0ghS65Kt/TRYvL1wQpFopOFUlHpVNCui2KeghZyLwI/SIggJbMIRGKJ0dbh1Id4c8/GW6tFS5jfiJAtxgwy1P72g+thWsrUrp2yasPGiZMObjL8nhiiZjmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728816271; c=relaxed/simple;
	bh=X/WzFSNG9UXVDe5ObTkY2Z9LAkPpAaQBZa/87PdOLYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHsyNPXV1FBUG5b1FA4p8oYVBaoMkjwvMPdeNg/x688XyNy6nDav3gk9sjWkVoOqOyoGbpg2lS8Vl2H1GsEDIF9jic73gn1OXON4Sm4O6BhcEIF0hFfDMgZ2tl/RW9X7CbliyzW7cQHZojlgQCwFM+q97cvj0Sr4pYSjXMsc8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m/3WvY/U; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so1406516a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728816268; x=1729421068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ts1R90nEHJoQVeK5SWtRBNEDE+lrpIhze62//d5StiQ=;
        b=m/3WvY/U3e1yH8+HXzdih45aEZclBSn2ZxMJwaWEwR7kqo3cTPTt4S93bpaBZNyiov
         rdAgqySW/7s+a4E81NDlWyqz3KZgLbyCo4Eq8ArE7z1z7Fo0Q8GiWXYdVEwKGNC0j1/Q
         /+Zh3JiFUbPx5SYunAO5NPYxX3I5F/5Mc1Z2aoZhe2yjZpsLIxVcvwe+tNlJBH4VYjEr
         QNAq2mJByL1zqtConkbqyp/zebQdlLwdpb0UCRO4GYv/MM7FrC4xasY6aJe1OyRwHJ/S
         L9W9tIcxqWZSUqNcd4flaYltP0Ym7k1C/nZarSBNB4HvWGUTZYvzbyctlZRTt2ZBrpda
         9AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728816268; x=1729421068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts1R90nEHJoQVeK5SWtRBNEDE+lrpIhze62//d5StiQ=;
        b=lrFW7OKhmBmvBPhNJmP6SbO8I+0QsdDdwdnBh/J+mjHwH9SZcl//YpXkqqugQlHMIV
         APol2uFKSgIT2jDMF+Odx2+jidLDq/QDUlb1Npsr9draFNBkr7EC0y63r4lHEzJNfbr8
         OvYscAHCmSreVEl3Ptnye+afBiZp8HXL08L4PJFIO1NqWOEt1PSv7w9GPyujeHhJv4o4
         /HN1mMYYfLcdh2Pal8juLbSZl32CP8yekxUkoCC/cS4Pps8Y6s08L5FzF8ZQ11jsHBID
         4sEy/DnEoJ/kDLbNMl5qKoEtUsRwtOcetjGQG/dpjn1VcTyoMi0rvR3SPtz49NolgdXB
         unJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuO8UGzLF9lw2U7Jmu1KDh6p7aiFxMn7XIJ1HasAubYJH2JqD6RD44orLU18XOQ0pqDXtjfrdBxwlI4Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/SwHGi+MXloUZhlcFxkgjENeMT/V3PoL6jpFd9Tw2pNgGjeNh
	AbUJ24ykRd8+M/BpshTTxFgV08pvO/24G60bneJJFSnZEPOm+MRs/zMpj+g5PYg=
X-Google-Smtp-Source: AGHT+IFiRsrwKX/5PtJcK4cGmlJ2UJ7yOCgzC+qEpTHb5ZJ+6wBKnUiuR8gg5WwUrpxesrYe7fLvbQ==
X-Received: by 2002:a05:6402:c41:b0:5c5:b7fd:170a with SMTP id 4fb4d7f45d1cf-5c95ac50794mr8118037a12.28.1728816267533;
        Sun, 13 Oct 2024 03:44:27 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f8dbd6d0sm122556866b.200.2024.10.13.03.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 03:44:27 -0700 (PDT)
Message-ID: <aa140a74-b473-408c-8529-e12f0e285759@linaro.org>
Date: Sun, 13 Oct 2024 11:44:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: dt-bindings: Use additionalProperties: false
 for endpoint: properties:
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Martin Kepplinger <martink@posteo.de>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "Paul J. Murphy" <paul.j.murphy@intel.com>,
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
 Tommaso Merciai <tomm.merciai@gmail.com>,
 Martin Hecht <martin.hecht@avnet.eu>, Zhi Mao <zhi.mao@mediatek.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Mikhail Rudenko <mike.rudenko@gmail.com>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Umang Jain <umang.jain@ideasonboard.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Dongchun Zhu <dongchun.zhu@mediatek.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Todor Tomov <todor.too@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20241012-b4-linux-next-202041004-i2c-media-yaml-fixes-v1-0-a2bb12a1796d@linaro.org>
 <20241012-b4-linux-next-202041004-i2c-media-yaml-fixes-v1-2-a2bb12a1796d@linaro.org>
 <20241012180935.GC5212@pendragon.ideasonboard.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241012180935.GC5212@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2024 19:09, Laurent Pinchart wrote:
>> +          clock-lanes: true
> This shouldn't be needed, as the sensor doesn't support clock lane
> remapping. Could we drop the clock-lanes property from upstream device
> tree sources instead ?

Yes probably.

---
bod


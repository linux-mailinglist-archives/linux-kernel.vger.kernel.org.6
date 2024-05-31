Return-Path: <linux-kernel+bounces-196966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD798D6458
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B69EB246B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50069199B0;
	Fri, 31 May 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H63gkFt8"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E314290
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165237; cv=none; b=U1K/3idNFtYmclHV1NDMCApRFmVV03w6ecJgMIOGiqD+oDHb3oA+wojoLGPGzXm30xPw5RnEfmySJvHmbBNNGusYs8zNUGoz0DNKqRpl5un4QWczziSvShJMyTyxeAe6o3AaxwilLjufHDyd/i/0Q4n+6RkLSm5HY7me9pA/tGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165237; c=relaxed/simple;
	bh=KzEblG+UBmVvZj8GKGJDWzqcl+vAZI6CULfRGM9IZeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLcgFAG1jGWcD/ZHVB7qnzw+QbQBxERfc6FH0u1fipJ+boGD/BNr6Yc8TjgTaMDI9q7OuXrRztWvD+VGFnsMdpquavDnHKGmDgdyXDPCAk6L+6c7n/EW4JhPSKTthtGIwsL5J83O/qKmcbRRgdtHeZED2RFlg7uZILMmoww0XoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H63gkFt8; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7e22af6fed5so10816739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717165235; x=1717770035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+VibLQtwZz7JsVuJcW09ZTb85DGOzOVeX9MBCZ9kfg=;
        b=H63gkFt8JHAvBkMhlTHY45axXqAVd8Ks+ApKoaCSM1sUK7fd2IAOmMrgxQHVZ97V6N
         0TSJBhBGJg7dvCwd4g5i3FLwMlELgjsqWI2Fbuitb2rp0r2YUmFkNCjY+/j0ZIc64QH3
         0eyYqQRLqRCjOMbVtoh4VdcAnSwTm7KyIafxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717165235; x=1717770035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+VibLQtwZz7JsVuJcW09ZTb85DGOzOVeX9MBCZ9kfg=;
        b=ApiOSmX9WWkdZjt1ycIxhogYggwSQlKlvxFVnhgQEmfwgeeX7N67aoFFiVN5+g+oje
         4a7NQYwJdHq4Ev52K2ueIPEzmE6prQooHrjnX4TiXpr1/GMap65ct2eMqPdXVMb99e29
         8JHACCILiGV5y3zeihubIykWBcp+2tIvbKyhiDD7I6zRDzvwIgCl5s6R3Nt9pcJM2jpC
         SRqVTTsMw1MXL3nBxVfsRjwrhGp9wmK14fbI4/RAsVjrZiF9IWGoZH5a4B9uF+3T9Ukq
         VJixpCVv0+6dLp+iPUh88Y8Q2iw7nEdCPtBjIgj05MJlpnz+0OLAjGUSBc9Wx2Y08+U0
         QwAA==
X-Forwarded-Encrypted: i=1; AJvYcCWFR87tu9Hyf4sv9Y1th18ObpErSl0O6XVIhcgz5xbCHUeM2gjPigg9S1UxFiGTwqjEhociij2PdpqgAhjDytTbg40qq7/EnJXuOJZJ
X-Gm-Message-State: AOJu0Yws3lWJVnyB1RW425WskaAc5W6Rdo5F7d/TA3u5n9b2mY18zyhQ
	ViGG5l8a+RNa9iiFMfQJMqo/eNbh6a2Xj3IKB3We5gpp1F5ZYMSGkKcP07Kex9g=
X-Google-Smtp-Source: AGHT+IFucIP1XY+8lNyDc497JR3Cn/S9ZLDLxEWsA4aPUq5KWN7j+jKcMbBK72UCzEokx4RbxnQdFA==
X-Received: by 2002:a5e:8b09:0:b0:7e1:8829:51f6 with SMTP id ca18e2360f4ac-7eafff1f512mr226430539f.1.1717165235070;
        Fri, 31 May 2024 07:20:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b4881d64a1sm500136173.43.2024.05.31.07.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:20:34 -0700 (PDT)
Message-ID: <16b1bcb5-00c6-4b59-a880-188bed32d175@linuxfoundation.org>
Date: Fri, 31 May 2024 08:20:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/accel/qaic: Fix typo 'phsyical'
To: Danish Prakash <contact@danishpraka.sh>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Carl Vanderlip <quic_carlv@quicinc.com>,
 Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:QUALCOMM CLOUD AI (QAIC) DRIVER" <linux-arm-msm@vger.kernel.org>,
 "open list:QUALCOMM CLOUD AI (QAIC) DRIVER"
 <dri-devel@lists.freedesktop.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240531060929.5281-1-contact@danishpraka.sh>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240531060929.5281-1-contact@danishpraka.sh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 00:09, Danish Prakash wrote:
> (as part of LFX Linux Mentorship program)
> 

Please add proper commit log for this change.

> Signed-off-by: Danish Prakash <contact@danishpraka.sh>

> ---
>   Documentation/accel/qaic/qaic.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/accel/qaic/qaic.rst b/Documentation/accel/qaic/qaic.rst
> index efb7771273bb..628bf2f7a416 100644
> --- a/Documentation/accel/qaic/qaic.rst
> +++ b/Documentation/accel/qaic/qaic.rst
> @@ -93,7 +93,7 @@ commands (does not impact QAIC).
>   uAPI
>   ====
>   
> -QAIC creates an accel device per phsyical PCIe device. This accel device exists
> +QAIC creates an accel device per physical PCIe device. This accel device exists
>   for as long as the PCIe device is known to Linux.
>   
>   The PCIe device may not be in the state to accept requests from userspace at

thanks,
-- Shuah


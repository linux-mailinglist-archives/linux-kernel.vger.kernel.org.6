Return-Path: <linux-kernel+bounces-548550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71575A54659
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C9E3B0CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C120A5E5;
	Thu,  6 Mar 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fqs/3qdk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F0209F47
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253431; cv=none; b=D3KtmhlQH3eNpi0b1P6rbftuWCX5d0E4OZVE9yXNcsQK/szO+SgWnjOY7qrgY/56KaJhYuJ/MYedgWWxtk+MWOZ+Ahqj2d6m57URz7MNb5D0775asEkjDamTPwCPiobWYZQrARRa1S+HD2puPSmZjL7FGLGNnUrKT8D3xHEeBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253431; c=relaxed/simple;
	bh=zL6BTmVJ/wyDlBdEEGs0+CfmrEMOo5PpQZDbnR0Qa8Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XpGRvJH0CqfrFbTD6Xek+OpH/9iEr2dHKs5G5/B37cXMS3Bwk19RykKDja1tHtCAthdYFmpjKcW34FDXQzThZGc2+O/zVrjhhCm9p1UC1OjMpvfJGoAIBYJpojAHdvni++aqAwdV77QFSJn2qua/nxFb1eqNJbf6st9N5LZi/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fqs/3qdk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bd732fd27so3570625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741253428; x=1741858228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ncB2tuQORatDJdRGujzDM4Ip4LmUwzu5C0be3bbhYo=;
        b=Fqs/3qdkYKuaDvGGQfL9r0hiqaXWPrAKV5YEDMwIAOz2u0dZGs6V/HkPaSVf3gu5t9
         JVm3/Ymo2jNWfG1JzLJgY9nRjHIPGQemhL03JL6tAJZWGMx4SS2e91KR9RdzoeK08gX2
         QxuMUSM0ZPGALF/g/AxBZIWIVFfYx4aOlmtlNFDW2cKglIRWwvxPQ3jhjr9SHzizzhpx
         XzbtEYtOBeRS92yVKh9LiNE3QPtGzAVk8+KKbHEqxeeJzLo6bm9S1IJh3uOBJUOG3aG1
         vkrQj2MgRGyzSWox8dYef72Ty4zwOI4eX77+gpliR0pTvHoWo+KfDafNoz1kaN2q0L8l
         1sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253428; x=1741858228;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ncB2tuQORatDJdRGujzDM4Ip4LmUwzu5C0be3bbhYo=;
        b=pvS/oolkd4d4tel2388sV1TaMcE07s0Q+tgr+5IXe3qV3YBsdW/hzavP4h0keAF01g
         VXdF+VeLdO8PNpWlek9IcEIPz+1IHDfrEAhHivkdizSlujUXHdh6ifG1DhDqeytl/mkZ
         D0t4XHB3gMHsxuloz1Wij+CWwtFRk7+d/jJoPrW9Kz74B853HcxW355Km7wUme/tHGVK
         AOvuoT/9Mul2wTEfJc9sKtong3mopYVXc/siXqHKxOqsJTmEgvihfuYnq6Th4GGm3Dqt
         et4f6EJbTo8kk16MpxfYQacDWAyY2gwtk1+/0xDJZjjEvRwpg86OSKbvqlBDOGUO3NF7
         2bCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeEMYLQwV/wVMwCWXTHf8Vgrslkwg13+opK8n1+AKN/oX/+3eSOY/yb8qnb+euUY4kvmmv/eDb9CyRKuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1YLn35UxgGC36RPwgZvVVpO1rcTRNYS8fDKc2kpPiXrC6LpCL
	+OKNNbwTJl9UOk0j2r4IIeX7J2O54AlxMIfKF1QQyW5yQ46hmmTFsmMo5QUU6rg/N2LDapVALkB
	j
X-Gm-Gg: ASbGncvhH02jYxZar0zZc0VE0O3SZPUpAwfLvQVPIZ3uki8q+gNdOMNwNaOLhhgWILY
	1BtSWeYR7e1HAE4pqt5h83HUUo7H5PbzKpLia7tR0b8trs9HOi1VahMMHrD4WtLdiZ+gSziqu4N
	luXY5ncnDiq6K6Yk07MMk9CjVEmMjoGKN9/p/n1uhXwfA3Ez+tepfHHie/ErL6see0IXmoMWND6
	opE0RGxRYwJPs7DRY826tgJDDKbbIFvDBSSeQ+W/l6+glXnXrOqmGGOcNbAbEyLL7bKilu4d1RN
	kMv7Ho1MKk1i7WyvLBhxa2LQN+N94R9JYeiBO7MPkZSNPiGDQ533SnGQ
X-Google-Smtp-Source: AGHT+IEyknlGy0vVxl7IFJZZCVesAcPmZtefHHgNNLbDgMorbZ9ZZYO+JvFG/OeIm1Ql1Pr2uoj2Wg==
X-Received: by 2002:a05:600c:35c2:b0:439:8bc3:a698 with SMTP id 5b1f17b1804b1-43bd293f637mr53469645e9.6.1741253427697;
        Thu, 06 Mar 2025 01:30:27 -0800 (PST)
Received: from [192.168.1.101] ([37.167.199.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2b8bsm1440616f8f.64.2025.03.06.01.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:30:27 -0800 (PST)
Message-ID: <3cb174c1-ef1f-4578-b5b0-b82366d02ebb@linaro.org>
Date: Thu, 6 Mar 2025 10:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] MAINTAINERS: use kernel.org alias
To: Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306-update-email-v1-0-9a231571e905@kernel.org>
 <20250306-update-email-v1-1-9a231571e905@kernel.org>
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
In-Reply-To: <20250306-update-email-v1-1-9a231571e905@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 23:44, Dmitry Baryshkov wrote:
> My Linaro email will stop working soon. Use @kernel.org email instead.
> 
> Signed-off-by: Dmitry Baryshkov <lumag@kernel.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29e1a423eee5bcf9df7938aaffe5bd3e2f6a2bbe..b3a67e278a839fa14d1329a249ecf4bbec00c26c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7459,7 +7459,7 @@ F:	include/uapi/drm/msm_drm.h
>   DRM DRIVER for Qualcomm display hardware
>   M:	Rob Clark <robdclark@gmail.com>
>   M:	Abhinav Kumar <quic_abhinavk@quicinc.com>
> -M:	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> +M:	Dmitry Baryshkov <lumag@kernel.org>
>   R:	Sean Paul <sean@poorly.run>
>   R:	Marijn Suijten <marijn.suijten@somainline.org>
>   L:	linux-arm-msm@vger.kernel.org
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


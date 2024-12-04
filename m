Return-Path: <linux-kernel+bounces-431175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EAA9E3A03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B9A162E7B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3FC1B87DD;
	Wed,  4 Dec 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ou3bnwiV"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612AF1B21B9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315483; cv=none; b=RIl8nhQ85Rm+fx6bOCKdOmZxKg1YTE8E2xNrXXhLFOQP67iz5b8wyt2CzXXSZfKQ05jxg2rGhCZX22vAktMEgMZTOhb+/g/+ufGT9wrBov5GCpRZmF5M3xHyD0qely/yY3ziDRLGX2y2JHKE+HsDoOGECLIOXpUcW4RKzs9eQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315483; c=relaxed/simple;
	bh=AqCXH3JLVIO2d5FcjwyUEOOgKwBIBl8MV2/t7UJiXr0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jSIroKHLluT257qN/GAJcc7et36HHQsN+AiwYCaI8w/DiEbDAJgkRVgkostU6Mf+vKIRkCUh2k6ypxTZNd0KhB+pzMuskfauJWaBlPt9El97qUQvGSaHKxBly+eu6+wP1SUDSrpdfr4z6ittWdbenx3hE8vquDcH8tlDxYpzcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ou3bnwiV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e2880606so4582372f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733315480; x=1733920280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbWwdT7tE9INHbs3KzJyjOSIJ8TmE2VppwJHxa8fgK0=;
        b=Ou3bnwiVYN1lAlL32xZh3CitOrSNKGpYvn8acBSSUag4dN8746QWkWW9KGACFVWuz0
         7hxKXQ0vVydlL51F9UcpLMFnLzehuh8UI2uWh032Kc9Knb8OTTcgZNBRYsAq22dmZIHo
         rMlQc+bU1MGZN6vO83r8Ih3YSPaUwWXkgzEyDAQJcsROmBipN3ZsIvlQUk6fE7FsOoKH
         4yKC+6sNSnhVwmsjSr3n8Gl7tT9hnlBe4ltVCQNalJpONZlIMo+a4Tny6klx23uXxkdP
         EQBG+aSxfUAVQDt1flUL1FXv4LWOgc7DbX5jVISMCxC42wOLAHNC0sC/oeFrfs2O8muI
         Fwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733315480; x=1733920280;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cbWwdT7tE9INHbs3KzJyjOSIJ8TmE2VppwJHxa8fgK0=;
        b=pWT79G5kRrPtg6tEC0O3mvM5RSm0hET702iHTaIlUpsfIIBserPNhq4RdH0Olpj1um
         TXF5x1d5VfgoiBRk6k8Xs/jiamtbng2vPqpBjR5cKOrdJ1bvDVrUE7OY/q+7jS+rD5L/
         s0Ohv7rtuobIUnV1P8Z8OMp/eXqHg5xGLZBrk1lUbb7hd6vvq2jfS4esxc6LgA5fsPZT
         DM7KC60dZ8nigJ6BbpiYVddbzZmJJXVsmRWQoOglXa2mETu6pPZc1xkhUeB6Y9V6nhNJ
         1unYNBMKYgrurxrlKE0QUai+/oOfqggDeo3T8743qfvJ9R7gDz+szB+ykTQWxluqWi+r
         sY2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEI/+/mn0QiGYDMbfx0klvp10UDtGgItJFCHzFyCDlF6/SpxL4UdW037YGN1FXfOPLyuuvocn776q+jaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/t0eVr/XATW7kromunSMCX5369DOU9JejwRcZDMgpvUxQWPZv
	XXcGPrG73AZMsXb9xkD0q0YOpVkiRLZ2HKBuSbhh+SuEtYKRLx5+mQ43mbxwNPs=
X-Gm-Gg: ASbGncu+wyIxD27FIfeRAhAtbyUboZXtLUtoH6bXDp8b0F6htYLsvbOlXwY6AVXNRP8
	2uq7FYRIAS3KwGL8O1a/1YTNi0OQMrs5vVRRHxhFpizfif12tYqzAWZYYbdNrVa6w7ZbACkELjp
	KIfb+yWQtD47eDxQvjQCiSCPkd+a3IZ8QBU4zjW50SIiwpMVsxmrpuuQlKHBuFvw0YnM74vNAo6
	jcSvUme8Ng6JaMMsjQ5IYZCti4ouc1ME4HyaQ3UlWbHUpp2YXm7SVhCSucdxp4LjF5Ehdv3lXXU
	yE8j1STf+xivm+h5iuU/tOSj
X-Google-Smtp-Source: AGHT+IHlnaIAnJCdDW1tnpOh5zG5O4kkYOWjTdY1ooDYR2tXwky8ii+ehLuUnq0yb/fUFPuqeP2PTQ==
X-Received: by 2002:a5d:47cb:0:b0:385:eb7c:5d0f with SMTP id ffacd0b85a97d-385fd3f29dfmr7132352f8f.26.1733315479660;
        Wed, 04 Dec 2024 04:31:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:740:b323:3531:5c75? ([2a01:e0a:982:cbb0:740:b323:3531:5c75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e5e3629fsm12188615f8f.93.2024.12.04.04.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:31:19 -0800 (PST)
Message-ID: <6e4f39c4-fe74-4b17-b333-47ce64d458fb@linaro.org>
Date: Wed, 4 Dec 2024 13:31:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: display: msm: sm8350-mdss: document the
 third interconnect path
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20241204-topic-misc-sm8350-mdss-bindings-fix-v1-1-aa492a306bdb@linaro.org>
 <173331176548.4095099.9767845657326548018.robh@kernel.org>
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
In-Reply-To: <173331176548.4095099.9767845657326548018.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/12/2024 12:29, Rob Herring (Arm) wrote:
> 
> On Wed, 04 Dec 2024 11:36:37 +0100, Neil Armstrong wrote:
>> Document the missing third "cpu-cfg" interconnect path for the MDSS hardware
>> found on the Qualcomm SM8350 platform.
>>
>> This fixes:
>> display-subsystem@ae00000: interconnects: [[121, 7, 0, 77, 1, 0], [121, 8, 0, 77, 1, 0], [78, 2, 3, 79, 16, 3]] is too long
>> 	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#
>> display-subsystem@ae00000: interconnect-names: ['mdp0-mem', 'mdp1-mem', 'cpu-cfg'] is too long
>> 	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#
>>
>> Fixes: 430e11f42bff ("dt-bindings: display: msm: Add qcom, sm8350-mdss binding")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: display-subsystem@ae00000: interconnects: [[4294967295, 7, 0, 4294967295, 1, 0], [4294967295, 8, 0, 4294967295, 1, 0]] is too short
> 	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: display-subsystem@ae00000: interconnect-names: ['mdp0-mem', 'mdp1-mem'] is too short
> 	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#

Oh, indeed, will fix in v2

Thanks,
Neil

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241204-topic-misc-sm8350-mdss-bindings-fix-v1-1-aa492a306bdb@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 



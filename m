Return-Path: <linux-kernel+bounces-434785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B19E6B49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B11D285F05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD461DFDAE;
	Fri,  6 Dec 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovbQ6e1x"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF31EC013
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479590; cv=none; b=JjHp9xtha0Efiu4k/qJ9SRoYCX2YiVaBR4vYpvGBDBzOSJOBSokNc1N6uYeTF9S9rMcizXIbGJrJT+B/l0vsvz/UzxsRXWUc7qiRQ7En/z9zqKvAvUcoHz7K7SOM9Er3l/WuZPrlr+4l5i3Aa/r3ai+f97acyU5ZQwXg2Ak1OsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479590; c=relaxed/simple;
	bh=gr0wVuYzqbScFxXpZ52+ApK6ae+ON1Z8MAshwsB0Z0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaEYm01x3Jz8wqk48/RA0K8amt8z7p7Czwzp3ITYkiXcCgNG0tst0ggJSLAnnrUwvDwcXvL4ACaWZ0nKx4sWutFEMib0IWk1n4qXrRktg1l6GDOPRYitLy8S5h9W9HkTu+VX2ngzRgCVFPp/zi3WRbBcIvpTJUXe8kGluFHW6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovbQ6e1x; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3002c324e7eso11621911fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 02:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733479587; x=1734084387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kq5iLCatZqMNd1JIiH/Yx41KIxb4a7s0lro7kXyn4Y=;
        b=ovbQ6e1xHMUfZ/yLCzDdtPXrQFQLPHEgon+O1P3uGNkton6ekWi/ee/ALbUahAqzKv
         kJrtaZ9u8yd3BcqbPBsPdggm/U1aMkLm3Yzkg4By4vtMwN8T4KP7g0nteEDUMks/WJZN
         HmEtXsOQEQKLHdD2VQj9ah6IHx1Y+Pta1mdvzNhOjWaOSBJzhQdMriIHUHhsPWQaSl0L
         AjxLzKWy1YXiEo8wJMPAOtvjfLY0mxmmyJVMJ8grsGyykFFb0aVa8ZYDOl0vbaOynMPr
         23rW/bDHm0LT0blbR0DS4+J9+NYmqC+e461AO8PC32JuWvYg/4n93fZck/hXTgmtG7td
         cKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733479587; x=1734084387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kq5iLCatZqMNd1JIiH/Yx41KIxb4a7s0lro7kXyn4Y=;
        b=rBY3pzqzpc5kWP14ce8Gl2Z4S/3WR5+uZgD3JEaSF+dRxfE94hpZK9Y/FLWODSKDBW
         ssHT0RQEvBfCSyWtfGK15QsPNWz7X0UTP6jLwJxKovDh/Hcy0XNsY6CK/8SblWjVdbvg
         mRSTYa3yzFbvPs2VTl+LrpBMxhKupvGbuNetLWgVACFjK1WcaB3vTjK4OVpjk05p6251
         MHTO55afimpLzeWsyfKDAqhU/MSDKJ2VDD3HMxhwkQ/L+zUwPahONk0esFqZLNUM1srK
         Ddk+qRMM0dFXW0CobuMQFGvWD0Rih2+zJv7paCo8qdCwYM3Vvv2og7RPGWJdVmE3QMEq
         e6gw==
X-Forwarded-Encrypted: i=1; AJvYcCUFRemrUMdPdWAaK6EyrnewB4luJraxAoHx+4enC/Ee+8PZ0pPkeIajAsI+IpeEbs6SJ81yv/kkCHpm6B8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytxbaxs4piIZHAZDazsKPo3+7LnnABT0UUYwD+EyNmbbT+wQ9c
	+imwYZhYh2jNbC+snaFKxwkYBiLwmYken/eZ3rHbIkON4RL3D9IBwz97OlEtwF8=
X-Gm-Gg: ASbGncuFAFgjdf0eDZgXNYgtk7GOShgqC9eGj1g1ql/ClE3kGadVnIf8eKeZTj7T8XF
	y5aDC0iHo9BL0Wm6SX5mmY1DwlWm41zYrkCXu+FoFkq9EyWhe+xI4zxxMQ2ElpirxsfoAMHC1n1
	H1CVn/wBg3yMsnHEzqwpcX2loTNn6K/u1/zVb1RbhsBzGvsZZfbbx0Rf/RmrTm+p5wMdgRcMfAx
	tCjqcOB+VUA1WyChIFzJQ4vcElk6qwqRA1UgeqNJW2sVo87Opfx/QyK1JyyCsY=
X-Google-Smtp-Source: AGHT+IGGeMStTSdxcTd5bpMThyqNxEJJDfbzMe1IIVhlqf6bA9rVonkja56z4SWniuJeI0/SbZItnQ==
X-Received: by 2002:a2e:be11:0:b0:300:17a3:7af3 with SMTP id 38308e7fff4ca-3002f9140d2mr10549571fa.17.1733479587170;
        Fri, 06 Dec 2024 02:06:27 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48ab4sm1949019a12.27.2024.12.06.02.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 02:06:26 -0800 (PST)
Message-ID: <e5f89ace-3a22-41a7-aafe-1365f2fd9bcd@linaro.org>
Date: Fri, 6 Dec 2024 10:06:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Yongsheng Li <quic_yon@quicinc.com>
References: <20241205155538.250743-1-quic_depengs@quicinc.com>
 <20241205155538.250743-12-quic_depengs@quicinc.com>
 <0909a2b2-089d-41f3-82e6-f0e05682ce27@linaro.org>
 <2515c9d8-0e9d-4e1e-b8ff-764b53ea3edb@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <2515c9d8-0e9d-4e1e-b8ff-764b53ea3edb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/12/2024 02:18, Depeng Shao wrote:
> 
> Since the camss driver just support ife, so I think only ife related 
> iommus are needed, just like we don't add ipe,bps,jpeg related clk and 
> register in the dt-binding.
> 
>      msm_cam_smmu_ife {
> 
>          compatible = "qcom,msm-cam-smmu-cb";
> 
>          iommus = <&apps_smmu 0x800 0x20>;
>          ......
>      };

Upstream camss entries provide a long list of iommu entries, please 
provide as complete a table as you can here.

---
bod


Return-Path: <linux-kernel+bounces-417520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88F9D551B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920C9280EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5121DDA2F;
	Thu, 21 Nov 2024 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqGHjc7W"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C961BD031
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226478; cv=none; b=BpvFkmFH+Xe/RiS/dNNcYLvypf8QMX2/i71C60cbvBDIVOZIhlIUns7eLyWFWcIu5/aDj76dIJXIBVcRlB2ZV+n1ZsomUaAB8x7WSgYPKgreJGdNppr8YAfZ87qhzpS2yif/7GfKA8pWznswrB9wpxACSpYarAtFGosVFp3qvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226478; c=relaxed/simple;
	bh=oULDhTY9NKL7RUXhTGGxFaIwXHvE7IZ1UIswvh8QlU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiuOE29mumt9kaAzv3l0lipL1xJ4IgScyCZpaZkcjxN4zqxyE9dmoUcuHUt7i2dZnC93sD2xdHd+u3346ZA1iPAvUsrkED99/y/fMR4MdgATfxy7NgyFJU/wHxYE0MDNcBhl9QYvNpDemZYWyDrI1i5X8gT1+2e2dxLv3jGOr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WqGHjc7W; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53c779ef19cso1633378e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732226474; x=1732831274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PypIErFyD/n0BNOpM458f7rPV3XZUhIzNxg2aBsXTpI=;
        b=WqGHjc7WJA77kBg4oS3H44MbbnPwmVQYq83522AaVel/GYU2VOp5kvlpquzNZyVYYP
         JxKXiEegpEcxst2sFX6DyIZ0RGUtJCdIuHBkuoaCe9xD54HtTqzZ5UKPfgXyKKz0ungC
         28MB94MY301/ZWVu3X7NhXDR4lwdTxJ2onSyS6whYP991AvlksYQn7clqahyXx+wwMZz
         CdskYLm0CCreKMEHhNTswwwfbhpKe6qowlDriWHKeMnFnkhw4F6ApmPr23ZWIT0lDuu5
         +Kr4PALqB9ah1gJUNwU/Id9FW7o5R511CJSKddva0735/Y68D5NGf4LN4nhxWN/xS106
         CCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226474; x=1732831274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PypIErFyD/n0BNOpM458f7rPV3XZUhIzNxg2aBsXTpI=;
        b=iDyrEyrRDvvoDitQOg19TJjaY3Q7Qzs2SeJTARhxDLQgMGw8piSUQ3GwLWFDA/N6RO
         djt1U5U9HHuHqO2zjmOVLA7/idO21qjxTWppI9KlYitNoUFAMalTGFGlg9C9N5TdKqdV
         fgS6PhYQ/45k8Lw9Z7YLUO91LKIW1NyivYgUu1CEDseO/UiO9j4P+n9aaeJASvdbeKF7
         ODrOYE4UzwOIl24hdufr9ygy/Oe/BMiKOwby0mnGdVmATDoyYgmSh1a2M2VFLuy1I/V3
         vl+uqZIWZFiZdKanqIVz1uh8uHp4z4Kiov4xCzx7ybBBR9zrHRS7w5mY1hpU1ZsY6O5u
         Zfyw==
X-Forwarded-Encrypted: i=1; AJvYcCUBavwQEJ6R4+c+3IwkKMOSvI4dWRW+XelutR+u9ZlgoQkxjcCr9JXPnoguFRx7/F36S0Aj9MSC7vvL2Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGYcB7EjMXNVLVlDkHjyHYcX+d8S8UTn8issz+ZjKkWy7wrSj
	pdwshGAf0KT0tO/+aGKeYm+TkJU9uXBUMEsDWrEzvW2IfgAT7VNCOl4MzOtygWw=
X-Gm-Gg: ASbGncv6mk+FS7ZRFjI5gLwI0O2de+TZLu1V5ve81BmtnmEBskdGEj+hHOWPEYXk1nT
	EZtuu1wc1InLSTUud9jmc1onq7IqBxXpPRByGXohUM6I34uNMwXeyYPeFKNHHpZbtpRunpJYex8
	qYHnkspl3FvAOIIqpkVlTKpjCgHLlZoWxM3bI5TjcWhNHqBqSo9LEeBCKU51BzeN0ZkqOPzPujd
	DtxyZad8ppu8rJARel/LSmS5QyiTDnDKLgqVhCyjWYbm5Ce9oGN4pMLGf32wtozzk6HrU6c/Qid
	eN6Fim+0gTBvmp9i5xA00y7Ftu4aIg==
X-Google-Smtp-Source: AGHT+IFFL2q/vIMRHr/WtuLEdj4EJHjWtGPHoUZcmjYRAKu5VLoo+jdnHtTWOwZ8S+bh83TLTJUqqQ==
X-Received: by 2002:a05:6512:2382:b0:53d:a8d3:aeca with SMTP id 2adb3069b0e04-53dd36ad5e2mr186652e87.28.1732226474029;
        Thu, 21 Nov 2024 14:01:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2499fccsm89849e87.270.2024.11.21.14.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:01:12 -0800 (PST)
Date: Fri, 22 Nov 2024 00:01:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom: drop QPIC_CORE IDs
Message-ID: <fuplqyfqvfc6foi4tdsts53kvdokfzprxwxedgi6hyxicedvvk@3rrx67vihbex>
References: <20241121172737.255-1-quic_rlaggysh@quicinc.com>
 <20241121172737.255-2-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121172737.255-2-quic_rlaggysh@quicinc.com>

On Thu, Nov 21, 2024 at 05:27:36PM +0000, Raviteja Laggyshetty wrote:
> QPIC resources are modeled as clks, therefore remove corresponding
> defines from the binding as they're unused.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  include/dt-bindings/interconnect/qcom,sdx75.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/dt-bindings/interconnect/qcom,sdx75.h b/include/dt-bindings/interconnect/qcom,sdx75.h
> index e903f5f3dd8f..0746f1704ec0 100644
> --- a/include/dt-bindings/interconnect/qcom,sdx75.h
> +++ b/include/dt-bindings/interconnect/qcom,sdx75.h
> @@ -6,10 +6,8 @@
>  #ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
>  #define __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
>  
> -#define MASTER_QPIC_CORE		0
> -#define MASTER_QUP_CORE_0		1
> -#define SLAVE_QPIC_CORE			2
> -#define SLAVE_QUP_CORE_0		3
> +#define MASTER_QUP_CORE_0		0
> +#define SLAVE_QUP_CORE_0		1

This changes the ABI of the driver. If this intended, please provide a
reason for that. Otherwise you can not change the values for the
existing defines.

>  
>  #define MASTER_LLCC			0
>  #define SLAVE_EBI1			1
> -- 
> 2.39.2
> 

-- 
With best wishes
Dmitry


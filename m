Return-Path: <linux-kernel+bounces-513977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B807A350F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F873AADFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A31714B7;
	Thu, 13 Feb 2025 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OX8Q74YC"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369D245B1B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484566; cv=none; b=BBqjaKZZQ579fnC2HNLO+6oDG3r109mBQN+INedej5lqIjF+QVm3l5CxvnqIFKGkXgx5sRr+j8/poqKvxnddNgizdpNUBcTjGlbhywD71hhGAB5pkG2b6XZixOR6C+l+ua6JBFy8sUc9ZPeXkB8Gkhioe+NZJKSn4MyvVWZqwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484566; c=relaxed/simple;
	bh=TiogawfA+d8HAgfcQDsyQvJAW4KatS/M0fvAd2ugozE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZaWf4VVo2IK387CtGOJpZe8R+bKF4SZgU8rk05gZVd7Ips5ZT6MVkFxoFt3vGi6VpfdcQCkiZBGsccDhTSQX6Od0970JbJ/7an7YDEzyFIN+0ffjhD+Pg+DFfuakyDuXeSyVIJ1YP7lC5Y8VQ8Qv8IqnQuhF7c66r0ujMDrdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OX8Q74YC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308ec50eb3dso14683061fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739484563; x=1740089363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxuQQ2aIsssajEjEPLBiy4yR+691Ol3xWx3H0aH87Bo=;
        b=OX8Q74YCeHUIU+ahbFWfnVFxeyeM+wpFudVhM2USdzBzRuCvi10S9iSKZTzTzNHFAl
         e/X8HbLGHIZzxAuni+2keviN0t1Azivnc9+6Plo5x9NQ5JzqSpHn8uVOLJVkJSAwDLVA
         2zmmUSjhLb3yz59HDX2DjkfL5isMynBpbePTel/wM2k2cz78EYgrK+brP7jt3K6/f/2N
         7Lq49YkMG76pLjyFbqrzI1+4zgUE9zJps0FB0cv0p2C924Z4VKNDZw/c58WYcgWvpuPY
         G9esM+HtfFdNY6Wp0cxV6ZW3mm6yoXZlmdT2HWk5J/N0ADuQ+qMa/G62Z2bVuiovIQ8X
         kjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484563; x=1740089363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxuQQ2aIsssajEjEPLBiy4yR+691Ol3xWx3H0aH87Bo=;
        b=LaMNY1ShWZFSw8KA7/68bpQudAYIMI+evdN9KHPLHOFaWfwgo9BNTp/jwPWs+kDdYc
         rsOtoJcp0smhtENqJK4CN3lgUZ8PGSW0U9wqP8H7rLBgFGv3Fr/8yRLbo33vLzk+/VF8
         h7Bs0s79N2rd4PiyqNvrkA5k1hbzX1ii6Wvg1S24pE+Ke0+V9M2jskZNQjeD2HsUkY/V
         N75irjAqDxkPlavF/uNTT+v1YAc80iSUWLxQ1AGdn4y4ohlTRAwG7of3+ic/HA+t82Gw
         aip1LLi5kDxwOCMv6Pn5VJ7tbJDUrDRMFPM04K3v1eS9F2fJ3ywBn0lKk/ckis7KJ9jL
         uQTw==
X-Forwarded-Encrypted: i=1; AJvYcCX4b+KBLi+j5nttIvt8WyypSOYCJfiY51XSnG5lK+NZ0Lo57X0c5dA06MDi5CPjztWkstdLlWt0EiMzzXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeArO++iuM6KNyn4ADOHidKGD7NWOZ1Rb9ZugOu3GdNLqjl6Nd
	Hb04A3RpyKl1sbs8YcbCBt0+rFHGQ9hoblH2W0qStFZq7+Hw+BKHsBdJyuJRZm8=
X-Gm-Gg: ASbGncu1qSzACZBGXpIi54Tzu1ucGU+na+tuZDbBFxyd3AjqN39RETNct+OlZCZTdD2
	LWVZ8i5EIvWSBgfaYS2NkLMk4WMq7m1POo9kVok33bIWkRNUkB9NIaelbfdars9VPwoOSPQQ6N6
	MkiKlQPF1skdICUS5yg2zZd2oQmbV0ESdjKFB/k1TIpbgZI9GafNMTMcfujYZhyKwuoPO42YNpI
	2b3VX8SoI9drvzHNs5z+boQx1i7MVWgd2PPsZ5ySTbEx+a2BPFCXtV4WcoILiJc5szQq2/10T00
	JL3R6/ptLGqHaxLfPN3GkXD2hrIfvPzhoKd7KOkNPAGXfo19fN4r6vqN7pfmZog+UnsPpMc=
X-Google-Smtp-Source: AGHT+IEQZiaXM9iD4RqwV8Exvhjv8IXXzp3pQe7MYgKZr4kvCi50te+wsM5WWvl1NzvFC4pn4eF+IQ==
X-Received: by 2002:a2e:bc16:0:b0:300:2a29:d47c with SMTP id 38308e7fff4ca-309036d731bmr35341951fa.24.1739484562644;
        Thu, 13 Feb 2025 14:09:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100c5751sm3165361fa.14.2025.02.13.14.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:09:21 -0800 (PST)
Date: Fri, 14 Feb 2025 00:09:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	david.collins@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] thermal: qcom-spmi-temp-alarm: add support for LITE
 PMIC peripherals
Message-ID: <2v2nxdv2ofd2cwvatrpmo6w7o46o26y6w77myioailuin5ymal@z2mabzkbcrgl>
References: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
 <20250213210403.3396392-5-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213210403.3396392-5-anjelique.melendez@oss.qualcomm.com>

On Thu, Feb 13, 2025 at 01:04:03PM -0800, Anjelique Melendez wrote:
> Add support for TEMP_ALARM LITE PMIC peripherals. This subtype
> utilizes a pair of registers to configure a warning interrupt
> threshold temperature and an automatic hardware shutdown
> threshold temperature.
> 
> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 204 +++++++++++++++++++-
>  1 file changed, 203 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index a10f368f2039..081db1a85b8a 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -22,6 +22,7 @@
>  #define QPNP_TM_REG_TYPE		0x04
>  #define QPNP_TM_REG_SUBTYPE		0x05
>  #define QPNP_TM_REG_STATUS		0x08
> +#define QPNP_TM_REG_IRQ_STATUS		0x10

Is it a generic register or a LITE one?

The rest LGTM

>  #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
>  #define QPNP_TM_REG_ALARM_CTRL		0x46
>  

-- 
With best wishes
Dmitry


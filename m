Return-Path: <linux-kernel+bounces-563824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CA6A64932
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B1A173830
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66244233731;
	Mon, 17 Mar 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCLEPjLw"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDE233726
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206458; cv=none; b=Vu3m7RzKeQiimMru+5JrJYei8X2W5dJOHmRy+T6/D8abSsVIloQgBz9FuHxN0zaqpIzw8D3Mb+EN1EiqtqFUbhezaQW3fypm6kAc+Sq7XkyMfBp9bocqHDkwkTH+xDVeixPzdMz2GsaAh2epiHXia/XPL/30LdZY6KuOUaiTK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206458; c=relaxed/simple;
	bh=sZB0Xl2Pp1TkHFdbxGqYaPZTq/4+leRWWiqvKWe5oLE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nRNur7q9SpqNuRdI5Zk6bfjxLYYzdCiGTjLxMkCGwH4PqRXaO7tLIT5H4mhMsizfSQ5CLwfvvFXSFpTvRISn6Rl8j1hEGUs3GdFD84SyS6zYx+RQvDmR0hgPgoQ6fx3LbX+jepArbvhzpBDCnBDz5XWG2YhdvKEadCmD1kA7DEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SCLEPjLw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39727fe912cso885312f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742206455; x=1742811255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkFf4kCvzevanXv5Ra3CouyTzGW5e0hWlak1EUbm37A=;
        b=SCLEPjLwCpeVqrB7A4HqcHwctCEWEJjo6fkvG04erA/h5lHZE2dgHEQrlwnO1dV6po
         /i5m4syyjqyWFJmXlj4rt+3Mu+OoE4iSvhxWRRryq/tPRvzIZw3TdzmNz5HmpnBMigiu
         89hPKpsONSN/JjLFkOTRzfAWimXwj23Ekcrg+ntPrLhsihIgOeLg6yDOuCivZeK9WkW6
         TXIIL97HyBJT4BYnnzbrqKj9quWFNhx0IrWpH6kwd5MzmNzfq61vflRYdBCdjpafImIP
         vRDfnyY4Ijpc2ajH8YWtacZ6xQ90KN2yvlMcUh5JnxpN5NvznniA4GLATspGY5R7kcrP
         Ozrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206455; x=1742811255;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MkFf4kCvzevanXv5Ra3CouyTzGW5e0hWlak1EUbm37A=;
        b=h/zd+mT/OhJghaGeNYR95JMsRA9XCFsB/V45M0qBVrHX4u87bZx6opwp/Cwxa1+8PK
         zD7ZsTkViPZGJlq9u80z60YeKVH10GI0VMHL+dBNtV8kNMjs1PkLusV6wAfjg/S/e2GF
         ujDv2/r02GP60MUCXNgMQOO1IlgC/ZcrIVNTcSG5c61XvIGmq/K+tgRe3q34/scap1/N
         C2qYkmDhv1knPxrmD4OhdOjnuWiwiaAp44s05Jusdl50pN4SlT1HZ6o+ZJEcdZPYybSa
         z0C8ucuINyPIp/MBU0bSXJ6+X/xi+Ncm+RerkXwoutFDi3UgVF9CyGI/b4nfk6wGpQkW
         aSVw==
X-Forwarded-Encrypted: i=1; AJvYcCVyn5kRkrYpbN0w/+wDmYH0UPxupZ/zRtVPQxiur3Gsjn6rl6ArDckxwYk308I4zeYDpA1KdDrGzdcbSUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDhguvwdIZns+NszSInHHg8JSTHvyN/mWGcOX+GzNaLaLnEmQa
	Vn4ABcKxkuN8RiVpS4lP/sN5kWh7ewzK4rx8YHPG1wORDWAxgRpur90kTUU5pBY=
X-Gm-Gg: ASbGnctAGEOB9MYP2cbH/eDsWJUF9IWkO1L6dWrV16qdrGs5f4Uizny7aWddDz7TmSg
	iJ8CMZz5XW/t0ubBVD0k9vtihixGe1h9koTOh2eQI75gl/35/ILIUHhr4MYDjD3gs1rylCjccJm
	FPj79f+WHy82IXeIu/gnxdv1JdJrpA14VGFnLazvoh6Vm7jCERiRVrtGKIoWZdFcncGbIq03/BZ
	1fbgOTw61x6qJ0zt8XGsDblDw0OC5X1DD3Y8fsrnyAxQ3e8+HyzuabGDn6pQCadMBUdENEPsDct
	BktOYBXN0kEvYVqyD0wpQbY/s6KOy9+/kMe2s1JEYgLYV3h1aM4qI8SNIsiQzvmb35vI1dUA59x
	pYhj7Ru2Po5UXUWJUDDUO+w==
X-Google-Smtp-Source: AGHT+IFg8DYdHdUMxV4ttCgnYaZlXCiwiHVT/Zz0plPz8BiWoKXgYkhHYAZJWNOA3PzN0BKVDvL6AQ==
X-Received: by 2002:a5d:64c9:0:b0:391:39ea:7866 with SMTP id ffacd0b85a97d-3971d8faedcmr15996408f8f.19.1742206454898;
        Mon, 17 Mar 2025 03:14:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:55a6:4776:6e68:e626? ([2a01:e0a:3d9:2080:55a6:4776:6e68:e626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe6a1c7sm100284585e9.39.2025.03.17.03.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:14:14 -0700 (PDT)
Message-ID: <78758343-b9f9-4920-977c-cab4b5f84679@linaro.org>
Date: Mon, 17 Mar 2025 11:14:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>,
 Doug Anderson <dianders@chromium.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Tejas Vipin <tejasvipin76@gmail.com>
References: <20250314-b4-mipi-synaptic-v1-1-a64ccb5e5c66@redhat.com>
 <CAD=FV=XUN7CcnjURs6xfVAFqvZ1WR86y8nQm=OMcrV_hYjq5RQ@mail.gmail.com>
 <CAN9Xe3TpwwBtfXD7oii3VR8-ijDN_WQe9JUTC5bE_7vFQVRN3w@mail.gmail.com>
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
In-Reply-To: <CAN9Xe3TpwwBtfXD7oii3VR8-ijDN_WQe9JUTC5bE_7vFQVRN3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/03/2025 18:40, Anusha Srivatsa wrote:
> 
> 
> On Fri, Mar 14, 2025 at 10:20 AM Doug Anderson <dianders@chromium.org <mailto:dianders@chromium.org>> wrote:
> 
>     Hi,
> 
>     On Thu, Mar 13, 2025 at 9:47 PM Anusha Srivatsa <asrivats@redhat.com <mailto:asrivats@redhat.com>> wrote:
>      >
>      > @@ -181,24 +162,15 @@ static int r63353_panel_prepare(struct drm_panel *panel)
>      >  static int r63353_panel_deactivate(struct r63353_panel *rpanel)
>      >  {
>      >         struct mipi_dsi_device *dsi = rpanel->dsi;
>      > -       struct device *dev = &dsi->dev;
>      > -       int ret;
>      > +       struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>      >
>      > -       ret = mipi_dsi_dcs_set_display_off(dsi);
>      > -       if (ret < 0) {
>      > -               dev_err(dev, "Failed to set display OFF (%d)\n", ret);
>      > -               return ret;
>      > -       }
>      > +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>      >
>      > -       usleep_range(5000, 10000);
>      > +       mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
>      >
>      > -       ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
>      > -       if (ret < 0) {
>      > -               dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
>      > -               return ret;
>      > -       }
>      > +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>      >
>      > -       return 0;
>      > +       return dsi_ctx.accum_err;
> 
>     nit: the one caller of r63353_panel_deactivate() doesn't actually look
>     at the error code, so this could be a function that returns "void".
>     That was true even before your patch, though. I wouldn't mind a
>     followup patch that fixed this. ;-)
> 
> 
> This is anyway not merged, Maybe better to fix right now instead of a follow up patch?

If you can, yeah fix it now !

> 
>     In any case, the patch looks reasonable to me now.
> 
>     Reviewed-by: Douglas Anderson <dianders@chromium.org <mailto:dianders@chromium.org>>
> 
> 
> Thanks :)
> 
> Anusha


Thanks,
Neil
> 
> 
>     Happy for someone else to apply it if they want. If not, I'll snooze
>     this for ~a week to give others a chance to comment and then plan to
>     push to drm-misc-next. 
> 
> 
> 
>     -Doug
> 



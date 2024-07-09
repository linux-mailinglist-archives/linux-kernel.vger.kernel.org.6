Return-Path: <linux-kernel+bounces-245707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8288592B6E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48651C220BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD137156F37;
	Tue,  9 Jul 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8vlCWVc"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706255E4C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523881; cv=none; b=SJ7HSWx5c/TJSCz4ORM//rxqrSQVdoxSYBXIMWf1rlM3NO4VD2GjNhQ0Qg4FkB/NnDgUkaMkoC1uTdliq0KVXemDkdZ4bA0HoL4XDGoIDBlXHRqwpRO8WEFw2Fqdg222ry7KAofoun7h2n7Tdxs7xC8vMAaVRlBZvD7QJTQYpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523881; c=relaxed/simple;
	bh=RXb6uBU966n968LSvF2zPoH3v5zMEksvv0pxXcMPN/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Li9AlHRWpH3wBYU2XObOf7CCVTrphyjfFluNorAGrCozZDXa+bpJU5ZsTirFmRDLmBPR/o3gT8kwN3wCB8Jg08BFZvUsAFurFV7joLqucIBoUDyOm30qmP+21lZMUuLQ0W2nk2YQOYTp1Ev5M7KafobagFTTm/KqM1tmPnQaU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8vlCWVc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so24567485ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720523879; x=1721128679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LffdEqewAZJmMCfa7ecxMlJEx99J7erlVb1U4mZnCc=;
        b=m8vlCWVcFwpYWGAh04K9J4uCXD5RLbg76J5DeTqoNYCeDsIdko9g0Hjw0WkghtQjt0
         HOOhz3b3q6qwGhmpjfu8ZMjZjrovw83Zn18/cjQExPMYK/KtToqz7JY9Y7Kau8hRGBy4
         DKQsvc1N0sHMI/BtZ7DaacRZ7rLhip+7cW17+5zcKKvYGHXzrSPhqf50cs1U7/7UTYdu
         +w1Py09pVlYtiUdFZGiHsanW8N7XHJUg/MiMXrI8uEBAjC/aFinRP+nlA7OZUevq8zeG
         Ct6fOs4n/1V/4GhWqvAQJgTl+rmU4iwinU3TJzsR4vZA80cXYR+6hmKUQV+YlLgfLUq7
         iIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523879; x=1721128679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LffdEqewAZJmMCfa7ecxMlJEx99J7erlVb1U4mZnCc=;
        b=onRWc0E5YTE+CtapoakIZltBkx2tonHsUzrozOt4DTUaxnDUbo3ULb7L5KWGDFuI+m
         Nrr3egy0wIu80Z37QWSzimSXFElgtxGHkSyLsY5CWKgew40pWQttbfNyuTJib3YUW9nT
         7Z1eXnxsYIDtBbT3LQMu/CM/LcgJOwImE9Ltiqd7XZIwOh9zhnHd+T8iLO0t22vPF8j6
         +acHnXMd2Lxv7nMQdsxggbRHXMaXth/G9+ZV/6mOe2vUv2qoucUbMdrr4th5mU30YhW8
         WEX62wvugIqP3DUgHQOVhyNyl2wx0hI+J4O0qNNaYDc75HRxYBeM5RjQYgG/TKMtkD/l
         +9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU5aE5Ev542RI4J8Se67rTNBcy76WH6KMcHf7a+SPnpJwncceB/cw/4HQHHiiahniu727id2L9R11YZlS+YxchfyjwrfgB25/4LLO/T
X-Gm-Message-State: AOJu0YzyBceha4dawNhjlRp1cw9qSrPI0U3cUyQRRj4XYcB1WcJOnqd0
	zjowCItlBiaTnxRFnmWTEWMG0gQtN3QKvnKXAdlCiyYWLyLN8E0T
X-Google-Smtp-Source: AGHT+IG2Mq9eNcqdHg3oa4a7z2UqJ0SFwWZrv4mZhDGVicRfQokX1Eq15hYu9qp8JCL43PBi68eRVA==
X-Received: by 2002:a17:902:e80d:b0:1fb:93e6:94a3 with SMTP id d9443c01a7336-1fbb6d03da9mr17249195ad.18.1720523878976;
        Tue, 09 Jul 2024 04:17:58 -0700 (PDT)
Received: from [10.0.0.19] ([122.172.81.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a107d2sm13957255ad.18.2024.07.09.04.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 04:17:58 -0700 (PDT)
Message-ID: <36aa6067-fa6b-4957-ae33-58a28e32c8fd@gmail.com>
Date: Tue, 9 Jul 2024 16:47:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/mipi-dsi: add more multi functions for better
 error handling
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, LinusW <linus.walleij@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240628182428.171031-1-tejasvipin76@gmail.com>
 <20240628182428.171031-2-tejasvipin76@gmail.com>
 <CAD=FV=VKiEjDfeK8pCqAk8+YWBD2U4ESLik8kiDbvgrZz7o1NA@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAD=FV=VKiEjDfeK8pCqAk8+YWBD2U4ESLik8kiDbvgrZz7o1NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/9/24 5:50 AM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 28, 2024 at 11:25 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> +/**
>> + * mipi_dsi_dcs_set_page_address_multi() - define the column extent of the
>> + *     frame memory accessed by the host processor
>> + * @ctx: Context for multiple DSI transactions
>> + * @start: first column of frame memory
>> + * @end: last column of frame memory
> 
> nit: "start" and "end" comments should say "first page" and "last
> page", not "first column" and "last column". The previous function was
> the one about columns.
> 
>> + *
>> + * Like mipi_dsi_dcs_set_page_address() but deals with errors in a way that
>> + * makes it convenient to make several calls in a row.
>> + */
>> +void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
>> +                                          u16 start, u16 end)
> 
> nit: indentation of the above line isn't _quite_ right.
> 
> 
> Other than the two nits, this looks fine to me, but I'd prefer if
> someone else provides an "Ack" in addition to me that they're OK
> adding these extra "multi" functions. Both Dmitry and Linus W were
> involved in the original "multi" functions, so maybe they'd be willing
> to offer their opinions?

I think a better way to go forward with multi style functions is to
use macros. All the multi style functions are basically exactly the
same with the only difference being the function called internally
and the dev_err. This can be represented in the form of a macro, and
would save on a ton of otherwise redundant code, while also allowing 
us to "convert" any function to multi style as and when we please.

We would ideally have 2 macros, one for the main functions where we
desire to modify accum_err on an error arising, and another macro that
just checks accum_err to see if the function should be a no op.

If you guys think this is a good idea, I'll work on the macros and
do the multi conversions in this new way.

-- 
Tejas Vipin


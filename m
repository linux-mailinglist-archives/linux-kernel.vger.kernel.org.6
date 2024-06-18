Return-Path: <linux-kernel+bounces-219132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587B490CA39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704B11C209EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D7E1A0734;
	Tue, 18 Jun 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwZALNTN"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E515A4B7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709454; cv=none; b=NuoVWHaNdBBuXPCzNq3FnPbt4PFhHWUe3LslpyPRx3rHAkfdHKXqIIbcdxji6ENh3WelRouqwj1byCrU2V6OJUjw6+kfwwVjhqqQ7NjU2MZ8cXV9MqzecXqaFrj9Dh88w+MyzuGhdLxATc72GXwtWK4FkokcfWCDG4vbm3XofBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709454; c=relaxed/simple;
	bh=YYKxlep8+oqHxAY2y5ou9k9Z/pjt9apvicxUun9EwkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuAVoGHqWkmrgJ8Qr1oAmG9qG/bEtrWRI3OPrx1nW7M0sH7GrXVWlE/SISr59VXlKsLNfL3BsFLXS8x1lwCV1kXsOR18z3ZDmepowE02TLAesjVRdO6dNYOv2+7l79r64nVS4GzfES0J6FE4RNgRHj8M9NyL+dpURXf5WIUof7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JwZALNTN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52c85a7f834so6822220e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718709450; x=1719314250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQ+i+yUylzc0vNZND2yRwe4IaOpgkA3NphEu3B2GdDM=;
        b=JwZALNTNZE7T3UppX2PUWnkdpqzVJdNs9txgnhng3siLsehLKZqKw6L5lNaY4jgtLo
         p8z+37F6hy0y5xVbT+PMzbOlxksDyjmVl2Zup4q9X886tQMrhS6ZZ1WPKMRUUFNrMdFc
         sHeOrjGfzkA+E2iHe+sTbmNFawOm67aOSWSgyLRy5sOAmS/s6g3QZR9gcKPsgwqWXue1
         TK+7WMyL8RJK86FnDitcCWP9vUeMXUhj0YR6XB3/k8FPoJnUIKpkXzFGTaKokXKHI5Bm
         g6sefwjdAO5/RBi49vf0XoA2gwCkUngvpj9EoFjq1Z03RrnJbGHe1ozZA9Ay3TwpIjxP
         zZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718709450; x=1719314250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ+i+yUylzc0vNZND2yRwe4IaOpgkA3NphEu3B2GdDM=;
        b=ofeD/CQOGytmkActVfu4OPI2s3m4sDPXLrLcqyd2KX6bgwFzxKqwLd8dlslXECiCRr
         bO3frsYPjypBUGGvqjN5LS+LIw2Z71zQ0uHbaeCjXBu6ZnKi1MHFA0ku2/qsCLwFAIhK
         HPlSvVKIi73oHYBmFWnae2IWQn/q8hOh4KX9mM4KRLO9ry0vZLeO9ZTXGKH8k7VhWaDA
         170i3D/35nqHO9rVJWE+7JUvyAbFgJjlm6vH6PdUk5OsZo4XO5NpZHYaw482LyNRmE8j
         PUagWSm4WW56UD59mqanHGFhOJJVBj1qdCa3oDd6YC7QN44LrHXzsv5ji7FzsHY3QKky
         LZwg==
X-Forwarded-Encrypted: i=1; AJvYcCWo40foDRwWLqEjx1G/30uPOqTd19EXuOvx/QYDUZkmqKccdn2CY/YKuFnXwPwTeg+ALbUHdSMtDy6f9PqsYYKJaruecRdqzJAXLzLi
X-Gm-Message-State: AOJu0YzdlcACEeE+a7ev5KZMP3EFiJvuNWcAQ/1KZuj+4hBBNzQFUQnU
	wGmohTCo0U+tjuTcQ73wmhX0LEyrg7Nhbc0okLbE7efC8UfAz4VO8JLHXphnsLM=
X-Google-Smtp-Source: AGHT+IHHBBxjqquwzsz10R7mhJV/FLoBeBD8boOTDbExy+3KWVhzVyEG734oQ2FbmXMY1nRFQiofEw==
X-Received: by 2002:ac2:43dc:0:b0:52c:82cf:b80 with SMTP id 2adb3069b0e04-52ca6e9a0dfmr6058474e87.63.1718709450007;
        Tue, 18 Jun 2024 04:17:30 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872480sm1474922e87.157.2024.06.18.04.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:17:29 -0700 (PDT)
Message-ID: <290fb9e0-64ea-45ca-87e6-70c0e6edd6a1@linaro.org>
Date: Tue, 18 Jun 2024 13:17:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] drm/msm/adreno: Move CP_PROTECT settings to hw
 catalog
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-6-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617225127.23476-6-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 00:51, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Move the CP_PROTECT settings into the hw catalog.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

I think a702 was skipped over

Konrad


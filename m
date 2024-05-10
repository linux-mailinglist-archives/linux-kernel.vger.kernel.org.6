Return-Path: <linux-kernel+bounces-176097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B08C29DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96181C221AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CE925779;
	Fri, 10 May 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNuYz0db"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30C1BDCF
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365713; cv=none; b=qRgTGkb8BfPcsUh3WHao2MoYEWyjOrA2R5W9Af2YUybCe+XYuIMYA38qhvwGZ7cgxyIsttbreriuBPvBurnYMH3fhkoS30+ulycVJEMVLkRXXFnVUhVlOi1ImRP1u3ovuAhLP1dd5vXPI23DOKUxY/K5zf8u96BQuqXh+TDBESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365713; c=relaxed/simple;
	bh=noS0chLiJMj1/jnm6DHAjcxF+XaKoOtbEABT0PJ+oAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLTRvtxz+kfCoRZzzVl7N3EEhsZBGlkT9FwuXiA536qyVYg6vnTaeZnlZ6oBj4Wgw6c0RRCWmc7ySORXmCe5DH6gU7MSyHULvH/gjtxR6P7RxMd5k/0hPrCUmoyvnf3i/iWIsVSmt/vYxeVDUzvGXoyztUtpcqqG7OXF2BJYmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WNuYz0db; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41ffad2426eso7788965e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715365709; x=1715970509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkDGKRSdcvRfyhHhua0JGhLQ3Tca+NfnsHQpFiYqb5Y=;
        b=WNuYz0dbd3tKgyPXe0itbor5rXM1mhiJs7J83kVwBHOuUhJLLLTOw/SvcTyaZ3b5KE
         ig/arGMDa0cDKWxdYIV5eB8yNrK3jo4kYivBx/7uozjTVyVQD07lKqZZprsd+FLnrqQT
         SnJhO7GLn0HXp1ZmS8nmfIjk4PulJNuycpD9XfXBHarh22sXwBKJOJwDke/uNZJtkUo/
         ZzxEAdXkZiGh6QuhLmANPbHFxXk04hAe4SwC8xKcBt9sSQ0rsOAyttCs6KEb/T1g4psC
         yCAXd7AoVvwNOIZsME+Wo8DE2AMMbS7BfDQOtBhW1VcREKjS7nwdyD0/JxB4iHYyOBQm
         XEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715365709; x=1715970509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkDGKRSdcvRfyhHhua0JGhLQ3Tca+NfnsHQpFiYqb5Y=;
        b=RjbkrLrF+fQ7JDRxopZuaII2yKuj4TlTb04WsQ26KlpuLWVNk7OdkBxYF0ZOY46OjZ
         3fZk+5TVTJ9LrA+I3d0u5VQmnb7elm5reXxe1h8B6xKxM2nqTdatrwG4FLvO20hJL3zZ
         s+j5Q0ZvWtGhdnx0BoT4iTqfEEwVbEZStlyu2Uy/spN2OCBeknLjjMZkFiymdTQLZLL9
         x4vtQqgJVACmQ9sMbZZ8TWysXIx/uA79mk8Dm4n2Pyj3jEgZ26uKYMTL9eKVawdfjTnq
         3KXPyeUP+JsRbOZdyx0iNGVgwbd4cSrOJmGbIab8Jkr1vfI8xDL3AK5boIPfuRI5o5Nm
         Kecw==
X-Forwarded-Encrypted: i=1; AJvYcCXnFO24R53xwFvzr+AF08U7lrBUO+ILFryUpkKAbuRgVlhnVX6bjH50ruUGckH2BqJwZeThc5KkE3i3ig4VtYh7afDJz+JsHznUx2Wx
X-Gm-Message-State: AOJu0YwG4whcYeXHQnj5swiivb60Y/AjrGcmvBK5hEEkfoMSTGOBS9UJ
	pMbBLa9Frq9JwRtcTc14RUu9e99n8Y+1eWg2XnJJwhTli4Jieec2HhUpczGo9zXTr86lcCMYT1i
	/OAM82A==
X-Google-Smtp-Source: AGHT+IHhJ3IWUTMpEukV13lgqod/3Z/PRtQUZZlsHBtLFo1n8NpATl37KHiL4lU3REc09zwtOZz8nA==
X-Received: by 2002:a05:600c:4707:b0:41b:edf4:4071 with SMTP id 5b1f17b1804b1-41fead64731mr30877405e9.35.1715365709660;
        Fri, 10 May 2024 11:28:29 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f86e7e340sm108333665e9.0.2024.05.10.11.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 11:28:29 -0700 (PDT)
Message-ID: <b3242c7c-a55c-4d81-bd64-dddf3cd57ebe@linaro.org>
Date: Fri, 10 May 2024 19:28:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] media: qcom: camss: Move format related functions
To: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240411124543.199-1-quic_grosikop@quicinc.com>
 <20240411124543.199-6-quic_grosikop@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240411124543.199-6-quic_grosikop@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2024 13:45, Gjorgji Rosikopulos wrote:
> From: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
> 
> Move out the format related helper functions from vfe and video in a
> separate file. The goal here is to create a format API.
> 
> Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
> Signed-off-by: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # 
sc8280xp/sm8250/sdm845/apq8016



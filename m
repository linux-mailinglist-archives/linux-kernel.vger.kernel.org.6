Return-Path: <linux-kernel+bounces-427780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C2F9E0683
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F181E17145C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BB20E024;
	Mon,  2 Dec 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyzuzLdu"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D4205AC4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150809; cv=none; b=fvNp+Yk0+tLPaGP6qkNBswCImK8rTbo5mbYPeUOTAnfgEi+tr8m9iHsDuZmjK7/zmiOX7KkGpVj2C5jmfNYSc9ermDFcet45+nJqDX4g6l8k/Y5h3mJxtz7AHJVKc2aVeI0O8ddsVAHp8lSYEY2ReINYAN2s025ZjmUEfxw9V9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150809; c=relaxed/simple;
	bh=YDs+AUP8/sPXPpRK2RvKyuumBkR2iVV6ym1xSAp2m1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JM1Jl1gTYPsHj0a0dYlntnb/hP3A1T3gpl060o3NHPu2gOMeLCOA35Hdvii1fby3HipZc0qnQ3MgKKJmGD8zH8GkiSTOQtAyMSuaiYWLCNzIGroe0M1+sQ/pJvZNID6Hmuaa21/TznNHrXuP+G15+UGBHjw2CL+jO1H1vEGO6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SyzuzLdu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a10588f3so27661845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733150806; x=1733755606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jngKSnV1SnlkeqtipOyUqxY6v4EepIgqkXVcaaXUUg=;
        b=SyzuzLduOoNRgG6ZuNKAtCFUvrAy0lRXR5iCtS+Q/NEL3NfPCj/B6fG+3Y8EqgG5lr
         RrVV0jda6qkHmf7r80zgEUywWKiIY5x1RfMCmbNF3me9CK3DXszFEs8EZQ9lsnfBoTit
         COVjEnOtyumcNN5olTi9T/zbMLSUQeYQZm89Bn/QD2JHmMIlGlovOrlk1QHWrZlZF8mf
         WfOCxSVidxfoO7e4jlY6nN4z3uhG+lgeM8EAQ6dfwNTR/4GGqjbW8avpEeIiXqSVa//9
         sEZM8oR3bfiNmHDNmyB/3bEtsJU5lznAHoGH+WWwfirclFDsRdOqkRSO5vi4/qNyk6Sk
         MkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150806; x=1733755606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jngKSnV1SnlkeqtipOyUqxY6v4EepIgqkXVcaaXUUg=;
        b=h0LYX23Y7vwpvrqyw9/vxl14Zu1ioHVkyIq6YW7kS/sSf7X5iyLzRl3xLTEBRAgX6o
         p6G4MhY8fXrnWHFzDkCY6leZSRRs9gl4lUS6ykS5CyJKhJa1lCIjvxNJF2C2qOpprFwJ
         Mzd+uxnv9wV+mOW6Bb7IGYspD5HufbGjC2e1bjGSvJBpidqsfoyqGzPHRTsg7tKLttMf
         oLYbDYvdVIcFcRSbeNW9z9kSqvkDnIMDVEY8+noSal+Eur0aCUWN80Fndxf8lGlBe0PY
         kaOotDL1qkw+gIWzbxKrrStlbP8rMbpsEi2mUbfEIjs2nvknLFYvxLFH0gygUPAHAo1C
         w4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX2e0yQfq8pQw4yD09RH7UodyyLAYGC2n/tDsTiIKShh9bN32B938JapAYLT7n0H3p/OZj/ralT1q88zyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fzaUYXe9WHUi7am962QXTVyGZskfHaXtu03k5FWKJqJP1clG
	kHYLnEiahDSWJFSRTQdDQNMxJY1KajFfH66h+rbmzDC6G4eIM87IfUrzLBy3nMg=
X-Gm-Gg: ASbGncv+veIrgMS2inCS8/OOj0Wc5aLyHbcyweYioWHbRauh1Cste2xX07nye4XcwIM
	ofx+FtiAjwMIIeddiaU3vTdUdu2mgbs+6BCnAOgeftFzag6hKwRvDMrSOyNet5JlHoxn9dQoPG6
	wpY7PHjmnqMInWxlireMy9auZtaNHLqVkugEXfPKT2qPw74FWaGReqMSAwjZB6pUFmoI7gR/Avr
	37v+tWQ1D9MU3jPKEe0w1eouQNDRj9j7h34JjIIebz/jGLrws0NP35OVgqW9bA=
X-Google-Smtp-Source: AGHT+IE49b8JjMPBK9ZvR+0YrEE6wFU50bpMjnp0L2s2ALML5mrxtbe7syEjF4yg8qOV9t5qAfufhg==
X-Received: by 2002:a05:600c:b87:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-434a9dc3d08mr207426355e9.11.1733150806267;
        Mon, 02 Dec 2024 06:46:46 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74efbesm185888475e9.7.2024.12.02.06.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:46:45 -0800 (PST)
Message-ID: <1a063942-22a5-4ffd-807f-67b681ddedf5@linaro.org>
Date: Mon, 2 Dec 2024 14:46:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] media: venus: hfi_parser: avoid OOB access beyond
 payload word count
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa
 <tfiga@chromium.org>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241128-venus_oob_2-v2-0-483ae0a464b8@quicinc.com>
 <20241128-venus_oob_2-v2-2-483ae0a464b8@quicinc.com>
 <65002924-3b8b-47ab-aa90-4733ccc2f728@linaro.org>
 <1a6d05d8-08aa-cb84-ca36-859be3c589c3@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1a6d05d8-08aa-cb84-ca36-859be3c589c3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 13:24, Vikash Garodia wrote:
> If you see, words_count is doing the role of remaining_size. In existing
> implementation as well, we can move those increments per case to once per loop,
> just that to avoid incrementing for default case.

Yes.

To me it seems

- A redundant step to have words_count
- That the functions themselves should return the amount of bytes
   words += should increment by
- That you could do that words += outside of the switch instead of
   at each case:

but to be clear the logic of incrementing the words looks right to me 
now, I'm suggesting additional stylistic change.

---
bod


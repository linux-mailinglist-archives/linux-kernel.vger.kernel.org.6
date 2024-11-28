Return-Path: <linux-kernel+bounces-424721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3EA9DB87C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F5216177B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7841A9B31;
	Thu, 28 Nov 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D22owIct"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AA158527
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800265; cv=none; b=oBqYYlusFJrHKiXbu7gs6mGSy752+m4L1/GUki0d6/kkf3bVVCW2BIPPrQLtO82xWVmeN0oB0eGNhjVAtNCDn06jqw9eat3/HHfGMzbyJKiRUFZCfLNCJH9wk9jYAzEK2Krw4K9+7QNcuIIEqAW4vSWeHDvUj7zDX7fSy4lgbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800265; c=relaxed/simple;
	bh=6N0bgmGW6ZFE1RBJSAYibt4wD8JBkZs1/eYZgRBGMOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWdAieMbxl4srFFfArL+26YgRe0JkpDMdVaEFCF8BxKgUWYXVuBj7GleqlymsZGj34foulv9XMhD/pbLBo7oJnvxMmv+ffkigggWsGBOppKiIwZiODvVezL1CF7I2IylNmZjEOTFYbXATzU/PFGjJHtTrE9W5iK/mzG0OIOdulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D22owIct; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53dd0ee64b5so106350e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732800262; x=1733405062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXmwGgua6b6IFHk+sz5oYErhryQ6lSwss7yAIxQHIIc=;
        b=D22owIctVKxBDkaxGYzFMy0rfpp6kKM1JoEakN4yj1q+xxIzhOeCA24rgu/0Jtf2fD
         YdZCFfXRCAJGK/1h+XMYphJOvJSNeZWdajY5PfBig/rg6avopRRxOwy2ccc8tYBbg77e
         XyQrIddjeRH4ASCI+sWepk0ZT93onZnrKIo14FJ5XLrd/IH2kfEiyQFoAkldqcBUQOuG
         /fId78i4zP2kP6s/AofO8owlxCfXn4fZ21OjvPFnYzmuN/UXR3O66e0falhSxEnAKjnx
         XD2ffpaODjOtiszMWyihs7g+NtWAi6yJV4X+jkQ1sYn6uf8Xqol4l0oB0gLtZ9fp5Ce3
         lyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800262; x=1733405062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXmwGgua6b6IFHk+sz5oYErhryQ6lSwss7yAIxQHIIc=;
        b=jaN79CNSRgqgta+uOR2uaP9TQd+o6A09teqLFfXfOsRY2JUyamJlOgv+Jw7UGJ4Zaq
         e3fwLCK4zTfjvbINVPw9CBWWAAudlNg23EZ9/yGnymvOAs3yfiXi9mWaZYw8KQhTL1/e
         vPi8b1lLxacLGBw2dhc+Rk7O8t6WVvJLBwYqtsGtosyzcCdhJ2hyXDefA1p+NJb4tM13
         55Scacy2zdNQidcRoFcyHNp77YQMpkmzwiUFZSBpFCXqg7tkd6cAdcqhsCpEy31EYNgW
         8Ei2mCemz8MWZzpHk+ZLrPW/cqSQ5MXZByR6342824Gl3HrQdM7j3CrHWOg0E5sOzIuv
         gWnw==
X-Forwarded-Encrypted: i=1; AJvYcCXFmw8x4VQ3ULNgVV0pnXTGWQ19YyG8qlEVYXQokb+Iacge1/RQ59jYUq4C6z2SHB/3TTUk6O3ZlwcaY/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPYHUpiPgn7+KTJPPkCL/07FOvW43r8h04/NhxQdGQ7lrgaEO
	89PwO61a1rXC5YX3DYZVMdjrtx9xGZTqcacEgl9tOeMXUGUwYA/1YsLtNv1uUko=
X-Gm-Gg: ASbGncsMTcLE6r2ikavLnXr4F12nRDlmJYZaRTyVa2djMMIeJCTQsow7/Ku50NRaJyW
	d2gQTuTpJL4ZvNcpNeHf54A8KRJcJNHPjXh8+dkteRLr0U1FNinGxrGM9TsfNBClo7aWNblh0Bu
	5+F74GQk4f1aLhbCcVAJX8xG6F5vvPUpnC4/Xjv0Erpw/LyxhNpNiGoYmEsxpANZNoj1jZRyn/8
	mPLxPn8A+VWfFs53RPuHELP8tP3seUijUMoU3VDC+S91armGaDi2ARiruLXyyjfayE+esC7tBrP
	s1F0rWTb5Z9gLul/SNsF+R0MiecY
X-Google-Smtp-Source: AGHT+IGFUJAxjvhsByyBdZMcAk0gikSSjkNb3tPTHIn7AP9ungve1WLXE07mxdF/zOolQIu33Qx1Vw==
X-Received: by 2002:a05:6512:3b23:b0:53d:abc3:82a6 with SMTP id 2adb3069b0e04-53df00d3e59mr947638e87.4.1732800262033;
        Thu, 28 Nov 2024 05:24:22 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f27fsm176060e87.157.2024.11.28.05.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 05:24:20 -0800 (PST)
Message-ID: <b97adbf2-f19f-4cd7-9266-526957c4c3d1@linaro.org>
Date: Thu, 28 Nov 2024 15:24:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: venus: Add support for static video
 encoder/decoder declarations
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com,
 quic_dikshita@quicinc.com, konradybcio@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, devicetree@vger.kernel.org
References: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v2-0-c010fd45f7ff@linaro.org>
 <20241127-media-staging-24-11-25-rb3-hw-compat-string-v2-1-c010fd45f7ff@linaro.org>
 <ad906baa-a93f-42c4-bbe5-968fa939c653@linaro.org>
 <71dd9aec-e2b4-4323-aeb6-53f2491005b3@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <71dd9aec-e2b4-4323-aeb6-53f2491005b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/28/24 14:54, Bryan O'Donoghue wrote:
> On 28/11/2024 09:02, Vladimir Zapolskiy wrote:
>>> +    np = of_changeset_create_node(ocs, dev->of_node, node_name);
>>> +    if (!np) {
>>> +        dev_err(dev, "Unable to create new node\n");
>>> +        return -ENODEV;
>>
>> Leaked reference to np.
> 
> I don't believe that's a leak, because you only release np when it is
> non-NULL.
> 

Clearly it's my fault here, I'm very sorry for it.

--
Best wishes,
Vladimir


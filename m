Return-Path: <linux-kernel+bounces-274004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1928C9470B0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FBA1C208D1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB7213A884;
	Sun,  4 Aug 2024 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2E9yhaX"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F31369B6
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722806820; cv=none; b=n/EQpVdIS6T/7nHE9QhNz+j0d9zKxANYZa2Tnd9UFvNWDy6fgKEJbEw9GNzhnTPwz0bn7rHKuBseecmYhwLAIHS37OgLAL3LjZVttynOGB7VjzkLoXIlZHBbDOv1deGhZth5R7ZmKm5RN+UDL4xuLlO1LzHuMwRU0XONYn8HMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722806820; c=relaxed/simple;
	bh=ZARinnrZ8898vJ97LmefXiZ/D8Kujgb6eUAqVyijsuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XusIPtQFO9+tbYXEshj9vInylWbX+P6or5pgh6CaukjtLd/nkx9Nz260CNtHp1OInbiMObHxuLbjV9bZyi6Q4y2bAwX+1S4oFQzT80ghLsqS+quHui241CFGj2Es19x64rB87L8bbCX2FjIlee7bAzDMftP5bpMYSL1mToPGAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2E9yhaX; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2e37a171so17128981fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722806817; x=1723411617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OoBXpPLc2r0a0UPJxEfi2oLrgzhk8wKgCqCsglbfDhQ=;
        b=j2E9yhaXCcHlWXRU+KDbKWQ8Qc3QpcKBR4q4E250pOsfCIlUXKJS7GIuQfOVhvsJvk
         XNkZcvyR44Lb5C6X4FGyPbycjNZDIa44zkRd3aXEWJQEjYX56DIAoZCGJFNa5SrzOfAv
         NDJFCniUYDLZ9PXl4pWgShh1WLr1MXsaqkIdkWwcRSE78DvaLRMihX1WBVZYr2Z2hzHd
         no9YutjdDAZ07ys74XJQBS/PU5YqRld21+kKSzqYMBt7yRrhZY9XSaUOisOuCndlMISh
         9fEv8nZCSryJjz1C9aEJunqywvR8QTKanFORxIUfozgtCHV10f7xoXs6HNllFIJujnu4
         qCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722806817; x=1723411617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoBXpPLc2r0a0UPJxEfi2oLrgzhk8wKgCqCsglbfDhQ=;
        b=AjxoiXS/lQaXj7KvWqPFXhxgiqms5WV94oPXP0GcjEXC1t8ketCyAGKIYU29rTP4Cq
         pT37eM969/uQ9KiCNygdyAYZhkqhiEbHrx3v8V2XfINBmod1xGnoPoHtS24vTitZ4rrz
         TT9W+evlq7+Z0Q/tBlGTupueXmlKfzOPRj0vIFZ7tsCCHvTt6xRG3qL2KQTGIcbNwR3E
         iQqdmcnjzCWangU0HiRX8Ej/WUMPx4KBONcp+hyfXsGrbjPT0gICiOzfqZBBZtIXDKK5
         kPjHcv3mQegKhx1ZxHUZkViZ+7SV0AsX9ouBbci/3aqB44/oVcNatlpGA27T/kfEJ6eq
         GHlg==
X-Forwarded-Encrypted: i=1; AJvYcCXSAWCsNw92iA86u+Wh7A2J+OlbWQMBpkdy/QNHrY+Oy5H6Q1l8Bp6cCWVOrwQCCI8r99btXvsnFR5VWkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1xxXaF06iTI3eOMhnqKQA7olcsjmY8nqAwePwz80+AQXkGy4
	cIbBh93Esx63qpFvhrmSyNRWX7rm0pxQ5uIM+cfUah4ky8mYuawWJFYS8n7LwKY=
X-Google-Smtp-Source: AGHT+IHAD9gnG+vrWMrfHWvKTKuTRgNKabB7Z6XbBoZLxcRN/KC+3/Pv5T08i9l2+eg3hX0oX5SEQQ==
X-Received: by 2002:a05:6512:3ca4:b0:52f:c285:323d with SMTP id 2adb3069b0e04-530bb3b52a9mr3404779e87.5.1722806816947;
        Sun, 04 Aug 2024 14:26:56 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10f7dsm904228e87.112.2024.08.04.14.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 14:26:56 -0700 (PDT)
Message-ID: <4426c0e0-f877-409c-b2d2-a5aac5e8c645@linaro.org>
Date: Mon, 5 Aug 2024 00:26:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] media: qcom: camss: csiphy: Add an init callback to
 CSI PHY devices
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240709160656.31146-1-quic_depengs@quicinc.com>
 <20240709160656.31146-5-quic_depengs@quicinc.com>
 <6dfc2c79-fc6d-4eed-bf3f-94396130cb4f@linaro.org>
 <fafda7d5-3853-428a-b0eb-9993fc2d4f56@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <fafda7d5-3853-428a-b0eb-9993fc2d4f56@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryan,

On 8/1/24 11:16, Bryan O'Donoghue wrote:
> On 01/08/2024 00:43, Vladimir Zapolskiy wrote:
>>> +    ret = csiphy->res->hw_ops->init(csiphy);
>>
>> Here.
> 
> What name would make more sense to you ?

according to the implementation the .init() call just fills some data in
memory, so I believe this could be handled at build time, if it's done
carefully enough...

--
Best wishes,
Vladimir


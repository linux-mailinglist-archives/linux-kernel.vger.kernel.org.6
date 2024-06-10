Return-Path: <linux-kernel+bounces-208807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927F90296B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A264B21324
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013EA14E2CC;
	Mon, 10 Jun 2024 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk4qi51v"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8013665D;
	Mon, 10 Jun 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048229; cv=none; b=ezG34UqifjlhqzWbJtjBVi5WUVG1smlmYNHeZC5Rm/qNOqhzSYmiYrXj9IQ7ktUts4w9UPq0iiy0ygVXyZq6ZAMFeFi/xzteeSXU44oQ3YdptywKefVl9SSetZD00ygd1ucpM1cmXjKtW+kEWO14QVUjjm8h4EuCaqfy7enFidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048229; c=relaxed/simple;
	bh=0PnQ7JcDwQy6GuS+h90eAb+hPmSTVuQjXun3YIoqONI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6snecBWQeOqogBeiQ6j90w5Ty7CbHGREWc48WP9FOGbpQc5RLL1d2LyZNNTSKjne0UAtxD5fsdpze4M0gkdRW8NXf98zJ9gjBQbLa4AJIqaVtdJPb02RNEzkDPt6joe0tIgUCoAa0iCMj8Yn8FLDkP1zD3P9tbeS/XHUeloC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk4qi51v; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so351825e9.2;
        Mon, 10 Jun 2024 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718048226; x=1718653026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8h0SoR1IdP8sTl9hCTv4WQ8Vv5cv7/2sTEnWF1cX+rc=;
        b=Gk4qi51vrkceTG0kMnqi4POaOrAxPVqEHGeLwbf3S54rmdRIlu3zCXSWgypsvPonvo
         oaz7HG3wAPL0N/QjlWu5LD3v7J+I5+kbWQeN4/sN1Mns2ChTHond0kLXU1yXWK07KFdP
         35pLtP1WNw7wJHqTJ1vdaN+DeDHMALWOAdrW6kErY98afv2KXfPTrjL+tMHzxUgTPPTj
         hqBvuWteCl6iEpx1WGUTtQZyD9q/sLb4TzCXv92Sy9p7TfXxkpT5vyLTZDo5lIcZMZa6
         o/JAldhsamNUqkgrOkFnWjitam+sTeP4cpoIYxtjGs6wrjHAans7bfLxOA0C831wWfO8
         0mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718048226; x=1718653026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8h0SoR1IdP8sTl9hCTv4WQ8Vv5cv7/2sTEnWF1cX+rc=;
        b=HRePfXXrFaBbq8vz5RVYIQgjuIa8g8tPe3IE/RkZEyWiu4utmJtKCmltBoP4RHDSEI
         f5MdbN3vpC91JhXvs2X+RQV6JdbXNWY++Z0AxRMJjj45j90hVXKjaaCFxBHdkLv+ZAAT
         RyugUf+w5tEuquUESo2b2nXWy32PR5EkxizTSa8QOUqt01iHaH1ytx7mSfzgozhVv23i
         BydWN2bx0qw+mB+xmQYOdbd44fiX5zvgauT66TM6Yzwa4Y7qozrmQEkcaXp1BO9uc1b/
         rQSCnBR+y1WNkzSXjK5TafmjkAhJG6k4PfTDJZIKnw2lOzcCGuaZfDOrcMHSSgZqR5Hr
         OO9g==
X-Forwarded-Encrypted: i=1; AJvYcCVlNPtvlgT5JW3c5iSM+Z59xpfVetnIngyslPRVhpRFO6SRn6R/jtlDxIGooFDS6h0DqMPpTGGeM5Ifjma3xNBimaZ/JH0Kmta4i1VtDyM=
X-Gm-Message-State: AOJu0YxQm75zzpBLVf9e2hB4zM7rkVhPHS2lcjMtcntICXGHhyiwvT52
	vNIheoUm34DS9i7qFdqBo/uj7FsOHcujriFYDqDrHb2rTCEyFSTw
X-Google-Smtp-Source: AGHT+IFIHjGgGY8+jGNdwOx+v6ZxtwK5erxpCzpfi8hOa1DDVsere/GMRkhDY79Ziybi04Jiw9nQlw==
X-Received: by 2002:a05:600c:314f:b0:41b:60ae:7827 with SMTP id 5b1f17b1804b1-42164a033b7mr93615665e9.24.1718048225886;
        Mon, 10 Jun 2024 12:37:05 -0700 (PDT)
Received: from [10.5.1.156] (188-22-218-164.adsl.highway.telekom.at. [188.22.218.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1efe9a74sm5100004f8f.104.2024.06.10.12.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:37:05 -0700 (PDT)
Message-ID: <f798777d-6a56-45d4-8136-6aa9e0e77abc@gmail.com>
Date: Mon, 10 Jun 2024 21:37:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: rust: Enable Rust support for ARMv7
To: Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org, Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
 Sven Van Asbroeck <thesven73@gmail.com>
References: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>
 <5a8a6b44-9f89-4e26-869c-e9361da4cb5c@lunn.ch>
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <5a8a6b44-9f89-4e26-869c-e9361da4cb5c@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.06.24 9:00 PM, Andrew Lunn wrote:
>> --- a/Documentation/rust/arch-support.rst
>> +++ b/Documentation/rust/arch-support.rst
>> @@ -15,6 +15,7 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
>>  =============  ================  ==============================================
>>  Architecture   Level of support  Constraints
>>  =============  ================  ==============================================
>> +``arm``        Maintained        ARMv7 Little Endian only.
> 
> Might be a FAQ, but what does Maintained mean here? Should you be
> adding yourself to the RUST entry in MAINTAINERS? You are Maintaining
> Rust on ARMv7 and so should be given credit/responsibility for that in
> MAINTAINERS?

From my side I can/will take a look if there are issues/patches related to this, but I 
can't be sure how fast I'll be able to respond and I don't feel qualified to handle
larger or more complicated issues myself.

But there isn't a MAINTAINERS entry depending on the architecture, so I'm not sure
who will be responsible for this.

Miguel how is the support handled for the other architectures?


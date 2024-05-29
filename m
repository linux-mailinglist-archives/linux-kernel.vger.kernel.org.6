Return-Path: <linux-kernel+bounces-194583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C78D3E93
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751191F25091
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68881C0DCC;
	Wed, 29 May 2024 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zM9fjI1P"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AC15B139
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008775; cv=none; b=EFsGRY6ny8eGjmghyu28NUksld2aMMXF7mZ7KXROIG3ImUvLnxGrAGMVPZnK+ademSvVmw+TSQmHJVxggVB1CblF0DG2dQSgTdaFHdp3bmFFdkCwnHz4q1B2g4SADuD4eimt3ip2ggL4zvtTERFbtJTtvXyDJBS2LfFonTq9KOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008775; c=relaxed/simple;
	bh=VCyLXfQw+vODJ+gWUnxnJTmwZOqAzSvyZikbefhPOtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXXXCQ5C5ReTkiP/kb73wRxr6VeH92diXV0sf1SJPOIXK9Edq82CTVPamYz8tAYE92LxfbzopAnavTx+hTQcth5yW8eR/trK52cxGCDZDGFGU9OlDfnaWWWP/qngL62jlyGc3u3xX1SH+L6if/9Pm+r8w5VI8QXvXa2MTMpxnHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zM9fjI1P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4211a86f124so518925e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717008772; x=1717613572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCyLXfQw+vODJ+gWUnxnJTmwZOqAzSvyZikbefhPOtA=;
        b=zM9fjI1PJgVf3I5U58hFLJCvNWRJPeAU3ubFCxPJ/C9i/YmkT9YCRB3CyX8sJWXFwt
         7PhBoBOIT6GLphMoAKOcmOJ4kyREu4XIDyZJeiHB6T233Cv/6fQHvH1iFc4u7kLmyuwH
         Sc+VWcZxbgT7cNajydCbpt//Z35CXhMcVsesb0wRJi/keZ8Nq3WJkjjvYk703g3JHrtK
         7augOOp21v0kxpHbqJjMJ/zDJNIcbD4+Ck+f4TYhpF3/VXDeLIS3IWmtnV++c7qAsE1Z
         eGw7UsXgVpAfcqpMFIoTwMqp1CbWZxxKWU/xi9P5b5KkBpavQkpF7KhlW6ZZUZfXidZJ
         xJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717008772; x=1717613572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCyLXfQw+vODJ+gWUnxnJTmwZOqAzSvyZikbefhPOtA=;
        b=QvqgkQXa+0l1dc3a3ApOgcEDQ2JnZ8ZMH2BHjcihmJgYhLcCa3QrknlPYfjiPu4v2A
         vuS4yysTgHEHd+sHDowR1ZuJjyv7GDauUHdwf3lup2KIjTNnepeZI8O0GJIHYqdZi3MX
         d/d7pLQLq5rkr9JXDo99GTqa0DfcpCVMkVUDtOEs2VndaSJyMF2e/j6VyIfWAtLC+eJd
         iEx+zcpicwyDERkWEa+koPRTmpmLLEZQwdzo3FY2KNskytUwMA4Jph2Swa0ZwLrs1PBQ
         10GBL5ejszDiSaGLg7P794ALaGEz1vXZjxycCNGYLc3bYUb+9W/pTdZ3hyqjVTtJSnYR
         Hmxg==
X-Forwarded-Encrypted: i=1; AJvYcCXVK4YAbar2yW39bho72YoJS5VZq+JP9MN59U1r/rvUS/OI4s4nUT62bCJl1dLFTUDGrCOxz0lKf6q1chWm+JLQibxl7+MsF6aloxDt
X-Gm-Message-State: AOJu0YzO1BdQEeePR0t+ACQ3vLC6Ugo9C7+xWHVx0wXm9uvhRjTZCsR+
	wZOh4q1bI2X+tKJ2ruDo2pRzV5h5+DN+XQ7aYE7n6RuIyeolWmD9SmGsRPhDDHQ=
X-Google-Smtp-Source: AGHT+IFYV8lOdAq8BVnBAdwANSNE1at77ft2iuhi77Gbpa36U2AS+eGe4gpkadqc9c7yNfvtjizhyQ==
X-Received: by 2002:a05:600c:4ecd:b0:420:1fd2:e611 with SMTP id 5b1f17b1804b1-421279294dcmr155055e9.27.1717008771805;
        Wed, 29 May 2024 11:52:51 -0700 (PDT)
Received: from [192.168.0.31] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-356c8daef27sm13465928f8f.115.2024.05.29.11.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 11:52:51 -0700 (PDT)
Message-ID: <6caa0d27-3abf-4198-97a9-42b0e564bbba@linaro.org>
Date: Wed, 29 May 2024 19:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] mfd: pm8008: deassert reset on probe
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Satya Priya <quic_c_skakit@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240506150830.23709-1-johan+linaro@kernel.org>
 <20240506150830.23709-4-johan+linaro@kernel.org>
 <4468becb-dc03-4832-aa03-5f597023fcb2@linaro.org>
 <ZjyX6iBqc50ic_oI@hovoldconsulting.com>
 <ZldU_LqjkU-4uphO@hovoldconsulting.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZldU_LqjkU-4uphO@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2024 17:17, Johan Hovold wrote:
> The irqchip registration will also fail if there's no from reply from
> this address.

That's acceptable too.

---
bod


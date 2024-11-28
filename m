Return-Path: <linux-kernel+bounces-424645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75659DB768
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC09B23F27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480BC19D072;
	Thu, 28 Nov 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="UOQnX+CO"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1219F111
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796224; cv=none; b=VZiGRgRKYU2OUkpG6+4IHLK7sMjJKbwoJcIboCLLjI2qNtUTyOdJtkTQKoD/Jf14R+PQvtHWAXWpnPOUQux3PbYGUW2bhcmfmWQosesP8N4v8VAN9sTCekPRdIeYggy/pr8ktwwSeNqz9EIZ+YjiubR0gqM8y5uLpLRk2HBRPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796224; c=relaxed/simple;
	bh=2anrZsi8yYxZsGY8iWPbTzDGxeWMdq9pCPMPA2m4h/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ly5v3NnjAasK/h+5/KiPOn1a6Itf18EV/Fx1GB3IB888sZPzPuxz6TJKLIjyx2rKlaR+VLYC4XPw6PwE5aK1JyZYL5xWk1gRDC2H/OYsXnDxWw0BDlDkkG2Hb/JXLJX3UVGaV+u/xxh/qfiYeE/mn4JUzKg7N3L7nLzun5Ylse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=UOQnX+CO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3823f1ed492so1065173f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1732796220; x=1733401020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qnYKNjsj9+DIg4dgtEwsJzOol8LULwkHizIbCsuFjgI=;
        b=UOQnX+CO9rYOgMAHMozJhN5pBYnItkE/bw6KxtiHIz/u1FVaFMs3jBRb2oTeNFp7V+
         fcQgqIgtBVioUX7dgicGKQ3MXXDtrxgkLlnrZW+IWqAyBKF+wzMK9t8ZVE47EHGwSVeR
         EvEYzZs1CT5PpbPVnuk7V2jbcw0gDUXSgyp3mmxQz+/yHH10dUT4SlMg6FQoQte41Kq2
         uDveZTs5K8Rq5AbRzlXgXeu8oZeLAKMVE5Vwcmkol4vQwFYGV8Qdpd9sp3lVT0ReWc16
         yqIwgjrETx8+qUHjMcrFX3L+C+oMRLKtUPFFJKVyIXijs76aRUFxZyDXMeiuNmjIk/Mu
         lk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796220; x=1733401020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnYKNjsj9+DIg4dgtEwsJzOol8LULwkHizIbCsuFjgI=;
        b=sa8A6lFUHDU9Z93VJQLp1M4c9+aWKgguI7enMM1T+HPB72jsxsLZ3pRa/0JXrnbvIG
         27OuwfZMig41HMqh2SQhHI4igKkVpl7AwRIYuU6SEgjP66Gsnrbr42KN97TVH0L+9uWU
         iVpVp/8cxXvwpLpjb1KbLSBfHMbE8b6diPmEekPmgxK+XNyaiZCk6L/Hla64JxVziVeq
         zx9UPEBnbdVkePP8RqHJ+o7jApFLWA4ExaSUqm1na4vETFscgGhXIcAgqGSMasGNgt8n
         GqkINweTOfJRd6s58Gl1gFWc1lnECpsit4BIUzBR9Sbcyc/y4lrdJHPpgIYWMC+pdC1e
         78wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3rMeLrfg2f6kRJCn4ma3H7ijXKijrjrKaEuT663JuVBXoch1w+JmG7PuNn4xOFxuRC4JHQRA6KIAQHes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKH4U2Els1PbuczdlQPym4gFYteytn5Fye0UR6JN9EvOpFv6i
	PWLWKUgX+gXOiCSNQ9sSdc0cdIqjTaNaESfcVgOUb+JeXsN060s831tC1eWQPG8=
X-Gm-Gg: ASbGncuUs4oGLVUUP7o8O7WJA36fXs3kaGIs6m/lTeDqEhHq8CzEaZ/NUktwqABXA1Y
	P+ePjNusSG4nvrQqW1CSXKdQgf/f4voiZQewTMHVPqDgbZeJZcgVMV+uynrGOPymu/cCU4gIrNI
	9blgbHJbmXz1FSQctQGNO9Tz01mQI12AXHlxDvxBXz2fFlRkJGOSJVpEC4/5cg075ubf8CObV7i
	KzCXTreF0FfIrIhteL9lI9LXDQpwtT8XyiVe33phVz8Bhcg9yehMPu38ZTFc7sfxg==
X-Google-Smtp-Source: AGHT+IEZjXNtTqeugmsm2btLkjXjVN1qa/0hxV/pE3MegQX6gcpP8J+clt9rtORx717q0sN/fuCk+g==
X-Received: by 2002:a5d:5f93:0:b0:382:22d6:988c with SMTP id ffacd0b85a97d-385cbd6050dmr2242980f8f.5.1732796220493;
        Thu, 28 Nov 2024 04:17:00 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36c44sm1508127f8f.38.2024.11.28.04.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:16:59 -0800 (PST)
Message-ID: <ec5faeb0-2cfd-4634-b772-80197c1b9092@nexus-software.ie>
Date: Thu, 28 Nov 2024 12:16:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] clk: qcom: common: Add support for power-domain
 attachment
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org>
 <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-2-4348d40cb635@linaro.org>
 <a73a3b5a-cd83-4f87-876d-ea99ef8bbd70@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <a73a3b5a-cd83-4f87-876d-ea99ef8bbd70@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/11/2024 12:09, Vladimir Zapolskiy wrote:
> Please simplify this change, please do not ignore patch reviews, if you
> find it possible.
> 
> https://lore.kernel.org/all/8a33c0ff-0c6d-4995- 
> b239-023d2a2c2af5@linaro.org/

You want this inlined ?

It seems like a stylistic ask but OK.

---
bod


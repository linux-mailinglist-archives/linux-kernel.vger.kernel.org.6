Return-Path: <linux-kernel+bounces-405881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9AE9C5873
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A901F2333E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69113A3F2;
	Tue, 12 Nov 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZyV/1KV3"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE445979
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416427; cv=none; b=Q7ZkZ7y/6MVbKqk5HG9Bxgx9iH6frsUJQNVxzbPz4izOx9u0MjmX7/QpV9V68rYNK8juQ9nOmHb4IBkKC0Z8aXpoitbDbF+3Cbjr9zrTGxDMB00858qBw6zrKPEGgQy/NrfhXct5aZZ8Jzyd4sxtBhOhBVVSdIVrGBR+7OMQDFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416427; c=relaxed/simple;
	bh=6OSMeGKtQqEz6pt4CLSfVWP64uVuHB5pe0dkYt4nkKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hI8dFQmnjidR8FCXmOUHdoMKYqNCnt6JYMuovztlXRJhmCk06QJmacpAgjYuG2QPXiuf+15ziOjsFtY/TrC5j2yftZnlZSTkNDvNzYXfyh7BHH+wEhIvtavT9OoPJtNCgPf8YeqT1m+mKs1P10J7i4Cyapp2uXtUimr66Rhz6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZyV/1KV3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so732055266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731416424; x=1732021224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OSMeGKtQqEz6pt4CLSfVWP64uVuHB5pe0dkYt4nkKU=;
        b=ZyV/1KV3tpWvTjCE95Yf58ZUOEbNIZKoAiwqH6F6qzVCdtJrGOw1t+sgUi8Nl+qj1y
         08CZ2/lYN2a7/fZ4A8SuUwxaNSRVdOg4IQoe6lwltOWBtY9qoASZwjHu7WNHYsPNt2Q0
         Koc8aY8kANohcCwutO3AZ9El+RPJvWXrYE/9q9JKe31rUAdnxoq/eoETUjyOG3kC6/lo
         wvzOjuuDBQlU1r3HIwhlgyJE+EH9ADwxM6c2XdYp0EEw/H+4Fp33yi53kPow74P7iWRb
         WTvZ96xHvIi4O9XtxcAnP5RGEm8awH9z7or3IwZ1QTNxVox4ifvvtlNd0F7Ycu7uIhU2
         Xi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731416424; x=1732021224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OSMeGKtQqEz6pt4CLSfVWP64uVuHB5pe0dkYt4nkKU=;
        b=DZr2wgr6BdNDvKNHd950lNURns4KkQF3YGgU6MBTb3BA4Rvm45Vi0mEFyPPPxlCnZe
         9eFHM9h4SvCJEoRDUhKYDoaFCbt+lAqid/NkFzUSVnSgvNcRajL+DpF0xZBKTcOwrKxh
         g0ExFz/Wi4NLFAIvwv9pt2F/FNXb7XZCPM4DuLGH6zgQjHWr8m0meoCaB4paefPRquWk
         NIRLTKygDWPbEZfjRNzUS4l4PYvlu5YzEp4iXJEWSA1v7SwBe1KO0IHEkBxzIhSFUYu7
         2yaap/goEdI4tigQ14Hmw1P7dE6VWZF5C7vSR5rhhRbJXU6JBZ9CoPLL34gGTEhZba6c
         vNBA==
X-Forwarded-Encrypted: i=1; AJvYcCUWEVlGN4NJBl+xX97GdqdQzy9ZFf64HXTKwFHCuBje6MgdAzIY/65AdAaVfUUgvwzO51nAkOjXE91a0lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQam+IOdwMUxLZkBcvOZSnS4aJGtmtG36mTEmLJkaVphTq0eg2
	x9kTNFK53KDPJpLIBrb2sirCr6AiVDPsuNNOrkl9GjmtDrlNFpWOCDiN18XVVbg=
X-Google-Smtp-Source: AGHT+IHNxQPlxbO39/cx0Bj0wtirFeB+QLLR3F4SPq6zq+0AX5aNWZRe22SFOp6JVWXV6bMG2CpGIQ==
X-Received: by 2002:a17:907:3e1a:b0:a9e:b610:8586 with SMTP id a640c23a62f3a-a9eefeade5dmr1417029866b.5.1731416424054;
        Tue, 12 Nov 2024 05:00:24 -0800 (PST)
Received: from [192.168.0.48] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17684sm720243066b.34.2024.11.12.05.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:00:23 -0800 (PST)
Message-ID: <e0633e3a-8670-4541-b4ff-9f000b47b746@linaro.org>
Date: Tue, 12 Nov 2024 13:00:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] media: venus: hfi_parser: avoid OOB access beyond
 payload word count
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-2-8d4feedfe2bb@quicinc.com>
 <474d3c62-5747-45b9-b5c3-253607b0c17a@linaro.org>
 <9098b8ef-76e0-f976-2f4e-1c6370caf59e@quicinc.com>
 <f53a359a-cffe-4c3a-9f83-9114d666bf04@linaro.org>
 <c9783a99-724a-cdf0-7e76-7cbf2c77d63f@quicinc.com>
 <f6e661da-6a8f-4555-881e-264e8518f50c@linaro.org>
 <410e1531-6c1b-fb29-2748-eca57fc13481@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <410e1531-6c1b-fb29-2748-eca57fc13481@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 12:58, Vikash Garodia wrote:
> One thing that we can do here is to increment the word count with the step size
> of the data consumed ?

I think that's the right thing to do.

---
bod


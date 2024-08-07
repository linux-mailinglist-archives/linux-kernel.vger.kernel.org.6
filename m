Return-Path: <linux-kernel+bounces-277769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4AB94A672
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34377B2D5F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274C1DAC7A;
	Wed,  7 Aug 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xosc+3ok"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF221B8EA8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027782; cv=none; b=hlRM52GieJDisg3yX6xAODkPXCkL4XN6exU3YbMWkWKmUCFM8nLm5jlCTmJ2KXk3XbPK63/BOfsVQOeJ0cfCqyfJ1JZQ++lfA4Hq97HdSh5ikwGuoD5m7nWvKWj33GwA+OT0NGVFhCIf02YQP05+T1l2DSUkyVJXpvd97zMDMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027782; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8hU3WX1RZeynn0dfSLY1obhlQ3tZEs1a3VKz85tGmuthHSpj7BUO1VCXyHmGckwst5Hs0swUSZnJN11Izv/tuLRoPKpqasjPAYNzdd2uTZY58ABGkKMnlVZCdmTPfq6wfwXfxdswGjLseKSCoqNW+5uioux/fhtCCupkm09k/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xosc+3ok; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so168274366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723027779; x=1723632579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=xosc+3okh0nio5SOFOISjCL6L7mHRsHPMLR5GEcud3OhGiH0TBD3t/QDW5SlQn/tFD
         JoOgOubnH/gFWcl60NMzvSRHnCGb4H6L2Umcnep8QNBI/qDu5pb8AbwOFmcYwn69czI3
         bEEq9X8i2NM/mEBaVN0OLgaref7U8EygNDp36qiUAeygbAetf/j1KGFtOJCFfESWoaaq
         BMmMRNnzHP1FmkvodI768ZcJcfN6TiFe6KhpuHmq5ZIMPI1ZQjUeZl92yM2duAs2TPQm
         txrHSmyiHWlkcUtz/X/xepgVr0EDu6H+rGNkH+HuQauhbT5LXXoTqFNHK2b97cJMPx5N
         1W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027779; x=1723632579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=WF8jjBzH4rMagPIOJTdaL3kMmuxTP5l5KXjU/6fpzMwSMXX5i8B2/kPpvmsTh33gUp
         XQCQg77ZUwippCT5ciAWxXsggnGVmYGsmBdPGwVxWlBYGceJnwpqTg18vgGTnPHHiUQA
         BNPQ8Z0IntXuc5Bi2esc4fx8cpaZNW4JcxD1jt00MB7fnn/hLo/YdEA9twEEccE955AN
         DxRHnz/TfnsqSqtoIVA5VI5wZpSbed96fBu8a4IftZfAajcCZsf8RZ39zMyVOVy4mNwT
         t40o+hrhxK4yBK5sU/5sutAEotLk1YzttsLjnjp14MnUVhyLYcF007/lDcUAxYiwWLkA
         ODhA==
X-Forwarded-Encrypted: i=1; AJvYcCXe2xH8oeSKys0wDKZZ9AKCQEoOaGWR/Xpqs/TCoSQWyk6RwNAlPd1vAawWW3R2XOpBxv5JpRrMu49I4teg23U7cUSA7ULoN5bGMXb8
X-Gm-Message-State: AOJu0Yy3vNwZTY3p8xj/emWmVDJPyjLEJ+Gc+oLYboA76t0ELGs2ZNP7
	pqvJHkZNzGaFfB75JKmiIizY2ubXD5OzJsFDHFJjIPkF/EH6IVcKcDVTh+wxlm4=
X-Google-Smtp-Source: AGHT+IHSY0bmLDfSGhbBtnMDOvhC7FSiF7eS5TVjfR9u4hhBM5eeMK2YDYd/3F4hcgHZfhOFJjWUHA==
X-Received: by 2002:a17:906:6a09:b0:a7a:bae8:f2a1 with SMTP id a640c23a62f3a-a7dc50a2f0fmr1328523566b.42.1723027779415;
        Wed, 07 Aug 2024 03:49:39 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc4fsm633411866b.77.2024.08.07.03.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:49:38 -0700 (PDT)
Message-ID: <2e639150-5c7e-4ef4-b54e-b25b10fc9313@linaro.org>
Date: Wed, 7 Aug 2024 11:49:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: drop unused argument to irq
 handlers
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
 <20240806-samsung-tty-cleanup-v1-1-a68d3abf31fe@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240806-samsung-tty-cleanup-v1-1-a68d3abf31fe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


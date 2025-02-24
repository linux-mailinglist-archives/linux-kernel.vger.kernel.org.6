Return-Path: <linux-kernel+bounces-528963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAA8A41E74
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBCF17D978
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC02571B2;
	Mon, 24 Feb 2025 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OuyGjVsi"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB5194A44
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398650; cv=none; b=mC4BiqKWw3fBwM4AAv+MJ3SiiS/IK5VYMmxz8jYhCHtJmUlBw3D8bj0IMf831j3qnTAhyQM8/S4+Q4azwnImNKtSeSEJARkP3UQLV7jso1Pk9HfHL6KYDWqSSCyamOKsoM7GRo3/kvhgKjf+G+RLcDk1r6p/V9vrRcAUzT3GtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398650; c=relaxed/simple;
	bh=+L3PhZEmgQaSbRAuJHWLglYt4qjvAOIrF1s42gg9W6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE/dxnXAc69Ik/GFl4PHh7Zgce+C5O2pQKzV6y8IyjNgvXlpyz1lZArUhAqkYjGt4YSgE+nfTQdX1ee+fX+xvu0wtchYF5USPCa3RWQr1AUBpvq74AxW/XgBvPWzgisc7nRfqwkAESB3V88g7E8ERya0/cK/rMWPDE038Os7dXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OuyGjVsi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f378498c9so4057762f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740398646; x=1741003446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0onFnRxIs2kBe+jELL7hIQKKJxUK1QSzk168t3wEz8E=;
        b=OuyGjVsi0z40guKq/yLMns9O69WhUyg5/ww9DyvsjsWoTKLbuhYaPy5toSyCNZbFhP
         Nt9mWOVxzC2IrPcYYEEEzELdIwYnQv0URlGr62FU+c6MeogXORACb/G+OcC3K3VRkeBe
         kwWEu6HwRzhZaEV5NCqrG0fE6cNbR+RyQWnZfGZ5qol/rSewIt0Mwt9w8HZfLGd6Run7
         +YoOa8iRNamF6+7p+ONrXMbyZUMuQx1W/Ho0ujUy97ZA8K4ZuvTKe4ts/4695iQmnAE7
         5myDGC5hJxmN6mXOFXO8OvHXdNZQ6EHq/ojv6nYJQ6+iFAV0tIltNm6syymGLxDoq2Nq
         i8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740398646; x=1741003446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0onFnRxIs2kBe+jELL7hIQKKJxUK1QSzk168t3wEz8E=;
        b=gpgdT/QIQp0KGZ9rrnS4aXFk2Y5Iy6WJpLGptKshLNAAPEE14lUJLTSvpKMSWSQoUf
         vj0XkN3yL633vpwmLGaAbET4EWN0F/Mi6M7jTg0WI5flleLpNWD8WbNbtSbjtx6neHPc
         ARTtM5F9f2WKgTwSFAXRR+ffFk7DMbO0Ulogqn4ww8qr0/tgRRRNRviaJvyiMNI5syVh
         iduvBiJRDeCBZ2p1MVlyTG7Hagcbqd0cgGz7LBhAzwUw1B6XXnyxp9f8ZJl7uELuQwsn
         xnsaRYPhzockuIGX+uqjvSRXRYEXoZRDJ1Fy4RVlF0XEAM35hoL25mqpLsks2KTo81Vv
         OxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX0OXaknDcYOKfdyKxp/mcMNASVcOLO9+Gy9pOA/eu59oHNTQjzeVj/cZaANcL3ehp8OypHaveqx/KS7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vEC6592v/4BNvrNz2f08eDriQag9XNbvTx4V2obfIk19kvBo
	lezicyy+RLTF/25eiOqiPIEQfPdz8FQFrypoaz9BVfZ0Mqs+gVDEDNQHXJH2ftU=
X-Gm-Gg: ASbGncv0z9K2DwUTEQ+oVw/c1RTty6k5JAvqvvHWMfsz5BwK7zWvmiEqR2rJ4bBvpL5
	kRQvLiqV5OOw0NVoZRsVcZMv1yn2wepRxptDj4TsPYwDBq1byrmYulY0u8l8zAeU3BsNoWCpmog
	HS5QMop0wZeS2hwMBmsyBUhpEjaYrRmIwG0tZxC14k6nejLghvYFsSRWjdiHjmXQL5NXTOPK1eJ
	KcF19JNiyYBmbaJ6lHas3Fa+CV8BWxpC7Aj7onI/TzJ31Y5A+Wt11aXffzGZUZX35x8Vjk/wGjZ
	TB74oLOraBOx8WhdVdpb/757mvsBpcM9DgA5UEr1xOIzhF0nh4et
X-Google-Smtp-Source: AGHT+IGRKIPeXT1LNLoxtMfDiXfqTI3VfaUvrkEcTwnu3mVHJKxvqex6Qwlkx3D50c356CoRnS0VIw==
X-Received: by 2002:a5d:6daa:0:b0:38f:474f:f3f3 with SMTP id ffacd0b85a97d-38f6e95bd66mr11180365f8f.13.1740398646115;
        Mon, 24 Feb 2025 04:04:06 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm30819875f8f.41.2025.02.24.04.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:04:05 -0800 (PST)
Date: Mon, 24 Feb 2025 13:04:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "davem@davemloft.net" <davem@davemloft.net>, 
	"Glaza, Jan" <jan.glaza@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] dpll: Add a check before kfree() to match the existing
 check before kmemdup()
Message-ID: <kwdkfmt2adru7wk7qwyw67rp6b6e3s63rbx4dqijl6roegsg3f@erishkbcfmbm>
References: <20250223201709.4917-1-jiashengjiangcool@gmail.com>
 <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>

Mon, Feb 24, 2025 at 10:31:27AM +0100, arkadiusz.kubalewski@intel.com wrote:
>Hi Jiasheng, many thanks for the patch!
>
>>From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>>Sent: Sunday, February 23, 2025 9:17 PM
>>
>>When src->freq_supported is not NULL but src->freq_supported_num is 0,
>>dst->freq_supported is equal to src->freq_supported.
>>In this case, if the subsequent kstrdup() fails, src->freq_supported may
>
>The src->freq_supported is not being freed in this function,
>you ment dst->freq_supported?
>But also it is not true.
>dst->freq_supported is being freed already, this patch adds only additional
>condition over it..
>From kfree doc: "If @object is NULL, no operation is performed.".
>
>>be freed without being set to NULL, potentially leading to a
>>use-after-free or double-free error.
>>
>
>kfree does not set to NULL from what I know. How would it lead to
>use-after-free/double-free?
>Why the one would use the memory after the function returns -ENOMEM?
>
>I don't think this patch is needed or resolves anything.

I'm sure it's not needed.


>
>Thank you!
>Arkadiusz
>
>>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
>>Cc: <stable@vger.kernel.org> # v6.8+
>>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>>---
>> drivers/dpll/dpll_core.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index 32019dc33cca..7d147adf8455 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -475,7 +475,8 @@ static int dpll_pin_prop_dup(const struct
>>dpll_pin_properties *src,
>> err_panel_label:
>> 	kfree(dst->board_label);
>> err_board_label:
>>-	kfree(dst->freq_supported);
>>+	if (src->freq_supported_num)
>>+		kfree(dst->freq_supported);
>> 	return -ENOMEM;
>> }
>>
>>--
>>2.25.1
>


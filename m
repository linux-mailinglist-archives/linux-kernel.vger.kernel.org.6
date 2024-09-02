Return-Path: <linux-kernel+bounces-311087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1819684B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5996EB23AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D2213C810;
	Mon,  2 Sep 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNhvW4jF"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85A74063
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273186; cv=none; b=jTB06S1TmlA/mW83Phzr//5POzm8fo29qa+CvCpPAKhcyL9sS3aKsoIM1qAwju9Kn1V4E4kjbPB7q1htIbah0aXRoBr971pkzaH5nmpwFcnkB4aHmLlrji//rOGDKETArVmvs8jkOKZD9jAdR82aE1rFx7Ia546sExO3sypfo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273186; c=relaxed/simple;
	bh=AeWcujVxGI8AnbHV/0Fe5wTQkWQqRzeq7103SLsOZng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWa9ejcGFxKolfvetOsHQrM1AfoML8KnGb7Fu4Un+fl6pe5gDDT+Dq6r3YTQ/nuJkVB1ZUzsAUeMrpJaXuw2y9jG5tTXAN8IdcCXB4IepZfDpfsrE1H7W1N15t8AmcoPJojzftkIS4oB0LiIV346YksOLJAAhI6jIp1an0HEtKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iNhvW4jF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c84dcc64so793423f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725273183; x=1725877983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IDmZ/aZ3vBW92cNlQa3RNHObQ8G7xlzNDeZDmBZoWM=;
        b=iNhvW4jFDlCyxuWHtRXYp0wknHqBBK1peZ+K3VWKsqqOyyHLm6o1cSc/krvwFRJMdc
         Tf7fdqAyToGLlblVHDppoKnex86W7wr9NGgGt6QLteBHWSdv6CoqAwOqaknbuwFDmlxb
         jsFXj5UutheErWUqmZC+Jutk48iem7OPk8pYEl5ACitYISi5TRkwDiZVe7MtYIKd7GA9
         fvi9ikiqMiW67g2id3aDbI41T4Yu9Jl74+YNasoBYHwl4WEAZ3YnFgK79RI16HyNKgMW
         uaA+vq5YZNvvj9j2mBqD+DkjGqKbv1gGKccWPf62P6bXeFqGGZic9QX/lYt44mdzVgKn
         NFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273183; x=1725877983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IDmZ/aZ3vBW92cNlQa3RNHObQ8G7xlzNDeZDmBZoWM=;
        b=PIFfsuLo409HLR2/yvOJRGTiUSKfvRGLindAafpBn2/eqTR+hWArvnjIz6n7pg6dnj
         X21lPszlbllDFMTwP6D1bW1Fq/pmDtTiuO1YKPqH+uGGeSTjeiCwvAQNGvfZqCHyCadp
         SUc44t6EapyLIOkrgif0U77MphdIAgL4Xse64c7vy4Vj3fUJvExTmpfdo4j+FAecQSTG
         YTsa2plf1UxGKWAQOtQ40wj+pYbzUpW1DZVQDs5vSCvnSnOiPILZDySbx23SlSmCCFgi
         K8wccHGuklKFa1Y6RZtB3IloP6ijcutfONEGSG82W7vrMjOJ0i+PrUyLKhzqigc3NjPF
         M2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk53gTfcGD7kxw6+smQgF6dKPMrgW7uZNoRRUKz9hvALL/k4qt/AgIWYhEHVl2szwAt0/pfLN6oGr8Ss4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0T8FCBIqeEmH8NUwC2jzwSkEyNfS1NGXJSWKoaxjZOWyp/mo
	dREnlAA81Ztx5ZyjGHez3N3qeQyzNImQrTTdoplBaxq43vh14QIJJv7wWONOkxsyL/8VLsPm4sN
	H
X-Google-Smtp-Source: AGHT+IF0Qnfpr7eU8dg/jrcnWRo42Ljom+UGkTgrufheCBhHiIjav5pkCmNDQQT21+YZ/TJILXrodw==
X-Received: by 2002:a05:6000:124c:b0:374:c29a:a0d6 with SMTP id ffacd0b85a97d-374c29aa194mr4302034f8f.2.1725273182890;
        Mon, 02 Sep 2024 03:33:02 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-374bfbfc7b7sm6089254f8f.88.2024.09.02.03.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:33:02 -0700 (PDT)
Message-ID: <21cc2173-2934-470e-a151-ed3fe2bba9db@linaro.org>
Date: Mon, 2 Sep 2024 12:33:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/jcore: Use request_percpu_irq()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>,
 linux-kernel@vger.kernel.org
References: <20240730132015.8920-1-ubizjak@gmail.com>
 <51c33ede-b379-41ab-88b0-71615e214853@linaro.org>
 <CAFULd4Y83ciewbJe36jsuTVXL705_DoS_QpjKayniSCdqkpsEw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAFULd4Y83ciewbJe36jsuTVXL705_DoS_QpjKayniSCdqkpsEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/09/2024 12:11, Uros Bizjak wrote:
> On Mon, Sep 2, 2024 at 11:17 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 30/07/2024 15:20, Uros Bizjak wrote:
>>> Use request_percpu_irq() instead of request_irq() to solve
>>> the following sparse warning:
>>>
>>> jcore-pit.c:173:40: warning: incorrect type in argument 5 (different address spaces)
>>> jcore-pit.c:173:40:    expected void *dev
>>> jcore-pit.c:173:40:    got struct jcore_pit [noderef] __percpu *static [assigned] [toplevel] jcore_pit_percpu
>>>
>>> Compile tested only.
>>>
>>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>
>> Added Rich Felker in Cc
>>
>> Applied, thanks
> 
> I think we also need the following patch, since we changed request_irq
> to request_percpu_irq:

Hmm, I think you are right:

I would say it is:

static irqreturn_t jcore_timer_interrupt(int irq, void *dev_id)
{
         struct jcore_pit *pit = dev_id;

	OR

	struct jcore_pit *pit = this_cpu_ptr(jcore_pit_percpu);

	[ ... ]
}

The former the better for the encapsulation.

Do you mind to update the patch ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


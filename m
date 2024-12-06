Return-Path: <linux-kernel+bounces-434972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960AB9E6DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D425A1882EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558CA200114;
	Fri,  6 Dec 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYRS3Hn+"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747A200109
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486348; cv=none; b=Xx6Or/U9Y0+bjgNYlTIF4ypXQ0t2aTA6k6i92gRewwG32KBh/Mv7/eZ75lPkAhGU6fIZv6jVsZX3BUAz9llm8mCh0Eo8yRsaZdrlV+05r5Ua/79xfFFABn2gU0McDwk7ES3cq6+XHaK3Lsf5RlsWqbnTbjZLHq0NZLAvutdEbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486348; c=relaxed/simple;
	bh=eNm8ETrye6gjjlqkEx1ruKw8lDAuRNX8prmHn4lv3f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfjVHM0may6qRM7RncYIyqA79Mcv+4LHZ6EYJZ84O5e8ihqGNfy5uAONSSFI7fhihsBiXRXAmcSTw3GiFXnjR6+LlzkrqtL4iTCcr1sWngyFdj3iK5m2IIE6vJVizGh3GNB3prOQAogDuoEz0LzhSlS0tN9G6ZVWy5EIHMvRjKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYRS3Hn+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso335678a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 03:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733486345; x=1734091145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkgL71aCC+c5eU3/5Ahdd+PfY2GgDv7LSswVdp5m+AA=;
        b=wYRS3Hn+UmwR8DVD3nmE8wz6/AcD+Y+vS+QmjB52ehqNwmFnnpGQwmJnJRpUtLYDVc
         KvADpGuLgiT8lfF2mvAwRhRnXft9S4yUyORew+ywBzD6WpmqACnVp6WAt65HmBVjETHM
         Pas1xTi5AFlKfZ3A/UHfm5snrTj7bAyiPa+4nAQ+e6UjCTMvIaTHSqBbHViVMiu9tKJR
         MH58J/LdIOKXJp+SQwXM/MmTi9haBp7LcTJI9g5T/NLojcRGBn/L39nazHvp15aZ6C/k
         iU12OIaJ6BDlKWoA6C3p+aoLl+sUuGBj+vIkWwzwV++WPO7Y5pBc7w4sEkyjbUlINyH3
         fWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733486345; x=1734091145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkgL71aCC+c5eU3/5Ahdd+PfY2GgDv7LSswVdp5m+AA=;
        b=Xg0zRf7eA9XTQFHyVYiA/0ljycm8ZmFMS+LsPy4NSbo9sJb+aolbaYQPDKarb0bZ8N
         4I4CwfEvMxbeXI3kiBt0aSVQ3fbhJoXBdZ14waQbyzZL3oPl3E5eDuGn6rQ9dry5ApYi
         SJDYagsAt6bfE9ZWIm6t8ZwDq6YHIdJvSBlWrz42forsiJsHIaSfHczX9KqrT3IlA/pI
         Lnv3aqCk6V28gyaslnBB8qzonEC0oIhNA+2nfAhPekiISC2oct14Y6xg5yerVLAhF4D4
         GPaaV78hJkaK54y+XhLC3djbakT+MwJMoqRpkS/O/V2SNp5a3490KGk0djVM9ylsaJFn
         PcXw==
X-Gm-Message-State: AOJu0Yz3Qru/ckMJ3pCHSfv/iNo1jyTMz3sU/pfNje2YdVWyV7AHYkP+
	U6GfG5fBfIfO1XUK0gnR5ab4lqI0kEtXQsKoWPUeyxBXUea16wF1lFYalFxqnXQ=
X-Gm-Gg: ASbGncsmVkPUM0o2eEY92C/2dzzWGJcbvTmgRPjv7k1DwZUVUTm6iQABoJyEaqJQYfA
	MPE1WpoilA65+lj+c1r26Bk3SocV29KlyhTTNAJCBDKkPTSw4krjuxZ7PEsFw6E8mGMUn8m8ejk
	/MZ0735pBe7yv064aTAi5eCGQbuCmg3FJRQwMoplGts8f0qFbRe0DtZqSR3ji7BCrf+TSbImBUz
	BCLf1JHaKnAXosr800Tg52IbF2N3Z1TINOZAnpdxgVUt4u1O1qLIkt17w==
X-Google-Smtp-Source: AGHT+IEHIi9QWxcwQ/B/5PO4EWqQexTbFpihDQmGHpBVwImN5z7OBHtx4LNIPsp//1PemqEWOn6Y3w==
X-Received: by 2002:a17:907:9385:b0:a9a:3705:9ad9 with SMTP id a640c23a62f3a-aa63a2550c2mr202722966b.50.1733486344908;
        Fri, 06 Dec 2024 03:59:04 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260eb8b5sm229008366b.193.2024.12.06.03.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 03:59:04 -0800 (PST)
Message-ID: <aa09bbe3-8f5f-42cb-a7a9-deaaef77affb@linaro.org>
Date: Fri, 6 Dec 2024 11:59:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] firmware: add exynos ACPM protocol driver
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
 krzk+dt@kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 kernel-team@android.com, William McVicker <willmcvicker@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20241205175345.201595-1-tudor.ambarus@linaro.org>
 <20241205175345.201595-3-tudor.ambarus@linaro.org>
 <427caa87-b9ba-4797-88bd-a18a96eefdcf@app.fastmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <427caa87-b9ba-4797-88bd-a18a96eefdcf@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the review, Arnd!

On 12/6/24 6:47 AM, Arnd Bergmann wrote:
> On Thu, Dec 5, 2024, at 18:53, Tudor Ambarus wrote:
> 
>> +#define exynos_acpm_set_bulk(data, i)					\
>> +	(((data) & ACPM_BULK_MASK) << (ACPM_BULK_SHIFT * (i)))
>> +#define exynos_acpm_read_bulk(data, i)					\
>> +	(((data) >> (ACPM_BULK_SHIFT * (i))) & ACPM_BULK_MASK)
> 
> Could these be inline functions for readability?

sure, will do.

> 
>> +	cmd[3] = (u32)(sched_clock() / 1000000); /*record ktime ms*/
> 
> The comment does not match the implementation, sched_clock()
> is probably not what you want here because of its limitiations.
> 
> Maybe ktime_to_ms(ktime_get())?
> 

Indeed, will use, thanks.

>> +/**
>> + * acpm_get_rx() - get response from RX queue.
>> + * @achan:	ACPM channel info.
>> + * @xfer:	reference to the transfer to get response for.
>> + *
>> + * Return: 0 on success, -errno otherwise.
>> + */
>> +static int acpm_get_rx(struct acpm_chan *achan, struct acpm_xfer *xfer)
>> +{
>> +	struct acpm_msg *tx = &xfer->tx;
>> +	struct acpm_msg *rx = &xfer->rx;
>> +	struct acpm_rx_data *rx_data;
>> +	const void __iomem *base, *addr;
>> +	u32 rx_front, rx_seqnum, tx_seqnum, seqnum;
>> +	u32 i, val, mlen;
>> +	bool rx_set = false;
>> +
>> +	rx_front = readl_relaxed(achan->rx.front);
>> +	i = readl_relaxed(achan->rx.rear);
> 
> If you have to use readl_relaxed(), please annotate why,
> otherwise just use the normal readl().  Is this access to
> the SRAM?

all IO accesses in this driver are to SRAM, yes.

There are no DMA accesses involved in the driver and the _relaxed()
accessors are fully ordered for accesses to the same endpoint, so I
thought _relaxed are fine.

> 
>> +	spin_lock_irqsave(&achan->tx_lock, flags);
>> +
>> +	tx_front = readl_relaxed(achan->tx.front);
>> +	idx = (tx_front + 1) % achan->qlen;
>> +
>> +	ret = acpm_wait_for_queue_slots(achan, idx);
>> +	if (ret) {
>> +		spin_unlock_irqrestore(&achan->tx_lock, flags);
>> +		return ret;
>> +	}
> 
> It looks like you are calling a busy loop function inside
> of a hardirq handler here, with a 500ms timeout. This is
> not ok.

That's true, the code assumes that the method can be called from hard
irq context.

Can't tell whether that timeout is accurate, it comes from downstream
and the resources that I have do not specify anything about what would
be an acceptable timeout.

I see arm_scmi typically uses 30 ms for transport layers.

> 
> If you may need to wait for a long timeout, I would suggest
> changing the interface so that this function is not allowed
> to be called from irq-disabled context, change the spinlock
> to a mutex and polling read to a sleeping version.

I think the question I need to answer here is whether the acpm interface
can be called from atomic context or not. On a first look, all
downstream drivers call it from process context. Curios there's no clock
enable though in downstream, which would require atomic context. I'll
get back to you on this.

If there's at least a client that calls the interface in hard/soft irq
context (clocks?) then I don't think I'll be able to implement your
suggestion. Each channel has its own TX/RX rings in SRAM. If there are
requests from both hard irq and process context for the same channel,
then I need to protect the accesses to the rings via spin_lock_irqsave.
This is what the code assumes, because downstream allows calls from
atomic context even if I can't pinpoint one right now.

I guess I can switch everything to sleeping version, and worry about
atomic context when such a client gets proposed?

> 
>> +	/* Advance TX front. */
>> +	writel_relaxed(idx, achan->tx.front);
>> +
>> +	/* Flush SRAM posted writes. */
>> +	readl_relaxed(achan->tx.front);
>> +
>> +	spin_unlock_irqrestore(&achan->tx_lock, flags);
> 
> I don't think this sequence guarantees the serialization
> you want. By making the access _relaxed() you explicitly
> say you don't want serialization, so the store does
> not have to complete before the unlock.
> 

I could benefit of the non relaxed versions indeed.


>> +		.of_match_table	= of_match_ptr(acpm_match),
> 
> Remove the stray of_match_ptr() here.

okay

>> --- /dev/null
>> +++ b/include/linux/soc/samsung/exynos-acpm-protocol.h
> 
> Why is this in include/linux/soc, and not in the firmware
> header?

right, will move.

Thanks!
ta


Return-Path: <linux-kernel+bounces-518978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B36A396CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652133B1789
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948120CCE2;
	Tue, 18 Feb 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guX+IQym"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FF228CA5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869921; cv=none; b=H5XLpFKfcBKC98i4olbgY4NQ2jWCJws57EfkEV+w71GA+qf+MOYh3GqoCmUT//lswWBqnKAt7s8nbSShN+NPYfkykKTOa/f4xVZBntnV+azeS+QxEUTaghNwqsncSk7Kg/3ronlSSj9R1t4PzsET5/XhQy1Z1AR8H9pF3/LVcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869921; c=relaxed/simple;
	bh=UzhNznqgAAuIcZzZPrJUtoMO3STF21152UGRG8HaC/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuf3NQNgM119NrszvHh1x4IoaCBlUvTt99oVxBReCBZx7ni0IAt45k+dQCDWPXNIHcICTppLQ1ARyYRj7NOpHoV53rDpAgQ6L/CK0b2N52Lbaxor6LAHW9HdFV0yj8qBC016najGAzOdk03jTyGre2kDGV6Y9oOfzH3RYwPIepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guX+IQym; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e07897bf66so713023a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739869918; x=1740474718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3uXTrr03eTBp4TQInaTHeB1lyJsdQisBIQEzz1BspM=;
        b=guX+IQymz6uDTHw8M8yrP85wM1puEgjhC8F5+CFOiJb4WQwjgb4GEfCIBQL8xUQknw
         kcpgvAYBypq9pd/p/7U/ZLY81HzUezgMuab/FCggH//Km/kKDB9ynoslCRKfam/ga/Gz
         4sER1E62Q8Kz6cBLghd1uAw2RGRFfom5TF3sLNy74OrZOqy//3mk3IIT+hwDk7uDq1o9
         0spohzSseEG2AUoUPL9Z2EyzE6gxADlDndIEQTKgGFEFpdXUUHotqdtfMAV8CPqtqBtI
         5Ca+T5xJRC1gtzS2Tz4Wv93xFIG1MTtH41hGf0jJbstEEWPVtgkOm9gbPwstjfZnJwBD
         ooJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869918; x=1740474718;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3uXTrr03eTBp4TQInaTHeB1lyJsdQisBIQEzz1BspM=;
        b=nmncQDQ+LpKV1jJU+by7z4P0OICvGM0mlRNnzKOGZnn5Mfug6WlQFO6EnlKv5XB15E
         0K1MxwYHjkdlDGDLraGnJrkVPubpH4lDGmABhGOoOh5wa0Uj3hdUfRL+Q0Y6VHwiZd2L
         juUtPEcLSx1DREuSWYMCJPGwXGjcMd05tPgTiAD6vKhHSnj+s/Gpjocu1Uh95Fz4Uv9Z
         YOrcF1nfainYTbm3HWs0aaZ8+eWCZCgGHOjcWV2+pxEtHkx1l1NCccX0j9ge470g79D/
         diBH+QpzfoJEnwvYmp0nq4EjKcn4YbKEi8tZOPXH9u3+LEApm/cL+Z+8COdEYd4F3OAA
         U/WA==
X-Forwarded-Encrypted: i=1; AJvYcCWbg+opjIUh6tv9HTxZKa1JsLkcYtqhE418NsK/hTbOYDrPeTI2AW+Jhp0zoUJuQt3iSiuN0g4EInwbY9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjyWMBlM7co0hjxVJGEmBb4wdXcwOU7uzUHuW5Ncyr36jAGj+3
	Wr8ItJERJQY0ghLIumYkK16O+ECvFM3sOR1nNup1zv1fc1Lg2sXezAioQbHiaJg=
X-Gm-Gg: ASbGnctcSlB+679CdhGURc2eMswF+1T6QYpfaXpf+cWYKNRkNauqXJ1woppM4tfrOho
	m/6JD0yrmIvAniGC+r4JitmjyNoIbTRVTeFYMxGzoIFyIxV0sjkEVYE90ceaKAxSwkYOJDrHJNa
	HfFoSHYVo21Nw5MCj52DsHATYLigr9lyeqYOSjluWt4MxC3K2cds73qBDirUtQmCZRXtnP/n+qf
	bQLUw3nreIV3oEMj+EVxEa+nDsqb/j4FnESvdN2lJ26I+7Uvdkhd61eq5qJG4Ak/9yHRu4f/Crl
	Epr2FJgqondFrIAraXK1WCc=
X-Google-Smtp-Source: AGHT+IElObB+wPJH8ll7VWsYIuWeUZ3GQukv025YddeShYC2NXJtKepo4lLlRZ3MwK7mM+8bMe+zXw==
X-Received: by 2002:a05:6402:5246:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5e036055eb7mr13524262a12.6.1739869918369;
        Tue, 18 Feb 2025 01:11:58 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e076048c05sm924724a12.35.2025.02.18.01.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 01:11:58 -0800 (PST)
Message-ID: <e925a6d7-aa71-43cf-ab84-bed65b78cbe3@linaro.org>
Date: Tue, 18 Feb 2025 11:11:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 07/10] printk: export symbols for buffer address and
 length functions
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 kees@kernel.org, linux-kernel@vger.kernel.org, johannes@sipsolutions.net,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, tony.luck@intel.com,
 gpiccoli@igalia.com, pmladek@suse.com, rostedt@goodmis.org,
 john.ogness@linutronix.de, quic_mojha@quicinc.com,
 linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
 <20250217101706.2104498-8-eugen.hristev@linaro.org>
 <Z7RELnyWRLietj9b@infradead.org>
 <20250218-175733-neomutt-senozhatsky@chromium.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250218-175733-neomutt-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 10:58, Sergey Senozhatsky wrote:
> On (25/02/18 00:26), Christoph Hellwig wrote:
>> On Mon, Feb 17, 2025 at 12:17:03PM +0200, Eugen Hristev wrote:
>>> log_buf_addr_get() and log_buf_len_get() can be reused in another module,
>>> export the symbols.
>>
>> Err, no way.
> 
> Yeah I think we've been there before [1]
> 
> [1] https://lore.kernel.org/all/20230905081902.321778-1-hch@lst.de/

Okay... in the line of the purpose of this patch series, I would like to
be able to have the dmesg ready to be retrieved out of the kernel in
case the kernel becomes unusable (due to various reasons as described in
the cover letter). However to know exactly 'where' is the buffer stored
I would need some way to point to it.
Do you have any other suggestion on how to do this ? Using the
kmsg_dump() API works only if the kernel/CPU can run code.

Thanks for looking into the patches,
Eugen


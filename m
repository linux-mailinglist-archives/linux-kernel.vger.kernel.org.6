Return-Path: <linux-kernel+bounces-219498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE9990D375
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391D41C24BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F3218A947;
	Tue, 18 Jun 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vjESDmIY"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FB413C683
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718155; cv=none; b=hvQGo37TwLkE77+WHzIchKa8hs8jCj6G5o2MLOfNRzE9fQZ0gEtuEf/L9BiUItTTIHvZLtCSNA2WSfQFc7P2bJulf70vmCy1B6d+C3/BHma9pIxH7MGN09gbm6bOWqkd1QJ2ekvFBFCjAj77qKJ5YIFSi9Y9dayFvzzpI5tbcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718155; c=relaxed/simple;
	bh=Hw2rKRrQ/vNk+YVNe/TVwDJWQKj5mGabhKIzMLIBezU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9AfaMBzinosM4AkxEKjKEGz4ybUkGVcZuy0QFyXT1rChQUGNZyuPSiz7dE2K9wdnAoyR44xpP1yiy/PqrLDccAF85FrMlIwdhgFVGjj+4wEZCizceZ1VN3O7jtPMEHxkExgSy/TxUdD/Sny1L4MDiEi/XsKnfCDegbbdU9sNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vjESDmIY; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f980c89db8so2979455a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718718152; x=1719322952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2yaAmgIQdF+jsEnorEZWLhxEmZSW+woyCJvm4XIFQg=;
        b=vjESDmIYKDbrgsnUIvhTS3Qajji9YiT/X6+aoXZyHhN4aZIw0rZxpFXHzSXQdDgPSB
         CGQoLJwRAFB3VR4K2+o2Q52LUQZkjXKbzxcpXc9dGGu5oArS5Ub4Q0WK6lHzvnqfvX3h
         aOIO7+MKgEzASMG6H0rq+acAoK1VGE5M7QV0jvypWP5UBlEIi+ap7NurdTFJ0mJT1sOj
         GmJGE/WBN1oh0il+zCRE40UCjyvWfkhsmYys0swctfYvyOGtG410zVudQBv3+feRQ7vs
         Y7qt4pbMT4qx1v+A2dGOPj4LSntM8jVtaRdZomt99h2pBic762IgkwHhDn4/2YSlQWY1
         zFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718718152; x=1719322952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2yaAmgIQdF+jsEnorEZWLhxEmZSW+woyCJvm4XIFQg=;
        b=AG7P+7J7g1F4jlYsN6C9q+XqiP0w59OfNPYxoT2mNgNPLTmsKAPix7/9JkFGRbaC5j
         5Pf65CcV+W5pOppE8HFVPE1t0m0qSZTTZHLjaMpMOl8oBwKg/g9sKaLzDPW/+Cbmed41
         kGR/Q7Fy8ysGC37tSnKVtsJmfk4eWuTQtKhm///2BEs5nOjg8rVn7zgyUXPuqR92VQ0L
         1su+igIi81YU5zYV/OwDqqV0eB8IxvDKEChRo5SP7j9Cr/IODxzvt2KNQZ5KPitqqWh6
         MVhjMjFsgwHslJf98+SkQsnbRoZl0KYcBPlgyFhbZuPqcRYIRwvxL2D7yvmv3wkKIK3R
         LOUw==
X-Forwarded-Encrypted: i=1; AJvYcCVgWh38rq257+ngh3qwDE4mPsq990wwfCJzuRVmjCCEePluphadOd+ict2jicyTQzN85sOEy4sb76g7Raf8qiRnGhPMIjRY3uBs2tik
X-Gm-Message-State: AOJu0Yzp2TOsmkwOGC7wCbPRQjS/rhR9TH/cOLOpLLpywFTlBBRLHGBl
	T4aeQ3uHQT9MVUYtbLcH7m7KssSIrQV2np3nnQUpjjHQwFzw6AncrvvS4Q9EYE4=
X-Google-Smtp-Source: AGHT+IH0XBL+oYGfFfDAABV2lY6rjFGswntrsxIQtwr5eSwP1oqGMYpSQ45XFMtQjvOVFYM82V+h4A==
X-Received: by 2002:a9d:6d92:0:b0:6f9:6e0b:4ac3 with SMTP id 46e09a7af769-6fb939ec9b6mr14767727a34.23.1718718152649;
        Tue, 18 Jun 2024 06:42:32 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5afa9ffesm1824394a34.15.2024.06.18.06.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:42:32 -0700 (PDT)
Message-ID: <edc38640-42ee-4bde-bc95-500498b5a461@baylibre.com>
Date: Tue, 18 Jun 2024 08:42:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 kernel test robot <lkp@intel.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
 <20240603012200.16589-6-kimseer.paller@analog.com>
 <408aa030-23df-418d-a04d-a5551119624b@baylibre.com>
 <PH0PR03MB714164FC9335DFBC003E4F57F9CE2@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <PH0PR03MB714164FC9335DFBC003E4F57F9CE2@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 5:32 AM, Paller, Kim Seer wrote:
> 
> 
>>> +}
>>> +
>>> +static int ltc2672_scale_get(const struct ltc2664_state *st, int c)
>>> +{
>>> +	const struct ltc2664_chan *chan = &st->channels[c];
>>> +	int span, fs;
>>> +
>>> +	span = chan->span;
>>> +	if (span < 0)
>>> +		return span;
>>> +
>>> +	fs = 1000 * st->vref / st->rfsadj;
>>> +
>>> +	if (span == LTC2672_MAX_SPAN)
>>> +		return 4800 * fs;
>>> +
>>> +	return LTC2672_SCALE_MULTIPLIER(span) * fs;
>>
>> Are we losing accuracy by multiplying after dividing here as well?
> 
> Hi,
> 
> In the case of max span for ltc2672, I found that performing multiplication
> before division causes an integer overflow during testing. I was wondering
> how the upstream handles this case. Could you provide some advice?
> 
> Thanks,
> Kim
> 
> 

In cases like this, we usually do 64-bit multiplication to avoid the
overflow. There are helper functions for this sort of thing in
linux/math64.h.

For example, if LTC2672_SCALE_MULTIPLIER(span) is unsigned, you
could probably do something like this:

mul_u64_u32_div(LTC2672_SCALE_MULTIPLIER(span), 1000 * st->vref, st->rfsadj);


Return-Path: <linux-kernel+bounces-238276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB89247BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8306B1F21B32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB92F46;
	Tue,  2 Jul 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqwnuqSM"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4761D6E5ED
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946810; cv=none; b=HH4TekVgs/ph8Cj0bG399OMwUxYxzbgS2dJOif3ty7szHNc0xu1YoqcBB/a9zJOXwm9P3PhE/drGw8437kDFmbrIIejhdjJ0th8XC+0eTJEH//Vh775oeWJWsI+Yh/Gorg0dUt8QLBWXijglHNjlSKxZwLb5akYTmS/L4KuJj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946810; c=relaxed/simple;
	bh=JLXC3FdnRVpdlZi0gSr6nb7Bgz5CtKxU5/blWSFJ+7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3RnxKa9B/s8U/S7WTZgKT1u8MLUeyKdPinQcwYjFnG0RuWlMr5dT0015t8j3970kEu2hsR8nR+A4GNLgBCmxsHnzaJwgO0Q928CVTskk0BqDk1gQY6W4gzisjW1/76ZCGyp+7oj5qLeH+mJe3cU0q0bGQ9G1g/V7HBvOUIw/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqwnuqSM; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9cc681e4fso2384444b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719946808; x=1720551608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEPcVloGJVi0kMi856li8WXobhyjRWBvmAFJPrUl1oc=;
        b=eqwnuqSMXZzBmSAlcUJcTNa8DywOrUNlAFzoU4nawwnGjogEgwOrvz3pIq8mJtW89G
         3ASeH5MP5s8KdiSJP3XFjVnCzHFy7kv6m/c72HNs7x6LcO8oE+qh/uXS0kNdBm2P69Aq
         tFBcojf51GwfVNTCvSPhcoVYdSJXbs60Txe64qpdGuHs2sj7U0XmJ97Arrh/OfzB7Xl8
         oyq0280CqNBMf4x34OG2INSc9eUNvSfbSF8Yp9J9Rsh0OTDuxZ7Kg32zIpb+ODfswXdg
         19WZHhttUnNCz4J7bcS8p8kDJ1BE7YD8rbr5CLbqlrWU5XOA/VVbb7rS4Fbq8bMq2iop
         9kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946808; x=1720551608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEPcVloGJVi0kMi856li8WXobhyjRWBvmAFJPrUl1oc=;
        b=iT6T6S/izM1qGy208hyvAFUrsXYe5ooZjMqF0qeNLIDI6gFPzLTTwOohXY4wuatDA9
         /2ERSCeygNDHNIs1tb0ZHSdynOVM+a8ab4JQ2S7/l1wXXO/gAz710KnN28vPsFujr5AM
         ZPKaIDkwZLf8U/zQSVppF4BLflCox9iagqObqeUj64x4jew16juSI55jvJ6mrTx8kWd+
         bULNkKYF7cW9rjbPZCxt7apmpcITYpTVYGeNtcy6oc3MrfP7UBnTh8Z+Sq25Liu1kYnn
         FHHVU5IteqW42eljVU6BkgpYVeHwLlrRK6iKAs9/a5xGJToIJLGCWGPMWwtOpAFC3rX7
         Habg==
X-Gm-Message-State: AOJu0YwfwU9iUDVQ06DyAGWc4mzv1WVFljV/BoUeziQGjHZA11h1wgBn
	FHrVdkvrO5igzuNKhILtyJKxeJt/r6u9QBzgntAe5IfCuA6CQ45RVox0OXdT
X-Google-Smtp-Source: AGHT+IGFvWHJtacROjfKFmOg43PzeldA66DcuTBL4Gi+UrJFsKFpDfb1I7YxraopyCUscgjBJNzn/g==
X-Received: by 2002:a05:6808:1823:b0:3d6:9c05:1aff with SMTP id 5614622812f47-3d6b2b257e1mr14737075b6e.10.1719946808156;
        Tue, 02 Jul 2024 12:00:08 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20963sm1824515a34.49.2024.07.02.12.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 12:00:07 -0700 (PDT)
Message-ID: <13d0a0db-e113-42c4-9fbe-74ebfa46f46b@gmail.com>
Date: Tue, 2 Jul 2024 14:00:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] driver core: shut down devices asynchronously
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
 <20240626194650.3837-4-stuart.w.hayes@gmail.com>
 <20240627055515.GC15415@lst.de>
 <8a7ae125-883c-4c45-8b89-791066fb5866@gmail.com>
 <20240702050414.GA22160@lst.de>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240702050414.GA22160@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/2/2024 12:04 AM, Christoph Hellwig wrote:
> On Mon, Jul 01, 2024 at 12:57:40PM -0500, stuart hayes wrote:
>>> We discussed this before, but there is no summary of it and I of course
>>> forgot the conclusion:
>>>
>>>    - why don't we do this by default?
>>
>> It is done by default in this version, for devices whose drivers opt-in.
>>
>> In the previous discussion, you mentioned that you thought "safe" was the
>> only sensible option (where "safe" was driver opt-in to async shutdown)...
>> that is the default (and only) option with this version.  Greg K-H also
>> requested opt-in as well, and suggested that "on" (driver opt-out) could
>> be removed.
>>
>>>    - why is it safe to user enable it?
>>
>> I guess it isn't necessarily safe, if there are any drivers that can't
>> handle their devices shutting down asynchronously. I thought it would be
>> nice to be able to enable driver opt-in from user space for testing, before
>> changing the default setting for the driver.
> 
> I was mostly getting into the contradiction that either we think the
> async shutdown is safe everywhere, in which case we don't need a driver
> opt-in, or it is not, in which case allowing user to just enabled it
> also seems like a bad idea.
> 

I understand. My thinking was that is was very likely to be safe (the initial
version of this patch didn't have an opt-in or opt-out).

I have no issue removing the sysfs attribute if you think that's best.

>> I can correct these lines. I thought that an 80 character line length limit
>> was no longer required, and saw another line a few lines above these that was
>> even longer... and the checkpatch script didn't flag it either.
> 
> checkpatch is unfortunately completely broken, it flags totally harmless
> things and doesn't catch other things.  > 80 characters are allowed for
> individual lines where it improves readability.  The exact definition
> of that depends on the maintainers and reviewers, but outside of
> string constants I can't really find anything where it does.

Got it, thanks for the feedback.


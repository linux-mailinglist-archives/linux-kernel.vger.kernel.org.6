Return-Path: <linux-kernel+bounces-402253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E19C257E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927E51C21B82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486D1AA1EA;
	Fri,  8 Nov 2024 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L7wH1N9k"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8B233D6B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093783; cv=none; b=kFdjkYOo7F3hywVcntM5S2xraW8Yxo3d1V2CaQWWaawxaLEnZjrtscrIG/OJ5Q3IXsWd/4YhvzoN2HBFLPpOpJ7afN6bBLLdETfE0SQ/olMz9ltiWj5b8TPmObolaPtjMBEsuPFE6JfvKN6snk+h/a+kPNsZcf/crMW8O5X8g6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093783; c=relaxed/simple;
	bh=IAUJIwBdYWKtBE0Vnmi7VVdntZtwfeaeU0vVOBR4Wjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueLR9dqG5HbRH83FrX0q2kB0VUX0HDcPZOE9yJzJ1sJZy7sNepG6k8q0uYtbpb6QlMtDyRcKlH5JomLdMHhm6nKBhE+LgzsRoS7P90LTGQODiCoTzPHwdvnwBdiXI2CTLQ8XMRoI83F5ciC3kaYL3AjEREGYXuGnM7VMDWVfY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L7wH1N9k; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cceb8d8b4so17623915ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731093780; x=1731698580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WHvEPzIuaCnloxy5m0FklyFacTs1MbmOXmxDfeZH5M=;
        b=L7wH1N9k+K525MaDLKhxBFrM1oCn6BFGIVSA8UdvkWQYzDEfmogPWaTiGoDq1w997r
         L+SrQSFiJceUjt6ehXxjdS/dVf5O0W19bXTgdtXwCUyiAQEWdtwqLooAMKYYlIVNSGwi
         +ADbrJ0fGimhxRx/SNhKZil/xPHurjYIoQNIhPqcgGciJIg7tIJ5j2fF5W55skSLaITG
         EHJzbbMAPFFTNJrscu9GpdBTNQoUYdIUumBLxH8kC3v4WWbPdZ/JtrRFbHt7zw7iB8Am
         CDFUAwRZumZJVFKGItfcn8+fhm/dc3EfjadAXePdd+JmQ6fwnNzY1CSwQXzF867cu+LF
         WpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093780; x=1731698580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WHvEPzIuaCnloxy5m0FklyFacTs1MbmOXmxDfeZH5M=;
        b=tALJ3kzhYifZFXGxfGEHRRuwoz9DOCJc5BUDUFKFRoF4G4/HC3iXgHYcKPyeCfoz6b
         9MEicoKD+MYwDjuNt+NH904VCrWAPjXA3RCnqvhaHpTgfn8w1KQeqkGv0MiXJhzSzg+K
         bloi6it1H8+N5jiUCuHxjF84eE1Xtumodjt6rebwWrpVidxPJXOgWgxK8RePlz/bPxY5
         CF7psLT/TrgDFMTEa4ulRJEF6doy3cjvOcebJH9uYojG/FU8nu/ki6CTGDCFk/5GRhRn
         3JQ/MrzNUtAcR32eqCHH8XqpZ+JGOmwrOfxDTBQcs4vZUXh+7KmIdOmdr/EAXggrvfm7
         0LMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWZRnFF3x8q89Wu3h5llXa+9fR6KdrhU5FAeFop+QjDBbAMff2lORShNpCyyN2BvettGUTryNEV/c8px4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcS65Xac4qXu5laEGgj8DI7BGkwWW9rUfc8uaZPISdDidouJ7w
	N+GGYaRTEaQuWl4myFO+Oi4Vp9WG1QPd4T2J2yf9yC3CogYFOF5gMm4SVKsVpH8=
X-Google-Smtp-Source: AGHT+IH5C0D4ueeoqV9ISt39iXPf8LxCV5vetd5L0Cqq3YdVf2ODnHsEYmqvjt7hO0+vEYelcHAarQ==
X-Received: by 2002:a17:903:945:b0:20b:a9b2:b558 with SMTP id d9443c01a7336-2118223b6b4mr62359465ad.28.1731093780491;
        Fri, 08 Nov 2024 11:23:00 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf2b8sm34454365ad.91.2024.11.08.11.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:22:59 -0800 (PST)
Message-ID: <ca1f78bb-47e2-424b-a57e-f3272b1450cf@kernel.dk>
Date: Fri, 8 Nov 2024 12:22:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] mm/readahead: add readahead_control->uncached
 member
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-5-axboe@kernel.dk>
 <Zy5Wl84aHADMe8MQ@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy5Wl84aHADMe8MQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 11:21 AM, Matthew Wilcox wrote:
> On Fri, Nov 08, 2024 at 10:43:27AM -0700, Jens Axboe wrote:
>> +++ b/mm/readahead.c
>> @@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
>>  static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
>>  				       gfp_t gfp_mask, unsigned int order)
>>  {
>> -	return filemap_alloc_folio(gfp_mask, order);
>> +	struct folio *folio;
>> +
>> +	folio = filemap_alloc_folio(gfp_mask, order);
>> +	if (folio && ractl->uncached)
>> +		folio_set_uncached(folio);
> 
> If we've just allocated it, it should be safe to use
> __folio_set_uncached() here, no?

Indeed, we can use __folio_set_uncached() here. I'll make that change.

> Not that I'm keen on using a folio flag here, but I'm reserving judgement
> on that unti I've got further through this series and see how it's used.
> I can see that it might be necessary.

I knew that'd be one of the more contentious items here... On the read
side, we can get by without the flag. But for writeback we do need it.
I just kept it consistent and used folio_*_uncached() throughout
because of that.

-- 
Jens Axboe



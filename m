Return-Path: <linux-kernel+bounces-402254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016309C257F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9BF1C21783
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221FC1AA1E9;
	Fri,  8 Nov 2024 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="voy5FYwR"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20131A9B54
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093802; cv=none; b=Czm6PGV2ZlkTLhesNUEURp/2kjfHcXfNj3UvRy4gm2GnIy+utOdSrl4ilzvv7YJUl27EArKwbah54lTf05EVJ3hZHkP26Rh6cDGtBPeNFsYW+LsChW/nkluIfNqndQjL6xFp24i/3lcY2y0HyWZs//dGzQ98cEJA9YUaAA+KTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093802; c=relaxed/simple;
	bh=1X7JLYtlrptg55OrXWwa9P8Z92gMEAjTs8uvp4LZfA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWfzLYF34ucwwhhY8Q86O7CPo3+mYC0NccEuz5wrwHFgPRNPbGu7sSlzP0NICKWNHKXCPkZOtW3qRvbJs6nBsV94fpyjQPgc7Dj/chPAnwN9Fm2fO5e/sFOi8O8I2joSycgmKmhssNsm8J2bB9jUNYcHH4JbKyh7fb4dUNCPzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=voy5FYwR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2113076b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731093800; x=1731698600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sdbg9gcnJczABHk4QBqJ5vtKlutkOJQgskA5FFfGzPs=;
        b=voy5FYwR24I1wzC8ZwWYScIM/dt61YwcHZn5BBp09VOhH6VZ319n3wN4oFHvuPk93e
         Tjk69Lel1nJCpeZKv93cVfsg7GlhtLaxk0pngBGm9xP5Uv5cw0wvmeFQ6VkPmCylf2EQ
         x4/lBntbYVihvrwoXm0+gQttSSib23hUfFUTwM0p/gRwNVq+YAyT1iYDAto4r8IrgyEN
         lMwKJnimw6p7+XyN29E+U/56l1UlrC2Ub6xU5Z6770kWnEbNc/X9tstlzB3b7Pz1O+aX
         uOhyywRU8wRfFkPDBs/gGzImYN8F0uyZbYBC0A8vMjf+rgq/j6dfV7+moFnikT9iCmRr
         VKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093800; x=1731698600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdbg9gcnJczABHk4QBqJ5vtKlutkOJQgskA5FFfGzPs=;
        b=PocU41IXOaVtnxToyEcrUq/ehW36Z711EF8x3g54L+mdc2Sx9Mkm10HnpBCqzTjjv1
         +YlCuEfi/uBy8mx5Yba/ASjVss+G2GyzzLj0haTIwHcH+mqEF57PXa86Er15c1pC8TzZ
         GvcGiU9quJXYB4xzjREm3pUFQ52W5UIeu/6hKHkTqKOFJHTU0Tu7vhmlIrpLA1e4upkX
         Z3K17T1xiXumTF/M+V5PT8ZsOHo6CTIKiB/vSPUsblrLKteWEb+QwWw/1ZktZO22I3aC
         2SbxbYfVfw8OQ/C0dJJL7AyXBw+7et22oRCgs5Px8yXiUp1BKI+X/2a0wMVS9qB/G2Mb
         qNXg==
X-Forwarded-Encrypted: i=1; AJvYcCWPLJMadIuRHpQWe7zVmLZDGXX840PsEK/RoBnnm5euJ9AqhWz9GsgrwtEkwp/EG4Zavvt45RCfUBhUEY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZYBt/bGapX0HXD1k7uOAk7ezxy1kyZK1kFy5lKAkDyqTzlZE
	FTh10br2iaA4F4QiA7PTQsL/+u+/zi5Kwc5Vvl90XLA99TpLZ3Q3ngDroI+EloY=
X-Google-Smtp-Source: AGHT+IHHCavtzY8pfAh/RcRCXOmyqb2XFAmbo9Hz9KNi5mbeZrG+URDGuMcMVIUYVOINSPHeUOHtLw==
X-Received: by 2002:a05:6a20:840d:b0:1db:dfc7:d86e with SMTP id adf61e73a8af0-1dc22b928ccmr4223392637.45.1731093800125;
        Fri, 08 Nov 2024 11:23:20 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ce2d0sm4140167b3a.89.2024.11.08.11.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:23:19 -0800 (PST)
Message-ID: <27db341c-253b-45b2-9b18-c75a2655fd75@kernel.dk>
Date: Fri, 8 Nov 2024 12:23:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] fs: add FOP_UNCACHED flag
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-8-axboe@kernel.dk>
 <Zy5YHDj-8DaSP8n2@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy5YHDj-8DaSP8n2@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 11:27 AM, Matthew Wilcox wrote:
> On Fri, Nov 08, 2024 at 10:43:30AM -0700, Jens Axboe wrote:
>> +	if (flags & RWF_UNCACHED) {
> 
> You introduce RWF_UNCACHED in the next patch, so this one's a bisection
> hazard.

Oops, I did reshuffle before sending. I'll sort that out.

-- 
Jens Axboe



Return-Path: <linux-kernel+bounces-551533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A693A56DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76892189473D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF4A221D82;
	Fri,  7 Mar 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vyKWQTtb"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925F1607A4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365153; cv=none; b=YGI4fjPaRQiBeb5IfWwVuNNP3JgnrAvJsnaULlbwSQjflJEHKdlnI+0GDoP6zvJSO4U97oZ9uFzvUu8WOas2Bx6YZldN23kQamvJeXtrUWJquc0w2hnzaFxGWRsX2+quBTdvNqtg3KDjH1uZ9dFPyQDrF6BuRdOQycuPZuGAp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365153; c=relaxed/simple;
	bh=xaiQsJdBQxlDeOtm+4O7NGV7vcMhAxgto+N2EHIhGcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVgpibp8BubHcbCAgvwUVUkZlcfHTxZtnknWFoiODgpzxdqT0q8HiqMpLB+bZmiqEGVwp0/BdpJgj5sNuvq25LytQ3DtGlrXcXYRX3MB/kE8d+MuF8r8wJO9lb0chgnDok7sRESedaczwvmWKR0Y4A4k2Hm/Wgh4IJaisKM0k9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vyKWQTtb; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85add1c48d9so52206139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741365151; x=1741969951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxZG4GvpT+foDYYOqA5R+bdl7vVryacA7OvSQ2kb2w8=;
        b=vyKWQTtbd+945VUGfTn6XAMQm/6HQ368a4Tj1GmAbPPrQIKUSy5VPauOL1P/JqKwsw
         wrvSvXpPDmCBEwpu4Ys8ioo84qayGxXnWaRuCF5Ji6ZjQ2IXZ6mPH9GghKDzjYIHP86q
         H3pS2bbupyf2c73WUD0nDRp1zhXEEEdHvTOpq3atvXSFxySqaFaVO10gcjAUZ1qzK3tN
         d7TugjBBhF6J57AItd5uIhbIonefOjvl2WHj2ZzAOo9vYy9eVeUxwuIV8mSqw5HFuS9h
         LkPvDd1C5I9bLkAmVqnlaaoYSubpeOegb8IQbRbHqVSPX0HC1aIZ4q7E52VidnLfK9yA
         WN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365151; x=1741969951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxZG4GvpT+foDYYOqA5R+bdl7vVryacA7OvSQ2kb2w8=;
        b=ewPTMJ6OcNRlZbFNQF0E0yb9FMJS/maOeatqESuTn8hG/m1G1kenOP5Bf/suY0LLnq
         CZ9JR/ZYda7vG3Tng4QWjXfINZdGUc8aYvRqJSp2CdwBNIyxwbwY0WIu4m/eFAXf7kE+
         jZ7qeQTwJh7N3P4Z9DjoTuUjtIYeYWKhCfTIFaORvVlIfNFqRl/1pPlhrb05aQKdRTuH
         LxrQNQda3r6x/T5+023/yqVAnqLrsNItQOCuIcjLqcHyfafJJKadclfU2ybpl8PIQz0j
         w75aRk3ORGgGfPrGxr8m1vTqfe43gPv5BSQU+NyVMOZR8izZsg1RKXZSv73TaTP2FL1M
         SwxA==
X-Forwarded-Encrypted: i=1; AJvYcCUwVeuUtxgqe3D97L5W33m9K13nK+W0aKOd4EE177vLbsohsbfDSBu0XAfs1N00bPITa7BJ2J0pBOFrpRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZqrX5OOXud0qyFx6Q6kQnXhwfY1jv5xfglPL3SYHHc4opomc
	bb/BkCkfogeiPxPUQLsLLgkXa3YDcK0gJMLjlEhVddo4l68hG0ul9OM30h76cng=
X-Gm-Gg: ASbGncu8qUfBPYrZ7puKBH6QZt7wMyO2nVRFMH0sbkpHoBHXkJJRWttcs6wBNu42oXL
	v5b4GOuvke0uou+4xmczHVf2Z6AUQVSPhyIX7KNT9EpjPwLN2/eIbhqD0LmFQNLSGAzvnjQkiiq
	TfE9BT2OiWC0d9HDOuhKre8XsBTV/nkHzJvbYW5TuEaS7RpQI4B7671ZGuwqZVrbaCpScHMSah8
	MxupC2pKgARV1tJ5f2RJiyPYV869SYJus7PG48AywNnUICo3NhD5wwv7SFob3kennpjNmILSA0U
	AKgxZsGOOtIJG9ObMtyY59hrv8YHi6PgqgQlHr6T
X-Google-Smtp-Source: AGHT+IHrkCLjuVHj+BJlje4EuU1N2OofbZGNyuXaZNfL0mggj9MLt+HfmyCGFOKlxxG5IOS/M2005w==
X-Received: by 2002:a05:6602:3a09:b0:855:cca0:ed2c with SMTP id ca18e2360f4ac-85b1d0d5b8dmr500795539f.10.1741365151234;
        Fri, 07 Mar 2025 08:32:31 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06a6a7sm995329173.134.2025.03.07.08.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:32:30 -0800 (PST)
Message-ID: <5a0ddd31-8df1-40d7-8104-30aa89a35286@kernel.dk>
Date: Fri, 7 Mar 2025 09:32:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: support filename refcount without atomics
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, audit@vger.kernel.org
References: <20250307161155.760949-1-mjguzik@gmail.com>
 <fa3bbf2c-8079-4bdf-b106-a0641069080b@kernel.dk>
 <CAGudoHGina_OHsbP_oz5UAtXKoKQqhv-tB6Ok63rRQHThPuy+Q@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGudoHGina_OHsbP_oz5UAtXKoKQqhv-tB6Ok63rRQHThPuy+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 9:25 AM, Mateusz Guzik wrote:
> On Fri, Mar 7, 2025 at 5:18?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> +static inline void makeatomicname(struct filename *name)
>>> +{
>>> +     VFS_BUG_ON(IS_ERR_OR_NULL(name));
>>> +     /*
>>> +      * The name can legitimately already be atomic if it was cached by audit.
>>> +      * If switching the refcount to atomic, we need not to know we are the
>>> +      * only non-atomic user.
>>> +      */
>>> +     VFS_BUG_ON(name->owner != current && !name->is_atomic);
>>> +     /*
>>> +      * Don't bother branching, this is a store to an already dirtied cacheline.
>>> +      */
>>> +     name->is_atomic = true;
>>> +}
>>
>> Should this not depend on audit being enabled? io_uring without audit is
>> fine.
>>
> 
> I thought about it, but then I got worried about transitions from
> disabled to enabled -- will they suddenly start looking here? Should
> this test for audit_enabled, audit_dummy_context() or something else?
> I did not want to bother analyzing this.

Let me take a look at it, the markings for when to switch atomic are not
accurate - it only really needs to happen for offload situations only,
and if audit is enabled and tracking. So I think we can great improve
upon this patch.

> I'll note though this would be an optimization on top of the current
> code, so I don't think it *blocks* the patch.

Let's not go with something half-done if we can get it right the first
time.

-- 
Jens Axboe


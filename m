Return-Path: <linux-kernel+bounces-430325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018149E2F54
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13492B2EF50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C215E209686;
	Tue,  3 Dec 2024 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rJ6q74F0"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD831FA179
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265718; cv=none; b=Q6/aSTCqERIJNog+31SRulS4OTFkHtN3Mh2BhqceTyQZYY5h/yuZwfg9O9ZeelHHqXXaC6NUJjskeTEej8xD+PFNyPMurxfW9y0jj/idUDp4Jm4ff+q3EsXfSTusxuaAlJOZ371j3RuAvsBxQmdydvZQ/6sOI7uHwenXkRhBjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265718; c=relaxed/simple;
	bh=B/liPQIb4IzDwgFk2HZsoN0QEq45CrAM90ifIAL3cls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRMNGqKTNNgB4BIxNMccjyiwhxf41eagB/gRvEsQEoWpkyUmatoyXMNrx3sUpDqHd3Om1Jp8dXvuMXkthl6t/BblqMxhQIaSdaINGkv73orjekdVRUzGE8y26cBkgFsnYAN22jk9k0aU5fXh+NSdq93fknANzPfLRzJQkIGVdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rJ6q74F0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7258bce5289so264744b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 14:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733265715; x=1733870515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYz4wZQ4ozLWoz6WcLIf1w2/FEfERq16Hm/9zLb1izY=;
        b=rJ6q74F0a1GtpeslnPcoTa6X1rlURgz9WJ410a5qU5btiNFQ1bI1tEkf381woZxx5t
         86HTGbkhIvWSxI2xGkaTBrQj/EtD5L4d6cWVv0Ugj9qqqQpMQJeQ1nNIzghXVXI70E5u
         4YvuMGk/oBvuFOEmqwBbP5Z5htteuX9fWOEW73pg6wnc0vm4FpuPP7iuFspTy19R2NAk
         KK/VqAN+1dGwLdxFeNlJWbT0i0/2yMuJbwPWV4l+98yC2Eb1okNNK5iNIeU0uaIbzo7p
         PG8M/fitP0f/NMYFeLy5ekX4jHlNVCOu5tVul6YgiSXLnDmToTDxcWBFABSf+L82AugO
         jjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265715; x=1733870515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYz4wZQ4ozLWoz6WcLIf1w2/FEfERq16Hm/9zLb1izY=;
        b=OVEAApV78EWoZ2PUZ2DM7R4zvnQnfM4QmSGTcl38+X17fhYSJO5tQiQV0IGYJkaZQI
         FY3SRrXNKNfe9VQGJug6knTH/tHLR4et6n80MOhJExzRqdYQWfmv3YELxRsXWFMxGo2+
         Q6tJVLHcfAVDpBb31xER4JLFRkiYN7yDfgx5tArYmZx4DnyOMWZnO6nflip+GMRZivn3
         +ItU244iQbhHEa2kVsDrxp60EEu2ugAKeEpbe++mF/u/gdpreqEROvT1FXEx/YtbZqFl
         My09bJwToqwJcXatiZVUdNGvnZKrpQArRb/Rt6UtNF+KHHc2ZE8wMUsqeJch7rFVDR0o
         PzqA==
X-Forwarded-Encrypted: i=1; AJvYcCWRerIKIaRaA5jFi+1zUB6Fs3zkGHcUC+MprKcicHbr+kQ1T3APhvPSbSlXD76ESLHJmQPVEt+5aC+Wcb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywefuc2XgRE0hcpmISbLLutPPpiM2974BmNQ9f/csN2vAt5TLIA
	jbMj4eC+gE77oU9AvdNrZIYhxdeAjEQcZ87259FyBXX8AQMHr0JnG13x1YtvH4Y=
X-Gm-Gg: ASbGncsmb0ItJQeEDbv9pagBv47FDPZ6R8dcuN70LeBjYuIyffx1KKvpVgBi6a1V8Lc
	6QJ3GQLPbbofTRutxihbJ/N8t+ApTFc5C1Ei7MqJOWKWR7pHs8mzJlkh4gUDj55Xg7Oc9+p027O
	Ii328oYWRat02m/FjLRk1h1aMK64OnQrxKDXYPndMRS+rHgAd5R8bXn44ztqinJuyr7+lxdf0f5
	HviXBs6AhR9uvUghKnoSuHU/3TOOFVupzJDroqDZxMXciAkr6HaMw==
X-Google-Smtp-Source: AGHT+IE8Dqnok8jV5g7L3OmAsLx6cL87LuT/Gjx6JQItfNyi0KdCrRDg1xS89T6jOLdCSXuSD9q10w==
X-Received: by 2002:a05:6a00:3a04:b0:724:5815:62c1 with SMTP id d2e1a72fcca58-72587f6c48emr3492918b3a.19.1733265714946;
        Tue, 03 Dec 2024 14:41:54 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:18a::47e? ([2620:10d:c090:600::1:fe53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417616ddsm11083162b3a.13.2024.12.03.14.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 14:41:54 -0800 (PST)
Message-ID: <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
Date: Tue, 3 Dec 2024 15:41:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 3:16 PM, Christoph Lameter (Ampere) wrote:
> On Tue, 3 Dec 2024, Jens Axboe wrote:
> 
>> I actually did consider using some form of temporal, as it's the only
>> other name I liked. But I do think cached_uncached becomes pretty
>> unwieldy. Which is why I just stuck with uncached. Yes I know it means
>> different things in different circles, but probably mostly an overlap
>> with deeper technical things like that. An honestly almost impossible to
>> avoid overlap these days, everything has been used already :-)
>>
>> IOW, I think uncached is probably still the most descriptive thing out
>> there, even if I'm certainly open to entertaining other names. Just not
>> anything yet that has really resonated with me.
> 
> How about calling this a "transitory" page? It means fleeting, not
> persistent and I think we have not used that term with a page/folio yet.

I also hit the thesaurus ;-)

I'm honestly not too worried about the internal name, as developers can
figure that out. It's more about presenting an external name that sys
developers will not need a lot of explaining to know what it's about.
And something that isn't too long. BRIEFLY_CACHED? TRANSIENT_CACHE?

Dunno, I keep going back to uncached as it's pretty easy to grok!

-- 
Jens Axboe



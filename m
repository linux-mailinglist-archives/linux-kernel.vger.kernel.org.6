Return-Path: <linux-kernel+bounces-402323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D599C2660
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B866C1C21447
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628CA1C1F0B;
	Fri,  8 Nov 2024 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AO+UuGmH"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1D192D66
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097124; cv=none; b=cb+SkFeAO9ZqIG4TP0ZNPjDSxjCL622SkjtS4Hcv4j7c20tlENfwRh9XTKqI+L9ggEZlTEbN+Wj9xMnUVsPJD4ycQu1FNnemXicguObH+A5nAnRbeOJ33RZK88NnD18hIVtgww4kEfq8Yj1pfnPbgj0WoPEZwOqvAA4jH0xIpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097124; c=relaxed/simple;
	bh=Gl6J4i8m7k23jpRJx5ocIZWz4UUaLEBXFJm1vMKFu+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dc8huXUbkuOg2CUVcT2fcNWH86fEQ/yVKLMJkhYFPPlJ+n2Nps+6Ue+NVo4PPo1TZW8DMyROaUEisEaytekLlJFv1JXpjrqM1nnYKrcpSZuzBhN8VfJdvgjldJ3yu6Xxrxfm8+1GcJ/yqWpjcHE+Px5NnJnnoq8cRy0FReFYhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AO+UuGmH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so2111653b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731097121; x=1731701921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ButruIjsp+N12e25KkiSE9SJF/4i/qG/vJeDN9gjSEQ=;
        b=AO+UuGmHCTCI22l7xpB6UTTSD2HSRdj91zu64h8SZoZYb9PdAVwviJq0ljeUQujz3/
         hZpykRjBMgAsA/we0j/E/qn+J3Y4+NH/qiJpAKQ7t9ckJY7jbB7ZXB9eMWwuRc4j5Fws
         QqdZG6RdGMpCWMzd53GlPh8ho8nXVUkS3GNBWvZofcenhAeYjZJGkcf5lnmOCxXED20x
         XNI//AgEjg2A8yYl3ai8aLKq30cSFhbsM4WW82FN9PdBs0hzpT/Ix0IZNPEwL39VT2ov
         HebjP+mmnp90lBTtfQ49LfVThDg6VrxJlNpWy2pkqXUfvAFov1xTpSJQ8BnGc21hvnKA
         4BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731097121; x=1731701921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ButruIjsp+N12e25KkiSE9SJF/4i/qG/vJeDN9gjSEQ=;
        b=YfqNFwTYjbTD09hPuJ2ohLCS0eKsQRTu2Zs2rB7KpZFGBoVSQDgKTB7fZP4KhmeW5i
         fyul/4a0PvS3KCGGvXsvW8P8s5ZnmZJIRMaNeeEG7Kjc+FqnzR1ZE9Eqr0Fkz2U4J/9R
         4QyyAc6+gbKdq+rUrTY0NjqIRvPiQny+5m4MvU3uCDmBZXhMkMIWUl68VpD3IeMHwICZ
         8WcSCvPopmDv2dw9+eGTIIfL+8w10iHUBfKEjZgTCN5UKqtK/0LN6DVDXtRobrnmRN3q
         k2/64tfoU+pMykWd2eLBSgQxkJC8vznR67DG7Ps1uU4SvQZP00bJAK20nREHHCeNxyX6
         AoKA==
X-Forwarded-Encrypted: i=1; AJvYcCWccDaSxlhfdl0XE1vlqy8l37zz4eMfAGXI1gt/D7G9fDN/swCFws1px6NVa6/eJEnIgGDwkCRb2iix16w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydp6RPCUpD8NT6+TE3mN4LxasZ6duEYq4iEs6kR7s+c/evuSka
	CYMwxo4FXmE/lIbhFo5kXxz3WscASRdWlv657BI0siTRbbF17mtiBFr4/Sjdu0E=
X-Google-Smtp-Source: AGHT+IFLmWi9D/02ZHOGsiKNUZIejllZA3TE1dM/x2+sf2uL7j+2l7Scl+cOm+alMwnqVVLvVvizEQ==
X-Received: by 2002:a05:6a21:32a1:b0:1db:f087:5b1d with SMTP id adf61e73a8af0-1dc22b94a7cmr5051588637.37.1731097121568;
        Fri, 08 Nov 2024 12:18:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52d4csm4023444a91.7.2024.11.08.12.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 12:18:41 -0800 (PST)
Message-ID: <00b97317-610a-4ae3-8d97-f5871972a401@kernel.dk>
Date: Fri, 8 Nov 2024 13:18:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] iomap: make buffered writes work with RWF_UNCACHED
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-12-axboe@kernel.dk>
 <Zy5cmQyCE8AgjPbQ@casper.infradead.org>
 <45ac1a3c-7198-4f5b-b6e3-c980c425f944@kernel.dk>
 <30f5066a-0d3a-425f-a336-16a2af330473@kernel.dk>
 <Zy5vi-L6Vsn-seRZ@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy5vi-L6Vsn-seRZ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 1:07 PM, Matthew Wilcox wrote:
> On Fri, Nov 08, 2024 at 12:49:58PM -0700, Jens Axboe wrote:
>> On 11/8/24 12:26 PM, Jens Axboe wrote:
>>> On 11/8/24 11:46 AM, Matthew Wilcox wrote:
>>>> On Fri, Nov 08, 2024 at 10:43:34AM -0700, Jens Axboe wrote:
>>>>> +++ b/fs/iomap/buffered-io.c
>>>>> @@ -959,6 +959,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>>>>>  		}
>>>>>  		if (iter->iomap.flags & IOMAP_F_STALE)
>>>>>  			break;
>>>>> +		if (iter->flags & IOMAP_UNCACHED)
>>>>> +			folio_set_uncached(folio);
>>>>
>>>> This seems like it'd convert an existing page cache folio into being
>>>> uncached?  Is this just leftover from a previous version or is that a
>>>> design decision you made?
>>>
>>> I'll see if we can improve that. Currently both the read and write side
>>> do drop whatever it touches. We could feasibly just have it drop
>>> newly instantiated pages - iow, uncached just won't create new persistent
>>> folios, but it'll happily use the ones that are there already.
>>
>> Well that was nonsense on the read side, it deliberately only prunes
>> entries that has uncached set. For the write side, this is a bit
>> trickier. We'd essentially need to know if the folio populated by
>> write_begin was found in the page cache, or create from new. Any way we
>> can do that? One way is to change ->write_begin() so it takes a kiocb
>> rather than a file, but that's an amount of churn I'd rather avoid!
>> Maybe there's a way I'm just not seeing?
> 
> Umm.  We can solve it for iomap with a new FGP_UNCACHED flag and
> checking IOMAP_UNCACHED in iomap_get_folio().  Not sure how we solve it
> for other filesystems though.  Any filesystem which uses FGP_NOWAIT has
> _a_ solution, but eg btrfs will need to plumb through a third boolean
> flag (or, more efficiently, just start passing FGP flags to
> prepare_one_folio()).

Yeah that's true, forgot we already have the IOMAP_UNCACHED flag there
and it's available in creation. Thanks, I'll start with that.

-- 
Jens Axboe


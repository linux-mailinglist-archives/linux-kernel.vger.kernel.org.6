Return-Path: <linux-kernel+bounces-409776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9701D9C9146
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401D81F23AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6653A18D647;
	Thu, 14 Nov 2024 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kz6DF3tG"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F451C683
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607307; cv=none; b=eKWoG9lDdWyq57UVkEz3USF/hcbOXvXNhU3eV3s3EZ0P7hiBJHXKd2Vmn2LES1FYG385wZT+AL+95NnXovOyQ//BoQ+VQVMvZ89EL1AGOnUi8X0pCJ0xj6a806OK6+AbAaBSlQVKllqzBRzX1llgCAlv95nMEKJnf66URVlTPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607307; c=relaxed/simple;
	bh=0v6QBOMoLylFix3ycLeSicUSCz0baDoUPdKck7c6QbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZU4NiM4anmzXsu2CnUwI3WXqMTICijlxj5NjqV6Eb81I6ngDR1VZ296ptNy5BfiZUUiyLw9aLKt81CIjhXv5Zx82qXxRnzGX6LHXByuXl9jElD0r2rIoaYUtHDFHcMx2ZE9iq7XjcYqxhYg4dMkSi963aAKRNN7KW8sWd/hEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kz6DF3tG; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288b392b8daso524909fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731607304; x=1732212104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQa0McRJ6ktHn9JWaay5cO4vE1zjTG1spgas33tTGRY=;
        b=Kz6DF3tGNy7oQ3edwLAIQJnXhXCzo0TOvNAY4G4isB/TNEzg5YIUTJUs/rya08za+A
         hGkihggRLZ2VdsU1isSytQp0YuLy3QZIlVevQiqvvar0rThQ9khsxCQQrPuv393gRrQw
         ME2NjuFZoS/2hl9G83Hvg9NptAXDWOXUhk3sFTJrnJH5ZaYNPBuPUpeGWSJtnE5SgqqS
         nb4KSHmFRlU/emBGE0GLgD3kUjF9vSVonrf5IOibQGh9IdzbWNW0dvQKsZ4/8+jPS1kp
         HNgODL9KsFZbSOs1PS1zgjSRoNH+wMocD3cJyRV4+okzgedDlKMLkIYqOX1eC2981nW8
         bUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731607304; x=1732212104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQa0McRJ6ktHn9JWaay5cO4vE1zjTG1spgas33tTGRY=;
        b=u3BoCFNKS9ILxAhfzxxJxhDunxFNzCVtNlEenIL2TVwBlFlnz6xe3p0fo6+omp+1z9
         8lCvRZ855ilrwHgFJahu+PVW6xLlChTvDIaDZ/GmlF7NwPX2TVGwBC4S85/lSSL/eGsE
         oePZNpBUX38R9q79G0s33OHD4EDt3hq2c8ARIVuggp3LQt4awo84EO3K/10p5ENA5Naz
         5OxWKrfzk7yL54JHOhlW15ZyYE0b2BnqF+yI4emp+QcO2DAHKnIF9i0sL+VVqzZt/TcF
         stxWmap/owmThYL1wqeh6nJn1d34EZ5sZSiS5jzAws67ILGuK34II5m8IsnIN1F2oybG
         oq9w==
X-Forwarded-Encrypted: i=1; AJvYcCVWuc797rsDcyLlderznYti7tVHjTYdj7O7LF36CW50zreM5dYMBPJPsFOE6DS6HuirHctZKHu47SJJ/bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1n1OTX6H7NB35YgIU6OJommSBc6XhjPomM1e9yCMAgYWCF2pR
	Nkzsl5RYJpiXSgKwPcUpnDmrqTnUKBFlaQUvACW17rAWOqufdMIcJVRLZewdE/U=
X-Google-Smtp-Source: AGHT+IFoKXcjI2CaRY/oLgtT/oix+5apDbtPkI9pzbUKznrd7KQao0Yve/QbD7+Q2w+5aA9I6DSzbg==
X-Received: by 2002:a05:6870:32d2:b0:270:1eca:e9fd with SMTP id 586e51a60fabf-296102a0557mr3342246fac.3.1731607303805;
        Thu, 14 Nov 2024 10:01:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29610b57149sm679918fac.44.2024.11.14.10.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:01:43 -0800 (PST)
Message-ID: <b977f98e-136b-486d-a52b-61c85708ced9@kernel.dk>
Date: Thu, 14 Nov 2024 11:01:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
To: Keith Busch <kbusch@kernel.org>, Bob Beckett <bob.beckett@collabora.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 kernel@collabora.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <ZzY6v4d71jliy78w@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzY6v4d71jliy78w@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 11:00 AM, Keith Busch wrote:
> On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> We initially put in a quick fix of limiting the queue depth to 1
>> as experimentation showed that it fixed data corruption on 64GB
>> steamdecks.
>>
>> After further experimentation, it appears that the corruption
>> is fixed by aligning the small dma pool segments to 512 bytes.
>> Testing via desync image verification shows that it now passes
>> thousands of verification loops, where previously
>> it never managed above 7.
>>
>> Currently it is not known why this fixes the corruption.
>> Perhaps it is doing something nasty like using an mmc page
>> as a cache for the prp lists (mmc min. page size is 512 bytes)
>> and not invalidating properly, so that the dma pool change to
>> treats segment list as a stack ends up giving a previous
>> segment in the same cached page.
>>
>> This fixes the previous queue depth limitation as it fixes
>> the corruption without incurring a 37% tested performance
>> degredation.
>>
>> Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
> 
> I had this queued up for the nvme-6.12 pull request, which I'm about to
> send out, but I guess we should drop it until we conclude this
> discussion. With 6.12 likely to be released on Sunday, this better
> mitigation would need to target 6.13, then stable.

Since it's a long standing issue, it's not urgent it go into 6.12 in the
first place. So I'd concur with that assessment, even before this
discussion, it should just go into 6.13 and be marked for stable. It
needs that anyway.

-- 
Jens Axboe


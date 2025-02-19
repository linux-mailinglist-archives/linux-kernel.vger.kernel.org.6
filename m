Return-Path: <linux-kernel+bounces-522014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130FAA3C4E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B263189D64F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA3E1FE443;
	Wed, 19 Feb 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jDTON8jY"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F31F4620
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982187; cv=none; b=JTftgyhqEOC+PB34Oq5xNJzqbdwYaAUvisudj2NCDnm03Zkg1nOfJaTfPVWiloOGGOLMPYe02WiGx7A60T7jh0IOpBf4zeP2Lyj8cg75PdpFhGacu9/7IT7H3V91xNHoG54/cncPRpMKAntT7pR5Wj19Iq4YjwQaQVm96WIgA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982187; c=relaxed/simple;
	bh=NvID/kMg36Diao3OFuD2pJOuu3vylpBwx2YN0l8Evok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuUCLPayT4B0dFvKDHVlicLLnDdl3oE5WanCOAagm1S/zfFFVnE0eOxD/j/heT963hJwdVlJ31pFkfq0G13qS9cMFJvaKCmFiLvNuzQ78UGaQUzh7rpt7sSNR4ACvoM69Vip/oZ8yFisxG2GpXJRKF8gX4WI8FyO96eWE6MjUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jDTON8jY; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8559020a76aso91690639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739982183; x=1740586983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67TYMpkqxY5mExKnmZVTE77hxJr9qVBfzvrOMIP8NRY=;
        b=jDTON8jYgvmi1TsE5gCn12hB9s6ARl3WruyKmqI7gUlgX7GEVlGvbWZ0Gj2g6vji9w
         1x5zJnaWxxXiTaToNxoN97dFSXKQLDc3gLeqKUnW851aanfswQntEKsygwEVN7+it5An
         9zUbQfOR8spWXmgH0aIgQLU0xoFg47XqEDUauquqr1+dWgoygqnVy3BoZykcjEW4KllX
         Rc1DbRtWWPZmcs2mHb+Sx4FQw7kX7f0hwRhdLIL0gHgvk6vnHZPo7k0+uUBY+8WTc9KN
         GEMGi5zagKFa3479AFmda+tMeZQQulU2F8jMiXyXZhV0krSJq4BI0o/9VDpSxYDWzc1x
         U9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982183; x=1740586983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67TYMpkqxY5mExKnmZVTE77hxJr9qVBfzvrOMIP8NRY=;
        b=ac0LaBkuQM5eiyVnMhZAm6Z5SJrhcmSUf07ZSqyRnDF8o5jFxD2MSwSt1rnJSvC1JN
         D7Rdqo+ZdNI3eJkCUfr3lJtDzvudzJPV7vkxtlN538cxf+KM4TRgqjjmd8iVjGu8ebNP
         Ju9EKKNMmLun6qCUHRWxMV7w9fy61RykaoiYDDHxTNHeTNBL1y5ht+FwK9JqgDu9p5tg
         hBK9iqcxHictZemCuJxw3MiRBzZYnh4HIJvCWS8kJa57SVaZDiKkXetycSe0Va3ij2fG
         2ZCRbINlq/DlwcLUIn4rkDP61NdMcQrBF5PEoCdBCyfg5MHRgIi5BWNRQ0VS9vVSUIEN
         usrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq/UK+RFak46RDsiInFZEIW6uQ4yYWLGijJetXsoyLejlsfLB1cVzPbnchbBxgRK6TY23RSbHCAOQOK98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyswKYZqYmVfW5OT2Z7HekgwkXpCMTNKvzTR8VGvnN0RLWc9J33
	eAJfTBkvKRNepZ/gid8y3zAihpyN0qYumytAeYFe1r/3Lc+e2srClDUfxC272V0=
X-Gm-Gg: ASbGncuioDE4Od68h8nHFgIcr+cALkK9n4SryRLcNfhN4y8bJuWs1l7rLCGsqxXAcsa
	NZmyb2laMHpWlcRcLV8wOF43cfXF61Ce4j0Fl5WWFX6hjiaO4OYLsVlo5qqWqHcSkUBrnl/5sTr
	JIaLbshBwuIOzNv7H1xS7XyHYo9rN1G6EA3yOBwYtRMcggbk+S95mlqxW3v2tJU5UxRgq3f9u0G
	s20eKgYSl8ktLNDQVkUQszl8D5pB7yAsxstvsYPLBgXItOXzdFJRPYZV5+HDuzOwLlPt7UzLRSm
	+93zAVGoIGI=
X-Google-Smtp-Source: AGHT+IGsP9WAlYtkUYVoWjhz3+vnzS72BFbKRaFhdh7G4oojUtLjlV/F9FheozGc1GxCuDhK7ilFlw==
X-Received: by 2002:a05:6e02:1d85:b0:3d1:a75e:65dd with SMTP id e9e14a558f8ab-3d2807905e3mr162742745ab.10.1739982183443;
        Wed, 19 Feb 2025 08:23:03 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee8809c5d1sm2144921173.38.2025.02.19.08.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:23:02 -0800 (PST)
Message-ID: <65e5ddcd-642b-4671-b814-d4a66b2039d3@kernel.dk>
Date: Wed, 19 Feb 2025 09:23:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/truncate: don't skip dirty page in
 folio_unmap_invalidate()
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, brauner@kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
 <20250218120209.88093-3-jefflexu@linux.alibaba.com>
 <cedbmhuivcr2imkzuqebrrihdkfsmgqmplqqn7s2fusk3v4ezq@7jbz26dds76d>
 <b2248d8c-1f80-4806-80fb-cbc40ad713e6@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b2248d8c-1f80-4806-80fb-cbc40ad713e6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 6:23 PM, Jingbo Xu wrote:
> 
> 
> On 2/18/25 8:32 PM, Kirill A. Shutemov wrote:
>> On Tue, Feb 18, 2025 at 08:02:09PM +0800, Jingbo Xu wrote:
>>> ... otherwise this is a behavior change for the previous callers of
>>> invalidate_complete_folio2(), e.g. the page invalidation routine.
>>
>> Hm. Shouldn't the check be moved to caller of the helper in mm/filemap.c?
>>
>> Otherwise we would drop pages without writing them back. And lose user's
>> data.
>>
> 
> IMHO this check is not needed as the following folio_launder() called
> inside folio_unmap_invalidate() will write back the dirty page.
> 
> Hi Jens,
> 
> What do you think about it?

Yep agree on that.

-- 
Jens Axboe



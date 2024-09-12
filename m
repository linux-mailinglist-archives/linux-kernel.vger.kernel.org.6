Return-Path: <linux-kernel+bounces-327318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109E3977422
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7E7286568
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4901C2458;
	Thu, 12 Sep 2024 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZNch9qJu"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968A29CF4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179162; cv=none; b=JAEXadriIJ7P6SduRwYU8zJirAlAyvx8YRZDMnMojaXU+jzCInZ72Miw3CCWIVWMH+Kk1hNbq8hKG3H49kO/8Uc7Hay3Ppm6s7M0ryrvMtrEYxTRQCg4jspc2Omn7QM8fYY6MOv1yv328/Trz9nStyTDPPtCWu2q035nX08/wSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179162; c=relaxed/simple;
	bh=UlYy7Hlbdt+rczKfYZZW2LIR+Y5Cgkp3NmyR7eArPLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0A4YQOrwXCA4hzdGuq+pnSDptVmf5+PnZl81keYpP7tPKsgM7WrIrODOiNkL/wvWX6o+2eLQdPnLJ+lu3/HUDT5zAYq4M63BpNbXDmDQoTIXlnnfPGIHtudjnJTWI9Ikf2SNpA0Rm/vITcIu8PtKriZIZ1vb9lKqqCt8Kv7o+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZNch9qJu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-205909afad3so16844385ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726179159; x=1726783959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XHoL0ZBi9GE7Zl5WoiwZ5w6Gz6wVLeamEWBzoE27iE=;
        b=ZNch9qJumqv92QI8ZUAkl/0w69TYW8NdOpM66ZLbwHUqtU5657xSWUIsgIoBdc2sgj
         j/t3yvECkQDqscjnevuytcT/kSUrKPU+IZL5Rjwu3vbO7GXtWEXgkfFH6CVn4ZA/igOT
         Hradv1CtkfX1tIjayTBIZ1bjBx3zMXbXLKffYXnH/aZ/HsHLPp9tRvhbuT5z7oxdWKaI
         SXe8h3UmRqhcROd45KVKaVthcqc286AQPSTl7lnSsC0tvRxsnyebL09iys6tgNKMZzbr
         L/8np1YmHF8elGMcL+JryHQJyYGbOPF9+luUljsSFdXvb9mpeJuOEWrolAKYVADmv5ht
         RFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726179159; x=1726783959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XHoL0ZBi9GE7Zl5WoiwZ5w6Gz6wVLeamEWBzoE27iE=;
        b=HLwIcEf24Ee8kkiS84SCEafxqt+wmDBNFUgjOmPJbA59zyXetb2HdpwoenM0vX+Ruo
         CnX3tNG7mayAv5q+89WozCwrDtO4W9Dyo7dNX1ixZIYfrzXJWvCmXy5GzZShDtFlaJMR
         Ybn7KMRr3HhDVKVvqtIvg3hzkPtAPE2FOwz2AvpLeMT24uwmZhyLB8ymBfNAkDqlbgxu
         Es0YCud1JKbtPLAMxxT9KJR8bDbrL0pD/HykdjbczpcepaxzcwxTlk1jg5IeKiyW4qHW
         x+MKWcGC0ph0KdhUT5brA/H7IoUhRj3XbmoIyhpz/vWznV8zt4XuBfQUz3m331hA4jEM
         Ti2A==
X-Forwarded-Encrypted: i=1; AJvYcCWUr4XHhhOROPiCjcRPzqs3fyJnRBKwFhFMSGl04sdSOroWcyXDApsxNOalLeDKGHtFMlFOL1Qy8Ulr0rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiuwmeFb9zPWjF8gyKyaFzvtYC9ysJl988tDp3OIB8NQG3MAT
	BqO/koInLE5AdmpFL4cehzSbMVKXl/8k2mdAGCevKMBTQjZnjoRnfQGyb7UXxxI=
X-Google-Smtp-Source: AGHT+IFpTCq6+ukL7H58M1PsiI9W1iyXsSunsAA643ZhHhX6ctp4jDxCLQSXqpQypnPnbrvP1So3dQ==
X-Received: by 2002:a17:90b:4a4a:b0:2da:7536:2b8c with SMTP id 98e67ed59e1d1-2dba0082fecmr5160596a91.36.1726179158919;
        Thu, 12 Sep 2024 15:12:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9ced741sm211330a91.39.2024.09.12.15.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 15:12:38 -0700 (PDT)
Message-ID: <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
Date: Thu, 12 Sep 2024 16:12:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>,
 Christian Theune <ct@flyingcircus.io>
Cc: linux-mm@kvack.org, "linux-xfs@vger.kernel.org"
 <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 Daniel Dao <dqminh@cloudflare.com>, Dave Chinner <david@fromorbit.com>,
 clm@meta.com, regressions@lists.linux.dev, regressions@leemhuis.info
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZuNjNNmrDPVsVK03@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/24 3:55 PM, Matthew Wilcox wrote:
> On Thu, Sep 12, 2024 at 11:18:34PM +0200, Christian Theune wrote:
>> This bug is very hard to reproduce but has been known to exist as a
>> ?fluke? for a while already. I have invested a number of days trying
>> to come up with workloads to trigger it quicker than that stochastic
>> ?once every few weeks in a fleet of 1.5k machines", but it eludes
>> me so far. I know that this also affects Facebook/Meta as well as
>> Cloudflare who are both running newer kernels (at least 6.1, 6.6,
>> and 6.9) with the above mentioned patch reverted. I?m from a much
>> smaller company and seeing that those guys are running with this patch
>> reverted (that now makes their kernel basically an untested/unsupported
>> deviation from the mainline) smells like desparation. I?m with a
>> much smaller team and company and I?m wondering why this isn?t
>> tackled more urgently from more hands to make it shallow (hopefully).
> 
> This passive-aggressive nonsense is deeply aggravating.  I've known
> about this bug for much longer, but like you I am utterly unable to
> reproduce it.  I've spent months looking for the bug, and I cannot.

What passive aggressiveness?! There's a data corruption bug where we
know what causes it, yet we continue to ship it. That's aggravating.

People are aware of the bug, and since there's no good reproducer, it's
hard to fix. That part is fine and understandable. What seems amiss here
is the fact that large folio support for xfs hasn't just been reverted
until the issue is understood and resolved.

When I saw Christian's report, I seemed to recall that we ran into this
at Meta too. And we did, and hence have been reverting it since our 5.19
release (and hence 6.4, 6.9, and 6.11 next). We should not be shipping
things that are known broken.

-- 
Jens Axboe


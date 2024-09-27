Return-Path: <linux-kernel+bounces-341607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C08988257
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5639B223B3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F66A1BC08A;
	Fri, 27 Sep 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iDxbQId/"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85634482E9
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432444; cv=none; b=da9v7wBh6HFbVDgnTDcIrHfp6pohpFt6BCC5dQKHJJEx5NDhoaJsgN6+Mc0KJFmHeKwIBiYSQ+YIZFfWfTDbmoU8k1KDsJJnDRTcrtnDNMDqCTEEpRrLRNTWzR1H/WLuApJ8xrj6G4ec4rCqiAp850OrwrVtRmAiI6eBDdcVDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432444; c=relaxed/simple;
	bh=QaIf2OHv2FCRI4jD+DjQDMIScp5cQp7VGmtV8rFkH58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcetVDpKHy/1gNEbCYiuCLTOlnHs2Zu22wh+i7b4LmRoSmclefBY6eRCoUw4zAoHoN+0G2j7IHc+jfWx/vMNd0fMgzx2AldES6u+MxKpxdwm/Bdx+OSe9mLTZ+JbOO+CAltTVu4rdWQv4vzVLPQ2WR8x7dkPiet1JOAoHa/tgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iDxbQId/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b0b5cdb57so17875495ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727432443; x=1728037243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=245SVimhBY/4RdQSCjSigvJmIT0nvIptUInN7qYYUCY=;
        b=iDxbQId/AJ7K2XZAnnGWEmh/zWTVtirkXE4K7vIxfofv2BDddI5Fyvbz2msrokVQHD
         OiLpG1hQg3vYQqTxZRaqqCw31tYRFOx+pSHp4Rb9UlHqvF3OM5KJX6AEOo1qBt2mbkfk
         NMc68slmUIM6VNWEA6Hov5ia8yqgFKCFCTu3VLRHJTH61/L+qSKybNirNr/98y7DPZMk
         ydHWcBr2Mnx/euOCG8OEsr0YcmIY1wNbLoaGAomQLiOIdXQ5rVew3SYZackx3vSv+s1D
         no6nt8KIZbAL7ONdVwOEOwdhDEJtXaADueZ4K10RF6dU88Rp+BDl3K2XFX3UoIjZE/zM
         Heeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727432443; x=1728037243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=245SVimhBY/4RdQSCjSigvJmIT0nvIptUInN7qYYUCY=;
        b=PA8LWAGwVAmEOtA1u+iqpXp+gbp87L4ucgAnJYBu4+CkUu3S/dWtpNCbWSXdTW+3vX
         ojXUxInw5Ku4IFQOOzKCtBKD27sRfZaCrT13PA5y7gruXcdUisoDfyMmlaIDhO6DTcD3
         2nZiZL6pL2kJWmPjXnphoxUShH7W1baRbfF+JLZBC59HeonNFRXI90X7Mu4IGKmfhK6y
         PgqjB8rk5suR26blp/LHNs7vdSpPPYoz1cdtBwvRqaRlWyrDgO5U5fQceeHJypWBU+bk
         7wI5I0bVyxV2LJ+R6/022DOJBiFREo/pjgS1OyaE2v7gVx0Xfv9b5ukW84PXBjdXIw06
         +FJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXemw0LJpBlV6VWeI5VkmTu5nJuRCzv4m1Tlv8GSNO4kPm0VZ/8Vfzba/mRppJ1e/X7+9gRFobzAEU+nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI84U52CyZhOgzzuFrhDt9nMYh1tT0oSu1Jig4gpH6rbLPrsMF
	1zJJnAqWbZsplvhwPx0dCkplnt3tPudNkXKWJmpWaAiztfGrNy/itE2qab30+kI=
X-Google-Smtp-Source: AGHT+IEOqhLE3FfQM6EpVLEy18nRkxkIw6K1dANGP4m8yefVDBP4oiz4KzxnNxA3v+lPafHKUwCH1A==
X-Received: by 2002:a17:903:228f:b0:206:b5b8:25dd with SMTP id d9443c01a7336-20b3668c278mr43293325ad.23.1727432442859;
        Fri, 27 Sep 2024 03:20:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d5c4sm11051305ad.157.2024.09.27.03.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 03:20:41 -0700 (PDT)
Message-ID: <e6971851-477c-41c1-b0fe-1d813f8b9319@kernel.dk>
Date: Fri, 27 Sep 2024 04:20:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Keith Busch <kbusch@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240916183622.105641d8@canb.auug.org.au>
 <20240927134337.021b1ec2@canb.auug.org.au>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240927134337.021b1ec2@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/24 9:43 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 16 Sep 2024 18:36:22 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the block tree, today's linux-next build (htmldocs)
>> produced these warnings:
>>
>> block/blk-integrity.c:69: warning: Function parameter or struct member 'rq' not described in 'blk_rq_map_integrity_sg'
>> block/blk-integrity.c:69: warning: Excess function parameter 'q' description in 'blk_rq_map_integrity_sg'
>> block/blk-integrity.c:69: warning: Excess function parameter 'bio' description in 'blk_rq_map_integrity_sg'
>>
>> Introduced by commit
>>
>>   76c313f658d2 ("blk-integrity: improved sg segment mapping")
> 
> I am still seeing those warnings.

Due to travel, didn't get it queued up before just now.

-- 
Jens Axboe



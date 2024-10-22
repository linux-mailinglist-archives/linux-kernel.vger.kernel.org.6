Return-Path: <linux-kernel+bounces-375316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF49A94A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27815B223F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4EDDC5;
	Tue, 22 Oct 2024 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqX0/edn"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13C4A18
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556370; cv=none; b=qsvh8eLybrVk83fuioEyrLTEczwRkmXw2UPhW4UHz1y4iaYvII7sb7DHGXStSfyFVPppePe7tLFWwM9DMzhvhAZ8U/ur/wFBDHSf5437L5m3BikbCVJRl49a4fOrGWgqYWcFxJ7DBVZWk0BLQLDJhHdtg51hrX8JDzMKPuZrARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556370; c=relaxed/simple;
	bh=SoVuOE6rW8yVtT/CmcaGAvYOfAukDqA0XOMOkBmpE1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=pcGgH/6B1rqRD9HvW4h3GunQ2VFoODz+dWAyoIS5bg2V4TKl8wPIXnBzwIdQCcmhtn3VMKVveXeU46sO8gJzKJEpTVX4lT9oO+Y0eVOlyjERpS1T3gioygrvq9d9zqr6+MgejzCQCjsjT/PRI0THFkzjYQFQNN/we5UVXPC+GvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqX0/edn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99fa009adcso279149966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729556365; x=1730161165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3L++Tq78Z4wLx8KKrPfxsW5qjVZVQchtRSIeHcPRpVo=;
        b=FqX0/ednc772fZva/EDdhz4IItdpMwgGft0K2IyPR1eYNEkacIuRJiZuQOvjE2F6ce
         3QRL1W/At+sFHmBeSkiBSvhCwKhRKfDuXdXNzqCcQm6jkBpr+mgrxcNRCoTVotfjM3V0
         5L26EDuZHTJ7G5xbM/+9yR2k/XY1uH2lhAizMqDVYQW7v8QeFpBiJb9lli1ThQOBKR7l
         J3udu5dwV4OTYygdGXew7oi1lVjmWmKrOa75m5GkLhFRUIiT5r00P02P65jgkLMfX6et
         /oI4yqNjthsgEpTYiRsIAVmugLj+YrgHKaqBmqs3T2tfNnV8qF0ntuf/TEf51CsWmbds
         /1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729556365; x=1730161165;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3L++Tq78Z4wLx8KKrPfxsW5qjVZVQchtRSIeHcPRpVo=;
        b=ixkYmHw9puOIgHVGbIUer9rBGb02NYu1LJ56mx7AF5BZiZ/dUmZJffi0AmA5/y3T98
         7vpYHEdm9CGOAmxx4U1xkBM5xYNJuWpAfnq0QNr24lCWMDjtK/GN2u1eVlTECQoJRm6T
         uaxPAiofrC0y+B+BcCT90CIoXl+TZOZlGjOezu0n7KeXqwSU1mUJAuzGaQuoO83R3spB
         iw1G+7M6nnaoYL3qy81cFKJNsTPBmL6v8pLGUzU1vV336h0GRezHGEtnrldoVbA3nCXQ
         2rI56k+ZR3VH0UzF6pDPLegyy/qW5E2w6iXy95g2di3L5LFz8o4fZdCyXmeNkCL/SmD3
         b2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUrwNt4BTBbs01BIXlaIKFF05ldalnOTapbaduCFGNHuepXcDm5hjMAbO4K//c95V2hAv/dZHx4tDzjUfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKnL/ormHgX9/FDP93K38ioXNaI4/uES+PpE42ZYoXLlWoLdva
	gJxiqa4qH2UJs3PoYpyNtbgf2eSWyj3OlWpZ3QjxgdTLRmeH98KN
X-Google-Smtp-Source: AGHT+IFj7pq/yq+jiJswm+jO2v52hlglkuHibUJxDLd94JRztGQT8Nkez5SDkhfGonYAsyvidyx6rw==
X-Received: by 2002:a05:6402:210e:b0:5ca:1598:15ad with SMTP id 4fb4d7f45d1cf-5ca1598179cmr9519877a12.3.1729556365331;
        Mon, 21 Oct 2024 17:19:25 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5400:7400:ff60:75e8:cc8e:6028? ([2a01:e11:5400:7400:ff60:75e8:cc8e:6028])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b556sm2479577a12.63.2024.10.21.17.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 17:19:24 -0700 (PDT)
Message-ID: <2ae7d2b0-0053-4cff-9352-d180c243ded4@gmail.com>
Date: Tue, 22 Oct 2024 02:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [udf?] general protection fault in udf_read_folio
To: jan Kara <jack@suse.com>
References: <6716ebf5.050a0220.10f4f4.00db.GAE@google.com>
From: Gianfranco Trad <gianf.trad@gmail.com>
Content-Language: en-US, it
Cc: syzbot <syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <6716ebf5.050a0220.10f4f4.00db.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/24 02:04, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com
> Tested-by: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12684640580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
> dashboard link: https://syzkaller.appspot.com/bug?extid=ddf8715339c89280b6fc
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

Hi Jan,

syzbot reported a null-ptr-deref in udf_read_folio a month ago [1].

This bug was marked as still open on syzbot, so I retested the 
reproducer (no patch applied) to check if the bug was still valid 
upstream, seems not (as reported up).
Wondering if syzbot will now try to find another reproducer, since after 
this check the reproducer was crossed away on the syzbot web UI, or if 
the bug can be considered closed.
I hope this might help.

[1] https://syzkaller.appspot.com/bug?extid=ddf8715339c89280b6fc

Thanks for your time,

--Gian


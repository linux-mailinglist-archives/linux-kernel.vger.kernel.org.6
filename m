Return-Path: <linux-kernel+bounces-552079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00668A57545
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC443B118A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FD258CD7;
	Fri,  7 Mar 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="e7cuHqKk"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BED2580CE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387909; cv=none; b=ZBmSUP2zJLTeK1bBdBMvKvkZUaPFw8+QH6R0xBWw/BUR7VWniOR/GElxHjwenPKoIgM9I5jpnGEQ4c8tu7pHXyLV2buboAWcZacIGHPZuY5KLgiMPVkUkNke3G0gmQ5y1odvRMKQr0veGCY/8vXBUKQ1Ohlz/S9kYatEZ91r9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387909; c=relaxed/simple;
	bh=h+yH4nMqnONyPvR4b5+ysIpFa/g+49z4eyeWl8EfT1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bR2JDpJs+ee/u4vOOjxKtiUra2UHcIMBwO9fT4Q9W3UXYtiRHNmHHS9myQnIptRb0IL1l++XVyRaDk+0DfBFOAikCRdhSck+1+0q+KiyQv0cGGrclQA4qVykR2Ww6BP1dZe+pp3J2Lc3oLqsDqSEKKMx2lcww4cxVAV/xyD/na0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=e7cuHqKk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso3750941a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 14:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1741387902; x=1741992702; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJgB/M7aLDGShp5uE5Ckn92GHYjwSxnasPCMDhgEbVs=;
        b=e7cuHqKkbG3Gtz2KK7meopf5VHHY1flytAH/7eduNHVfgD7eG7k61KTbdSY9SjdciK
         YX2lSsVHIsPluSLGDjTlFS8X7LGEgZSK3Tb47aZJwv7BQFLwR0GRKkjFwkOsqcoH7NYO
         ijETuTF0Ku7kNhDBOwEAHY+nmTn+H+Rg+IeQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741387902; x=1741992702;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJgB/M7aLDGShp5uE5Ckn92GHYjwSxnasPCMDhgEbVs=;
        b=xNj1GUoPldQ6C308e6WF2aTe0loIg2mKvFOXVphFovbgGfigR7VwtEnN3Lr9R6dseb
         atEP4eBDv8cpdfajwDsx8hWKnMIPbVv5Asd1dxt8QIp0F8AoflqO7o2ZAOTotaIpmINh
         3/eme8b3SkEk9gfSUspGixpdxgDLqiIyg6AbiL9b9Z5zCg+qChhB+g34aucScpLV5d0N
         I8fPrrwlvp4QBYBUCmU/luiCk5mc/jrQYn3Gu5gZ/4Sg83CqUtMQgPUkNj29Szq6TTV4
         fhyK3yudRxkQDa+qczTl+CYaw3LW9uECvdcG/n4nfZhjuhuO2cVvpc7f+5RnXZEqPdUq
         YcgA==
X-Forwarded-Encrypted: i=1; AJvYcCUqj25mBVy2gjIs9WnlbKBpFtLj0hNMwSmZRamn74vu1i7O+Wiqe/n3Yp9IwMeVTRBWc0QmiiHE/H7fPH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeQUGLoiTtCWwtwWePxvZAX0kJCYoVbZTyR0H1zB+QnqilH5x
	ubAdjik6ZYkV6PnYy0ca8fiMhihzquDvo0XE+Hgja4kuv6pnPAAvtf8J3yOnOrg=
X-Gm-Gg: ASbGncsVNuivRU2GL9hdYsZ4afdP72FbaV3Wwx4tKCcmpWL9RW3rYhv2hdgMcwHfQn5
	EYqBcD6I1wARL/MZgAzL3j+u3Py3RogAPMTrUZjC9ukLsAlOQnG+/dGtSO+vNNMcMXvvJNbgKHe
	DZXqGv4fB3Uk5yOCWX3Hd8V5uqXxbemuTueKhospCe8TpLfeKNEU9rHbhYd+WMNVLOLXiYqZ2eb
	VPnP9AiosXWHPD4phvGOD242OPu1n2Y5Ya8K/OIn9VfCf/uStnWroWEwhpO0NGLry+1m0ocUO+w
	5jKFL5mFmWQrwfsL1mW3WX6PshZxJ6Ub4wZJiPW91C5L51AbXbOMQcz0KYWEoDofYTYZ0OuEQwo
	lQbE=
X-Google-Smtp-Source: AGHT+IEfRYJcajOnqEBzT6wuJUDmUfI4G47zNSYjcP9pqXZw2dbdllJoQnhD61zML8NDpVTavFbSWA==
X-Received: by 2002:a17:906:c03:b0:ac2:b73:db4b with SMTP id a640c23a62f3a-ac2525ba768mr585756866b.4.1741387902286;
        Fri, 07 Mar 2025 14:51:42 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac239482f0bsm334109966b.41.2025.03.07.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:51:41 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  David Howells
 <dhowells@redhat.com>,  Oleg Nesterov <oleg@redhat.com>,  Jan Kara
 <jack@suse.cz>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/pipe.c: merge if statements with identical conditions
In-Reply-To: <wkdxihiolxnzelu57llc7vealuofie3l42clbsn7tqjbvstxqp@a6d74rhrvcla>
	(Mateusz Guzik's message of "Fri, 7 Mar 2025 23:40:54 +0100")
References: <20250307222500.1117662-1-linux@rasmusvillemoes.dk>
	<wkdxihiolxnzelu57llc7vealuofie3l42clbsn7tqjbvstxqp@a6d74rhrvcla>
Date: Fri, 07 Mar 2025 23:51:41 +0100
Message-ID: <87frjo4fpe.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 07 2025, Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Fri, Mar 07, 2025 at 11:25:00PM +0100, Rasmus Villemoes wrote:
>> As 'head' is not updated after head+1 is assigned to pipe->head, the
>> condition being tested here is exactly the same as in the big if
>> statement just above. Merge the two bodies.
>> 
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  fs/pipe.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> 
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index 097400cce241..27385e3e5417 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -547,10 +547,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>>  
>>  			if (!iov_iter_count(from))
>>  				break;
>> -		}
>> -
>> -		if (!pipe_full(head, pipe->tail, pipe->max_usage))
>>  			continue;
>> +		}
>>  
>>  		/* Wait for buffer space to become available. */
>>  		if ((filp->f_flags & O_NONBLOCK) ||
>
> I already posted this :)
>

Ah, never mind then, also for that other patch I just sent. Just
stumbled on those while trying to proof-read the pipe code.

Rasmus


Return-Path: <linux-kernel+bounces-178436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCE88C4DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B521C2159B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A01CF8A;
	Tue, 14 May 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cD7fg2/W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA091BC5C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675161; cv=none; b=U1vgaK2HPJg4nV3C0HVWnYCDlmChTUsxvz133kqJGvhSFmDHac+NXOKMAFBH+k6eN0Dyn9lyZFL6JONLPagdmf4zuqcKmwifOij1FVkN4dZdlwP2QGd07r24L0y5Nu9O8MTi2h2yAHgmgkFYz/y5nQqLHqXtyGCAFj3J+a0id2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675161; c=relaxed/simple;
	bh=zWZkyNsaeMaxE3LFUOlJ0Vssp+gg9spAyWC67IWBUG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+rDNrdOXqXtB2lTE+Y4H/1hsBr6qZktZ8/blLKTmS6GBU8ovhzx7mjo1hJtjPKOFjdNWElP7iiLomhrAzwwO6QpnlJxkhFUt/O7AZvusp1kHJ2h2/madkFIp3lGwSdOPUJBynaWBeAn8SIKBS+2RumB6SAX9nXTP7z3nJCEyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cD7fg2/W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715675158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weDIElXIDxVDl4VH9KwpwXxc1zg9Efm1qvi3oedOWbk=;
	b=cD7fg2/WnieaVRo/J5T07U8P9RMS/ilrRVgowHhDpr3pcFyY/160H1CM7IzS6cHR/q6X9e
	fliPEtFy0QiA/GS2bOZZ2HAYPuXpeqUhabSjFfPIGM6Q1sTAzvqcFvi5BosA6VZpnVn8n/
	PxVETu2N80Yr6aiBKUUS8hxzH2J61Qk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-1GQKABkFM5So8G4YBCdD3A-1; Tue, 14 May 2024 04:25:47 -0400
X-MC-Unique: 1GQKABkFM5So8G4YBCdD3A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5a84e7c884so31038866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715675144; x=1716279944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weDIElXIDxVDl4VH9KwpwXxc1zg9Efm1qvi3oedOWbk=;
        b=sXadLDHVMM+viDh6uY5Io9ofD8CHx37lm5MyCXfg19yj91AeYvhAeiMAE4Gy9I1d0K
         Yl7EB9p//heC0tTYWZeuVIdZYGnBTHl1KJsfDBcNVQIW6FDNqnKN/dj7K7lZaBiZt7Wn
         7rv0Oa024KfmJQYgybZfsEr0YT75OSfPDjUlPFPO1W4jY/Y5DPW+E3q2FruHI4Rznrd0
         AKgPhE0+OsodFid1vBY9ANIHBSZ3/vdnl1RgtlkKct8UC1H5U4lqjyKzSafea3MqCOP/
         7Ur1zp5xIXiOp+U42V6kwvQXdCGeE05XNYV6xV4nBdRc+BsDh2l2F82YrNGWjibt6tNP
         FfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5q/LJGsQ2JDiIoLBuh1fIFQRdEyOvOzpcHZ7AjgiWjt1or3yqplnA/jPwXCW4CykbvmJ1SwPosRdJaBLbdGn7ndDwKEFDvw2QNTOM
X-Gm-Message-State: AOJu0Yz5qLmxtpw86++o3ArcgJ5Kmm0WLdrxGfqRSZPXuxiRA0qfxMxm
	p9x+8MlVSuYanNf7BZ/wtrDT0qjLl+HlUYZXL5bSXdmzv0XxZISpF1r4nJ77YDo8G1ljitv6C7r
	oCfdg6zNBRqjDEWWCzxiEYavAAn+P2FguWkummpYoHRaP3wo7c6zapFJnAoq/VQ==
X-Received: by 2002:a17:906:75a:b0:a5a:15f6:157f with SMTP id a640c23a62f3a-a5a2d54c7fdmr759212966b.14.1715675144599;
        Tue, 14 May 2024 01:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2gUrM/w0h+ePfMUInQXQDxRb4JOVlASDvj5Y2Wb6BLrO1PMd5Fafz38PbWQ0/6Mlr+6Y19A==
X-Received: by 2002:a17:906:75a:b0:a5a:15f6:157f with SMTP id a640c23a62f3a-a5a2d54c7fdmr759211066b.14.1715675144177;
        Tue, 14 May 2024 01:25:44 -0700 (PDT)
Received: from [192.168.0.222] (host-79-27-209-158.retail.telecomitalia.it. [79.27.209.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a69148b97sm238836466b.114.2024.05.14.01.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 01:25:43 -0700 (PDT)
Message-ID: <b98f705c-07ae-4b5d-bc55-2279a6340756@redhat.com>
Date: Tue, 14 May 2024 10:25:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Fix grammar and typos in comments
To: Phil Auld <pauld@redhat.com>,
 Paul Sherwood <paul.sherwood@codethink.co.uk>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
References: <20240511082644.44757-1-paul.sherwood@codethink.co.uk>
 <20240513135812.GA9998@lorien.usersys.redhat.com>
 <ef7021835015a5bdd5bf5404ee712853@codethink.co.uk>
 <20240513162519.GC9998@lorien.usersys.redhat.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240513162519.GC9998@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/24 18:25, Phil Auld wrote:
> On Mon, May 13, 2024 at 04:19:10PM +0100 Paul Sherwood wrote:
>> On 2024-05-13 14:58, Phil Auld wrote:
>>> On Sat, May 11, 2024 at 09:26:44AM +0100 Paul Sherwood wrote:
>>>> - conjugate verb to match subject of sentence
>>>> - s/a entity/an entity/g
>>>> - s/this misbehave/this misbehaviour/
>>>> - a few typos
>>>>
>>>   - not starting all the lines of a commit message with "-", priceless.
>>>
>>> Plus, you're just repeating what's in the actual patch.
>>>
>>> Otherwise, these changes themselves look good to me.
>>
>> Thanks for the feedback - would you like me to re-submit without the
>> bullet-points, or without the text entirely?
>>
> 
> Personally I'd rather a sentence or two saying something like
> "Fix some types and grammar issues in sched deadline comments."
> Or something.  I know that's basically same as the title, but
> that gets lost in the subject line, so maybe worded a little
> differently? For this it probably doesn't need much but does
> need something. 

Yeah, I would say that a short sentence, then the bullet points, looks
better.

-- Daniel



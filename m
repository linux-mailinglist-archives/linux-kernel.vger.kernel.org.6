Return-Path: <linux-kernel+bounces-202755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8588FD0BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E640B2F30A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F217BBF;
	Wed,  5 Jun 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgyRJmW/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CEBA37
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596469; cv=none; b=oDfhzWpUlPWKgPBqZ++ILCIrxnXCqVFLhaLJCeOliRlPGwackBXnG82yGjumPGtXQ50Q9v3HxKqED2DkPqxNm82BBdqFun5tk8D53N/b88pobP2uV6xvAaLj/oqu9m5BV2oeOCaIoICNpCubgxTh1NvNY5AE+085y8M+CSm2cb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596469; c=relaxed/simple;
	bh=G1kz/PRN23+QpsWh23o6YWf2s2yCUPcJwpFAPBnT3k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+H+Ll9KUYFeJOrbcYz8CshGE1VZKOVO1jgXWc6LaSPadf9qAdVxG+ysQF208MXppD5HioMwaDz1+Q+uAQloGGBf2OuWg23tDcJ42qRde0XOVd5XXigEZGNB8vCkxucvWEPau/60TeeYKxQtmloZco8k4Nby/5jsaTJRqdXh6JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgyRJmW/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717596466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEkSv/wkJy5gIacDcugoCBVPAdCY8hqPso/BOhBGtKA=;
	b=TgyRJmW/GOJUzZe0Ytwr+Z1/HF7/5eTmgDFAFrCj0+0UPqunviPvggLbRISQ4pMgucJ2V+
	qZxFJdHHltGal54qoatmHrVA6Ye1wHADM4Jf1uF5KlAjdabtaDZBk8mX0AzdmhzgNeG4yW
	leDpsOqA8Z/OKEl23FkyCOqo8VGKXGE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-_se0qxjSOD6d-cK_NIldVg-1; Wed, 05 Jun 2024 10:07:41 -0400
X-MC-Unique: _se0qxjSOD6d-cK_NIldVg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52b98d73cf9so2631915e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717596460; x=1718201260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEkSv/wkJy5gIacDcugoCBVPAdCY8hqPso/BOhBGtKA=;
        b=BUioj2UiEkQbbB1ThSnUOmHn5shO5V0BowUCIPSkx5rlI3PkEOwx6v3eQtG42cWG/B
         8Z2AggiHckVB26LPWjhtssqyth888dPdLV7+1Y55ID2e7Js2FVslgnHZiIKgi6equ456
         Hj2SZZ/zYq6UQAOuflMlX7YZywFFHmKHaO3bteo3k3oaDbEVEfi4a1fk2uFmP0i20JEg
         uVXGruFARiZfdycIptQdCv4GyLgHASZaEhBuwT8dBSOAtFkHt26xAZGQ1TnZYz+lLcbz
         CQSOU7KKF8hLmy/hhrIkR/r/3IqnxjcmFBECYpO2JtER1mxJkMEleZa0l4Qqlc3JqHQK
         fc2g==
X-Forwarded-Encrypted: i=1; AJvYcCV6Ak19PSYbHLpg3U9qqh5s4k9Cd1or5Q8a3LFtHXm/uyWPo3UUhudJA9Umsi1I7KF80bd9eownwbpmF4vDIHrHxaglw/iNfR0I3O8q
X-Gm-Message-State: AOJu0YxgjDq/Gq6zPJEejy7DIGqEg6miLDtzF6gBMoJV141T/AijP8xP
	rway6XSnhquCZf+Jzydud+80bn+ypQTMLojswOW3P79oUS5v7suPGxCBbhy+NxKHIDE5TkN8TRT
	kNoTdiKL7OP8jR324XWXfNFN8VNVki4eEZ4xX8+QmlSNLrIQwLhrbDBjGmObB8w==
X-Received: by 2002:a05:6512:3e1e:b0:521:cc8a:46dd with SMTP id 2adb3069b0e04-52bab4ca688mr2447043e87.11.1717596459944;
        Wed, 05 Jun 2024 07:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWQkEGTiF2US910j6qATuYv6PWll++dJZVRQ+oWbzvMc1eD4nMBj6V7rtuZUfVx9VVE5M1nw==
X-Received: by 2002:a05:6512:3e1e:b0:521:cc8a:46dd with SMTP id 2adb3069b0e04-52bab4ca688mr2447030e87.11.1717596459494;
        Wed, 05 Jun 2024 07:07:39 -0700 (PDT)
Received: from [192.168.0.161] (host-79-23-6-148.retail.telecomitalia.it. [79.23.6.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e6b5cdf8sm559531466b.81.2024.06.05.07.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:07:38 -0700 (PDT)
Message-ID: <af031e33-74db-40ba-abdd-ef1bf32e4caf@redhat.com>
Date: Wed, 5 Jun 2024 16:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
To: Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Metin Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
 <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
 <20240605093246.4h0kCR67@linutronix.de>
 <20240605132454.cjo4sjtybaeyeuze@airbuntu>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240605132454.cjo4sjtybaeyeuze@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 15:24, Qais Yousef wrote:
>>> But rt is a shortened version of realtime, and so it is making *it less*
>>> clear that we also have DL here.
>> Can SCHED_DL be considered a real-time scheduling class as in opposite
>> to SCHED_BATCH for instance? Due to its requirements it fits for a real
>> time scheduling class, right?
>> And RT (as in real time) already includes SCHED_RR and SCHED_FIFO.
> Yeah I think the usage of realtime to cover both makes sense. I followed your
> precedence with task_is_realtime().
> 
> Anyway. If people really find this confusing, what would make sense is to split
> them and ask users to call rt_task() and dl_task() explicitly without this
> wrapper. I personally like it better with the wrapper. But happy to follow the
> crowd.

For me, doing dl_ things it is better to keep them separate, so I can
easily search for dl_ specific checks.

rt_or_dl_task(p);

would also make it clear that we have both.

-- Daniel



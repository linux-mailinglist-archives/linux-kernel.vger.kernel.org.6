Return-Path: <linux-kernel+bounces-202752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEBD8FD065
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D3A1C22728
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1010A12;
	Wed,  5 Jun 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYgF/4W3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F710A1E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596331; cv=none; b=Op1bQMTvcCX14T7WRuFe9l78JrV5PBQ1S4oTjuWjZl5BLtFAauakyncBxLehJKJaTAK+THD3mPZXydGcScE/PjZhwO306Nd2H+OFXwnfEqYwDD3clyAASxGT0IOCTEYA1d+xSOBDkm0NQ78RRYYmLryZRBwedklHY0O/3NaGc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596331; c=relaxed/simple;
	bh=J2kQ4wQoNvDj4NE3mHtx5/BMuZd20qs1tyhxegM305Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4fVrfG3hWtcazvyem/Sc0ZxBJYZ0FR5yGh8K59KKgZlPS6rOBaLKdn2qyonxRXO3tzrOLmaMwtC2RsHuzwXrVOtQUYiBwbu4e26WzvODYdjzuv6eYq0h6c/3GJ6tHZJ7knr6ISWyV/DRujkHx7SqRDKBoJBLPTSGRxnk7RIyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYgF/4W3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717596328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnAjRPdPslLKR6RQzu2pBmXnTD4p4gc93G0q5GXgtK8=;
	b=GYgF/4W3t6HhZMA7j0hbcgv6t0Q23+3SlQu9Z4TPWVl1WblnU1GdcuW7OuHPz2EzdlfbV5
	gqna9P55slFr3XvJwIxdu0qr/revjtmRuTH1eqyKSvsH3WTbUDbrKTVV5hBW7a2WFed0u0
	OwmIkggVpSbIsZiZrz95k7t9Ni1VJPw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-hRzSkVHZN-apQgT_v0R6AQ-1; Wed, 05 Jun 2024 10:05:27 -0400
X-MC-Unique: hRzSkVHZN-apQgT_v0R6AQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52baa2e4ab1so1376961e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717596325; x=1718201125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnAjRPdPslLKR6RQzu2pBmXnTD4p4gc93G0q5GXgtK8=;
        b=ZgJt86LVOt0UPF9IKZhs9Lk9CsBo3/DC4pqJIcMnTdc+26EwnSgEA75tDATuHHHTbu
         VH23zwdvhvuSSTnua52OYhQedGPkyee3uKUpdiZ5ny5C7dfCSFBnulJmJhaqBDvoWFv6
         NG9Qw5yLLgnYH3Ue1I5vHLfP/YPsGNgq9K7ZUbb7GR2Kbnh04mF5FUdhMcfxDp6ONniv
         xB73pmlRVvGCr0Z7Ilg+i9OrbGUmBdJ2k5zEj6pxzAS1KBfOxKlHFjBQJ7+ExIAe8l+e
         +N5cExM+cfWrWiF2xzF4KCs7ZKb+9Psa2t0+Pyv5d6UU0DPjSyQ5IgO98kPJ2qmu3Lpr
         gXRA==
X-Forwarded-Encrypted: i=1; AJvYcCU6kz5NQaXhW5cVVRCioXLACnBiOR/2Na4kRr6CY6FPeuRZvzg4mc01G6yuDv498wrgdKbvpSejKnYylvYL+2Qk6n6bRxBW98GUihOd
X-Gm-Message-State: AOJu0Yys9UHxvBt1JBe6izv0ZOiD4xcynkGaskeeQqo8uYGiuPfq5535
	NbwPKVc3HDsuiqv4dGd6WatzUouF0XSXpKJyKLUEC+0RfgKdTE/xad3k6YMdSD9CgnJ4Lv3XZca
	qazrKJkzSfjcUaOo0IC1l5UpsY3lbu/0GvGRUBQf6kgSPRqWxPYHE4q7Rqr4hqQ==
X-Received: by 2002:a05:6512:3e5:b0:52b:4ae8:46d9 with SMTP id 2adb3069b0e04-52bab4ca6d4mr1891860e87.5.1717596325743;
        Wed, 05 Jun 2024 07:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC7EdqZjYrmyMx/USwVrnIBDKTdRMVW5oYpkXPFLx7eROHA0u1LtZeLxEwCYBnW4Z+lNhiRA==
X-Received: by 2002:a05:6512:3e5:b0:52b:4ae8:46d9 with SMTP id 2adb3069b0e04-52bab4ca6d4mr1891750e87.5.1717596321944;
        Wed, 05 Jun 2024 07:05:21 -0700 (PDT)
Received: from [192.168.0.161] (host-79-23-6-148.retail.telecomitalia.it. [79.23.6.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a681c4f2b6fsm777163266b.144.2024.06.05.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:05:21 -0700 (PDT)
Message-ID: <9f21c8e5-1103-44fa-82bd-cf608f8a96f6@redhat.com>
Date: Wed, 5 Jun 2024 16:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
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
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240605093246.4h0kCR67@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 11:32, Sebastian Andrzej Siewior wrote:
> On 2024-06-04 17:57:46 [+0200], Daniel Bristot de Oliveira wrote:
>> On 6/4/24 16:42, Qais Yousef wrote:
>>> -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
>>> +	    (wakeup_rt && !realtime_task(p)) ||
>>
>> I do not like bikeshedding, and no hard feelings...
>>
>> But rt is a shortened version of realtime, and so it is making *it less*
>> clear that we also have DL here.
> 
> Can SCHED_DL be considered a real-time scheduling class as in opposite
> to SCHED_BATCH for instance? Due to its requirements it fits for a real
> time scheduling class, right?
> And RT (as in real time) already includes SCHED_RR and SCHED_FIFO.

It is a real-time scheduler, but the problem is that FIFO and RR are in rt.c and
they are called the "realtime" ones, so they are the first to come in mind.

-- Daniel

>> -- Daniel
> 
> Sebastian
> 



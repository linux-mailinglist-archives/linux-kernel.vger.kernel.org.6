Return-Path: <linux-kernel+bounces-396356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F019BCC1C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD112828C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390031D47C6;
	Tue,  5 Nov 2024 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpPxMjfC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E551D173E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807254; cv=none; b=rDBqERz+y8hrY8LiGCnmopPwmxAodVI/4nMxI93B+18D/RbCNIUQGSyeGom5vX/DYcww5C1a7jqEmkIGqJNQL9IylXHP5GNtE56C4WnkPQ/oAHtoywA2GN2Qt6VDrihn4UYUKFJVMn9aL9U+KH6oGFr/7Z2BG441iamOYuHcmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807254; c=relaxed/simple;
	bh=+6/H/XDafrltzhOFfb+5FmSnOevGqRPMwlJKVVM64SI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJGasbnIBUjLf7TjP/Rr00yuz2gu4FJ4WAefIqppIAR0EW0xdElyZpK6006C6wd5fCPnJg8O3d6l/fg91em7mekZ5o+sEpW1B+DijL2l6U0SUPXhGJwkwOTsLZC2N2OWC7sIPN0EIXXNQMaByXt6idJ25VcOmh1sb+YfMOd9RDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpPxMjfC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730807252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvEt+630bp2zTwkv8fB0BYAPpHvXTyBk/V9RY8sAZMo=;
	b=hpPxMjfCU6k/05bR20OvwPFk8OfjksUn1oVllqyqRd8OLujg6PPZ4dzQlYCrA2KRXfKwEY
	9pHDOD+i9jvA900JjXehgmZ9NRanGsMtkYj12+jTwUerUqfNdxJ1xpv0wHBjFEP04+oAye
	o9czIwcu7j1YHHShKGdFx0hAd/yotUw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-yf1hFUmoMsy2IbaNJS3f-w-1; Tue, 05 Nov 2024 06:47:30 -0500
X-MC-Unique: yf1hFUmoMsy2IbaNJS3f-w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1b872d8bso377398366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730807249; x=1731412049;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvEt+630bp2zTwkv8fB0BYAPpHvXTyBk/V9RY8sAZMo=;
        b=ZcNKNpNMAuGTryQA1TZ92aey3SfG/tUzW4hV9XzvqtG5XhtnOQWZEDVRFwnuAI/te2
         3m5lU44csMMogQBfsDueRvcbhgDnInVc40EfL0e7w/obyDYhqGtl6cvC2ahmT71juH7R
         efUdjowH4XrG5Gq6TDfQUWEDMNQWglAR6h3ZpZ6ZT1Iw2f4SSuTyrRJ8axp6nwbzz9g1
         C85FtLgc85ZnpuaQFn2lepYI2opAnFSWUnnpQP8PFqJBMjCruRFkOm9o+7KOxeAuwUib
         FhSB/Gumu8+tOrzMSiWe0ovZdLElAGU2uY62gHPs2rNQnmi2TSr7VhtRHH7EnGPvZXC/
         cctQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLf7iPxe7y6sUrcg138gQdOSAPNBrTb/kt8ZnekGlbAoTJgAgPtAVeTIL7O/wj5H2O30VTvhCdzIHjvnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjwePsxeCPQMMrI3PlMFFboIozqCgzdMEdLXJAPORFPzl6h20
	nQUW9pJkSNLr4ZkLF5psfRUgInVHmIQLcR4QuVdThL+BzeckX7dcabMtU+Xao+7Yla8x4gAWzVo
	O3vzPgPVW+hb6kKTdZagETB07NKhO7lEJxLdecqxKncyfE2lSRv0SWQPfxiBjTw==
X-Received: by 2002:a17:906:c113:b0:a9a:5e3a:641d with SMTP id a640c23a62f3a-a9e50cb0401mr1967595166b.59.1730807249483;
        Tue, 05 Nov 2024 03:47:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXnL+6T8mGipW8cAyu0azUR7FlsedzWWDQr98e0c9nhVPjkKd8TbpT2mFnkD3c0nE8mjR0kQ==
X-Received: by 2002:a17:906:c113:b0:a9a:5e3a:641d with SMTP id a640c23a62f3a-a9e50cb0401mr1967592966b.59.1730807249104;
        Tue, 05 Nov 2024 03:47:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f964csm122895066b.159.2024.11.05.03.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:47:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 57ABF164C228; Tue, 05 Nov 2024 12:47:27 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Qingfang Deng <dqfext@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ppp@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: ppp: convert to IFF_NO_QUEUE
In-Reply-To: <20241104115004.GC2118587@kernel.org>
References: <20241029103656.2151-1-dqfext@gmail.com>
 <20241104115004.GC2118587@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Nov 2024 12:47:27 +0100
Message-ID: <87pln99a28.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Horman <horms@kernel.org> writes:

> + Toke
>
> On Tue, Oct 29, 2024 at 06:36:56PM +0800, Qingfang Deng wrote:
>> When testing the parallel TX performance of a single PPPoE interface
>> over a 2.5GbE link with multiple hardware queues, the throughput could
>> not exceed 1.9Gbps, even with low CPU usage.
>> 
>> This issue arises because the PPP interface is registered with a single
>> queue and a tx_queue_len of 3. This default behavior dates back to Linux
>> 2.3.13, which was suitable for slower serial ports. However, in modern
>> devices with multiple processors and hardware queues, this configuration
>> can lead to congestion.
>> 
>> For PPPoE/PPTP, the lower interface should handle qdisc, so we need to
>> set IFF_NO_QUEUE. For PPP over a serial port, we don't benefit from a
>> qdisc with such a short TX queue, so handling TX queueing in the driver
>> and setting IFF_NO_QUEUE is more effective.
>> 
>> With this change, PPPoE interfaces can now fully saturate a 2.5GbE link.
>> 
>> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
>
> Hi Toke,
>
> I'm wondering if you could offer an opinion on this.

Hi Simon

Thanks for bringing this to my attention; I'll reply to the parent
directly :)

-Toke



Return-Path: <linux-kernel+bounces-396400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285489BCCA2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD42B20D8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E11D460E;
	Tue,  5 Nov 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFt2oHD3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2D1D47C7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809448; cv=none; b=lXqoXdUwuAtrDD51HJDugJTgWK9p5/RzkKiJ5+Rf02znq95g/RtkFZtjlDduofAG9SpfzO7Wn943BOwi466wfReRoOxTRQHu8NatpWjIZlTs3/9O7EEfWIZg5MrE8dhk5Bwf5qgNMtO3qvh2tOrUAUm98NW+xQqrDB76BZrQ7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809448; c=relaxed/simple;
	bh=Z3RxKyFF+Ak9RYp0Y7HGuKQtSUXZCbiRnqXg63PqVbU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LHXSzFUPgBGVVS/NoCzzapv0ClX8BQjGGkoh+rh0oP4sWXrPAG2AW2wxd0DHQMlmZ2lw3n4iqJVyJ8tOaR/jSafSn8pcLYbG2CuSJHBmpzcnIWtxyx3kXXDQFp/+Sy3bkcq8tEMN9TrC2m+BSEkW1+3+j6RgxUUX3jat0GndgOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFt2oHD3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730809445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3RxKyFF+Ak9RYp0Y7HGuKQtSUXZCbiRnqXg63PqVbU=;
	b=IFt2oHD3qNYE1P+wrY2C2Xlt7A8V8iFgVw+pVEWIzllEW0vnPbF1+CTC+olfSC/ufnZUZj
	UuSPefEHlHX1v+XPDAsY0XcoJA94SjPE67CBdiCNaqlYnGH2A5OQyIouRAqRPW38o6wIDt
	kIBxU8vIdvilUzFqyErbMFbCePIxYRw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-NKAPh83uPxOORVM_YhmkIw-1; Tue, 05 Nov 2024 07:24:03 -0500
X-MC-Unique: NKAPh83uPxOORVM_YhmkIw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d49887a2cso2908982f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 04:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809442; x=1731414242;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3RxKyFF+Ak9RYp0Y7HGuKQtSUXZCbiRnqXg63PqVbU=;
        b=TiA3lER7eJwD2hKI9BIUQc1rTc6xB33xQK1iES7ssQUoAfYrgbmmWeNmQX0zR+cRlH
         icg4vj2nxd/x8lcN1ucSpERP+U9kEJ06FcIl5aMAWrofhDMddC0/2PMNaxxj75WlOLB9
         ulOCuGCg4eBqjCGrrgi4qTa2miAE3SVk3ICGf9oXbJkiAAq76Znc0c7o9dlg/borWXLi
         C4ptTG5cdo4oApn0h7BeOB0ATs13/4ayOK9OwcrAw0y6sUSWAIgt0eE8s1T2sGX2u5z8
         k3CL9GXFK2ebYwxOuH8v/ZzkljUER+RfP0hTDCNkeNYbYxTO1sY0rgOkLTPpFMdR/W6Y
         leHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW694abjyY1Cyigh8bjypTGEyXGqV6IE6vYEoT5LZwP0HFTa6aEhQ8jNbaqYoBEFrg7xbCivnXmrYp/Hoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLa5DPGXEpjUxW+K8HfJc7FxwLn0KaSTiFz8h0FP4XguJFMMy
	Kb2sPH6Cx2qlZnb+ZByIdOr5lGtNT414SANNwuUhmdHbeSsK4kAQYLlq1My0gRrk6BGNeDcKw7w
	Mas+W8xzEfr6gHEZQIk4I44VUT8RqG4Kmz+zs2eMlgjKeNvExrHHOHxxFwCLcwmn8i6fB/Q==
X-Received: by 2002:a5d:64a7:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-381c79e366dmr13150401f8f.22.1730809442215;
        Tue, 05 Nov 2024 04:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzZvOHp9mDNLf51xpdI90j858qfaPZWduW8ds6lyIOgmL+9RgRFkJgWVGEH17X6Wx/BjpnPQ==
X-Received: by 2002:a5d:64a7:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-381c79e366dmr13150378f8f.22.1730809441710;
        Tue, 05 Nov 2024 04:24:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e69fsm16050891f8f.69.2024.11.05.04.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 04:24:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 061B0164C230; Tue, 05 Nov 2024 13:24:00 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ppp@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: ppp: convert to IFF_NO_QUEUE
In-Reply-To: <20241029103656.2151-1-dqfext@gmail.com>
References: <20241029103656.2151-1-dqfext@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Nov 2024 13:23:59 +0100
Message-ID: <87msid98dc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Qingfang Deng <dqfext@gmail.com> writes:

> When testing the parallel TX performance of a single PPPoE interface
> over a 2.5GbE link with multiple hardware queues, the throughput could
> not exceed 1.9Gbps, even with low CPU usage.
>
> This issue arises because the PPP interface is registered with a single
> queue and a tx_queue_len of 3. This default behavior dates back to Linux
> 2.3.13, which was suitable for slower serial ports. However, in modern
> devices with multiple processors and hardware queues, this configuration
> can lead to congestion.
>
> For PPPoE/PPTP, the lower interface should handle qdisc, so we need to
> set IFF_NO_QUEUE.

This bit makes sense - the PPPoE and PPTP channel types call through to
the underlying network stack, and their start_xmit() ops never return
anything other than 1 (so there's no pushback against the upper PPP
device anyway). The same goes for the L2TP PPP channel driver.

> For PPP over a serial port, we don't benefit from a qdisc with such a
> short TX queue, so handling TX queueing in the driver and setting
> IFF_NO_QUEUE is more effective.

However, this bit is certainly not true. For the channel drivers that
do push back (which is everything apart from the three mentioned above,
AFAICT), we absolutely do want a qdisc to store the packets, instead of
this arbitrary 32-packet FIFO inside the driver. Your comment about the
short TX queue only holds for the pfifo_fast qdisc (that's the only one
that uses the tx_queue_len for anything), anything else will do its own
thing.

(Side note: don't use pfifo_fast!)

I suppose one option here could be to set the IFF_NO_QUEUE flag
conditionally depending on whether the underlying channel driver does
pushback against the PPP device or not (add a channel flag to indicate
this, or something), and then call the netif_{wake,stop}_queue()
functions conditionally depending on this. But setting the noqueue flag
unconditionally like this patch does, is definitely not a good idea!

-Toke



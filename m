Return-Path: <linux-kernel+bounces-282607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F994E662
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C91C21599
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F114EC59;
	Mon, 12 Aug 2024 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IN9jC5um"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324207406D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723442758; cv=none; b=jUxZWI822aGn52pHgHQM1/D/MwQxGQA4AFEOAdoNWljBYI4uRq+ef8O5QFpPBK4zj2OLLGCTGmvDD86k1T/pB6eX91o3bPuzOQdFXoWJSRq0icuDq2qoRcI50tHT3i2/V8mlbbjtquziEjLjLZXFOBXMD/wQV6jmXwHWNVXgx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723442758; c=relaxed/simple;
	bh=Dm/92/bGvdHP5SQ80XUnnaP7TEoYqwtKdS6w2k2Gz4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUzFOk78LK20imLsuLh0/I77awQbxGMcaMAjBr/kv2nveKQ89VaKlR+uLyV3z4G3zKgdyGmji0TIlf03chwGVTtFF7g1pVSasqBKlA9ElBIAWvHR6C1IFaUA6bNzwnzV1QXZhnxP5tWK0z6SpLweDyDTrxzv2NE+DVkptaEQ73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IN9jC5um; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723442755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qA4BH06bb7VMDIbOMqT+kOmvZ/O4l65OvWNFedwV4Kk=;
	b=IN9jC5umn4xvzEtVnQeezCN24uwVZA2T0FikpstSmX0fo75up8M30XUroDNLrIxmWuImnF
	qtCg3AMhshMHRvgV2FX0tAC3tsV8uwyv9lUMzasmq5YKvYe4DlWh1tm5F3FWs/HMtXty/1
	8QKE/KBPLtjyn4VlvZXRhzhMOz5jpLU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-K2tMVH5rMU2YZSqw8l1YUQ-1; Mon, 12 Aug 2024 02:05:52 -0400
X-MC-Unique: K2tMVH5rMU2YZSqw8l1YUQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb600e1169so4250135a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723442751; x=1724047551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA4BH06bb7VMDIbOMqT+kOmvZ/O4l65OvWNFedwV4Kk=;
        b=WK2jcUNCx9S1UkPCNia2djk+5kPm8VKyNMWva6X1kcWuiiGbde9MpBWY8DCsyyHKcR
         nEvQouCPiZXJjlpHAuytLqcUfzGqYjgdtzP3CMoBvdrBTpml+y3mCtEQDC8mnAh3S6kB
         Uv2HTomdNb8RSCMhq92zgA4/gef/wCeLuJvrKyk9xnis5FPBO6natWVA9y2Y0eEvApN8
         f5SRIyDaZfZPoAli84tlD6qSjA52FkZgb4wvWF8YSPZ/aGo2rm9UvhXil7tV2zgsjjE5
         cqBKkMYb24VqiTlxUyJlmMrd9I64Xx/tCwdgI8bzly58d8OdTYX/6aHkNamUuWatheag
         Ek8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHa5qQyutCAt0eIknqShJXiNy177KlbRGz7xVpQZsw63kRsN61+8YRkZ/W0zVOrn3G7gC4X1USswYBfTGHROta+7koagomYLOmIVot
X-Gm-Message-State: AOJu0YzB3V8mebVrpPcXzIiKYH+LQh0YGwWKHLtC0XaFm6khDVaZFD+h
	Er+WMos5fGsA0BDlCgv2WiMv8pfN+f0j96gKfWjz9EjGz3zCqF5yyD18/kv/mVza7BiUdd8l8fz
	KbGqKXsNopcmV6emjHxYf7rOfSBjn22SAVZy3bbrtymzPPSnD/Uic0E7a5oWtOu4LUSjH1IxKds
	FaHp0dT7QMpPMmeJZa6xFkIoGye5aBo0xWcRos
X-Received: by 2002:a17:90a:e7ca:b0:2cc:f538:7cf0 with SMTP id 98e67ed59e1d1-2d1e7fa3ee1mr6621450a91.4.1723442751222;
        Sun, 11 Aug 2024 23:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPchhMOprMgdkVva/H94XFQJSN4hrwiz5xzEmRL+mAgQxBDibh8AJMSeiipVWXNAeVB9xnLnBIBB/EeLveqQg=
X-Received: by 2002:a17:90a:e7ca:b0:2cc:f538:7cf0 with SMTP id
 98e67ed59e1d1-2d1e7fa3ee1mr6621423a91.4.1723442750662; Sun, 11 Aug 2024
 23:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
 <9C79659E-2CB1-4959-B35C-9D397DF6F399@soulik.info> <66b62df442a85_3bec1229461@willemb.c.googlers.com.notmuch>
In-Reply-To: <66b62df442a85_3bec1229461@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 14:05:39 +0800
Message-ID: <CACGkMEsw-B5b-Kkx=wfW=obMuj-Si3GPyr_efSeCoZj+FozWmA@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: ayaka <ayaka@soulik.info>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:55=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> ayaka wrote:
> >
> > Sent from my iPad
>
> Try to avoid ^^^
>

[...]

> > 2. Does such a hash operation happen to every packet passing through?
>
> For packets with a local socket, the computation is cached in the
> socket.
>
> For these tunnel packets, see tun_automq_select_queue. Specifically,
> the call to __skb_get_hash_symmetric.
>
> I'm actually not entirely sure why tun has this, rather than defer
> to netdev_pick_tx, which call skb_tx_hash.

Not sure I get the question, but it needs to use a consistent hash to
match the flows stored before.

>
> > 3. Is rxhash based on the flow tracking record in the tun driver?
> > Those CPU overhead may demolish the benefit of the multiple queues and =
filters in the kernel solution.
>
> Keyword is "may". Avoid premature optimization in favor of data.
>
> > Also the flow tracking has a limited to 4096 or 1024, for a IPv4 /24 su=
bnet, if everyone opened 16 websites, are we run out of memory before some =
entries expired?
> >
> > I want to  seek there is a modern way to implement VPN in Linux after s=
o many features has been introduced to Linux. So far, I don=E2=80=99t find =
a proper way to make any advantage here than other platforms.

I think I need to understand how we could define "modern" here.

Btw, I vaguely remember there are some new vpn projects that try to
use vhost-net to accelerate.

E.g https://gitlab.com/openconnect/openconnect

Thanks



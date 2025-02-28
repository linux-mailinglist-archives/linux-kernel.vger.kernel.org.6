Return-Path: <linux-kernel+bounces-538557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC500A49A34
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57572188A1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0CB26B96C;
	Fri, 28 Feb 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNURMclR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27302F41
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747990; cv=none; b=m3OLeora4/THTheoQgj80k1H/nUozzJDJHyUPCVgbjGOa/7SlpoKyOHEPyx9B4YCFM9j0jqOIdgYlvFH8zjgYO5MTaG/CYklHjTCJjIrbEH8vnQfvj2ejQ+bbiQF+MzE7mGJovfLAXImT/RTrDyL9hXS3aRBUUQ65viL0hFflFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747990; c=relaxed/simple;
	bh=+GsZ2x5HDjoLoOW+IXY8Q0+AMdGD72Srex7vp56yPeY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvUOMaJhm/xEIhEkRDFtw8cVkbalbR2+H3xfMk3A+A1F9IZBuTwJGwnX7icsPLVY9YuFADDkDExMMTJ7vV4+e6NujbY/ugNwb6b96/X8Y0y7QfCPLr1EeFb8jh76U+p+ajvz6hoGn02ogKp8nusSGcRy8CR4ymjpOca2oMhoFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNURMclR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740747987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rXONDGo6ihZ0iPAG84+CFGzh14N9ncmYlb6e6RA5ajA=;
	b=WNURMclRK/elCk10UKIXY71Bnt7gwcf6uyTgVTy6LK4XZcCcRIdb5NYSMMk2+cvA6y1/gE
	JFF6UiSLT6wfuYEttzu1DE+1brgapqZF5GugSMOTH4Opww2e2ihQoVvOEGYQP0oxI1e03j
	UR1K/SBp+toD84iDhXxZN6QRDtmVJJM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-zDEgWlCGO2m6qXc1xIjODQ-1; Fri, 28 Feb 2025 08:06:26 -0500
X-MC-Unique: zDEgWlCGO2m6qXc1xIjODQ-1
X-Mimecast-MFC-AGG-ID: zDEgWlCGO2m6qXc1xIjODQ_1740747985
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-54958006b81so13673e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747985; x=1741352785;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXONDGo6ihZ0iPAG84+CFGzh14N9ncmYlb6e6RA5ajA=;
        b=hh9LJNBUA+SF5WhlmBKS+aDYh1SJUPzWsG+cNidKxEnSlg09YWOmvDoDewPNuI/oM2
         +9hyqlJxbuTi7Pf0xDO5knNQDG73c85CSLr9+txWcyX+vnBp1IrPKunI2rXIfv9EXk2o
         9tvO2mtzf/Hq5EJv6oW3OQNT5nEFP3cMi1Cfa0cNOt++qQA7Bq4hNLGg3RaoqO8RGu/g
         qfMTwZ/tXRXh4SXthz52NGjYXAz6uo7xKQS7UL2AaiblhtUNTGqDK/fVtORLv90ozJ4A
         2xAJAI+sMr1D/2qs5LhLHnaS+RYAcmqNvwEDt+V+JuSl41EUrarkZMPvCberjRo9EzIU
         +/7g==
X-Forwarded-Encrypted: i=1; AJvYcCVotB20SmNtP+QmQUeqJ326PotruQXWQNUcT4bLiKiHdFDbXzEiapk2b7HW2p9PMBbCQqKSZ0nYfhD/4Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVc3pKTLfZIgF4kWyxHQZyc5uyBsQru+YyvQwX4hl3PNSwpGz
	yP2L759I6KB7T2IQT7Wr4zkKt7Ii7Q9n6uSetshi0Xrt2ZTBVO4wi5VM/V9zpZNE8RNtJu7HSfv
	NyGOLGi3/wUZZE1BK8PoGqnIwzmB6C46MbY5idkIJpBVySs7g5QTwjDJ996t6CQ==
X-Gm-Gg: ASbGncvHpmoGm2bhJ7gDs6f3TS4t9OW4PWWapYovb6LEa+P/E8VcPSRFWa/jXguwtYN
	ACCky/azzC4LycXvRVt5lckon1gh7ShZipJTn690EyAYdF3yhchaA6zl3IsXMermi+L5E0BPB55
	vqSF1TT0xfPXV5Fic/0fUFLiieaO+ZeaKPJ9CPppWOvU6F95ExYxVY13TFAQtRJ3Jt4oISSSnT1
	NjYMYm8IXST96BhFJugiX+9VSWPPh592pSyrhFjxpMI+1lbKFFEUWP/yVyGznwGq2lYzdRGMS/y
	HbR8gGYCSAMG
X-Received: by 2002:a05:6512:693:b0:545:d35:6be2 with SMTP id 2adb3069b0e04-5494c37b691mr1519554e87.34.1740747984675;
        Fri, 28 Feb 2025 05:06:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXotuHxxDRGbkDTRI047dsn/XMby3ovfUFDsR8yccG6wwU82nc0E5sR/kWuqacEJVRyen1nA==
X-Received: by 2002:a05:6512:693:b0:545:d35:6be2 with SMTP id 2adb3069b0e04-5494c37b691mr1519511e87.34.1740747984188;
        Fri, 28 Feb 2025 05:06:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494cb3352dsm274562e87.184.2025.02.28.05.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:06:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 970B818B69EB; Fri, 28 Feb 2025 14:06:22 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Michal Ostrowski <mostrows@earthlink.net>, James
 Chapman <jchapman@katalix.com>, Simon Horman <horms@kernel.org>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3] ppp: use IFF_NO_QUEUE in virtual
 interfaces
In-Reply-To: <20250228100730.670587-1-dqfext@gmail.com>
References: <20250228100730.670587-1-dqfext@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 28 Feb 2025 14:06:22 +0100
Message-ID: <87bjum1anl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Qingfang Deng <dqfext@gmail.com> writes:

> For PPPoE, PPTP, and PPPoL2TP, the start_xmit() function directly
> forwards packets to the underlying network stack and never returns
> anything other than 1. So these interfaces do not require a qdisc,
> and the IFF_NO_QUEUE flag should be set.
>
> Introduces a direct_xmit flag in struct ppp_channel to indicate when
> IFF_NO_QUEUE should be applied. The flag is set in ppp_connect_channel()
> for relevant protocols.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v3:
>   Move direct_xmit above the unused "latency" member to avoid
>   confusion. Should I remove it instead?

If it really is unused, I think removing it is better to remove it,
yeah :)

-Toke



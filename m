Return-Path: <linux-kernel+bounces-394333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9A09BAD84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC1E1C21240
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C819CC02;
	Mon,  4 Nov 2024 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dd6Nlr8R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC018C320
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707101; cv=none; b=RSGlGLGKWKFIiQNS/z0DIj3OhNxTYYl9FWfi/aS/axZOtOT8KmXK2Z3uFnb+SfVzeQUGrIH/q6xM/qabFjiYQS5+9f2xawCrRjqkv2/ix4jb9evw4noD5/FXwx8ICfZUl7IKp6XIM5XYtSEL0stkGHIaebhNqINshZng0aRfsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707101; c=relaxed/simple;
	bh=GDFehj+2Q5QgjBvLeZg1uWgjvHdjMU2PvgA3F+vFyZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxx/4BRyPK8idgK+zrbVctKV/FtStN/P3W7xTUGrR50EmUTw/spgcAdyvRCz8DqQFuMmGK+JTxKWpsBTl1LjwgbI4qArZFZvGn+SO3SRxNcMCxJbuEiVP/gj7uTLA5KGF/5OkYMXxx/yf13bnY/aVzloBYKva74mGTs3vAOXnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dd6Nlr8R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730707098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcyFQ9rHsVsrsTfHR/B5NzPP3h2da5K+JoorZkF8Nik=;
	b=dd6Nlr8RXTBjuV56XRIBfwQufbE0yche/nx59PB41KL4ivjjZPybM0KUg+WqXivg/Z106i
	j/24GA4K1xsnhZ9/XyoZefz3Zq8pHPm1BM41vmOltXDV7S4vMbSUbmNRkwRyEbMqDu5jOL
	WlX1XW2WlfInKKJyyufsJaI49H2aImw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-0VC7VpOTM2a2Ecry9IMwIg-1; Mon, 04 Nov 2024 02:58:17 -0500
X-MC-Unique: 0VC7VpOTM2a2Ecry9IMwIg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9adb271de7so310843666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 23:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730707096; x=1731311896;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcyFQ9rHsVsrsTfHR/B5NzPP3h2da5K+JoorZkF8Nik=;
        b=fzV7E5l7TVAX87/8WoGesETDwBwHT6O3jladI486Kk7OMoeQmP2F/Qrffrb6niuDb+
         z42J31X3E/x4UUFlI3R4vIeFRV8V7Bvs8vZuap/HGUG19motWlqE/wC0WRLr9F9/B7Ys
         Vlju3Pduq+MWtu2KL6/yYd5SBt5PmuFTNArKCoCvVBgfgo9S7/M/cQzzYl2+rOkekabS
         llDYceG0V9An0U2v/hABwdhB3FIRzmFsH0Z9DJ8klq63qehkmihMAUhg9h4ny7hebQf9
         00jG3HcA53Ozgbl5WcoKw1YUaHi3GMkkYmrxwuSAQejPlVoeGFyVJIpRHfedDTHHMwRh
         9wEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjgcxR3kjfOFOI0Jv+7jiiDok1fPcUVnjZzzG4qBTtS3QnJoUd8RLbyOW9cHCOSpp3jlpZkZqwuTHvDrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFqXSa3k35wwnZNLJzKVrrh1VVt+319u3IVfnY93GHIC1lJxf
	BzvZcTts4zsE9OQxNMd145JQsuDTIvHReLUwXU0chpT8lMYV6n1LIoCHrugbNKUh1HbvFRoarvq
	Ibg14s5WEOPNzbvW6HRTuyhdfs5cMxArxm1nnFrMRvmxfGunXBbgrXNL0/8QyDQ==
X-Received: by 2002:a17:907:1b93:b0:a9e:380b:8ce with SMTP id a640c23a62f3a-a9e380b0dfbmr1218137366b.35.1730707095905;
        Sun, 03 Nov 2024 23:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP0751gl8VphAgLQBVElCDxBCGzv/BGgumIqFmFlbuVGfyRKgj1T5etuLQrKxBtrjeJIXMzg==
X-Received: by 2002:a17:907:1b93:b0:a9e:380b:8ce with SMTP id a640c23a62f3a-a9e380b0dfbmr1218135766b.35.1730707095507;
        Sun, 03 Nov 2024 23:58:15 -0800 (PST)
Received: from [172.16.2.75] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564940d5sm519757366b.26.2024.11.03.23.58.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2024 23:58:15 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next] openvswitch: Pass on secpath details for
 internal port rx.
Date: Mon, 04 Nov 2024 08:58:14 +0100
X-Mailer: MailMate (1.14r6065)
Message-ID: <D4FB09BF-FF61-427F-A2E1-545F7F9052F4@redhat.com>
In-Reply-To: <20241101204732.183840-1-aconole@redhat.com>
References: <20241101204732.183840-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 1 Nov 2024, at 21:47, Aaron Conole wrote:

> Clearing the secpath for internal ports will cause packet drops when
> ipsec offload or early SW ipsec decrypt are used.  Systems that rely
> on these will not be able to actually pass traffic via openvswitch.
>
> There is still an open issue for a flow miss packet - this is because
> we drop the extensions during upcall and there is no facility to
> restore such data (and it is non-trivial to add such functionality
> to the upcall interface).  That means that when a flow miss occurs,
> there will still be packet drops.  With this patch, when a flow is
> found then traffic which has an associated xfrm extension will
> properly flow.
>
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Thanks for debugging and fixing this. The change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>



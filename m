Return-Path: <linux-kernel+bounces-531758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2FAA4447F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B086C17114E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A144513C9A3;
	Tue, 25 Feb 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzFDClw8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E342A8C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497583; cv=none; b=FeaOgAOUb/vnk2vv+sihJaS916IKOpmBixCIPqTFLMk0jColnKKzZel4bQ1pkErUYYl08S+eQ2duYblLxSuQv1IdlQZb/2YXUuEqOP+/6tGEweC9qoE8kKDUsg6NtPsxbz713xj4v0zgaxgQaLVZ5c+kCx7PJ+XY4/iUqIDPN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497583; c=relaxed/simple;
	bh=C9Crx40HbvCbn4GeoVtQ3Ygq3ygOQ9nSYyB9A++NoMg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVmQfietWIzSMiGU+kp8mQu5NSEpJmyjKbrTzqWl/Gwf0CUx/qk3DWVlvrsPlk33M1Iz0hLhyhawnztmi8AkKUVZh7myBQ6XuxC9mDccjr+6VGjcNJKuTPT2Ld9eYFNaqUWrkgQVOn78tJhXUqSWz4uDSqxM0tfryMAVC72znL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzFDClw8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740497580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9Crx40HbvCbn4GeoVtQ3Ygq3ygOQ9nSYyB9A++NoMg=;
	b=PzFDClw8RZ2FTOv8hlXfQbbFkHFJJHPzSPjsHlZDuTWosNU4jcsZ+Co9fIAcDCKDLQ8tMR
	HKcghCggnnnLTQL3ZOiSRYhC5SCI7XZ5hf3Ido0XJLUH1aAU0gwPNNaknzaY5z3NJqqOLR
	zV1gnr/RlcGselpCXqH475bKDup80IU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-PRvCeNirOw27fbX7rPs69Q-1; Tue, 25 Feb 2025 10:32:59 -0500
X-MC-Unique: PRvCeNirOw27fbX7rPs69Q-1
X-Mimecast-MFC-AGG-ID: PRvCeNirOw27fbX7rPs69Q_1740497578
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abb7e837a7aso487350366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497577; x=1741102377;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C9Crx40HbvCbn4GeoVtQ3Ygq3ygOQ9nSYyB9A++NoMg=;
        b=eetdpkCwpiPm5ppXZTLJYsW3/lKD0gJPQZnCz4MOpBMgPjWmpbQMJB04l/GwGENOsV
         JRZ9laFUugoYarR3WXMnEoM7aFYMCNg1qwxnl6Rwy8luvgl7LECieKSMJyfNyBzjUM2h
         zhhPEKPM0WSov70hzHNsl9LnLTPNnBjrkaWuM1AErwjF8J2fzuEZdE3oh5N48xD77En5
         JmJIahgwv3UxNZhxQZAMGWnQ+kAxU1bYS5xZaJ1gjV/5dpr4rV9LXAakl2XaUdbh6i9c
         P3nCrRdkJV16t8mC7/CZSiiG0QeJUcQRAXG2N/Ay9Sc7IW/sLr2DOCehBjYYGisUhRYp
         O0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWv8dv8E5t1v+rBJSnKAb5FJhDglamaE388H8sJXv97eWlbImWEHfK0MhWH3f4y3t738h0iF6x0ypr0Rag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwf0U/LETHN0RPlS0EIqsPs/aDUSDfUSvXXtDv+KWLnoV7QyW
	7wc5oKUffv1OzUkFkBvFj0t8QtOf2J8XxodyBIaitdoK8xZewa4HfibdQA4VV+5OsENObKOy2X4
	Vu68X/pyyyDjMJ81+5WEJE76Eh6GNL5ojY/07z5qnU5cpAX+UcW0KSb7sfXZormqBeCOiFg==
X-Gm-Gg: ASbGncv70FWOFaBv92fpWy+RnEmweG6ANRQHuXmWlIasMI/9+tuXfJazmHvyQuem6Dc
	eB3LAlyLS1k08G28HysbtG9ng3x1vq9v+FRveaZPF48oeElPacKT4xju+UAaxF8Eb/4dTJcYj4d
	eAcVhY06SRDghUdOdpejSWLZtXx8rNCur0zFHmWxdnD0Irv2H/pStZEaLuFFb2Vy1XPcx8gQHdk
	ApmrTOWDdDa67Y8Wkm87j3sIiNFooXYai7VRQhZPnw6QgzWlRWSXHuDta9CzgAaqHFv3vH2Wlsw
	V7x7sasjUFtC
X-Received: by 2002:a17:906:30cb:b0:ab7:b878:e8bc with SMTP id a640c23a62f3a-abc09c19ea5mr1607977466b.38.1740497577482;
        Tue, 25 Feb 2025 07:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF3+i2Gm1aUPhUaBNxj5u5tbwyt3MeVX876gWJD/IfWjY9OJnLQDc37H8S9ky+bGoOp9yVRQ==
X-Received: by 2002:a17:906:30cb:b0:ab7:b878:e8bc with SMTP id a640c23a62f3a-abc09c19ea5mr1607974366b.38.1740497577103;
        Tue, 25 Feb 2025 07:32:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20134fdsm160623866b.94.2025.02.25.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:32:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5505318AFCBC; Tue, 25 Feb 2025 16:32:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Michal Ostrowski <mostrows@earthlink.net>, James
 Chapman <jchapman@katalix.com>, Simon Horman <horms@kernel.org>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] ppp: use IFF_NO_QUEUE in virtual
 interfaces
In-Reply-To: <20250225032857.2932213-1-dqfext@gmail.com>
References: <20250225032857.2932213-1-dqfext@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 25 Feb 2025 16:32:55 +0100
Message-ID: <87a5aaxcns.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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
> RFC v1 -> v2: Conditionally set the flag for relevant protocols.
>
> I'm not sure if ppp_connect_channel can be invoked while the device
> is still up. As a qdisc is attached in dev_activate() called by
> dev_open(), setting the IFF_NO_QUEUE flag on a running device will have
> no effect.

No idea either. I don't think there's anything on the kernel side
preventing it, but it would make the most sense if the interface isn't
brought up before the underlying transport is established?

Anyway, assuming this is the case, I think this approach is better, so:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>



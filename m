Return-Path: <linux-kernel+bounces-170887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F148BDD52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED70D28442B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46D314D433;
	Tue,  7 May 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AupHgVjw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515E13C9A6
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071364; cv=none; b=nnrC3O4kZ4Vvy0/MNfvI2IpPLwe94QjXLuLq52OJ+gLolKPraXVV62ADnH5bxiH+6x4vzr6a7eDwZgZBDiWnm3wUias/Wm79RUJPD4X+FaS7W4iLDWDj1sfnf3Xr2CgJS4jTG4Ct5FulNOn9yy+s/6bdRhgpkjakG7dyaP9XC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071364; c=relaxed/simple;
	bh=joLZ82/qDlnM3hqNQDbtKRts1WGRIsmAEuypVyS/k5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwJU0O1X9GOkysbS964ttTwbfP2fR5FGoUVToVh+UzCzo8GnpDtLadf+KahKAWpsjZWGQdNi7YF+WRhlkr9bwYzAMLXlP9rJqzRIts2plIqtCMlU6CNRZ3+HHeGU4UyIEAnlGZiQ91Bmc+mHJAoBzFArIsjlEtVmpVc603/uNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AupHgVjw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715071361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MeEIcD5RTZy4syRWjHXHQyoYiBxz8Z+MY7de/HdeVBo=;
	b=AupHgVjwrQ82aLrJuiD+86B/G+pzgeDyBuoqK59rYWVyqIniSUq9NPvezjLsL6BtLy+/r2
	S+lt+f8zi1OwB7SPIOok/nT2v1Ndp4ZNrzYtm9Xb53Fb7vOU+4afPaXZ030Sla6VWYnHnO
	VCNMZsVJ4ioKPw7wzbREUHAq3X6iAow=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308--nSAW8PVNNOYSlvQO3udUQ-1; Tue, 07 May 2024 04:42:40 -0400
X-MC-Unique: -nSAW8PVNNOYSlvQO3udUQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e20f2db07fso4119321fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715071358; x=1715676158;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeEIcD5RTZy4syRWjHXHQyoYiBxz8Z+MY7de/HdeVBo=;
        b=A08FGQgIfaqpQP6uCuP0RRIISJi4mg7XwJlRKJyfHL/+k1wkBMP8wTT5Y9DpL3+w8o
         szCA2uKqnPZzGvZQRC0GOOfC3Is6qyLDEIeC3gT4Oeurga7x9FxwL1ccVNMKr/PI/O3K
         M4KqVcSiJfbntzi/lBpmlYKsm7EHLR9M/UMN4shzwOFQmHhD174NrIEfwX16VodpFuRo
         Mn/3bRqNkxYTX/OCoqm2H+oyCwqIPLNp+vH5oXNwVD3G1Ap/0JB31NAEv8mrYskQuuQq
         c4xOJo4peonJHgQF7TZMreCzzZYJqydtdvIvne7cpR7dMjJJp7dpxeStfttTFqGbO5Dz
         PTKA==
X-Forwarded-Encrypted: i=1; AJvYcCWhlwbeK8L8lbcKYUx5zW0KRdDSR568YRQp077N2hDLKUT8WoqdVY+3WMPWTAWCQVMw/U2WQqHeT9EnmVbOuln18z74GU15sxSJ+2YJ
X-Gm-Message-State: AOJu0Yxh5fTAKnst2zxUTD0khkQlLIJcGyKKktBG9y7G3IHW3M2/EwJu
	Wm9qUt065zlzBapIM+LgKzTfKkTLupIcg8FaISrP7CnZfOct4mANLZR2SWHTbMhIaJduQDU3i9u
	AQep+P48efNprcv64TvirnRPnLSzfNtLK+dXO6tm/fGqlYfNZtc1HgK8X7m1a4Z+O064nuQ==
X-Received: by 2002:a05:6512:3286:b0:51f:1896:be05 with SMTP id p6-20020a056512328600b0051f1896be05mr7822754lfe.1.1715071358186;
        Tue, 07 May 2024 01:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Y56a5xjR2HcpqZeVfq1doUBAZqCrfzjo120onoMM93kAGNY3ZTtOI6x1WtXdxUx9LUN2Ew==
X-Received: by 2002:a05:6512:3286:b0:51f:1896:be05 with SMTP id p6-20020a056512328600b0051f1896be05mr7822739lfe.1.1715071357734;
        Tue, 07 May 2024 01:42:37 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810::f71])
        by smtp.gmail.com with ESMTPSA id b17-20020a05600c4e1100b0041be3383a2fsm22688823wmq.19.2024.05.07.01.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:42:37 -0700 (PDT)
Message-ID: <bbd6a75b644bf11b82af7fa25a47e4fa20630958.camel@redhat.com>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
From: Paolo Abeni <pabeni@redhat.com>
To: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>, 
 Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Richard Cochran
 <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sagi Maimon
 <maimon.sagi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Date: Tue, 07 May 2024 10:42:35 +0200
In-Reply-To: <20240502211047.2240237-1-maheshb@google.com>
References: <20240502211047.2240237-1-maheshb@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-02 at 14:10 -0700, Mahesh Bandewar wrote:
> The ability to read the PHC (Physical Hardware Clock) alongside
> multiple system clocks is currently dependent on the specific
> hardware architecture. This limitation restricts the use of
> PTP_SYS_OFFSET_PRECISE to certain hardware configurations.
>=20
> The generic soultion which would work across all architectures
> is to read the PHC along with the latency to perform PHC-read as
> offered by PTP_SYS_OFFSET_EXTENDED which provides pre and post
> timestamps.  However, these timestamps are currently limited
> to the CLOCK_REALTIME timebase. Since CLOCK_REALTIME is affected
> by NTP (or similar time synchronization services), it can
> experience significant jumps forward or backward. This hinders
> the precise latency measurements that PTP_SYS_OFFSET_EXTENDED
> is designed to provide.
>=20
> This problem could be addressed by supporting MONOTONIC_RAW
> timestamps within PTP_SYS_OFFSET_EXTENDED. Unlike CLOCK_REALTIME
> or CLOCK_MONOTONIC, the MONOTONIC_RAW timebase is unaffected
> by NTP adjustments.
>=20
> This enhancement can be implemented by utilizing one of the three
> reserved words within the PTP_SYS_OFFSET_EXTENDED struct to pass
> the clock-id for timestamps.  The current behavior aligns with
> clock-id for CLOCK_REALTIME timebase (value of 0), ensuring
> backward compatibility of the UAPI.
>=20
> Signed-off-by: Mahesh Bandewar <maheshb@google.com>

LGTM, but let's wait a bit for Richard ack.

@Richard, could you please have look?

Paolo



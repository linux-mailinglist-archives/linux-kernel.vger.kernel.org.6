Return-Path: <linux-kernel+bounces-244807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8DA92A9C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52ECD1F227F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87114D6F9;
	Mon,  8 Jul 2024 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HO7uKd9u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D614AD10
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466685; cv=none; b=jmRtawoL0Use9ASEncAG0WqMcWPREMhfxsDqNnKYtf/BZ6VzjMdrXydbBQX6C3GGSxm43c4p1YdnaRrZR4Zqi6q006RZ1TYxPZWpiFlzJi/pLW72zRE7C1Rjcgxcrd+tIKLiYWdEEB1j4uWnlx+2OYGmsyjMUeKMOagpJtO+/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466685; c=relaxed/simple;
	bh=esUHA7YqelnRIjhjJNwGHNiw6iHbBK0FPgjKF0ZFwLg=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1mW1KlNClBpCn9lKC2efEUjuvAZi7NcdikFYA2B8+7AxpTKLlDnbJwfKHSVOx4wfl+n5HMPwNX2zNqbypknX/5WBwT5cEvlvBWxsmrs456X38wOkh+Ruus9XOLQ9odcTb8AaYVZLybG6Y8HZ8s4fulaD5BivgRd1SPWn5HdbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HO7uKd9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720466683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LuYwWDyVZ0vRCoqz1m7vBYFnvowimcuILsFlMzl9hOU=;
	b=HO7uKd9uFjYBupcMcaYT34iREkZj11DjFKwlnnnnk6nKej73vIaGpQPDsmZ5ylDR1pap+A
	TMJA72WEyz/gqCvpeMNlhLOx3bfqfMrMAzYYLLtVKN6BmAgoKjwMxPHV1mRpP1BoFfm6bt
	S4ZaZ9cKglHuxd05i/rQDDhhE24wMbo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-9Tq86n_2NrSLvPtVNTqoiw-1; Mon, 08 Jul 2024 15:24:41 -0400
X-MC-Unique: 9Tq86n_2NrSLvPtVNTqoiw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5f37aae55so41509336d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720466680; x=1721071480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LuYwWDyVZ0vRCoqz1m7vBYFnvowimcuILsFlMzl9hOU=;
        b=ifinjgKujlp8XJVKxzFuDxL8DHCKi5mrTAoWiOgNlxdwbmsCmeaT9Kzjg+h6RaBHCD
         onHpw/qdwbDO89rEDoBMMuCwZz6oZP8LXO8Z8RLB6Zh3b6u9xWyX6DnlLAaFG2PekeJz
         s3AMlZaUkDij8g1lP+TH0p+ZPZBkuHRltZBpxnXcJ1Etx9qIb5IMESwOBWZ6TCraJkdy
         fKCqY39m6jy228dXS+jvkhoncvGCL9pLiKnLJsfpJDk3V5Z3EV618LZwGM6rQhy0otfY
         wg0BUENsdb7Vqx57VPeqTxmPFpUcLi9FVbf/GrWYRPCVnUVavG1Hu+fy/osa4sndPTQ8
         /8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUT3b2PFqQUmXpAgtnOr896iWgHaQMwLrdCYfwznYLNU0ueArSAveWa4U3B+L6NxPS65/jux35yCN4dB7LzjEi1VYHyD3oSeptyv3gC
X-Gm-Message-State: AOJu0Yw2yQvRV/fHJYfX1ayzxCB6MzTtBvfW8JPCXvXslmx8gZckpEfg
	LuLhoy/71dZcesq5Izz6yr3zsPulRt+3UTme3zBXc4j81KxrkhkPv13UYQ7Rzpze6ZlLR1QWWNs
	YD5uBz+nBhyBytkTV5EEgmBX9nnjrJrDooIhlw4m14f4rWKAUcvxIdEjOo6O6hYXr1IVNfNd5+/
	khpNpfp3bOrzmC4O7xS7pxjy/nuh2UMCGs3dG2
X-Received: by 2002:a05:6214:48e:b0:6b5:e2fc:d5c6 with SMTP id 6a1803df08f44-6b61c22cc31mr8614226d6.61.1720466680564;
        Mon, 08 Jul 2024 12:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjBC9F3BNRZrjv2Kz64U1umj4qHEyyN/HuOLhjIbvplQlAP5m5LIbBFIXsZHKpSPpXldXTReEQ+spKQIXsCo0=
X-Received: by 2002:a05:6214:48e:b0:6b5:e2fc:d5c6 with SMTP id
 6a1803df08f44-6b61c22cc31mr8613946d6.61.1720466680196; Mon, 08 Jul 2024
 12:24:40 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 19:24:39 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240708134451.3489802-1-amorenoz@redhat.com> <f7tzfqrn3ha.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7tzfqrn3ha.fsf@redhat.com>
Date: Mon, 8 Jul 2024 19:24:39 +0000
Message-ID: <CAG=2xmOMHZf74NqRtS1zhPpNNcWKdgqns3ivW2kqX0pq0Y31XQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftests: openvswitch: retry instead of sleep
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	dev@openvswitch.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 02:27:45PM GMT, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > There are a couple of places where the test script "sleep"s to wait for
> > some external condition to be met.
> >
> > This is error prone, specially in slow systems (identified in CI by
> > "KSFT_MACHINE_SLOW=3Dyes").
> >
> > To fix this, add a "ovs_wait" function that tries to execute a command
> > a few times until it succeeds. The timeout used is set to 5s for
> > "normal" systems and doubled if a slow CI machine is detected.
> >
> > This should make the following work:
> >
> > $ vng --build  \
> >     --config tools/testing/selftests/net/config \
> >     --config kernel/configs/debug.config
> >
> > $ vng --run . --user root -- "make -C tools/testing/selftests/ \
> >     KSFT_MACHINE_SLOW=3Dyes TARGETS=3Dnet/openvswitch run_tests"
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
>
> Looks like this does resolve the issue in question on the -dbg
> environment:
>
> https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-net-dbg&test=
=3Dopenvswitch-sh

Nice! I guess the 10s global timeout is enough for now.

>
> Thanks Adrian!  Also, thanks for including the fractional sleep.
>
> Reviewed-by: Aaron Conole <aconole@redhat.com>
>

Thanks.

I just realized that I've missed the target branch ("net-next") in the
subject. I'll wait a bit and respin to fix that.

Adri=C3=A1n



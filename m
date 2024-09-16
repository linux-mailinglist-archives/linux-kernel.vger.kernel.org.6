Return-Path: <linux-kernel+bounces-331053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10C97A7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D5BB29FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8015D5A6;
	Mon, 16 Sep 2024 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RwutoFQB"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DF15921D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514767; cv=none; b=M84U1xG8B5tW5KNPYWKOKpYkfxkii9UridMj4ioJzwlTPghXvwNx2bg3fSCyZkT94mIfNim6PcFo5aP0zifmrhYgNEcO3m3rfigIgFWzxs3574nwJCMU8NfRyJyF1f3cQabicA6rHcZ+9BCoIEl7BPEer3NclSbGAc58kOdE+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514767; c=relaxed/simple;
	bh=6hVSPTDjjuHtlG4ysrsJ7KI3PBSfKbhOd99YqQZc20I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fT5hLxBYBYEOEr8KcycUGIXVegL7n5JRBp7RkGMpfWMwoxdR1xQMMRmHziAR1S6yAyRqAgObN0Huky9iwY2xDDKctC7VCnJ6C9/n2o1My90pv11OV7X1CV0VfxR5zyI1FLQBUZ3ssPlN/IacheJw+c9kH69T3tQpGcm6Ym2JfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RwutoFQB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 868D13F5B3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726514763;
	bh=6hVSPTDjjuHtlG4ysrsJ7KI3PBSfKbhOd99YqQZc20I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RwutoFQBjOgt8EG0KDRjJWROcOwRbywBMzunHY5G+LsLOyld8cloq3E7gRxCzBsjP
	 gQfBhF24//eSxdTvqMXYE4FXoeZuKz3zj+mkfSt7ZfVpjiKFFs4KdHtj/wB2qw9GSV
	 vyXwJiV2b37GrAcc3PhF9LE9Pm602QOWy1CtDzU/xgfYd2QOnof2Q7rykJ5ThTJPDJ
	 W3ZoZvV+3DB/3zoE9O8Te+WU4qoVn01z7ADeq69aNi/5AErbojW0XHo6lJA52EB0pl
	 a0fe0qRVf05W1gZAfw5l6NFJM1RYhbK4lL56z/u7zsDES+k2uZ8gEEJXrvgpfwsBoX
	 EiweWED3ov9Ag==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5365c0e2eafso3651897e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726514761; x=1727119561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hVSPTDjjuHtlG4ysrsJ7KI3PBSfKbhOd99YqQZc20I=;
        b=Ay1Xys2kSQVPuZ+qfGFecfaQTbQH2hicbohCTc2jl8QfAVqndZcdeC8PtRVIxcln/5
         LeXSkWEV9ezJ4HMUVSKYc0XBOQRvGy43QX7dgnJON+eCXLCR9zroNtNnn5/q2GqnnV+a
         p61bgX9GVaPgU9IsrndWtddeFWEJwZF/fO1YHsd6LwQOEb5jUYHRowp5+G02Ccd1e3To
         SURfS1b8K47zd1r9E28/+1pX2VUDF5pwj7vDYSO8SMy25xCXN46wQ+G8Ti8puZw5rIOv
         uDm0JuSHFrhlEZroyKHsY6YmhXayQ0L7+e6e8zabLY6eDUcbp/KkWz4lZx58SLnb1qP9
         FGEw==
X-Forwarded-Encrypted: i=1; AJvYcCX1KH0wvXVE6SRe5PxXXXKLPo/5bNHngrSd7CTVGMZZEBE1GEtApsooEvCrDRu+huaHAtD3EqBcj+vOhQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9nOlWAp1efmXHNQtvBKgxeuWu430KJm6XG7DvJ9fAk8VWeck
	ePrpGhRkV+Oj5W2ivMNGAxnoXZw8XA9fP3dRTHq8+VZ1frhb077uZ01pUNc1bohcO1KPrAMZG/o
	dpW7cOqZtmvfp3jrPy9kU3eg2dQZr9lFsosCRlhGPxE8ih2ntMOpeuZWNxPHbzxlYKTzUkY6g3j
	TIO5X7Tfom7VLY+f4LIQSiVEoAja2bHUjP8bBDbKVCx6CttbulXVj1
X-Received: by 2002:a05:6512:1193:b0:535:6cef:ffb8 with SMTP id 2adb3069b0e04-53678ff321bmr8869775e87.54.1726514761302;
        Mon, 16 Sep 2024 12:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9iFAn60gqVCh/eEOClq/2Ao2PKM9BHijjCnoTeeccANQO3dg8hkcL8qWA+1JKf+BkzHLG8xBIVMKN5qLCNCg=
X-Received: by 2002:a05:6512:1193:b0:535:6cef:ffb8 with SMTP id
 2adb3069b0e04-53678ff321bmr8869741e87.54.1726514760012; Mon, 16 Sep 2024
 12:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org> <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
 <20240913115124.2011ed88@kernel.org> <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
In-Reply-To: <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 16 Sep 2024 14:25:49 -0500
Message-ID: <CAHTA-uYxSzp8apoZhh_W=TLFA451uc=Eb+_X4VEEVVZNGHaGjw@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Linking in this thread as well - I submitted a patch to net-next with
a reproducer for just this bug. It works reliably on Grace/Grace on
v6.11 (and prior kernels already known to be affected), but I have not
had a chance to test it on other platforms yet. Let me know if I need
to adjust anything and whether it reproduces the bug on your machines.

Patch w/ reproducer:
https://lore.kernel.org/all/20240916191857.1082092-1-mitchell.augustin@cano=
nical.com/

Thanks!

On Fri, Sep 13, 2024 at 1:59=E2=80=AFPM Mitchell Augustin
<mitchell.augustin@canonical.com> wrote:
>
> > Sorry, I missed that you identified the test case.
>
> All good!
>
> I will still plan to turn the reproducer for this bug into its own
> regression test. I think there would still be value in having an
> individual case that can more reliably trigger this specific issue.
>
> Thanks,
>
> On Fri, Sep 13, 2024 at 1:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 13 Sep 2024 08:45:22 -0500 Mitchell Augustin wrote:
> > > Executing ./pmtu.sh pmtu_ipv6_ipv6_exception manually will only
> > > trigger the pmtu_ipv6_ipv6_exception sub-case
> >
> > Sorry, I missed that you identified the test case.
> > The split of the test is quite tangential, then.
>
>
>
> --
> Mitchell Augustin
> Software Engineer - Ubuntu Partner Engineering
> Email:mitchell.augustin@canonical.com
> Location:Illinois, United States of America
>
>
> canonical.com
> ubuntu.com



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering


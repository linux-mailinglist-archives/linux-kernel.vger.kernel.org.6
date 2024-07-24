Return-Path: <linux-kernel+bounces-261099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D7B93B2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DAB281BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF7B15AD99;
	Wed, 24 Jul 2024 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxYuNVMQ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97215A86A;
	Wed, 24 Jul 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831912; cv=none; b=H2Yjyxn8HJBeDm+fm4smTRMLA6fFwWCoeFiUltOXdtwqHlpZLFcPE513e7fF7a4tXtrJ9Ry1K5QRJcCbnz1VuW1xTxyJuHSb2gYhch54Xt4ddE+7R6hozdYqwQQ23F53QOJ8/inNYwakdk83O7SDPWBT9gKExFVJ2UU3iZVDkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831912; c=relaxed/simple;
	bh=l9XbFL29fFYp113Wob6+1cBWchT/C8JVCwn7KnQn2Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvwBu5BSin3B5CyWzULA3xHpCrraL7EVBG8V737uGswIPA01uvf6zj9IkCHcWo/OKTH7z4tdImr1wl6gdEW7/ehmLvv9LIDi0DSv8OwKhT1YGCTrV99o27vWiuwSBc+1YF0ZRTLz//2OgfCTwSsFe+SknPubMEdfxETeGHTYt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxYuNVMQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a1d48e0a5fso1236851a12.3;
        Wed, 24 Jul 2024 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721831910; x=1722436710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5YfGNIlsO/NNcdOXqpqBk0T6w1npLT4dQ3KtAyVFgQ=;
        b=PxYuNVMQrWn46rluwHbYfz812DdWggZwLCZJVCliOqRfzSNol1bLt9Widv2WxNUIZT
         zmkWP4guqWPdSmqxb+h2twhxjkoFYWSecE0apBpM+sk2LWZPt9ils5KOtoRHReVpFGcP
         Ry8cc6ivX6ZJuHJv+csgNl8ceVsAAIxnoDYpa6P4FJFKS3KX+V8xJK4pO3CsAJf5ZpMC
         8sDhy/xhG0uRNfpfi3jjfLOBLHWyzlWwK3drSEVe0/xewnx7o4MX7JSeiXHkg2+ovj/R
         sp6x9EcYDEGKJZ9UI5LkjqM5nyA8EUdLgboqaCOGf8bzDpMVYrbX1+W8pl64kUHaaOlm
         4QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831910; x=1722436710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5YfGNIlsO/NNcdOXqpqBk0T6w1npLT4dQ3KtAyVFgQ=;
        b=SDk3Vnghvj6hf/IB3SWGQycHR/uMy5Nf3fsJ+X3A7u16CE3aBNH0/5ze3ZWcluWdku
         pdR/7MQyLCfO6neRZQcr1XRIaiHoS9iL/USMsSLNLM8xhdd0jRT6LX+hab9kvDO1yDPj
         VvbPfSvwRZOsdhQGhJDocmgKw/GNuEcLK6RPuqyS8OD85NnZdN4c4Ru+56ZXJ/bJg1tu
         Owyv4LHK/mN9luXGSoPPmHrmMEWTOXRRwnAxpyzqGxQcic/JZrotU/1sQ3r5ttbVpPpQ
         nDm6IJBPA/CV/cGvQSqXNSqkfmuIO3iJL6KmGFxicGzgvEWFjD3zVHfO6qKJxMT4VOe7
         eUrg==
X-Forwarded-Encrypted: i=1; AJvYcCW7IEWhMQUOo8Zk3ODrGG8vFS5HZL522h6B/jx87o/kYU0HWIifa1/006vkJXCjyn2d394uo0m+elU12AKf9NqXP7RV4qtaWw0rW6MeEs5k9Pf5t1xSSG6j62ajVM0MVXTchw+5MPPX3UKlGGI=
X-Gm-Message-State: AOJu0Yx28NlOEX6ZBMB7mh0VOnSUg1OFWow42QKfIgE/gdrxYUlzucYD
	wwFa1+wYJCc+AlVBokZ9r+n9AIpXBCfwc8/ux+4l0xybLhjSLbMNBtg3pMK65Y1EESeNiSOy+rf
	YRay/wrsXDY8AdX031wmj506PjqI=
X-Google-Smtp-Source: AGHT+IHkhoNnAUc5XxPmutCwvMdnvpdALQYON+aoV564xC4ii1mPdF6qwNMOsDonPZyJGvSXrQCgN6VolR2UrakMRW4=
X-Received: by 2002:a17:90a:ca86:b0:2cb:4b88:2aaf with SMTP id
 98e67ed59e1d1-2cdb513f24cmr2794532a91.12.1721831909978; Wed, 24 Jul 2024
 07:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com> <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <edda856e-3102-495a-8cc6-b79f5f114833@arm.com> <20240723180642.73502856@collabora.com>
 <6ce8fd12-b175-4a8f-8ea9-6221a555b69c@arm.com> <CAL_Jsq+Dr5zO5MKEGq0dW9SuTuawaJMhHziFd73Ef_S1zbOkXw@mail.gmail.com>
 <6b60a83d-8416-4cf8-b373-dc3c697c788a@arm.com>
In-Reply-To: <6b60a83d-8416-4cf8-b373-dc3c697c788a@arm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Jul 2024 16:38:17 +0200
Message-ID: <CANiq72=AFLogwowqhi-hwYT1UcnQ+6kidg2Ni-Q0vStKK5wuSw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
To: Steven Price <steven.price@arm.com>
Cc: Rob Herring <robh@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org, 
	Danilo Krummrich <dakr@redhat.com>, lyude@redhat.com, lina@asahilina.net, mcanal@igalia.com, 
	airlied@gmail.com, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 3:54=E2=80=AFPM Steven Price <steven.price@arm.com>=
 wrote:
>
> I'd be quite keen for the "fork" to live in the upstream kernel. My
> preference is for the two drivers to sit side-by-side. I'm not sure
> whether that's a common view though.

It is supposed to be against the usual rules/guidelines, but we asked
since it came up a few times, and it can be done if you (as
maintainers) are OK with it. We have some notes about it here:

    https://rust-for-linux.com/rust-reference-drivers

Cheers,
Miguel


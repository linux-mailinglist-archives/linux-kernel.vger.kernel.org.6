Return-Path: <linux-kernel+bounces-533041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A77A45518
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E72B189C97D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EB2267AE3;
	Wed, 26 Feb 2025 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLeRR71E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689719992D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549052; cv=none; b=eS/D0rc+Fe7j0LN4fLc22vPx19gcwKM7otcPCVI0hQO+toRCNXKmLzdW7s+ACXRia5DJSbt/1kj+J7oOlFN6J3i1szGFrMZoQUZSdCh3znj/dC+oSv5q7Navm4rU4G2+tU63R9DUbzRTX8EtfokyEB1t7VMyRo04l1WkxS3stus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549052; c=relaxed/simple;
	bh=JRAxpAQrEbJwqIyAh6i6w+gxXoH/ajvwiS7GcAnkB5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noYx514SPVHttmtN0TtRxJGKZ0CsAVX5jS9mE4bIRicr5GUI5q87tqSkaJZ+XIiVoSLL/7lSnEDSsTWk+qH362IWdx+u1qXQXvqLd5hkQV4FBZvfjZMS1iht55yll19CAqTyaE05CJN6uP71Qdi+TVud4uBTGeAs0lUujb8SqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLeRR71E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740549049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2JCmE84dOZ9F4zm2JOKCFpogjriwu7XSzK3ady9Cc8=;
	b=gLeRR71E3+uVhKaFLLygGzFmY6wzs6+9Yhfdwzh/HGvQp+Yr9uDDiRU8CBdn58KmUeBGmT
	tIHaFI9ZSYyyt82P7ZqILHWT5Mc4GSkJ783vM6pZB7nBEX3/dG01H8VNwp54KNbThjbpfk
	Tl9iRPiPTfJdxppe4X1fe7YEMfvhNjw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-FX3mmMQZPqeLkSyWTCzlGw-1; Wed, 26 Feb 2025 00:50:47 -0500
X-MC-Unique: FX3mmMQZPqeLkSyWTCzlGw-1
X-Mimecast-MFC-AGG-ID: FX3mmMQZPqeLkSyWTCzlGw_1740549047
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2217b4a48a4so125866465ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740549047; x=1741153847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2JCmE84dOZ9F4zm2JOKCFpogjriwu7XSzK3ady9Cc8=;
        b=Dx9rMxwwxbJYmuonujYif3gwnsfjU9lbD90TIFSriE9u7Vh96bT1/tXl4jBFLRycIs
         X2D4Gh+SOEMT28Jz0XmVq+XZkW9CBt+HiRilm2E8gQSpaNxmz9a7w3lypBX0ItutRQcQ
         E0I9fn4tqosPw8boWeRIid8f2coaSBkruGme1172IiRvhautQiXOuO+6G2YNZ0koFneA
         pzuxIAGXZhl3JJO/aZRSABycEuk+HN2WT9P/7f0GsM5MM5jGB8RhrrZtTtM2GwUpdI+Y
         ZVwjuDRKXNagpaZwOYZ4RPejS5EuVAcUnVf8N+vq7aR4+9h7upboM7V8Ku3tW+ztMVxK
         yG/w==
X-Forwarded-Encrypted: i=1; AJvYcCUNC0jOKRazztJz9z5ti9oEek0PcABY7B1bTtNvKl85xl+mUC7yVzxy3wSZ3/5A82xbcqfZAXsfWJ2z8ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEq+6QRJDpQCpB+nn5KyWLqux2uAS2j9Zz4aqngDUQgpwnDZ+J
	SCDYLkenKpvW9XslBL0uYT+2tyNgocpuu1xyK+zESMq/7HBKfL2DKO563gGlTqQnU7sH9+7J2PE
	A0otCTXDkHINpn9SFNEXGKDi4RacHIwDVvXlTEGRigkBTByb+rtAb9EGmVgGZyE0fs1K06we39+
	SiR6QLUqk9/McIwKp3YmQ9E5Z4iP3S139JXVA5
X-Gm-Gg: ASbGncvMPrlD3R3BNZH0u+nl25PdReAtnYmwHJfXwXdtegl22nLSmq9ECBiqtV5wkb1
	T40mUUOP1NW5tmNR6E7Sg198NQwqLQxPazbiSOPP1+HBx77kiwst0lgGaycpKW87sPSfJEPURZA
	==
X-Received: by 2002:a17:902:cf08:b0:216:2259:a4bd with SMTP id d9443c01a7336-221a11d9943mr298091985ad.52.1740549046789;
        Tue, 25 Feb 2025 21:50:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECh444EkE6Nz3Uz5uJCmB1zuBEqfrsqG+r0rDiqkwFHGA43cEHXyVheME6ykNXCP8bLGlcr8CKOUqFZzbAmyA=
X-Received: by 2002:a17:902:cf08:b0:216:2259:a4bd with SMTP id
 d9443c01a7336-221a11d9943mr298091625ad.52.1740549046365; Tue, 25 Feb 2025
 21:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de> <20250224152909.3911544-2-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250224152909.3911544-2-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:50:34 +0800
X-Gm-Features: AWEUYZnhZpWgW-fFWdFc8tWPsD-KgXUwmqhpIcK7wUNua2DoMvlQqYulqScigdE
Message-ID: <CACGkMEuUcz32QMyG2XsupFhNKGozd4Tr+WD=6FKpmHzvD0K11g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] net: tun: enable XDP metadata support
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:29=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> Enable the support for the bpf_xdp_adjust_meta helper function for XDP
> buffers initialized by the tun driver. This allows to reserve a metadata
> area that is useful to pass any information from one XDP program to
> another one, for example when using tail-calls.
>
> Whether this helper function can be used in an XDP program depends on
> how the xdp_buff was initialized. Most net drivers initialize the
> xdp_buff in a way, that allows bpf_xdp_adjust_meta to be used. In case
> of the tun driver, this is currently not the case.
>
> There are two code paths in the tun driver that lead to a
> bpf_prog_run_xdp and where metadata support should be enabled:
>
> 1. tun_build_skb, which is called by tun_get_user and is used when
>    writing packets from userspace into the device. In this case, the
>    xdp_buff created in tun_build_skb has no support for
>    bpf_xdp_adjust_meta and calls of that helper function result in
>    ENOTSUPP.
>
>    For this code path, it's sufficient to set the meta_valid argument of
>    the xdp_prepare_buff call. The reserved headroom is large enough
>    already.
>
> 2. tun_xdp_one, which is called by tun_sendmsg which again is called by
>    other drivers (e.g. vhost_net). When the TUN_MSG_PTR mode is used,
>    another driver may pass a batch of xdp_buffs to the tun driver. In
>    this case, that other driver is the one initializing the xdp_buff.
>
>    See commit 043d222f93ab ("tuntap: accept an array of XDP buffs
>    through sendmsg()") for details.
>
>    For now, the vhost_net driver is the only one using TUN_MSG_PTR and
>    it already initializes the xdp_buffs with metadata support and
>    sufficient headroom. But the tun driver disables it again, so the
>    xdp_set_data_meta_invalid call has to be removed.
>
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



Return-Path: <linux-kernel+bounces-520842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B4A3AFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C033B0E95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A751A8F7F;
	Wed, 19 Feb 2025 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhqPCc3K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD715A85A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935079; cv=none; b=QMaa5gXwh0xlkYFnesDVfMnH/jsezKWdemSCW/JXOXmvppu/dIMLSXC8L6WM/3eYAEy8sHGt/DtwwcaQRBQGDdkL5v9jPn9exXMbwlNXn70guvW+JkN2sjAf/RKlXKHoZFJvI7K7BZNhnKJjx9zko1cggiZ+//FlySpgbvrT8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935079; c=relaxed/simple;
	bh=AXiI9tXfD/bRXn+8Y0AETb2ngSu6A5KTjMGOKhztDro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwhQFQeQEDjfhucsqc/WFt/mnRx2W/MYFR2+Oe6VViQDz92pjM9sbTEjmVEMmxtVTr0Yc2ku1XL9R92MTRcRMtDVMCYunJLECIQ/pSdZk+tURqNrWy16WKH8wBJzeX/JsiRhy3hoqaN0FMs0zgRVnmmzB39VG/swwpG26uJXcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhqPCc3K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739935076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKadPNxi6muCmVb//eXomLPYTLJo7paJFVc00B3IJME=;
	b=MhqPCc3KjN/9IXEEKoKRXL772m547JDHmTpAV3VoaKkPJQZRxe7KEq2NApT8eOyshO0Zet
	Nh9NM05vE3aKgxNp+lkT2vsQjXJ6e6amBE5BmJAnEs40AM3j7Syk/wIqQXDjHTJAxB4QR8
	Ry/HkkXK3k1NXUfCDrbh0YCDEsreNK8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-cQWJJrEtMFeNUy1QF4GYQQ-1; Tue, 18 Feb 2025 22:17:53 -0500
X-MC-Unique: cQWJJrEtMFeNUy1QF4GYQQ-1
X-Mimecast-MFC-AGG-ID: cQWJJrEtMFeNUy1QF4GYQQ_1739935073
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso19941134a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739935073; x=1740539873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKadPNxi6muCmVb//eXomLPYTLJo7paJFVc00B3IJME=;
        b=iWvYih0c8y0joh+rYcPrviMQad5gl7F08FyVeMVZCQQqnvxiMNo38E49lm5z7IPRxJ
         DAMYBW3Wc+n/8BmVDQrKvpmfzUPaTFlE9a7QGSjbx/USZM49Gn2EO4imTNv8wTdoE7hq
         AbMJgQQBaaIi5niRqkWaRY9DQKoeTKUnAu6zyTfu5eE697r5wuVpM0sZsPHmg5bsBT+b
         8bYRZKDQzhKqwReA+yH03A/qXLtE3NOXc1eDhTHeF75ypveCUcjFn9x2PnLUNGodAyLo
         LAnWMpvU71ELKVq0UsTSQOjVCYELMWt2dB3kOXNZAjuPZ5GAzHdMZO8BgvyVnt054jKd
         Wsog==
X-Forwarded-Encrypted: i=1; AJvYcCVDAOUu2yW+r4zvvWyTEBNRC7jYmGYz2JDibqEi8Zam62OH7zRznYRiaVki0n53UkQPxJtmFq+xqWhERj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRkZ6ytzPs9cLtd3gdORsSvVIQZ8+xAQ1MiOLtISURwHnjhNB
	/+k14/fLha9mKhH4iIZp4SXy13wq5T0YuUNC13IsfifNgQY34qnMrnO+ioIYnm7XnwqGTtBfGmb
	UUhvsPYnalh9TYosSItPioSjHdsW4TDcJmmlElT0SgeHdkSgraEImKsyC/n5IjpjZbSupLWFUN2
	1vaMQ6ALWfGbdMJPLENHIkPW0GGa75Tqws0+tp
X-Gm-Gg: ASbGncsK0yh98fJ/P8300Rhzd9h4B2YeejlsKHPJkEpUyUlxuDCACgGHmrwP7qHzNAr
	rLU4ouUlC+it+cWqGc+8wll4QdJxhLRa9ii4Yvxb3jQKCPNbAD4Odw/iE6snN6l4=
X-Received: by 2002:a17:90a:f495:b0:2fc:a3b7:1096 with SMTP id 98e67ed59e1d1-2fca3b71328mr6689791a91.27.1739935072843;
        Tue, 18 Feb 2025 19:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6PN3buhsj4JUJy+Dzc+p8dgfIJT6zMzIfOOj/oagvGFTtsM5768bTiKiPfmJPIJEOxIzO0imrO6+0oAlHP4A=
X-Received: by 2002:a17:90a:f495:b0:2fc:a3b7:1096 with SMTP id
 98e67ed59e1d1-2fca3b71328mr6689759a91.27.1739935072464; Tue, 18 Feb 2025
 19:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de> <20250217172308.3291739-2-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250217172308.3291739-2-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Feb 2025 11:17:40 +0800
X-Gm-Features: AWEUYZmQkycRwSOsaFbHJhebPYbtJJ3xrSXwIHRYXHCed3Hqat2E_8Ie-BS422U
Message-ID: <CACGkMEu0amsUNZS_EoJc40B=av90OJkpivDw3vCWwYJYAB68kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] net: tun: enable XDP metadata support
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:23=E2=80=AFAM Marcus Wichelmann
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
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



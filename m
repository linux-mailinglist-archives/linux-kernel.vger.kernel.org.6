Return-Path: <linux-kernel+bounces-517452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D481A38103
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BBA7A630F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D848821773C;
	Mon, 17 Feb 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMxQKzGr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A8218585
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790016; cv=none; b=frqzBuGrt5pHScnuAZtQ96il0T0bs7LGKixb2MUE5Br0+xmLkQY8uJzC/MIIwrfOJv56NmbUKrVZ1SafG5MNd0zHp+FMAbKO1f+B6y/6Yon/NcuwdUFlnPIRzk35c5bWEy84AsUHYOiBlSlWkdV8eyXJQyAUhNdk7+w6ZZSgmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790016; c=relaxed/simple;
	bh=dR+rep/57L3EWMjPfigCxhlyG9swRKpij/Px8i1KymU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omfmcFOXYSE/g1fHMug/caHpmafkr5qnyVJmeNHlMDO9W8a1m3T5nG+JsQyVkjGUsyFC4zmAw0QvnO2b2Pzs0t3Lds0FP6Nw5xLZq47riuOmG4uFvhSuuAxKmULAVL2rauhLBoG6fgRecZOGK/gqPsbHrVFENFv0dMpkf429oGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMxQKzGr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739790012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqQYFCaTchuW6lwmeMd3sJwEjkrnpuASKdjJ1fvZwRE=;
	b=XMxQKzGrFzfPk1/aGeIeIuJrV9hPxGsKIrf85yOIn4b8JR1fE7QTrXH1ZYCcxI8UduP34L
	4xQarnSPn2/xRcMh0CbLruipE+NjLCcnQyO72P4heInOo6WP6Cd5zq0bbbltC6RCBaR5IG
	d4Q7nygeIZglRXVzwFiJH6rLDBRmCAg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-MBnihD0DPNq7FgqQe6sdIA-1; Mon, 17 Feb 2025 06:00:10 -0500
X-MC-Unique: MBnihD0DPNq7FgqQe6sdIA-1
X-Mimecast-MFC-AGG-ID: MBnihD0DPNq7FgqQe6sdIA_1739790009
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f44be93a8so418444f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790009; x=1740394809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqQYFCaTchuW6lwmeMd3sJwEjkrnpuASKdjJ1fvZwRE=;
        b=idnOw5sT6wjdwOdP3ZHHBCNGwnHGqM995Uu3dqDdIctkC5Vfo6+1oiwhv9l6ZOQjiP
         5oSCbznpdM20a87yRtyGRXCXh/FcJMFMmrcGGdsEwZFcvbHuK5hBQLP0AEtgB7KbWiKM
         DYyb4bq7dwaMQlXaEDKJqUfsorTQnzfM/HP1qWn5eF+8KXDUmIayFdkVF5OCuEJ+B5Aw
         T0P35iGY2r4b+z2ofP4mjfdjTE7Unw6yHhD+33qjLr1XsQyGI8danITDt/LOo1G6v5LR
         Td5PxYyiW3QvXhdFMWSmIzdZE4HO+XMPNZXzZzG8HZX/3JYfqVhBGOzcKjCkeaVOn+0l
         ccuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlVVwDwmEtpzPNcxq+y44to4LBTVgArN6MASluRu6nggDNj+VETl6iP2BBCh2tsaaFSKOgladZ+o+087w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIcxieqVeB6KJhgHUzUd2eaWRiD9TVcCSrqn6WUKPbfDJxMXt
	bXJP1SDp0d6PsHtltL6pgByxT8cGiepT1TLGCwNrOFOioMzIjnLrzyRBoFZX6JcDIJ/JduUCSKh
	cTKPWFKe2pIGoB7X+lfCFH5p8ug/KKt7i66TIF/0zRhAWMwTpJaVYqfrU7rxKAg==
X-Gm-Gg: ASbGncspmED/dnum7Kj1q5JkXdU1WsSKwe1I/268hoYh+yHNhES/Ilt/mHmYP0H9Pvd
	wqEntazYoK5DOTHsVur+9h3ZomUgMDPPdW9FxMrfQW6T7WkwaSmhgIdSdWhcqnCyymwLBeTCnQB
	iJCOYG0/Xpy0uKKd1wp8DGXIWmzTIfY5oVVWF/swJfuOUX5Y850/OYslGZBTKSK4oBxIdCw7rS6
	aF2AQoQdQaZQ8dXbl1RK3ZRouYm17wALQXOhj+GI9Ul/LxQsTicODIeTlrWmPpdmbp4J9P6S01u
	Ssr6/ke9nYKCx2BWUKxG0GFFJqWfThQzALDNDC04Hbv7UrDTzqULZA==
X-Received: by 2002:a5d:6dae:0:b0:38f:3b41:c944 with SMTP id ffacd0b85a97d-38f3b41cb92mr4017220f8f.11.1739790009186;
        Mon, 17 Feb 2025 03:00:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfTNMRvG7FzvFEHCD6J1+67oFasR/KEYRPfOfLOQYRJI8pdpwKgXLv4Rl4Qdj++N4APKt7UQ==
X-Received: by 2002:a5d:6dae:0:b0:38f:3b41:c944 with SMTP id ffacd0b85a97d-38f3b41cb92mr4017163f8f.11.1739790008461;
        Mon, 17 Feb 2025 03:00:08 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5b40sm12047690f8f.68.2025.02.17.03.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:00:07 -0800 (PST)
Date: Mon, 17 Feb 2025 11:59:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/4] vsock/bpf: Warn on socket without transport
Message-ID: <ygqdky4py42soj6kovk5z3l65h6xpglcse4mp37jsmlm6rjwzu@dcntngtsygj3>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-2-994b7cd2f16b@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-2-994b7cd2f16b@rbox.co>

On Thu, Feb 13, 2025 at 12:58:50PM +0100, Michal Luczaj wrote:
>In the spirit of commit 91751e248256 ("vsock: prevent null-ptr-deref in
>vsock_*[has_data|has_space]"), armorize the "impossible" cases with a
>warning.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c  | 3 +++
> net/vmw_vsock/vsock_bpf.c | 2 +-
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 53a081d49d28ac1c04e7f8057c8a55e7b73cc131..7e3db87ae4333cf63327ec105ca99253569bb9fe 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1189,6 +1189,9 @@ static int vsock_read_skb(struct sock *sk, skb_read_actor_t read_actor)
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>+	if (WARN_ON_ONCE(!vsk->transport))
>+		return -ENODEV;
>+
> 	return vsk->transport->read_skb(vsk, read_actor);
> }
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index f201d9eca1df2f8143638cf7a4d08671e8368c11..07b96d56f3a577af71021b1b8132743554996c4f 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -87,7 +87,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	lock_sock(sk);
> 	vsk = vsock_sk(sk);
>
>-	if (!vsk->transport) {
>+	if (WARN_ON_ONCE(!vsk->transport)) {
> 		copied = -ENODEV;
> 		goto out;
> 	}

I'm not a sockmap expert, so I don't understand why here print an
error.

Since there was already a check, I expected it to be a case that can 
happen, but instead calling `rcvmsg()` on a socket not yet connected is 
impossible?

Thanks,
Stefano



Return-Path: <linux-kernel+bounces-573137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BB6A6D371
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392F93B0E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040611552E0;
	Mon, 24 Mar 2025 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEyw/zzt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7B53BE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742788907; cv=none; b=OlqsvzuBPyz9XtHo1ISDtV3JbJw7VkJOvO4vE/iQarM9i84gfSohYOk0+ts/qr294Qs8xzY1NXPCsYYkHMCuz1/QTr/hRTcLAo/JYChJqHnjE03d5tgaSNSVZm4eufNG/9nKyodj42UHVYFhZMl8fSqGBkMCdFFWTi2Qhtisufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742788907; c=relaxed/simple;
	bh=CGSlvFYaKu2MQWRWu1e9Hm6aB6LcidbseISLkc9BRNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odMUqMgOzU1l/xhgHlRr/egjCktNhcJagnxiQ9Qx7M6LGlTXu/BR52gXnJmvy1jcSBal514EJgfND+mTWm+9oZJl4IYbRJJq0SIVNenkA/VJcbKr6rX8aFNTMXn8cDXQYfu6ebgfEfBfTrRA7P63QBiU4yMJjVQqcN2nIX6oPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEyw/zzt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742788904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+OhXmPoo0DLljAU0TDjoAu4m1RP6jxtWb9wetcQgFs=;
	b=iEyw/zztLouPWu9M842ApjmGz9+lACErNKQVM4qLccJkaVYtVCtU9waw0HukS1HhoNAOdS
	dTKJVqNSdIBXLZgD4dKRiUZ0PaLvBZFL/2AiNebwQiNUYcY2nCjap7RB8qCW7CKsSw3X3S
	VjRtY5sV9mUsAJVr2OpPT1wQLZJCiSQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-OPX_in8JN1m2SjK7xa0BbA-1; Mon, 24 Mar 2025 00:01:42 -0400
X-MC-Unique: OPX_in8JN1m2SjK7xa0BbA-1
X-Mimecast-MFC-AGG-ID: OPX_in8JN1m2SjK7xa0BbA_1742788902
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so4815312a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 21:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742788901; x=1743393701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+OhXmPoo0DLljAU0TDjoAu4m1RP6jxtWb9wetcQgFs=;
        b=vdR6NrZGz+bvrw3gMhZNOxARzarWaS+FpaXl3+nbjNqbUX8tT3Rik/SL4ePdQ21Qgh
         FPeZG7uUbeWFql1cRQxOTIxgvnMDzEfatU3GBB1Z3OFgOOROpfRt0Nf1hecf2/xxRnPW
         2Ym/B3biMceENM+JghsMUZsGbIHY72hOyNOSLrOfG0qybm0lfJkJ08DNAOW5YTVpQMJ2
         F9E7SFqFQeGrFGqjjuqADD4dzNgKcEo2x0EsejCmQyJv0VWcadrEAVAbU1wstVBCukGq
         fyJqXBU573P+wMWS/Itn1uc0ftVSuSO6AVSjI8jV2z9DS20W4vDYxWVwCygDx2jP2id8
         A5ww==
X-Forwarded-Encrypted: i=1; AJvYcCXXzp5Qu4oPjH62BiliWb8lAZn9BYSpDUrE3oNteLp1BpKnpNNVBU/E82pcIssIXzjk8fIMNPH02964tjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnwheug5aFUWHyZ3u9AFHlkFAM7zGwDi6+89vRO524OHTGfk6
	uJdbU5WRUWT8kjzDqqzBnskToppLq7WXdBRxWIgUnrl9Ql0m8lKIl0Ll9iMbqVtTJbyItccEKa5
	LQsQw25ogVhHu1oBMcJwonRgETojXoaxypbmL9xTA7kHKYcNpWkHDQ8dconMz2bieMpx8P5JKY+
	azByhuzO9zXkPQwR4eHz0zsVNZMbzp0fBRKql6MVzcsq2XmRD1SA==
X-Gm-Gg: ASbGncuHEy4vcw+Lgzzi6a5htuKLHEgLasNxF4+x6HFolfs20KXn88DeM1O6iPYtMQy
	uDmEzJgBWlqfI7qZuAAXvG3m+xZMiz9nRZ3MZm3Gvo9rpGnknYyUEafGWfWvMoTGKPsXp3DU=
X-Received: by 2002:a17:90b:4a45:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-3030fe56af1mr15735743a91.3.1742788900690;
        Sun, 23 Mar 2025 21:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtwyi1gJ0zaQFQsrBomqFHMj2VHAekCjI+gMhb1MAOqbuMYR3u5EZtG37zC0QeYxAC9WJADhULBbYtaVCZnck=
X-Received: by 2002:a17:90b:4a45:b0:2fc:ec7c:d371 with SMTP id
 98e67ed59e1d1-3030fe56af1mr15735694a91.3.1742788900080; Sun, 23 Mar 2025
 21:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com> <20250321-virtio-v2-3-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-3-33afb8f4640b@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Mar 2025 12:01:28 +0800
X-Gm-Features: AQ5f1JrJp4r4sxi_4HFviIS8ywunUbKIEpVHOsgca9dqLM3KIjeU47-OoEZtJNs
Message-ID: <CACGkMEvQr=cj2iXZTH8qwjByVcWwsAowOqpDy+n14sxyvQw4rg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Use new RSS config structs
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com, 
	Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 2:49=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> The new RSS configuration structures allow easily constructing data for
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
> for the command.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------=
------
>  1 file changed, 43 insertions(+), 74 deletions(-)
>

Though I still think hash config should use a separate helper, it
could be done in the future.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



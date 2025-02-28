Return-Path: <linux-kernel+bounces-538713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28571A49C40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34CB3AC361
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5A26FD84;
	Fri, 28 Feb 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVcn6z3J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF2A26E959
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753632; cv=none; b=Uduy73uviVigTon+8KWAzIUJ8I9K4Tia9g1g7kKjXWo/6gLV9uTc3NbtHXpo3S05zyOMLdjTiqVythI4ESr4Rhi9r2+lCFcD073ztTTV8pyagAD48gq2GR97LLUalnR2H2i2P1t2usd986sglpRPfBY3jrem7Oq1gOXH27QlwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753632; c=relaxed/simple;
	bh=vvamKXaXonTikm8G6IDKp730/CDhnoJ0Mk8W9T1Ok3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Czff6f+S91LUTxJ7zBUKLrwpjeT4ZA0ui/0Ypm8D16tHTbzCxPbDxmN8RIbBK8U81lGtFD5Aeqkka6uz88rF9BaO4PXvySYiBu/8Y30ql7r5lyLj60yQJ4/j/MMb28Bwbv+n1FjDyQhJVBKNVJovMUOXWGiHDuj5Tr+hGkyJnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVcn6z3J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740753629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roUwxiS7ulymLcFa2pyWvjdc3Ih5JRuvNyvUztd1mhM=;
	b=gVcn6z3JcRZWRskEt7X1f5GOFAnIJ37MARcvvtH2FJQNg8NfyXf1HQksltonaPNyiGeIsz
	9qTF5Dfu5cbtw9vD9XJmSvycBW+jkcQf9xWtKRMGul6K5jx0G6adM/0HMdJE6QJySrh6mg
	xb9+i8KjIZoUKFXjbjVeqE6XbVFvXI4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-MLYXloKVOKeRRXG91NXJhA-1; Fri, 28 Feb 2025 09:40:28 -0500
X-MC-Unique: MLYXloKVOKeRRXG91NXJhA-1
X-Mimecast-MFC-AGG-ID: MLYXloKVOKeRRXG91NXJhA_1740753627
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abb7e837a7aso251062666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753627; x=1741358427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roUwxiS7ulymLcFa2pyWvjdc3Ih5JRuvNyvUztd1mhM=;
        b=BlJhsO6iQJPdJIUSZzI1OMqVQ/S60O0pbOiGmxTb7sBw1jqI6H42uWCRujRW04ahmz
         2z7qpWCwJpOvLBogAgCUXzDb4Bt31QtfrLczaRomT5JRCk3BpuCrDNtWfPhUTcc3h+v+
         yoG6XjstfypDhocIIzR5tCwGwGBRiR/4G+k6jaS/jyKoMl6R3t77/YPGpPTaOh/0Z4S2
         QHGttk0Okb+YFRI6IiKlTFLfVnHBvvsYldTwg7hZ5iuRPPgHeSzvN0DoAHBTxkXVX+dl
         DHAswf9rW74ZiSoi4/+ybKx2ZrbIVGLz2s8YdA6S3eoo5/f6MQd8w8Zyy7bM94YMVNjf
         RqqA==
X-Forwarded-Encrypted: i=1; AJvYcCVEgHpr+Gpqo5d8kKM3GU9biLSTuUCaUliV9UN+D6d4HQtj2Pg5BQF9i4FTBVAr/R+KE0xJ2L2OTLYysBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhroELckLhhJ8ypnVCKFdBCK81Vp2dElGkqDlj7VfeCOA+K5n
	497LmJNQYGa0obMyyF8niqnf3kxD7VzJNyFSngucWV/UJMxfI+s7NDRkMQXaH7M9f14UhTD6ggZ
	sp/5I6E8/DB/EAYPcXVXeKVd7CuJ5VCwYyAkcyMgDPGL7glavyW4LpeeRplpedrFsrqcCW1SK3w
	dNZCHB3CabBU0GUVEWswiRGJoCud/0fniZqBQQ
X-Gm-Gg: ASbGncsX8qMm91F7A+J57ViG1dvuxa0V3Ew6rKgYM7R3QcEMnEo864EvkJV4sC9KniJ
	JK1Ctimj4Yk5BZ1djnoG6lQDnx8uGHHOrSl1On9EkTHl/LHCGz/NaU/NErGdtXvHf0mYM42B1HQ
	==
X-Received: by 2002:a17:907:3fa8:b0:ab7:e16:aab7 with SMTP id a640c23a62f3a-abf25fb677fmr319208766b.13.1740753627003;
        Fri, 28 Feb 2025 06:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPegDg6tPejCUZgBS9Oz611YYT0gOXJGrHO0Mf3Y3+5jBs88zw4q+EJl75v4x09O8dKVdC8oCD4tipkFYJN9I=
X-Received: by 2002:a17:907:3fa8:b0:ab7:e16:aab7 with SMTP id
 a640c23a62f3a-abf25fb677fmr319205966b.13.1740753626613; Fri, 28 Feb 2025
 06:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227185017.206785-1-jdamato@fastly.com>
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 22:39:47 +0800
X-Gm-Features: AQ5f1Jri6SSnIUB3TA8bZTF7aUJK_L13tJvV7_Fad3fng_j3YX1IbMDftxVWDPk
Message-ID: <CAPpAL=xpdFVfFMzU7qQM=YGJvEyhSPyUDfrt2FyWx61BJgHjMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/4] virtio-net: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, kuba@kernel.org, mst@redhat.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I also tested this series of patches v5 with virtio-net regression
tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Feb 28, 2025 at 2:50=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Greetings:
>
> Welcome to v5. Patches 1, 2, and 4 have no functional changes only
> updated tags. Patch 3 was refactored as requested by Jason. See the
> changelog below and the commit message for details.
>
> Jakub recently commented [1] that I should not hold this series on
> virtio-net linking queues to NAPIs behind other important work that is
> on-going and suggested I re-spin, so here we are :)
>
> As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> correctly elides the TX-only NAPIs (instead of printing zero) when the
> queues and NAPIs are linked.
>
> As per the discussion on the v4 [3], patch 3 has been refactored to hold
> RTNL only in the specific locations which need it as Jason requested.
>
> See the commit message of patch 3 for an example of how to get the NAPI
> to queue mapping information.
>
> See the commit message of patch 4 for an example of how NAPI IDs are
> persistent despite queue count changes.
>
> Thanks,
> Joe
>
> [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
> [3]: https://lore.kernel.org/netdev/CACGkMEv=3DejJnOWDnAu7eULLvrqXjkMkTL4=
cbi-uCTUhCpKN_GA@mail.gmail.com/
>
> v5:
>   - Patch 1 added Acked-by's from Michael and Jason. Added Tested-by
>     from Lei. No functional changes.
>   - Patch 2 added Acked-by's from Michael and Jason. Added Tested-by
>     from Lei. No functional changes.
>   - Patch 3:
>     - Refactored as Jason requested, eliminating the
>       virtnet_queue_set_napi helper entirely, and explicitly holding
>       RTNL in the 3 locations where needed (refill_work, freeze, and
>       restore).
>     - Commit message updated to outline the known paths at the time the
>       commit was written.
>   - Patch 4 added Acked-by from Michael. Added Tested-by from Lei. No
>     functional changes.
>
> v4: https://lore.kernel.org/lkml/20250225020455.212895-1-jdamato@fastly.c=
om/
>   - Dropped Jakub's patch (previously patch 1).
>   - Significant refactor from v3 affecting patches 1-3.
>   - Patch 4 added tags from Jason and Gerhard.
>
> rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fas=
tly.com/
>   - patch 3:
>     - Removed the xdp checks completely, as Gerhard Engleder pointed
>       out, they are likely not necessary.
>
>   - patch 4:
>     - Added Xuan Zhuo's Reviewed-by.
>
> v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.=
com/
>   - patch 1:
>     - New in the v2 from Jakub.
>
>   - patch 2:
>     - Previously patch 1, unchanged from v1.
>     - Added Gerhard Engleder's Reviewed-by.
>     - Added Lei Yang's Tested-by.
>
>   - patch 3:
>     - Introduced virtnet_napi_disable to eliminate duplicated code
>       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
>       refill_work as suggested by Jason Wang.
>     - As a result of the above refactor, dropped Reviewed-by and
>       Tested-by from patch 3.
>
>   - patch 4:
>     - New in v2. Adds persistent NAPI configuration. See commit message
>       for more details.
>
> v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly=
.com/
>
> Joe Damato (4):
>   virtio-net: Refactor napi_enable paths
>   virtio-net: Refactor napi_disable paths
>   virtio-net: Map NAPIs to queues
>   virtio_net: Use persistent NAPI config
>
>  drivers/net/virtio_net.c | 95 ++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 28 deletions(-)
>
>
> base-commit: 7fe0353606d77a32c4c7f2814833dd1c043ebdd2
> --
> 2.45.2
>



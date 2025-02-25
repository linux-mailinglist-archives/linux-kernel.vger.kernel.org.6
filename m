Return-Path: <linux-kernel+bounces-531788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19281A444ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAA542193A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7E1624E7;
	Tue, 25 Feb 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUoccHpQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5CA1552F5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498458; cv=none; b=FJpDwvJ3U53vDAZGw964smjQSRBnUpwMu3+S6yyiy9hzjeawA3nJBeu6Dj62zC++HEseMW9OMb47n7UxX/PnEnypygEhVk6ZwRvbUBrRS7ds9vQRn6F0kRt2cy+qrE/009CxRE/2Tu97hxQmPehSSSVHK3yKX/wzAt2OhngdHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498458; c=relaxed/simple;
	bh=+hpEQsksCM2iTh+r9a0lvGWAIMgAZlsCpvFGoIX1BJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6cLhsPCOmfWnYK/BLTTb/igdS7EmvafT26byBpHPoe6RBjLrXRj40ZDNvnmgGrYLQ/9Ct6ke6iJxQ0AhqYUemToNTO7GdXu3vEgApTVtIlQw6VJaQc6u1HJuQLwVc6bpJialgJyGNX0v3AtahwqdhI7WzBsjIVY/PoCI/CkAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUoccHpQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740498455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLowiaQXcPjBLLsqA2QJq9sdnqXz83Xdngu5wIHqeOs=;
	b=JUoccHpQgUgiQqnKnVQizAMHU3HSsP7aOu/x1RXrxpERkD8i25UbaLDO78swbx8xidFUvp
	/dEbTIM94NRqb8mJQhsHKBS09OUnbsdSn5isCHwGnA7cHJ7+tcgmQQ1KU+zfBDijuokG2R
	Bysh66oVskq3X7MPdtNvuntYgR6otCU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-5jyGNjUIPOadvCaE5mTjRg-1; Tue, 25 Feb 2025 10:47:33 -0500
X-MC-Unique: 5jyGNjUIPOadvCaE5mTjRg-1
X-Mimecast-MFC-AGG-ID: 5jyGNjUIPOadvCaE5mTjRg_1740498453
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e4987b2107so500167a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498452; x=1741103252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLowiaQXcPjBLLsqA2QJq9sdnqXz83Xdngu5wIHqeOs=;
        b=idzsPniSZuV5VDpIT8+MOaOyvybFHnDSCRZrod6ngPN0Z3MugaurGPjszuLQSSLZlS
         eOgcsU+W+b48kKojJgFHmeWllTLCNXPJNpKNKBFBGDJxD3ljVm0Pqe94JWWuXYzixX9z
         d6i0vkV7f2Rgh8PTYXU9pqAWmCicoOmLZIS5peN1LAoRrFuUy+TYQyPowRi5Nx2K72uR
         l54oTFYAu2Mb+/ye+prNK8i6frsleWw1v6b5s3fiMIbvGe+4Utzlg37ofesTp4NUvLa7
         ekGv299tU/zDZ3W18ILZGel8ZOH8Zg7b106D1Nnm/8sa2FgffF85UhVOmSOH1AlOr8md
         a/hw==
X-Forwarded-Encrypted: i=1; AJvYcCWQYLWD8bChT5Z9gd41XBcZ7P/xk/LjOKq8CJQ+Je4KUPs8R1m71w2Tbtju8iQD8IBWFwBCzOW4ZlyVcLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya65fynuilDym3iIqmXPrptw/BrseLLvAago+LBOmjQJtxWoOA
	3dKNnPEhrS05+zmB+CrimXLwxrArrHauASgQklsoWTjhjbwQQqaDpUQbzs+em9ZeG5OxJGbevYr
	u5ADi46M48wILTh7ej1X4Ao/LUKYqUxGsQfGcfoZy+42jCs6mqiR2fqwG16b2KprVtGLirCPpR0
	ZJn5dOQn+SbqAxI+jXia0XUcednZg6/+M0UxGR
X-Gm-Gg: ASbGncsKvxB8aaEI1Rvl4cTlQ6rX+tHuLibVWYzrnrAJAennUKGq0nZ8hq+AVlNLyD1
	e8jkqZNGMBJULET2G5DmzA8pL7EWkWurxQBLN68Uv+1YTn6sjdkUcd7VVDkUDJWE+vS8uwX3gwA
	==
X-Received: by 2002:a05:6402:3885:b0:5e0:892f:89ae with SMTP id 4fb4d7f45d1cf-5e4a0d49316mr52506a12.4.1740498452567;
        Tue, 25 Feb 2025 07:47:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhU8dArcNz7knBUveuwkVPq5cd7umRsmFiecLgZ7/6k9imQABOaWyFK/dDNV1CGGBckyZTblMRAxsXXO5bzfo=
X-Received: by 2002:a05:6402:3885:b0:5e0:892f:89ae with SMTP id
 4fb4d7f45d1cf-5e4a0d49316mr52466a12.4.1740498452137; Tue, 25 Feb 2025
 07:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com>
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 25 Feb 2025 23:46:55 +0800
X-Gm-Features: AQ5f1JrHeeMYwYVuWDy8wtDZfVYsR07ZW6D64o1AlnpiaZi6PVCbCyH5tDufmyA
Message-ID: <CAPpAL=w7e8F_0_RRhBuyM-qyaYxgR=miYf_h90j78HzR4dvQxg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] virtio-net: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> Greetings:
>
> Welcome to v4.
>
> Jakub recently commented [1] that I should not hold this series on
> virtio-net linking queues to NAPIs behind other important work that is
> on-going and suggested I re-spin, so here we are :)
>
> This is a significant refactor from the rfcv3 and as such I've dropped
> almost all of the tags from reviewers except for patch 4 (sorry Gerhard
> and Jason; the changes are significant so I think patches 1-3 need to be
> re-reviewed).
>
> As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> correctly elides the TX-only NAPIs (instead of printing zero) when the
> queues and NAPIs are linked.
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
> v4:
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
> [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
>
> Joe Damato (4):
>   virtio-net: Refactor napi_enable paths
>   virtio-net: Refactor napi_disable paths
>   virtio-net: Map NAPIs to queues
>   virtio_net: Use persistent NAPI config
>
>  drivers/net/virtio_net.c | 100 ++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 27 deletions(-)
>
>
> base-commit: 7183877d6853801258b7a8d3b51b415982e5097e
> --
> 2.45.2
>
>



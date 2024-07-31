Return-Path: <linux-kernel+bounces-268466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6CE942503
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC42282911
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CCF2110E;
	Wed, 31 Jul 2024 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbNfx9xI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95F18AF9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396078; cv=none; b=oa7kFk2SZtCH5txihJ+D45h7APIQ+FOK3RygLbaI7ATRo619pwhK9a7TimamV7+p681eq1eaUh7ywYMNEk3Z/imKHLuXz9R9jth6fvnk/xVJshsLRBtT2Jnnh89RmxulAGFN0JdO5V4DCfYB9xJ96r/Waqo5jlYzfqoCPF8CcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396078; c=relaxed/simple;
	bh=xJH43k8URImlEysYb2ZtwSkGIsRnlK2Txi02lgGh/Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RunLbOZ/BtKeTcgRHYXC5NxU7bh2iY7HPrLsHORtHoujB5/lftYuX6TDNPKVMVZEw4rorL7fqO9PTBAc9biEkDQTZ0cC5Ycsmd+ML+NnvPO4kIZ01/3D3o82SbPcMCokhD/AvUY23zWBa+JupuS6w69sEFq3r3KnYpOa/3Qi8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbNfx9xI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722396075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJH43k8URImlEysYb2ZtwSkGIsRnlK2Txi02lgGh/Qk=;
	b=QbNfx9xIIpY6/mZyOjLnvBtFsUZgu8ub9MysMD5hnW/ZJxbalb7psgx6kIb0iLtvSrSSep
	R3vtdO+kBQnS5soMNvZ1hG1hFeBQLTh8omZXoUPf/6knAesBuecs6AMjE4wwZbiG8V5r0t
	14IoVvfhH1nnK95VmJAZRwNfv/Py1V8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-KFFno1tNMLSO_Y9SwmFpsw-1; Tue, 30 Jul 2024 23:21:13 -0400
X-MC-Unique: KFFno1tNMLSO_Y9SwmFpsw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7a732cdd03fso4209722a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396072; x=1723000872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJH43k8URImlEysYb2ZtwSkGIsRnlK2Txi02lgGh/Qk=;
        b=SyHHL8WZNm1JJ5Lbe73rvG3RVnyF0cjGrJK3VZRUHR+EkmZ/2Cikct/VtmZbvCQs+G
         wH16qszohwUt1eF0fwp3cYbTNzPzfqd2X7A37miTaolNTqxyqPASez86LWkyTHcncqHZ
         ah7IYTM/lSqTuzvknC6id0ccpMXjc6c8AiD8GWPPs7dLohD82U0GpVURze6zgZltfYTh
         KfG6oGGwAQZFzYOb6Ye/symXrX5ll0P9adfp4kh6IbZGQZ/lIr10lSj7n4zZ8R0zWNZ+
         E1FprFiIVBoc6YOvmAk5hXQVKMj0agmKCEmeaRsLEOwx8H1RTXSNI2/6TUYv0sVmBIgz
         4ciA==
X-Forwarded-Encrypted: i=1; AJvYcCWdInTEb9HXz1x2XoB6TBRPlQUR+Pih0s+104pZQRtqdhfOuKcsfGXrq4APm1/0lf20Wf9vWW08pqt9xvoY4l4e7vx2XdUY7pNkqXt5
X-Gm-Message-State: AOJu0YwyLMJ26xhAvaXhgmZ62qDuXrTBjE3PHkL+/FGyu0Qe93AIrhuZ
	+7Tf5IxcWv3VcVe9HXik5drYYCMuxngR+htY83r+MT2/y5VgUWNhynhJ6YyqPR++SxZBMSHQSbK
	BsKOPJwcxx5KnwZWi1laufxLLMxVoW8pdUtrbpUyVL6tJNvkFyX1Sb5I0vc3X5aUWpRmlQFJ5gY
	FyBknKqukzQz/V3VSb6M7P0ZrobxotP9TsyGNm
X-Received: by 2002:a05:6a20:2449:b0:1c4:8bfd:4321 with SMTP id adf61e73a8af0-1c4a13a1ef7mr12560613637.34.1722396072294;
        Tue, 30 Jul 2024 20:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFOJlwWT2CFUV7HOeE6P2HxO4AGkTGmXU+UVH/PtXBdfYm5264V0djpRLRQIe/OL7105iGiJ+e4nquq3zV9ec=
X-Received: by 2002:a05:6a20:2449:b0:1c4:8bfd:4321 with SMTP id
 adf61e73a8af0-1c4a13a1ef7mr12560603637.34.1722396071790; Tue, 30 Jul 2024
 20:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731031653.1047692-1-lulu@redhat.com> <20240731031653.1047692-3-lulu@redhat.com>
In-Reply-To: <20240731031653.1047692-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:21:00 +0800
Message-ID: <CACGkMEv6K054+HWxocdsf7fsxw64R5MctDaJ0wuWBY_LMrnDqw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



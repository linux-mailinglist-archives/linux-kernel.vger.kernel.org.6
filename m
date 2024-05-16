Return-Path: <linux-kernel+bounces-180648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D90C8C7145
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39626283535
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 05:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF27D19BA6;
	Thu, 16 May 2024 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1dD+Dao"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872E10A23
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715835820; cv=none; b=Z6qVAzDZoaf6YFw1oE5hvrRKTggczIIjZ1PhkPHSStURZmLmo+qVdJJKnU8xTpxVbIystv/cmRguw4Q81A11VC/z8TKxCBVLUCJ3BzHhR7rsX0cDF98wjk82z2G/K010e3lmGrpyP1LdusyMOamb9M0uAuGFhCgkLQaaUfDA00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715835820; c=relaxed/simple;
	bh=DjF0gKWJ8+yHQMlYXKXU86iXdSe/PU926z1Ys3/Duiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDVnopuwmGD3hwvmB+Iki1hi06mJ2E9cHjoWR5clK+sgi7lY+GOaR7w7ZM4UY+3xzxgIa7PZWx+7rZIwdj2O6adBW4P/Qs2g85ZG124JvASlJBl+9DWcv+7J2KUbB0RybporanoM8groj6I0fPMptZqUENTcApdoKxts2vkNILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1dD+Dao; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715835817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIdlxCtNUsN14oiOu6iayNNOeSqk/xL+5C1diPVIWj8=;
	b=h1dD+Daog574QsulTvpjvB4BWR08WfD4rReYTO9SWY7VZatn2suzFwj81QBrNUXIxecMZW
	TooWaC2ftPtS4iVwKbufUb89bRcnmc5KBOUzTv/g7slk11OxuVVfVhuRtK9aSRVGN6fSt/
	sIpgJ5mO3dUa3waKWiWsKxiJKvTPfVg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-p57CLT3cOYG9DW3Bqbx7JQ-1; Thu, 16 May 2024 01:03:35 -0400
X-MC-Unique: p57CLT3cOYG9DW3Bqbx7JQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b33cce8cfaso7441673a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715835814; x=1716440614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIdlxCtNUsN14oiOu6iayNNOeSqk/xL+5C1diPVIWj8=;
        b=okAdKzmtqFDTp2agaaORHlGIjziiF6YGRC21cl+8OxReRIvkJf4Qsa7aPa2sD/MSad
         +yv3W19aS7kQl6QzCoppLdpSRaZG13ylZ95zU21mF+AEoQ2319gjqgObtFHXMS4qfChb
         scSL/2IbWg8QGa+W5DdUDnCsfDaujAV2MMCGY1gyEeY8loHjXZMLkZTbnE9cdPrpHZ+w
         R5Vx/0ospO33fE5Q0tR7GqrPDRRqm/3dLaIgwdWcTACQsUeQgKDRWVngKuQFFwuwEYm/
         fKhxHSw0gcLU0KCpPgwMdo3+cwDsIDFidwoQABumDPoHtFTxdQGQXP+OCdPpnV5D2bsv
         fE0Q==
X-Gm-Message-State: AOJu0YzS3S+Oi+aGVIeOdjv07okwK0An3i6QuAcZNpLGb1ggyBomT1in
	uWcFxLNRNEu3TfkaT6o6fft0FAymgndWsBZikchisHJeXFET58tW2C1Z3CEm9hF9uh1wprUgBr4
	ztha+lb9iQc4FkXL/h+HIThroSfn6lt7co9vtnnk3MqO8UvkiImGIgoHRopIrBNzEO7z9Byi2Mn
	czR2N+6+8Alp6FXkCEQP/+LwE2eRfKPoV65XHI
X-Received: by 2002:a17:90a:dc82:b0:2b5:6e92:1096 with SMTP id 98e67ed59e1d1-2b6cc87abadmr17615797a91.28.1715835814625;
        Wed, 15 May 2024 22:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+ev8TSdRX+zKT0qCrNrwqTtjz+WkSu2mM3TK3gNNhGR767n/TIbLADRCAzfaJ2wL8x2tkPfFJfTl8kBewwqM=
X-Received: by 2002:a17:90a:dc82:b0:2b5:6e92:1096 with SMTP id
 98e67ed59e1d1-2b6cc87abadmr17615782a91.28.1715835814295; Wed, 15 May 2024
 22:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
In-Reply-To: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 May 2024 13:03:23 +0800
Message-ID: <CACGkMEtxYsRhxRc_DExPXeSLOstp0D66+yEoyXKVWrMdTx5ASw@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: always initialize seqpacket_allow
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, 
	Jeongjun Park <aha310510@gmail.com>, Arseny Krasnov <arseny.krasnov@kaspersky.com>, 
	"David S . Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 11:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> There are two issues around seqpacket_allow:
> 1. seqpacket_allow is not initialized when socket is
>    created. Thus if features are never set, it will be
>    read uninitialized.
> 2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
>    then seqpacket_allow will not be cleared appropriately
>    (existing apps I know about don't usually do this but
>     it's legal and there's no way to be sure no one relies
>     on this).
>
> To fix:
>         - initialize seqpacket_allow after allocation
>         - set it unconditionally in set_features
>
> Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
> Reported-by: Jeongjun Park <aha310510@gmail.com>
> Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
> Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



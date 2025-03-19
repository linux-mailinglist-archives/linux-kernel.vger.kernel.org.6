Return-Path: <linux-kernel+bounces-567169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62863A682CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720373BF1B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C047124E005;
	Wed, 19 Mar 2025 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvfRMjR8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD612CD8B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348598; cv=none; b=QNO7wUig9zWNFP5hl2dbJ0iVaB6HRA2NWwqA/SnLGJOSLzCv+veJSs29LvWsz+BSqhOjn09G/3hcJVBzoSzzEYpPg/kUsC0FwBdlHZw3XK5QE9as16j2aSuqA7K4oqMIlv+N8mmVpmDKzC3bCVejkiouwtyFl3Bq4nJcrWXr5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348598; c=relaxed/simple;
	bh=GV92ClXjvz4/MTW4YP/XSUB8BPHIDGjT8AUblei2M/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYdGAsBCQcITGytUE1JE8L8+GzLs3mx+ma6FOFLHoNOoT4APRkN8jt4d/jhMr3zffkWP+xjC/Z8LpkIL5JQMN6lwd96jwX/WchBU25JtwnNNYL4TGq+/JgqNmHzdcHycTwH5vLzBUCb4Q4ve5NmDeyllAn7j9GpdDAnabXJ2jQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvfRMjR8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GV92ClXjvz4/MTW4YP/XSUB8BPHIDGjT8AUblei2M/Q=;
	b=dvfRMjR8OvkFjq7wsM1szkC/cDvAFrZfFe4wNBb5FhbVKfNgctnox8qfCy8QE3IE8LbsGt
	3JHYxxXd59p76QSHHs085WvdtHMjlwPkO8MObeBcng0GNJSP5gkiKyYDD6YRX/YQHTr6zf
	avVqrFEQ4taif35NotJkpGIlmyfYE70=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-F4pVxwTwPz6_TV63YbM6wQ-1; Tue, 18 Mar 2025 21:43:13 -0400
X-MC-Unique: F4pVxwTwPz6_TV63YbM6wQ-1
X-Mimecast-MFC-AGG-ID: F4pVxwTwPz6_TV63YbM6wQ_1742348592
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-301bbe9e084so1044089a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348592; x=1742953392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV92ClXjvz4/MTW4YP/XSUB8BPHIDGjT8AUblei2M/Q=;
        b=IlV2BVCGfU4mctN64fIiXciO+N1SsmMzQgL+yPAlhIgvrWAtXFCu9/E4/BJsqHLgkl
         XeuDX/RN88iotGmVGQD2mEZ/DzaWEvn8J6HPk9h29/J/WwG9Pswwj6sdL/lNK61P/YxQ
         pOQxygyU/FQYYNNgVNIUW1Akn38Snnq6Ww81mnkyv9ZhOx8Ybdb0fgHxfWGiAUJ7YXMg
         Y+fI/NllMECpF7//0Iw94zYa4DolJ7xgFSlE+4ktlTvsPcAbHVM44YGh6DvdQne8TdrW
         INDeuyqqxO0YcwhTw6xLsNxLUUWrgiHKqh7BBPdpas7ppSzPyUZzM/+r3BFC2qmxNZ89
         ML5A==
X-Forwarded-Encrypted: i=1; AJvYcCXDHTQeIxUlP4T7ZkYMjxY5U4rjpV87jPrtpqS4ySSjxYTbzYBO+sv5EWPcY81otmuEh9/G33+GdJOMgwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHNUzQC2Cirkos9TAhFG2mOtwPFrHLRBVEjLy68x9QZ+PtZ9i
	8PNZ0cssYvJeWnTyS6MvkVGjvcQlTaTNPqdG2gdYkv/gcztYkjGwDuoyiGWiJpzm0rNanrjJA1R
	0hKFwNyTxbGYlAsC3u4Mv/DXPB1YC1lzr+PrjXlFtzyZFyYVlSHlpkoQSpbnIuLIEyvTN2PGqjG
	M376b6TzsCHMJc7R/MNmxuk0Eo/dvyHjp+WcYX
X-Gm-Gg: ASbGnctL6JXcIB1bIAAEDZEZCOk/G7b+OUxNwZ2rrg8UL8S87wz22aWB3fuom8Y/fT9
	uNMV7L6t50rxjd59x7RbDHNXvNZwwbHQbxHjP+6p1uZ4b+BMT83Z98/m66ch7IF1eHwLG+U8d
X-Received: by 2002:a17:90b:1811:b0:2ff:5ed8:83d1 with SMTP id 98e67ed59e1d1-301bdf8fe6dmr1172321a91.19.1742348592282;
        Tue, 18 Mar 2025 18:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3xUKmc/HaZKbY2Dl8pCa58A8bYMdk6rBE8YTKkC3nogLq+BbetaOi+Z7lREjD84lMdYnVJXjJq88sniZ07Ns=
X-Received: by 2002:a17:90b:1811:b0:2ff:5ed8:83d1 with SMTP id
 98e67ed59e1d1-301bdf8fe6dmr1172297a91.19.1742348591933; Tue, 18 Mar 2025
 18:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-1-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-1-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:42:59 +0800
X-Gm-Features: AQ5f1JotJK4za7GHDUjLaHu15ZgN8MdATNrjp2GqHsHDNV3hc5BHA8yY_muRp9w
Message-ID: <CACGkMEv4EXUcZ68SZ7RzKnJ1+etf4jvqLLUG9-dXUDc9jSsOiw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] virtio_net: Split struct virtio_net_rss_config
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> struct virtio_net_rss_config was less useful in actual code because of a
> flexible array placed in the middle. Add new structures that split it
> into two to avoid having a flexible array in the middle.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



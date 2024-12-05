Return-Path: <linux-kernel+bounces-432671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC739E4E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DA118817C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA831B87D6;
	Thu,  5 Dec 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gC8alGpY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB01B6D02
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383997; cv=none; b=neCGQb+fRZbNYKY6ilD1zUMHRDx5fGRDwgxxGNeadAEoaHPOB9EjLVpsQSlKQ+gWGyQ37WyTcUfuHQkOfnseiM7dZ8R8g9vyloUDEz53qH6IsEPkamVznJB8SvuKY9SzPJremFnpQmDqw0BajoyMxEteR4dPMql8xil2+dtEs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383997; c=relaxed/simple;
	bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5sPJKcDj3ee/7njM5Nk7x+1AoDH5KI8XMYyDgiP/QzxV+NxVs+JjwebtlwjNecoWiX1QHXKDekLtV9l8EwAQl7oXIv5w+XyA55JApxaELoInVr5P4qDifLZ3XeJ2nJSWg+cwwXEwtjXJevsMfVmEDWp/jhRXI1um4wE+Krcfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gC8alGpY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
	b=gC8alGpY81DsLC6y9P2KLHiFX+mFPFm0phcyaPc6i/jB19nowtjFYCfnnr9WWpUnBuEGG5
	yma72xh5Exu7A+ua0JPDqdd05xOhY5JM+lrzuJb5mJ/nnMrm2UA7lWnszRbL8hgVHUMsho
	cO7f3oL04m/qKUjIBrE/bA60WSA4EH4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-37MM_4e6OUKnoV3k8wWaDA-1; Thu, 05 Dec 2024 02:33:10 -0500
X-MC-Unique: 37MM_4e6OUKnoV3k8wWaDA-1
X-Mimecast-MFC-AGG-ID: 37MM_4e6OUKnoV3k8wWaDA
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-71d557437e0so379426a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383987; x=1733988787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
        b=jHavlE0RRb2n2BHRAt+Bf1P0PbFY9gZmae+aEt2tt4adKf8wZqUkbgxKiW3IA4CSs4
         FS9cCFPSYGulrvCy3AVCRScjw9kORbzuNAEtA70NbpOZq3szZ0VJnf6u806mZSnjcUVE
         2t6IP7nmITT1RBUj3RwybAi+AVTV0m/ELsy+Gqg9/TwVS8gmNRgfToUK16yAyWbSsLQJ
         46yYU+KV3pBQPOBUOFUr+qJ3t8Ftrj4vqQ5cg408eeXcjBZ0KAbo3RbdXfEY8I33RKPD
         23GbCXxE/LMwnVzlBHjK4qUGzHJIOIH/Bf2W6f+HIVxRsdpRESLAkPK2fgevGFhGIxPk
         zU4g==
X-Forwarded-Encrypted: i=1; AJvYcCXKjY9j7rlt6qYsbeFgquw/Qd598mJLgrZ23LgAx9J5gukvlR897YkK8TkmyQiDiHHWP2ko6whp6yCUk3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvGDVCehiezpC4vIHSGNkB1uD115lNJBDWA9IX/HIr5L9Ezn3p
	rcxbpgLX9E7YxcTAGaDjL7BbJUXyhsEl+ZaUtadnWJID/LmK61rZTM5FQN1xceB1BY71vXtzj/x
	A50X/NSpxLjUotHkzuC+uTrNBWDLvJ7268n/0FwwhT6IUgwf9k+xDpg3RF6mfSqs7OP09fod5RO
	xhFT+x52XGVLTQKUV9fVK9N5CYWEhWNLhOaO/IFtxTIZgs0qU=
X-Gm-Gg: ASbGnctlKNKU5X5Ug6frKorQmoKZhGN9sYzbB63LhPGXecwMnoWZHv4pqmGKNb38Sob
	5bh8n/VWBEcO/TgOKhqG2SI4FiDrC0ii+
X-Received: by 2002:a05:6830:4984:b0:71d:4733:b723 with SMTP id 46e09a7af769-71dad692bf1mr7133439a34.18.1733383987145;
        Wed, 04 Dec 2024 23:33:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDtQDoQaqM+3b+ntK9dqohRIca4r56a555HOpzjVOkBG5XoAIkxz5R1IAjDQ0aajFWY1uYgAI/ZNkMsaHUSWY=
X-Received: by 2002:a17:90b:1b4e:b0:2ee:8abd:7254 with SMTP id
 98e67ed59e1d1-2ef012748damr12711858a91.36.1733383974938; Wed, 04 Dec 2024
 23:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-7-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-7-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:32:43 +0800
Message-ID: <CACGkMEtkabmYmepsx-dyTbTJKq4RUh7fPVT6YubS6RFQD35XMg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] virtio_ring: add a func argument
 'recycle_done' to virtqueue_reset()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_reset() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new function argument
> 'recycle_done', which is invoked when it really occurs.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



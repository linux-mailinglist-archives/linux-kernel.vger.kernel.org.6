Return-Path: <linux-kernel+bounces-432663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6849E4E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6000B1881921
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7491B2186;
	Thu,  5 Dec 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgBo/PWM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8C1B0F29
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383865; cv=none; b=eycxEn4Ez+/mBALG+ItXt5jZXDDgVu0lHhnykvHIyHd5qYiJcYLkAPi6RY4oL2Z+A04FAzlIeDabOGkhtmmLec+AsdR0A2v65zUmDEGvjNAeU4FvpvpCe9ilaBmxkAOlMZCzcvY0D0b5je2bmYDJn3w+Y10pfKxV9BjiqOLsg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383865; c=relaxed/simple;
	bh=gBsazSA+2P8jNheF6Uy8VcoZ1wvAMnui60NL3/2jmLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV63Fmwbc1Y9ODU5uKU3g5HuyvrwiZTmg7Atvg7jiECwy9DiDp8dIBWlpMTqokm2EBZYWCZ5QSYE5QwB+QHbk1D40eh6ZqKayqMFPDBpCjwxn8ODUpGSireXjGWhMTJo4KKMjzKSEjagoUnWhh/cCaSqRPPv88o6GYD8OxNudsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgBo/PWM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQByPnPwbfne/yS8JI9pQTP84ZOieAk2em/vkGbruFk=;
	b=UgBo/PWM6oqrw4jpRNswNaacLFrWee/7ZHGrLWOqzlocYaPK324IhjsbW/F220E2cFSTQE
	/ObWaE39FgCjqZRJmSP+ONUl+CPUhxggyt+mCeR7j3FvHBMbJcyCmcc4323tK5V+Zy4rKv
	9plIiRh/0ispT6hrx8e7n50RvKm33+4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-OZ7y8khuN4iPw018ySXq2w-1; Thu, 05 Dec 2024 02:31:01 -0500
X-MC-Unique: OZ7y8khuN4iPw018ySXq2w-1
X-Mimecast-MFC-AGG-ID: OZ7y8khuN4iPw018ySXq2w
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee6ea04326so1133849a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383860; x=1733988660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQByPnPwbfne/yS8JI9pQTP84ZOieAk2em/vkGbruFk=;
        b=HJJZVRHMDwGFjSaxQQXd+qFyw0ZV03YuUFP0N/uI/O8Qqlk3NgfbXql+WsGB8XzYty
         0qPiQffD0YbtTau1DsTjbLENKCvo8QBuAgxV0DQBNfJwvGckauxoFhqJwRm5IFkoghLY
         3cPCytJyTCZ4ClUV+gJGq7T70sfZocQ29hqxaADpJ2qFPHXPhmpAAzG2Ji8weS9EdQjF
         KlgJXP7CHuzRvXI2dSPgMMFDpJv0QDcaBdjLOH7HMxMILVdmqoDOWwz66vbVxJlMvDq5
         pmOsJL4FNqC8YQN9UEfOEUocGqeBWet5uTgJzTrZEsYwpgaH7QpU8YJF6WPfcr8Jgmsp
         ky8g==
X-Forwarded-Encrypted: i=1; AJvYcCV0NVSgESU8yzrENJzXoILSKMfGwnkh0iJcWOWbQAxGqtz012M2GqMTaBsjx6Z1CKXtMYyHmNl96ZbHSvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvDZC47g9Nf8QTY/XOZdwMHXdTjux89YFkgUDcvdQxK/cGad3
	i+nMEf/wLB+QEJBEdArHzoHoZXi/K+V63SJQf4lEoyyBI4W9hm65ScUkvXfz+k9qlsGhPsgnbE/
	OD79Fpj3oQZgGN4y+a49tdZ7VcRLX04XJ0MVrKNanHRlMkKMnfCioLc9iyL/JW0MQr4CnhYq4HU
	3i96ZsizFhQUKN0o3wg+kV1oqe4gcn0wIEJhT6
X-Gm-Gg: ASbGncsqMMJy5eZm/EPQNgutqhbVa/bRmBcwIa18+cI0XMUX3lkdrohHbZe+sSRQVbt
	l6dyXBksZKyS+KAR0re6DEHMY5s0RubxW
X-Received: by 2002:a17:90b:4a41:b0:2ee:a127:ba8b with SMTP id 98e67ed59e1d1-2ef012730dcmr11339477a91.36.1733383859229;
        Wed, 04 Dec 2024 23:30:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgjvvMf7JapTRuI1SObNMq7BvZhIqMSi6SZblyK6LzMeh4bpcCn3KV3lIBqaI+D6cczvydNaQWvE4gxNRWDj8=
X-Received: by 2002:a17:90b:4a41:b0:2ee:a127:ba8b with SMTP id
 98e67ed59e1d1-2ef012730dcmr11339393a91.36.1733383857900; Wed, 04 Dec 2024
 23:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-3-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-3-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:30:46 +0800
Message-ID: <CACGkMEuhhgNWZst2LAWStw+agvLjPrV+c2ZHe8JL4zLej2ZzGw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq
 where appropriate
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
> While not harmful, using vq2rxq where it's always sq appears odd.
> Replace it with the more appropriate vq2txq for clarity and correctness.
>
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



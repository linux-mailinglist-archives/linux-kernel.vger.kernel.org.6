Return-Path: <linux-kernel+bounces-432665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931B9E4E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEBA1881E84
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B631B4132;
	Thu,  5 Dec 2024 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHaidylg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CA1AF4F6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383890; cv=none; b=nILdO+AJQnQH5ZcY3N4oOgPFbvOTnQ4M2xsIe4noEhtzdPcexo/lfpGPZBfyZ6nuI9eWs4zVM6Sb74Jp3VS9DTEPDyzLL/CZrij5pxvAEWLFy89+aq/ARf7zVVNAWlNkFHcoTV9V7moV+iGv2btc6VaDhjjJUztCs+OIkbHzonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383890; c=relaxed/simple;
	bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gi2Omd1Q+YHb6XTxe6ZPvE052DLBnguknCJd9R4mIzQY0Ub+wFpgxWT+Dls1mGGUOTg2sdd2WLtlpwF39Kn5JkELwqNhFdJzxGmCcJapP0R3UKo9Y8fkQ2Bt+iDVcWwIvwpsj8I+H9fas5/V87S/uKHRGcK/o7ru/8qWFRQ/Ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHaidylg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
	b=eHaidylgv+DotOSaDLvT9TEjVOqCChpM7kzwxY9jt5HVWbqGMeSCpjTRRc7754L2LGzmr0
	S00dwI+rgjj193W5raNP4S85N3HwUGdFKwyPsumk/8TSwxbNHMyo0CDoghojAhdUSi4MYK
	K4KRZU8Dp/A2KnsrUCZLdzK+t+fJYIA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-42hG0TwAMjSxgkYp_Sc5Mg-1; Thu, 05 Dec 2024 02:31:26 -0500
X-MC-Unique: 42hG0TwAMjSxgkYp_Sc5Mg-1
X-Mimecast-MFC-AGG-ID: 42hG0TwAMjSxgkYp_Sc5Mg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee7e379819so1657720a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383885; x=1733988685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
        b=AUFuF9Xl5aSHyKwuvvVDK7vvVsZEWSm2xBotg4b0ehuBr6TVbqdNir8usbAociZnpR
         m+ayu908FepZ69AX9x6MTGkM3rIMmILhxWafaW9aljq5pfSL0IAH7oaErV/kDA1n9Kga
         5A3XFG0Fyp+O8OoSrpB1uvXi8argLn5ANkn4z3GbXKPiczek1B4nS9UBj0loFzTfr0Kq
         pcKRUH/OM0DpsEYX6MBL4134YXNJYrwCmtdhc0L5+UbqYQkiIHhIS5fi1IFLLGez4AUz
         b3wQRB/pnLc0SWtk2ejFLgLtyMqWVFx/J9O9CypPmoHWkTwQLOpZP44t7CrOk3M1eYHH
         jz+g==
X-Forwarded-Encrypted: i=1; AJvYcCUb1QSdeYE6onQj/3PM2chF//wrXlbvWfA38pOOrgTISERIOJGe9YRiR/yrg4aK87BaFXh5mvKwxt/1uOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCw11Si94uDud5cJOMg9zHw6XzGRfAThq+nsxFJHto51f+Isrl
	wslUqik+7Cc7N9JAnyd95IM2AN29LJGpgAVwPovVGuVQkjYaaXlmaAGKv0063jW0JTHrTSfCdeE
	W1O2wR+Ld46007b2Fzhpvi0a02y1qE1G/nB7h6BlaPAGh6mBu59XWosyAUueO6fS8mTw/xrDpg3
	zoZc/0L98pLGgPTlgjy4+UuipPIwKRQiuj2hBq
X-Gm-Gg: ASbGncu1v4OhDtCrPmDq8AFicWayJ1mOLAyqo2fEcXy9r90F/8BeFI3BqySo6M8/B8J
	42faY19oSfIAoYQ1RABDA7txvFeN2J9fZ
X-Received: by 2002:a17:90a:6346:b0:2ee:4772:a529 with SMTP id 98e67ed59e1d1-2ef41c99386mr3511950a91.18.1733383885273;
        Wed, 04 Dec 2024 23:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Uz6s1s92mheWZ482J+Pms58UfnRdPDzgkeV+DuxdzrY+WXQ6wsaWOBD+r2THsCYKuaICd9UQwkstxAvMEhs=
X-Received: by 2002:a17:90a:6346:b0:2ee:4772:a529 with SMTP id
 98e67ed59e1d1-2ef41c99386mr3511918a91.18.1733383884870; Wed, 04 Dec 2024
 23:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-4-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-4-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:31:13 +0800
Message-ID: <CACGkMEsmAtguhDbYbgzs0f_ynsDy2UwYR3jun+J_OQQwuXGWSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] virtio_net: introduce virtnet_sq_free_unused_buf_done()
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
> This will be used in the following commits, to ensure DQL reset occurs
> iff. all unused buffers are actually recycled.
>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



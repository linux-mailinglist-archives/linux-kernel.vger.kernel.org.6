Return-Path: <linux-kernel+bounces-337991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF2D9851F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02D11C22E85
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D1C14B08E;
	Wed, 25 Sep 2024 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkcGUdaA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAAD2CA6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237926; cv=none; b=poSgFz7oOHqNqy4ojeqfvznMp9iXn1WOxBdUQ53WSNqyHRytcXZT+2Kr4uzwtwbJoALdNu+xqnhBoog6e07IWw9QAfnHn86ekOehBEov8JrnGfCoLgwVH4KekQQ7GwYK/pelg1P1jmGla2QoBzyMfO4SvmT4dne8pV/x2wl5Kmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237926; c=relaxed/simple;
	bh=G3chFIunKoa6UYZkePQmH4EEA+5fZM365dBwiUGSCYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djxangS2kiLe+8U81OCq5PnbQBv2p+xix0gyzueTI5Ru9KqQXnvD5PLCOd7op1jenQTWb6c7l/Q+KX4GwhYgMWAL2Sku9ZSzuRwvTSC5dUaPVQUFVDtCc97qKxC62Z1nFBy9y0RO+JF+vkvDNNEJhzLR4Yf9n9ZxrWwYQuiCB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkcGUdaA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727237924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3chFIunKoa6UYZkePQmH4EEA+5fZM365dBwiUGSCYo=;
	b=KkcGUdaAVRsi6FrbC5uj04+u4m6OvetjE+sgTUeoOQwGoBQdpzFAjwTcl5274uSPbNdk1b
	vQFOk1K54EMsboNmK5SSQ/dTB08Na+ZHIwUGs0pajDI+rUOCcjsvVLHKSAEvBlENiEu/FN
	hSZoLb2is5staFwu2tfElQE9J+hPWW0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-g4FUc8BgP_mtDom0nQiJag-1; Wed, 25 Sep 2024 00:18:42 -0400
X-MC-Unique: g4FUc8BgP_mtDom0nQiJag-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7d1fe1dd173so4998514a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727237922; x=1727842722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3chFIunKoa6UYZkePQmH4EEA+5fZM365dBwiUGSCYo=;
        b=IiTCkTopYI7JCXiKXkD4Ts4IKZ/AUBQhWrzhXy4V436nrRcF7YrYo0hCCD4BOYA6ck
         Se/QCEoN7d1ejrqoOChj10Z++taGskqz/ZKwvZ23pL9c+StYHW78ExsUSyt5r6BZkpiS
         9CwlPR1HyrcQk3Uub71dVsZwSpZOhmkRV0A45wwnHxVno+dQlqPx+ht+38AtGbyAwVgY
         lyiFKZHaiAtTuALX8oRfTrCAOOFRko7ubReRDpCKR4CrmHUCbsG0NF5YWAQAJ+PWxZmP
         NvZJgFp0bzjjp8hNwSje/jRHlVKV71zPcGPNCc4vEzI26xVP6XPjCKGdpUqzBbfncXfj
         A6WA==
X-Forwarded-Encrypted: i=1; AJvYcCUX0iYv5C5O2L9lWYKpOOJvuXo0AwUEbJskJ2Nlrqd2U9M0tdSmbX9nxeJMPSI2qiYUAynun+zMZS+b6HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNZNj6LGaJlJSz2JAKPMpht78CcKnzx3QKuNYlAeqwjTdOIKZ
	3VQAGQXh/yD6Q7k+Hgr4zZmG9UmKly3AXJ7pvdusiFfiqzwBqPxAM5jImsKmF90ELzcb8zBDKpK
	J8R8GPM+IZawdU0pxWDxVsby6H0ayp06uhyR7i+pSXxMxp3ivGwD69lf0lYQIN9UUY9ZDsuDWe6
	VNvEptBgB3gmhcruUJCSps6yaqNtgUWesHIjUF
X-Received: by 2002:a17:90a:9f87:b0:2d3:c664:e253 with SMTP id 98e67ed59e1d1-2e06ae4c868mr1799738a91.10.1727237921636;
        Tue, 24 Sep 2024 21:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/2nCEr5Rgl+muh77Cq7muUEu6owuQxLm2BQIblXASXkR8C6qM167lFWkF2jWG0c97NVdwJzaslcF1/n2mzPA=
X-Received: by 2002:a17:90a:9f87:b0:2d3:c664:e253 with SMTP id
 98e67ed59e1d1-2e06ae4c868mr1799712a91.10.1727237921137; Tue, 24 Sep 2024
 21:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921231550.297535-1-linux@treblig.org> <66f0378ecf981_3b28232942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <66f0378ecf981_3b28232942a@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 12:18:29 +0800
Message-ID: <CACGkMEtVAQKKywHXmeOagik_4pob2Qv-WimLQEKG4NAcM=r9xA@mail.gmail.com>
Subject: Re: [RFC net-next] appletalk: Remove deadcode
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux@treblig.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 11:28=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> linux@ wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > alloc_ltalkdev in net/appletalk/dev.c is dead since
> > commit 00f3696f7555 ("net: appletalk: remove cops support")
> >
> > Removing it (and it's helper) leaves dev.c and if_ltalk.h empty;
> > remove them and the Makefile entry.
> >
> > tun.c was including that if_ltalk.h but actually wanted
> > the uapi version for LTALK_ALEN, fix up the path.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



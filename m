Return-Path: <linux-kernel+bounces-229914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EE09175F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB01F221B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193114F62;
	Wed, 26 Jun 2024 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rs2g/cNn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A745BFC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367131; cv=none; b=nODXUntL9r+39P+idT1wXY0kOwLsHZhgnvpmXOGPNOr8F3D/SM39saapPvuEff5CifCMoHCTvpPvOoBDLEO/c2wOo7nKLqLIsMMNw4bQVoWFtiKsUxNjhxMCiLW2hKPxGNb4lMnqB+fAIyTC0Yd2jZGVwmtZxWNctJ/hWQVPTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367131; c=relaxed/simple;
	bh=GnG1sbGbs1jtmTvlrH54yNuEYDYvf8DpjOgAllIIWYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owbeHEoyygiwwGFK4SUYTY2/LHQjqvnYgjmhdw8ylWD0xzbo8i/Lkxz9p6rjcVJpZYG3KrjQSt8jaY3ODExU+TzMQoIFAX4cSj3W+u32w4x+Wl+QD8drHDl2qrD7nFgd7pq0CQgQYiK4vA7sVGJyeQPYR8HmcSdkm2FXtXeUbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rs2g/cNn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719367128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnG1sbGbs1jtmTvlrH54yNuEYDYvf8DpjOgAllIIWYk=;
	b=Rs2g/cNnnjfNIfJ2XJZsYch+YbHRgYCV6KO7SjYjyz88mcpaXaULK+c9fNDcz5oJogBELb
	Wmy6sZfA1gAlP9emjNWpKJ7O7BMtscGjyqzfMjqHMLYVDHGn2jVv8o97HW1muB0E1z7Mhw
	/t8yFJ4L5ikwn0zs5K/PU/rIBz9fqHc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-vIKyfcDdNhOMY83muvBJLQ-1; Tue, 25 Jun 2024 21:58:47 -0400
X-MC-Unique: vIKyfcDdNhOMY83muvBJLQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c6f1c0365eso7323019a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719367126; x=1719971926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnG1sbGbs1jtmTvlrH54yNuEYDYvf8DpjOgAllIIWYk=;
        b=n+shQDV5/qTvhaNJUro6ANEuyFMMsj5yMwQgnBfZny5WFOXkxfpkELLP0ICvZd3HK+
         rYIS9w3GkA404w4tLnj70lgy/vacQsIRMnNueZ2/YbzA0y9bGznabIPnAF3AHzCnZUk6
         3ncVZApEMjSZ/iOlSXiz7Kb7vEFeHh5fZr52nsvI65GFqdpJs+hC5ztsVZ38/ij8A5FT
         bhrIMkjE/YSycHKgsNJ44GQwno9EcUJqp+PuyhLKKCP1Fy31aLneJpOC41SD88EujEAq
         p7vv/TKpd4QimjrRnFQLuufpvE80HR2+Ut8s9btfaqrmcKyL+TF5cWFSHPsM0QF4u7fw
         ykhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDCWMRM7pWEtQdsrliemFMgGbb9nZJqosD2gEhwAYo0RIcf5rGg9eklslfn3Z1BxH8wxHgUY8VHun49AK33xDLfaAadm/9CAjZ7VXp
X-Gm-Message-State: AOJu0YwusVUbxqSkSPakOannR4fQFGl088qyRoLNjgYrR0SfNGsEIgxz
	FG4RciAhCoRmKaO3/CT7ydVXJCgCN601uYFEUY1SaIpt/DOR1QviWtPnwh1QmQUfwQmo9q/TPn3
	MCVNkvxMFwPb4m2n7Q7AG2MbzKdT509X+V1Nl3rf7Lb+RbWvu2xp1s72NJvKv09ASwB/HGaJG7u
	3MBfrJYkbK4o4nrLL/tCcj8fMjJECUsvoJSNXE
X-Received: by 2002:a17:90a:d98e:b0:2c4:b8e1:89b0 with SMTP id 98e67ed59e1d1-2c850573e58mr8416519a91.30.1719367126330;
        Tue, 25 Jun 2024 18:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5cItPu7kw+lpFHgT9mFcrgcyIi3eaohdOBIsIuRQUoMjB36Oowm0mQq7gn7+W9fkMRWr+6IMsheb7X2K6btw=
X-Received: by 2002:a17:90a:d98e:b0:2c4:b8e1:89b0 with SMTP id
 98e67ed59e1d1-2c850573e58mr8416498a91.30.1719367125794; Tue, 25 Jun 2024
 18:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org> <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org> <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org> <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
 <20240625043206-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625043206-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jun 2024 09:58:32 +0800
Message-ID: <CACGkMEvO+hAd-JeM-LEAavZqogEhSBPQRhSQK6hPMaVyEHH7jQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin state
 on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 4:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 04:11:05PM +0800, Jason Wang wrote:
> > On Tue, Jun 25, 2024 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > > > Workqueue is used to serialize those so we won't lose any change.
> > >
> > > So we don't need to re-read then?
> > >
> >
> > We might have to re-read but I don't get why it is a problem for us.
> >
> > Thanks
>
> I don't think each ethtool command should force a full config read,
> is what I mean. Only do it if really needed.

We don't, as we will check config_pending there.

Thanks

>
> --
> MST
>



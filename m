Return-Path: <linux-kernel+bounces-228530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5605916154
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EC5B253FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB24149E1E;
	Tue, 25 Jun 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGPJ2bkq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D50148857
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304317; cv=none; b=G9WemO8LsgDG/PDR1DBCN49D2kuDtfzHjD4VoC3TnSoEIbYmJ94ynl20GWvxkDeC2LBqpR3ipqDGWUhRy1uFyxXeZjF8RaLUM2/6hsYrwYawV6ftiNll7TJv30XWd+q3I8IJc6FE2flXuZdLqNB0c2AQoRJadvUH7VBJ/TZx22c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304317; c=relaxed/simple;
	bh=4GQMcGauM1sM2qcIuTQSJ5+jNSGplBUnYe9YXxdjt0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epfod/X6gjitZU3mgNg4mWa47sNbXIxoMOSdiv5ushLsEpjxmLyUNK+r9LVMse4gxL+yevCgYN9ekSGy06PyQAVSVvJWpTDEhqDxWGmviNcSVcgdPu8e5g8HfVmqvXU8TGry8Vmkd+CE8sFBsBiJijldysSQZa1YJ/BqZK+e/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGPJ2bkq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719304314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FtBka9f6WX8BkCVj0JZCuT7A8nh0ozt1KTXqJ+SkZZk=;
	b=dGPJ2bkqK5Kl+9s4LpHaQ7JZf4B/U6W79V26iAnUrA0DiMgHTWHUOZrHM11dIG6Zn+MYiS
	4Ooc0FB6jQwtY5kU3xK6CahdtYOFsHK5xTYMlD4ef0w966i87RpnhcDAjB7JXkVReW9IKH
	AVHK1l4bRbIWuJDZ7nybI4mbLJ7p0oM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-pnTwvopxMGGbv6AZxRkupA-1; Tue, 25 Jun 2024 04:31:49 -0400
X-MC-Unique: pnTwvopxMGGbv6AZxRkupA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6c70438d0cso196303366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304308; x=1719909108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtBka9f6WX8BkCVj0JZCuT7A8nh0ozt1KTXqJ+SkZZk=;
        b=ASHOrBEqzFGv9HAbSngRCAz2jDI/sFgG/JePz9anvbdbjOAF+/szK0HWMYmNU1UBXX
         JSnoiUM1MIRj+Vv59aAVizDioURwcOmMtBC5b1ndDyqSPLdQE0gRjUpA/0JsBQOrJbxC
         X1ckVWbkNNF7afN/HXdHbbQ216UudHPrYaeWzWLnfPVvdhobdGXVFA/FUFp2fBgUyEU/
         cTQNN6YJAD1h1CNnu1CDy4WogEDerIzujegId4VxgmlWT/Og6Yoq//nhGSFkQIrNJuu+
         tl+/YmYEtEmcwxk+Bcp8+iEKm6NV3sgTrzocIyHBSzCrNTaL2Ocemcb1MXwObuB+pWK5
         31rQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6sbP5/SPTq8JodzsK+qR33beX7PvNYg6/XZR2A1eazRPSgmuOTH47loLnuDnPNCgEcIT0o2CxmbT4oueyrAoQHhLhoKW3ufm9wkoj
X-Gm-Message-State: AOJu0YwqXkqfIe7Nj7Z/YuJwuEN+vaRwuS393+tzJbcSmJgJuAz9et99
	KuJhy7xoclibPz/CjdEDs6tLz4d+IywYKT6Q9aoZFhddBfs4/oFB4SmhTTmwaSFIXprdqxMwXRR
	fm2T9c+Rnlv7l0zOiPR3WU/Hbqm7FemB2g34Lh06ZDbQjTAn2aZoeiwnZjLDMIA==
X-Received: by 2002:a50:baa5:0:b0:57c:a7fe:b155 with SMTP id 4fb4d7f45d1cf-57d4bd74074mr5403365a12.15.1719304308210;
        Tue, 25 Jun 2024 01:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxhsR1+izX70xNnvyhK6UwUVonlEeFQMV9kch7eEfTNcHpuqfZ/z/U8gcxRPMmp8lA3q60mQ==
X-Received: by 2002:a50:baa5:0:b0:57c:a7fe:b155 with SMTP id 4fb4d7f45d1cf-57d4bd74074mr5403333a12.15.1719304307535;
        Tue, 25 Jun 2024 01:31:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30535232sm5638857a12.72.2024.06.25.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:31:47 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:31:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 1/3] virtio: allow nested disabling of the configure
 interrupt
Message-ID: <20240625043120-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-2-jasowang@redhat.com>
 <20240624054403-mutt-send-email-mst@kernel.org>
 <CACGkMEv1U7N-RRgQ=jbhBK1SWJ3EJz84qYaxC2kk6keM6J6MaQ@mail.gmail.com>
 <20240625030259-mutt-send-email-mst@kernel.org>
 <CACGkMEuP5GJTwcSoG6UP0xO6V7zeJynYyTDVRtF8R=PJ5z8aLg@mail.gmail.com>
 <20240625035746-mutt-send-email-mst@kernel.org>
 <CACGkMEtA8_StbzicRA6aEST8e4SNHFutLmtPu-8zaOZH2zO3cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtA8_StbzicRA6aEST8e4SNHFutLmtPu-8zaOZH2zO3cA@mail.gmail.com>

On Tue, Jun 25, 2024 at 04:18:00PM +0800, Jason Wang wrote:
> > > >
> > > >
> > > >
> > > > But in conclusion ;) if you don't like my suggestion do something else
> > > > but make the APIs make sense,
> > >
> > > I don't say I don't like it:)
> > >
> > > Limiting it to virtio-net seems to be the most easy way. And if we
> > > want to do it in the core, I just want to make nesting to be supported
> > > which might not be necessary now.
> >
> > I feel limiting it to a single driver strikes the right balance ATM.
> 
> Just to make sure I understand here, should we go back to v1 or go
> with the config_driver_disabled?
> 
> Thanks


I still like config_driver_disabled.


> >
> > >
> > > > at least do better than +5
> > > > on Rusty's interface design scale.
> > > >
> > > > >
> > >
> > > Thanks
> > >
> > >
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *dev)
> > > > > > >               goto out_ida_remove;
> > > > > > >
> > > > > > >       spin_lock_init(&dev->config_lock);
> > > > > > > -     dev->config_enabled = false;
> > > > > > > +     dev->config_enabled = 0;
> > > > > > >       dev->config_change_pending = false;
> > > > > > >
> > > > > > >       INIT_LIST_HEAD(&dev->vqs);
> > > > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > > > index 96fea920873b..4496f9ba5d82 100644
> > > > > > > --- a/include/linux/virtio.h
> > > > > > > +++ b/include/linux/virtio.h
> > > > > > > @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
> > > > > > >  struct virtio_device {
> > > > > > >       int index;
> > > > > > >       bool failed;
> > > > > > > -     bool config_enabled;
> > > > > > > +     int config_enabled;
> > > > > > >       bool config_change_pending;
> > > > > > >       spinlock_t config_lock;
> > > > > > >       spinlock_t vqs_list_lock;
> > > > > > > --
> > > > > > > 2.31.1
> > > > > >
> > > >
> >



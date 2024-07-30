Return-Path: <linux-kernel+bounces-266628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C79403B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4728E2823BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A38F40;
	Tue, 30 Jul 2024 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYWLU9tS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9256D8F6E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302935; cv=none; b=ud1myREk1xH/cN+rTXdICepYf/1j2bTif2vMazvEUsH3+QUJlkcrAbNJoymp7pbUmLQ4AMejy6FZr5qAhWE/JlrQvezoynDiAue1Bb8YanrBNd0OAgsB1iF1XBhzjVBNQn8GwdnbmCTeRiPnwkzNYF5xSXfg/67FZHE7l4jon8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302935; c=relaxed/simple;
	bh=1h6fzE7CDmV1O0t5HtGQutaiZcu3XDixPdfniPx64Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAAln3hca8RwHuygfYvV048MaAe6Brlqntzh51QQwcYueRSJQJUpG/yMJ0EF7zQ7XGVClEshTpIGaNu/d7zbdV4J/Dtgmuc9r0qWfmAUesBpzSK+IgTAoYefZ6bc9c9m3GaH/Kq68XwH37vS7nG2V0Ubq5amQufCONr52IGvyws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYWLU9tS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722302932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rmIJ5vFT5Yjjbs7pVvMcPXGKtaSi+0yKhvgi7LK01Y=;
	b=LYWLU9tS7AmzNsFCFanio96Btr3FXDuqEbUF0US93GRArCuFVNRZ8PAgrVLU8QL0dnqCos
	+03QQEBMLDrMdIeOSimb1cHvme5pkbDsI3X5PnDtGlNYbMWaXd26kejSQ9ZMFTi1v+LFww
	2TrFceLbWW60l0XvD+uxCOHgwt/+nTo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-tDU2cFWUPqK9Pto3ZQUhhw-1; Mon, 29 Jul 2024 21:28:49 -0400
X-MC-Unique: tDU2cFWUPqK9Pto3ZQUhhw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef311ad4bcso41377401fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302927; x=1722907727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rmIJ5vFT5Yjjbs7pVvMcPXGKtaSi+0yKhvgi7LK01Y=;
        b=L+nQjyIjeRVImhXRTvk4BksDHrSVSMjM16Z8QPG/NeL1L8m5cfwJzzaDfx6+aH0Aa2
         KOwqCimjreJ1wzr2jAlTH2UDftCBgyHOAesq6H2yfgIeOnesBEVQLEli6NLgo57czYqk
         p0NReVFrH3Hmani20vl0ql96PuOXMoXYJAE1NS9eIpm9XMqftynnytbSOG/bCPCO96wt
         OvFbJT67xQNtC0cPZdKK5vBFCh+swj82bsE80xvy1YkwfWfDq4roxHZaPb3NXKdEgve0
         O4wFXyY9IhTu7onMqomEBi6uWd0RPb6azx/UEFyh1/xMF4dk9TuZiF9ZBnAl1K4hVb9x
         BPYA==
X-Forwarded-Encrypted: i=1; AJvYcCWXPrcEz+D8eql5z334JLePYrGaBZ3e5lq9XNBkxhxObI7gct1Omk5DGuFr/xeNLkVcORCvuMk/FGP8wtqWCBHOZBJYGDFEcPEqx88/
X-Gm-Message-State: AOJu0YwZI7MHh/NBweNRhFoPslByvzZ6csFv4JoGNOnaP94Pz6bf/Gyl
	WNVGUcuv81F9NvnbrYkEHQLyK9lhhd3hdwZCGVP9t6/CJus7fvaduj52vvIrS5YFTtT26GJ0Cwn
	QPcH4KGEyvWJcxeVNwc/DfbRY8lbpNhkoQKc+Kr7i9arLSDCmq/dUUrc5eR9b56XfXaer4Qidt3
	DrkG8YBCEtnPo4SkG/ORjpug7cckHwaoepH4q5
X-Received: by 2002:a2e:8ed6:0:b0:2ef:208f:9ec0 with SMTP id 38308e7fff4ca-2f12ee05f83mr63094071fa.14.1722302927737;
        Mon, 29 Jul 2024 18:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtzdiCpJ9XgLdCKEY4EksF7k+lVK2MjMN+/4Tci3YtSJYsZZW4stODQlF5ADRUckTfa0JhEthcKDqHdk90vQk=
X-Received: by 2002:a2e:8ed6:0:b0:2ef:208f:9ec0 with SMTP id
 38308e7fff4ca-2f12ee05f83mr63093981fa.14.1722302927388; Mon, 29 Jul 2024
 18:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729052146.621924-1-lulu@redhat.com> <20240729052146.621924-3-lulu@redhat.com>
 <a5898ab7-a2ad-412a-85e6-9c7ad590704c@lunn.ch>
In-Reply-To: <a5898ab7-a2ad-412a-85e6-9c7ad590704c@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jul 2024 09:28:10 +0800
Message-ID: <CACLfguUkEtB2cTBrsC_GaxxMdVk_kXjO-gokDUNdECSuCrsLoQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vdpa_sim_net: Add the support of set mac address
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 03:15, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
> > +                             const struct vdpa_dev_set_config *config)
> > +{
> > +     struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
> > +     struct virtio_net_config *vio_config = vdpasim->config;
> > +
> > +     mutex_lock(&vdpasim->mutex);
> > +
> > +     if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             ether_addr_copy(vio_config->mac, config->net.mac);
> > +             mutex_unlock(&vdpasim->mutex);
> > +             return 0;
> > +     }
> > +
> > +     mutex_unlock(&vdpasim->mutex);
> > +     return -EINVAL;
>
> EOPNOTSUPP would be more appropriate.
>
>         Andrew
>
will change this
Thanks
cindy



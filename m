Return-Path: <linux-kernel+bounces-245324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EC92B142
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00DE1F22A24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2603149C6C;
	Tue,  9 Jul 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6FVDQG4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202627713
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510557; cv=none; b=qu48a9nPeJ7kD4BzBl0eKobyIk332claf58Lg0cRQwlInMvp9q1CGDDhOcG28qrBWnPM+daM+z1qAIdmKAgC6VyS6IcNLyVuLWdOYlODKYobLOofQ9BLsLdH4aPBp4DJRtr1JxkZL3XbjhUN0QhzUgu76okjV+LJOTslEtb0/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510557; c=relaxed/simple;
	bh=bk6TipIY+YZoexVbFgevxA604DBUzZ7+Qxg6gsX5klE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sjr2c2ZZJbz17pKZZLJV2tFkZQWVyQ4MoZmlUhPasknnI6An31CcRLBLGBT3LFOPrLwL+bwjkJ68E+bqFxqz++Ur/Dmcf1RUnWL5eyLw4CfIzcX4hzDta8PgdCpXv4IKjo/JidhBvOf+O+uLLwwEcDU8xV51EWBlP+buVYAwgPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6FVDQG4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/aFi9ih4y79YK2CY+Ehp2n7r5MFyUbmdEljfkFAxlY=;
	b=f6FVDQG4Tdmw3yxc3qENg+kLWXw5VkHRBO9O1prYG6NPOBB+q23N2AjUhV8fJtLDUAwD0h
	6RiRXU2RrdvnJMsWIuG+KzIj5ZG/9NFfGzEac/jN8P/EanI7hTM9Dmk3vLoGJQNuE0YVmW
	j/kbdaWC3wYb5L4R5tDPFlgfTlYW7jk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-amXOoV87NDGjVhyeH0YHdg-1; Tue, 09 Jul 2024 03:35:52 -0400
X-MC-Unique: amXOoV87NDGjVhyeH0YHdg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-58c38bcd765so4020982a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510551; x=1721115351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/aFi9ih4y79YK2CY+Ehp2n7r5MFyUbmdEljfkFAxlY=;
        b=KYFhIUHgKeVi+ygAEHcZDjQuygxtO/ESxaC1nAzz3qZEl52xMWzCXDFn6sei8s9qT7
         dwnUdPj/ny5BMACK5YnF05xY8Pv8wB2r0Aha/rAUtRt+Dp02qU5/qupuRkNe/qCcmYU5
         jBvKxQN7VbmZr1aoJqUKP+ZUj7JVcEP+dRYyQ5m0JjlynoVDx3eZ2quTjf3Fgmh67DZ8
         +79iVs9Ka/+9OsYGzjYPUAJPfE/Fs86kuc1DdAfGa9WbMjutu7Gn/vHroeSaB4IPzFT6
         DXhen9LvPjOSMRu1F3Tnn5/BibBfGvH/PCjIZ6jh/LMwWToZPcxb/LOpvUJ4f3rN64Z5
         5x+g==
X-Forwarded-Encrypted: i=1; AJvYcCUzwykliF1pAaW697Jt+eB8DltTuzVBHD0J0B+gLv7spaZgNgl7KwHeuguWvzOpJnlt8Mq+q+zRpRPNlCGsa3u3ZDmac+cmVQtVZstD
X-Gm-Message-State: AOJu0Yxheoii65COM0B9MfntJz8XZ5H6pQM17ASthDeaU1DpsQOjW2PQ
	k+Y9pSrCcei5KCMXfRb06OVbZkeq29omvpWG7rWIhQ7p2uMnpCDyUiAMm5OM8CGHEo8ZnaOm28d
	dXtohRUca6d3/607naT+YTXJXAwNyehqk1PmAvVNtskNOD+yI2v5YnmnxXW/CuR0kyYt78+wjJq
	A+wwa4TgNQ5rGLP/xjg4vyhRjt4qMC3h+hsuP7
X-Received: by 2002:aa7:d98f:0:b0:57d:105c:c40c with SMTP id 4fb4d7f45d1cf-594bb67e9e9mr997093a12.24.1720510551376;
        Tue, 09 Jul 2024 00:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiWni+LJU+6yVhYpIE9XYIpyjrSEJCag4tVtoxMKRcXeymx8yfK8l7rFpFU9jUUkq9Rln8XyB6tiM44nsNR3c=
X-Received: by 2002:aa7:d98f:0:b0:57d:105c:c40c with SMTP id
 4fb4d7f45d1cf-594bb67e9e9mr997083a12.24.1720510551112; Tue, 09 Jul 2024
 00:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709045609.GA3082655@maili.marvell.com>
In-Reply-To: <20240709045609.GA3082655@maili.marvell.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 15:35:13 +0800
Message-ID: <CACLfguUYny6-1cYABsGS+qtdzO+MKp3O09t_gt-bMM4JgdpZqA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 12:56, Ratheesh Kannoth <rkannoth@marvell.com> wrote:
>
> On 2024-07-08 at 12:25:49, Cindy Lu (lulu@redhat.com) wrote:
> > +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *add_config)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_core_dev *mdev = mvdev->mdev;
> > +     struct virtio_net_config *config = &ndev->config;
> > +     int err;
> > +     struct mlx5_core_dev *pfmdev;
> nit: reverse xmas tree; may be, split assigment and definition.
>
Thanks, Will change this
Thanks
cindy
> >
>



Return-Path: <linux-kernel+bounces-324160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F09748C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F21C2574D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8441AAC;
	Wed, 11 Sep 2024 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlJ/p+ze"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0C3BBF5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026168; cv=none; b=K9p5pUOhSw2c33oW4SJqvrXw/JjbcTPlzh6MudhbHFTIZSMGR7cP00VblZDlKGMTViR11+/R3tvZf7RSnSde0ZyjaX4PSotvPKJ+a+Q5E152bsXywWifnLIRd0to8tM+nw201q9N7zcNT5sFXd/VuPxz+o6cVYonIEeWEJOQofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026168; c=relaxed/simple;
	bh=7lWqkY6rYgWNrKCoSGKWt8J1rPrFev44GvHxux5ASjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZekgInBTlxiMuyOXez6eEnod6rfvSdA0ag+UVosQQOgt4NvQ5hUiHkVusXM6IlNq9flWzc5niu7C9AIsbGz7coL/xoBtJV43vVbMrEBfVIy+KtVCSzy4yzbrci3NNqNLahlitLNlkH5VneZ6kwdHuzyvl20BNnGCyfbW4ObR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlJ/p+ze; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCdT/G6ASLPs+mMu/d0vJMQ3EmNT91XHCdsEZRhZj6U=;
	b=GlJ/p+zeNWYfJv7Cap5MQCOGYZNd3dMUU+3f+Se9xkwn8qmatRLtQ4k19VN5LHll6IfFH6
	kaXCXlyX4rgGgS4vJ1vv2K3rK+57ntoqn2G66o/cQWYsZWwKSCMB0dANbioN5W3MbHg5Q8
	LtUocGUgNG5ddWDs8oJhbOrPffTXtYE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-XUMM8WUyPhiNgJPWkfAO7w-1; Tue, 10 Sep 2024 23:42:43 -0400
X-MC-Unique: XUMM8WUyPhiNgJPWkfAO7w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8e59fcd4bso1748543a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026163; x=1726630963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCdT/G6ASLPs+mMu/d0vJMQ3EmNT91XHCdsEZRhZj6U=;
        b=M+BOkgnLBHIZINym9BbwxXK2kZAQexldnIMi50OzB4nZki/0iSU1Yht2SmeAJxWgnM
         6E7VHGGp/P5mnvdDocB3dOWSQQyJkDLn8a0atdkQtSL7k1to6EX6QUGZ4DGvR2/l5/2j
         YuRgDUXzFBx75VC3Naw1vOjyT2TNlsKqaOBkKCQ+XVZDXzEuVy5sZ4zjxI8+7yqpioJo
         HhZBgMf8xNi8TyGMVBKlJ/+l1nJeIOSVaCkPOwPnVk/XPFlp2TJGeCfxTRiGAjqOQ1xN
         uQeiGT3sA9Pu2CllufyQ0evGVfMX/mOXd0piFo2a1jVXcrVk85/ICuLG2htaUVWT+kHJ
         Ls2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmfFmAiWv6E9nkCNSWLJiAWLAHrq75dMJaCZjEGvxfmiRjZ3KLoTF7LJDReIFx9E/aiEEbUWUVzjM4dqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwneY6tC7PtMP7elg7JF26THCnQjwWh7f/Mu4rHR+iW22IyIETE
	NauV4+Y2WjGg7tNPx/JRg3dvCvUcCkLR7aqC/djNR6Hi5xnYVCt4Z/+odoAZyOIDZT+L1moHL/m
	b+TI3/z3JGfrD68FUyTyh8iOSNZh3K3DKnlJYYPpuev6KDpiSmfZYNdyonWqOW0m7Qo2dT1Z5oZ
	1lYWbJf1uZFzKe595HRaMbPsZ+7YUOJ9eLXLmb
X-Received: by 2002:a17:90b:d0b:b0:2c9:7219:1db0 with SMTP id 98e67ed59e1d1-2db82e7f291mr1947616a91.3.1726026162724;
        Tue, 10 Sep 2024 20:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYtgxoPYgk4ye8c/+6l2b91ppaTpKhlsXURphnUZh6+MgMb6hMovMDONiqGgSgciil5VhTa78kls6GbtJfkUU=
X-Received: by 2002:a17:90b:d0b:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2db82e7f291mr1947588a91.3.1726026162089; Tue, 10 Sep 2024
 20:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com> <20240910022843-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910022843-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 11:42:31 +0800
Message-ID: <CACGkMEscQWywn67yN7fAaRdWkOZV80RryCvyf_02RDWjrKZMwA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Properly initialize speed/duplex and remove vDPA
 config updates
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, dtatulea@nvidia.com, 
	shannon.nelson@amd.com, sashal@kernel.org, alvaro.karsz@solid-run.com, 
	christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com, bilbao@vt.edu, 
	xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com, eperezma@redhat.com, 
	cratiu@nvidia.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 2:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 04, 2024 at 10:11:13AM -0500, Carlos Bilbao wrote:
> > From: Carlos Bilbao <cbilbao@digitalocean.com>
> >
> > Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
> > vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Remov=
e
> > ioctl VHOST_VDPA_SET_CONFIG and its related logic as it is not supporte=
d;
> > see: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
> >
> > Carlos:
> >   vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
> >   vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
>
> This will need a rebase. Will apply once you post one.
> Thanks!

Note that I think patch 2 is probably not right as we indeed allow
config write for some device.

Thanks



Return-Path: <linux-kernel+bounces-565230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41204A66415
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4353B03FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCAD335C0;
	Tue, 18 Mar 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGnk8Ifp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042518E1A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258878; cv=none; b=fdOCQYhyxY4F2RMRxDf2up13drtuf3orObVwBZ8LAPLj8holHGqBWFxAr1d7opw4YK86p9y/8y9ayxBITpN5H5yh4fPSq4MTbSKrGGK8KvP6pH8BZMesO/jqqkaueNOiU0kW1yOnULlCVKpdeepvJivI1t+bq8/DZQ6N5idSP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258878; c=relaxed/simple;
	bh=q9cORwpFr2i7u4nU59k5OUVSEIAbi61v48KFlNjBrec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0cr32sQ4vtnbnw6uMU+9qhMpJPoM9AVOA8iB9i6lMBrjU4V/O4TQwfsjGodc23mAhMaO5GSkk+0IK11DqmUj5a1/kSSwXgSXQG9wv88CoYC9Cf6Cq/dzXIflSj18l2iOw6MKbqJfZGejEWFo0w8TH88FVLTs68IMneQ+Rwe4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGnk8Ifp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742258876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZfDnbuROQarLxKZz2VKb8iNL/v4tVesJARFvFI6DSM=;
	b=PGnk8IfppLLRxrnQps0ZpncuuIc6iOI9jy0FhuBSlX2jZgeIv7+SeRGYLe2rnQuNVzR3OB
	1YI/UD1Tu1saIb1mIzVWOa48nWn0Iynv/x2SdZ7eUyp2VgiacEvkcKEtuDg0T+Ffgtyfp8
	Bdf8yAJkToVxUmJHUNnySAduDBHVB0A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Zy-raxMEM-2l0dqxm1oNFA-1; Mon, 17 Mar 2025 20:47:54 -0400
X-MC-Unique: Zy-raxMEM-2l0dqxm1oNFA-1
X-Mimecast-MFC-AGG-ID: Zy-raxMEM-2l0dqxm1oNFA_1742258873
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so4104459a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258873; x=1742863673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZfDnbuROQarLxKZz2VKb8iNL/v4tVesJARFvFI6DSM=;
        b=cYHNYnXrjv5vnTiRx5fzsJwKTqbQN+Pn1Xisde/ht7mG/1OfA7nKdfZ1TOI7U1XcE7
         ZaGSYEiztISAywGk4NvYo33h44KyWBuCQDswJIjHOBDp1Gq9jmLkmBCDJsSvDQyNIg7r
         e/jSeqAGFmH79Ee8ImRw+8S0daMzo/v6W+gScfZgKM6y80jOTEw7ztam03jcd0LdtJhY
         jD+gB2dcl/kTapme12phC7wqcL3Tvuu6UqUMXzP5XS6LvB+jA4GEK8FGBHNteu0rlLkj
         xA5VzkdBeKH0CEVX5M2/phLEUunVtSa9Sv2oG/ONALbBASo3700cVaWMhbRkjPzSGg4R
         3aLA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Po74wVrhsLyyRm7xcLoIgu8iJUWYx/sV/B8j4NZzFiubrCzI6GG3s05GAENDiPoh/p9kgAspU39eNdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRmaNxc8A628Csfgf0hpYuiVzGTy6qvZpmMU1bql7SBzAsZeJ
	4o70XvvyEx1QbD5QWThTlttp5zVAiCQCFjxl5KQ6u4Pc+kwXZlwpjIZH1BnriVoCTBqmrHUqVJ0
	QVU58kLvAHMt+8LquySNCvlcmtNvV6Y6zSBlP0CovjtUnzbug4EJ4IFiSsJA8HXhjMqSH5gujvG
	NxALlRce6uhatiohbswtNEsir4qFVYkwdPKQz9
X-Gm-Gg: ASbGncsnlROmuYxU2ufTmHadGOxKKkbj9oUut3b6C7weZ57O6zuk5fuqYGQwSqjk9jA
	lC9IWCG0MENRjCSEjXaW2WOQa/QIB74L6t+jIbe8kT6ESK3B6dem6Y/e29T9PPRdGtKU/eA==
X-Received: by 2002:a17:90b:4c92:b0:2ff:71ad:e84e with SMTP id 98e67ed59e1d1-301a5b12f2cmr456106a91.10.1742258873517;
        Mon, 17 Mar 2025 17:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzHqvPHhOWayxt9nOn+uABgh4pj7w82asDqMrwDQrO6X0w+kGSrD+YsTLhPM5iW1l3zRKfAFj+h8otb7DW0Pk=
X-Received: by 2002:a17:90b:4c92:b0:2ff:71ad:e84e with SMTP id
 98e67ed59e1d1-301a5b12f2cmr456092a91.10.1742258873172; Mon, 17 Mar 2025
 17:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com> <20250317235546.4546-2-dongli.zhang@oracle.com>
In-Reply-To: <20250317235546.4546-2-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:47:41 +0800
X-Gm-Features: AQ5f1Jps6JQeDE5rVwNMXQm81xnyDS129cpfEryeka1nOPKDMf2qheCIDs5KSLc
Message-ID: <CACGkMEvDk-GzpVMPJPEJLRSrJjVHFsbXsd7LB9MjNEghbUc5pw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] vhost-scsi: protect vq->log_used with vq->mutex
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:51=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> The vhost-scsi completion path may access vq->log_base when vq->log_used =
is
> already set to false.
>
>     vhost-thread                       QEMU-thread
>
> vhost_scsi_complete_cmd_work()
> -> vhost_add_used()
>    -> vhost_add_used_n()
>       if (unlikely(vq->log_used))
>                                       QEMU disables vq->log_used
>                                       via VHOST_SET_VRING_ADDR.
>                                       mutex_lock(&vq->mutex);
>                                       vq->log_used =3D false now!
>                                       mutex_unlock(&vq->mutex);
>
>                                       QEMU gfree(vq->log_base)
>         log_used()
>         -> log_write(vq->log_base)
>
> Assuming the VMM is QEMU. The vq->log_base is from QEMU userpace and can =
be
> reclaimed via gfree(). As a result, this causes invalid memory writes to
> QEMU userspace.
>
> The control queue path has the same issue.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



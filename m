Return-Path: <linux-kernel+bounces-528065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD0A4131F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38198188771A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227D02BD1B;
	Mon, 24 Feb 2025 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVwFPVFR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77576539A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362513; cv=none; b=qGgJMUmhEU2IUdEsQ7dPRMw1IATsvLAI+oFCWUC1J4zHFffIvCIZzI9MJiIa7XV0FaYgxFqLEYr/b24QHtrijGZ7cBOheV0weHJSrLOf+FAXp+bp05vH7ma/En0fFri3cO/7u8PZlcb0TyEJ/CmVXnSYfWxa/mW41wBiLoRTuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362513; c=relaxed/simple;
	bh=9KMHWPkt/mzP2FxeLtx7HSsZuineo0SUwsWbbSwMoJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmOxPqaOIXHgHIGB6wy1oza29qab3TxtFoA2xoEDn/GlEPaInv7vFiv8FXWYcF7DxPTYTPdcNhNEy9tS0/tJEeubrCIuaOlOIN/pIRvfJ0wghTwXYfujoiFFtIiq9NfK2NyeVSZGWqcXZWwj9lqRjZDueLz2vtW4lUqIQ4COvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVwFPVFR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/JSF4EW8sAz0SacUsjOJsB92EZAvekc+D7nVVJHuZQ=;
	b=KVwFPVFRC+Ay7ZEGF5KKz8v6kNk/SHcpwmh4A3bnATDs+vAzdqeteaZl88MhUT1bAMj4wo
	dMMh8O5se386vNxaQBRLXAkwHrCJHG7rKP7XrWfph6Bn0TJRKDt6CO1oVDo5RPhsH3bB7M
	jpiahMKO/bwwijdgmdspn/M6YcVxiwQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-cx89w3J0OxKqUpjDon-TWA-1; Sun, 23 Feb 2025 21:01:48 -0500
X-MC-Unique: cx89w3J0OxKqUpjDon-TWA-1
X-Mimecast-MFC-AGG-ID: cx89w3J0OxKqUpjDon-TWA_1740362508
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1a4c14d4so8360355a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362508; x=1740967308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/JSF4EW8sAz0SacUsjOJsB92EZAvekc+D7nVVJHuZQ=;
        b=D+xsgj3a2uExbGBdwu3J+wCclVbhESSDWXn6CWFy08p7YkxGDkmi3+4DhPRy+xZRCo
         I4EcuET+CJSyrCiMnGnM36aJZoVfEoUF4YFeiNKI4pG8e4coKcO2UUteEx6/VEe84jfB
         KFeqE6sWGkKq7mGzlcxdjQh/+7m5+sKqYQI/9jc8wd26rpgiMbeAnlRdaH4OF2RNDepv
         Y9HiiV1UMM1S10WdfFh8cHIrYXJ5Wj/ZUcJTIiPPePWCZ4a8yTtCxW5hA7aB9SIXFsRM
         p5RtJlYjgX1HHi9BdoAbwNZJgagNBG+cPIYgRefVHiEg0vydcv0+7kZs3oN4W3YQV0hl
         UdgA==
X-Forwarded-Encrypted: i=1; AJvYcCUIoDPLXpO/7fsXsxSEfSBOBifj57RDLYTdeGop51aW6s3FQxt9klXeRUpmCiL8KkDUHQcLx42/1LuG/z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLkWHe8urNOw2PqB25apAcU7+aUtZu9fMzYCYNdHJt62SW7Qu
	4hOsSrI48izLtCaQtHCGZAGWA8LQmVCqGRL10eMmTr74dX/A+IX/lthnxUtfDIzrx3VdyMjh1Ve
	BH/G3gcxr7UDyoT580hN7TRhJ1MQO4n0t12OGfHfNtziSlF3V4WtW8tnTGYXDjg4erwVEQBWO9Q
	i2uw5V4KGNvFew6bRYiTt0bAxkCGszpv6+Hx1U
X-Gm-Gg: ASbGncs1Ece3iG/ARhHmAlGg8wmckT0DjWuwQLXJv1huidYlVqPpkBctQIDn/OCvtHt
	MfJNGrsWzJC074zhHhrg1eNfPICaia+q9ar/wzaEp1C+QzSidkS9/VaMxfmpqCTxWriu/3voYtQ
	==
X-Received: by 2002:a17:90b:5292:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2fce789e6acmr18362353a91.5.1740362507938;
        Sun, 23 Feb 2025 18:01:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3byH8eo8Yb3n98mptZs0KnZVtNYk3QfL7gWdOG/0QZCy+k/iRcwVcIGwP8Q5J+01dl8JyIjK7VJiXYwtLwks=
X-Received: by 2002:a17:90b:5292:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2fce789e6acmr18362322a91.5.1740362507538; Sun, 23 Feb 2025
 18:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-6-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 10:01:36 +0800
X-Gm-Features: AWEUYZnr6SSmyz0c1upMGLe9FqKMYegAAGYeATevh8dBr6bWe1ZabFTLnQtaRl8
Message-ID: <CACGkMEtdWhdPt6yOjBsMuqF5wv6kjHH2OV_HHN3gedXDUe2T5Q@mail.gmail.com>
Subject: Re: [RFC v2 5/5] virtiofs: Disable notifications more aggresively
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 1:07=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Disable notifications right before scheduling, instead of waiting until
> the work is running.
>
> After applying this patch, fio read test goes from 1191MiB/s to
> 1263.14Mib/s

Let's describe more about the testing. E.g FIO parameters, test setups.

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index e19c78f2480e..3d6981c0f3c3 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -915,6 +915,8 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
>
>         dev_dbg(&vq->vdev->dev, "%s %s\n", __func__, fsvq->name);
>
> +       /* Shceduled, don't send more notifications */

Typo, and I think we can just drop this commnet.

> +       virtqueue_disable_cb(vq);

Do we need to tweak the virtio_fs_requests_done_work() as well?

>         schedule_work(&fsvq->done_work);
>  }

Thanks

>
> --
> 2.48.1
>



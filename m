Return-Path: <linux-kernel+bounces-430505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7215F9E31D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F1166443
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55313BC0C;
	Wed,  4 Dec 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNdAPONs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D99FC0B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281761; cv=none; b=bK5NK5VtrjmJh7oXdRMwbPhzkN+1N43yGFPN7qMC+GX+a4OcImuKwcXmFBzPoNKWdJ2RpLk/HYXzxhJ55GTsn6qMM3kH0kClv9WMwMzRilJOSVhgAP8xKWbuvM9VYMyDCv5EXKtt2UtbJTgAcLv80Mzadh8J+33SP1rtshfm0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281761; c=relaxed/simple;
	bh=MgmdEGHRndukdNTSVbD12RLjVRhCo7fsl9QialTQEYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHCKnARcD+iAUxg4FHPIVMinq5yJ1OSRszzsvP3aKvxqbNxTmwSLHJ9hANdAcAjNUuf5/6Py1xiD0OsP1vCVwoXgU5qPQGTRDydqUX3GnBR2brLXHh108ghqrHcZgeOlOUxsE7zNjQq0T2yHpDCM0oiicR3BUNCZI9KdfqoHSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNdAPONs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733281757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgmdEGHRndukdNTSVbD12RLjVRhCo7fsl9QialTQEYY=;
	b=FNdAPONsZ3lSniFMZ+jKnVCiA+DD2AWhnReReSeszfE55MLv4xXHFKGMqUJdEx0Il1Z5Gx
	aiIVWTo/d0O79AlBXhYUUoXX7QNarm86/6OIRJaGV+WQo9cGRp3KChTN9wQUOCDQdKZjzt
	VQlc3TZ7bN4VMjUiiAH9YO24/F+wvLo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-YKB1uBiQP1KOO44AlrSaZA-1; Tue, 03 Dec 2024 22:09:16 -0500
X-MC-Unique: YKB1uBiQP1KOO44AlrSaZA-1
X-Mimecast-MFC-AGG-ID: YKB1uBiQP1KOO44AlrSaZA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee3aa6daaaso5316642a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 19:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281755; x=1733886555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgmdEGHRndukdNTSVbD12RLjVRhCo7fsl9QialTQEYY=;
        b=EYJgRGbNlgL9XnGWkedxAMmkQq7I18yXTJX4VJEeMwDsSXDOwzql2OO5EaDsik2jN0
         tQYXuosr1egqRZJmB6zQOqzvL+QSJKqtmrD1K7xBpXCJSgPTfeBgeotm3li+Rjc1Ye18
         Cx+0VjjL0T4x6Iwho2n7MNTxcoIP/OoBgDnp2GDB8WARlU4moC5MhNMaBbj1N63UXlmf
         wfNjC4U6LC+hMZNoE8ESBPaTkoM5eHf/IrInMRnXTSM4zm939q4oz1I8JYMY/WxxXE4y
         nZZKcA6+dvvJCuw65kEwpZBOxPLnjEZrgWqe82KepjvboZcj0OTS5n1DzvdNUezXNnAu
         bdgg==
X-Forwarded-Encrypted: i=1; AJvYcCXoiYWycMgAgUYORVLa7UnzgKEa/PsRgb4NBpleZ2zupIhI1+igtqoo+JPn0KD9cP96XaSKPF0T6T61tfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAfdWCDEu2hRkFUgXAEZoG4ME00ox+hGYPxnz0r3sUjvCZe105
	VeYCMQ4iWQKClDT69XtOMzKk3K3sqiSF/IDU2mM6dmLq9u0wBFFo9ownZN3VXUB+s5TM2GRYioU
	q8oLYpNz/zdY5IOkMxhY9xsiuA5wWX/sKD9RyT/rcG5uO2GZZMA+X5+wvd1S+RoRm2BVyo7aJuc
	4npSMzBbb1SxL+vNU0KRZLZZfsK0KLfdSB453B
X-Gm-Gg: ASbGnctqPvJfKma4cNQgdONzWJAobjIDSkcmBGyKFgQ/1G7RDOT8GhuiQaxc3zWE9uz
	LdxVTpXNeSO59/0pQRvnxUGw9yjlMUIIl
X-Received: by 2002:a17:90b:4fcf:b0:2ee:c457:bf83 with SMTP id 98e67ed59e1d1-2ef0120fa09mr6191074a91.19.1733281755684;
        Tue, 03 Dec 2024 19:09:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRyq5Kar+YPrt0fIQIwOO5QkraST31h47uN6/R67k+FK85B3TAjImC5ClI7yR+Xz7aE0hgCtXnDh0broXLhKQ=
X-Received: by 2002:a17:90b:4fcf:b0:2ee:c457:bf83 with SMTP id
 98e67ed59e1d1-2ef0120fa09mr6191042a91.19.1733281755308; Tue, 03 Dec 2024
 19:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGkMEvf9TS6c9PTiwWn3POr33m7m1shNfHOkviZpk-Pkbf79Q@mail.gmail.com>
 <20241203023743.1757-1-yuxue.liu@jaguarmicro.com>
In-Reply-To: <20241203023743.1757-1-yuxue.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 11:09:04 +0800
Message-ID: <CACGkMEvWNb0XVYjm+bOSaFB-U2Fi4H22pwXvQBq1-5T-DqANMg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: implement kick_vq_with_data callback
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
Cc: lkp@intel.com, mst@redhat.com, angus.chen@jaguarmicro.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, oe-kbuild-all@lists.linux.dev, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:37=E2=80=AFAM Yuxue Liu yuxue.liu@jaguarmicro.com
<yuxue.liu@jaguarmicro.com> wrote:
>
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
>
> Implement the kick_vq_with_data vDPA callback.
> On kick, we pass the next available data to the hardware by writing it in
> the kick offset.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---
> v2: fix build error for kernel test robot
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



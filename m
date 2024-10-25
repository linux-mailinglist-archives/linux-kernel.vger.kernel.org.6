Return-Path: <linux-kernel+bounces-381272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CA9AFCD2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B0C1C21671
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614FD1D27B2;
	Fri, 25 Oct 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMN9a6Ls"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFC1D26FE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845774; cv=none; b=AsMmIZZPGo8wMm0tYDZ8BI9MzVNhJfHpvrCI1lIkHjEf9diDbkPDUhGXpbsN9lrAmZSLuuwLfaIP0EYUalzoK4FEZazKchzCNQBC5HyUYOVaLjTBb83zd1YfLJ6lBtnQNNKSF619C2Vje4xbb1Pdv39z9FP9j0dDe+O5we9sT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845774; c=relaxed/simple;
	bh=ESF8HNfQuBgJctBd8Wbfrf3fbvtN7SVW+NouVhQec20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5zgxbqcXW8KLKY/qiETDnCA9RncEc9e3Fmg1yvY8GklJflicqTmrtSutxQLoFqGHuXH/SLtXNgRzQ2DkmyJJ0nVDdwL4/iks16V8u0OAUdFIgCGU2+k/Xl1BdMOKVip7Fm5mcYUTxTanpna+IcS3LP9oKAd+CnPlAxcfW+s6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMN9a6Ls; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESF8HNfQuBgJctBd8Wbfrf3fbvtN7SVW+NouVhQec20=;
	b=IMN9a6LsffDGU7U58imUHnqwSPCy8yzP/UshRqLijn026KO81bHmLfhmB71lzqFZZjmu2i
	f9GUwGcboxwCmM0ihB2LNcRfKHmrqIKwTxCRy1cYLfc51KH4Mr/LHHj6SI1xiWL58GkS73
	Uulu2tzosm/dJSNqD8cLIbH7Tse0TA8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-BKBgHtqUNoOI0TKyminMHw-1; Fri, 25 Oct 2024 04:42:50 -0400
X-MC-Unique: BKBgHtqUNoOI0TKyminMHw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e6d31b3bdso2757034b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845769; x=1730450569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESF8HNfQuBgJctBd8Wbfrf3fbvtN7SVW+NouVhQec20=;
        b=Ot5in0F69jkJlW1CNt0DD87HAthC5UK5SjGHdm1OxNPluK6y5ZfpWbnS/faG01oxSz
         tFQgBPkHiOOg2AmKt645X26EOFAnuQAN20oTFi859E/uCheesKpw/3b1fu6cVNHoP4kg
         F06Lt//DTaAciSAugYm3Xo81Wn6pYPk61G0NhT5EzvfpxlUdIOGIKIcTMzqzh2kEGGY+
         0wPB3097UeuPeX+NFtJ7qnlNwlvVV0On8XTFxshXPnGMx476jS0qt9Duyog9rtcy3hJM
         Gu1+F1YYTaQCEm4CrijbEbeCa0uwn2ss5zcNqw7zrq/C5w6VpjBKZVBhEz4Lm7r+IWW2
         W8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCX5VHQap/gp+ZNkJAxsk5hWXYDmB4GzYNLaYvMlcLg0+S+OG5INb8BqGIt5g3i85Z5gQJsLwp4cfXqCU/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGapTf4o1Ns2Ofbpa2ZJznu7KDune+R2xkUOXSqkJxFD+ma2AH
	vkj2I/Chw/sUZ8wGMPPxSSNXvewY4Er6hTMzKlTYbgM/leL5bsJm4S2C2gTvyhs16HavmZ896X1
	XygNotoKZpsGFivAR+7u8G2SRpsLUK9B3H4agulTAeLUDIvUHI+0UNEgKs48qDuzCDX9R1tSUGK
	QTO+Gg2oImU1stDomEc2+v7Jkmdqjn03YmoQU4
X-Received: by 2002:a05:6a21:1698:b0:1d9:9b2:8c2a with SMTP id adf61e73a8af0-1d978bae307mr12136712637.34.1729845769456;
        Fri, 25 Oct 2024 01:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqWP1hxccUA1MVos/H7lZp0gFmu6rQMfRQw9i+PiAUNz6qgFFpbHPa8aaG7pIBJG1XwjsjvD0LL1HzXXPt6VY=
X-Received: by 2002:a05:6a21:1698:b0:1d9:9b2:8c2a with SMTP id
 adf61e73a8af0-1d978bae307mr12136687637.34.1729845769020; Fri, 25 Oct 2024
 01:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021134040.975221-1-dtatulea@nvidia.com> <20241021134040.975221-3-dtatulea@nvidia.com>
In-Reply-To: <20241021134040.975221-3-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Oct 2024 16:42:37 +0800
Message-ID: <CACGkMEsOpz1S4Dhx2PPb1kdYc4f2SxX-55QT6px2TF1g9R_A+g@mail.gmail.com>
Subject: Re: [PATCH vhost 2/2] vdpa/mlx5: Fix suboptimal range on iotlb iteration
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:41=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Si-Wei Liu <si-wei.liu@oracle.com>
>
> The starting iova address to iterate iotlb map entry within a range
> was set to an irrelevant value when passing to the itree_next()
> iterator, although luckily it doesn't affect the outcome of finding
> out the granule of the smallest iotlb map size. Fix the code to make
> it consistent with the following for-loop.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



Return-Path: <linux-kernel+bounces-528061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B287A41317
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DC8171DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4318C1A2388;
	Mon, 24 Feb 2025 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pr0PKthP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1F198E63
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362275; cv=none; b=TE/UH1MsOT7ldEqoBEXmdeAsHwug0ZiINaN9aBFFHTvZVpOZtnCZKm/jcD//Wp4xf/oagcI/KqhXXfZkPjrLpIob62/6qg3wfFRXhKhZwOfNK/Z2cY2jztItrKuI0XIdSZ1AffVfD6hvTCrDGRCZY3obsqoJ/Hfq2Ert7XZ7/gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362275; c=relaxed/simple;
	bh=vaLbHjmidwioWvktfwCGhYibt4VsmiTOJwXQD5tcJAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHTuLprQZr65X5GjpUniC7cmMSe8xw9nQ2MV2AOf7yzxZ/eTu0d9QWVGJSHqrG8pf0lL2ZluddC+ZZ3yBF8RumZrRsH5/P+LpH72kMvSYGKPCyDUwnsNd90v7LXOi15p2Bo8VOZ6P4fmXwnBTATT9pp5uD96poxHIM9kMdF0bQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pr0PKthP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaLbHjmidwioWvktfwCGhYibt4VsmiTOJwXQD5tcJAE=;
	b=Pr0PKthPTp4WlgnKzgvbD3n129hzDrjhggbyQCOV0rakcAekhy7WoKoKOGWcRju3NjDUF8
	eDMghFq5t7wsFVo3E2Nh04khkzZloQmKGFBmOq9URSv15iIYwK7O6coYy87Ahi0/NNJjoT
	0kE3dBQ4R9om5cA1P2dQ+PPuPjwJJlQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-S-2Ksw7mOxy4cEZ_FxC5vg-1; Sun, 23 Feb 2025 20:57:51 -0500
X-MC-Unique: S-2Ksw7mOxy4cEZ_FxC5vg-1
X-Mimecast-MFC-AGG-ID: S-2Ksw7mOxy4cEZ_FxC5vg_1740362270
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc1e7efe00so8201695a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362270; x=1740967070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaLbHjmidwioWvktfwCGhYibt4VsmiTOJwXQD5tcJAE=;
        b=djPmc3k3QWdvQ5cKjCJNjO4Khrqosjlah4IawxmVLWcT6vK70EsX/u6vT4EDfvKB+G
         ySGnw5SuRgBFDidl1A6lWpN28FoAfgF1wKhZtlz6ARgqA0xWmiKTjT2tzW+GlZEJr15e
         zSqaCyEoZyEvMZmxNzXx9i4oYDLLaTUFEvu+oI4ownNrIMxaJWvVnMkoLarF6C6/NOEM
         qZyI2O66qCzI0inh8ewmvGm/EMzDtXAgdULmr66/Cilu94Q2012tGyo3ipxPgTWTeya6
         ERud7fwHZfwah7erPRM0IHLJLUiSMxxyMwgu3iwAq3XPAbknSBSLm4JJbXfNw6NaSk58
         C+nw==
X-Forwarded-Encrypted: i=1; AJvYcCVY67ZWWcdFwkWqpfJFLERyOWXIkxV63wYVFc6RihoKi6QO7Oo0L8wogTKEZKBdNIMynxBdvn6566k8SlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+InwnVlI3TYvHuIgFwL3O8j70zyQx7nHvzpHWDLabJTCq0vzE
	bD49I+35KSoYnUlzyho99TukxcAhLoT+0d1R8ELU7PnC4SIcV/1TOVUcDttQlPs7uJKui7e1EZ5
	UB6D1NSaW8WHAS75CXIOoJpq75B7Sux91PsIdg/InRSZIzKHE8deqQWsbkRedBf79Bc/3P0hypQ
	aUftPfcML5V7Cb1CXbhz6IpRvRIt9grVEpsNg6
X-Gm-Gg: ASbGncslpq/O5oncMW/1PjVrNYLVlg94PPh/e49m/bkB37y1fnXKy6N/UsJCZMtd669
	Vw/OeKyL/pwFPGoHLba4wM9b1h+YImk40XlEc2wOzHT2ePXDMbzCVPV5YW+M4fNbwJKasUjQ4iQ
	==
X-Received: by 2002:a17:90b:4c10:b0:2ee:b4bf:2d06 with SMTP id 98e67ed59e1d1-2fce86d0e70mr17216788a91.19.1740362270354;
        Sun, 23 Feb 2025 17:57:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA6Evp1R/AVQM43Rg9j9ev6km34s4eDr/KxTbJj7NcHwjPHvLjbL/J1ySnYtiKgEU50Z9QwUmLV9TIPv82Ck4=
X-Received: by 2002:a17:90b:4c10:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-2fce86d0e70mr17216773a91.19.1740362270040; Sun, 23 Feb 2025
 17:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-2-eperezma@redhat.com>
In-Reply-To: <20250221170626.261687-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:57:38 +0800
X-Gm-Features: AWEUYZkwPGV2vcMfr-OnyHZZ9WyqXX4DsYi3NmTeAiBb2tUM_BD0LSWZEVb2-QY
Message-ID: <CACGkMEurYAGHx1FF5YgS=T-4CDY8dn4B2sQJB_ojRxDdiqB2YQ@mail.gmail.com>
Subject: Re: [RFC v2 1/5] vduse: add virtio_fs to allowed dev id
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 1:06=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> A VDUSE device that implements virtiofs device works fine just by
> adding the device id to the whitelist.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---

Let's separate this from this series.

Thanks



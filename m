Return-Path: <linux-kernel+bounces-403727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0859C39B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FC91F21579
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63CE1662FA;
	Mon, 11 Nov 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEYBnQ/E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BF42A8A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314233; cv=none; b=dsRDuLU2ucJSYYBBW4jvFiTXW7tXg4ET5xydhYhFMceOwwKuJjLJNQaarCwuYqYYKyrZMrTR14jWAMF7utt4Q84KOYpYG+Zw+AuBEi2757HsDEYAe1LZffoe4aAmCCRrnYGzWFqtycwl6lTY887nFpvaX0fKY45HSXZnxyxfbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314233; c=relaxed/simple;
	bh=SSX2S4tLU3+tI1quOKFDgN4HoiaVYP+wrBKENYGKgI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjjTXBhMNjUDFw9nBREFH3jsBZg0oa/POgoE5Hz33dcXvqFwESuhrc3ribFEtl5+oxKbzUd5EwNabcRSUC55YYOI1DeDFwWhhrlT0xD0cWnebiMRy2LDaAWUQdXSX18KWk5ZOmNpO9NYTB9DHaYO8zvpJEKwHqMprJG79sydHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEYBnQ/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731314229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcpmht/nC/6Ldeh7ooxXZiHchbJtFHR1QbkXPfVWBzE=;
	b=KEYBnQ/ENkT0xudBEa8XEQYVLpP+eDjkFvXzS7YSe61/hrlYr2ATb1kvoMaKszSDolxlXr
	pbhbGm5qSEOKpKRqSSOxDAS/SNTCUa6m3bjGCOAGPJFfXGhl9MBKFSuo5xySmzIHq2TW0z
	Kb54+ivcRsw3gBDaWaqZ7Ymw6RcH4Zw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-AvKHJuBCNL2mgc3MoW5_vg-1; Mon, 11 Nov 2024 03:37:05 -0500
X-MC-Unique: AvKHJuBCNL2mgc3MoW5_vg-1
X-Mimecast-MFC-AGG-ID: AvKHJuBCNL2mgc3MoW5_vg
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7edd6662154so2988682a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 00:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731314224; x=1731919024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcpmht/nC/6Ldeh7ooxXZiHchbJtFHR1QbkXPfVWBzE=;
        b=WSWyojzjjRAwrtvLinafUoZAthAtWEOI2II9yMQ76bf8W153PigtmxbtsymEDiOERl
         yQJDdkinsra3xRxM0cthXp38trbE2MuldPL/NkTx5NVhBrcXJLh2wOip1D4sUQDqipRK
         SHzeoZGvlgPeJFfsHEJHwQyu8AzVSLW7FsCme4oiNI0stOcSofzwjV4O8sP7bd5ldlnR
         JJKR4WjgFpDp3jgyl254w0QGYfpYIda1n1FtXDAYJ7XrEWmqQr9F1ljX1WtaAJeMDwBN
         0YcUut28RnB8iTn2UI9+hgVSVBftD9LYUU3xhG975ap3O2QW2D4UrPvHGNrhoumxDi2G
         TFLg==
X-Forwarded-Encrypted: i=1; AJvYcCWHPQaC6hIXnb7Oc3B1wmP3vAnMMJ6tokbD06IYXz5nTe6Db4XKdCnq8jsWoKJo2AjHnUzPCCFVy6KIEhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXi+m36y83wxtMo8mKzz2/OcQsQpJ1xztEndxmyu++7TTgQfz3
	mHP9D0iUBKRjOgt088Mu1k24GrRea3QsHr8/AaucP6pr+VKh64E7A6XHS6oJsVMxeoDlZZRhLp5
	apAcOuujUtJ1q2YUknHmNAuZzh2qiRu5odjmyhs2e3sKDEOP6ETZD7H82xaYpu352SWbv00Uffm
	CwksZp8Cn/0TOW1qOsuFmEDtiQniYsA8zP8igw
X-Received: by 2002:a17:90b:2642:b0:2e2:e4d3:3401 with SMTP id 98e67ed59e1d1-2e9b16ab979mr15603595a91.20.1731314223958;
        Mon, 11 Nov 2024 00:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkW8ZHgY8oLa66OOGt0FSKjysNNtKl/NkU5rD9hEEpLrZ1hrx/0G+1xyjW7t0R1U+85Oa0ZRTBG5IovF9dKoo=
X-Received: by 2002:a17:90b:2642:b0:2e2:e4d3:3401 with SMTP id
 98e67ed59e1d1-2e9b16ab979mr15603578a91.20.1731314223570; Mon, 11 Nov 2024
 00:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111025538.2837-1-jasowang@redhat.com> <20241111022931-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241111022931-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 16:36:52 +0800
Message-ID: <CACGkMEuCx=ht2Q75xJ11EGsjuZPWcTTpGh7OyVEHCOhGDB5f7A@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 3:30=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> > There's no need to sync DMA for CPU on mapping errors. So this patch
> > skips the CPU sync in the error handling path of DMA mapping.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> DMA sync is idempotent.
> Extra work for slow path.  Why do we bother?

dma_map_sg() did this, since current virtio hack sg mappings to per
page mapping, we lose such optimization.

Actually the path is not necessarily slowpath in some setups like
swiotlb or VDUSE.

Thanks



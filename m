Return-Path: <linux-kernel+bounces-265666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A693F431
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A5928623C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38814145B25;
	Mon, 29 Jul 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e6NJG+AU"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0191448FA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252981; cv=none; b=OlZeHTcG/yXJ3/HTqM70/ab5fSel1lSG2/SNZfU0vCx3nLXUfEqpvxO6ccL6NrM6EYog+fvBeMQQt9Uta1YeGkPRe1gRhvdIDJzKNh5cAD/54CK5QeA9UQQRimr4YTOQjU4h+PupxLB57Fj17aoVdGBE2iSHFeT6jqL9ceExQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252981; c=relaxed/simple;
	bh=9d/TuvIi2gaVki/61lDkSdIbeGequPDx+pBjCZNjcnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpjOTqIQc8VPmvQGSTAnzFAUI+rYLjZGQ6fXOMDq+SljJy63YAhhPT4jENmGtDgVtNiq6JDR4NxLDgDSQzubzMObpBHz1zujN+dxv8vQo0/g8drNKxx6/KK2cgEx8jcKsgU+F8dvQmKMBFY3TcBCQJ6AObYQmU4ykOPdgZZqHYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e6NJG+AU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so242149166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722252978; x=1722857778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KF3mlZEDxsHIPxRij6eufhwBQK9CK0HzJYTYEnEj7k=;
        b=e6NJG+AU7bvhMyO7XK7VFDXFLBSLx+wSJlNE5GeqDoKWmFcx93lSZqNzOnEcfZBsm1
         +KexIa7bISvCIVHTwIkeyPqv/qdqC+hfcJr6V/rlLZcK7SircOPysAgxaoZ4OcLjJcqv
         qjbOO6E96Cq2+JGydEodAZt54+gdbLTs7bdXhXRmlo4+4JPkEXmaBEe8mNfqsGMFQlZL
         wfJAqBrij6i63xeJnZ1x7qiloaDhWFaRYppzUTcKukS98nh7rm9cu24nqzdWq3mFJEBf
         6nV7YGcvmaWIQaN7Pf3yjLc7cejOFJcxjPcet4sx6TDMvoee2p6gAjQ/5HyP1qJUVEmz
         AvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722252978; x=1722857778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KF3mlZEDxsHIPxRij6eufhwBQK9CK0HzJYTYEnEj7k=;
        b=O8L3Y1Kwmqa1dj6026O11G01iD6Q7IZ0DaeKEDW1TR99pjWEITDZSYA+s2O3sxgJH5
         FPThw1Hexwcj2OOfiyIPS9o8xL13+/5Udk1K1mY3Jw2q671/4kQn+KCC4YYG5YkfcBRg
         tlFY5lIgN7xCgMOwamoz7tECIwDCZI+t1qPEzQy0EZ1qzj07It0Kkfseaj3oEZyZmrmQ
         d9A/wTsrR2UsJ9JV2L8rs7RjDOkcjeiDtN3yKZ0omEm8HcFbfOTut1QWpV1espK7zeNu
         qUvO9uyZJrLWtnF2jGcbBUGVmf8ZiI0tbldGvmM9S2HBcs/QmFzDvAhAPlGmcTUSMdT8
         tYWg==
X-Forwarded-Encrypted: i=1; AJvYcCULlFJJb8IQv+o2JcUu40UMNmRqp8+RG1RwK2MPnY8PyHA5e81Me/XhYb0gCeC59rFI6d6GwkAxke8xSsHkvYuHdJh5N8N7UIwSk/bS
X-Gm-Message-State: AOJu0Yyql6RvYlp+vw5XADV4hC9ZYxoLDsAtWRo7BaMXxs6T3IBINh2m
	C82/52lZGPp5rOeRj7rBJsu2075TFhYudwvTympmKSLilgKPzFixBLrRUSLvs+CjfpI9DrcNV7d
	zalGZRHrvudp6uGxJKNDLSO2qE4qBCcmJUtE4Iw==
X-Google-Smtp-Source: AGHT+IGKpUG8GjQyZSSGXOjOMOggSW6ZJ6EszzZi7IF1MSWLkKJ/Q8dWEZAXvw9LMoCLxfRh6TQumDR0DdnGLtVJdlI=
X-Received: by 2002:a17:907:160a:b0:a7a:8cb9:7490 with SMTP id
 a640c23a62f3a-a7d4013523dmr456527566b.47.1722252977589; Mon, 29 Jul 2024
 04:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=zCy9Y87R1qw@mail.gmail.com>
 <CAKPOu+8s3f8WdhyEPqfXMBrbE+j4OqzGXCUv=rTTmWzbWvr-Tg@mail.gmail.com> <CAKPOu+9xQXpYndbeCdx-sDZb1ZF3q5R-KC-ZYv_Z1nRezTn2fQ@mail.gmail.com>
In-Reply-To: <CAKPOu+9xQXpYndbeCdx-sDZb1ZF3q5R-KC-ZYv_Z1nRezTn2fQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 13:36:05 +0200
Message-ID: <CAKPOu+8q_1rCnQndOj3KAitNY2scPQFuSS-AxeGru02nP9ZO0w@mail.gmail.com>
Subject: Re: RCU stalls and GPFs in ceph/netfs
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 12:17=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>  BUG: kernel NULL pointer dereference, address: 0000000000000356

This is obviously NETFS_FOLIO_COPY_TO_CACHE; this looks like it was
caused by 2ff1e97587f4 ("netfs: Replace PG_fscache by setting
folio->private and marking dirty"). That commit uses
folio_attach_private(), but fs/ceph already used
folio_attach_private() for something else.


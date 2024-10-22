Return-Path: <linux-kernel+bounces-377056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012329AB956
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58BE28420D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4791CCEE7;
	Tue, 22 Oct 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs2O2b7r"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0413B58A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634911; cv=none; b=K9/zhFcn6NMBmHiib1j/EA63lNFdvSyXYgY2ap47z0nr+Ep1IKQ6IcerG6EJ5bEA8eM5wUh8BYU/t+Ybi7vB6x4dPwtUY29+v9MC+ZJS0YrLZswJKLjFIpIE+hIohFyGo5jh5JSXbVx/I+vdl/eGR9MsV0GYWEzKo6JFDs7ROuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634911; c=relaxed/simple;
	bh=exrAnHLSWPpEiERh2pwZh6dYyXTEzGOqExE2DJ4x33M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kff99lmVxE86MMHLSmLSYkCuGfxnyCVLPG+fgQLv3EAIahDn/ZSqGl8gQb5e+esSJLsfXUt5iUZxPtvjvp/EUihtwpiAlBWumLDIL/eyws+wTuSVVTcKM0MlAJ+AVanZUZcQmWnF26poeCdeIsertBwJO97SmrB7i4qOv3cARG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs2O2b7r; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-851d2a36e6dso151050241.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729634909; x=1730239709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1EdHuO8J8iAbx9XEg99EM0K+vD/8zpQZPET6Q+8S4M=;
        b=Fs2O2b7r+Tal8UVMoPoZLSS5GDXM8bw60HLAXvfJtnI5uGrUKH2qoeE9ZQ1XAQFAfJ
         4r3WZRG6k1zX9jA/nI8yxhi1E84J4+8KtfyhZnBLf5ItfT0LxcnSfv4gQwY58yDVl6E1
         qhZcXwBsfKBx8MKk9Im/4oAfOUcVjzOVKrE+G7b7raEaMNsMP2THSWepUUVgZrFOndgw
         NexAyyEE0GTpz31p+BAFtiiteCBbiXW3Xoq51tZ9X2U6gd2em6KcH0ttLFlYIK1pKjMc
         YvsAPmefVkq1/GBKlKE6VkhSRYaDFoUkO/A1biEP8ydOFa+Ckqc4/+W6iCM8vG1OrTql
         L9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634909; x=1730239709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1EdHuO8J8iAbx9XEg99EM0K+vD/8zpQZPET6Q+8S4M=;
        b=TYN+dBkiZOK3v83HexaGdoFNmgKUfwZsZvo8HNn2UWnroLD2Zs+HDLER3Pnp6kj4mF
         AWY7UXCeLzb2Q+jwVj3EWFWIzALciWTuekMkWxTpnyikaGJaE+KjwK4ltwgCozA5pCbW
         abBXGmQoLbhVzq+WOa6wQWn072o++LKUjzknTkfjZ8MPPbz/Te1yrpeJfUDkSgUpqObL
         XfD0Y0R7bHathPVOGb+UNv0aG9Ur60gIPHXL9qda2Kx5Xc+UQUS8ZD7lbyd5Si3gveQx
         hrAiITzmM/DdS1hnKZKwAtRFW+izPcxU/JaPQUU1q+zfAoYG1rdjEzNpMVx4EmkFaPbO
         +DgA==
X-Forwarded-Encrypted: i=1; AJvYcCWuTaFgn8Ne8sWNE3+kZBDrmvBGCuBoPU1th/oacjnvsJma9czpPhrOdaJGHFFizghqzgnaOFdyvqymynA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OLweMpNhXz3IDnqZJArKVft1b/gEwgqxJAKyHMl8ays9ijgD
	qRK4jd8Mf+gUQ4PNErgk0b2q00aX0eP41uqMqgpbnJT+oQgNNvyucI0NhFwW83sXzyatZdzNRo9
	PcLWmaBQ4K77oU5PiZhgarfPOU0E=
X-Google-Smtp-Source: AGHT+IFR4lJPOvtab+BXMERxfYcK0NvC6Q7/68IB4+RkRk13GEKMIotK57tlpFQV51sMJcQHm8gAHnfCqqVTeH9MQa4=
X-Received: by 2002:a05:6102:a48:b0:4a4:8a11:a3b9 with SMTP id
 ada2fe7eead31-4a740d6ae64mr3427941137.1.1729634909118; Tue, 22 Oct 2024
 15:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018174114.2871880-1-Liam.Howlett@oracle.com> <20241018174114.2871880-2-Liam.Howlett@oracle.com>
In-Reply-To: <20241018174114.2871880-2-Liam.Howlett@oracle.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Tue, 22 Oct 2024 23:08:17 +0100
Message-ID: <CAKbZUD3YLqWOyN7t8d9x3drJBJFSQw0O9dq7reY2p-gQ-wen5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/mremap: Clean up vma_to_resize()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 6:41=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> vma_to_resize() is used in two locations to find and validate the vma
> for the mremap location.  One of the two locations already has the vma,
> which is then re-found to validate the same vma.
>
> This code can be simplified by moving the vma_lookup() from
> vma_to_resize() to mremap_to() and changing the return type to an int
> error.
>
> Since the function now just validates the vma, the function is renamed
> to resize_is_valid() to better reflect what it is doing.

Small nit: Could we pick a stable naming scheme?
I understand the kernel has historically had plenty of ways to name
functions, including
do_stuff
is_stuff
stuff_do
stuff_is

I thought we were starting to converge into vma_/vmi_/vms_ :(
I would personally prefer vma_resize_is_valid/vma_resize_valid (even
if it's a static function, so it doesn't matter _too_ much).
Anyway, enough bikeshedding...

>
> This commit also adds documentation about the function.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Pedro Falcato <pedro.falcato@gmail.com>

This patch made me realize there's a couple of small improvements we
can still do (maybe with a vmi) to clean up and speed up mremap (at
least!). I'll look into those if I find some time.

--=20
Pedro


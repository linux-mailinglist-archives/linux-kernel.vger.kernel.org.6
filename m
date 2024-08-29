Return-Path: <linux-kernel+bounces-307343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A9964C27
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B381F2120C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7BE1AC8A9;
	Thu, 29 Aug 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WioGiiA/"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F081B5EA7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950456; cv=none; b=Gnr5DXyX1+QSmJlkGBkhLDF2D1DunKrZVZpf6noq5f7N9+ceoLL3KdyFWe1faWzxblY5+FpT92csWLhBMMLUd6HdgcXZzK7DizqPdR4e0km9+2mG8PMpJnmUNGu7tDjUM0qPg1PmAzhS+phkHbc/ei3cT6VNSG7iHQwF6okOxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950456; c=relaxed/simple;
	bh=HivztgEv/VjD4p1WDtu23CWcFDFoHlbHehel8vIrfxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th+nMBkj+dGCpXlfMDSuvOskNYAityKDYt7BIt2p2VxyAigT3Qe+0WfezZ/FDjeRZg0jHjAFmxDsHi7ZdJMugEuAglffjLkEi+EeWLryCwUn/yppJDcAOKLOAyADmiaaqExoKoa5gNtpN4GINS+WCgS/8WWaa0JSU4rAzFLD6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WioGiiA/; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e117059666eso935239276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724950454; x=1725555254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXYGkyvMY4Be6IKs/mexCoTKMNb5qBTFdAYl2PaR7Ks=;
        b=WioGiiA/HtBk33xsAYvLTquyPVxhl/lnHJwqJPlUjnQW4GNKl4nj6NUFmOljbDbWI1
         sGwqPMJIeGqeQian10bmxIauLB8rSJG5RvH3Muu1JLbltriYStpi9q+235FSH5ar6jWC
         fMCLzwgvnO0h0xMJPRYwHsXFkoF/Z8qWMnegV+mUTXhVnUomptu8vH7+/h4I8foYr0Jb
         InnWxV5t7aONXMTw0MXKzKD9ziWRC4Q+rjBrhyLfR836V0XzghmunNpXD/KS5j2uTtmK
         FD6Np/kS3XcpM26I2OyDeQKgYe02UXznWHfM3+BJK3S/5eqvGb8ms+NOut53zgTtICNA
         QXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724950454; x=1725555254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXYGkyvMY4Be6IKs/mexCoTKMNb5qBTFdAYl2PaR7Ks=;
        b=KncYICZ9jdWxwEhe2EM1FENdMM5NBj9k9VHewwNT0PbocJ6uHct7/W3HXt6hu2j8eY
         Db4w44QQ6ElXw7FvRIcO0M/pALAv/V5MeTqfDWL+WD5XPN6af8U+5Yd0ScJutEYMDOWu
         DvvNwXCgiaDTy5zBiCVvHbRVcC6hz++odHuUK5JXtTlRoRgsi1lRZ4A9BGjx5x02tjM2
         6IWNTKFcD2WE7ClSmEBlLlsP3LpmrlBmBmNOZ1iPYo3Osnbps7w8O236JZl8dnE6nqfx
         wYHQqLJ55TAwNWCW74JEVCMXy8xY7g5p9LOB8uB1fxjGrCfwEC5u7zlF+pstUurGreGA
         L7ow==
X-Forwarded-Encrypted: i=1; AJvYcCXApcSLvhmHf7KaAnfdFLaQ/CwIvgIyAQWFygigD5aGLD+1rfRocO7lq6kkerc1qtn8ZccjU/rFp5D45xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMLkxSSev1tRQ7JkY6ylzoGhGzv8pzmiUsnZkOQYAkd7HfOTY
	/9IOadzz7dZK2kx5WYVK7rWobviXppn+YsO5cBu4SMlj3Yx1Tr6MldWB1DgAcD5EhgAXOn91baI
	x8aawjLc6pJ3RyvvNOyJ9GaQY3ThlimY3taqg/zbRCxP6rGCyy0Ur
X-Google-Smtp-Source: AGHT+IEMQMhaKLQKPpoMq1RGaDlAvogj2kDpdcRlLLBZZCFFUMA4ybh6mESyCLFSeqXVAwq9SGF0ncrK3n7IdG+kGDw=
X-Received: by 2002:a05:6902:1690:b0:e11:6203:918f with SMTP id
 3f1490d57ef6-e1a5ae0124dmr4032678276.35.1724950453588; Thu, 29 Aug 2024
 09:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024082224-CVE-2022-48936-9302@gregkh> <z3hh3yrf5wym3obgol6obh3dkmqoc3rwbkj23qcmadf63b47h2@nn2232wngans>
 <2024082854-reassign-uniformed-2c2f@gregkh> <jsnwzpmezgju7r7nkcauaicthkzizsqglb6p43zq25cdvdgbgt@dlkgwkch52qi>
In-Reply-To: <jsnwzpmezgju7r7nkcauaicthkzizsqglb6p43zq25cdvdgbgt@dlkgwkch52qi>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 29 Aug 2024 12:53:34 -0400
Message-ID: <CA+FuTSeHvADR5qbWnzRpYtpvNcvYrAeXAj8LYczUFLKREDwfpQ@mail.gmail.com>
Subject: Re: CVE-2022-48936: gso: do not skip outer ip header in case of ipip
 and net_failover
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org, 
	linux-kernel@vger.kernel.org, Tao Liu <thomas.liu@ucloud.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 12:18=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> On Wed, Aug 28, 2024 at 09:30:08AM GMT, Greg Kroah-Hartman <gregkh@linuxf=
oundation.org> wrote:
> > > What is the security issue here?
> >
> > This was assigned as part of the import of the Linux kernel GSD entries
> > into CVEs as required by the CVE board of directors (hence the 2022
> > date).  If you don't feel this should be assigned a CVE, just let me
> > know and I will be glad to reject it.
>
> The address of original author bounces back. Willem, could you please
> help explaining context of the change? (~the questions in my previous
> message).

I don't know why this has a CVE.

The patch reports that the negative effect is a drop due to a corrupted pac=
ket.

According to the CVE report this requires both user input with
virtio_net_hdr, which is privileged, and a tunnel device configured,
which again is privileged.


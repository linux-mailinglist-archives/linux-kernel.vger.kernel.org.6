Return-Path: <linux-kernel+bounces-545344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57494A4EBDC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CE318903A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F51F25F97C;
	Tue,  4 Mar 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkM6idHO"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A019283682
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112630; cv=none; b=VcXJUyLWqya/aULkcgqhjvTCij09uxFcUipR5d04OvNQp9X+z4mmbgtaMI5Yj0IqCFTME4XxBlh+xby5ogbtiiUX4o7YTQKmbpdY0ZBxFkRHQbQ/sC+ANT7u2PGXCNCVGz4pDX+eZaGlMhTB+z8RF2xT8hjUBJPyw6Jyc12v0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112630; c=relaxed/simple;
	bh=9C3HRgMvOSEa4ktjDvIz4M/r6v4WMGEKoFgWeLzkARM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkju0k8At0rMiayc8fASHWRpo0d6bqYJ0/4g3xDHZXMInZlQizqOwNDJby972ywXDD1TMRaWfnyA42vhbaJzIviUQ80bWStj24WZdokmiU3ZuSum+6nHGJHlMxWj/bRSgg5mo2GdfJgizHK7FVfHjCeQOarwOkO7yBViN3duGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkM6idHO; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5235d7f9599so2119877e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741112628; x=1741717428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTvXX8sSlYolu/q7NpQQdlJiEqFKcsD2LSJ4GjwRKNM=;
        b=CkM6idHOQ6/qPKKIthQAkoq2q5IjeLJFjFvzXvmbG7TqsMXRVBzM1VJcODzlBQcpyL
         e2tdCVtAL6Uxs+8YwRREgKE+DxPGoH2r/+dAuB0rbPij6yJRB2qcvhLbWHIPvsxzKH5D
         HwBN038XUDXUrprG/7WZKZU/Q5tR0ffubNsO/DDwka3mgZ7lLgALgsNPIRAewkIgYzll
         P3Wq7mLevno8q+jJ8SWEIODnEqvl5vA7v6hxBHxFA/2fMGtGMNa/f6ACg/YK2cowYasn
         BNpthy+jEmAa+2ft9vlkoJc1+IVydk0EtUYhZeKxDzu6oWLRTcyX6I8fvGTPz5oJCT7z
         bIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741112628; x=1741717428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTvXX8sSlYolu/q7NpQQdlJiEqFKcsD2LSJ4GjwRKNM=;
        b=qnhialtYhrABbq/PlUtHe0JRdscGYi9QTn0ADPRNIb++4rBb46TKmBRXX+5rUou91R
         e1oGk47OeOSYN9M2Y8T7oS2m9AJwSRsJBdkwTsY+DOcofto14naeazWO2Pj+fZLCysfy
         geZ0fNhSqEdfCP/wc5bt0yxFLHaq6jraUH0bfMMC8HnAyg2pEAIGPQSSn/Tuzjlf+m8F
         d0WDGGWhjQqYzR7eh3w7htnSJieDUx/QCvEBAzT4sv6pwoel01U9HLJrxckxXCCaDWTu
         fsVyNxVtnlMVqtV6vLgGNuAAkKq9zg2wurdAkk8EkH+vJmxdQHNq2FdxkAu6sCAIZbXX
         OjTQ==
X-Gm-Message-State: AOJu0Yy3chnTxGQxr1k8wNsC4ZsWmmg2++rzbLPikQvUav9OybPj8gr1
	52bJb3p4xRI4BqurhaCcPFYDm1p0lKnY43HPMTIpuaT/stpiEU8JRxbuaEh7eYGaUcABpbh9ks3
	Bo3iQel8YpQmqmLzsRQIiB6AmeQ0=
X-Gm-Gg: ASbGncun9GBUEoqJjFwaTfaWWP+VH5i28TEckhEJUho1L3EJeK9uHErT8vN3tYaPy1O
	WR7DoigxZ9DURk46Be3R5PXrYQa/Ce57orb+FLMJnnRGzN/16STc3jBElsTSN5dbFMX4fJnrFqB
	krdvlnTo8BT7c119gcwnO5NGYN7vgcBwR4oLkY0sAIeATwyRkIra5SZMJ4
X-Google-Smtp-Source: AGHT+IEZ/7BRp+uRS9nvklgUVf2SLGq8Z8YVnf3r6v7ElAdA67PrC/xXF/mqmYSEMUQX29CjECzNkD4WGfrOQXTiWbs=
X-Received: by 2002:a05:6102:2924:b0:4bb:e2a1:183e with SMTP id
 ada2fe7eead31-4c044a0017cmr10533700137.18.1741112627454; Tue, 04 Mar 2025
 10:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303221730.1284822-1-jaegeuk@kernel.org>
In-Reply-To: <20250303221730.1284822-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 4 Mar 2025 10:23:36 -0800
X-Gm-Features: AQ5f1JpfsRQkcPF6KIFZ7YMYTdcL01aAD6xF-xk3YtBCXsNdVl8h0JTYeOohAe8
Message-ID: <CACOAw_zmqS8UrpsYeMEEvyc_Xe9edx4ptWOtQBz3UufZM+iNag@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: set highest IO priority for checkpoint thread
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 2:19=E2=80=AFPM Jaegeuk Kim via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> The checkpoint is the top priority thread which can stop all the filesyst=
em
> operations. Let's make it RT priority.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index bd890738b94d..8dbb815a35c0 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -21,7 +21,7 @@
>  #include "iostat.h"
>  #include <trace/events/f2fs.h>
>
> -#define DEFAULT_CHECKPOINT_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3)=
)
> +#define DEFAULT_CHECKPOINT_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 3)=
)
>
>  static struct kmem_cache *ino_entry_slab;
>  struct kmem_cache *f2fs_inode_entry_slab;
> --
> 2.48.1.711.g2feabab25a-goog
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


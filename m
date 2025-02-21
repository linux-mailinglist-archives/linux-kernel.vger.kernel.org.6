Return-Path: <linux-kernel+bounces-525003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17348A3E9B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D9A189F617
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F5D3BB54;
	Fri, 21 Feb 2025 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtyeFnfC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF083594E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100379; cv=none; b=HmFwDlSlhbNuHNSeQNXFVG7rVeVK6oVWwdgMvO2EokHjBclDKSt7EbBUnQtQfZxkQUiL5GoMsksAYmH1ZzPmWHZqMkGvtztF5dSo2PdCJtl8+92fgFkxXeuzVgJoKP8DOM2uuPIq0Cv7j78z02GljoNQsGptYCNc6wllrukFsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100379; c=relaxed/simple;
	bh=Uq7GzPfQ3uC0UiGgLsywtL1UAOYX+nwobFKbFtjrYR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVXYM9JEBCBgkWpTPKiXGR7LypSRKyxikimh5gNzZMZGQ/waD+bHhrxrrBV1s3rCGUie4O/Hi+MlL8So/6zFuAiKECBRd2YFUbpsO210jF1FiXY9FHUKNN8vSIvDxBk7TcZcxyj2cKAZ/Jo07ukmEKC20r4eZfs7PuUkk50oMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtyeFnfC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740100376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq7GzPfQ3uC0UiGgLsywtL1UAOYX+nwobFKbFtjrYR8=;
	b=OtyeFnfC8vKGfAnuluA76oPk7WRVorGwCp7JFvzZY+wZ/6p8VUy6Lv9dqrt/sZkgb2neDb
	/iZjiOL0/yx8BSAq4lREaQ5D5LG99p55MFxNZ2Uokb0xx98P3rYZl/by2gJndJO9nk6UDQ
	3KzFo3rjhwScsSDwqbhKTYeWYM9IcHQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-l2utyjLaMzuodNz8u8VIEw-1; Thu, 20 Feb 2025 20:12:54 -0500
X-MC-Unique: l2utyjLaMzuodNz8u8VIEw-1
X-Mimecast-MFC-AGG-ID: l2utyjLaMzuodNz8u8VIEw_1740100373
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc0bc05c00so5053109a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100373; x=1740705173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq7GzPfQ3uC0UiGgLsywtL1UAOYX+nwobFKbFtjrYR8=;
        b=soS0bCFtyw68Pxpa1eoJQ2J0fXZ1B7Q9prZK9TEpi29kl+M/HW1b2WxCl6LNBubRJl
         2HP6/+lxi/nR9mHvN7odMMTeeSMkJdzV9ZKULqOCroD6wF5JAlsZVz9hOMm/siBCTVP0
         8UFPXYh2dWmXSs1oq/j6t4EzSTPDzIOx7yT+5NwW+RyruijyWlpVwAUsZyJM4vWmOCvM
         iovxs5LzLAvx/FQUoSxTTfC3hij8HrY0Fu1VmyzB8a4VKIK2rmSzYfYsKyg0cU5bb+X5
         acRS3jZw9JXB73LtJPU8elzKQwJN+TrK08XskCQQs30IpJj4gr2Q2UB0hCiLbc/nSo+O
         IDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXxdothOJNqB1MxSHcrVt55xvjz0ueY96sRwTFqIQZxDgs3tyK5231G65NcDULh+gmKY07OAHFuklyFHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cAxCFAQsJ36IQg8vdLl2wcrJB5oolwsaTd9GjVkvK40CIZSq
	5H1znJxHyl57aoP6krgKj9Qboxjzx8eoQwiCKZ/ZWgO1qMR1Jv4SI4TmgRL+iImVcfArM6cjK1n
	BDlAtx2oS1PJCJh25gmOP/j+ICiKKzKiOz1+KW9yk9TGqVPFDo6N+2MNZe3ehKfGAfnxRiwk8VD
	85mE/VfSyVr3uQLyVVqRM6JT40/rxXOgq/uv/4
X-Gm-Gg: ASbGncuACUICjGDx+I1ahJ7GRq9tsuhjJKF6//b6eQ02CN7zSMrnqrcMn55scz8k8NJ
	AJgSp/e4ePx9rsrhlG2Xr2Vv0rzY9reFxtOLorOQe8b9/crwcUwZUiBnOtnBUXAI=
X-Received: by 2002:a17:90b:5310:b0:2ea:696d:732f with SMTP id 98e67ed59e1d1-2fce7b271a4mr2148907a91.29.1740100373611;
        Thu, 20 Feb 2025 17:12:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnQJ9hWU4v+2TwwECUtm6Pf8c9YX7B6ZUHd/Hqnqd2kx0Bc2ftH5qx2hCH5z2BE+GZRURxv4Goas3NlmOaXUg=
X-Received: by 2002:a17:90b:5310:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2fce7b271a4mr2148854a91.29.1740100372927; Thu, 20 Feb 2025
 17:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220193732.521462-2-dtatulea@nvidia.com>
In-Reply-To: <20250220193732.521462-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 09:12:41 +0800
X-Gm-Features: AWEUYZkw-CTw854l_MFE994dYvtfLs30K1XdrnaRr8wNLayyzmZm48vwiDxgk6A
Message-ID: <CACGkMEuUsh-wH=fWPp66XAFeE_xux-drf1gatSQSiGuS_rO_zQ@mail.gmail.com>
Subject: Re: [PATCH vhost v2] vdpa/mlx5: Fix oversized null mkey longer than 32bit
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org, 
	Cong Meng <cong.meng@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:40=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Si-Wei Liu <si-wei.liu@oracle.com>
>
> create_user_mr() has correct code to count the number of null keys
> used to fill in a hole for the memory map. However, fill_indir()
> does not follow the same to cap the range up to the 1GB limit
> correspondingly. Fill in more null keys for the gaps in between,
> so that null keys are correctly populated.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Reported-by: Cong Meng <cong.meng@oracle.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



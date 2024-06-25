Return-Path: <linux-kernel+bounces-229018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F7B9169C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F15280C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89A16C848;
	Tue, 25 Jun 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfjzqcA1"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7D16729D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324069; cv=none; b=m/kzVk1tEhBUcPHnBAavSLSiSWyifKIuQGPAZrn8bP4hfAhvjvzRqaT08DiqeT8NEDjcpcoPFtITemtpPZIRy5WTz4LhIhuqoY/IRyLkEPZnFdzodJHw/hoEO16N/PHg7jYhGdPAwt3bLAOKNaWCCWlIFi6iid4LZwwElgUCCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324069; c=relaxed/simple;
	bh=0iUji4YU7CTd2c7VFZO5weBB3zZUqKVzHmxQ/+nux9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWGkOyuVaXWRwC8ecsX6Hhujq/MwJO1mG3M+CHXSNc1zByghlnuAJ8Y1INxZ6gsBk4fBVkThwV+Tq03tmHrDtO+r+bbWyvZ62o/6flH8LB487q1EgUQdzEmL9STj/K3+oDj89Z8tBf89NuGZZJh+qIb+FbzQELRIbY7R38+jqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IfjzqcA1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424786e4056so58935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719324066; x=1719928866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iUji4YU7CTd2c7VFZO5weBB3zZUqKVzHmxQ/+nux9M=;
        b=IfjzqcA1V4xagt3sAQMZABEuucS2GkKWuerRzPAENhx1teT98KJiqZwySRrjeIuP0+
         LAWDq7/FckcFvpDQ4bWuURkRw+3EnWdloen8VTrItJq1E6SxRI/IMTzZnvxidYWk8kW3
         QeC/xVJIWoah2ryBRrYcN7OlcrrPMw5a2I16VLDb6rZ/eyVsRetnN48r9+zcUce6Pg13
         f8rO80B0KQwsP/rg1TP7STaxWhBhOsH1YSLyy5a95nLwYiL+5gQQp4c4/UsdAN8tEb6P
         FZAWINe1U5GB4yV26Kls3svnMU1mX1vJBeBvxFTmD8gYQHxuAN7gwWHJmSqerRcrOenE
         A8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719324066; x=1719928866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iUji4YU7CTd2c7VFZO5weBB3zZUqKVzHmxQ/+nux9M=;
        b=NNJltkFD3rfBwQw3j7UvojtX+MgL/+CY0gVNATf1z1UKPtDHgGTYX5XqYE/FoF0R1Y
         IlyGHNI2BYL94DK8l+XUFu0WEPyWGCiqFuy4VjrOJcsFNtX4KDqbpxMeyHLJUnK/x9Pg
         164HBy0a43TftIbvnPpZdsGt+6IRKy0vVj7YnMbmR8lKhE341lsRnroCLI2stOqvxCuD
         Jec4zmCSgZvQkHqBQUIG/OGF/Dn8+6rF5LIlyC/h43jwH59M4Boemwl+pwxTVaqBfpv/
         QAB9IE3y7SnT3uU5Fdq3fuHDhmFuhELc11UfyEe6b6HzPOZqqCmnG+Zx/e2Soz1MlZ7l
         alIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZKmWpKsHwSCfz3VkuLrTx+Tj1sGTNV8/io4gySRpuMwL6JsraAHwsXRJGYjTao1j2s9FGieR9G43rLCXw8Csyd9gj4JQw7c/WwKCK
X-Gm-Message-State: AOJu0Yxcri5CTh7Yy4aCRJ6I1oNzTty5A/Jp0GqsjKUGWhgQBIdft8Iv
	XDnuZCH3EfTC9E7Tthh/XbJK6PnyjyIQuX/YTt02C95hP3sWL3MNfMyXDApHmXyIErhOdDcDyQ9
	Z6vgZwCJ9VvBPJP++llG49ZjYPBHGDMcueI2ElnC3p+3B3xzLgnhY
X-Google-Smtp-Source: AGHT+IFi60pqCTZ2PhmbScpfvVHSlP79Je6RZxTBeRVQa0tDIwHRTiXhex5MNwjEqX/qp24vK7+wKOEsa9glLbD7D54=
X-Received: by 2002:a05:600c:4e0d:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-4249b65604emr1549465e9.1.1719324065471; Tue, 25 Jun 2024
 07:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com> <20240625114432.1398320-4-aleksander.lobakin@intel.com>
In-Reply-To: <20240625114432.1398320-4-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Jun 2024 16:00:51 +0200
Message-ID: <CANn89iK-=36NV2xmTqY3Zge1+oHnrOfTXGY0yrH=jiRWvKAzkg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] netdev_features: convert NETIF_F_LLTX to dev->lltx
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 1:50=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> NETIF_F_LLTX can't be changed via Ethtool and is not a feature,
> rather an attribute, very similar to IFF_NO_QUEUE (and hot).
> Free one netdev_features_t bit and make it a private flag.

> Now the LLTX bit sits in the first ("Tx read-mostly") cacheline
> next to netdev_ops, so that the start_xmit locking code will
> potentially read 1 cacheline less, nice.

Are you sure ?

I certainly appreciate the data locality effort but
dev->features is read anyway in TX fast path from netif_skb_features()

Thanks.


Return-Path: <linux-kernel+bounces-295835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADEB95A1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81751F2701B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585F1531D7;
	Wed, 21 Aug 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvhxToZB"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10E14F9DA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255015; cv=none; b=RBQVmBm83adY/8u1zU5Pj6+o2u0Or1tUgA+H35+JlpvYCQLY8QCqQnKCxxX+PkhLnReJTlu/ZH3vGDjTNcK9uAv5x4ho3qKkvWHcnk8Lyvs6mgIf6SDZlCHa4JF3kgLb4ukjscfCeZfzbOh9srSQri0pYZ8PIJR40UMzNKkoJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255015; c=relaxed/simple;
	bh=FE4aY/q5CVtWooWDCyJ3ysUxrUcqnG1S++u6HwB/bVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiVHCrKkikYAqMva9OwEAiPYEcGg4eklsmjOG9v9u9MCc2qe6kHwUwufPKz6Ok/VJ/eT/ipGSBb25CEuqby0v4FBxvDkIFI9Kpa5+Dc2DfBHQkGrYDTdaaCwet4M0HVlyGVEMUJS8DjoAvgPkCMorlHKNSiESw4mAK/dUo1WtTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvhxToZB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86859e2fc0so33806766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724255012; x=1724859812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE4aY/q5CVtWooWDCyJ3ysUxrUcqnG1S++u6HwB/bVY=;
        b=fvhxToZBeFVduwXh5P1sqnp/H0MBFjS8mLvyAwEqiHLl3ig0HhoKGlNgjhCq0djQZG
         9B8K4IXWhN69uLuPZmh+CgrMbrIbf42bA00oMpIJTjg47YFWCsflLs7K/Ppe7vHmgC0/
         TB8aimcd+/8f0v4KRZXgLbFugXpEoPBL4K5EDQq6O7WdxLTYAy6Q1m5rCz5ura/Idpui
         FAisZiT2EwcpV6BC3O6xNwvz3fFFPbO4SQGJcwP/glU3bxeKrujpMynwOy+hbdZauFGI
         qlefeMIs8RxSUaLNMmLBWKGVGzqKN7A8CEq9BnuFWU0l0vE9Vlu26PSgX/Pgnbyn0ItT
         8RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255012; x=1724859812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE4aY/q5CVtWooWDCyJ3ysUxrUcqnG1S++u6HwB/bVY=;
        b=SsCOCOwBOdk+aofpOG9y/LZUZF+4p8O61XuspUgfGq7SaMQZLRvG+3dKP6q5+yEWUc
         Gj3WdxMqJUNJA7nRGmK6ePg5KrW9i8gy32IMmoGA/3BP3/Io/kyUMDqA0cmMvd7o315p
         Gudw3Aber9RvnHqqmhJmymAIv2LvyLj7fkmX2UuegzqVlSB4+aiPaaXEWvI1noGeO/T1
         k6okjuFqHIIM+v/jlJpZkvnpi59BPHBS27KlohdFZdzf7YsbKP9pxpBWoBq4spmIjoYm
         cDIsNTrLADncPdEK5AncWbTFj8ivEC2swKBN/7RC+dnkrRWEVzPzoQYQ5Ze513uheQV+
         fM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtyHnxXvva9RqGcQ0Ht7XCKpdbysJAPMZU3iyb7KWnoyURewPxtmAdZqeAnEI5gEbODeUVHnKT7jzdf/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnejoeTdnSY5ykG4DHQ60gaD1lgcHJKag0qymS+M8HXrmtkoW
	FqGo7G2JZYY0LNLfqyW/3WSAHGMDGahygbbfFpuTWD1ajnlZZVTzUH62coVHyxnhdUaJ5rdjDgp
	F8/ehjEEDIirr9Xzc0TdQlrYVEKi5JiRHAfo+
X-Google-Smtp-Source: AGHT+IFXM1haTH3Tft82GioemDeMyJeWgfsUvV1Z0FDSHL0znQ9kGlTog6+S/Takg6dPBnQDSWoR4E6wLJW9Oj0YiHI=
X-Received: by 2002:a17:907:c7c9:b0:a7a:81b6:ea55 with SMTP id
 a640c23a62f3a-a866f9d2804mr249205766b.56.1724255010853; Wed, 21 Aug 2024
 08:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com> <20240821150700.1760518-3-aleksander.lobakin@intel.com>
In-Reply-To: <20240821150700.1760518-3-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Aug 2024 17:43:16 +0200
Message-ID: <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused __UNUSED_NETIF_F_1
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:07=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
> ("net: remove NETIF_F_NO_CSUM feature bit") and became
> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
> Remove this bit waste.
>
> It wasn't needed to rename the flag instead of removing it as
> netdev features are not uAPI/ABI. Ethtool passes their names
> and values separately with no fixed positions and the userspace
> Ethtool code doesn't have any hardcoded feature names/bits, so
> that new Ethtool will work on older kernels and vice versa.

This is only true for recent enough ethtool (>=3D 3.4)

You might refine the changelog to not claim this "was not needed".

Back in 2011 (and linux-2.6.39) , this was needed for sure.

I am not sure we have a documented requirement about ethtool versions.


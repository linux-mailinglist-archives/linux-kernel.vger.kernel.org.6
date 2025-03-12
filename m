Return-Path: <linux-kernel+bounces-557798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B8A5DDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F1189005C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1163D2459D2;
	Wed, 12 Mar 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xeh4aymP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931422A1E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785970; cv=none; b=t7uarI7VMude4h78UwWE7iTpE2xWy49emcr3dmtYcS1RdNdL5EnVqaJOfzwzoXtDGLkwi1+FGNaxn5eWpK0sCcBv7BtojqYh5rKGv7wSDU27PPNMcrgREt6r8uLC7hgUG5jw6zauasiJhPGYm2uP3s6hjY5sZu4j077x0jBQAeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785970; c=relaxed/simple;
	bh=wyQf149d956R8llw4X1LrAZYhPsEJG37tSDhhRLRm0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZPURhB+RFXdOQNYxAaJqFT6HZMDEW58NoVGhklWJeWNixuAyKHE551YiNjbBaCypUo6ppGBZ0XuCFDLl7fVhOOrvXLad82LeJWVvpKgGrgMwSO9GFL+eU/OZToRh2MwQ+uC55SeyRzj3FSzXk4hAj89PHkvNRXoFGVIDK84hH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xeh4aymP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741785967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ83bVVAGBssvQD/Y/6hPy7fP259qfiYhm1/Pc6fLCE=;
	b=Xeh4aymPWnAp9ktdszV1mOYoPnpeu7ondHTdsqpmr57pyeUu+TOm/M65YQYC2GCKQzeeCR
	7HyQR1rSVjj9c8OEKB7zxrvAaqqVo0lYSMTJZ6TS+ZHCyW1rhoXxfDXKyNbaMaCJh1/CoY
	4BcS+hii1WHCeFV56XrYZhe1dQWbLP8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-V9WOPSykMuCCRMIl7h-gIA-1; Wed, 12 Mar 2025 09:26:05 -0400
X-MC-Unique: V9WOPSykMuCCRMIl7h-gIA-1
X-Mimecast-MFC-AGG-ID: V9WOPSykMuCCRMIl7h-gIA_1741785965
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac29ae0b2fbso342953666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785964; x=1742390764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ83bVVAGBssvQD/Y/6hPy7fP259qfiYhm1/Pc6fLCE=;
        b=NWRei3TlBbkgYhQCrubggacK2vW0j9MXnpN1suHNvbZqxvPHjx38KYd/uWgLMfovsM
         W9jI04iUhGahhNWPne8uP8zYNZK0Ht3X2iBcrXJaOw13bQbcxQDeIsKEuls8Cws9QPud
         DK5CJJMZ1Eq2CyhEVAjzgt9bH0Mkkq2aJWis7Fn/t5F9o2fr7AIxiLcy2SLH9ibFzSoO
         FQgWvcnT6tDdgaMvTcRKMd+iqSWbmYXiRzSSnVQ6XKdCr0PLOS7s8n2VS8Kz/SLkdbyG
         M6QEE72c9pNmVfLRud0o4vWdCyLiJVEd4hM3mKBKxmI1UgptHVZTfX0Ei7gi4HdP34ys
         BxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGXDKGKk2XoBP5VnnPAZercvY8y72ZFA1osuv+tyR/8pYOq+ojvN1LgB3WUJ7nyATv5j1JsinFupOI/eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmQ5dIa7rZVbx0cF6ggI1DemEdgXRMMIJiFRqhKv1pR9si8uZ
	ytOxWlIWkvepUlA7OfyuGc3yH+bv7Ye8iL5LTENdYR4CXCLb8WRQu3R1th1QB+KIJekmWEn6wQZ
	sy5Oa7Baa4g0InJfvZKLFTvYSnFGNpwgoKAX9NQPz4s6ZVvoXEXkVUv3dFWwKQWNAa+vULGSULr
	mLXzGJaMXBSYS2tDSwCdl6CV8W54Jc1nr9UlRJ
X-Gm-Gg: ASbGncvoBEJqa+KwmOf+E+6o+Jvtm6KjCoBcNdlBZssE666ofIO7aYZyQ32SjCUgMgo
	7qqNNQ655wdTWPVDKdPQa8n9THjeby/2VTLp3KjDsvb17IiEvbF5Vbr9Gql1u/obT0ICO8hPtTg
	==
X-Received: by 2002:a17:907:720d:b0:ac1:db49:99b7 with SMTP id a640c23a62f3a-ac252ff84c2mr3037879666b.51.1741785964598;
        Wed, 12 Mar 2025 06:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwMmV0C2CCYv/294WVZ7TsbifUATtW/CTrWwwnLd8Mc6iFkeZiz9m9ZXV5FYCn/k4KDS2uoseHSkNcPerxpew=
X-Received: by 2002:a17:907:720d:b0:ac1:db49:99b7 with SMTP id
 a640c23a62f3a-ac252ff84c2mr3037875266b.51.1741785964271; Wed, 12 Mar 2025
 06:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311084507.3978048-1-sdf@fomichev.me>
In-Reply-To: <20250311084507.3978048-1-sdf@fomichev.me>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 12 Mar 2025 21:25:27 +0800
X-Gm-Features: AQ5f1JrgD8nNC6ElFILl5ZgueQ-mIyl58jJoTMkHTMUQbrKsbRA_yYhLcWmk3xs
Message-ID: <CAPpAL=yXhh+MUjJh2KvPhjESUGTQBnDRZ6tKpeMi3FZAtoCNvw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: bring back dev_addr_sem
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, jdamato@fastly.com, kory.maincent@bootlin.com, 
	atenart@kernel.org, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this patch with virtio-net regression tests, everything works fin=
e.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Mar 11, 2025 at 4:45=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Kohei reports an issue with dev_addr_sem conversion to netdev instance
> lock in [0]. Based on the discussion, switching to netdev instance
> lock to protect the address might not work for the devices that
> are not using netdev ops lock.
> Bring dev_addr_sem instance lock back but fix the ordering.
>
> 0: https://lore.kernel.org/netdev/20250308203835.60633-2-enjuk@amazon.com
>
> Stanislav Fomichev (2):
>   Revert "net: replace dev_addr_sem with netdev instance lock"
>   net: reorder dev_addr_sem lock
>
>  drivers/net/tap.c         |  2 +-
>  drivers/net/tun.c         |  2 +-
>  include/linux/netdevice.h |  4 +++-
>  net/core/dev.c            | 41 +++++++++++++--------------------------
>  net/core/dev.h            |  3 ++-
>  net/core/dev_api.c        | 19 ++++++++++++++++--
>  net/core/dev_ioctl.c      |  2 +-
>  net/core/net-sysfs.c      |  7 +++++--
>  net/core/rtnetlink.c      | 17 +++++++++++-----
>  9 files changed, 56 insertions(+), 41 deletions(-)
>
> --
> 2.48.1
>
>



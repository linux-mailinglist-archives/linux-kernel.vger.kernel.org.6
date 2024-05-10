Return-Path: <linux-kernel+bounces-175168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F768C1BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6061B218CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352B04C3C3;
	Fri, 10 May 2024 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38gz8D87"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F875235
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300355; cv=none; b=ckX8Sljwae+E24vRXVxLsktM7SP89sWT3UOfrUv5K5jI/sGUKn5CxZ/4RXcPqIFGyrmnJDGz6jEHh3WfMyG9keOh/UNmSjEN5Kf9Mm1EB1proHtvBeBSGAZNL7G+AXy2gzv5Gte7b9Hpsp+8vBM+DAcyphNpJyxrvJ9LKSHUMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300355; c=relaxed/simple;
	bh=0XTehdgnUAu0DffyW0Hg/Nc8qFCKbP9Br4UL88WMW8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4+XnG9xGc6IDUia7bwhiJvVyr6X98RMyyGxFqpfBHbWji5NHUUrUNBKQtp4D7pp14V2/uLZtwpuUj8oVyUpSmE1NMjrQZnwkkNvohL5U/WMwNsKFZ7nHIWvKnLWzKJoVf7JVyuM/2mPXXY/TeMEu4kU7RHof8R+FzgZwUAQsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38gz8D87; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41fc5645bb1so11758615e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300352; x=1715905152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDkg740tjVRPA7muszLKzifx+lB1m07et3SmwF5+y0o=;
        b=38gz8D87AKgDP25titIU0RdCBhX5qbc9/dtCMMNs0YHRdy9f7XQwahJ4mqJwTr0ilx
         QoVW4Idwe9XkVXtNDRsuMWNLXWvgkCdZemQDVL0ZJqlAkce2DTieFpT5mkyxGwMFsQOZ
         QmlvEtcJrAf/c4JL/2Qn3Z4bFRfoPojF6GZmqmHq5VnkykdPqWKnH/KuM1JliGfMypo/
         J8PK66W0AB+NANa9IJw5vbchEslM4SSHlRxxb9Ug81uhdEui5ESadoP3EM8xBTMoSzAQ
         QBsiebr37SFDVxW75PFUa8o2TRsyS+5KhR82VDbt5n+bYcKNm0ivkUMMm9YssMH6XS2f
         50OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300352; x=1715905152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDkg740tjVRPA7muszLKzifx+lB1m07et3SmwF5+y0o=;
        b=bCHKM9SifVvQWpG6U/JNXqpun789CF5zVfPguFOLoAC9cRKx6SPIL/R2QNg000X3nv
         gEzi3EhW603hu3iUONl4U3UQGq6X2Y3AicEkQM3FIR348IaqjdXQ7NmAsF5W/FGNpUZX
         LM0ZkcG3s0R406MrKBFwUoaqHkcbCOj8qPN+Zx72BtgCPpdIZCFMpBruildJkdXEetaw
         B0jbPcgbf5z7yfHLjcpesjHDqAHBDlvcPPnOWj/KBn6LSfD0iyTZqy5EnpTTrmJM3f53
         DPg1OHEw9mUplIWCcKqzUKU4iGoLKqCjH9ahEwJV4Wof8NOZb/t9ABXhikHUqNFlaEO3
         1CfA==
X-Forwarded-Encrypted: i=1; AJvYcCUFjonkWMaeYAVd8WDapAY4H2VibnMXFkQhkNOL4sHQN+lt91zTh8pXCS0z6OQrX1ivOajokQ4gu388W+zCVxpktrdf72Y/+o3pMFsY
X-Gm-Message-State: AOJu0YxZ5GIVu+xRlY1+ntHEpYBuNbJ0iHo6UFkBsgLlwXulBtMqQCIQ
	xKFmurjmom6Z7Mc/SfxETztuCfZFdp7YTX4zoqf8fUATh8rejhF1HBXGd5cJGjRms0/yVbB5Xee
	CXw8fY+kx0xX/shF2bPZ5ezWFK+1ZTbBJiDCt
X-Google-Smtp-Source: AGHT+IHoymcx9p+FVAYDd+bxTKN3u67a8ICRxPdR9lToM+b7TuJWleoDYOV7HKWLMYCbcEXS6FL9j7W1pp3wwxvc5ms=
X-Received: by 2002:a05:600c:4f42:b0:41e:8894:3f48 with SMTP id
 5b1f17b1804b1-41feac59d64mr8641395e9.27.1715300352187; Thu, 09 May 2024
 17:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507225945.1408516-6-ziweixiao@google.com> <3e10ff86-902d-45ed-8671-6544ac4b3930@web.de>
In-Reply-To: <3e10ff86-902d-45ed-8671-6544ac4b3930@web.de>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Thu, 9 May 2024 17:19:00 -0700
Message-ID: <CAG-FcCNGsP3FnB6HzrcQxX4kKEHzimYaQnFcBK63z_kFTEQKgw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] gve: Add flow steering ethtool support
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Jeroen de Borst <jeroendb@google.com>, netdev@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, John Fraker <jfraker@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shailend Chand <shailend@google.com>, rushilg@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 7:09=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> =E2=80=A6
> > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> =E2=80=A6
> > +static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxn=
fc *cmd, u32 *rule_locs)
> > +{
> > +     struct gve_priv *priv =3D netdev_priv(netdev);
> > +     int err =3D 0;
> > +
> > +     dev_hold(netdev);
> > +     rtnl_unlock();
> =E2=80=A6
> > +out:
> > +     rtnl_lock();
> > +     dev_put(netdev);
> > +     return err;
> > +}
> =E2=80=A6
>
> How do you think about to increase the application of scope-based resourc=
e management
> at such source code places?
>
Is the suggestion to combine dev_hold(netdev) together with
rtnl_unlock()? If so, I think there might be different usages for
using rtnl_unlock. For example, some drivers will call rtnl_unlock
after dev_close(netdev). Please correct me if I'm wrong. Thank you!

> Regards,
> Markus


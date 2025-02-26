Return-Path: <linux-kernel+bounces-533039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8385A45515
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD513AAFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430B02676F6;
	Wed, 26 Feb 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll5e3UQj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735D25D537
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548981; cv=none; b=q84X3Y9FcaIw24JxRSHatWHkVo+tOycSi06DscvDEg3F0cdTexAvG/cXA3L5LQGQLNkmq4OJC74yLib/p5Gd2QBoLzd87hxF3W/Kt71GuOnkL8AUoqTPSSWImkqRFV2rNDoCXDkLBiPDkqMKeRdfK2NpNN9CYnmQObguAK0mhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548981; c=relaxed/simple;
	bh=7JslJeDzk/c13P0I370hNGaxUhAl2eLc1HmpJBdcBaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE2MN5YDcIiBtCoEjK/5v7/iSK9vPc0BSxLeiYP30qgf0fAXj9U60Hirr5GfQrBakUEGYwRAUBROUGHCHOM2r43g6yOskRhXaAUriiEt5G9WwcEFsVjD79d9NKqgVTjHdDlZOCARKkisxM08ShwnwQIRhVy0jzixU8f0DULj2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ll5e3UQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740548978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JslJeDzk/c13P0I370hNGaxUhAl2eLc1HmpJBdcBaw=;
	b=Ll5e3UQj0Jy1bp5c7MATEv9SoGaP5TQIUAXRfua8I/5FC7VHjWCBisjS3foA23C/QJvf7e
	t9y9aG0dE48YmG5mnNkiuWz2Z3PAIyEgVSlspHLav+0uRhZmFQwIhzasOOKzURLWKD8e0K
	S+PisQ951GIPLonK+lTSWyKoIraRPe8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-zOFP_haWNpiTkT3VDxGnRw-1; Wed, 26 Feb 2025 00:49:36 -0500
X-MC-Unique: zOFP_haWNpiTkT3VDxGnRw-1
X-Mimecast-MFC-AGG-ID: zOFP_haWNpiTkT3VDxGnRw_1740548975
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so13798018a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740548975; x=1741153775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JslJeDzk/c13P0I370hNGaxUhAl2eLc1HmpJBdcBaw=;
        b=Xlpa7b10pJwpi1r8fWcELpEGhMGYWORSGm8opUIVyfM3h5FyOOQu/2TWe3YaJb51oC
         ndXLVMe60S29oBrosQR4Ff55eKFIuEXLvboS6PRr4914/UaHZfGvAP+c8JsDWsP9KFOT
         xzNBjugnQsUiWCKNvnq+ojx6J3ptxUuheZKKnCbhrJy3re6VrMHK/JKNdZ4HulumTzEY
         Twqz9UteYK5vKNYhX1x4AiiNkHtXgg82L0xX9R4B5QFmhf2fTQ5nVX73J9xsV2lR5EVr
         db/CAEviI95yFGMh3p/m3/b2C+byt4hVpQmEL7fQcSAsIKj3y0UOxl97EMmXOsclpVby
         O/lw==
X-Forwarded-Encrypted: i=1; AJvYcCUs3xV9liyMogOPjWDmpj4HnuAkXQQYhb4j0BtI71n0tx6ZtCHmaTPSCktPXQx5FI8hcNf/oX40kH/LEro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU853hciUtAdzNy9SQUG2pbtQa7fuDQww3TfgplSvUzW4Yz4ZM
	s88EZqYFjrjruqAW0SW0w1RRY/k+sOG8gROH78jc7q3oZjctApaC73QTSXMH4zUHHcBC8CA3/a1
	y8qYDt+DRTxYfL5f4gXgIdYxGjcug3F0lebOuc8bSyEuwDmL7T83/LZe8dbN/wzFmJingjlmyK7
	lO4a7CfA2UNhBqk80gfu3RePpZ0Y6KKEevj0P0
X-Gm-Gg: ASbGncuuBIKPglmFqjXtC+3G3lFgFTyu8b8zMhAVrziUz3iZP6mfUFUQdx6aAfvQCNC
	EP+jPOIq5CxHqtfaWOXzwaCq8C7jOn632LINWpo+dsLcKmcpEZlHvhqr/tcRD2QKHuhh9pxBMwg
	==
X-Received: by 2002:a17:90b:540e:b0:2fa:200e:acd8 with SMTP id 98e67ed59e1d1-2fe7e36c6a5mr2830401a91.26.1740548975537;
        Tue, 25 Feb 2025 21:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHao4sHapKak96kS34jjVbnf/J/xsI5aoEpJfu6k85ld0wzno5T370e5VcuJKWSZcF3LJ8r2FpUj/vtSH7zOG0=
X-Received: by 2002:a17:90b:540e:b0:2fa:200e:acd8 with SMTP id
 98e67ed59e1d1-2fe7e36c6a5mr2830379a91.26.1740548975203; Tue, 25 Feb 2025
 21:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <20250225020455.212895-2-jdamato@fastly.com>
In-Reply-To: <20250225020455.212895-2-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:49:22 +0800
X-Gm-Features: AWEUYZnY9EFWcoJ3ogh3GxbFxsL5lrfcPA2_752HhK9UejW8xtaSGW6hEYORVZc
Message-ID: <CACGkMEsGuw8WqoGQZarktjPbF+UPmTk5GS7Z5UtTUK2B8Zkg-w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] virtio-net: Refactor napi_enable paths
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> Refactor virtnet_napi_enable and virtnet_napi_tx_enable to take a struct
> receive_queue. Create a helper, virtnet_napi_do_enable, which contains
> the logic to enable a NAPI.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



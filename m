Return-Path: <linux-kernel+bounces-259611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDCD939988
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548A2B21663
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECB213D602;
	Tue, 23 Jul 2024 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0qtiKHT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B228E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714515; cv=none; b=gtd+gb/Md4qYpvHJ+Z3SzUh/3yPtzHlJh6R+Oi6dTzuWbf/0MXMguCNqFNaCjbwrlc2ixUuNXfXoQgBWbhBrx2qIeWQE6XKYSh3BW7UIq9p92Y2GL/pEspHfToqkwhIQFcDqmTNfnMEpmKejJAl0DelQbHWJU3zhqQWM9tkzBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714515; c=relaxed/simple;
	bh=9xwqJwDsGR3pFv2mlR4oUH8gkzfpSSnRrp+hDPttC1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGD3UTJTU6O9lmJ5jsSLdCVMxrSxsoCPHWvy+ofBwYzh2UJgN2mCDO2BrVbhK33J6d2GfPO81jg7ZcrOCtpUs58Pu/E8Z+kIVb80ZG3vjDFsdLGQX3nEx+B98qtvNmgdUfxN6bTtFXS+UgHWhth1uB3x+kfMYXwoUkG2pdVcIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0qtiKHT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721714513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xwqJwDsGR3pFv2mlR4oUH8gkzfpSSnRrp+hDPttC1M=;
	b=N0qtiKHTBNOTjhVji/dVGgH2jevC7nnRmT/yvvYy+nNrEQgFbChZfkv3RjKH7+s2MEUThD
	Wn4SdzycGeGikrdwT2oEimLsKvzqGNXX3mGCePeiYd6Nz5ebs+oCjEJjs2OdW9TAWe1LvH
	43lMORVLeLGf7b8nKrARYvlQDziEyz8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-9sYk4EQVMMeLOI3B6te2BQ-1; Tue, 23 Jul 2024 02:01:49 -0400
X-MC-Unique: 9sYk4EQVMMeLOI3B6te2BQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cd3bb0a9c7so2160002a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714508; x=1722319308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xwqJwDsGR3pFv2mlR4oUH8gkzfpSSnRrp+hDPttC1M=;
        b=CAXcmQSE9iGBrfh3S3S8Kb1d2YjMCtvGn53zkvOOYzTXDuRx09lhJd1ixm66Ch6iEH
         nBeIJY4YtR3xq/79zLrmakMIyx4i9/3WXWPuqVsrRMrqdbQs19LCP59p+9VDyUaEN3B2
         wAGiOqQo6jiVfNxF57OVuhfE4fTcEtPT5GYp5cGeITO6koPAd34L39tWW1Ok2RTVwg8O
         U+fYnV3KQLrlCf6ideXTern16o68yMcIfC6SD9vzrOgziZLmDe1GeLrQJXgocWBD+PeK
         g7cMEEMeS4WMeoYkxOIQSG3WrDXRkRruuH8ipE8E2x8AxRJ6il4COqt6P6pyax3sqN1U
         9LAw==
X-Forwarded-Encrypted: i=1; AJvYcCXfbN+l3+U1UEKYeQ4HPtZpHZafYtQFx9Niqone/+gM5DIJk/Ss9SiiouW4IqOZs8k6srum1T0gExPnq99UHfQFn2utfux5cD9hbXDv
X-Gm-Message-State: AOJu0YxX7f4kaqzm2evEKbvpJ5x/qJP113ZAji0UdrevkgwCxOjO73cZ
	VlUUO2lpyVqZBQPCr0MW6uX5lbfXxUpb0ZcuwaSCEA5z/9AEa6zGpgQsMyEVe/zCHAmIgYvC6Ht
	AfNQPDFbdfKVMWpMyZQ+ZSEGM5eq2V9rbkDdP0L1o1Gzny/gJrE1Jjs1ES+e3BoVeGcUISgnQGL
	/Em4dh5/JClO2UicnPSnDG8GCobH8VyDOTqV7a
X-Received: by 2002:a17:90b:1e4d:b0:2c8:7897:eb46 with SMTP id 98e67ed59e1d1-2cd274d48c6mr5248607a91.37.1721714508195;
        Mon, 22 Jul 2024 23:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoEpwALYUFixu5BsTTbuOhYXcOpaanMm+heueYUhW44DeZ/5YttPO4b63Hy50iMiec8ZUd1PMvKMmbsaX93RM=
X-Received: by 2002:a17:90b:1e4d:b0:2c8:7897:eb46 with SMTP id
 98e67ed59e1d1-2cd274d48c6mr5248585a91.37.1721714507652; Mon, 22 Jul 2024
 23:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-3-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 14:01:34 +0800
Message-ID: <CACGkMEv5-Hn+LNKNT9ObCaT8xBv_BKrhoJjBA9RShGgh3Hwq3g@mail.gmail.com>
Subject: Re: [PATH v5 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



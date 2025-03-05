Return-Path: <linux-kernel+bounces-546218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2BFA4F7E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87703A7D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519641EDA21;
	Wed,  5 Mar 2025 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXAGK283"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129BE1EA7E9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159646; cv=none; b=FCvU63EurdDr6eTLjNYUltn6l9bY8cRcX+c92EFx0ZnyX9sICUzr/C/8S5B11qGrY+JS27GfCJbEN6q7XJAeMxwSwkG2wQAHXxKsH36hPiBRyQDKnmn3YRw4d6PNab82yynt/O0jTzpNeM91bCfgJiDt6fxZCglYVhSNfuv2a8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159646; c=relaxed/simple;
	bh=ggBjNt/KlzNhbq7zUAZEYyviD7fOL0zcgpYxjiglnLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+Ki4Qrt602JwKwET/h97nVmNthZlknnLgX/OT2tRXqCK2DsXeglntDGsf3g84XGi+PEhSxtEGU04SnSQgXls/tt8r7bxc3sHKenX7UBK3c54eISUgf5ZIaQ56QMk8avgQaPxT4I3jjXtjmVKey3Ia0mNJIddORrLJMpa5RdpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXAGK283; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741159643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Gqpuh7OkhW6l3/SGFe53202mdgSid6lnY8KI4KHLQM=;
	b=SXAGK283JmTgrgQ8ZpuC/CwpPU60aTOP1K1i3yMMoP1bckoMODmb9JguuLT90Ifk5EhIcl
	RfS/j0n+/fdEoE0uw3M7LwZFrjZWDMx08MXXixY3ah/DY3enMQtxVn4fswUxaem5T7DzTF
	6YO0MuoduWqSBROgSAOve6Sh9eLVHBM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-dnh3C297Pw6dYZa1SdUqxQ-1; Wed, 05 Mar 2025 02:27:17 -0500
X-MC-Unique: dnh3C297Pw6dYZa1SdUqxQ-1
X-Mimecast-MFC-AGG-ID: dnh3C297Pw6dYZa1SdUqxQ_1741159636
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-438da39bb69so47190235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159636; x=1741764436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Gqpuh7OkhW6l3/SGFe53202mdgSid6lnY8KI4KHLQM=;
        b=LtM7msZ3JIaYxVlWDUE6Bi8tDG6fgD0RY93qM9v2lPm+iYR7oKJq8Ooyw6j1dchcvd
         Y+CIBEpyY5Xi9mNrmEqxZe/HyC3oXPvjRzBJMEfmTinCArFrR74bWkHT1t+JfwH7E6yL
         EzUmG8A4OKEbs8nVEV1agve5q5za8JYBWeGxSbHYljN6zdEJSMYGWFXnSCnwXrL/BmSg
         LxifDHesoZtxoll/Iw/VgTp14U7iDE6YuHbV8kRpZYxIwt38K3YnC61VYBhLVDVBroL6
         2DzhMAYwQtvDZ1luxrzknoTyNToYSjV6QVH2hC7Kf6bCpql04NE378RpIYWR5OiVro2N
         8QQw==
X-Forwarded-Encrypted: i=1; AJvYcCUR0HvTQw689AqjgCsWbh7t/8YtAJzNeRXVWdZ+mZl6vrbeZFe0LyTFjYjpXgizNS0R+BZfSUR5+2uQCzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUwhj5TmCbTOLsG+7eGNg5J2Cx2qS6lRdMaaUZeByLr858lmj
	7SjrrE1IdPovZFMo5Ez1Zdfm/GjVGFQPAppeCdQY/5l9PXviaULav5giwBXIPlMANJ3tXW2oLHM
	PPeorgAc3nUmlwi+7FiuJ+kV5y6UU7DetotB5eX+yDoR+mLWSkkfy9aF/UOyt6w==
X-Gm-Gg: ASbGncsUdV6RyTDYuGuldVX8KLPCjC1n/VUcO7Uz2OryEq3NzggfLhJLgfRZg3U+toc
	0QxrpbihpVrg0NHt23uRSXcDmzx5zbHIe5+GZemzylp8kOfCbwGmwp/iBbszfPhusLz95cw5pOv
	NDiO4Qc7/IC409ifJAS90Yfsx5h9/W2/VBd5Tx6tAXWuDYFiZN1frLk6z+/V6PdJhcD1wy1gB0f
	VBw5NIAFkHFCUFWx3lvdMR3UNhoUQh+7BogzaMHjOCp5mQt1e92ULG5d4+tQZMVQnNvItp9pC5I
	riH1+EG6xA==
X-Received: by 2002:a5d:588c:0:b0:391:1222:b459 with SMTP id ffacd0b85a97d-3911f7bd7b9mr1100779f8f.49.1741159636302;
        Tue, 04 Mar 2025 23:27:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFSwg2gbLwAPlPAn2L1vg/ffvpbpIN3dglqIqZN8294KCbPeBfUkyQP4He1JGn832GdDHxeA==
X-Received: by 2002:a5d:588c:0:b0:391:1222:b459 with SMTP id ffacd0b85a97d-3911f7bd7b9mr1100756f8f.49.1741159635943;
        Tue, 04 Mar 2025 23:27:15 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm19898221f8f.40.2025.03.04.23.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:27:15 -0800 (PST)
Date: Wed, 5 Mar 2025 02:27:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <20250305022248-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>

On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> I think it might be a lot of complexity to bring into the picture from
> netdev, and I'm not sure there is a big win since the vsock device could
> also have a vsock->net itself? I think the complexity will come from the
> address translation, which I don't think netdev buys us because there
> would still be all of the work work to support vsock in netfilter?

Ugh.

Guys, let's remember what vsock is.

It's a replacement for the serial device with an interface
that's easier for userspace to consume, as you get
the demultiplexing by the port number.

The whole point of vsock is that people do not want
any firewalling, filtering, or management on it.

It needs to work with no configuration even if networking is
misconfigured or blocked.

-- 
MST



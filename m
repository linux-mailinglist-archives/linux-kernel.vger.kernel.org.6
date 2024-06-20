Return-Path: <linux-kernel+bounces-223531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE129911490
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4501C21D98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C779A84D13;
	Thu, 20 Jun 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpwQRGPH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCABF14E2E4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918712; cv=none; b=QHipIQ+yIZdtxK0BNLeDH9iyAYKFzW/uG3S505cQVze5R0HhXDSxxQZn4anUmFyra6MxQkqQksdQA0jqnaEhboOR8UWbbFv6JJnehHmFK5pxfC+cQMjZ0GRQT3i3EqxABb8jAXZ5j9Js78jafhpo4NyyKAIQJTYmlHEw2O4vsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918712; c=relaxed/simple;
	bh=f9JJShizHW6+26Nm609dCnIBkr7rhSHsiUz2a74VNgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYNyBb3BZi5rEblLABmzh4qvNUGJ2TJXNVYMrvHWI0SWpXmqLOUwESxp38C1sAIMeaGbgX1JC2tGFHs8sTZihyfhAeWPjoKX1/AguI4D9ffVcLlh+NRqLmQjT+YF49DKjGs8S3HjR2NmKkaked1LNNi4snQUc2KWFRedZNmh7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpwQRGPH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718918709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9JJShizHW6+26Nm609dCnIBkr7rhSHsiUz2a74VNgo=;
	b=HpwQRGPHg1pzbwbxTH55iyMKRd3bku8K2JJ/pBQ89ttjEmTh4KN2zmhuapIPnWYfG1b03N
	tdEUMIZTCObGgSE5EQC4xxTyOcDdyzN9CoMvd/+3RPpxcCVZP4V5iP1grNiTmIp+ZFY/qS
	SMGaHJKojlZ9LujLL+DGw6n7abV3Ai0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-xkx0CxNlOTW-a0rW8tpU0Q-1; Thu, 20 Jun 2024 17:25:08 -0400
X-MC-Unique: xkx0CxNlOTW-a0rW8tpU0Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4217104c425so10994895e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918707; x=1719523507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9JJShizHW6+26Nm609dCnIBkr7rhSHsiUz2a74VNgo=;
        b=PXbJQfXj9A5WRh7F1Ta2MLCx74b9scwSDQE5yStjLnB1SNjrsnCBWYSqtvbQsgGqK+
         Yp+aquZ9eP+rsq2VrU+8j2bWqKlflu7/OWctZ8bmUMJW+jf9eO7q5z2QOx7AQtgA9kx7
         BsO/pNFe8JcCPMcoUjd+qozck4w9YuUdZT8hYZS89T/t4b1TVlriLMlZ+IFT+nTYYe6O
         6sugZ9hOLlHjoic9ufYtROHH0HMiZ5Cl9CLMvswAUXPMpHMfs7TTgsGlpbqI3NmxlAH0
         DxK1FmCY9XUyCVWoy9+OR2uThNNTA9OyGoo4ER3YY2F1FARoKssy4vOMSXBy0VVmifGk
         6zbA==
X-Forwarded-Encrypted: i=1; AJvYcCU85oNy5+3g8BIXEL9UzMyHNgdRJa0RU8CoHz1s0Miai7zMu7vKJR30JC6x0V27Rv5hbg+5LKNiVNtzPIWX8A0NGsKe2+m8Y0xCktED
X-Gm-Message-State: AOJu0YwTg9H3/g+513klZgXsxbO+nGegVFg7sm7pvmRYdCwmEguZLZP3
	nzGzQfZSzG2XPgRshBAS+nwwufLkfVbuqvyBr4152J7d2Sih3RxrtJlW5dchW6FlzWLOHkLFa6X
	KdP+9WX1M+KUzoT7OSGr5jSX1kbMZPM2X8Ne/B1OvfL1P07TQce6rrz1c6EcW5v5dBaxKDVOuV1
	n6HmhN+m+pED+Kuuk2syEnahglyPuT0Cw9ifl0
X-Received: by 2002:a05:600c:258:b0:423:3f3:ba9d with SMTP id 5b1f17b1804b1-4247517db46mr50211485e9.17.1718918707011;
        Thu, 20 Jun 2024 14:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaBsjAt7HYoRlIFrc5qpLHiI59NGO2TVUO9sqzR9IetjhlwXnL5MlgKewv4Xldk70LZ3RNqpOnHHSjyM9x5BM=
X-Received: by 2002:a05:600c:258:b0:423:3f3:ba9d with SMTP id
 5b1f17b1804b1-4247517db46mr50211335e9.17.1718918706671; Thu, 20 Jun 2024
 14:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620054708.2230665-1-wenst@chromium.org> <20240620212142.461771-1-pbonzini@redhat.com>
In-Reply-To: <20240620212142.461771-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Jun 2024 23:24:54 +0200
Message-ID: <CABgObfZTbszy8ruotPCA4O+u5C2wDXSfnaWo0mBNF3RbJwUNhA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION=y
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:21=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> Queued, thanks.

Oops, a script started sending "queued" messages for everything that
had "y" in the subject. Sorry about that.

Paolo



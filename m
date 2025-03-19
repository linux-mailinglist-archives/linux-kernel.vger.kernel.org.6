Return-Path: <linux-kernel+bounces-567537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783AA6877E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E162D3A3008
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB72517A5;
	Wed, 19 Mar 2025 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="havpks1j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77662512D9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375250; cv=none; b=SHyy2UYLEHgaJCz9icq7oDNgvnN9xVwzOvwlFvgGjKBEWvoe5EZZ0MdKRLTrNfqSPeSO3tPO0WzrQa2zn9xBO4+2+PverY21/RXnVESNYuFZqrnqOgUTY7cv/Yma9w+5r6CPRPyFku27RjEUWORbTXG2GLj7eSapXOBC0pnvouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375250; c=relaxed/simple;
	bh=hEJVrnzm4GUSEpbeNp1hb6r5W3k5q0MPjzpWEDaGbds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4DxOhE3LEMf/9wpRxGCF0cdQQE/rotQhhAN0iGjYOc007ARJEXpEHUqMFOJbg2CyWzZgIEkCT7aUupsSjtCo1cJGR++44Btg78OBXhYZT0lyQ1FGUcHIOE3vzTcKqS+0b510CEEorCepWeI4SgtoFdXR9HOjcCujL4EivPeOjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=havpks1j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742375247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OtNSakPmsjuVGQF8Kkh6d/+HhZBiSbvtf54NcxNWCUs=;
	b=havpks1jKQMIXBtFY76eWHPgLOB7LTgagAOP0RCg4GfSRBsG9pLeshZLFfYBMuo/dehpuU
	0dD1X5mDAa/DsTgFoS44ygf+ndvPrmhkvCiMzGQ9P361ve/aDWUG6gc/X0SeCywN6zF6FE
	Y9P+DxaN3LXgqoMMl/4pi3+dEKIUPi8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ZtbsipUQMtGaUAPGCU9cLQ-1; Wed, 19 Mar 2025 05:07:26 -0400
X-MC-Unique: ZtbsipUQMtGaUAPGCU9cLQ-1
X-Mimecast-MFC-AGG-ID: ZtbsipUQMtGaUAPGCU9cLQ_1742375245
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39142ce2151so3035298f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375245; x=1742980045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtNSakPmsjuVGQF8Kkh6d/+HhZBiSbvtf54NcxNWCUs=;
        b=lMba9pdUqh3gsG1qkEutDKiHARorKK0BZAfhFQaR5SAa48fISmQgvFWstpfLHKpMpR
         dtNhfwDbR8oBqN7G1MBVvRfxG3FYkFe21tduGrr/UBTELRnLvk1LUfyfzJtrxuxxyCGy
         OP6PuMitaLI+Z1Bl0GTKoZIbMD81ToRHybaSIzu5xeVgjdMsxq9nqIAUMmNZiF2jdlJD
         CNuuZuZmpnmk9Vxjwygg8nuexs7CsVCK05tBFE7VuEtpxDfHJb7zDekQUpg5iZxS1YSY
         d+hzurs6uoBwXBVcq8Z9RCn+W/aqMiCjyANVaSQP6yUdjqmPL1V6uRcfdtEHeJhpY5LR
         fupA==
X-Forwarded-Encrypted: i=1; AJvYcCVVKr40/NRfBXzJpHTn16LqTaq7gOQYDmv/WGC985TAcDY6SFNCdgO0skyY+sDj55wZU0UorSiNH/5wUvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3DY3VK7Hh0OKyg/NSw3ZQtUH89pkgzofxvnvVdolZc9ob+rY
	y5NNaTt3+keFq4SlDwPDg5jZDPJr1dslrjgwjWS8FwUyOFGSMwTxQPUNTPXvAC8OnKCMzmvIDef
	NgV4KqtJp9/M3BhtAwhU3n/gvxNhovK3kBKL3IqxRVqTd9fvIKiYx742ljuTiSw==
X-Gm-Gg: ASbGncvn/4citkdMCAGyKrTv0Nzh9usMGGWJ/uH8ZtILlvzBefyeHxgrducV1WA3m04
	2xv29f7EbKt6xN9XPGcOKHbotwPEO8H4QKoSPtkK6wm+SIyIoKW5CaNH+rJ+IBejIiI7fefdHYV
	qasemovQsSxQ1+w6BNx2zIp86u0g+oM+5Vg/a/mfA8Ui7msiwTbaxz7P7X9awoKSHlbAWky3azN
	oYCneUYAhcJXkiqzAeNlVPFjX76CzAut4lITRj5qX3fyBib1PMt8km+ImXDLRdKXWbQiYbYfne2
	KVH34WD1Rw==
X-Received: by 2002:a05:6000:2c7:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39973af9236mr1203008f8f.36.1742375244955;
        Wed, 19 Mar 2025 02:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD2b47NZYxg5uLG0ig+ZUAWSFTONEyHXxR8MWacA+06Zt020C+c8ArZXSlhSHTCWh815vtbw==
X-Received: by 2002:a05:6000:2c7:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39973af9236mr1202967f8f.36.1742375244436;
        Wed, 19 Mar 2025 02:07:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a12sm20348037f8f.75.2025.03.19.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:07:23 -0700 (PDT)
Date: Wed, 19 Mar 2025 05:07:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Joe Damato <jdamato@fastly.com>, Philo Lu <lulie@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devel@daynix.com
Subject: Re: [PATCH net-next 0/4] virtio_net: Fixes and improvements
Message-ID: <20250319050708-mutt-send-email-mst@kernel.org>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>

On Tue, Mar 18, 2025 at 06:56:50PM +0900, Akihiko Odaki wrote:
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com
> 
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
> 
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>



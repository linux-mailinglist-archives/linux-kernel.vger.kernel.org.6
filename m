Return-Path: <linux-kernel+bounces-198511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5878D7973
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463E22810EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 00:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6320ED;
	Mon,  3 Jun 2024 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIWwG/+x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79810E6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717376056; cv=none; b=prRgMCwiSkFr8pwhEZwzsGdmAoSVZOzj4b+afPxOfl7mn8eLE4ARMSmaA1sbsZPbXzIGGaU2UZ36Zu50xgcoZem+imasbi0A9lW6C1sR6gsWFjZL6HKAztmWMlBt4MOn6zx3CR0pYqUddW9qPY63Vkm8qcL9RhjpqcgR+4klvV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717376056; c=relaxed/simple;
	bh=FCG0IEbOfT/bHhxbTtejsIy3REUx0zfjYOoOQ1qBhKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcExhYVSmidfyn/mTXrb2OHHEL59kLAhHMMKHIaWmg+DySlR+owB6Ng09YViHszS9391wAjquIE1n2H8dAhCjQ1VpDmo5KWDezY5FrrMedc+1+Ysagup7YROjdAqyW5YnasOixaEV0eyUe2qQ4y7RH2Mik1v1GboBjGq/HEXvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIWwG/+x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717376052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JwTjl/fChud/3QoHHQ7fbqf2HYYxzvAlq+JNY96sgcY=;
	b=KIWwG/+xoFx0GKjbWQXxD8x/CkoLHy6IR2WYIF7kc8qy9LColBwzR6vr1IMjn4Mlp0Q1Xn
	nihLcpV4pj/DWswaiNiXG2NvzCrjfqYZGrASdZeBdad5evL7v3ouugrU9F9BDvPG30TKIo
	FvUexE/lfI6COOTvMuk3J7sK6aaKKiQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-EwEXPhcON8iH50r5nD5WZg-1; Sun,
 02 Jun 2024 20:54:05 -0400
X-MC-Unique: EwEXPhcON8iH50r5nD5WZg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C115D1C05129;
	Mon,  3 Jun 2024 00:54:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CAF7440D182;
	Mon,  3 Jun 2024 00:54:01 +0000 (UTC)
Date: Mon, 3 Jun 2024 08:53:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ublk_drv: add missing MODULE_DESCRIPTION() macro
Message-ID: <Zl0UJZWx9fyZLzrm@fedora>
References: <20240602-md-block-ublk_drv-v1-1-995474cafff0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602-md-block-ublk_drv-v1-1-995474cafff0@quicinc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Sun, Jun 02, 2024 at 05:23:26PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ublk_drv.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/block/ublk_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4e159948c912..59916895ee2e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -3017,4 +3017,5 @@ module_param_cb(ublks_max, &ublk_max_ublks_ops, &ublks_max, 0644);
>  MODULE_PARM_DESC(ublks_max, "max number of ublk devices allowed to add(default: 64)");
>  
>  MODULE_AUTHOR("Ming Lei <ming.lei@redhat.com>");
> +MODULE_DESCRIPTION("Userspace block device");
>  MODULE_LICENSE("GPL");

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming



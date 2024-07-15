Return-Path: <linux-kernel+bounces-252253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE7931097
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688611F22745
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18731850BC;
	Mon, 15 Jul 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU8tp0rF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377123BF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033459; cv=none; b=trh3KQVTxKg67T4YqFqNY17NFtTHgNmv+cMKA91nCUCXvpjWBTVjCurxhIcvTZy/1xh5chE4qwDfu4xzasPfZq8YxGPuix4kgNSL7mlEbH/72zm02+YENqfAXPzApyeL5pJc9YPr21C/fEJlX6ohyGVstIvRCCkPKB9VDfpm+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033459; c=relaxed/simple;
	bh=nBbKavCJyqzrIZv8PJAfPA+w4NgQkEV4ydBoPdiObzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIuRjeUevOapuE+bOsy+ftu2AbEvV3dJZSElSeBGuax/mhnXu3Sknab3xK03tPWh1epnRlzS3bidH4CzVc2CvQX9tj1LvDykchBYKN5XjcKecLomjCu8xR3qlKMmwIUoKJXevD3tqLCm+/QUKTkNXExQ8XjPSCm7rZhDJXWRci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YU8tp0rF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721033456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWvDskXIkPSppbNzkw8xy2ijuffbGpWgqggAAU9Z+vw=;
	b=YU8tp0rFLmFgyolGalTA1ryYHfWVHDhi45Q+KRnN5OkLAmqS+P8wvEojPZV8sRDwr83dyI
	9xxpJTupL6+kzsjuyU+jmcj7P5qF7gwpXFhICw6hdFxryHaq9rgynFzY1785jGfOTj0iNl
	6KpDYwKdCOogE4sZgEbMlmP7lkDYNoM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-0GpRxdD6PHKGmRKKLggbfg-1; Mon, 15 Jul 2024 04:50:54 -0400
X-MC-Unique: 0GpRxdD6PHKGmRKKLggbfg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36792df120fso3071832f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721033453; x=1721638253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWvDskXIkPSppbNzkw8xy2ijuffbGpWgqggAAU9Z+vw=;
        b=hr3c3MVH1cbPosPxQQGrBYCS/8rq7RQhHoH8VXA7lgaLpTPu8qDwATvusgQH1D+NbN
         bNjzAscUkoSBKhzw7Zwc7lkYsDdE6BbnHdAu2hCNrKo34Z+6xlqgDZ4ti0t8Ccnz2n4T
         XekySCdtolwskcWPuDUVTrgVNzyRjiHsPonek/1GKkUWfgZwjJeb1LIaRF+WNAWKth1h
         zQpg8WyQ/rQlQBTlGnFnN5MnT4CepVBob2FFY7UV283OFtixdkfBPIOUH4TJslbVQ5h4
         HoVrJ0h5A4Q0QuIeZ9mM40LGi1dechRtHc7+Pb1CV/nb4AF/ibYgceq2nkl0eBrCpmlw
         /U7g==
X-Forwarded-Encrypted: i=1; AJvYcCUTLsUZdhY+kNF2lUsTLnM3KSLMBOPL9XqbSqVbxBLVOSc0OBAwSuqan/4EhOE/MCHXnvfLXULkfk95NBNaZk1I2roUB4R/zWcrM+2Z
X-Gm-Message-State: AOJu0YxCg7xLPh4Vm0cu8vSDm/Jec91A8dJd2TRDD3MmpZU9zcvuS5ix
	2zDBBO923DojgFI4N4hHLH3QIgmrL/O31s8hFDV3kzFl2v9C7QjNWqyrY3rFP5ylvb6XL/CKDkI
	FXW1NuYlN7UvAC4PwceSrj+fYBciqgVSfWomaS5spPuxSfAqtLHAXlV67tVag4A==
X-Received: by 2002:a05:6000:402c:b0:368:75:26d1 with SMTP id ffacd0b85a97d-3680075279fmr7387114f8f.4.1721033453593;
        Mon, 15 Jul 2024 01:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJu/xoy+GxopR7vQNdNzzt0DKpGm7Wl2vVr2AxEIguJDoit8gJZFlMar45kfsCRcJX/U9SQg==
X-Received: by 2002:a05:6000:402c:b0:368:75:26d1 with SMTP id ffacd0b85a97d-3680075279fmr7387088f8f.4.1721033452953;
        Mon, 15 Jul 2024 01:50:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5146:27c:20a3:47d4:904])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccc9csm5673375f8f.57.2024.07.15.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 01:50:52 -0700 (PDT)
Date: Mon, 15 Jul 2024 04:50:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jiri Pirko <jiri@resnulli.us>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vhost tree
Message-ID: <20240715045026-mutt-send-email-mst@kernel.org>
References: <20240715171041.5d0ec5a1@canb.auug.org.au>
 <ZpTXa-E1SpFJfVBw@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpTXa-E1SpFJfVBw@nanopsycho.orion>

On Mon, Jul 15, 2024 at 10:01:47AM +0200, Jiri Pirko wrote:
> Mon, Jul 15, 2024 at 09:10:41AM CEST, sfr@canb.auug.org.au wrote:
> >Hi all,
> >
> >After merging the vhost tree, today's linux-next build (htmldocs)
> >produced this warning:
> >
> >include/linux/virtio_config.h:136: warning: Excess struct member 'create_avq' description in 'virtio_config_ops'
> >include/linux/virtio_config.h:136: warning: Excess struct member 'destroy_avq' description in 'virtio_config_ops'
> >
> >Introduced by commit
> >
> >  e6bb1118f6da ("virtio: create admin queues alongside other virtqueues")
> 
> Ah, leftover, will send fix. Thx!

Better squash it.

> >
> >-- 
> >Cheers,
> >Stephen Rothwell
> 



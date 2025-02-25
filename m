Return-Path: <linux-kernel+bounces-531319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063DA43EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984431885299
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE0260A57;
	Tue, 25 Feb 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N39kxbgi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE619E992
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485531; cv=none; b=ujHg3rH2yk6o5jTRhnPnuBGhrdEH13JSxq7W4D0CBNoV7oeb61AMM6o2tBQ7gDaktxr/N05ZoV4tDA3IyP/lQxj2DZQ7K3JXhJeDvzO2bQGuLPtKj1qcMX35c5c8mcZCahBs8Yx9sgedNpQIMgl3x4qXZBCu0Gjmqr9FWXuze/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485531; c=relaxed/simple;
	bh=AFsJqmT57iellJeaKTJ9xLV9Cb+tyFIshI1cEMSvhsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC09VQkMc3rcGpTGZWkUfFb/g5VfTUdq116CAKjEIPxQ2zXoPgFp7A09KnOgtDcmalQlZlLpnhItZyJa7+SgNqdmhw+KFsHKmPmx5OjbLzCOhpJmfl9rwHTEcmqG4DV7l2X89mj6sK/64fQY/tIOtNXlE9/AhMkybdJK9ILZLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N39kxbgi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740485529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aJaeu9rZ+DoBGc6xBiNF32UJACZbizHemfkpjSOTkw=;
	b=N39kxbgiUb+S1ENAHp4AQFFCSwS3DvkPnA35/zynJFFQUNSswg5xzuo0+hXUHntVoXbkbH
	gnIoRrZTKK44SoI2mhhvpBG7vwHvM89RkcKqSXJ6l/co/L8h1i8E+x7DEl0jwuu84I2ppK
	b34mUCNEmc/OnrVNVjjDuefSocGi4y4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-TxesqTg2M3SjfkzRuFYo3A-1; Tue, 25 Feb 2025 07:12:07 -0500
X-MC-Unique: TxesqTg2M3SjfkzRuFYo3A-1
X-Mimecast-MFC-AGG-ID: TxesqTg2M3SjfkzRuFYo3A_1740485526
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f37b4a72fso3113059f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485526; x=1741090326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aJaeu9rZ+DoBGc6xBiNF32UJACZbizHemfkpjSOTkw=;
        b=mSjS4mno2qcotd8lvctCRAvc1MCbXDwOHs8rz0uko03bMMXMljSpTvyxPcRv2ZbnWe
         sNCSWPHDSI3wqu6yptNjdViBkS1lYvL+rWWoL0DS6E3Pr3FvdtiiNdZ5ceBBUl0zePs8
         l43285AVJI0+nD5eQKUawtn2DPXRQXJfJZZjqKARlYgsq9JOuJXSMbscIRSPEpL5dCkf
         1vPJIz0PrVTxOBBP/I+z2iSgICxpzDvhtEqje7/ib0CihiI2axrJJYTZzrYbjyqbZtHJ
         lTAGBbEd+GhfEtxYP9genjR5M+OL5O62i6LhJw/xt8PlT3af/w5RbSE/HlYvvWp1GN3/
         +6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUeGFrFq96wetTATvYuQ14MppibTX/CqeGyeAnYeDVZIFd0BNGy+zeCAq2kXhIzXGiZ7CyXovLq1w2nvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBEP8YoJqIiDaoQXShy7dM8Y060V6DFO2JJFLV+WYkB9cyXTfQ
	l+YLP+TsvX81v736YVh+Jh3amVa7sAyvQCZ8RurLchfK9svBI4R8RSAclA/lsumTy/vszgfzJpa
	bJATMLBZGo/KLyK9UI7AqWgQ61NDlll+ZYC6hbrfOQRAABdsq39BIzrfY6S5NbTrifYDFvA==
X-Gm-Gg: ASbGnctqqbZ7a5MI72HdZGiaLsChuawJpHMR2A9fQVOy4rAg5bMHTBGMK8n/ZmZbmnA
	/uxFXT2xydNPdVzVsL5Hav1oeK1UhbW4Nb21tKJouUZQeUvM0RHlHUuCW0wU4VUj/l2GtOLRDA+
	tstTzQdDbMIlGx5YHeDglgpQwb+LD5GMY+862qrVk2el60o/fhglgNZ7CFcDFbtTHKQ0NxLjjeP
	Al2N9nsegezfTscsiSvEhM/Adl1TMwF0PakZ6I2GjUdZwcaKiMuwQzqD6n+Jo8+1f39cHYYqOVP
X-Received: by 2002:a05:6000:1a87:b0:38f:3ec3:4801 with SMTP id ffacd0b85a97d-38f616323bamr19205102f8f.25.1740485526166;
        Tue, 25 Feb 2025 04:12:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEykYFxJqq5aoxM9jT2pNbB1JRNQ14mBWtEkW3/y1tkITWzHYgKP8DWu+Y5OP3wjPUEl3TkZQ==
X-Received: by 2002:a05:6000:1a87:b0:38f:3ec3:4801 with SMTP id ffacd0b85a97d-38f616323bamr19205077f8f.25.1740485525733;
        Tue, 25 Feb 2025 04:12:05 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cc3csm2124927f8f.33.2025.02.25.04.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:12:05 -0800 (PST)
Date: Tue, 25 Feb 2025 07:12:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yufeng Wang <wangyufeng@kylinos.cn>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the vhost tree
Message-ID: <20250225071114-mutt-send-email-mst@kernel.org>
References: <20250225094550.07b771f9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225094550.07b771f9@canb.auug.org.au>

On Tue, Feb 25, 2025 at 09:45:50AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   b995427e8a85 ("tools: virtio/linux/module.h add MODULE_DESCRIPTION() define.")
> 
> Fixes tag
> 
>   Fixes: <ab0727f3ddb8>("virtio: add missing MODULE_DESCRIPTION() macros")
> 
> has these problem(s):
> 
>   - No SHA1 recognised
> 
> In commit
> 
>   9709a9145ffe ("tools/virtio: Add DMA_MAPPING_ERROR and sg_dma_len api define for virtio test")
> 
> Fixes tag
> 
>   Fixes: <c7e1b422afac>("virtio_ring: perform premapped operations based on per-buffer")
> 
> has these problem(s):
> 
>   - No SHA1 recognised
> 
> Fixes tags should be
> 
> Fixes: SHA1 ("subject")
> 
> Also, please keep all the commit message tags together at the end of
> the commit message.


Yep. Thanks, fixed up. Yufeng Wang, pls take a look at my fixup -
both to check them and to make sure to follow this example
in the future.

> -- 
> Cheers,
> Stephen Rothwell




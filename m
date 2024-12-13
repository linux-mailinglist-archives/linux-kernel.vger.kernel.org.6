Return-Path: <linux-kernel+bounces-445384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E9F9F154E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45B67A0387
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECF1E5713;
	Fri, 13 Dec 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJSlD+ht"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5F18CBE1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116112; cv=none; b=GqNmSw3g0Rw+GXfAmhyWURKZ4j0scnomi2lsgJ2Xb2N1PYMMgoGTmCwMtTSd2GNR2rARnNLrZ+opnC1c9X0i5GElJ4dQ02ZDTEWqyzRFj+8XK6tBCDrIQ0BkZXUuCUx7rcVaS4T+dk+LNuIUgQ707QvXKQoUay4iurj4yXYy6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116112; c=relaxed/simple;
	bh=RcJODScoXNF3HP4hDUffKS9Z470PUHCkZnTLG0obbnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAyWZdtY6ABRPK0WdIqc7Gi8CqdJn0oD+UFlpiaBaYrXgj3s/AqGnBn3ql8zmMeC6go+GBLDLckk5x1SyxdsiIYK0wzwJZQ8EhXmdGcGoSTD8vE+jqfO6etzghrAiTYHRcH5Sz68psvO2NXjdRsmRf9mk3QzyyVYt1VkBS5i1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJSlD+ht; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734116108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Oi5mdK80AGx2gnUMpCyjJOjx4fPGiU1BQmQpKsVJLQ=;
	b=dJSlD+htC2r03eudPNEunzVYzYymUamwzGnvG7PxkbSNWBdxDOj649MeNCFt4WSeWZKw8r
	QrA9GzEOovqrkcM3iKH05NUtGmQrGgE/3oU/JEHWq659seGtVYNkk78QANxHS4wywBBJxE
	OT8A8FxcADArRsslicePrANd9sRpwa0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-roIupEnhNEq70YQjlG8TLQ-1; Fri, 13 Dec 2024 13:55:06 -0500
X-MC-Unique: roIupEnhNEq70YQjlG8TLQ-1
X-Mimecast-MFC-AGG-ID: roIupEnhNEq70YQjlG8TLQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e3cbf308so868180f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734116105; x=1734720905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Oi5mdK80AGx2gnUMpCyjJOjx4fPGiU1BQmQpKsVJLQ=;
        b=SucqwGcEG/hzGShNbQZUEY8GngWB8+YB7pv7mSSWuIKH2gP6KDCyEpiOtWlrn+XMRN
         vO7h7ddt7pg9yQRKJZQANNOS1hFmsp0eE+kHdZw4J4Hq7pBvYuQyGL3XfSDexX59HV6u
         aUnSQ/DfmtGbE6kB6L9HfywjxTQZfFYPecpnZUhFlPsFzskyCxBg4K9ByJz0iRQBUG+y
         26Ghy8rEiQgRycxymX3s7vc3vwLlTF6UiSO/r5CDcEUirkCLqmqXQlMblVRg2ewkUgGW
         7GV8lG0ga4fTI4S5JyVkOitF6uexXiHpXH9iDOcbBM0RBI7glexvo4/sknFroYQavKUH
         7bpw==
X-Forwarded-Encrypted: i=1; AJvYcCWXVk1WoHHODxVo34R3Ff6JJsHeO2IvRXV2xso+bvIw+nFFY6cdm2Z8fCNzWvda/c6Rp67tBivbBrwURWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2PhHa0ot2aI2eQt42ongsrYxUSv4OCg5pgZ5oskI31zT3WCH
	IQPL6Uf8gD8N4elviHdmvItuNEtA66aClNUf/CYptHRyd8F07rxkttRMe//bkoe6RhPM5P7SXxN
	clH9iwyJG3SXeJwp+989DsMs7RR6O1MAf+rvYhFbF/whRfvATqeHPkRyzof4x6w==
X-Gm-Gg: ASbGncsV6uT9KzacV06Tm4FfXrH3kUnydbo3hFFKHFWoI+jIskjsvSwnYsq2158UXa+
	5R9zhDVasd9CIxCTtXIHNluJGA/O2+oxfPcMJcW3NELK+jnGkWAnnfq2ewEySJzlQNG0nClxTCI
	F7LXMPqC9J7jM8j3+imyREFx107d/3Rp9L6vycOhApVkxPz7DT5s7JKScP48n0WKjeJZsLRs87/
	PgRK5Y7CwlYNtW0CK3L7Ebn6m1htiApfzO5357t0+zKnZbnLw==
X-Received: by 2002:a05:6000:4024:b0:386:3f3e:ab11 with SMTP id ffacd0b85a97d-3888e0bd231mr3018509f8f.34.1734116105453;
        Fri, 13 Dec 2024 10:55:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqDsqjIlsKqyhHXSOnxjVEITmP6zRNZkmfcHEacMFRdJtvP0V9402C97CiW3ObpgUPBopi4w==
X-Received: by 2002:a05:6000:4024:b0:386:3f3e:ab11 with SMTP id ffacd0b85a97d-3888e0bd231mr3018485f8f.34.1734116105103;
        Fri, 13 Dec 2024 10:55:05 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:66af:6381:7d28:90f3:9fad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80163b8sm265821f8f.35.2024.12.13.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:55:03 -0800 (PST)
Date: Fri, 13 Dec 2024 13:55:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shijith Thotton <sthotton@marvell.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	Srujana Challa <schalla@marvell.com>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI
 capability
Message-ID: <20241213135321-mutt-send-email-mst@kernel.org>
References: <20241209151427.3720026-1-sthotton@marvell.com>
 <20241209151427.3720026-4-sthotton@marvell.com>
 <CACGkMEvuObS4RCk2BjQ4sm6r4jaC3fN4ui5EXd6SVzYxYZV7iA@mail.gmail.com>
 <PH0PR18MB442538D91F856F27F3C37A9AD9382@PH0PR18MB4425.namprd18.prod.outlook.com>
 <PH0PR18MB4425BB6DE30C3805F31D75CED9382@PH0PR18MB4425.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB4425BB6DE30C3805F31D75CED9382@PH0PR18MB4425.namprd18.prod.outlook.com>

On Fri, Dec 13, 2024 at 02:20:24PM +0000, Shijith Thotton wrote:
> >>>
> >>> Added support to read the vendor-specific PCI capability to identify the
> >>> type of device being emulated.
> >>>
> >>> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> >>> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> >>> ---
> >>>  drivers/vdpa/octeon_ep/octep_vdpa.h      | 20 ++++++++++++++
> >>>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 33
> >>+++++++++++++++++++++++-
> >>>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++-
> >>>  3 files changed, 55 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h
> >>b/drivers/vdpa/octeon_ep/octep_vdpa.h
> >>> index 2cadb878e679..53b020b019f7 100644
> >>> --- a/drivers/vdpa/octeon_ep/octep_vdpa.h
> >>> +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> >>> @@ -8,6 +8,7 @@
> >>>  #include <linux/pci_regs.h>
> >>>  #include <linux/vdpa.h>
> >>>  #include <linux/virtio_pci_modern.h>
> >>> +#include <uapi/linux/virtio_crypto.h>
> >>>  #include <uapi/linux/virtio_net.h>
> >>>  #include <uapi/linux/virtio_blk.h>
> >>>  #include <uapi/linux/virtio_config.h>
> >>> @@ -52,6 +53,24 @@ struct octep_vring_info {
> >>>         phys_addr_t notify_pa;
> >>>  };
> >>>
> >>> +enum octep_pci_vndr_cfg_type {
> >>> +       OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID,
> >>> +       OCTEP_PCI_VNDR_CFG_TYPE_MAX,
> >>> +};
> >>> +
> >>> +struct octep_pci_vndr_data {
> >>> +       struct virtio_pci_vndr_data hdr;
> >>> +       u8 id;
> >>> +       u8 bar;
> >>> +       union {
> >>> +               u64 data;
> >>> +               struct {
> >>> +                       u32 offset;
> >>> +                       u32 length;
> >>> +               };
> >>> +       };
> >>> +};
> >>
> >>This seems not to be padded to a multiple of 4 bytes?
> >>
> >
> >Looks like, the structure is naturally aligned.
> >
> >struct virtio_pci_vndr_data {
> >        uint8_t                    cap_vndr;             /*     0     1 */
> >        uint8_t                    cap_next;             /*     1     1 */
> >        uint8_t                    cap_len;              /*     2     1 */
> >        uint8_t                    cfg_type;             /*     3     1 */
> >        uint16_t                   vendor_id;            /*     4     2 */
> >        /* size: 6, cachelines: 1, members: 5 */
> >        /* last cacheline: 6 bytes */
> >};
> >struct octep_pci_vndr_data {
> >        struct virtio_pci_vndr_data hdr;                 /*     0     6 */
> >        uint8_t                    id;                   /*     6     1 */
> >        uint8_t                    bar;                  /*     7     1 */
> >        union {
> >                uint64_t           data;                 /*     8     8 */
> >                struct {
> >                        uint32_t   offset;               /*     8     4 */
> >                        uint32_t   length;               /*    12     4 */
> >                };                                       /*     8     8 */
> >        };                                               /*     8     8 */
> >
> >        /* size: 16, cachelines: 1, members: 4 */
> >        /* last cacheline: 16 bytes */
> >};
> >
> >I will add __attribute__((aligned(4))) to be safe.
> >
> 
> Small correction, I meant   __attribute__((packed, aligned(4))).
> 
> Thanks,
> Shijith

Don't add packed pls, for me it means "something is not packed naturally
here". when in fact it is.

aligned is also bad, since it can add padding which creates all
kind of security issues.

If you want to be sure, add BUILD_BUG_ON and check that it is aligned
as expected.



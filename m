Return-Path: <linux-kernel+bounces-229802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC1917462
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285E81F24110
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEAE17F393;
	Tue, 25 Jun 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtF5ZS32"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F204C6E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719355824; cv=none; b=cyAnr5npFL8movkaQt+MzteDoxCfYReOd9vB/sfn5pqbnbkS3/iXUamQXCMcildpCQEBZFuDp+IDngfWbtaDff1EBOxZ5aY2IhG9cVAkM5t71Ato9rwMqUsH+wzuR4NYsq8EVCSjQ2z/eCC2LLac/JV0yi48tgVuAF1v3sHFyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719355824; c=relaxed/simple;
	bh=OMJJqsWmMXsLxDpb09oJZ90ADbUHbE/I6p9lu0Syvfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1D7GD4YGLbOUYuAq5ibSFiPYSebNGhMoGrPA+Sukkr9hL2JG4neWqfJhoZZMCv9JmYZwAVw8gp8p37e2POF/hrz7Jb0df8W+Pchjdcn4NNYFbi4uQa4iWyrUMmptJMrkjlepJzWE/b9HdDRDKsPACI+kBocyEpnUPeDTyYcNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtF5ZS32; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719355820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oU8QrkeYhtfgg4G8OaEsau9ozz7JUXSqzMXGT4kRNJM=;
	b=PtF5ZS32bmil8ABSpZ+WQNPunpJixZiAzr/JyX3gFbQyRlICsG+Zew6KvK26tT1jSvrBC0
	6JHJjpzqD1pft3/c2nfm2XAwinfk6zaAQ1xqBfXrx+sBzEqXWkPOy+2q+ME84PZIW17XKI
	YXHBqyaBUnY5FOcuJ5TDeyWZhkTdk4c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-n748oOuyOr22xYgGRFKRvA-1; Tue, 25 Jun 2024 18:50:18 -0400
X-MC-Unique: n748oOuyOr22xYgGRFKRvA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-421805fadadso42219885e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719355817; x=1719960617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oU8QrkeYhtfgg4G8OaEsau9ozz7JUXSqzMXGT4kRNJM=;
        b=lntOEp7YFIqLJuqF3ba9e8jsk3vc0JDi+xofFIcoVPLCREVIjqzS6dtL89IRaaVFdc
         HrEFtgP6hEVMcivA3BtBFIq5L4+JJYrmQ4MbHOy934lFiDbUy1iSQIJk8YPewSun+Kau
         uUe9vim3nWbzdkAXEH0cckVQmCrm3gcdTmHXVWdxTWHvmccshecE5y9h0tGoFepfQPNg
         pV5pL/DVq3++KCvxVKf9Et5gmIZFTUEWseCrjZ62zaquZN9LG7vexMhWUvvE7bZg1+ph
         C0KxgyAn3rBmARsrS/n/N1T0qSnufeA+vVARSuZGAp6AmBoVudKGaWI33v+6wKMZUoPV
         N5SA==
X-Forwarded-Encrypted: i=1; AJvYcCX90TAYo0TURIGNyLR9E8U/zJSBKM1y+fdQfDX05nozlb3shHx+NZ9KjfCWAR8wiWYfLoNL2SYeN9dJkr1Vm1KE3TDcdWfCAvHtp7xh
X-Gm-Message-State: AOJu0Yzjkwy6SZPtldVc/cNa+IwVcRmqgXUAGeuLSJkHMFAB41utg1dQ
	ebRvRX4yi3OaGPvoXRP2XqXqX2LPodz3YGucuiod5Eee1u5npN7jtfZFS9A3FhxRcHdul0c5SIK
	WEYwqaX/4tUzByMlqUjLwigjDR6Z1IQ0DHnYBxVNqscDWr/2n2MxMzXs/2hadhA==
X-Received: by 2002:a5d:4bc5:0:b0:35f:2067:2072 with SMTP id ffacd0b85a97d-366e96b2398mr6698747f8f.52.1719355817112;
        Tue, 25 Jun 2024 15:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdr5Ed132jV7cV1Dq86qNW68UOd+n6d3b/DQMkB0QVx0Q/gO7pu5FkpmnKYZrbw8RdUc9qqQ==
X-Received: by 2002:a5d:4bc5:0:b0:35f:2067:2072 with SMTP id ffacd0b85a97d-366e96b2398mr6698734f8f.52.1719355816391;
        Tue, 25 Jun 2024 15:50:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f693fsm14083543f8f.69.2024.06.25.15.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 15:50:15 -0700 (PDT)
Date: Tue, 25 Jun 2024 18:50:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sahanlb <sahanb@bu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	drepper@redhat.com
Subject: Re: [PATCH] virtio-pci: PCI extended capabilities for virtio
Message-ID: <20240625154900-mutt-send-email-mst@kernel.org>
References: <20240625184043.10658-1-sahanb@bu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625184043.10658-1-sahanb@bu.edu>

On Tue, Jun 25, 2024 at 02:39:37PM -0400, sahanlb wrote:
> PCI legacy configuration space does not have sufficient space for a device
> that supports all kinds of virtio structures via PCI capabilities. This is
> especially true if one were to use virtio drivers with physical devices.
> Link: https://par.nsf.gov/servlets/purl/10463939
> A physical device may already have many capabilities in the legacy space.
> 
> This patch adds support to place virtio capabilities in the PCI extended
> configuration space and makes the driver search both legacy and extended
> PCI configuration spaces.
> 
> Add new argument to vp_modern_map_capability to indicate whether mapping
> a legacy or extended capability.
> Add new function virtio_pci_find_ext_capability to walk extended
> capabilities and find virtio capabilities.
> 
> Modify vp_modern_probe to search both legacy and extended configuration
> spaces.
> If virtio_pci_find_capability fails to find common, isr, notify, or device
> virtio structures, call virtio_pci_find_ext_capability.
> 
> Notify virtio structure can get mapped either in vp_modern_probe or in
> vp_modern_map_vq_notify. Add new attribute 'notify_ecap' to
> struct virtio_pci_modern_device to indicate whether the notify capability
> is in the extended congiguration structure.
> 
> Add virtio extended capability structures to
> "include/uapi/linux/virtio_pci.h".
> Format for the extended structures derived from
> Link: https://lore.kernel.org/all/20220112055755.41011-2-jasowang@redhat.com/
> 
> This patch has been validated using an FPGA development board to implement 
> a virtio interface.
> 
> Signed-off-by: sahanlb <sahanb@bu.edu>


Thanks for the patch! As any UAPI change, this one has to also
be accompanied by a spec patch documenting the capabilities.


...

> +struct virtio_pci_cfg_ecap {
> +	struct virtio_pci_ecap cap;
> +	__u8 pci_cfg_data[4]; /* Data for BAR access. */
> +};

Hmm, a weird thing to do. The reason we have it is because
a legacy bios has trouble accessing BAR directly (e.g. if BAR
is 64 bit).  Is there still an issue even for bios with
support for pcie extended config space?


> +
>  /* Macro versions of offsets for the Old Timers! */
>  #define VIRTIO_PCI_CAP_VNDR		0
>  #define VIRTIO_PCI_CAP_NEXT		1


This comes at an interesting time, there is an interest
in order to get virtio working over EP protocol,
in exposing all this information as part of a BAR
as opposed as a capability. I wonder whether that's
also palatable.


> -- 
> 2.42.0



Return-Path: <linux-kernel+bounces-315853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B896C7B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04091C24AE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D01E7675;
	Wed,  4 Sep 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A75cg0sa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FEF1E6DDC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478837; cv=none; b=Mmcda8waAgTfDLl/+Sq4U0YiNwuFYuprGRWLQ7aI97b3nEjcLyVbwyVdsV3Qh3P/U101kzjEE8eGoG/N+VRIevLSgfLdFzqxgi3FDVt74wAnCRqPeVhdjJlzNyxDj0z+u845F4cDR0ahP/k68+3XX72FSToAxd45MlrbyEckPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478837; c=relaxed/simple;
	bh=Fk53gPQvgVQIFSLCm4xJJJE5cIkbACatIsWQP4OYOpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptTp+qCwTiH4jDVu+rBiZ28uk+nb5rWMi/l4C1/sqwjSUMU2eF9TgEEQZE4AftsrBKktacM9otHMUgXZ+E3GlqpZGTJMzLHLgd52/wSzP6lPUTiT22i7V9myiqC1TLXDeeienps7SkNDDWku4m45aB8upM2yju0A4Du5ZJBKBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A75cg0sa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725478834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLwsZcpOTdWORq3NHEPNQ7b2Jve9flGiI+UyLFhibvs=;
	b=A75cg0saGMyMuShsZpX3Bb7sfZbUOCSszNxv5Hq6rELQ0d7ko3a5iL6Y8+zGLV8XnocO5R
	B2wNVrEeMQfLbHH6dnyP7Lmg5sZPgFBlR8L5YDmzFViD6RHzcQg1vMnQjMQOExfFIh1NdY
	a1HEB1l9XGlP/ZAcyY56+cgKkLxUSew=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-Hj0BRB0QPdWYLw0eQTZQtg-1; Wed, 04 Sep 2024 15:40:33 -0400
X-MC-Unique: Hj0BRB0QPdWYLw0eQTZQtg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a1c54b7c0so138034439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478832; x=1726083632;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLwsZcpOTdWORq3NHEPNQ7b2Jve9flGiI+UyLFhibvs=;
        b=S4jcfAzTe/Xe8KJOyH1/2ObGtl+5x+312pzAxDnsRlQEU5lGC84jpC3WjUuNd8GtGw
         BIWeCJ3BSP/N/J0BpR4u9dtkmHf016cSBcPPQnz8wdGa9xYxpxQ4PjP5wWykZSUX4E7d
         eG9l3bENeTdDil4WQ4fiUOcw4B5O4tb1YXX2/2DqK9i9fqiQPviJfou9EgFyDJn2WhHE
         ZM147pmdfx6M/LNLnOv2rqm4SJZhb6ToHV97Z+oXi5slAjjQpFSkpppilMPblZEkB2zV
         Pd/GqVLfnXOftNGDA/VbxU22JL7N6PiYnhvHDi9KSOhSrSL/X1lhgXkoLV2RXxi7fQH3
         OUGg==
X-Forwarded-Encrypted: i=1; AJvYcCXHt3gO908O2Kh8dS3UtD6dPnAS5noJBXGqmL273pNufRa9zDSRKR6VpWgSh8w4f0C93ZFv1iskt1gpFHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyw64Kcvn/RcHQDqvKNICSPQh8b3F+I2AE0e74U8EI/XP7JfN+
	RWIrJEOjZzrQR0+lnc2dZe7CyPT9eBRIVY+JtkkToVNRmNQpZg6ZrU4ctrYP1LkyDF897CzlmFx
	3OZzUlmKE0mee1vk1wU/neHPV4g/MkgvU5qHIGsgaOjUC+uMm9hWVXv5MfOB4mA==
X-Received: by 2002:a6b:db0a:0:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-82a262dcc94mr1148969839f.3.1725478832154;
        Wed, 04 Sep 2024 12:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqeePWUUXEKuIVJXWvfFpfgvAULwqemwYPtg9DlL8GY2cFsyHNg/zSv6eyEmYPzXtWnaZCVw==
X-Received: by 2002:a6b:db0a:0:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-82a262dcc94mr1148967839f.3.1725478831702;
        Wed, 04 Sep 2024 12:40:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2ee8559sm3239846173.174.2024.09.04.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:40:31 -0700 (PDT)
Date: Wed, 4 Sep 2024 13:40:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, treding@nvidia.com, vbhadram@nvidia.com,
 jonathanh@nvidia.com, mperttunen@nvidia.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, clg@redhat.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, msalter@redhat.com
Subject: Re: [RFC PATCH 3/5] vfio_platform: reset: Introduce new open and
 close callbacks
Message-ID: <20240904134028.796b2670.alex.williamson@redhat.com>
In-Reply-To: <60841b43-878a-4467-99a4-12b6e503063c@redhat.com>
References: <20240829161302.607928-1-eric.auger@redhat.com>
	<20240829161302.607928-4-eric.auger@redhat.com>
	<20240829172140.686a7aa7.alex.williamson@redhat.com>
	<60841b43-878a-4467-99a4-12b6e503063c@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 18:03:23 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 8/30/24 01:21, Alex Williamson wrote:
> > On Thu, 29 Aug 2024 18:11:07 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >  
> >> Some devices may require resources such as clocks and resets
> >> which cannot be handled in the vfio_platform agnostic code. Let's
> >> add 2 new callbacks to handle those resources. Those new callbacks
> >> are optional, as opposed to the reset callback. In case they are
> >> implemented, both need to be.
> >>
> >> They are not implemented by the existing reset modules.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>  drivers/vfio/platform/vfio_platform_common.c  | 28 ++++++++++++++++++-
> >>  drivers/vfio/platform/vfio_platform_private.h |  6 ++++
> >>  2 files changed, 33 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> >> index 3be08e58365b..2174e402dc70 100644
> >> --- a/drivers/vfio/platform/vfio_platform_common.c
> >> +++ b/drivers/vfio/platform/vfio_platform_common.c
> >> @@ -228,6 +228,23 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
> >>  	return -EINVAL;
> >>  }
> >>  
> >> +static void vfio_platform_reset_module_close(struct vfio_platform_device *vpdev)
> >> +{
> >> +	if (VFIO_PLATFORM_IS_ACPI(vpdev))
> >> +		return;
> >> +	if (vpdev->reset_ops && vpdev->reset_ops->close)
> >> +		vpdev->reset_ops->close(vpdev);
> >> +}
> >> +
> >> +static int vfio_platform_reset_module_open(struct vfio_platform_device *vpdev)
> >> +{
> >> +	if (VFIO_PLATFORM_IS_ACPI(vpdev))
> >> +		return 0;
> >> +	if (vpdev->reset_ops && vpdev->reset_ops->open)
> >> +		return vpdev->reset_ops->open(vpdev);
> >> +	return 0;
> >> +}  
> > Hi Eric,
> >
> > I didn't get why these are no-op'd on an ACPI platform.  Shouldn't it
> > be up to the reset ops to decide whether to implement something based
> > on the system firmware rather than vfio-platform-common?  
> 
> In case of ACPI boot, ie. VFIO_PLATFORM_IS_ACPI(vpdev) is set, I
> understand we don't use the vfio platform reset module but the ACPI _RST
> method. see vfio_platform_acpi_call_reset() and
> vfio_platform_acpi_has_reset() introduced by d30daa33ec1d ("vfio:
> platform: call _RST method when using ACPI"). I have never had the
> opportunity to test acpi boot reset though.

Aha, I was expecting that VFIO_PLATFORM_IS_ACPI() wouldn't exclusively
require _RST support, but indeed in various places we only look for the
acpihid for the device without also checking for a _RST method.  In
fact commit 7aef80cf3187 ("vfio: platform: rename reset function")
prefixed the reset function pointer with "of_" to try to make that
exclusion more clear, but the previous patch of this series introducing
the ops structure chose a more generic name.  Should we instead use
"of_reset_ops" to maintain that we have two distinct paths, ACPI vs DT?

TBH I'm not sure why we couldn't check that an acpihid also supports a
_RST method and continue to look for reset module support otherwise,
but that's not the way it's coded and there's apparently no demand for
it.

> >> +
> >>  void vfio_platform_close_device(struct vfio_device *core_vdev)
> >>  {
> >>  	struct vfio_platform_device *vdev =
> >> @@ -242,6 +259,7 @@ void vfio_platform_close_device(struct vfio_device *core_vdev)
> >>  			"reset driver is required and reset call failed in release (%d) %s\n",
> >>  			ret, extra_dbg ? extra_dbg : "");
> >>  	}
> >> +	vfio_platform_reset_module_close(vdev);
> >>  	pm_runtime_put(vdev->device);
> >>  	vfio_platform_regions_cleanup(vdev);
> >>  	vfio_platform_irq_cleanup(vdev);
> >> @@ -265,7 +283,13 @@ int vfio_platform_open_device(struct vfio_device *core_vdev)
> >>  
> >>  	ret = pm_runtime_get_sync(vdev->device);
> >>  	if (ret < 0)
> >> -		goto err_rst;
> >> +		goto err_rst_open;
> >> +
> >> +	ret = vfio_platform_reset_module_open(vdev);
> >> +	if (ret) {
> >> +		dev_info(vdev->device, "reset module load failed (%d)\n", ret);
> >> +		goto err_rst_open;
> >> +	}
> >>  
> >>  	ret = vfio_platform_call_reset(vdev, &extra_dbg);
> >>  	if (ret && vdev->reset_required) {
> >> @@ -278,6 +302,8 @@ int vfio_platform_open_device(struct vfio_device *core_vdev)
> >>  	return 0;
> >>  
> >>  err_rst:
> >> +	vfio_platform_reset_module_close(vdev);
> >> +err_rst_open:
> >>  	pm_runtime_put(vdev->device);
> >>  	vfio_platform_irq_cleanup(vdev);
> >>  err_irq:
> >> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> >> index 90c99d2e70f4..528b01c56de6 100644
> >> --- a/drivers/vfio/platform/vfio_platform_private.h
> >> +++ b/drivers/vfio/platform/vfio_platform_private.h
> >> @@ -74,9 +74,13 @@ struct vfio_platform_device {
> >>   * struct vfio_platform_reset_ops - reset ops
> >>   *
> >>   * @reset:	reset function (required)
> >> + * @open:	Called when the first fd is opened for this device (optional)
> >> + * @close:	Called when the last fd is closed for this device (optional)  
> > This doesn't note any platform firmware dependency.  We should probably
> > also note here the XOR requirement enforced below here.  Thanks,  
> To me this is just used along with dt boot, hence the lack of check.

Per the above comment, I'd just specify the whole struct as a DT reset
ops interface and sprinkle "_of_" into the name to make that more
obvious.  Thanks,

Alex

> >>   */
> >>  struct vfio_platform_reset_ops {
> >>  	int (*reset)(struct vfio_platform_device *vdev);
> >> +	int (*open)(struct vfio_platform_device *vdev);
> >> +	void (*close)(struct vfio_platform_device *vdev);
> >>  };
> >>  
> >>  
> >> @@ -129,6 +133,8 @@ __vfio_platform_register_reset(&__ops ## _node)
> >>  MODULE_ALIAS("vfio-reset:" compat);				\
> >>  static int __init reset ## _module_init(void)			\
> >>  {								\
> >> +	if (!!ops.open ^ !!ops.close)				\
> >> +		return -EINVAL;					\
> >>  	vfio_platform_register_reset(compat, ops);		\
> >>  	return 0;						\
> >>  };								\  
> 



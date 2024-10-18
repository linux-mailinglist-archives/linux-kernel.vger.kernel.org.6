Return-Path: <linux-kernel+bounces-371802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D417E9A407A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5080FB21F13
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DA11FF5E6;
	Fri, 18 Oct 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heBy3+lz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751AB1EE022
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259587; cv=none; b=fJcPqwiTnszl+DJtc5MxiVAo/o3UxleUdvVkUjwxyODHxMCLrwYXAmJo9EYjC4lySeYmPqbjn9FfaWDGHYCKg8FPHWFnLNyIIM7kYYlYrcvPFzIHgHnzW2lysK0uF9lYOLogmu6HdLA5jWHLIVmMqupKynFjYi/L5N3uKm7Z90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259587; c=relaxed/simple;
	bh=+pUqJ3djmbey5TSUtiG526xMXDdGeCWo+FHB78sE/JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5h6jMpm7XHSPyNbU7AMFuaDXUMRs/T3jgsN+9RVOKLnVXiggKyxH0q3oQuPu49H/izFgE1zWiFGavxvdLbbKXUTtmS5/9tJ//iPyu1He4LknBo953xDQuc9n9id+aLuqZixCAGfJRtMvXLdh0t23dDSmN9mV52+b6lOxkJ0hAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heBy3+lz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729259584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3MdTWV2aPXX7qYLVHT7xAeOS8FRxLhj6WL39+1SSrXE=;
	b=heBy3+lzTuB7hQ5meYvMl4jD7IO/1YVuALodqdRxRRbTmXSKRBpEfWRYc+ZnnJZ13p+VPd
	/agRAMuD4K5vFAwvnqWHHc37vfHULbCAf0zXpXEHvVCSdphKzxqTFmzKunQqoDypZD/UiD
	WpzwzdX6HHzqbJwmDkp+D3r8NPopw24=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-vkadPesGPGSnk3vtBPuUeg-1; Fri,
 18 Oct 2024 09:52:58 -0400
X-MC-Unique: vkadPesGPGSnk3vtBPuUeg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E918319560B8;
	Fri, 18 Oct 2024 13:52:54 +0000 (UTC)
Received: from localhost (unknown [10.72.112.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7518A1955E94;
	Fri, 18 Oct 2024 13:52:51 +0000 (UTC)
Date: Fri, 18 Oct 2024 21:52:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gregory Price <gourry@gourry.net>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com, ying.huang@intel.com,
	tglx@linutronix.de, takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
 <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/18/24 at 03:22pm, Andy Shevchenko wrote:
> On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:
> > HI Gregory,
> > 
> > On 10/17/24 at 03:03pm, Gregory Price wrote:
> > > walk_system_ram_res_rev() erroneously discards resource flags when
> > > passing the information to the callback.
> > > 
> > > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > > have these resources selected during kexec to store kexec buffers
> > > if that memory happens to be at placed above normal system ram.
> > 
> > Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
> > memory carefully, wondering if res could be set as
> > 'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
> > IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.
> > 
> > Anyway, the change in this patch is certainly better. Thanks.
> 
> Can we get more test cases in the respective module, please?

Do you mean testing CXL memory in kexec/kdump? No, we can't. Kexec/kdump
test cases basically is system testing, not unit test or module test. It
needs run system and then jump to 2nd kernel, vm can be used but it
can't cover many cases existing only on baremetal. Currenly, Redhat's
CKI is heavily relied on to test them, however I am not sure if system
with CXL support is available in our LAB.

Not sure if I got you right.



Return-Path: <linux-kernel+bounces-533541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07329A45BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0D01765C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A7326E17A;
	Wed, 26 Feb 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x/z/PNKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5724DFFC;
	Wed, 26 Feb 2025 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565856; cv=none; b=dP41ai0jeDahIdNATMEZ2dZlXYdTVHhlOG1byLy/tlEdbkUW/gghBVjBTyaP8toVSziAA6iahv7a3PD0d7ofACczi6M66hkmc1sK6A+2ftZVVvPpFmfCmnTSCgWuJYPIftWEBsBSDpqGm8cE9+XHqfKMPQrK99EVXnheWPHCVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565856; c=relaxed/simple;
	bh=kBUtFhM8QF9lXl5OpGbCyIrYvEiAU3LRgYh6moTbcNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIPQbe/ydLSYJpjxLISiYyQUPl0zGtYKbMqJDQRAWPBFIRHPC8AtMWMCD+rAKoMs41vA1o6xNOyqnHaYXZaVZeGdksvGkwjUjMnsnTTpA9aweEugoWJpVx83zdeKdo1t7TQ1ERXIM9iGPIR711p57zQmaVo4hm0sC+RllZYO+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x/z/PNKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C58C4CEE2;
	Wed, 26 Feb 2025 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740565855;
	bh=kBUtFhM8QF9lXl5OpGbCyIrYvEiAU3LRgYh6moTbcNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x/z/PNKyqA4PfaRNvSey27ZTn7J05bWCh1y6AuSHXaKbsuIZbgCgF5SfXl9GxP2Z7
	 065ngG6haLk6ln7TkkSlWws7pfkhzxlXfPzhpjuytZpJR0F//RpCQLnhkfNJrpJhQK
	 HRhuiH2KFKxSftKP77aaZn3LBM5y0sTRshzg8quY=
Date: Wed, 26 Feb 2025 11:07:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Zijun Hu <quic_zijuhu@quicinc.com>, linux-usb@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 9/9] drm/vkms: convert to use faux_device
Message-ID: <2025022643-scouting-petticoat-492b@gregkh>
References: <2025021023-sandstorm-precise-9f5d@gregkh>
 <2025021029-snout-swivel-9a45@gregkh>
 <Z6oPNmRo4XQQVEI8@louis-chauvet-laptop>
 <f1ea30fe-8cb8-41fd-bc85-d511c800e594@suse.de>
 <49cd8502-f11e-4ade-a3a0-b16ce0c6282f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49cd8502-f11e-4ade-a3a0-b16ce0c6282f@bootlin.com>

On Tue, Feb 25, 2025 at 02:51:40PM +0100, Louis Chauvet wrote:
> 
> 
> Le 25/02/2025 à 12:41, Thomas Zimmermann a écrit :
> > Hi
> > 
> > Am 10.02.25 um 15:37 schrieb Louis Chauvet:
> > > On 10/02/25 - 13:30, Greg Kroah-Hartman wrote:
> > > > The vkms driver does not need to create a platform device, as there is
> > > > no real platform resources associated it,  it only did so because it was
> > > > simple to do that in order to get a device to use for resource
> > > > management of drm resources.  Change the driver to use the faux device
> > > > instead as this is NOT a real platform device.
> > > > 
> > > > Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: Melissa Wen <melissa.srw@gmail.com>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > 
> > > Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > 
> > > Thanks for the modification, it seems to work.
> > 
> > Should this patch be merged through DRM trees? drm-misc-next is at
> > v6.14-rc4 and has struct faux_device.
> 
> Hi,
> 
> I was not aware the faux-device was merged, as it is a new feature, I
> expected it to reach drm-misc-next on 6.15-rc1.

I added it to Linus's tree just so that DRM could get these changes into
their tree now :)

> I plan to merge [1] today/tomorrow (well tested with platform_device), and
> then I will submit an updated version of this patch (only trivial conflicts,
> but never tested with multiple VKMS devices).
> 
> [1]:https://lore.kernel.org/all/20250218101214.5790-1-jose.exposito89@gmail.com/

Great, thanks!

greg k-h


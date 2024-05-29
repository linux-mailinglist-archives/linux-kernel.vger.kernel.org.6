Return-Path: <linux-kernel+bounces-194542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D38D3DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BBBB242A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FDB187334;
	Wed, 29 May 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1jdNfA4"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378ADDA1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005338; cv=none; b=o6rHubKfTqL5x4HhOrfah11SH0FZlMDshtT6u4+xdrVcic7CdwYM7yaPGwCetvofpv0mijJTcWjpMKhAyTwPz6ogN+wvSlqxkHL21u6DmYk3zs4UiBgijWBN78nLDm4/hkPuSibNc5D19TPyeOPjE0gKKd8GW6kSRRcBcdGYb04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005338; c=relaxed/simple;
	bh=howN3tvUDFN955jtqlIw20y79PvZGLeozyoADasfiRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVwqr4zsi5sDQxe0zYoMzG1WIrtMpmncJ3A6al7/cEJSwj2gWxPjIUuDjGSENGV7SKhE5ctm2SXTCHlZdPCG5mIaSz7Q2CmNCb0ydHCi+HDyGKU4YJJMZWvxzvBuegIyHkSEybICWLZU+x+2OcGbgtSTfhRX8JWpRfEOnhKKbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1jdNfA4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b78c65cadso75643e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717005334; x=1717610134; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oI1WONPChvzTYeClTUbWKLHkDxCb4Kvg9ToUPjcgp9U=;
        b=k1jdNfA4YZmuQvXqcqEWFl/Rbw3Ej/Z+DxMmi6quHKVF7xEbPwytANV+0ge2gTGopF
         eEfSOp2MKb5gWlADoMSkxkdGYZ27hQybtuxssXRFCJEGJkHj05cYymJWoEMO31wngeJ8
         6R+7o94Rw8noaiyNKB7YQ6KB9tZaq3qE5rPi+rCWTeEb+Ft0dbAdRms5giY6VEHJmMaG
         gANsDQ6D0tqfhO7Tc8bHGD4DE0FOrX8vc9uEoQcrnKJ149SWTLFEiSxjmfdzXudvtd+o
         4Dl0iU20+ffanQSStqO/MWA3wYZ8QVhEs6g6Xzb5+F0gJO2gYGqXs/fOh5UgIB5pP5fT
         D0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717005334; x=1717610134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oI1WONPChvzTYeClTUbWKLHkDxCb4Kvg9ToUPjcgp9U=;
        b=RhRFxgrH4wD13mD6JvCEWG3+WWxtbLUguNnOXrXd2bGP08LPrwDbq0AOgKY4XR+SRo
         PbY2Uf/e+OdUCoVJ0dsGjxi8x2WpyjrcArpFkiPMaFqdwruBw0gcf4KQT1bCs+u78IcK
         z/1s+FqwhAC0Yb3W92T9H5yiDQfeGKunrnMK0BoKa7mW5NBMLIp+TgUMmEqLI5d2bd0I
         z6E6rg8IDiwMc4E10yUmeIAcynxWb8kku/R+Lmb2xVwWOGJy+U4u34gTNLdbQAHIxwND
         5q2pTZPFupbcUHN3bt1xRP+SWJhucINoxAISDsEssO6QTSlHyr7o0DbfnLCthlRrYzg3
         I2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVjb5r6viArxhRfObeO5xQkU1x0++9VrcS5R195zy0F+Io7mM7AhvX2gpbp5+D3z1mgU0xBzru5FCZbIbTG8R4oPx6mKJwlqgNVJBhy
X-Gm-Message-State: AOJu0Yy3AkyZd8A5Gp65s9wABfbMiX0o9PotVSGFRVKGzVInNoecm/qb
	7I1FrLrxNNsZl82Wovxi2mCS6jiifIHDEpEaEHtryElfwkx1jyNbv6PgRXc1SyI=
X-Google-Smtp-Source: AGHT+IFQAm6qc7XzXyN8C8JYg8UfiJ+A4EBCRSceaiEsuveEbLqGxA+ipv55BAQ/m89F/t4Nfy8sXA==
X-Received: by 2002:ac2:4a9e:0:b0:515:fc44:b3f7 with SMTP id 2adb3069b0e04-5296556f224mr14865849e87.24.1717005334305;
        Wed, 29 May 2024 10:55:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529716df56esm1317134e87.301.2024.05.29.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 10:55:33 -0700 (PDT)
Date: Wed, 29 May 2024 20:55:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, 
	Chris Bainbridge <chris.bainbridge@gmail.com>, hughsient@gmail.com
Subject: Re: [PATCH v2] drm/client: Detect when ACPI lid is closed during
 initialization
Message-ID: <g34f3sdk22grheq2vaaonkl543dtk7nb5sffqgmkl5ywtj5skk@p5ht5ug33q4z>
References: <20240528210319.1242-1-mario.limonciello@amd.com>
 <Zlc4V1goFvU2antl@intel.com>
 <197d195f-9206-41dd-8ff1-f4bb4988fb9b@amd.com>
 <ZldMKZ1MzSDXOheJ@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZldMKZ1MzSDXOheJ@intel.com>

On Wed, May 29, 2024 at 06:39:21PM +0300, Ville Syrjälä wrote:
> On Wed, May 29, 2024 at 09:45:55AM -0500, Mario Limonciello wrote:
> > On 5/29/2024 09:14, Ville Syrjälä wrote:
> > > On Tue, May 28, 2024 at 04:03:19PM -0500, Mario Limonciello wrote:
> > >> If the lid on a laptop is closed when eDP connectors are populated
> > >> then it remains enabled when the initial framebuffer configuration
> > >> is built.
> > >>
> > >> When creating the initial framebuffer configuration detect the ACPI
> > >> lid status and if it's closed disable any eDP connectors.
> > >>
> > >> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> > >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3349
> > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > >> ---
> > >> Cc: hughsient@gmail.com
> > >> v1->v2:
> > >>   * Match LVDS as well
> > >> ---
> > >>   drivers/gpu/drm/drm_client_modeset.c | 30 ++++++++++++++++++++++++++++
> > >>   1 file changed, 30 insertions(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> > >> index 31af5cf37a09..0b0411086e76 100644
> > >> --- a/drivers/gpu/drm/drm_client_modeset.c
> > >> +++ b/drivers/gpu/drm/drm_client_modeset.c
> > >> @@ -8,6 +8,7 @@
> > >>    */
> > >>   
> > >>   #include "drm/drm_modeset_lock.h"
> > >> +#include <acpi/button.h>
> > >>   #include <linux/module.h>
> > >>   #include <linux/mutex.h>
> > >>   #include <linux/slab.h>
> > >> @@ -257,6 +258,34 @@ static void drm_client_connectors_enabled(struct drm_connector **connectors,
> > >>   		enabled[i] = drm_connector_enabled(connectors[i], false);
> > >>   }
> > >>   
> > >> +static void drm_client_match_edp_lid(struct drm_device *dev,
> > >> +				     struct drm_connector **connectors,
> > >> +				     unsigned int connector_count,
> > >> +				     bool *enabled)
> > >> +{
> > >> +	int i;
> > >> +
> > >> +	for (i = 0; i < connector_count; i++) {
> > >> +		struct drm_connector *connector = connectors[i];
> > >> +
> > >> +		switch (connector->connector_type) {
> > >> +		case DRM_MODE_CONNECTOR_LVDS:
> > >> +		case DRM_MODE_CONNECTOR_eDP:

What about DPI or DSI panels? I think they should also be handled in a
similar way. Not sure regarding the SPI.

> > >> +			if (!enabled[i])
> > >> +				continue;
> > >> +			break;
> > >> +		default:
> > >> +			continue;
> > >> +		}
> > >> +
> > >> +		if (!acpi_lid_open()) {
> > >> +			drm_dbg_kms(dev, "[CONNECTOR:%d:%s] lid is closed, disabling\n",
> > >> +				    connector->base.id, connector->name);
> > >> +			enabled[i] = false;
> > >> +		}
> > >> +	}
> > >> +}
> > > 

[trimmed]

> 
> The other potential issue here is whether acpi_lid_open() is actually
> trustworthy. Some kms drivers have/had some lid handling in their own
> code, and I'm pretty sure those have often needed quirks/modparams
> to actually do sensible things on certain machines.
> 
> FWIW I ripped out all the lid crap from i915 long ago since it was
> half backed, mostly broken, and ugly, and I'm not looking to add it
> back there. But I do think handling that in drm_client does seem
> somewhat sane, as that should more or less match what userspace
> clients would do. Just a question of how bad the quirk situation
> will get...

Looking at drivers/acpi/button.c, the button driver handles some of the
quirks when posting the data to the input subsystem.

> 
> 
> Also a direct acpi_lid_open() call seems a bit iffy. But I guess if
> someone needs this to work on non-ACPI system they get to figure out
> how to abstract it better. acpi_lid_open() does seem to return != 0
> when ACPI is not supported, so at least it would err on the side
> of enabling everything.

Thanks. I was going to comment, but you got it first. I think a proper
implementation should check for SW_LID input device instead of simply
using acpi_lid_open(). This will handle the issue for other,
non-ACPI-based laptops.

-- 
With best wishes
Dmitry


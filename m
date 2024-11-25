Return-Path: <linux-kernel+bounces-420737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489499D82BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0929C281731
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229218F2E2;
	Mon, 25 Nov 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkS+gBPk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83262500B4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527915; cv=none; b=RBfR+LdKec940gcX0wFM0VHi18SIhvzZWCCZ+aXkbKwF1ik1Gsn53gtq1nyE8zqzmyCqvdo6TxB7idd3xTMl74BFlRrXMoVdpfntsKTbfsKDwIDm+9sRkGABn7aIGFeF31DiyeRUhV+iT3onqFTWjBv/wiQO99Ohmo5Qt7k5stw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527915; c=relaxed/simple;
	bh=x028aXeuOrFWn6SSDLQRuiQSir9d+QFOOxfmn2XOey8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpgNn3x/4Ehu1mBPZy6p6NUuNkucbr07XU8hJ5cgbqNxPqcqYwEmig4hJCsiu4nUoJ2URvCKDLuCo37SqqN0Ug8o103LlAMnaL0WyYCTi6Z9fk21KdW5LB1ziRX/ej5T2FQvIkNhMUPrwsKzYvXwG9gpplTbSu6yMR8jcJrrNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkS+gBPk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732527914; x=1764063914;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=x028aXeuOrFWn6SSDLQRuiQSir9d+QFOOxfmn2XOey8=;
  b=HkS+gBPkHW43kTq0sWGc30cw2yVGwD710yNUMW8nZOyFXQS4v3XRuY1f
   HhZNQfUXAXYv1w33mtHc3gcIvBDFAUui4i9yy0J6s269NcR9PKlwpx1sB
   D3MxXGNPoTfVBMhE8xbrKe7O4glLSROvw23XjSDWVbJVwVKNZhlrVQcii
   bDs1w6WCvA6sv4X7INYx5Lpq0ATZuMmCdn/G1GjQAA7xl8LmCzMEh+umC
   mEktxT7OLySlz7R383fqDogEcFx6H9qpS9a5VARrAoKA/pNM4HEOyQ6PU
   2GX57mGIlzCcKUeIe6uwneXDLYtmoeac5wfrjiVYBAFhDp2DS7HzKFikD
   Q==;
X-CSE-ConnectionGUID: 2ORZ1sVPRmu2iECIATA++A==
X-CSE-MsgGUID: y9Ag7IJHSSeMejIlxfpe+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="32752376"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32752376"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 01:45:13 -0800
X-CSE-ConnectionGUID: wyt/aj7uR6qy9lk/sV6QoQ==
X-CSE-MsgGUID: +B+QqeZkT8C5sYLHFbcgTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="96143804"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.243])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 01:45:07 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, =?utf-8?Q?Ma=C3=ADra?= Canal
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: arthurgrillo@riseup.net, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, nicolejadeyee@google.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Louis
 Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH RFC v2 17/18] drm/vkms: Introduce config for connector EDID
In-Reply-To: <20241122-google-remove-crtc-index-from-parameter-v2-17-81540742535a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
 <20241122-google-remove-crtc-index-from-parameter-v2-17-81540742535a@bootlin.com>
Date: Mon, 25 Nov 2024 11:45:04 +0200
Message-ID: <87o723y7dr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 22 Nov 2024, Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> To properly test the EDID reading without using the DRM override, add an
> option to configure the EDID for a connector.
>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c |  1 +
>  drivers/gpu/drm/vkms/vkms_config.h |  2 ++
>  drivers/gpu/drm/vkms/vkms_output.c | 37 ++++++++++++++++++++++++++++++++++---
>  3 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index ac1a9658c5075c118d59da965ca3392355ccb2b2..1a1234d4f10fa8e5ea6bd649139ecc10c991f875 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -199,6 +199,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *v
>  	xa_init_flags(&vkms_config_connector->possible_encoders, XA_FLAGS_ALLOC);
>  	vkms_config_connector->type = DRM_MODE_CONNECTOR_VIRTUAL;
>  	vkms_config_connector->status = connector_status_unknown;
> +	vkms_config_connector->edid_blob_len = 0;
>  
>  	return vkms_config_connector;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index bba56c9d8aeceac97a4339ef42ab663c5dc54e65..1220b16f6c98d1ebb0ae55d662a84fe25e1a6a02 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -112,6 +112,8 @@ struct vkms_config_connector {
>  	struct xarray possible_encoders;
>  	int type;
>  	enum drm_connector_status status;
> +	char edid_blob[PAGE_SIZE];
> +	int edid_blob_len;
>  
>  	/* Internal usage */
>  	struct drm_connector *connector;
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index fc6a0cdade0739b94820ed4e0924cf355137fe79..56590afb33d75465971d10a282040690840cdbee 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -31,13 +31,44 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
> +static int vkms_connector_read_block(void *context, u8 *buf, unsigned int block, size_t len)
> +{
> +	struct vkms_config_connector *config = context;
> +
> +	if (block * len + len > config->edid_blob_len)

The parameters to the read block function are a bit weird for historical
reasons. The start offset is indicated by block number, length by
len. The start byte offset is thus block * EDID_LENGTH! There's no
smaller granularity for start offset. However len can be < EDID_LENGTH!

So the above should be (block * EDID_LENGTH + len > edid_blob_len)

> +		return 1;
> +	memcpy(buf, &config->edid_blob[block * len], len);

And this should be &config->edid_blob[block * EDID_LENGTH].

(Your patch would work, but just by coincidence due to the way the read
block function is currently called.)

> +	return 0;
> +}
> +
>  static int vkms_conn_get_modes(struct drm_connector *connector)
>  {
> +	const struct drm_edid *drm_edid = NULL;
>  	int count;
> +	struct vkms_config_connector *connector_cfg;
> +	struct vkms_device *vkmsdev = drm_device_to_vkms_device(connector->dev);
> +	struct vkms_config_connector *context = NULL;
> +
> +	list_for_each_entry(connector_cfg, &vkmsdev->config->connectors, link) {
> +		if (connector_cfg->connector == connector) {
> +			context = connector_cfg;
> +			break;
> +		}
> +	}
> +	if (context)
> +		drm_edid = drm_edid_read_custom(connector, vkms_connector_read_block, context);

Thanks for using drm_edid_read_custom() for this btw!

> +
> +	/*
> +	 * Unconditionally update the connector. If the EDID was read
> +	 * successfully, fill in the connector information derived from the
> +	 * EDID. Otherwise, if the EDID is NULL, clear the connector
> +	 * information.
> +	 */
> +	drm_edid_connector_update(connector, drm_edid);
> +
> +	count = drm_edid_connector_add_modes(connector);
>  
> -	/* Use the default modes list from DRM */
> -	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
> -	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);

I don't really know anything about your use case, but don't you want to
fall back to the above for drm_edid == NULL? *shrug*

BR,
Jani.

> +	drm_edid_free(drm_edid);
>  
>  	return count;
>  }

-- 
Jani Nikula, Intel


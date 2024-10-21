Return-Path: <linux-kernel+bounces-374470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C099A6AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFF0B21D03
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4299C1F8936;
	Mon, 21 Oct 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNzvB6xq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D561EBA0C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518140; cv=none; b=dXplrXy3WGPiDQ83djCyI3ZEz9CDnpxFoslA+G9o6NbQWg/WgVHxdnyPTCUOo2j9Je99tFBaS+ttxkFLweX4P8NhXXw68TXkNOuIQif+1yCYB18adiDuBGAe2GhIqpRt2BQClJxv7oMtenC4xPK7kqRz01i3SBa+1KBV1d5VbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518140; c=relaxed/simple;
	bh=pjvibWiVCG0PZxiM1xmWuEP9nThsSFVq3jPfmC8Vi4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxZsE91MP5J4OOG9EJDQO4Rad2nU8CeGWHkKwaY+XPBXTgR3ht4xmvtdzyCpcc27W+3xsNr9QJfUB2jWCIsdOlgkwimKL8Mt/3GfEVp9hzna+l8cyymfrMkAXuo14LxO+At5sXGBPry9kYo2aae1K+gyAqpC7pc/sNsZjt4w0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNzvB6xq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729518138; x=1761054138;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pjvibWiVCG0PZxiM1xmWuEP9nThsSFVq3jPfmC8Vi4E=;
  b=kNzvB6xqehop0C4pgDcdmH/A9deU7Itf5BhdmAt+yVLFfkZKOYZfbemW
   Jjbusj/4PlU08yKKxLmow+X4TqRHcyTTiDZCLBBm581cSCeJt5IPq+10F
   NE+EADxVZNQmmkxmPhzhlxDk2dqQot4XKDUZ2im0fZ4QK5+qUj+RiJp7f
   S+N0/MPx6Mj6Ouws56gnSMNclUE6nPQhqaCGC/MkAqpS1OIh6P68lUsza
   xct9SGxkuZUmQlhZAVW9RbuIh4gpRI3zT6tbjRuIkAdYNz1/eBDOGWGwe
   8EWf/si6obsAL/atnklcbmkIsgNBupLJgVr56fS+v2MNZZlAYybmCO9Kj
   w==;
X-CSE-ConnectionGUID: acOKUd/ORByIyGJuWC2rag==
X-CSE-MsgGUID: 4YQZzTPDRdehi4GMHaJCfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="32928204"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="32928204"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:42:12 -0700
X-CSE-ConnectionGUID: mCKX58edS1qA1g+YHEihxw==
X-CSE-MsgGUID: 6qhZLUzeQyOxSGhnBMmJCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="80355240"
Received: from lbogdanm-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:42:08 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: transition to passing struct cea_db * to
 cae_db_payload_len
In-Reply-To: <20241011152929.10145-1-vamsikrishna.brahmajosyula@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241011152929.10145-1-vamsikrishna.brahmajosyula@gmail.com>
Date: Mon, 21 Oct 2024 16:42:04 +0300
Message-ID: <87jze1y3mb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 11 Oct 2024, Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com> wrote:
> Address the FIXME in cea_db_payload_len
> 	Transition to passing struct cea_db * everywhere

You've misunderstood the comment. The point is to pass struct cea_db *
around, not to stick to u8 * and drop calls to cea_db_payload_len().

BR,
Jani.

>
> Precompute the payload length in drm_parse_cea_ext and pass to
> individual parsers to avoid casting struct cea_db pointer to u8
> pointer where length is needed.
>
> Since the type of payload length is inconsistent in the file,
> use u8, u16 where it was already in place, use int elsewhere.
>
> Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 63 ++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 855beafb76ff..80442e8b8ac6 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -4977,11 +4977,8 @@ static int cea_db_tag(const struct cea_db *db)
>  	return db->tag_length >> 5;
>  }
>  
> -static int cea_db_payload_len(const void *_db)
> +static int cea_db_payload_len(const struct cea_db *db)
>  {
> -	/* FIXME: Transition to passing struct cea_db * everywhere. */
> -	const struct cea_db *db = _db;
> -
>  	return db->tag_length & 0x1f;
>  }
>  
> @@ -5432,22 +5429,18 @@ static uint8_t hdr_metadata_type(const u8 *edid_ext)
>  }
>  
>  static void
> -drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *db)
> +drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *db, const u16 payload_len)
>  {
> -	u16 len;
> -
> -	len = cea_db_payload_len(db);
> -
>  	connector->hdr_sink_metadata.hdmi_type1.eotf =
>  						eotf_supported(db);
>  	connector->hdr_sink_metadata.hdmi_type1.metadata_type =
>  						hdr_metadata_type(db);
>  
> -	if (len >= 4)
> +	if (payload_len >= 4)
>  		connector->hdr_sink_metadata.hdmi_type1.max_cll = db[4];
> -	if (len >= 5)
> +	if (payload_len >= 5)
>  		connector->hdr_sink_metadata.hdmi_type1.max_fall = db[5];
> -	if (len >= 6) {
> +	if (payload_len >= 6) {
>  		connector->hdr_sink_metadata.hdmi_type1.min_cll = db[6];
>  
>  		/* Calculate only when all values are available */
> @@ -5457,20 +5450,18 @@ drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *db)
>  
>  /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
>  static void
> -drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *db)
> +drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *db, u8 payload_len)
>  {
> -	u8 len = cea_db_payload_len(db);
> -
> -	if (len >= 6 && (db[6] & (1 << 7)))
> +	if (payload_len >= 6 && (db[6] & (1 << 7)))
>  		connector->eld[DRM_ELD_SAD_COUNT_CONN_TYPE] |= DRM_ELD_SUPPORTS_AI;
>  
> -	if (len >= 10 && hdmi_vsdb_latency_present(db)) {
> +	if (payload_len >= 10 && hdmi_vsdb_latency_present(db)) {
>  		connector->latency_present[0] = true;
>  		connector->video_latency[0] = db[9];
>  		connector->audio_latency[0] = db[10];
>  	}
>  
> -	if (len >= 12 && hdmi_vsdb_i_latency_present(db)) {
> +	if (payload_len >= 12 && hdmi_vsdb_i_latency_present(db)) {
>  		connector->latency_present[1] = true;
>  		connector->video_latency[1] = db[11];
>  		connector->audio_latency[1] = db[12];
> @@ -5695,7 +5686,7 @@ static void drm_edid_to_eld(struct drm_connector *connector,
>  		case CTA_DB_VENDOR:
>  			/* HDMI Vendor-Specific Data Block */
>  			if (cea_db_is_hdmi_vsdb(db))
> -				drm_parse_hdmi_vsdb_audio(connector, (const u8 *)db);
> +				drm_parse_hdmi_vsdb_audio(connector, (const u8 *)db, len);
>  			break;
>  		default:
>  			break;
> @@ -6122,7 +6113,7 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
>  }
>  
>  static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
> -			       const u8 *hf_scds)
> +			       const u8 *hf_scds, int payload_len)
>  {
>  	hdmi_dsc->v_1p2 = hf_scds[11] & DRM_EDID_DSC_1P2;
>  
> @@ -6142,7 +6133,7 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
>  		/* Supports min 8 BPC if DSC 1.2 is supported*/
>  		hdmi_dsc->bpc_supported = 8;
>  
> -	if (cea_db_payload_len(hf_scds) >= 12 && hf_scds[12]) {
> +	if (payload_len >= 12 && hf_scds[12]) {
>  		u8 dsc_max_slices;
>  		u8 dsc_max_frl_rate;
>  
> @@ -6188,13 +6179,13 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
>  		}
>  	}
>  
> -	if (cea_db_payload_len(hf_scds) >= 13 && hf_scds[13])
> +	if (payload_len >= 13 && hf_scds[13])
>  		hdmi_dsc->total_chunk_kbytes = hf_scds[13] & DRM_EDID_DSC_TOTAL_CHUNK_KBYTES;
>  }
>  
>  /* Sink Capability Data Structure */
>  static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
> -				      const u8 *hf_scds)
> +				      const u8 *hf_scds, int payload_len)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	struct drm_hdmi_info *hdmi = &info->hdmi;
> @@ -6247,8 +6238,8 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  
>  	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
>  
> -	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
> -		drm_parse_dsc_info(hdmi_dsc, hf_scds);
> +	if (payload_len >= 11 && hf_scds[11]) {
> +		drm_parse_dsc_info(hdmi_dsc, hf_scds, payload_len);
>  		dsc_support = true;
>  	}
>  
> @@ -6259,7 +6250,7 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  }
>  
>  static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
> -					   const u8 *hdmi)
> +					   const u8 *hdmi, const u8 payload_len)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	unsigned int dc_bpc = 0;
> @@ -6267,7 +6258,7 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
>  	/* HDMI supports at least 8 bpc */
>  	info->bpc = 8;
>  
> -	if (cea_db_payload_len(hdmi) < 6)
> +	if (payload_len < 6)
>  		return;
>  
>  	if (hdmi[6] & DRM_EDID_HDMI_DC_30) {
> @@ -6320,18 +6311,17 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
>  
>  /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
>  static void
> -drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
> +drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db, const u8 payload_len)
>  {
>  	struct drm_display_info *info = &connector->display_info;
> -	u8 len = cea_db_payload_len(db);
>  
>  	info->is_hdmi = true;
>  
>  	info->source_physical_address = (db[4] << 8) | db[5];
>  
> -	if (len >= 6)
> +	if (payload_len >= 6)
>  		info->dvi_dual = db[6] & 1;
> -	if (len >= 7)
> +	if (payload_len >= 7)
>  		info->max_tmds_clock = db[7] * 5000;
>  
>  	/*
> @@ -6340,14 +6330,14 @@ drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
>  	 * HDMI infoframe support was first added in HDMI 1.4. Assume the sink
>  	 * supports infoframes if HDMI_Video_present is set.
>  	 */
> -	if (len >= 8 && db[8] & BIT(5))
> +	if (payload_len >= 8 && db[8] & BIT(5))
>  		info->has_hdmi_infoframe = true;
>  
>  	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI: DVI dual %d, max TMDS clock %d kHz\n",
>  		    connector->base.id, connector->name,
>  		    info->dvi_dual, info->max_tmds_clock);
>  
> -	drm_parse_hdmi_deep_color_info(connector, db);
> +	drm_parse_hdmi_deep_color_info(connector, db, payload_len);
>  }
>  
>  /*
> @@ -6410,12 +6400,13 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
>  	cea_db_iter_for_each(db, &iter) {
>  		/* FIXME: convert parsers to use struct cea_db */
>  		const u8 *data = (const u8 *)db;
> +		int len = cea_db_payload_len(db);
>  
>  		if (cea_db_is_hdmi_vsdb(db))
> -			drm_parse_hdmi_vsdb_video(connector, data);
> +			drm_parse_hdmi_vsdb_video(connector, data, len);
>  		else if (cea_db_is_hdmi_forum_vsdb(db) ||
>  			 cea_db_is_hdmi_forum_scdb(db))
> -			drm_parse_hdmi_forum_scds(connector, data);
> +			drm_parse_hdmi_forum_scds(connector, data, len);
>  		else if (cea_db_is_microsoft_vsdb(db))
>  			drm_parse_microsoft_vsdb(connector, data);
>  		else if (cea_db_is_y420cmdb(db))
> @@ -6425,7 +6416,7 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
>  		else if (cea_db_is_vcdb(db))
>  			drm_parse_vcdb(connector, data);
>  		else if (cea_db_is_hdmi_hdr_metadata_block(db))
> -			drm_parse_hdr_metadata_block(connector, data);
> +			drm_parse_hdr_metadata_block(connector, data, len);
>  		else if (cea_db_tag(db) == CTA_DB_VIDEO)
>  			parse_cta_vdb(connector, db);
>  		else if (cea_db_tag(db) == CTA_DB_AUDIO)
>
> base-commit: 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f

-- 
Jani Nikula, Intel


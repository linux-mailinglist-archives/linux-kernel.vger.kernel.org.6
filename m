Return-Path: <linux-kernel+bounces-385076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A59B3214
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8521F22A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F01DD0CE;
	Mon, 28 Oct 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R28GZEZ5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE61DC1A7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123117; cv=none; b=jLw7xoQ+4i0XaV4lrBVfQnusud5uNVNxaHruE0aDBLLFoxTc9DydKfhvDm1S23nGf4lUeY6oHCEjdpjpJMXoIVcr7ROf/znTNPGlPZfglyRoJomAxJETCyRY9lZTqWLeaDNcYuD89N8VOmYCccv2rWoIs3SHRhps6O9+MymTbC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123117; c=relaxed/simple;
	bh=NZMeTc4NBcdWPmOpSj5v7mg8vX2JelBmKRfkSt7Ffwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rg9XKjzc7bnymsQKejg51Em7a/r0XzdLHDwv1h7GOqj30Nxm070ntuEzQp2W46pD0qVgqsExOIBA0Q1n61FiU6zImAReQXlAnLEsJkyB3PD+Uq9tX1rIDFjynxosZQyJNph5deIuyEKzpKGQalgep1ZKwqEQYt9qzEOa/fS4SeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R28GZEZ5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730123115; x=1761659115;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NZMeTc4NBcdWPmOpSj5v7mg8vX2JelBmKRfkSt7Ffwk=;
  b=R28GZEZ5vjyKpQU7mYw5WafrU5B4Ym1RaqkNCmBHL+RdjTD1Tgrw3PDk
   JlVMwrMIvfXf2ltyzJRRTZm4yyLtFOfmQOY4iS2M316Ek4L3AHilC8Oav
   qDj+UZPRcOGq2+VmObfJBQYKYr0G1RMuQ7AG2Q7TVLE4J2GwiYfj9SfFz
   TmtMWIZoaijrlIZxU8BMELMpMMzxhfV8rcfBUW13uPIVUbxDk89KSZvOb
   lxIEc+LtnUrpWPLgWQisV/+l7ryutt73rMLOtXpEojqM5dn9aLPnTouXT
   ZeT6N2v4Ttd1M8+wxHjdjy44Q83xIwSnxpVXAuRgDIzQn3Vlp65E/jHyU
   w==;
X-CSE-ConnectionGUID: RfJJXYu2QHu3h52t79HQsg==
X-CSE-MsgGUID: 7vz2vbn7ReuOUUNPHpuYhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29678040"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29678040"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 06:45:15 -0700
X-CSE-ConnectionGUID: LkyKNHPzQHaKjy0wmC2SzQ==
X-CSE-MsgGUID: POAbQg99SvC9s0O7gnBgMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81945457"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.21])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 06:45:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, "Syrjala, Ville"
 <ville.syrjala@intel.com>
Cc: skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/edid: convert drm_parse_hdmi_vsdb_video to use
 struct cea_db *
In-Reply-To: <20241027075108.14273-2-vamsikrishna.brahmajosyula@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241027075108.14273-1-vamsikrishna.brahmajosyula@gmail.com>
 <20241027075108.14273-2-vamsikrishna.brahmajosyula@gmail.com>
Date: Mon, 28 Oct 2024 15:45:07 +0200
Message-ID: <87cyjkpcik.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 27 Oct 2024, Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com> wrote:
> @@ -6320,19 +6321,20 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
>  
>  /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
>  static void
> -drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
> +drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const struct cea_db *db)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	u8 len = cea_db_payload_len(db);
> +	const u8 *data = cea_db_data(db);
>  
>  	info->is_hdmi = true;
>  
> -	info->source_physical_address = (db[4] << 8) | db[5];
> +	info->source_physical_address = (data[3] << 8) | data[4];
>  
>  	if (len >= 6)
> -		info->dvi_dual = db[6] & 1;
> +		info->dvi_dual = data[5] & 1;

Just commenting on one hunk, because it's a good example of the whole
series I think.

The above is nice, because it improves the offset vs. length
comparisons. Many of the old checks like above look like off-by-ones,
when indexing from the beginning of the data block, not from the
beginning of payload, and cea_db_payload_len() excludes the first byte.

The main problem is that the specs are written with indexing from the
beginning of the data block. For example, HDMI 1.4 table 8-16 defining
the HDMI VSDB says source physical address is at byte offsets 4 and 5,
and dvi dual flag at byte offset 6. That will no longer be the case in
code. It gets tricky to review when you have to keep adjusting the
offsets in your head. (I don't remember if there are specs that specify
the offsets starting from the "actual" payload after all the meta stuff
has been removed.)

Now, if we accept having to do that mental acrobatics, why stop there?
You also have extended tags (first payload byte is the tag), as well as
vendor tags (first three payload bytes are the OUI). It begs the
question whether there should be higher level data and length helpers
that identify and remove the tags (including extended tags and OUI
stuff). For example, the actual data for HDMI VSDB starts at payload
offset 3, as the first three bytes are the HDMI OUI.

What to do? Ville, thoughts?


BR,
Jani.


-- 
Jani Nikula, Intel


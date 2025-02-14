Return-Path: <linux-kernel+bounces-514578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FA0A358C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486973A623E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A52222D1;
	Fri, 14 Feb 2025 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJ0mO69U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BC215F50
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521369; cv=none; b=qLanrKYwhUPJ9s9qwgJQ4YEDC5jicbjtMRF2mYUcJJvWi6+uSRXOhjsHpvuT5XdrT4nFxV17yTahviSK0TKBUpZvxDbX9T081r+PeT6JmGO0IHA/d0x7tNpeOWnOxLO0GXMo4THf/JIJEsEZ7oRAFVvGL8wm2Mzd5FmI4Q3myDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521369; c=relaxed/simple;
	bh=KCbafTIYvQEVerjHlCgAqPsDkqNPAmHAhQ0DFmXWdLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kn4soKXSjouoUM4SbbV366MQs7I/2ENE/X8G00Biu3qU3rp01qTPY6wpYfotyxY43sOIos8/dPkkgTN/3GOLYtAeOSqsFRJ7gIqTl3rhHF/aGfAJllYyIVTGhq+2fjnZgU+fRWonFmchQw5SaESvaficfPculpmj+unoF8LhmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJ0mO69U; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739521367; x=1771057367;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KCbafTIYvQEVerjHlCgAqPsDkqNPAmHAhQ0DFmXWdLg=;
  b=YJ0mO69U2cUGv42k1HhT4VSmdUuFTnawnD7Svcv7mhjO6SwUb7KBwbPo
   Y/tUHskC32IGc4NYRQAtxRa7bXhIlvOH85Dkg3gR8+7SrgeDijWwPztE6
   PK7vxYz7jQj4UeZ90nvsc/7u4gm6W1cmK+WX8hNY3Gr9WiBZ3d+eoH7or
   bTrYnjQs1YUv+pO7UgemO2XTudpZu/TcI914BWunqsDGa7zmUcV8WpLkH
   Laf4IIvZFnjUMNIPu7VAdAgzbOFcjTwKiALk/g0zX92d5XjwdAgu8gsKI
   BKZ/GjGD4vzI96IrfZBR/jRvffgNZCmXd4BpsUtO7QNXOGwY7pQIWvOr+
   w==;
X-CSE-ConnectionGUID: 7skrpgmIS8OXbk76d27kzQ==
X-CSE-MsgGUID: kcI1GgqGT6CfkDhHyM2Kcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50474320"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="50474320"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 00:22:47 -0800
X-CSE-ConnectionGUID: QL9vGmoSSWeAk73o68yDmw==
X-CSE-MsgGUID: 25+1wuZYR4q3DBZU+Uf4GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="114039564"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 00:22:44 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Egor Vorontsov <sdoregor@sdore.me>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Egor Vorontsov
 <sdoregor@sdore.me>
Subject: Re: [PATCH v2] drm/edid: Implement DisplayID Type IX & X timing
 blocks parsing
In-Reply-To: <f0e0d4e7f5d552cb82cf3c9243f15772268fa311.camel@sdore.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <7cab8349bc8bb6fa08d2a7127a724efea155f154.camel@sdore.me>
 <87zfirzerp.fsf@intel.com>
 <f0e0d4e7f5d552cb82cf3c9243f15772268fa311.camel@sdore.me>
Date: Fri, 14 Feb 2025 10:22:40 +0200
Message-ID: <87h64xvstr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 13 Feb 2025, Egor Vorontsov <sdoregor@sdore.me> wrote:
> On Wed, 2025-02-12 at 11:35 +0200, Jani Nikula wrote:
>> > +	/* TODO: support video-optimized refresh rate */
>> > +	if (timings->flags & (1 << 4))
>> > +		return NULL;
>> 
>> Mmh. I'm not sure I'd go this far. The bit indicates *two* timings, one
>> for which the below *is* correct, and another additional one with
>> vrefresh * (1000/1001).
>> 
>> We could just add a drm_dbg_kms(dev, "<message>") here about missing
>> fractional refresh rate, and proceed with the one non-fractional rate?
>> Or just have the TODO comment with no checks.
> I'll go with the former, for now.
>
>> Either way,
>> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Thank you. ... But!
>
>> Are you up for the follow-ups too? And since you've got the hang of it,
>> maybe fix struct displayid_formula_timings_9 hactive/vactive to __be16
>> as well?
> ... at this moment I realised that both the specs and the legacy code
> actually indicate it's indeed *little*-endian shorts!
> I.e. `x[0] | x[1] << 8' -- that's LSB-first.
>
> Also, virtually no code in `drm_edid.c' uses big-endian.

Yes, I *obviously* meant __be16 and be16_to_cpu(). ;D

Good catch, and sorry about that, quite the *facepalm* for me.

> Thus, I'm fixing both my code and `displayid_detailed_timings_1' (I
> suppose you meant this struct instead) to use __le16.

Indeed.


Thanks,
Jani.


-- 
Jani Nikula, Intel


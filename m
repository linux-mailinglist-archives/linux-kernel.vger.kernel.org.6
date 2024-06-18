Return-Path: <linux-kernel+bounces-218956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472A790C827
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E661F260E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80630158206;
	Tue, 18 Jun 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdTAddo5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C51581EE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703521; cv=none; b=FOkkCebyb6+5G2rPK5Yji6yRP3IVYOvrAh4I/l/5znfZLerheaXx4/X6nq4EdynlQs0/Buir8AzwKsmf5ihS34nrsQn99JIfNkgs5dNe2wk9nXf38GBt+qW0xlR/CKIO7lZW2mlDUUt5A630JZIx1ISI8GfgUEDajS+9IBpRStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703521; c=relaxed/simple;
	bh=QenCB3euq69QSB//DNTS+Hjnrm1i70bry2vnqFA0Xns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gKmLzIkewFlUMlMzwhYzuY86pJCPpuqUvzLjACZxvyl9nFzzzmWgQPa13sE/48W+vWqzQEWtMOJRD1Y9i2Z+QWOLTYnH5fe/CgTr2w2acerP7ktWV0a5Z+dm/b8cPQ384mjd/Z37ICCOT7fY0fPqHR7O4PrWkqw+wc1g6C4kRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdTAddo5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718703520; x=1750239520;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=QenCB3euq69QSB//DNTS+Hjnrm1i70bry2vnqFA0Xns=;
  b=jdTAddo5r9wk4ihplKkCPVsKLpjzLIF8enlC3fXWtbd78LSWIW/lWruP
   l940wLds9UHU+8syqnDE6S0GPk85xLexobd68NPVeTgFj71XlbjBZHCTh
   NitWfzj7AlCNwU/ez/R0FhIlEKgs88k6O7Jqadmt9M5JBi4DGeZBFtZgp
   U3Rr9zfwmW6uwwYBLHMJHL//Eztdh3epIqE7Yg+Kdj+lKfGRZSXTHeXe2
   QeNynxLVLy9BpB1nfCLef9psRBjUyB+vq5Yzo9Dtn/gyRTQuqeBVGsza4
   CSht8xoZfjPaoy97/j0ChmDlid8OBv2WrZekPfk7Zxv+MefFey/5t8RbX
   Q==;
X-CSE-ConnectionGUID: iIExgs1MSzum3CqSOUL10A==
X-CSE-MsgGUID: Eg3vIbdwRmebQksOhgvJFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="40973746"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="40973746"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 02:38:39 -0700
X-CSE-ConnectionGUID: 8q3IjEVeRvOFZ8qUIH04zg==
X-CSE-MsgGUID: w6BdYPq0TguAHoQ8bDknCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="64724227"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 02:38:29 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
 dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>
Cc: kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com, Simon Ser
 <contact@emersion.fr>, Pekka Paalanen <ppaalanen@gmail.com>,
 daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, 'Marek
 =?utf-8?B?T2zFocOhayc=?=
 <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>,
 ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>, Joshua
 Ashton <joshua@froggi.es>, Michel =?utf-8?Q?D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, Sam
 Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Karol
 Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, =?utf-8?Q?And?=
 =?utf-8?Q?r=C3=A9?= Almeida
 <andrealmeid@igalia.com>
Subject: Re: [PATCH v7 2/9] drm: Support per-plane async flip configuration
In-Reply-To: <20240618030024.500532-3-andrealmeid@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240618030024.500532-1-andrealmeid@igalia.com>
 <20240618030024.500532-3-andrealmeid@igalia.com>
Date: Tue, 18 Jun 2024 12:38:26 +0300
Message-ID: <878qz2h9pp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jun 2024, Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> Drivers have different capabilities on what plane types they can or
> cannot perform async flips. Create a plane::async_flip field so each
> driver can choose which planes they allow doing async flips.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  include/drm/drm_plane.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 9507542121fa..0bebc72af5c3 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -786,6 +786,11 @@ struct drm_plane {
>  	 * @kmsg_panic: Used to register a panic notifier for this plane
>  	 */
>  	struct kmsg_dumper kmsg_panic;
> +
> +	/**
> +	 * @async_flip: indicates if a plane can do async flips
> +	 */

When is it okay to set or change the value of this member?

If you don't document it, people will find creative uses for this.

BR,
Jani.


> +	bool async_flip;
>  };
>=20=20
>  #define obj_to_plane(x) container_of(x, struct drm_plane, base)

--=20
Jani Nikula, Intel


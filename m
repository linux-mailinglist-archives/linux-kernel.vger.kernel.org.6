Return-Path: <linux-kernel+bounces-175670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E18C237A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEF71F25B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D52171651;
	Fri, 10 May 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFxZj0gs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1217B4E7;
	Fri, 10 May 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340472; cv=none; b=A40xmWMdt8JNVktvU49sGgB9qDEHw0xf/vwe8bL14sABSoaDUWMeCtnnASo2tz235JFWeJnEVTtLGPHDFn3EoMNc2pvQsqnOOssA9MrXPtazHG6oTbb+R0+y7a65QCrhxS121EA0/4dBFsi/6WCTJV0RXFJs+OZezaMSJye7DZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340472; c=relaxed/simple;
	bh=aANSSUvUc/Jg9oLoo6P63WSiKIet7EGu6f4hUvfSXkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HDd8/+IneUM4rL2UsuiHyDPCSj+3+AZZ9vyGG5/risFotMbJNEuxPJytJ3NQ3OvcT1IpwkBrxwms9ZoS6ACLvAGkTkgUwRfz/Wm9ODaaqXJW1bAVeSLheJEr3CkdUEiXv5VL3FPucaWx1cMK59+6intjjwAHxcuABKBGvLn4v8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFxZj0gs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340471; x=1746876471;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=aANSSUvUc/Jg9oLoo6P63WSiKIet7EGu6f4hUvfSXkc=;
  b=lFxZj0gsf6Y47TFCYEtL3suuFDOys1ZWWm5mWJ29+SlR8HIo5SYRQU09
   YxAkJPAXPgitXZRkuMLl/4+6hCavD6gIE8tkycBbOih63N/UeFtsMKM2D
   KdkDLrenEKlB50nmbq36jm/nCI2hG6YaE3g9oENYDGuj+8NbId3XEYw+0
   bjTb6EAfU0mweFdvk574dBmIRQelqd0f+v06vrYEIYq3pnEH9efkZSdRj
   kFP2uy6MSZ4BkatGNT0+cnlb6fhwUfAfpySoFodp5+pS6Zyg1b9KqFNxQ
   83h3Pp3W0BwbxDTT2SnuzzkSXQwhsMSyIkJ0p2TPLlmjQrZCd6HNRfWvb
   g==;
X-CSE-ConnectionGUID: 8TCUo9LcS6Ok58H38oiw4w==
X-CSE-MsgGUID: CuwhhOSASpi8RLEc5W108Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21988053"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21988053"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:27:50 -0700
X-CSE-ConnectionGUID: ocveNKGZTIqcD+m/mfZGtg==
X-CSE-MsgGUID: NlwU2s0wTVeIuf/ciOKKlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29543350"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:27:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 jitao.shi@mediatek.com, mac.shen@mediatek.com, liankun.yang@mediatek.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 0/2] Add PHY-dp bindings
In-Reply-To: <20240510110523.12524-1-liankun.yang@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
Date: Fri, 10 May 2024 14:27:38 +0300
Message-ID: <87frupj49h.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 10 May 2024, Liankun Yang <liankun.yang@mediatek.com> wrote:
> Update write DP phyd register and add phy-dp bindings.
>
> Liankun Yang (2):
>   Add write DP phyd register from parse dts
>   Add dp PHY dt-bindings

Please use the proper subject prefix for the driver. git log suggests
"phy: phy-mtk-dp:".

Thanks,
Jani.


>
>  .../display/mediatek/mediatek.phy-dp.yaml     | 45 +++++++++++++++++++
>  drivers/phy/mediatek/phy-mtk-dp.c             | 37 +++++++++++++++
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek.phy-dp.yaml

-- 
Jani Nikula, Intel


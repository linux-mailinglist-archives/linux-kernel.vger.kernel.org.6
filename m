Return-Path: <linux-kernel+bounces-528456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD98A417D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26C516DE92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462CF23CEF8;
	Mon, 24 Feb 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhZ1OCH6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482B1A072C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387191; cv=none; b=DCdzHuAyfX9bumw4/8hhLKMYpVpAAPgIBchw8k3DoaYIy9cqQlpZgQuLimziBLJSsOV0Wn8/u+uKw15CTjPdf/PJX9xu/+H3HsFkN/74t/6KNcXDCkIrQDlV/t1bIBbMh1nNSZpZaFwE9pHkc78qf3Qp4mBl21TwWpXdTtKzDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387191; c=relaxed/simple;
	bh=neshqSurALujxJaE68ap1rRMFm3NUp1g3KLiJlE7CYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FBen0uReJgHTn8lhrgcg9NAtabcmZSZaijhCyM+1cCP/OZ9knZzS+WckeivP1D9bmso65prkj/TMYmpqg6naVZjlX5FTrLIwR4YRH5OMrpEZpT50Nk3FvqCNgXVnX6vEHO8csxEyHUv9HYUlS7HutkADaAfiOOToUSK2IA+Y3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhZ1OCH6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740387189; x=1771923189;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=neshqSurALujxJaE68ap1rRMFm3NUp1g3KLiJlE7CYo=;
  b=nhZ1OCH60bqgA3XPWuhof2wEUqXZQ/5bsWw7ps20VPTSHXCB4NSnWDDM
   QnK5WQSt/+CjAeHQDfR+I7jVgiwEhNptkic/Nicit43rMDpA8hk3OIwfW
   9nrtxJ78bbnC8eobJwMipshgwaG+XvC2Ghi8iUWDexCdC4ihCfGBNM8wk
   snidG686f6maHZw/o+KKLH9I8Za2qCVhdn+GOW6AQL7wkRQo3b0K3r5iX
   CmHQaiR/wnOB5miNOqP+VuIlZY25b+4pDo3nBL/UtqVIvoVNyTBIH2Ukq
   WD07YAql/I6XX2wv5hhdGH2mKMeKHzbBndbS2I9GRk4BeU+FJ1vGIgU2B
   w==;
X-CSE-ConnectionGUID: RjxjvsvLTTaVhL1ZrGZrCQ==
X-CSE-MsgGUID: +zIKC6WZSC2QMdH0+bN17w==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40370377"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40370377"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 00:53:08 -0800
X-CSE-ConnectionGUID: PNhOh7vxSOGLVEau75g2nQ==
X-CSE-MsgGUID: WM7FaagXSw+Fumvlggpw7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153200232"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 00:53:06 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Baranger <nicolas.baranger@3xo.fr>, Thomas Zimmermann
 <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, airlied@redhat.com, Jocelyn Falempe
 <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: Include ASPEED ast-drm 1.15.1 video driver in kernel tree
In-Reply-To: <984c317de1027f5886390a65f1f66126@3xo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <d507f6268ea3158b5af82b6860ca7b71@3xo.fr>
 <194c4656963debcf074d87e89ab1a829@3xo.fr>
 <b296bfef-1a9c-4452-baeb-09f86758addd@suse.de>
 <984c317de1027f5886390a65f1f66126@3xo.fr>
Date: Mon, 24 Feb 2025 10:53:02 +0200
Message-ID: <87o6yr911t.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 13 Feb 2025, Nicolas Baranger <nicolas.baranger@3xo.fr> wrote:
> Yes, due to .date total removal in linux 6.14 
> (https://github.com/torvalds/linux/commit/cb2e1c2136f71618142557ceca3a8802e87a44cd) 
> the last DKMS sources are :
> https://xba.soartist.net/ast-drm_nba_20250211/nba-dkms/nba_last_src_20250212/src/

I'm not sure what you're trying to say here. The driver date was removed
because it was virtually never updated for any driver. It provided no
useful information.

BR,
Jani.


-- 
Jani Nikula, Intel


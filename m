Return-Path: <linux-kernel+bounces-177271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D78C3C33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963771C21094
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA03146A91;
	Mon, 13 May 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJucoOQH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FFE52F9B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586227; cv=none; b=i8oP10BtfdfcS+xH4fO5zWmKIRAOpUJzN8c4hXBAGvD9HhYLhbgd1wKrl20TFuKhfMr48JB2Po9C/wGPSzQ0twkU2MKxfWqJRjTkKZ52J+CozVJcPMlsucu8ua4P0ku+WuLx57WFfslX84FBx4hbEBLtdXTDRA+Vp4oRo/Yu24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586227; c=relaxed/simple;
	bh=sta3WVSfyvxwITpMwLodobPQ4heyFgBUQw+Kf2WG49U=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eheGgul0plrQZdsVuJ6DoV4nzsUGHIpTzZH9M3QzVF4jupgz3VrXIb6taFRETjz20SbVctBVafDpfUzduYIWCJs6pd0zZ1SnofvAlw1DCAVKqoGi9/8e2NcpWleEHBc60fdWFiLkVKsfFjmPDO3oaInjDWJLuAgCKjRB4EBMM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJucoOQH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715586226; x=1747122226;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=sta3WVSfyvxwITpMwLodobPQ4heyFgBUQw+Kf2WG49U=;
  b=CJucoOQHCcbkfauxtA3sCyeNGtiMNzb79+Wh5jSkxDHBlqGV9gYTyM0G
   MRTRjZMPqTaG4M74S39drr9JWwF8XrPnKKZFctgKXlYCCeMJQJCXkDVOn
   VDfNZU9uaqHeJjVuY1tmWM1Yi/9frYGG+nUtK4fBYo8pgo8OqoT89w9CB
   rhECfNqpo0pS9EolXnsbHT6JBdaiH63O3cGBZ5HyXHuR7Wh7noDqfcE1z
   bqDvx5xAACezvLZ0va3vBEpvSasnt+/dRTY2/rrNn2MCWjfGWVPRpiY9U
   C6lpmoIV6braRFqBPLoAl0FeLgwg/D9hQMf8hWUhxjE8+FZe/3H77hoZr
   g==;
X-CSE-ConnectionGUID: wXCfwIRvQaKX/TRs+Z8Z2Q==
X-CSE-MsgGUID: n+p2dsTKSouSOd++GyqLlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="15317726"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="15317726"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 00:43:44 -0700
X-CSE-ConnectionGUID: u3IWYQZMTOCnlSzmR1InrQ==
X-CSE-MsgGUID: ESu2lkKKSNOX3tPMhwecZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30210501"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.7])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 00:43:42 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Chris Clayton <chris2553@googlemail.com>, LKML
 <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: /sys/kernel/debug/vgaswitcheroo directory missing
In-Reply-To: <b25a0ca3-e1bd-4457-8283-6878493b864f@googlemail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <199a1636-2cd1-4d66-b2b2-1b64c5af4f2d@googlemail.com>
 <ZjugHVX1WIgjbAH1@phenom.ffwll.local>
 <b77cb343-1ea8-4cfd-ac77-b7e8d1c5e078@googlemail.com>
 <b25a0ca3-e1bd-4457-8283-6878493b864f@googlemail.com>
Date: Mon, 13 May 2024 10:43:39 +0300
Message-ID: <87cypqgnro.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 11 May 2024, Chris Clayton <chris2553@googlemail.com> wrote:
> Mmm, I see a patch has made it's way to mainline and can confirm that
> it fixes the problems I tbothered you with in this thread.

Which patch? Might be interesting for posterity.

BR,
Jani.


-- 
Jani Nikula, Intel


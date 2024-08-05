Return-Path: <linux-kernel+bounces-274279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6880C947600
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1266C1F21A5D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B91494A2;
	Mon,  5 Aug 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiFZz41e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF501494DA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842737; cv=none; b=RLFoagjByX6jCRUcTtB4YXFkyUJ9Y7eUHJ9k6S9D6dG0PoUOU0Kfh4uMo/5grTPoUxODLtJ3SLZ4YYgO4qKi7Zpziiwn8Ffi+B/QcPI37/mllJ3JE2cMzyMQCCKSmVWIvIX92JLtm3big4/u0yG+4e453c290pnSlD/f9moPVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842737; c=relaxed/simple;
	bh=uBP+UQqllg5obArR77p1h7U2jo1hLyfB0P1taYbsllc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PRpFF3qiTpaxzkUtjm07/I6sHBnemlp28p96P5C6Is4ORmIudOcsrhzh348vHFKWllLuKSAEIbHjfHHoaKf3WjhmnCsljaHpmoGnJH00rs3vSMjAsuSqPIZILD5GJC93LG8NbwIZgK92ulrio3HWwzCY6lUjAG1Z1W2QabwIhjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiFZz41e; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722842736; x=1754378736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uBP+UQqllg5obArR77p1h7U2jo1hLyfB0P1taYbsllc=;
  b=KiFZz41ern5oJ+ceufvw0Gq7eZ5tz0du1FXN+iF0n/Ze45eOp5lxqJ8k
   rW/8Au6K7H8+W/l/KIt4dx/Q2IgxxCh+0qbTg1D6rQF6wBdBDONQs6vUI
   XHqUIdj8unIn23dZREyl3Rb8K8xuXXVH+iNLRSMOIhpihcbuRWVJIBHb9
   YIhsS+vS4wz0AZP1FPklyI3TemXmI6w87Pz1r3we6XbOlNObpsMn7DPwq
   IIPOdScJFzRYNMHrdfMuTbbjxYMniU7FAop5zpwV9AFjci0xY7fHYbDmX
   TVO90yxGzNmvDTjEcbmnVt7FzRN3VUR7l31GDLs8y2rGEeNhnbs+C6f6B
   w==;
X-CSE-ConnectionGUID: EZ3rGQvLQMyVbUG2W5Mv0g==
X-CSE-MsgGUID: oEkrQFy+QOmDdBIpt4OSCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="32191676"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="32191676"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 00:25:36 -0700
X-CSE-ConnectionGUID: fbvnVJLQQR2Nde23SX8ekg==
X-CSE-MsgGUID: gdhujbIERE+BPQMuRrj0Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="56006582"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 00:25:33 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	tony.luck@intel.com,
	qiuxu.zhuo@intel.com,
	yudong.wang@intel.com
Subject: Re: [PATCH v2 1/1] drm/fb-helper: Don't schedule_work() to flush frame buffer during panic()
Date: Mon,  5 Aug 2024 15:13:55 +0800
Message-Id: <20240805071355.42636-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240703141737.75378-1-qiuxu.zhuo@intel.com>
References: <20240703141737.75378-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
> 	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
> Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
> 	tony.luck@intel.com, qiuxu.zhuo@intel.com, yudong.wang@intel.com
> Subject: [PATCH v2 1/1] drm/fb-helper: Don't schedule_work() to flush frame buffer during panic()
> [...]
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Yudong Wang <yudong.wang@intel.com>
> Tested-by: Yudong Wang <yudong.wang@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Hi Maarten and maintainers, 

A gentle ping :-).

Could you please help push this v2 fix upstream?
If you have any concerns, please let me know.

Thanks!
-Qiuxu


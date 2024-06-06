Return-Path: <linux-kernel+bounces-204961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C748FF584
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08E72890F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D736FE21;
	Thu,  6 Jun 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C75ANUD6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D934C618
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703785; cv=none; b=m12T2dqEOTgSi4aKobtigPwy4yWIWRnBs7bcIuuCRfBLAmcYw+ecfpMmHNwDaCit2hkrDlaKPKPr9tbcWd0peWAjFYaai1znj9LubK1NAG/ZdEiX42uNq9+MlWaX74BBYoS/YOkE3y5T6SWv4g7HaTkxL2LOVlaC1nj0lw1/O/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703785; c=relaxed/simple;
	bh=f2w1loseXdiTImA/ZCEopk9Jyuox9r4UfAp6Q3PqsFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoRLIAUEyIzroXM3mZWf4lzlZCbCXjuOAqsnGqGo1gDQjL9ORunzWgJr969840tuNU5Dl+RsL39HjY/3WncEEFf6GVBiJFPSAf+ML8WrkWi0OqCoGPCAUn3hnUQaEQX3u8cqE7HAnbjBOADCsm4ddhl/XMx9nO8idMDkb3vebcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C75ANUD6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717703784; x=1749239784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f2w1loseXdiTImA/ZCEopk9Jyuox9r4UfAp6Q3PqsFg=;
  b=C75ANUD6JiVCAs0ZQz6eKNF+aXBeib5E/7o+EVQ5XW41AU8eGaMs06uk
   j0sb60kGkZ9TqxN+Aefda1+d258LnQyq6FXswB7qaQcGjfZ9I/8SCUWH3
   7ULgq15INz78syj6PZ+KJ564St9JaUQYwuMUCT9VYziqHs4OVRrRjWuPZ
   tspZ3lh0h+Mf9A4FcjS0uEKPkGoi1dHDhe4OqEDHX2Wx+UarjVF0NB/KI
   683ftpZCCZEOe/egVko7d5wwz3k436KvVnUXoy56b/xXc+aaBe3gVA3lf
   TS/yAoxIspFMr4vDQHlMnbOn4P9PEJfynEpbudK56Zn1Qnxg2maaXtYDz
   A==;
X-CSE-ConnectionGUID: PolQpoQNSTG4mBL9zifHmw==
X-CSE-MsgGUID: D7WdXADqQdyHU1fOiKoGnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14284388"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14284388"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 12:56:23 -0700
X-CSE-ConnectionGUID: jBPCrAyBR0KvMrVQ0aC2IQ==
X-CSE-MsgGUID: gGNvP3QdS36kVqXiWATEBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37997796"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 12:56:23 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-xe@lists.freedesktop.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Update Xe driver maintainers
Date: Thu,  6 Jun 2024 12:56:26 -0700
Message-ID: <171770371979.1979476.15412903037643543401.b4-ty@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602190959.2981-1-thomas.hellstrom@linux.intel.com>
References: <20240602190959.2981-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 02 Jun 2024 21:09:59 +0200, Thomas Hellström wrote:
> Add Rodrigo Vivi as an Xe driver maintainer.
> 
> v2:
> - Cc also Lucas De Marchi (Rodrigo vivi)
> - Remove a blank line in commit the commit message (Lucas De Marchi)
> 
> 
> [...]

Applied to drm-xe-fixes, thanks!

[1/1] MAINTAINERS: Update Xe driver maintainers
      commit: a9f9b30e1748252d158f78a0c0affdc949671dd1

Best regards,
-- 
Lucas De Marchi <lucas.demarchi@intel.com>


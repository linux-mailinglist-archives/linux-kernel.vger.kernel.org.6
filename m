Return-Path: <linux-kernel+bounces-349632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F898F94C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD50282963
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98671C2DC2;
	Thu,  3 Oct 2024 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRdR7FKx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB66A33F;
	Thu,  3 Oct 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992558; cv=none; b=cX3BolV5PLHeV8uIcaFFznY9/WoTWCGnPFi3ZDRYXgzb6h6GVfL6VzQ0j9//kQZGCfeTZxcIASX84mjb7OSiUtDkgEyUKufgcYF2tJq/vniPA+j5TXeyHs8Cq64sRTweTyLEQal8i6WnyngswgFa+Dqxc4ZJzajp4K7zcaqAXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992558; c=relaxed/simple;
	bh=TFGsQDJKVVrsj0YlCzYhgMD3rH2pYye2cn3azF1C3hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpgBbkwdzDn6d1J1Gs5123ao4l8jET8oAlpOXWFyq+/cER+ergPRpr0juUlsN4q6XzV6EKYL1hIqgeoQvXPCnZpwwWTLQGAfc8RSHTUz71GA/eJCkZ/xFJWvwtMEFMUvg/qZOrNqH43mUbCZ3OPLJQ5+TYCl49wubvo+wuT+yiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRdR7FKx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727992557; x=1759528557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TFGsQDJKVVrsj0YlCzYhgMD3rH2pYye2cn3azF1C3hc=;
  b=IRdR7FKxiPxVdLGcCBIgBzqfzLscMI4GX0ko6o4NPxj4gMlZuXTa54DT
   PiXSfS7TB93rRzlMUxpky9gBz/XqdtzBCwGcWt/s1G4z3UV1CWzuPcsQi
   R+ZxXRKio48Mfc9jJGIwwWgd+gBWdcO8XzE0DMbTNQl9VeOLbyBrkeqQq
   F+L+JstT0gkyL9KSackgVn3oUhzJjGjp25hTwOv9WEfoLDbbhk6EX4fix
   YGYp7IuRH9tkfyygRiaETqHyFu1330kelosSamV1Szw9A5Ufh2LCr4V/z
   u+/QhY94MW7DDYWZbccxl6tfi5hndtInrd5ho87QBFJGtUv/DyutYDQyl
   A==;
X-CSE-ConnectionGUID: OaixtHvtQqeeu36CAcHlQw==
X-CSE-MsgGUID: GZOoviL9SbmZskVtVEbfMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="31094000"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="31094000"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 14:55:56 -0700
X-CSE-ConnectionGUID: 4pzfn94xSoiucW4XV/dIwg==
X-CSE-MsgGUID: 3615OgBiROatImumWq481g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74613932"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa008.fm.intel.com with ESMTP; 03 Oct 2024 14:55:55 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] Diamond Rapids support
Date: Thu,  3 Oct 2024 14:55:52 -0700
Message-ID: <20241003215554.3013807-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPU model of Diamond Rapids for SST and TPMI power domain
mapping.

Srinivas Pandruvada (2):
  platform/x86: ISST: Add Diamond Rapids to support list
  platform/x86/intel: power-domains: Add Diamond Rapids support

 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 drivers/platform/x86/intel/tpmi_power_domains.c             | 1 +
 2 files changed, 2 insertions(+)

-- 
2.46.1



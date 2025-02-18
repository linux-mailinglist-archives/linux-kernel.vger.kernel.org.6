Return-Path: <linux-kernel+bounces-519075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF5A39797
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97271894055
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060E234973;
	Tue, 18 Feb 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWLe7lcc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB122E401;
	Tue, 18 Feb 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872097; cv=none; b=VRRqWd9wVy64uR2fGUbjDtyZAuJqYU1x76AMlACWiNWU6tvdd+FIQ89b6DAEzkvs6fsD8Ps2Qdi7idNEob7m3PTrmbX6xUw7IGzeC5+dA9UaIHlvBdtAkNAjXNw1sgzm251iQ/2drFwexidU+qAHenqAxEmp/+UaULckYqbEDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872097; c=relaxed/simple;
	bh=vO7ZECKd12yaABzBTIDMR3LdDUHrdTImm6Lk7iYIRJo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=muRws3INq6tN3GwXPY9EdkyME2PDACJDK9Qw1YkMctA2FV+rHwL0V28YxwAVQP93DjR2oTBkZiRi0bK7prG9aVKCjQIFC4seqy0iXpIdgdNX00KgkCzbRDMv6nv7GYMc7NcK5f1KwJCiWObF8jvDvVZWwN/fPGJN8vM0Z63W/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWLe7lcc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739872093; x=1771408093;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vO7ZECKd12yaABzBTIDMR3LdDUHrdTImm6Lk7iYIRJo=;
  b=fWLe7lccng9xP0hNgBKK6aDsGHCP7Gi2pp+/4xl3QbxxbOeRzjAGAEE4
   UOG92e3B8V43gUikDYlsyT6I9MSEjMK6oKH8HwRnu3j/I/jb4csejQtvo
   DFH8ttZEoYKJ6SvDnXM6L09fRaDzev7p63Uup/p6TLxRpglkHpXFvguKc
   kR+tLA1QJyzww8QmRgdolfj03O67c2d8kCzoi4ll1IT1mVPFH6WTG/skw
   CxA56slLgHnevlRvA1rnd5uMxCTbH4739RQYYHOkxPz/53PAouBRNrFQU
   7Ik3kX6yPzh4hVvhd2n4YCWpttDwcQCelGmAeUhkTskZ+Vk5rzbCaC+c/
   g==;
X-CSE-ConnectionGUID: wUO6omtFTU+JcrVRAjiBpg==
X-CSE-MsgGUID: Vm0cazWuSkydKdUteoyo7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="57965148"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="57965148"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 01:48:12 -0800
X-CSE-ConnectionGUID: TfMZJL0MT66Zjbz5D/pyBg==
X-CSE-MsgGUID: yCHhyG/ISQS5TnMcgVVhYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114213730"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 18 Feb 2025 01:48:11 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add TB daughter board support
Date: Tue, 18 Feb 2025 17:44:32 +0800
Message-Id: <20250218094434.3574060-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Agilex5 SoCFPGA devkit supports a separate test daughter board(TB).
Document TB daughter board compatible string and add board file.

Niravkumar L Rabara (2):
  dt-bindings: intel: document Agilex5 TB daughter board
  arm64: dts: socfpga: agilex5: add TB daughter board support

 .../bindings/arm/intel,socfpga.yaml           |  1 +
 arch/arm64/boot/dts/intel/Makefile            |  1 +
 .../dts/intel/socfpga_agilex5_socdk_tb.dts    | 27 +++++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tb.dts

-- 
2.25.1



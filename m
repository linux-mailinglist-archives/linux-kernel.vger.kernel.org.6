Return-Path: <linux-kernel+bounces-406411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32759C5F90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97F9BC5AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48155214406;
	Tue, 12 Nov 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVjLXuoO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894E20EA35;
	Tue, 12 Nov 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431856; cv=none; b=X8rVIfUWTce4NLlEwz6y9hZYkhItgCyTJaQfGXKV1uGx9kRnyaECVy4X6DZ7sTQH38raPcFDOIvYVVypJVdom1gwRP0t1a+bJYrli0W8zhIT+N0+EZtdZm8Ro/43+UW0CV4wdzisd9D4bng0emmaz4F1O1Ryopj+hknpgEDI5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431856; c=relaxed/simple;
	bh=GZKG9Pbj0+4eT/ivxamB+9n9eEVLqN3qcppg/sgMfpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YmB2TTZgVSfk1O3+divYjeJ4VjfCEr2j4x0pyHhtMb1hqrdX4QtwAUo87MpL1LZKmLnvcgMXxLJTRYqwJ7hfLFh4rGIlZ3V/L9yBfRHCIuqDR8Yv3YkuwktfVz32eFjhhw17fTpwMM/m7oOwAWBypkcm/TLkj25w/TEXS2Y8tT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVjLXuoO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731431855; x=1762967855;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=GZKG9Pbj0+4eT/ivxamB+9n9eEVLqN3qcppg/sgMfpo=;
  b=eVjLXuoOiGK7ngQ8ozG71cxhGjfmw44TXtbPJPDucdihuvNqBDnj4YTT
   hMWhYodKi7qWHzd8pdTPQ2aM8yN5uRlqjgEK/OTbBS9aHkziWJUlK+r5S
   /OLr+ANNN0Pvyi/Zh4P0ENmgrTw4WHZwhG0D2O18h2nwV95phdboAtMEJ
   VvwYpXJ+pNubvhBLYYjgD2BFSgFum9/ooAeQrh+e9xZ2X4ZeQR4dkKcCc
   Ca1llyWwFEn4tCgLQBBebBKRIB2GctmVIBl633XxGQLzMMv4YlltpefQT
   UaX2b7fzxQJiMFgN/aL2VjfYxt77ZdRWxGw6UcmbRH9u1c0nNsxQSDpju
   Q==;
X-CSE-ConnectionGUID: OJ499uXQSkqtEreVp7Pdlw==
X-CSE-MsgGUID: 5wad2HqSQ0+Iqw/wTF6rWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="35071951"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="35071951"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:17:34 -0800
X-CSE-ConnectionGUID: auCj78WUToGliQmGEobpAQ==
X-CSE-MsgGUID: CfUO/TH9QReCsPLIdw935Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="125070090"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:17:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: corentin.chary@gmail.com, luke@ljones.dev, mohamed.ghanmi@supcom.tn, 
 Armin Wolf <W_Armin@gmx.de>
Cc: srinivas.pandruvada@linux.intel.com, hdegoede@redhat.com, 
 Michael@phoronix.com, casey.g.bowman@intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241107003811.615574-1-W_Armin@gmx.de>
References: <20241107003811.615574-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2 0/2] Fix thermal profile handling
Message-Id: <173143184661.3180.9800918282337612221.b4-ty@linux.intel.com>
Date: Tue, 12 Nov 2024 19:17:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 07 Nov 2024 01:38:09 +0100, Armin Wolf wrote:

> When support for Vivobook fan profiles was added, the new thermal
> profiles where used inconsistently.
> 
> This patch series aims to fix this issue. Compile-tested only.
> 
> Changes since v1:
> - drop already applied patch
> - change commit description of first patch
> - add second patch based on a suggestion of Hans
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: asus-wmi: Fix inconsistent use of thermal policies
      commit: 895085ec3f2ed7a26389943729e2904df1f88dc0
[2/2] platform/x86: asus-wmi: Use platform_profile_cycle()
      commit: b0955ce555478e24ed34c7d14f62fdf9c07b15cb

--
 i.



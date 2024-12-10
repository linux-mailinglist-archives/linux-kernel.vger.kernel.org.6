Return-Path: <linux-kernel+bounces-439756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880EC9EB396
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BD3281B13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECFD1AF0D3;
	Tue, 10 Dec 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeAMpIsL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7EE1A2C0B;
	Tue, 10 Dec 2024 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841564; cv=none; b=SCIC40IlNocvGW4TIpSATluztGEJ/E+18B8keO4AC+PCcayfYSWxphBru9I+56hG4qae0wx/nyov6++EB1qoJYaiBfE8nZ6htmXD0meH2sxCtSzJtpB7ylqEmmeQQeS7wTEUa4j5Cb7/YAamkAS8elwYnKZMPPdiMhkUfFiZ7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841564; c=relaxed/simple;
	bh=K9lzVfeajj0MtskWSsICrfUKtI4Y0SFpgZjQtp5yZhw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EczL8G0byOo2HjSyiMxHUT53MWL3Ianw8ad62JB6ZuzgxDE8gjKVt5vNbArqTkciW2l0mVMrbJXPVOnJryjxFS88c80ozKIROwgK3C1vuD0Z2SxErf3fqCqkkimAGgJkEr7ziBVI0lFn1gIueX913ehPUaqKlTPU/V99Gm2n0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeAMpIsL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733841563; x=1765377563;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=K9lzVfeajj0MtskWSsICrfUKtI4Y0SFpgZjQtp5yZhw=;
  b=GeAMpIsLcso66uZnLDB66Laz0I0aa/1KRYDDbPNFdEz72CutEMzsCsgy
   S9I6Jp1rYihjLjh/6dXZ/bB75ZSr1ExBFL/pDPwgW3JjrLImbg2cFWnjd
   ++VwkMUfbGmuBQAh42Ff36LklUnryIRcSeE0lxEXwmf3AY2L/etxSAoZW
   iW1axb3vE5ScR3CppbNQLMEiUYFZAunlm+8mlJ0lJ+jXEHO0xuIFQOEIh
   rA2u5A76ipO8NAJxNhGQqIC+wkmhkSLNQB0iSVJP1XwLfmucBv1PvLxTR
   jHoCyuusw70py8f0tHuC/DFDGvVqCSTzezkxO7ClhJ92sxGRx6b9N20CT
   g==;
X-CSE-ConnectionGUID: m7cK4G3BRKO9hjh0b2nMTw==
X-CSE-MsgGUID: AR0mEz9IQ9GmVMUCpt3UCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33917560"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="33917560"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:39:23 -0800
X-CSE-ConnectionGUID: wWBmzMXhQfeF2Ai7KVE2DQ==
X-CSE-MsgGUID: 8KKosOuiSJGtNDFfmhoAIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95262480"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:39:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com, 
 linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241208002652.5885-4-kuurtb@gmail.com>
References: <20241208002652.5885-4-kuurtb@gmail.com>
Subject: Re: [PATCH v2 1/2] alienware-wmi: Fix X Series and G Series quirks
Message-Id: <173384155548.12053.6491077559044408958.b4-ty@linux.intel.com>
Date: Tue, 10 Dec 2024 16:39:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 07 Dec 2024 21:26:55 -0300, Kurt Borja wrote:

> Devices that are known to support the WMI thermal interface do not
> support the legacy LED control interface. Make `.num_zones = 0` and
> avoid calling alienware_zone_init() if that's the case.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] alienware-wmi: Fix X Series and G Series quirks
      commit: c1043cdb019ed4d053d673e62b553a5cea1a287d
[2/2] alienware-wmi: Adds support to Alienware m16 R1 AMD
      commit: 54a8cada2f3d7efb4a7920807473d89c442d9c45

--
 i.



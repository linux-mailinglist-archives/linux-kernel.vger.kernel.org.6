Return-Path: <linux-kernel+bounces-398287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C839BEEFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AB4B22068
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22161E048E;
	Wed,  6 Nov 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhG+/OG3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FD1DF995;
	Wed,  6 Nov 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899574; cv=none; b=smT8k5tlTJu0/y30VTk6yLlzvzQ4xasR/RM49gciUEJedt9xmPdZoGJl0NyYY4+vSUOC/F7R3aI1ktiuagPG/8XYt2HGmnDXi/bIEKQ38mJUOe/Bo3qUA/smVNJtB4jQR6k/MpyPiPgPwaf0eogiICGalZ1IoV6wud77tYdS5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899574; c=relaxed/simple;
	bh=2TKdnD2pCGp1HGWZ+uy5SvmeSKhAzj5r5r+FuhZcNnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UwHFlqyhwYSjqgGHnWUubjx58e8Yb3G671Y4/X7FlprnAKBB8nF8SZoRYnXwmnkcLyZGvjn5RSfSPaj9z7Nd62DK2cu3d7OuTUOAzSnh0n8QTXKT+S0MoyRLTuWhfyb351adaQWEC+VJ6jMIvfAAPmKWTU4IcIGpsCZIyCQLHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhG+/OG3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730899573; x=1762435573;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=2TKdnD2pCGp1HGWZ+uy5SvmeSKhAzj5r5r+FuhZcNnM=;
  b=LhG+/OG3fRwglFM8XVBHdYgODj+WXKnaGHhXGSznzdl+B1TJyeXp8mck
   ON7txYTqn+bRCwVu05Wkc846EBg/7f0i3VgPGTCObHcYo70CrYYxO1Qiz
   T4vshIKeWQGFJNLivb5EBdPNp4ofQerAzVzzWAnJhGREcu1K1+0fp4okU
   DOyFDLuH+TcojFhd53QmyEaL9kMg6SOgSYFU0Bgzm5hhjRoA7PqLf4nAQ
   U7h5MlmYU41Pb0qTh8gl9PsV3X01QmTlcTkztb0IPi/eywMABMWgpDSR2
   H568EIyy6RbggSlhrt7ijTd+Qz6yf5MUSqOXRx8uktTIjU2gG1/SbmDx5
   Q==;
X-CSE-ConnectionGUID: rnu/23JkSXiag4XQZk+D0Q==
X-CSE-MsgGUID: XW+wSWyOR1Ob2B3ejb6MYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41245267"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41245267"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 05:26:13 -0800
X-CSE-ConnectionGUID: TWzhqo02T/qVt+hq3bqvhQ==
X-CSE-MsgGUID: nT34LukQQ6C+6LKEHajdnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84638577"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 05:26:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20241105152813.60823-1-lukas.bulwahn@redhat.com>
References: <20241105152813.60823-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in INTEL TPMI DRIVER
Message-Id: <173089956521.2259.13164548577532945229.b4-ty@linux.intel.com>
Date: Wed, 06 Nov 2024 15:26:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 05 Nov 2024 16:28:13 +0100, Lukas Bulwahn wrote:

> Commit df7f9acd8646 ("platform/x86: intel: Add 'intel' prefix to the
> modules automatically") renames tpmi.c to vsec_tpmi.c in
> drivers/platform/x86/intel/, but misses to adjust the INTEL TPMI DRIVER
> section, which is referring to this file.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] MAINTAINERS: adjust file entry in INTEL TPMI DRIVER
      commit: 44ed58e57984d0fb26d1e267deb9d83a1a071dfe

--
 i.



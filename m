Return-Path: <linux-kernel+bounces-387164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5819B4CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79E91C227D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961BB19259F;
	Tue, 29 Oct 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSWpH/Cm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BC18E379;
	Tue, 29 Oct 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214277; cv=none; b=NBdd+lUG3DUCpV2ri3UyFWL2DrYKDeg6o2Nb0c29i6rFNq+lvCt/o4GAs4N6P2BVsZ/ZQ5WSEwSUNTw2v7l52YqZugyrYXvjj7KPgOAT9N3kEVdx/rNC3vnV+qCEEFzS+uWc9/nV358mAG7sx/KziPewTutbSdRpNqiM5PVb4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214277; c=relaxed/simple;
	bh=k8vZB2zfkufZ7zzIxx3CqNg55GVr56oHwvNMqQiWuV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fDJGM+DW8/oNfdkmwM6G0605dwI7/WXrmI/TnNNsRNAx9lGQjUDH/R8Jx7gyKnl0/lXyjLbOdj4v0kRge69L4RCNQmmxShH20eVLTwujN8T7ZAyIoFUKYvEkrrBetz2zA0PfTVHYPMA2+SxO8wZDbYaI/4PuWK0RjqZpBYXYR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSWpH/Cm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214276; x=1761750276;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=k8vZB2zfkufZ7zzIxx3CqNg55GVr56oHwvNMqQiWuV8=;
  b=LSWpH/CmQ6pArSCbyHOFS8lQNyWGIAV4J2ZIBpUP9waSnqz7f42bYqKQ
   fBrH36fl5uCfSvRP2J7wcC7v2Oy+wFTira8hii/sK1Id+SUIzSI8rE4WJ
   gDxdy+o2Vka3r6zprG8UJ816CxxVlQ4iRwYM6+njm6jyHM1VmwPzABjJc
   FO2oj85HU4Jd8Lh0wOMIzvDPqaRjQ1Ph6pTr8tWWJX3QlWkw4c+4zpHgZ
   syKebN1wFzKcuDekN0EDJGeMNEtLN2/pmOstg4SzHqysI8/+eJr2LmsKd
   XKr1q3qJbtGBa/Ga4sU0zFht4yhrDikdKT4mFnlWPtYX2hE+lnbDKEjY2
   g==;
X-CSE-ConnectionGUID: nCUyh8woT5eAmXxcIxa8WQ==
X-CSE-MsgGUID: tO1j3W/TRKieOpxXxjzfRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29968423"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29968423"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:02:49 -0700
X-CSE-ConnectionGUID: SuWoVbrqQk2Ly+Ny50JVmQ==
X-CSE-MsgGUID: 04wXhnrmSzW3FXxstkRD1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82315533"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:02:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241024195536.6992-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20241024195536.6992-1-mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v2 1/4] platform/x86: think-lmi: improve check if BIOS
 account security enabled
Message-Id: <173021416235.2801.3490963798776930826.b4-ty@linux.intel.com>
Date: Tue, 29 Oct 2024 17:02:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 24 Oct 2024 15:55:21 -0400, Mark Pearson wrote:

> Improve determination of whether authentication account is enabled by
> checking if either password or certificate is enabled.
> 
> Renamed valid to pwd_enabled for better readability.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] platform/x86: think-lmi: improve check if BIOS account security enabled
      commit: b39e8ece931a4b4f64cdf9e75fffd6e82828e471
[2/4] platform/x86: think-lmi: Add certificate as mechanism
      commit: c7842e69e4508bef0920030340093f128722964e
[3/4] platform/x86: think-lmi: Allow empty admin password
      commit: 7c0bbf1ae6502dfcd0df5d50013e55a71021c819
[4/4] platform/x86: think-lmi: Multi-certificate support
      commit: 5dcb5ef125907d09806509a9db8c6705041e0026

--
 i.



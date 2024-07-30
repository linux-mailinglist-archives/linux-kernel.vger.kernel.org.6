Return-Path: <linux-kernel+bounces-267528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A9941285
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364031C227D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB319DFA5;
	Tue, 30 Jul 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXYD9q+9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD11946DA;
	Tue, 30 Jul 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343674; cv=none; b=AEQTf5b7/rHvcH5+lYIarrnj9fX8UCV3PY5D7rIrNqCp1czlwEcF9yCxe3wyyYUyZNen6wvGCdTKkf3JcoN1eWNCa4igJp9CXqeEN//fKpIGgrpQvJEE7mhT+Ryw3BOTOlkLSjK8A/FLBXvhPDmjV7uDt6s7xUp3mAUpff3i5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343674; c=relaxed/simple;
	bh=HCMw+ye02m6d7XJ0spXH32xuEwXzeFs4NvSPJ9z77k8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f71PdoNKFi5JLdylmCTQN2OnF01phAiq4hEm61xBYXNP1p1GW/TrTStSGIauD2TFvxgbS2Dy7LDoNtwfkEF3Nkmmx572cZ0pxDGPvSqPyt9UcKcgQjbPSmZWlM5EjpcPJvYU5TUWkmi6CP71th2D8tQvYZVuq6CkUgP7RNbz1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXYD9q+9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722343673; x=1753879673;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=HCMw+ye02m6d7XJ0spXH32xuEwXzeFs4NvSPJ9z77k8=;
  b=DXYD9q+9SMSSyQSg5r8pXlrfql4f4JGjptp0vKUqDFvMJK1swfkg+GRi
   LIp09axXXVQVR5tVAH1JE9CsBCeUhsPmAPa/QbVUJjLRjbf6GSjxNMq3A
   FzbHBu0d0pTmnnlG41DdKEC6iOSpu+XfgQiX9THUqNRvT5k6zkRWZ117d
   QSW6T0KTEr+fZERChey7q2yoZvV3n9xdF/BDSVXYcu4awRGYlaXZr8tc0
   /NYR3FPoD62m9XHsOTuzv8ij6IbE7WCgicAXj6b/IUp75ruSBH3pKdETf
   3uYlneYp/Bq0n5DDNJEmqPuW5RFgphkecpHgmID7H7bhwDlzhY72vHaiZ
   Q==;
X-CSE-ConnectionGUID: zHuU8/NMSqW+yPdhM8Jykw==
X-CSE-MsgGUID: 5Ywh1g1DTCe2HVDM+27PkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="24020044"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24020044"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 05:47:52 -0700
X-CSE-ConnectionGUID: FTkYwRuBShKELfX30HED6Q==
X-CSE-MsgGUID: xyvgGgQTTmGMR8bOASgddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54582421"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 05:47:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Cc: linux-kernel@vger.kernel.org, hdegoede@redhat.com, 
 Shyam-sundar.S-k@amd.com
In-Reply-To: <20240729020831.28117-1-luke@ljones.dev>
References: <20240729020831.28117-1-luke@ljones.dev>
Subject: Re: [PATCH] platform/x86/amd: pmf: Add quirk for ROG Ally X
Message-Id: <172234366629.2712.7922428038159021547.b4-ty@linux.intel.com>
Date: Tue, 30 Jul 2024 15:47:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 29 Jul 2024 14:08:31 +1200, Luke D. Jones wrote:

> The ASUS ROG Ally X has the same issue as the G14 where it advertises
> SPS support but doesn't use it.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd: pmf: Add quirk for ROG Ally X
      commit: 4c83ee4bf32ea8e57ae2321906c067d69ad7c41b

--
 i.



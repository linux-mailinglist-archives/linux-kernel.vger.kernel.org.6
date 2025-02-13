Return-Path: <linux-kernel+bounces-513029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51689A340BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90086188F4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E42222B5;
	Thu, 13 Feb 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E99YUeTf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD12135AA;
	Thu, 13 Feb 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454387; cv=none; b=mm2lOdzcxk7JAqAQZCOXLjSQPApYRDa25Uwx2okdy2ArMhjYj7uvVJvf4UpgyGaaUCZu7/UrkU3z/+lwFPnSQ1+w1u7Rz+IfKPFqAa2mA/2/W2zd0TxBdcIv7Fcgtx1VHX+JmmE3j2nhBvSolQWjNj3fCM/RR3FbsyaSEIodnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454387; c=relaxed/simple;
	bh=ea4Jffnzhp7qsiHS6McVa8AJ+x0Zw0w7H+PgmA/Qub8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gL03oDc75BWWv1/n5AF+qkvL1fuxmYcirQVU3HcgAOOXSTVV3MNOyjOekq56QE246r1YBHpJ3R9iWQ/kEcZIwPuJRMGW2Q1RSA3z8IqX7mO9cv123GItZvnDp69Blq8HzF84MMcjLbiuel0pWLXFdJPJtdSSGs/ojoLBSQvYRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E99YUeTf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454385; x=1770990385;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ea4Jffnzhp7qsiHS6McVa8AJ+x0Zw0w7H+PgmA/Qub8=;
  b=E99YUeTfJYVhn9d5T0JUxcSVjUcHN82a9umbGkwUS0Cr/y+gv8+8T3LY
   JR3rtvdstY93jEv2h/0CffcCq6dqcxW4tzlWlFLq/STfemuRKnj0zXAdf
   9B8liZhtUHsdaQsT6TLe7nPfwlBstyf/NIeejfyMjxgnZfkrKOLyIWATB
   QJZ/gRQjKmC5gEaKkLsvBKDwB4+roGU80W20PanniwEzQKMw7r7eDstbf
   sajPimOd2sKax7+HSpV/KnWlH8I4ynLsaJ1nm0Yk+LIbqtglhi44nIXk0
   MRkBzu53pUJyDGMEuhRvu1v0AiSTAc6Ek3hoBUJB1pgcUSG5XWwHPzXH3
   A==;
X-CSE-ConnectionGUID: bL2PaGO5Q4Wm+PLSKRFbvg==
X-CSE-MsgGUID: P/TY95bpTFeprDe8a/Lt+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39343006"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39343006"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:46:10 -0800
X-CSE-ConnectionGUID: FyZPVDTLQNqxsZbkmTaASw==
X-CSE-MsgGUID: WEbo1EO1S9Kg19VQWHbqLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112903695"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:46:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: ike.pan@canonical.com, hdegoede@redhat.com, 
 Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250210155333.1145867-1-ovidiu.panait.oss@gmail.com>
References: <20250210155333.1145867-1-ovidiu.panait.oss@gmail.com>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: use dev_groups to
 register attribute groups
Message-Id: <173945436334.30492.5237054629135467891.b4-ty@linux.intel.com>
Date: Thu, 13 Feb 2025 15:46:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 10 Feb 2025 17:53:33 +0200, Ovidiu Panait wrote:

> Instead of manually adding/removing attribute groups, set
> (struct device_driver).dev_groups pointer to have the driver
> core do it.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: ideapad-laptop: use dev_groups to register attribute groups
      commit: d497c47481f8e8f13e3191c9a707ed942d3bb3d7

--
 i.



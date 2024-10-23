Return-Path: <linux-kernel+bounces-378024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CE9ACA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8491F2236D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F81ABEA7;
	Wed, 23 Oct 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdEM8BFF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB11AAE31;
	Wed, 23 Oct 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687153; cv=none; b=ZVGAEY/uQ9garhixS7nxCIGpujJIM20sP09PJBd3ngUrOF/H9e3idjMIdEkDol2wmadX90T5DhF3ku2NWIegmOKvcU1kmq0fDn6db9mMk69hphyIpzJRIZdC56zOZNOdd8dB/JiJk/WA078mDGOO0LBGqY4G8fae287r0c0mAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687153; c=relaxed/simple;
	bh=VDN6RmHlM10MurxZo+azDyhajBN9ot8KBsxyMd8i8J4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WFWp0hZtP2pm9zo2wPy18KZNC5s/mPJ+82awjCg3HMsMSJAgYo7rPTO5wIQGx/qC2SY8gbGuRMPDOacjAyzD+cQ4VcvFPxmugeutD5SZBcvdpPv5fgwNs+Y5CjNfD77kBmoGqyRT67dk9rPxGoBR2sTFgvLl6gr2fLsghDiuad4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdEM8BFF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729687153; x=1761223153;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=VDN6RmHlM10MurxZo+azDyhajBN9ot8KBsxyMd8i8J4=;
  b=ZdEM8BFFh3G886vl8Kl78GZtNA0CM5pDJ9/bOT6hO02fIq/vSxJPefAO
   YAGTlfbNJlBQzrDpG4Wy8bkwLTKotuuMKpZOmINqw5T4+oGrRmL5T7tzS
   K5llvxSoa03Mrm5KC0J1ip33B2BU6SzPiWX1cYDU4IBFya8LnUz8Zzodq
   nn9nxMSbrRjpCH6wfrQITiYkuuI3sN1O2/FE/C4dD1jFEiytMZSBtqBmy
   EuWwdffXVL6usVJ49ml29NUMVWTeu2yso9r0aqs+IgTJ7nftGgBB7qokZ
   Q7YJaftfrM4oTAC/ZEghdCU7gm2um/PMAGCqi2DfsTj+eVDMh8h7QqRzs
   A==;
X-CSE-ConnectionGUID: Werb1QW6QUGCtFazPgyYBg==
X-CSE-MsgGUID: o2P8/KB/RECcx42TUM8+XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40661919"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="40661919"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:39:12 -0700
X-CSE-ConnectionGUID: /5nfGDkhT6eagWSelHZm0w==
X-CSE-MsgGUID: Knq80YSSRwiR+gEnFtHv8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84982950"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:39:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, corentin.chary@gmail.com, luke@ljones.dev, 
 chen zhang <chenzhang@kylinos.cn>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chenzhang_0901@163.com
In-Reply-To: <20241023012905.15551-1-chenzhang@kylinos.cn>
References: <20241023012905.15551-1-chenzhang@kylinos.cn>
Subject: Re: [PATCH v2] platform/x86: eeepc-laptop: use sysfs_emit()
 instead of sprintf()
Message-Id: <172968714145.1753.6784354782646325704.b4-ty@linux.intel.com>
Date: Wed, 23 Oct 2024 15:39:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 23 Oct 2024 09:29:05 +0800, chen zhang wrote:

> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: eeepc-laptop: use sysfs_emit() instead of sprintf()
      commit: 5f70c9a756ee131b0ad4368ce16804e9ed123f69

--
 i.



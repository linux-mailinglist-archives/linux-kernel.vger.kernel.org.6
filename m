Return-Path: <linux-kernel+bounces-190412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C0B8CFDF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484071F2135C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792313AD37;
	Mon, 27 May 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtwCiVIU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696427701;
	Mon, 27 May 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805045; cv=none; b=tDw0nUwb98JonxdfM2MF7iT8DMvoDPlGLKAElzby25ntmusF/1IbG/rH2+lrJUoPOJeQd4hNogrRHxxeFu5B/88H+FnoBhe2tY9Y1V6N0WPyBg7/M8+DwLPLoIKn37B4Ygwy83NGP/wu6ZsKhSHhXL0vsghF/cmI/eB6h8Yz7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805045; c=relaxed/simple;
	bh=WGewnNRqrB4yIglI8RDMdjSqZ/L0q5XXfLeuc7tx7JM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tDG7KH6YGDqBAJcosZj7uCnUnOilgE6UrU1q9g9SuJlWmPun0ZJg1dsXcz9McUsYKDegxSNlhVgqLtQPtpJTrUwsBLQvxbN6PZziYdP+6Oyi73BUjGG1j1QGXove1cojTylw+3BB7hz9GlPMaCOnobFnybO1lUFKSDOow0ckxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtwCiVIU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716805044; x=1748341044;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=WGewnNRqrB4yIglI8RDMdjSqZ/L0q5XXfLeuc7tx7JM=;
  b=FtwCiVIUSdzTJP9nRgsMfSCFsDD8pdapJuBWxBpzqDMkTfoOypd7I+CN
   xWsUJcwGOzKhrpA3C2QQOlOQ/b+XmWqrxUcMZ36M/LEiDUHwiYmrMd7sL
   BLXefqd1+6MAv2nsgRvXMjsgwVskc3/JQF/DItohwtOOlyiNNE8VjQajM
   QpMTdKyLeURaTg1LsXYfL68f38hT3cJNbVHpG3mqzSru6oz4dFAzJTyCQ
   d6JhSNxkGkQk34TYL42QLSAlFmD4Wtn2o8juCMBwkz80xa6+r0qeICpKR
   gbynVQYgvGs3NdKbHio8ni6XU3NlWFocp13+IR1y51hHMH2EPDIonn475
   g==;
X-CSE-ConnectionGUID: V+DkMCOFT0i4uB61Y2j83A==
X-CSE-MsgGUID: OXnn9jZUQ+CzbSiBfyeDMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="16904483"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="16904483"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:15:26 -0700
X-CSE-ConnectionGUID: yR5bOMzmQwuKz7NGPJTijA==
X-CSE-MsgGUID: c+ib9qCPSJqwUWeAW7+mTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39118209"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.138])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:15:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: markus.elfring@web.de, Thorsten Blum <thorsten.blum@toblux.com>
Cc: Shyam-sundar.S-k@amd.com, hdegoede@redhat.com, 
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <20240527083628.210491-2-thorsten.blum@toblux.com>
References: <50d10f0b-d108-4057-be9c-a90e2398e810@web.de>
 <20240527083628.210491-2-thorsten.blum@toblux.com>
Subject: Re: [PATCH v2] platform/x86/amd/pmf: Use memdup_user()
Message-Id: <171680491830.2175.13318371328377311135.b4-ty@linux.intel.com>
Date: Mon, 27 May 2024 13:15:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 27 May 2024 10:36:29 +0200, Thorsten Blum wrote:

> Switch to memdup_user() to overwrite the allocated memory only once
> instead of initializing the allocated memory to zero with kzalloc() and
> then immediately overwriting it with copy_from_user().
> 
> Fix the following Coccinelle/coccicheck warning reported by
> memdup_user.cocci:
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd/pmf: Use memdup_user()
      commit: 46de513068f956b76d68d241a7ad6bc5576d2948

--
 i.



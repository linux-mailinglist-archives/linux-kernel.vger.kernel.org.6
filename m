Return-Path: <linux-kernel+bounces-387166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FAC9B4CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773A81C2260F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB99A194A5A;
	Tue, 29 Oct 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZT66GuNF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15B192D93;
	Tue, 29 Oct 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214280; cv=none; b=C/K3bCQ6NSYa8GRiG4vKrkfxIfcrd/9j4qRKag9nokugNWcbCOp+5ZEpo+VO90OpumHI/AAU7F7HggYjg+HdDY8TV880dQrPje9D91ugNB09Li1dFU3bkNInBaHWFCeKFtjynzKcFVl+jzBOT9ao2nrFPv2k6taUFbUdsnvyPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214280; c=relaxed/simple;
	bh=IhZqwxywfidNMOS5LUExdH984KVWiLGmJHduuN5McNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A6Ducq2FU6uQEUmvxoJkvbKNQSVCi44cxoLedhqlK5yySkqTQmoU4b2Wc4AlD2Mo9uscqU2HziiVlxWJyBNFfuJ4ZZJujygxpRY6v2JruHcFFHmgEO8A7mCJh5N2d1dh7LEpaeKG8MsjsP73w1Z7fCj2a1mA1ikzfRYVpTDE1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZT66GuNF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214278; x=1761750278;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=IhZqwxywfidNMOS5LUExdH984KVWiLGmJHduuN5McNk=;
  b=ZT66GuNFp3CdfLmCVK5wczJsminhYNSzoaaSlmddv62BjWVGLTrsNgbC
   CcwgoByzTCs/0qfFYF4VPI7oi4mzB4fCOwdnP6+VHE/z1rFuX4M3ifKbD
   aQCm6mOxdI/vlLIVyNi93jPo+MaX9AeDzdtK9YEcdBB5xbPck1QzZo7JD
   RugKLEppEAnxYVB5mtDCUZENls3akWLyo6FPSXKnd05ai0EwlbKSo4a03
   AM87SunQ7PpVU2ETzQUec5H9UC4uq0vw9SP9B60rtHTWhgPzGmuxwXVLr
   Djb9z4XA3hDKaZbKkzPq0y5wflCzjVo+qlImCTg0hiTtYFvAzstzlcKRC
   Q==;
X-CSE-ConnectionGUID: FFS8Q0PKT5O5JlXvz/Zhlw==
X-CSE-MsgGUID: Au2W+l44Scm1K7g6sCwNCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29968476"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29968476"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:03:03 -0700
X-CSE-ConnectionGUID: xDFZ37l0QNerlGmwLeO6UA==
X-CSE-MsgGUID: DhKNEs3MSVesI+ZktPCu5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82315556"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:03:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, cezary.jackiewicz@gmail.com, 
 chen zhang <chenzhang@kylinos.cn>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chenzhang_0901@163.com
In-Reply-To: <20241028024949.24746-1-chenzhang@kylinos.cn>
References: <20241028024949.24746-1-chenzhang@kylinos.cn>
Subject: Re: [PATCH v2] platform/x86: compal-laptop: use sysfs_emit()
 instead of sprintf()
Message-Id: <173021417618.2801.6058426025520461204.b4-ty@linux.intel.com>
Date: Tue, 29 Oct 2024 17:02:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 28 Oct 2024 10:49:49 +0800, chen zhang wrote:

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
[1/1] platform/x86: compal-laptop: use sysfs_emit() instead of sprintf()
      commit: f60933390852beb1fbbcad12df5e261cf8312a9b

--
 i.



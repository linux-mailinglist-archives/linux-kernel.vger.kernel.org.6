Return-Path: <linux-kernel+bounces-375950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3229D9A9DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7325283A91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E105B1991CA;
	Tue, 22 Oct 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIipBIDF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3161991C8;
	Tue, 22 Oct 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587450; cv=none; b=XhtdWERdQyKSqLkqrxCmaZCX9tqvyvJwlxlKw13UKGBCVO5EmW9k99UDY1ebxV41sEDPDYPB+xCE6MhRGF2no26NXRLwavvhQdGSDtdhvxAqy1i/3DxgpMYn2ZIVx7wNr63/dJ4CxC2XZzmMaY6h9/e60QE2t5JfZkEXss6UO10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587450; c=relaxed/simple;
	bh=H3Ce+y3qXwjnh7cRcDNQk4Q3lBSR3Erz6Pqcb8Depw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=md+SaQZTQXZPoviUqZirPildKiFLt4yqtjMEwWpqYMsVEtTLBAGTY6BpsjL52Rl2IyEbJ+Gs17IWmmgWQRqi15uxGd5jKeGOTQTGc5N1Kyw0+Q4RsJjvT8/Tp07c4g/cm2YkoBqxwaPGpNTvQsrm6HIt5L6O4fIZMhz4/j/NVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIipBIDF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729587449; x=1761123449;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=H3Ce+y3qXwjnh7cRcDNQk4Q3lBSR3Erz6Pqcb8Depw0=;
  b=XIipBIDFKBaaXUd5cATNoSZx1dfVqYCaU1+fX2IgUZzt2ow5w3sRpjh1
   qkqvUc0QQrWhpvfJQ87i/UCml+kocuDQcEu1D9prcA2COQRgMIlnTQe5I
   3HD2RbSgX8VehWuQdCJZLWoTxS3D9vZLM0HNd99sh7mdJZ2f/w2RPKp4g
   MuzcjgGxxaumkFI+zFcRfSrP5+pLcim3tgAEsNUFDOjxgJkG2XIcqD116
   gmJc1pMaUoGsp4bHKU5rNxKgG0bDHGUw8tm3Fj1KU7f+GpYIzmpqHxVJI
   fkl1r0KcMNAZ33QsmB80mtajSBg38uPIDCAtSeJYsmDo6Ii574nHWsmar
   g==;
X-CSE-ConnectionGUID: Tk7Pe8NgST23V26JkUiQhA==
X-CSE-MsgGUID: cKke3Km/R3mWp475h4O1ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40494351"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="40494351"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:57:27 -0700
X-CSE-ConnectionGUID: RmwmEPldQtqucDRGnsJS7Q==
X-CSE-MsgGUID: A0GSezNHS82+PxyJBZUWRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80607238"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:57:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Hongling Zeng <zenghongling@kylinos.cn>
Cc: stuart.w.hayes@gmail.com, hdegoede@redhat.com, zhongling0719@126.com
In-Reply-To: <20241022030500.9986-1-zenghongling@kylinos.cn>
References: <20241022030500.9986-1-zenghongling@kylinos.cn>
Subject: Re: [PATCH v2] platform/x86: dell-dcdbase: Replace snprintf in
 show functions with sysfs_emit
Message-Id: <172958743919.2775.6305812647811302293.b4-ty@linux.intel.com>
Date: Tue, 22 Oct 2024 11:57:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 22 Oct 2024 11:05:00 +0800, Hongling Zeng wrote:

> show() must not use snprintf() when formatting the value to be
> returned to user space.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-dcdbase: Replace snprintf in show functions with sysfs_emit
      commit: 81e2cc3688cb0002d22207a0a5b11be230d4ecc4

--
 i.



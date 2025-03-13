Return-Path: <linux-kernel+bounces-559531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55695A5F515
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC97A2AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A0F2676FF;
	Thu, 13 Mar 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QU4Fotet"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DF18DF65;
	Thu, 13 Mar 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870860; cv=none; b=J1YI8Q9v5kJRBfWQmalkBiYQpR7hvlPiS+h/5Udn2JDPbPRlZHo/crRUvbBNSZooGX8/yd8YUITLXjMLneXk/tQNye0HAdlY4CBeajY304NbCu1xS8SC/Jyja/d38grB113t2uh9myEdrO+n/kOSNXEzdkLp92Rf8gUGBtNa8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870860; c=relaxed/simple;
	bh=SDYy/g2KE1CiW0cC7LQL6eKyByrj3fUGqqCT9sOLOeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dRoS8i0rrSIZD7aqWCnBLUZW8xFppLIvqeI93U+jfEQwd/3IkaNPRKAwYo0oqqyWSnTGZegHn26yLKyPj1fgqEe+I/35HqU7SvRPZk685ODwXUk2zoddaclcA5bOM8PYU62guzf2NiOzJk/ZL9OxUFoCbXPySwY+N2concCIC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QU4Fotet; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741870858; x=1773406858;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=SDYy/g2KE1CiW0cC7LQL6eKyByrj3fUGqqCT9sOLOeM=;
  b=QU4Fotete3aSlLhWRxRWsuZ+eqoJaeu/6j8zNcGuCcDQdDEyUPBEz4bO
   3z+r+0wylV/9mjNjDCEbB5Y/hMBU7+TtqmOIYFUwcmu//9dl5jbjt/6pl
   6qABbcdQyXeG5oF/d9PGU6zrXA0fiFOMob2SmKGZBU5pvEZJ6K6LfeNnN
   NpagZlICNIv3qtfQoGpgNzc5owqCJUFJWrBq9zYMLMEX1IUUHOG4eMec8
   QhAra5hvUPqTat2Yh6P6mypeTT6Xg+B9kpMMbZIbRmOhAQoFs+qWnyHCh
   Hovy0qNq2uuexM2zBTf03z/Vk/gY+cIc6EPR72OwrqXM6x6HPpt/c84ut
   Q==;
X-CSE-ConnectionGUID: qx9Dc7SjRO+m4IGiGJL86A==
X-CSE-MsgGUID: pejiSxEUQaOXL7moxmL5BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="68339388"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="68339388"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:00:57 -0700
X-CSE-ConnectionGUID: NMLPc5kETuKAqeCw1Q37hA==
X-CSE-MsgGUID: 0/NCzJHxQa+dS5ZIXO/7Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121157649"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:00:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, 
 Sanket Goswami <Sanket.Goswami@amd.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <65e2fffb-a1cb-4297-b725-661d6b790a05@stanley.mountain>
References: <65e2fffb-a1cb-4297-b725-661d6b790a05@stanley.mountain>
Subject: Re: [PATCH next] platform/x86/amd/pmc: fix leak in probe()
Message-Id: <174187085032.11107.7565915146990042639.b4-ty@linux.intel.com>
Date: Thu, 13 Mar 2025 15:00:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 12 Mar 2025 11:31:57 +0300, Dan Carpenter wrote:

> Call pci_dev_put(rdev) before returning.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd/pmc: fix leak in probe()
      commit: 01db3d1ff43aeedeaf11c8bc9d09493ec00c8f4a

--
 i.



Return-Path: <linux-kernel+bounces-353093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391D4992855
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF79328411F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33850199E8F;
	Mon,  7 Oct 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgxSyPhl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEF433CA;
	Mon,  7 Oct 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294133; cv=none; b=q/2yJ4fZEvBr4xZij9CmYOJWervlvreu07I1dkpViqdWPFP6Lo7a4dHDQm/ZuF/PmtSdk37Y+9NEUTNlUeCNEd7wEHVTunGWmKRvZ0RDkJxteqKjPSq5SV2PHMJe5kk3uOBpFdoDOokqtV2P3sTztCS1wUp/YLe6P2g5ndSm7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294133; c=relaxed/simple;
	bh=FeKed36+MTjOd+VWrJxG8wgWlDmgL9nZPXlZjr1SW0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CN6DAcA9oF4o5zv4ajkJnoknQYJr6WMPeydG6KaYVxSjxLDIhzeL/gIbDyiUDXecEyxE1S923IHACHf5X4kjYegntIyC7m7LgPUL6jt4U/X44fqxr/TilxbvZGT21E8qM+jqXyZziGnBJFjo+/jubaEZVi7/zYwiUASfydqtHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgxSyPhl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728294132; x=1759830132;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=FeKed36+MTjOd+VWrJxG8wgWlDmgL9nZPXlZjr1SW0c=;
  b=NgxSyPhlKOm4eu+ZJCBO5VcQ5uRFMdxRisOxhctJ+5/ENHBRPyyCq8DT
   TAbvZdOHryxu1QxRf7YFD3vCWqU2WCqcVjm0WyorJ/0NRMEqkdI2Af0Sk
   g2HqY6gYCKpFJO2o6UccyP2pJ/2hZBOOHpmtG8lcSRw1KVgLhOtEWP5kV
   3CmvZusFfxVBXt+8WvCkOWufXSs/mkI0WZpTBwjPB2bEt/vIhQcErIa83
   9ppzoKfS1HkAduTEzU+EU0Q+GJtJ2cpqxlaXLD/oGmJUfqdHty3wmJAWU
   suIyu5xXxqkG9Mh2fBmkR5hWpwN+z1jM9fb6tuJtkoHs9OSlN5neocD+V
   A==;
X-CSE-ConnectionGUID: vttCxKUAR0aTSmtK3uM4RA==
X-CSE-MsgGUID: 1xSI9n5KSTuf1i7wk/pH5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="27317840"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27317840"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 02:42:11 -0700
X-CSE-ConnectionGUID: tA7kamMwTDO50GaZ+4oslg==
X-CSE-MsgGUID: KDm4i4mqQKqxPWLZU6l5xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80009615"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 02:42:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>
In-Reply-To: <20241003154819.1075141-1-andriy.shevchenko@linux.intel.com>
References: <20241003154819.1075141-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: intel_scu_ipc: Don't use "proxy"
 headers
Message-Id: <172829412325.1956.4300166493999034307.b4-ty@linux.intel.com>
Date: Mon, 07 Oct 2024 12:42:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 03 Oct 2024 18:48:19 +0300, Andy Shevchenko wrote:

> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: intel_scu_ipc: Don't use "proxy" headers
      commit: 066c779b094b63754e0742ad8675d72d6c0a46f6

--
 i.



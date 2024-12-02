Return-Path: <linux-kernel+bounces-428048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B19E0970
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228AE164787
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88B21D9A41;
	Mon,  2 Dec 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRa82u6O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA51D9694;
	Mon,  2 Dec 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159144; cv=none; b=qFL2gd1E6iwm3aVESR5Nwbgcjp0qyRJ7M6C2JfSmP6oD6uB/StjayUWYvTVRCRVQheT7fgt/8J27lw6jOIKXnuziaTdXAo1XUifsfuWSwbQ8c1pzCe2edyycMzdU5xjhX3ttCNO6CuM5NONhpvL1+aTwfHOlOMNTKs748CUJL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159144; c=relaxed/simple;
	bh=6Hf5h7DvKAIYK/L6EYLhP8Phqo1XPcyWSonmR4PO71A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gYOM60zlw77dICC9B6C1hgFR8V5l8DbfNrOqEpkPjSC8p1Ksyei8BDxf++hPnIJqvoYILczYRFzBJNO2lbv0qvy2e+tSJVIMFkLyKCOKIBlZDF2pC59WwRx9uxlZ4NamX9U949lf1SIMHGOi8sh+aH1KYxP91P4ZJFcbpQrhFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRa82u6O; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733159142; x=1764695142;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=6Hf5h7DvKAIYK/L6EYLhP8Phqo1XPcyWSonmR4PO71A=;
  b=kRa82u6Ou1jqZTQe9/kKj9ml21CWfROwIDqLhFnK4fc9oqUiibpwCjjP
   UBFH2tkpKAtTrTnKwn7a78O03+o96eFezdHdVXEL7kWy/jfBLz9k2lpOa
   gckfXcMUf+W4aCB6bveI61IJCjrtUjDUbTtUBeK+kr4bnVcfh51YS3hf1
   4mQkxkxlysWQemCLBqb0MBAfQXOQJ0Q6Z1W+hJ0NFOJts9A9j0TFcotl9
   Z86RoKteJtvlfsilXxGBOdO3b2o0wuHozS3GYdRm+tqO+mzcOQlwTLte4
   O+GjCE1cYr6Ua4dBUU+GaXsCGHi7O39/R/2cIreuOeL6KI5Bi27f2JxQu
   g==;
X-CSE-ConnectionGUID: p6akpXIMRwuXr48569U6ww==
X-CSE-MsgGUID: ecpZKevqQzKXb5WUT3fjtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="43824984"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="43824984"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:04:33 -0800
X-CSE-ConnectionGUID: M6eJwR/RSTOZbLaNOxEayw==
X-CSE-MsgGUID: /Oy4Q8XwTRuyVSoa5X05sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93995307"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.61])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:04:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Corentin Chary <corentin.chary@gmail.com>, Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sedat Dilek <sedat.dilek@gmail.com>
In-Reply-To: <20241123133041.16042-1-sedat.dilek@gmail.com>
References: <20241123133041.16042-1-sedat.dilek@gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-laptop: Rename MODULE_DESCRIPTION
Message-Id: <173315902007.13686.16854039790074639451.b4-ty@linux.intel.com>
Date: Mon, 02 Dec 2024 19:03:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sat, 23 Nov 2024 14:29:28 +0100, Sedat Dilek wrote:

> Rename from "Samsung Backlight driver" to "Samsung Laptop driver".
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: samsung-laptop: Rename MODULE_DESCRIPTION
      commit: 3510398032b445abd034753ce86a60882f41fe27

--
 i.


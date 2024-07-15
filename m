Return-Path: <linux-kernel+bounces-252459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C077931355
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127D11F22199
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F421891BE;
	Mon, 15 Jul 2024 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esGwawcY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEF6A039;
	Mon, 15 Jul 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043959; cv=none; b=g4vANahHHGbYtAsT5wiiW2kwLPOuqNXQper1t4thCsHHthU66BDcaT9WCag2VmmFuweSs8vYRntlX4u6fzQ5FXtiRAWGD0fdjPbQCax2SPp2sLc1FbFMKdWoa67pX90zZWtm+JtH9mtY4CkXsIRem+JFez711zUoC8GEpMe/QB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043959; c=relaxed/simple;
	bh=VvBk/IAgFfAsmh7PlPHgbGWzq7IUOENluqNLHMJlMAY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IJLemmQax2wkT4qGtgp9bZQedtaH/untzlFkmSpemHgmCS205rDsqTp5n/XXXxKTfWCkc1kL0sDrxMjM3d6rVf36n3c39nQq+dOUx/N89/iJd7mDWEvfVcO6BJtdiIS4pIX5szGHBbJbVzFLUhMZtVFWx7k8Mv788rZTO0bJPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esGwawcY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721043958; x=1752579958;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VvBk/IAgFfAsmh7PlPHgbGWzq7IUOENluqNLHMJlMAY=;
  b=esGwawcYi0RCchED2w67i02Youw/c6qeHGuH42qVD24qGlBZB07lDl/C
   zIJB6cfDMQZw2JdPthiD52HNphRraHGIHu4qRq8asLQB+t2glk5Da+0sz
   4M09iW703TEi3LHsJH+kQulTF3imqFvYqeKlY6tA7f7bt3WB+uuDjm7pX
   +tmr8fxdP7Z97i6TGUTCaHnmOGfRlLGqgGo9A1OjWROJqwLYzdjsO75iW
   ivn10yvc++ZJpUEhsK7U9o7Oh6pscPtMncg2fu0gJaTOn2RSIhlKtZknR
   DaCDUB3joDPoogX7WDYFl1dYbYl+Xt7KpVwPb8iORpRwU14lPgadidNgr
   g==;
X-CSE-ConnectionGUID: /RMxbaLhQSuoAHzHiWbRuw==
X-CSE-MsgGUID: uNgCBizLT2W1wqOFwMU5TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35957106"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35957106"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 04:45:57 -0700
X-CSE-ConnectionGUID: 9LPlusrPQta5gWxEV5D5Xw==
X-CSE-MsgGUID: pGcKie7aQc2C1LcSYEfa4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49683808"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.131])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 04:45:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 15 Jul 2024 14:45:50 +0300 (EEST)
To: Gergo Koteles <soyer@irl.hu>
cc: Hans de Goede <hdegoede@redhat.com>, Ike Panhc <ike.pan@canonical.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] platform/x86: ideapad-laptop: use cleanup.h
In-Reply-To: <851d4180f1df5a10ca6e2feaf429611f1c0ccc88.1720515666.git.soyer@irl.hu>
Message-ID: <066577bd-5d1d-bc6f-1fad-1c8011fa30cf@linux.intel.com>
References: <cover.1720515666.git.soyer@irl.hu> <851d4180f1df5a10ca6e2feaf429611f1c0ccc88.1720515666.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Jul 2024, Gergo Koteles wrote:

> Use cleanup.h helpers to simplify some code paths.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Hi,

I decided to take this v1 of this cleanup one in this cycle into 
review-ilpo/for-next but left the other patches because of the outstanding 
comments on patches 2 and 3.

-- 
 i.



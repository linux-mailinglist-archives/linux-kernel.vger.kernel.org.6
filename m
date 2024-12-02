Return-Path: <linux-kernel+bounces-428057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580439E0C75
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25FDB2254E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA871DA636;
	Mon,  2 Dec 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbPdvHNj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66391DA60F;
	Mon,  2 Dec 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159583; cv=none; b=MeCX0aP/YTaXWrhYKDrc09U51k7kPGYVu9t/GJxmYpRd2SeuN9yilSYuDnjVcBEMBF0RQMlXnW8ghseRoCja1MtwHBNBu6Y6IQiwcis5uxsTkZpgJYIOmiXGmjkfEdHa8C/ZiVq7MBVpX8xLLl8NFY9FH0qXyzXPx/fMwX51gNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159583; c=relaxed/simple;
	bh=eCc6Qw0DKGEIAmKvu3lI6k1co4F3f/ysD7yqK2328Ho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D1g0Q9n0ySaNYTTXwvZ11XnCbW2pk5HIScZmdJNMsUW3rWWThoTGEM0K6NLOW/NpI3g++P2stmPt67F0vn0A32yzsDsjHdiVQ7Fmi/jAopdzrV2ztUHgH+qVXKp8Uy08fnd0xpAqbBMdSU0UcmIfFthMhZVxFF3f8gxRINdXwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbPdvHNj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733159582; x=1764695582;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=eCc6Qw0DKGEIAmKvu3lI6k1co4F3f/ysD7yqK2328Ho=;
  b=VbPdvHNjki+8/EL+jcW9AQa/QPYpNaGyDjVVI39bs1UXZM6Vc0iuxxRZ
   xcmWDah8LEW7BF59h9ou5K2vrXa9AKRF/ZHG2YKJKvr3LK6ScqaHDYaQ+
   56N0v6rrb3diMh1ae0YuiMmlk/ycZRsHEob5hFleMTwYdBRUhDvZ5D/kD
   ZxrxgJfX4oX0aeGe8oF/42lYDwmhdWT3oBgbLmC8AL3PVJNYVPewm4YdS
   JWu7OpzMu5o9/sdSgk6rnFkaQbQtp09gCcmbdQiTTJKsoswLiSgbpPTDD
   piaznKg4XiZ+PxS3FeUPk6dY0hLxMUmb0scIFYFRejIQCjUiK1SE7MF6N
   g==;
X-CSE-ConnectionGUID: DnH606GlQO6LC0bkcukyQA==
X-CSE-MsgGUID: ZkJaiB2JSpOfEy+dO7GUBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50753043"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="50753043"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:13:00 -0800
X-CSE-ConnectionGUID: zZXfTiFyRE+2Nm+7MRqhKw==
X-CSE-MsgGUID: msql5MHbQHKfpoR1X4cxaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="97942531"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.61])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:12:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
Cc: kernel test robot <lkp@intel.com>
In-Reply-To: <daafd1371e7e9946217712ce8720e29cd5c52f7a.1732161310.git.xiaopei01@kylinos.cn>
References: <202410160432.oJAPbrW9-lkp@intel.co>
 <daafd1371e7e9946217712ce8720e29cd5c52f7a.1732161310.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH] platform/x86: x86-android-tablets: make platform data
 be static
Message-Id: <173315957317.13969.377038533153179056.b4-ty@linux.intel.com>
Date: Mon, 02 Dec 2024 19:12:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 21 Nov 2024 11:55:34 +0800, Pei Xiao wrote:

> make lenovo_yoga_tab2_1380_bq24190_pdata and lenovo_yoga_tab2_1380_modules
> to be static
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: x86-android-tablets: make platform data be static
      commit: 6e0fb1bdb71cf8078c8532617e565e3db22c0d3c

--
 i.



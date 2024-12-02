Return-Path: <linux-kernel+bounces-428051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFEF9E097E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41FBB42F92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4141DA0EB;
	Mon,  2 Dec 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMD4nEnT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF93125B9;
	Mon,  2 Dec 2024 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159270; cv=none; b=F5f39Vi9eL6jf5bgYlQGkYcvfKJDtR6Q5Qx1tF+ff5kk7ZXAFOY0J+dkaTdM5qEfFUFsliUuRhrN4kNyq3TyaPV6SLbNU9NRNKDXPJk4nCzU+GP8wzeaycc60aDgwtvtWgdUHufmfX4lAaDwirnA2iriS3yO3sq0ZZqIFjlgCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159270; c=relaxed/simple;
	bh=hukuVd48HzrlUMls/xL5iS0W3FYej2fkzttem2Qa6Jg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N39yWEFkjR5JXnCJwgh9WyO+4MsNDY/gR7XVeWfQIYpdaWUIrcDColE8vZKe/qb2/94AFMTLwGRnikJ2G4a4TxIOxzxz5v0i+t11TiB1MqrOY3GEw7NFZY6jG6sjKRTYjaebgLRSImQ16NWpF7mofCUV3F1n2LXt+5mmdrEEJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMD4nEnT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733159269; x=1764695269;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=hukuVd48HzrlUMls/xL5iS0W3FYej2fkzttem2Qa6Jg=;
  b=XMD4nEnTTQlwVriY4JxxIpygm61SsICIm0PiQG0yywBR7tJnjtOxGK7a
   qsD/iqDEO1NH5iuI5vrQnJIuOD35V76zjTrnwFYbIBpmXpQwWukMuOnew
   dlEdk6VT88IsnFXNwutY9+DuEPKXbKwIpT84mRhMk9R7MzAJgyX/tDP4G
   i0tjO7XeDvX/q6CRbzJy1eY7SFNbDRFBjZugoTDd26fm57FJhsmUvfh13
   U0VDfrrQc4srpInqkIEpQDcJL/vQac4yXu6xAezC7IAWGaTeBffRzEz6V
   W1IYGBQ65zNk58DS/FgwXrv6rgaF2QHFcyhMVIi8gHLSo9FX5NBu0ycBW
   Q==;
X-CSE-ConnectionGUID: d8fkWONlToGwidIB79le0g==
X-CSE-MsgGUID: b7BwL1MXQn2o0lktSD0uow==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="43825859"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="43825859"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:05:41 -0800
X-CSE-ConnectionGUID: PISFPt/TRBe2/HhZnvwomg==
X-CSE-MsgGUID: 0XdjS2dVSyCN7O5lCQp90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93068977"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.61])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:05:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: pespin@espeweb.net, corentin.chary@gmail.com, luke@ljones.dev, Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241123224700.18530-1-W_Armin@gmx.de>
References: <20241123224700.18530-1-W_Armin@gmx.de>
Subject: Re: [RFC PATCH] platform/x86: asus-nb-wmi: Ignore unknown event 0xCF
Message-Id: <173315902010.13686.5521479502498937165.b4-ty@linux.intel.com>
Date: Mon, 02 Dec 2024 19:03:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sat, 23 Nov 2024 23:47:00 +0100, Armin Wolf wrote:

> On the Asus X541UAK an unknown event 0xCF is emited when the charger
> is plugged in. This is caused by the following AML code:
> 
>     If (ACPS ())
>     {
>         ACPF = One
>         Local0 = 0x58
>         If (ATKP)
>         {
>             ^^^^ATKD.IANE (0xCF)
>         }
>     }
>     Else
>     {
>         ACPF = Zero
>         Local0 = 0x57
>     }
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: asus-nb-wmi: Ignore unknown event 0xCF
      commit: e9fba20c29e27dc99e55e1c550573a114561bf8c

--
 i.


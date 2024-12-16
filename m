Return-Path: <linux-kernel+bounces-447813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08829F375D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92411890CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6402063DD;
	Mon, 16 Dec 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqxfhbY1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E526E2063D6;
	Mon, 16 Dec 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369460; cv=none; b=cW48bHS5BX484weh+oW5INsL//nT4ecv/gSGIZCWd0qTsw1GwzkOWsQNnTrzF+4g5UjyLsxeAdpZpaHDghS17lgN5URj+3BcLM0WX02PvmlKJfXgedhb/h5/BaAwQM+uOjCKEF9oTvAlq4WZvKAd4PvxeCPz0NR3VrsxDfRw1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369460; c=relaxed/simple;
	bh=jwIDm7OntIjMqYsTkCZKIYWjyTOolpmfBMiJPluAcv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qkCQtHgltFp4WrseJzgsYdMMOoiwKrkrfbrqWL4MJAv9gMwHpXZDsa5Pa9JRPDC3NNU/esg3hr6drFW/K7KIoKmDgyqYIQwABfleNsTyeBbpu6EOa9txJlSaMj4r0wPSmtSjs9sfb6mwkjkKr7Kk34IkRMK+vsz9WnyWcORPqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqxfhbY1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734369459; x=1765905459;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=jwIDm7OntIjMqYsTkCZKIYWjyTOolpmfBMiJPluAcv0=;
  b=DqxfhbY1EZY+yLc3M+2yLBpVxQCNacBfA4GofGvx6PwKjKUTAM5QW+yE
   6o2mgkLEIAibzTqOndvOb55VkcICKiE/Qt8dlD//lFbdoud4p00GgwyFR
   vuj8ARAe0hSwPaWWR8ohmhhAMee0p9zbOATuVbk9VIfv1yStZW2Q7ETZg
   z0sntDjaC8Yz+4xv2FyyKFO5hndugMWlq28YbO0+PCcpNqFNt4sV76EeJ
   W142ANUEVipSajd759KuoLvzdA63HIPJJM7a3bksALNLMjw0++z9bMXg3
   VGnGWzJTz51XncG2dkZXisLG81vmtHuas1qlyoOt1E14hZS3A50D92N+f
   w==;
X-CSE-ConnectionGUID: DrfUhnxGS+awBONsBmTGTg==
X-CSE-MsgGUID: emkNbhefTw6+ZA77qmUQIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="46156595"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="46156595"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:17:39 -0800
X-CSE-ConnectionGUID: 8XOi4/ByQFGVd87bk4ccAw==
X-CSE-MsgGUID: 8ZWTwE/UR0aW7TPora4gfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98051792"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:17:36 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Vadim Pasternak <vadimp@nvidia.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241215-sysfs-const-bin_attr-mellanox-v1-1-b6fe4f68e2ca@weissschuh.net>
References: <20241215-sysfs-const-bin_attr-mellanox-v1-1-b6fe4f68e2ca@weissschuh.net>
Subject: Re: [PATCH] mlxbf-bootctl: Constify 'struct bin_attribute'
Message-Id: <173436945144.2913.15103478815629651953.b4-ty@linux.intel.com>
Date: Mon, 16 Dec 2024 19:17:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sun, 15 Dec 2024 14:25:40 +0100, Thomas Weißschuh wrote:

> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] mlxbf-bootctl: Constify 'struct bin_attribute'
      commit: aeb965c0eb8af66777d4bd5a109b92c7a947133f

--
 i.



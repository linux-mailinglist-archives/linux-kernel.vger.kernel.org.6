Return-Path: <linux-kernel+bounces-184844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186428CACF3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87597B21687
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039E974C04;
	Tue, 21 May 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="km2BiTOO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E974402;
	Tue, 21 May 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288970; cv=none; b=irHChsYWtl/38LbL4Lw38cQMGcU79pWiCJmrcUsrMB6vVOC7szf/CLflz+U+6qUyXTC6zKVovOOP7gTLlVQkd9lrcA/7gaiZ4Hshk2D392hlLmCcRCgn5tD5n0fZRnKats7mvk37dddNpx1T4sbX0LxLQft16gMYA1OODp9Gm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288970; c=relaxed/simple;
	bh=wVuYdeC4Ir6GXXZS576h08C/Bb0grRWIq46QA/Pmszc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZkCP5TPthl2kBMSWTIgbGPban2w5i1SHs2PSPs5J5921FQEJtnKJun9GigFPNBycnthbXUciqLTSIUab7pqHyOj7DHxbG4L35ZHU7Ke4FYAn9Xul+U/8iNhNDd5c0vaqqhNNL5xfqtAG7HSlzacp2EWE1SFwZOGj8FuEcuALuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=km2BiTOO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716288967; x=1747824967;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wVuYdeC4Ir6GXXZS576h08C/Bb0grRWIq46QA/Pmszc=;
  b=km2BiTOOa01ALYbebh2bwoZU/AsPr2g9G+f+586rmNHt1H0lngSsYHN3
   vEBMNN3/5TwTj3JzkRZvEti0Zl3vZyp/d7EO1IZ+kdpThJc3XyP540+PX
   oG0CWhoUbsqufBhWCBUX2zqWvwxxrUGNWC8HWPv1ZGDQi+PsXRntXveCV
   Br533NrIsxPaHkq0BAueWtroBYB5Z9jSKURRPL1cx1sIOAVd4p+voM0G/
   5zUyG2HyRhTLIXhVepHg4J6fk6Psg9Zg9/OF1HJCIgzD/hgXfcFEzajAA
   UsPzYYjSZL5SAIBIJ8wU2lctVoIMFlgb25wmFugBVjUAyOSLXGg5siET8
   w==;
X-CSE-ConnectionGUID: E6qua12gSP2xIwrikJn3Yg==
X-CSE-MsgGUID: s1FH0m3TRBmUNiufCiYxww==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12645135"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="12645135"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 03:56:06 -0700
X-CSE-ConnectionGUID: mVS7OFJwQMqOcxoAJBwMMA==
X-CSE-MsgGUID: dMEbn2OWSMeXkebbPXPCCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="64106452"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 03:56:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 May 2024 13:56:00 +0300 (EEST)
To: Markus Elfring <Markus.Elfring@web.de>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
    platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    Dan Carpenter <error27@gmail.com>
Subject: Re: [v2] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
In-Reply-To: <7b903568-d8e8-4a06-b501-8d49f3f0fffa@web.de>
Message-ID: <c158e0f4-fcbd-13a6-ee98-adc26160c3c2@linux.intel.com>
References: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com> <d5203ff5-8ed4-48ea-8e58-a2e6680b0542@web.de> <6d1bf351-77cc-7fe9-2d62-8bd99789e4f1@linux.intel.com> <d73fe99b-dea3-4792-aa1c-c3317f296003@web.de> <5287fc2e-91c5-442b-b66c-6eb1fe334ce4@redhat.com>
 <51368bcf-d2e3-42cc-a112-a1a485f29c73@web.de> <a8eb3ba6-eeab-6c0c-7b57-4fde508853ed@linux.intel.com> <7b903568-d8e8-4a06-b501-8d49f3f0fffa@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1083109358-1716288960=:1027"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1083109358-1716288960=:1027
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 21 May 2024, Markus Elfring wrote:

> >>>>>> =E2=80=A6
> >>>>>>> Fix this by reordering the kfree() post the dereference.
> =E2=80=A6
> > We'll not waste our time in wordsmithing commit messages to perfection,
>=20
> I hope that you would also like to avoid typos in change descriptions.

Now you start derailing this with off-topic references to hypothetical=20
"typos".

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.9#n45
>=20
>=20
> > the current one is good enough as was stated to you already.
>=20
> I dared to present some wording concerns according to the running patch r=
eview.

No, your latest replies were not anymore about wording concerns but=20
complaining about process.

Your wording concerns were already replied but after that you kept on=20
arguing.

--=20
 i.

--8323328-1083109358-1716288960=:1027--


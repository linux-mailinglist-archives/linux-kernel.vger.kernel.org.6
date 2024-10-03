Return-Path: <linux-kernel+bounces-348912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C221898ED8C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B19B2826E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8022F14F9E7;
	Thu,  3 Oct 2024 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPW8Bl0z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B014F123;
	Thu,  3 Oct 2024 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953414; cv=none; b=CTBAZ+jxHA4SUcpNVTq7byMRAHdXJhrgVoNwn0Ai4qmTn5OYqVB4i8wQ4+/8DZLFLbVPaUuRco5VjHGFNJNXa5DXonZpUETa19BhW71d/Yxw0oh3H10QTvLCC1NE8hhF6fvwbLyHaK7+075aHiyM0cZ9b/evLptSdcotWd4sfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953414; c=relaxed/simple;
	bh=BHxKfe7cwR5dwKO9e3Otil+dngQy74VkLkbWJ+gQaeA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K2/Q/ivTUNpoOXhrbEp5YmHcBrKGvFPlZJR10Jg58JbgHHfq+ZBdKACogzaeoThWY/ihSGE9qtXNPXs+oAu4mRCIQAloaAZfS7MZdvKDZ1BAO02bPW6eblN//3jabq/HouGBWEjlzgWbryFxNFABLXFSwXQMvKxlqfrOaGwfioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPW8Bl0z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727953414; x=1759489414;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BHxKfe7cwR5dwKO9e3Otil+dngQy74VkLkbWJ+gQaeA=;
  b=YPW8Bl0zxKI8za1Kdew3nVlaUezrlpq1QwLqly4rFqeCw+1st2p+Fg0H
   1nFRE7t9LkUnHlm436Vz5PZNLGAy2Qz+IjWqbBUEqNNIzE+vjlhToZ4vz
   eiby6j/e4EkcSogJptK+Q8C31yOH4FePcBVLypun6hiHltZ1lR8oD5xeN
   uFpHKmPLL6wgo62ZUkdWDKJ3wl1wvFcJ14zXHRJwRI/kbepx+Ab+e6bVU
   LXWPTIY0DeyOYLfZ91FVO2a48SOM8RhLF67jeI8vlFx43dWGGz9EaHr8P
   R1k3V/yNPV51RfHoMYSUhmn30oQqOSqyDvuyUHEh1i/j+eOBdOolgoT+e
   Q==;
X-CSE-ConnectionGUID: tMXknGnhSBadwC7Pi044rA==
X-CSE-MsgGUID: hIr5MRKZQVyOfXtVEm1KTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37700196"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="37700196"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 04:03:33 -0700
X-CSE-ConnectionGUID: B+UNORwcQfmYK5Pgts6f+w==
X-CSE-MsgGUID: wKG45aIRTLiVUETH2FIG6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="97644287"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.198])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 04:03:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Oct 2024 14:03:25 +0300 (EEST)
To: "Wang, Crag" <Crag.Wang@dell.com>
cc: "Tudor, Laurentiu" <Laurentiu.Tudor1@dell.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Crag Wang <crag0715@gmail.com>, "Ksr, Prasanth" <Prasanth.Ksr@dell.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Dell Client Kernel <Dell.Client.Kernel@dell.com>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "Wang, Berry" <Berry.Wang@dell.com>
Subject: RE: [PATCHv2 1/1] platform/x86: dell-sysman: add support for alienware
 products
In-Reply-To: <PH0PR19MB49884B9347569041F4EE234BE3682@PH0PR19MB4988.namprd19.prod.outlook.com>
Message-ID: <7ec1d352-4059-e5f8-3ff4-ecc5737d8a6b@linux.intel.com>
References: <20240923063658.411071-1-crag_wang@dell.com> <20240924050302.317522-2-crag_wang@dell.com> <0a31cb22-e3f9-4212-8fc1-77d6cafa7277@amd.com> <CY5PR19MB61479854D62CAD389C99BA15BA682@CY5PR19MB6147.namprd19.prod.outlook.com>
 <PH0PR19MB49884B9347569041F4EE234BE3682@PH0PR19MB4988.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Sep 2024, Wang, Crag wrote:

> > Couple of newbie questions: what's the reason for dropping the URL check?
> > Would it make sense to include the reason in the commit msg?
> 
> URL in type 11 is subject to change according to OEM ID Module specification, for
> standard Dell and OEM inclusive the string 'Dell System' should be sufficient.

Please add such information into the commit message so it gets properly 
recorded. But I'd prefer this to be split into two patches, one adding 
the Alienware and another that removes the URL making it easier to revert 
only the latter one if the need arises.

-- 
 i.

> Internal Use - Confidential



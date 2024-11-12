Return-Path: <linux-kernel+bounces-405711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1638C9C561F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565F628BD08
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE93215024;
	Tue, 12 Nov 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9pxJ9QF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A5721500E;
	Tue, 12 Nov 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408791; cv=none; b=oy5murQohqttQ2cbg8hSLErvH5ps99i+26s5m8P7+HGDaijiw2jYz/00c5JZeyoYvJMlFHqTFc41WrPkS2UVLSUlCQNWaqX8JfJPIZTr9qtNRUpDgdj5FZV/E3Q1UKCwAtnDY9TJl2/sg+id/7VQn/zr8IOMkC0zWOcQnw3gJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408791; c=relaxed/simple;
	bh=zk9uoUATqBztSiZioDYQTllfrwom4kqmG9YRYeTrtn4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AduGd3h8rFsYV5Fo5nTWB8Yc3APYfv4BQ/1hH7ZICJnW7A4nZ7TTIalsqb68rfQ9vOYD0gLyiqACaUk3Y6FClJpsoOFc+a5jPsXfBM6CRKcF/zhtPPto3F97hkZP5lPtZcOG/O0RItfSuROClJsh1CWKjN8/YNGbFUWH7NenlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9pxJ9QF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731408791; x=1762944791;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zk9uoUATqBztSiZioDYQTllfrwom4kqmG9YRYeTrtn4=;
  b=g9pxJ9QFmBmxo/7pPkLgF0RZnqDljep7uPZKWJNHi9X1ulH15f4tJj2B
   UgsRU2Q0phDc5m4IKae2MfArjdZgjfb8f4DYxRXX/l8xdsTG4NT2oH7f6
   hzLE43VJunXZDSd75ulMwH4BhmB+sc1Hea0SVRNwhHAwbp5fAjjNV57/1
   wpaoHJ7yyX2LNpDQStwnmNHgm+MvJpuuJbNg31KoaMPlW2tXAy4YtzRS0
   oozRsd/BY9aLdPM8F/hkiwx0wJaRY6BA9p83m6hOdCP+875ElYDCZof1q
   XoRgfEqY0mQU1kMKmQrw+yZSkrLuIq6HuiC8FbmTgVSqmw1GyqC/P2hZK
   Q==;
X-CSE-ConnectionGUID: RJEiKgaZSqyIY81eh7XzrQ==
X-CSE-MsgGUID: m67535ZMTL+0CJGPpIic9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="31331637"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="31331637"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:53:10 -0800
X-CSE-ConnectionGUID: uIiVoiGAQ3KYZ2la16r1Iw==
X-CSE-MsgGUID: iZOPZm86TJWvpgZ6xBz0wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="91893465"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:53:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Nov 2024 12:53:04 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: w_armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Dell.Client.Kernel@dell.com
Subject: Re: [PATCH 0/5] Better thermal mode probing + support for 9 models
In-Reply-To: <20241111183308.14081-3-kuurtb@gmail.com>
Message-ID: <072a65e7-b405-48e3-3923-5435c6889734@linux.intel.com>
References: <20241111183308.14081-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-141258059-1731408784=:961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-141258059-1731408784=:961
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Nov 2024, Kurt Borja wrote:

> Hi!
>=20
> I added models for all the acpidumps I could find. Also I find a way to
> not brute force create_thermal_profile and that's always a good thing.
>=20
> I hope you all have a great week!
>=20
> Kurt Borja (5):
>   alienware-wmi: order alienware_quirks[] alphabetically
>   alienware-wmi: extends the list of supported models
>   alienware-wmi: Adds support to Alienware x17 R2
>   alienware-wmi: create_thermal_profile no longer brute-forces IDs
>   Documentation: alienware-wmi: Describe THERMAL_INFORMATION operation
>     0x02
>=20
>  Documentation/wmi/devices/alienware-wmi.rst |  12 +-
>  drivers/platform/x86/dell/alienware-wmi.c   | 150 ++++++++++++++++----
>  2 files changed, 136 insertions(+), 26 deletions(-)

Looks nice. For the entire series,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-141258059-1731408784=:961--


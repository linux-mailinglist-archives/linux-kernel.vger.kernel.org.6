Return-Path: <linux-kernel+bounces-216952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466090A909
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9219286263
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870619067E;
	Mon, 17 Jun 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6T3R6Yo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E0374D9;
	Mon, 17 Jun 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615208; cv=none; b=EEET0+eIN5zTKAQeyWUipfN/AASfcvPumgIsINXD7YzYL+u8y49y8fwawDANmjQYyfjdSl5oogZ3P6wxU7PSk5+itgKIJCF//7nIyHwuTJ90nVnxAcUrhpZb0vpjGYjm8xyRcrkKnaw3/6AbYWPTc0g4VN4PzjCvMXWccUbgU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615208; c=relaxed/simple;
	bh=CurM/NrcmpXdr/4ms/NPV8dFAF1+JdNNE86NGWrSYmo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8jHFxpHdFUEmR/HoUiTwKefkYnA7t3WvCJsWkHuACw42BhScGp3UYbPRAlcIldua1kw6EXklA9Sk1TBa3Lug0Wmd274foh+TFJpbh9sQTvMw1Mi+ny9lxKMXU2MlepBjRocMlRGDn7WPoA3josFV/sQ0ltVhSi6NzUirryU/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6T3R6Yo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718615207; x=1750151207;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CurM/NrcmpXdr/4ms/NPV8dFAF1+JdNNE86NGWrSYmo=;
  b=Z6T3R6YoufdpH27vFCJylNggSNyYIpSRzcz38xO86yqOF3v9bpm8lqTn
   DzF2X6ug8Xta1SDxx1ZubZ3NbqMtXO7np9OJPXBr5X1cm0196LWJC2Ph6
   l4Lxvr3xArfsIDf1+zs38TMPuLC6J7hTK9gz3qIrmrX9wG64DwrSKYnHC
   pAoo4PBLZt0Owj633YIPn+VMxx1WWhqZU0u1qPMZkwBTyp/FXLMszCZz0
   07E5OP7QKXin1bbA4cMOILIQlGYsZPYvDs3R07n1ThQBHCIVefU2zkcst
   +2xnNFBCyB6meRY1ITeteTxQgpCvFdSo6t25PEzOpZOtIJHMvynMDzBmq
   Q==;
X-CSE-ConnectionGUID: ib6MDXizQQSofUdaGAVmtw==
X-CSE-MsgGUID: bT1rvJNFRI+0QWWFONv21A==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15268987"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15268987"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:06:47 -0700
X-CSE-ConnectionGUID: +lHs/llcRum3KYa+3szbbg==
X-CSE-MsgGUID: CgaJisbJR0qnu2tVgJ6jkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="45584975"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:06:46 -0700
Message-ID: <4a6888aa8e4c6e49e094b4340ecdbfe6c4934b95.camel@linux.intel.com>
Subject: Re: [PATCH 0/7] platform/x86/inte-uncore-freq: Cleanups
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Tero Kristo <tero.kristo@linux.intel.com>, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date: Mon, 17 Jun 2024 02:06:45 -0700
In-Reply-To: <20240617060708.892981-1-tero.kristo@linux.intel.com>
References: <20240617060708.892981-1-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 09:04 +0300, Tero Kristo wrote:
> Hi,
>=20
> This series introduces some cleanups for the code and driver level
> APIs.
> The purpose is to improve the maintainability of the code and make it
> easier to add new features in future.
>=20
> No functional changes expected from any of the patches in this
> series.

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas

>=20

> -Tero
>=20



Return-Path: <linux-kernel+bounces-386931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA79B49DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924711F22EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C01DE3B7;
	Tue, 29 Oct 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ho32hmAa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EED7E1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205610; cv=none; b=Vi1ScoSiXkFKtM3jvaqUeK8ji9zO35jo/YKSNS6qyD64Gi0SHoPfjBtz8iktSzQrxEE6w+F61Dd8+760/mMM6Azpgj6Ejq7XcfiO/inLpq19ZJ+o2vnMaNLA9p1CwvkAViQ1YebsSrKYmeTAUp0ORiGUvKutZbC/uh6NP8yiCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205610; c=relaxed/simple;
	bh=OZowyhBXQBx3DewJlYg3vuEIcw8DCCfPHbLJC7jU3uY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hm2Xj3HOAJOUa7qFeH+C6PXrj11/YeUmzW8jysO4XgUIxCXNxD9dFoxJv5GkLV/lrDIDMZE/ChO+LAJ5LXCGmdim7aXdBsg2MODPPnxgbsrPQdkSTgYdaNr7GsQ+A2Xd3N7KV+bCFuDqrLUCAsxzF3cSXn4ZiDiOsFwvtKf+JmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ho32hmAa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730205609; x=1761741609;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OZowyhBXQBx3DewJlYg3vuEIcw8DCCfPHbLJC7jU3uY=;
  b=ho32hmAaoiolTj+ZRTur0PpFCDubparVp50LteMtC/PEU8ajSSQD22sa
   TDs7Rv+VdWBm9G/ob82YF8to81fue/CkKcQLeht47GFA1SkTUeYUBTSUC
   312R9cjvdgER3qW/oBhpMhJwE7Ijq2ZRJFkBbbDRG/H8pKefEBJHoFmsB
   MMES9nvSpE1pFDmMfF6LVOE5a1P8EUI8dHCb3HENvFoPNxJU2AI0avzQb
   ilt/P2fSQhoXkptN5RUmTWpRnZObpw2LonaUPzm+5igF7ja87xq7rnwXY
   ++t9VD2kEa5TGQF5/vWfYARpHRg1pI8ePInbfp+Tys/6VHhCHB2xIkHaw
   Q==;
X-CSE-ConnectionGUID: 9zQaKjPVR6O3/hujH2Ec6g==
X-CSE-MsgGUID: m7CaIOxMSY2JOzdFRzaOWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29617406"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29617406"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:40:08 -0700
X-CSE-ConnectionGUID: VkMkTkbXRliPQUrEmSf04A==
X-CSE-MsgGUID: O4vOmEpgRh2zPaQ1NXBmtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="112752026"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:40:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 14:40:00 +0200 (EET)
To: Borislav Petkov <bp@alien8.de>
cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Yazen Ghannam <yazen.ghannam@amd.com>, 
    Suma Hegde <suma.hegde@amd.com>, 
    Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without
 CONFiG_AMD_NB
In-Reply-To: <20241029110641.GFZyDBwa2o1a13Bt-T@fat_crate.local>
Message-ID: <df0cb5c7-71ef-03ab-b0f5-7c95a4065ed4@linux.intel.com>
References: <20241029092329.3857004-1-arnd@kernel.org> <20241029103316.GBZyC57KGSxyPie3Qu@fat_crate.local> <3a5360a4-e5c7-4c97-ab15-778d73f5b5a6@app.fastmail.com> <20241029110641.GFZyDBwa2o1a13Bt-T@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 29 Oct 2024, Borislav Petkov wrote:

> On Tue, Oct 29, 2024 at 10:56:12AM +0000, Arnd Bergmann wrote:
> > That would work, or Ilpo can pick it into the tree that
> > has the driver changes, possibly folding the fix into the
> > other changes.
> 
> Right, while it shouldn't be a problem, I'd like to keep all amd_nb changes in
> one tree because we have stuff in-flight touching and changing exactly that
> area so...

Hi Boris,

I'm unfortunately left a bit unsure what exactly is your suggestion here, 
so could you please elaborate?

(I'm assuming the big amd_nb series will go through the x86 tree.)

Thanks in advance.

-- 
 i.



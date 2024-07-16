Return-Path: <linux-kernel+bounces-254010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF15932A20
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42F328853D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E1219DF8D;
	Tue, 16 Jul 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRWSA3Lv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1554BD4;
	Tue, 16 Jul 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142715; cv=none; b=SC0/nZ4vn5szwAhqaVFbSfVxPZ2mf4bQ4i2OBmhr94ZVsi6DILKcfVXNJUdu9kqXxj1PH67gYEakfrrAN+1hr/1t9Ot69kB4Uw5tnpYJzPQ4diDA/f1ttccrjzILeDmnpeelJdib5UofZYRQpF9SHWMKKs0dmXKGYSTgM+BmRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142715; c=relaxed/simple;
	bh=PhD4NmZQezw0hWCfRGHhs0Sd0Ldr1EdOgiNxKCNQl6k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=se0Dp5hjhE5Z1Tk8PcGTn41vOZ79824cebuIahxLVmMx6IGbmlX5NNvITYyADAHoyNT1IC0iD64RX01cJr1ekKpPvDbp5AmpJzLTBPDdTApMF7QK4OuePq/fuVekpgA10ScRWm+xubjxotHbcYUgLWZvHprysvEe0EqBtHTMzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRWSA3Lv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721142713; x=1752678713;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PhD4NmZQezw0hWCfRGHhs0Sd0Ldr1EdOgiNxKCNQl6k=;
  b=eRWSA3Lv4YatGJvPbF9A5qkC/oZV5ayIJQ2qIMtyNBKvOK4o7tKOpQt+
   fvK4JGC9hM9PZbE6QcRu3HnswIN+dqK9zffa93tHAT7y5bU4VG9Xi9BC7
   5HYEc/9ukcr1OgUehb/AnJea1N4FBMktjMq+ks2bCAlkjYp3h0u1LNJXr
   7HWfSGWtNCVnCoSrrgdRLyW1X3rvC6rWJA5dqHW8zcrYcqUvzovogPvdf
   Lzh7aqgv1G3/8+dO2IFZhM5Cs/ojg723gIUWXiijZFgLMRQlffr86VGjv
   RsQk50ObSGnig9WVyxLq4pLzEbwPfINEXit7tpbWOFYlwYJqLapDWAiOf
   g==;
X-CSE-ConnectionGUID: UxoU6gvrRlGl9rNYDFdWnQ==
X-CSE-MsgGUID: SX4ZlTmASUOy53GWt0pb3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18783887"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18783887"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 08:11:52 -0700
X-CSE-ConnectionGUID: 8IzsLuEmQ0KZPB6PrbPCfw==
X-CSE-MsgGUID: WeQpMnyqQtO6GKo5jiGK5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="50124449"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.133])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 08:11:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Jul 2024 18:11:46 +0300 (EEST)
To: Hans de Goede <hdegoede@redhat.com>
cc: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org, 
    corentin.chary@gmail.com, mario.limonciello@amd.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] platform/x86: introduce asus-bioscfg
In-Reply-To: <8273ed57-4c65-41da-ad7d-907acf168c07@redhat.com>
Message-ID: <e9f4fb37-5277-a7f0-2bec-8a6909b4e674@linux.intel.com>
References: <20240716051612.64842-1-luke@ljones.dev> <8273ed57-4c65-41da-ad7d-907acf168c07@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Jul 2024, Hans de Goede wrote:
> On 7/16/24 7:16 AM, Luke D. Jones wrote:
> > This is the first major patch I've ever done with the intention of
> > introducing a new module, so it's highly likely I've made some mistakes
> > or misunderstood something.
> > 
> > TL;DR:
> > 1. introduce new module to contain bios attributes, using fw_attributes_class
> > 2. deprecate all possible attributes from asus-wmi that were added ad-hoc
> > 3. remove those in the next LTS cycle
> > 
> > The idea for this originates from a conversation with Mario Limonciello
> > https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
> > 
> > It is without a doubt much cleaner to use, easier to discover, and the
> > API is well defined as opposed to the random clutter of attributes I had
> > been placing in the platform sysfs.
> 
> This is a bit of a novel use of the fw_attributes_class and I'm not
> entirely sure of what to think of this.
> 
> The fw_attributes_class API was designed for (mostly enterprise)
> x86 machines where it is possible to change all BIOS settings directly
> from the OS without entering the BIOS.
> 
> Here some ACPI or WMI function is present to actually enumerate all
> the BIOS options (which can be set this way) and get there type.
> 
> IOW there is not a static list of options inside the driver, nor
> is there special handling in the driver other then handling differences
> per type.
> 
> And if a new BIOS version has new options or a different machine model
> has different options then these are discovered automatically.
> 
> This new use is quite different from this. Although I do see that
> at least for the attributes using WMI_STORE_INT() + WMI_SHOW_INT()
> that there is quite some commonality between some of the attributes.
> 
> I see how using the existing firmware-attributes class API definition
> for this, including allow tweaking this with some of the fwupd
> firmware-attributes class commandline util work Mario did is a useful
> thing to have.
> 
> I guess using the firmware-attributes class for this is ok, but
> this _must_ not be named bioscfg, since the existing hp-bioscfg
> driver is a "classic" firmware-attributes drivers enumerating all
> the options through BIOS provided enumeration functions and I want
> the name to make it clear that this is not that. And the Dell
> implementation is called dell-wmi-sysman so lets also avoid sysman
> as name.
> 
> Maybe call it "asus-bios-tunables" ?   And then if Asus actually
> implements some more classic firmware-attributes enumerable interface
> we can use "asus-bioscfg" for that.
> 
> Mario, Ilpo what is your opinion on this ?

What you suggested sounds good to me.

-- 
 i.



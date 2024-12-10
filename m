Return-Path: <linux-kernel+bounces-439767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9129EB3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5009167227
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBA81B4236;
	Tue, 10 Dec 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuLZ259A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DCA1B0F12;
	Tue, 10 Dec 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841842; cv=none; b=mTtiSSGIXa+sEaPDIAJvvZMdNCfPZL7Z4dxUj8/aE4twuzjrYcsabN5O/+KaCquibvxLnUtMbYTAMWq0zd7iNpp616smrQZuw2se5TzeZ3fiKaryxj2P70czGXjSglJAqAOsh9AlO606eNbXKedoA42oaEZPhhDP4GpCEoZgC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841842; c=relaxed/simple;
	bh=85lxPveoF0Og5zEC+Yhbca7k7ks3rwCrZuV7a31bcVU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Vvt//0ioluU1BPQ6zizhHN62fDGIe+tn5/X6L4F8S7mrfBcMM/bMdwPo8UXAxjLqeYels+ty6UQKqmc/pHYnY/kS85IW+cGY4wmRx27d8LgoAgBohDBps7LpJaGDvDvIfG7ysWFqb+XvW2QUuolERMr28VTPRF7sgepzndCfWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuLZ259A; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733841841; x=1765377841;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=85lxPveoF0Og5zEC+Yhbca7k7ks3rwCrZuV7a31bcVU=;
  b=nuLZ259AAkP8vW58lELP3ICJhpsC3syjjD2k/oFKXAoOegM5Z2S/65/A
   jdeZqC7Ol/rym++fKrKXsBmaSWjnn8uAGUwU/SYutL24XqhTn5FSDUbs+
   Vfm6B4FP3bpcJ8+79Ty4uHpUHpVp/asKId76LOEUNKs2nz3LrpFg3eK7H
   gR3zLqCOeHk5f4stYIL3OihlTJFDTb6Iuwi9irB15Zcz9M8uPeKjsCDnA
   7gIjENxCx3SkXAxpv/igwfwvPD/ihCpnRwTyNA1769UHKBBGy8S6BG0H/
   wUZgGeCfY1Q1OrD98pORkFo0GJ1yaU+phLmNHIGkYkiZ1xSgvkBe16FFU
   g==;
X-CSE-ConnectionGUID: hrQ8ZfhYQIC69GB1rBfrKQ==
X-CSE-MsgGUID: P0tSyA3JT2W+9/sN+oYSMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="56669401"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="56669401"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:44:01 -0800
X-CSE-ConnectionGUID: 5HwIY5WuQ1GbhafZ+selrw==
X-CSE-MsgGUID: hCcNcgEgTgK59Ypg+kbNng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100485570"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:43:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Dec 2024 16:43:53 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Kurt Borja <kuurtb@gmail.com>, jlee@suse.com, farhan.anwar8@gmail.com, 
    rayanmargham4@gmail.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] platform/x86: acer-wmi: Ignore AC events
In-Reply-To: <2f695131-b875-4856-9782-c3d4231adc8b@gmx.de>
Message-ID: <01cec6cc-bfed-39e0-acf3-4973ba833881@linux.intel.com>
References: <20241210001657.3362-1-W_Armin@gmx.de> <20241210001657.3362-6-W_Armin@gmx.de> <jxqp276qrzg32zvm4zmyzq6qzru2ex4fbgyogj4ynvetf6j5gp@kxocmd2ky6dv> <2f695131-b875-4856-9782-c3d4231adc8b@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2102736852-1733841833=:905"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2102736852-1733841833=:905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 10 Dec 2024, Armin Wolf wrote:

> Am 10.12.24 um 03:16 schrieb Kurt Borja:
>=20
> > On Tue, Dec 10, 2024 at 01:16:57AM +0100, Armin Wolf wrote:
> > > On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
> > > AC connect/disconnect. Ignore those events to avoid spamming the
> > > kernel log with error messages.
> > I noticed acer_thermal_profile_change() behavior changed whether the
> > laptop was on AC or not. Maybe users expect some kind of behavior aroun=
d
> > thermal profiles with this event? Like switching to low-power when not
> > on AC or something like that.
> >=20
> > ~ Kurt
>=20
> Good question, i will ask the person with the Acer notebook to test if th=
e
> platform
> profile changes automatically when switching to AC.
>=20
> The other however patches can be taken regardless of this patch.

I took patches now 1-4 but left the 5th for now.

--=20
 i.

> Thanks,
> Armin Wolf
>=20
> > > Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
> > > Closes:
> > > https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b8-1=
20c8e7afec8@gmail.com
> > > Tested-by: Rayan Margham <rayanmargham4@gmail.com>
> > > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   drivers/platform/x86/acer-wmi.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/drivers/platform/x86/acer-wmi.c
> > > b/drivers/platform/x86/acer-wmi.c
> > > index aad8eb0ddae5..ef26ec8d90ea 100644
> > > --- a/drivers/platform/x86/acer-wmi.c
> > > +++ b/drivers/platform/x86/acer-wmi.c
> > > @@ -99,6 +99,7 @@ enum acer_wmi_event_ids {
> > >   =09WMID_HOTKEY_EVENT =3D 0x1,
> > >   =09WMID_ACCEL_OR_KBD_DOCK_EVENT =3D 0x5,
> > >   =09WMID_GAMING_TURBO_KEY_EVENT =3D 0x7,
> > > +=09WMID_AC_EVENT =3D 0x8,
> > >   };
> > >=20
> > >   enum acer_wmi_predator_v4_sys_info_command {
> > > @@ -2304,6 +2305,9 @@ static void acer_wmi_notify(union acpi_object *=
obj,
> > > void *context)
> > >   =09=09if (return_value.key_num =3D=3D 0x5 &&
> > > has_cap(ACER_CAP_PLATFORM_PROFILE))
> > >   =09=09=09acer_thermal_profile_change();
> > >   =09=09break;
> > > +=09case WMID_AC_EVENT:
> > > +=09=09/* We ignore AC events here */
> > > +=09=09break;
> > >   =09default:
> > >   =09=09pr_warn("Unknown function number - %d - %d\n",
> > >   =09=09=09return_value.function, return_value.key_num);
> > > --
> > > 2.39.5
> > >=20
>=20
--8323328-2102736852-1733841833=:905--


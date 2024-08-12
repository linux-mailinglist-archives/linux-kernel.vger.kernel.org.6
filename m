Return-Path: <linux-kernel+bounces-282725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA0C94E7F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994D6B2398A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB115C129;
	Mon, 12 Aug 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8xdQljV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CCE1474D3;
	Mon, 12 Aug 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448394; cv=none; b=Y1j/kcizzGQSabVdcVQtoadKb/QgBDXxkwBEMcLddFpp11mDZXJrKqmfkvpyVkxchLyNUXNp2xTllL8PjzkkbFg3eS2GRwdR8WrLT+5xaYxnC8he5JdE1K9eAd/veZCNBRjEYWkDvz9r5LrzuyAWfc+/UbXBlmUENDGQPyrG1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448394; c=relaxed/simple;
	bh=oU11PdIre5arnF8MGb073WE4WSJr4KFuJCxaMI+iV1A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jt7s+VPbmToB5IcEhG1C5ka3Jj+80P8Ul4ZNWodeQLAuY16kav8ARol1O0JdRBdwJFJhE9cEZV7/eym4rOO77d5DQk2sex92SS4zTVzRoMsLt2w+p0Hf0NclktZ0GM7+ruIUxAyryz/11z6VOdK3PBNvF6MureO5D32AgfkfvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8xdQljV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723448394; x=1754984394;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oU11PdIre5arnF8MGb073WE4WSJr4KFuJCxaMI+iV1A=;
  b=K8xdQljVnOhZfh7XfOpMMDNgx8KpR2Ve3DdcOy26bm1MyR5uJYxSOm7k
   iwHoBH9sxUZ2V6VKauSofOMc1i1h3AtrYFrgJsrywFg6RBO2LMxCT/rwS
   iOMy71HDkw96Ebzc4YulfRJq+n93Ijrfetn26dEFjQDijSoE/GWHXjChA
   mzhmAzXYEkrwC9N6oQ0t6+8n/a51SqWvi96XpOyJsh4Z2ezndhDhIpYpb
   eYlyaMXHBVlIIPpeRBq7QV/vZSr2K0hbZ9Rf7www3rIKxCVfCpn70pTVE
   YVKgRP5GATE3KSoobPWhauIv9TQcPTliFyHMTvjCfUl9J2pNXj4hsESWr
   w==;
X-CSE-ConnectionGUID: qGti/0wwTU262hyREDivgQ==
X-CSE-MsgGUID: Zr4oDnLLRTWa2qe3LIrvwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32935836"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32935836"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:39:53 -0700
X-CSE-ConnectionGUID: Uc8fu43mQYuNJNob2KQKkw==
X-CSE-MsgGUID: kIubpFpJScmYB6YLzEOhlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="89016132"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:39:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 10:39:47 +0300 (EEST)
To: Luke Jones <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com
Subject: Re: [PATCH v2 4/6] platform/x86: asus-armoury: add apu-mem control
 support
In-Reply-To: <d3577748-14b6-4aa4-9f51-069ae9ccff49@app.fastmail.com>
Message-ID: <a663ee3e-1c8b-5e7d-503f-e46641039f16@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev> <20240806020747.365042-5-luke@ljones.dev> <c7080912-7772-96df-0ae0-07903edbba1a@linux.intel.com> <d3577748-14b6-4aa4-9f51-069ae9ccff49@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1776797564-1723448387=:1039"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1776797564-1723448387=:1039
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 11 Aug 2024, Luke Jones wrote:

> On Tue, 6 Aug 2024, at 10:20 PM, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 6 Aug 2024, Luke D. Jones wrote:
> >=20
> > > Implement the APU memory size control under the asus-armoury module u=
sing
> > > the fw_attributes class.
> > >=20
> > > This allows the APU allocated memory size to be adjusted depending on
> > > the users priority. A reboot is required after change.
> > >=20
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > ---

> > > + sysfs_notify(kobj, NULL, attr->attr.name);
> > > +
> > > + asus_set_reboot_and_signal_event();
> > > +
> > > + return count;
> > > +}
> > > +
> > > +static ssize_t apu_mem_possible_values_show(struct kobject *kobj,
> > > + struct kobj_attribute *attr, char *buf)
> > > +{
> > > + return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");
>=20
> Ack all
>=20
> > IIRC, space or newline is the usual separator for possible values sysfs=
=20
> > files. I don't think I've ever seen ; used.
>=20
> The docs specify this format. https://github.com/torvalds/linux/blob/5189=
dafa4cf950e675f02ee04b577dfbbad0d9b1/Documentation/ABI/testing/sysfs-class-=
firmware-attributes#L56

Okay, I didn't know. Please use what's documented then.

--=20
 i.

--8323328-1776797564-1723448387=:1039--


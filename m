Return-Path: <linux-kernel+bounces-313266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA796A2B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1829D1F294A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7396918E367;
	Tue,  3 Sep 2024 15:29:07 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3D189533;
	Tue,  3 Sep 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377347; cv=none; b=dTUtNUn09Tx2pit/IuLj2dxCp68M/EM9iHSvsUj/w2MkPMVRae8tLh49Zear2LjyMU+V16NG6bG04ZeGjeWw1WnpVs6PxZg43DwAnBz17sbpf3K0m2OwfGYvqIaW3+9wZpEgal3n+y4IE4CACKamQkg/WVurPuqBg67+UE2zAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377347; c=relaxed/simple;
	bh=jkOz22QxNaB8pl8SUeaZCnrLem63e6bKQ1tsxM9C+uM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJl7ugjI6uLT7oHEMP1KrGsZLKri7I4Ly8EKXrishmBK9p66e4mpGy0RbLsA6rHHg1NVnK0xQ2q+/sn3LGlbSa0s4z8NqQ2zGEYHNIWq17qzw16pTA9D8wrHhOOlQWQ3FebCVCCsTXOYtv0GmqAItOtJI+Xt8y/9IUXZRfy1ZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b687c4.dsl.pool.telekom.hu [::ffff:81.182.135.196])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000076045.0000000066D72B3F.001E8F8A; Tue, 03 Sep 2024 17:29:02 +0200
Message-ID: <0e53a8b6eeb457f11a8a514b12c0598d1727b43d.camel@irl.hu>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
From: Gergo Koteles <soyer@irl.hu>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Hans de Goede <hdegoede@redhat.com>,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
  Ike Panhc <ike.pan@canonical.com>,
  Peter Zijlstra <peterz@infradead.org>,
  Josh Poimboeuf <jpoimboe@kernel.org>,
  Nathan Chancellor <nathan@kernel.org>,
  kernel test robot <lkp@intel.com>
Date: Tue, 03 Sep 2024 17:29:02 +0200
In-Reply-To: <Ztcn2Yu2TNSOYbhP@smile.fi.intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
	 <cf8c73dd91dbbb11b562a5e0d9ac6b4035c32d28.camel@irl.hu>
	 <Ztcn2Yu2TNSOYbhP@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-03 at 18:14 +0300, Andy Shevchenko wrote:
> On Tue, Sep 03, 2024 at 05:00:51PM +0200, Gergo Koteles wrote:
> > On Thu, 2024-08-29 at 19:50 +0300, Andy Shevchenko wrote:
> > > First of all, it's a bit counterintuitive to have something like
> > >=20
> > > 	int err;
> > > 	...
> > > 	scoped_guard(...)
> > > 		err =3D foo(...);
> > > 	if (err)
> > > 		return err;
> > >=20
> > > Second, with a particular kernel configuration and compiler version i=
n
> > > one of such cases the objtool is not happy:
> > >=20
> > >   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected=
 end of section
> > >=20
> > > I'm not an expert on all this, but the theory is that compiler and
> > > linker in this case can't understand that 'result' variable will be
> > > always initialized as long as no error has been returned. Assigning
> > > 'result' to a dummy value helps with this. Note, that fixing the
> > > scoped_guard() scope (as per above) does not make issue gone.
> > >=20
> > > That said, assign dummy value and make the scope_guard() clear of its=
 scope.
> > > For the sake of consistency do it in the entire file.
> > >=20
> >=20
> > Interestingly, if I open a scope manually and use the plain guard, the
> > warning disappears.
>=20
> Yes, that's what I also have, but I avoid that approach because in that c=
ase
> the printing will be done inside the lock, widening the critical section =
for
> no benefits.
>=20

This is intended to be an inner block scope within the function, it
does not expand the critical section.


> > 	...
> > 	unsigned long result;
> > 	int err;
> >=20
> > 	{
> > 		guard(mutex)(&priv->vpc_mutex);
> > 		err =3D read_ec_data(priv->adev->handle, VPCCMD_R_FAN,
> > &result);
> > 		if (err)
> > 			return err;
> > 	}
> > 	...
> >=20
> > This looks a bit strange, but is probably easier for the compiler than
> > the for loop of scoped_guard.
> >=20
> > But I don't know how well this style fits into the kernel.
>=20



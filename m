Return-Path: <linux-kernel+bounces-313182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E13196A196
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033C5286871
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6E187550;
	Tue,  3 Sep 2024 15:06:03 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A933186E51;
	Tue,  3 Sep 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375963; cv=none; b=FBnSgP2j0qkpDQzyY2WZ2x7Bd/NtpouYOiOz9rSacQpyV+AvFH2XhdLu4kKZITT/CIfYZ5jeIjaBft9v1RnXAZWMuso/DF2XHZjhlQkc9xv3/SSqks7oA598CazZ21cecMDi5WozoFFhQ4HrOIK0/gQsbLQVJLpB180DquNUWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375963; c=relaxed/simple;
	bh=Za5OvjXDVHbXWWe2B5O1GEiRe7xMQzAUlxeC123sewU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRcRn6PQEsk3Q0GOQlVdC+wQfkzZcFsB2qYnEYeqkOiC69ZvaYILc5DwjdX1yK5Ycng+v3hZ3wl00Fg5Z4WIV8/sX3aF0AOLwzJqAHo8c8SQ/Sl3F1/0C2fzATp12cWcm7U7n+y3aCNW9Uf9x3QtogxJf62/pRmHenwdcNQJ5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b687c4.unconfigured.pool.telekom.hu [::ffff:81.182.135.196])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000076028.0000000066D724A4.001E8EC5; Tue, 03 Sep 2024 17:00:52 +0200
Message-ID: <cf8c73dd91dbbb11b562a5e0d9ac6b4035c32d28.camel@irl.hu>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
From: Gergo Koteles <soyer@irl.hu>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
  Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Hans de Goede <hdegoede@redhat.com>,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ike Panhc <ike.pan@canonical.com>,
  Peter Zijlstra <peterz@infradead.org>,
  Josh Poimboeuf <jpoimboe@kernel.org>,
  Nathan Chancellor <nathan@kernel.org>,
  kernel test robot <lkp@intel.com>
Date: Tue, 03 Sep 2024 17:00:51 +0200
In-Reply-To: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andy,

Thank you for addressing this.

On Thu, 2024-08-29 at 19:50 +0300, Andy Shevchenko wrote:
> First of all, it's a bit counterintuitive to have something like
>=20
> 	int err;
> 	...
> 	scoped_guard(...)
> 		err =3D foo(...);
> 	if (err)
> 		return err;
>=20
> Second, with a particular kernel configuration and compiler version in
> one of such cases the objtool is not happy:
>=20
>   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end=
 of section
>=20
> I'm not an expert on all this, but the theory is that compiler and
> linker in this case can't understand that 'result' variable will be
> always initialized as long as no error has been returned. Assigning
> 'result' to a dummy value helps with this. Note, that fixing the
> scoped_guard() scope (as per above) does not make issue gone.
>=20
> That said, assign dummy value and make the scope_guard() clear of its sco=
pe.
> For the sake of consistency do it in the entire file.
>=20

Interestingly, if I open a scope manually and use the plain guard, the
warning disappears.

	...
	unsigned long result;
	int err;

	{
		guard(mutex)(&priv->vpc_mutex);
		err =3D read_ec_data(priv->adev->handle, VPCCMD_R_FAN,
&result);
		if (err)
			return err;
	}
	...

This looks a bit strange, but is probably easier for the compiler than
the for loop of scoped_guard.

But I don't know how well this style fits into the kernel.

Best regards,
Gergo Koteles



Return-Path: <linux-kernel+bounces-267829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC8941682
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3EB1C2358E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D931C9EB4;
	Tue, 30 Jul 2024 16:00:48 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934551C8FC8;
	Tue, 30 Jul 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355248; cv=none; b=BRpSfILHmeoiFvMPdF5PAEswuuTWMazTGUnSxpWUCYV/QKSosaryYpM8msQ/cEbySqQ0KB006Mh1+XFedeLmnnZs6KbrGX6M/9mz56rbUNBqkaJpGsQIAoCjXY7yRQD7oBLdorNZmEO8kDp5uForC+W9hasF5EFyqjsuBNRD67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355248; c=relaxed/simple;
	bh=R/UexHRtiPXFnBTxBurmQmt2xxtbeOUcRTCKQvCsLAc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sn7113jDpkhmjtnfh/4JA09688QT7bW4AGSid+EiLy3et9fPiNMOo3BVoWe6zeQ44ynft32gsdYKSFY5v8do+U9c8PyZFq+JI92mMj/SgeC/PQxaS92XDMkcgiponUMcRBRQ0C2ER1ed0QwxD4HZ7zwY6hnHcP14PlYWZVY5TDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69e67.dsl.pool.telekom.hu [::ffff:81.182.158.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007274B.0000000066A90E25.0019A1DC; Tue, 30 Jul 2024 18:00:37 +0200
Message-ID: <4eab134fc9b9a50c4f870f4d46ddc1415d5df465.camel@irl.hu>
Subject: Re: [PATCH v4 4/4] platform/x86: ideapad-laptop: add a mutex to
 synchronize VPC commands
From: Gergo Koteles <soyer@irl.hu>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
  Ike Panhc <ike.pan@canonical.com>,
  platform-driver-x86@vger.kernel.org,
  LKML <linux-kernel@vger.kernel.org>
Date: Tue, 30 Jul 2024 18:00:37 +0200
In-Reply-To: <29153152-79de-c637-eede-0b36ce4b5222@linux.intel.com>
References: <cover.1721898747.git.soyer@irl.hu>
	 <f26782fa1194ad11ed5d9ba121a804e59b58b026.1721898747.git.soyer@irl.hu>
	 <29153152-79de-c637-eede-0b36ce4b5222@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ilpo,

On Tue, 2024-07-30 at 16:37 +0300, Ilpo J=C3=A4rvinen wrote:
> On Thu, 25 Jul 2024, Gergo Koteles wrote:
>=20
> > Calling VPC commands consists of several VPCW and VPCR ACPI calls.
> > These calls and their results can get mixed up if they are called
> > simultaneously from different threads, like acpi notify handler,
> > sysfs, debugfs, notification chain.
> >=20
> > Add a mutex to synchronize VPC commands.
> >=20
> > Signed-off-by: Gergo Koteles <soyer@irl.hu>
>=20
> What commit does this fix? I was going to add a Fixes tag myself while=
=20
> applying this but wasn't sure if it should be the ACPI concurrency commit=
=20
> e2ffcda16290 or the change introducing lenovo-ymc driver?
>=20

YMC triggering works in 6.7, but not reliably in 6.8. So I assume the
culprit is e2ffcda16290.

But in theory debugfs, sysfs, acpi notify handler can race with each
other in the same way for 10+ years. Technically, probably not.

> Also, I'd prefer to not take the move patch (PATCH 3/4) now so I could=
=20
> take this through fixes branch since it causes a real issue if I remember=
=20
> the earlier discussions right? Do you think there's any issue if I take=
=20
> only patches 1, 2, and 4? They seemed to apply without conflicts when I=
=20
> tried to apply the entire series and then cherrypicked the last patch=20
> dropping the third patch.
>=20

Yes, this is a real issue.

You can skip the third patch. The series compiles and works fine
without it.

> The code movement patch could go through for-next fixes branch is then=
=20
> merged into it (or after one kernel cycle).
>=20
>=20

Fine.

Thanks,
Gergo



Return-Path: <linux-kernel+bounces-546729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5BBA4FE19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C9516FF36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115932417D8;
	Wed,  5 Mar 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Me3XjAeq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB61FDA97
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175848; cv=none; b=AK/KYHvSBtFBc59kl0R0qHZI9mVTH3xMNRaHYbKRcHSsY0Igs9rO4B1pHNf4HhIZxZTYXfEwITDOq9VNxm4q4d1rjT7LPcoijY+AN8OMMQecSDmOb/oOLzAd/GtElDuNRZ9UmdLJ4Q/jSsSeEMRY3mvgwKoVwjcMUt2Agkf5Sug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175848; c=relaxed/simple;
	bh=KUvTkzD8ZdVvFMlqnAmrsjZYnS0TavK1VWfGeCYlXFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EzeoBl31ixEoWXuia0uVzTWTmu05oqhjHeVzv4Nidbzqu7vd0JmR7lPi2ekcuPmLXFEs426KCu+EfMHfA3aXFbj5lkg5Wb0rn85CDpcpHKUD6P3iG9pwczJdZ195T3g6UJynhYnNgsO88iPAo8Ta6aIm7gcJ+gxKLtwRMzgRkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Me3XjAeq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741175847; x=1772711847;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=KUvTkzD8ZdVvFMlqnAmrsjZYnS0TavK1VWfGeCYlXFw=;
  b=Me3XjAeqGMB8q+cFmSQOh9QFztlFJQUNYbHnNvV/j3ai+Is8u6lMXNN4
   GGwXW/rliLd//XcmAZPYXl47hjT6fBsL+8LAwjP7SMQPseQtrYQC+ELWX
   z85ZfzBIGGw3HwMzXgp2cEt8WXsoC+McfOCaMkeO26wUbIXSmZ2fPwXEy
   Y1lSzFYIBxFT31uIO1RJUs23wvc/7R9riv4QS3ydagx1gDG5VKfj9aOJ5
   XJU80nhG+3nNT8wwPk/Dq5ugdaNmYC/Vzpdpp0chR3CE9X10wGYjhD2k5
   BdKqiHOHlNeXRql+HZt3H1S1uQF7DRkQGCnSiCQDvjaWB7fyNTkWebPsy
   A==;
X-CSE-ConnectionGUID: S0kvySVaQ1qRCP4uasut5Q==
X-CSE-MsgGUID: szS452vCT9Gb+Asl6/sF/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46060838"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="46060838"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 03:57:26 -0800
X-CSE-ConnectionGUID: TghoJe+CRSCXQvevc1s4bg==
X-CSE-MsgGUID: WQatGI/eRC6jtjchl6Mcjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123262532"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.49])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 03:57:22 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Avizrat, Yaron" <yaron.avizrat@intel.com>, Ofir Bitton
 <obitton@habana.ai>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "sfr@canb.auug.org.au"
 <sfr@canb.auug.org.au>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>, koby.elbaz@intel.com,
 konstantin.sinyuk@intel.com
Subject: Re: [PATCH 1/1] MAINTAINERS: Change habanalabs maintainer
In-Reply-To: <dc139f06-3f5a-4216-93c2-1e8b3b9c27ba@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240729121718.540489-1-obitton@habana.ai>
 <20240729121718.540489-2-obitton@habana.ai>
 <dc139f06-3f5a-4216-93c2-1e8b3b9c27ba@intel.com>
Date: Wed, 05 Mar 2025 13:57:19 +0200
Message-ID: <87cyevy9k0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 05 Mar 2025, "Avizrat, Yaron" <yaron.avizrat@intel.com> wrote:
> On 29/07/2024 15:17, Ofir Bitton wrote:
>> I will be leaving Intel soon, Yaron Avizrat will take the role
>> of habanalabs driver maintainer.
>>
>> Signed-off-by: Ofir Bitton <obitton@habana.ai>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ed2d2dbcec81..a4b36590061e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9599,7 +9599,7 @@ S:	Maintained
>>  F:	block/partitions/efi.*
>>=20=20
>>  HABANALABS PCI DRIVER
>> -M:	Ofir Bitton <obitton@habana.ai>
>> +M:	Yaron Avizrat <yaron.avizrat@intel.com>
>>  L:	dri-devel@lists.freedesktop.org
>>  S:	Supported
>>  C:	irc://irc.oftc.net/dri-devel
>
> Acked-by: Yaron Avizrat <yaron.avizrat@intel.com>
>
> Apologies for the long silence =E2=80=94 it=E2=80=99s been a challenging =
period with
> the Habanalabs-Intel merger, but we're back and ready to continue
> contributing.
>
> We'll be moving forward with our roadmap =E2=80=94 upstreaming the latest
> HabanaLabs driver, including recent changes and full support for the
> entire GaudiX series.
>
> To support this effort, Koby Elbaz and Konstantin Sinyuk will join me
> as co-maintainers on a regular basis.

Should they be added as maintainers in the MAINTAINERS entry too?

Are you going to pick this up and apply to the Habanalabs repo, and send
a pull request with it? Or how do you propose to proceed?


BR,
Jani.


--=20
Jani Nikula, Intel


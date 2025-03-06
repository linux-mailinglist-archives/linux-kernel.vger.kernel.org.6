Return-Path: <linux-kernel+bounces-549098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F4A54D24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4501895944
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303BF1547CA;
	Thu,  6 Mar 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqEG6RiQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E415383D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270337; cv=none; b=Q93Lu/4dsUrS0+dqR91nuKT0VS8gf+95FFGP30racKZHp/1PpNmmaNB3Pp3OZD6kG2wy2XUfPOENGXZu+89Q9ZDOvHq3lAMNGusTE/BDLSmuW4aHNth4cyFVaOB0sRGm+T90gT7I/bDUoOmyrx1KRnrqYV6soUvinjQ9J6lp0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270337; c=relaxed/simple;
	bh=uvthA8XmJqP8gVQqug7//D0qhv7CI6kWw6mhcSfz7dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QudeFxeo4rGim4fNeOPx2Y2wcu40M7f0rLp139O9toD7Q7wsahLwMhy9hvf0O2hltK6K14m8BdKC74+DlOnb9yMWy8HhFyR4MbORfk6owWIvT76eYjzGxmccqfy1ejip7ogek+L3Lqv2LTzyUSZm+mFFs5TT3gdlFKwikeNPlkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqEG6RiQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741270335; x=1772806335;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=uvthA8XmJqP8gVQqug7//D0qhv7CI6kWw6mhcSfz7dw=;
  b=VqEG6RiQMwy19HEZsg9L84mnsBle/M2S/l8a0kPLHgJV0NCQr583w3wz
   dvYfGHNZHeGiwAXMvhzIgTu8FRDX8TbBADYKIxyEhIXtS40HpJ9GPZRXs
   ammoEkpRlEJkukVRU6FZ7XLtuScICN+GfE19rY2/nOtqrvVGtdaF6YD86
   C+QB0v4XENTf5V3rN2DG9M7l+vIogcexqS9lUo1++TYDxg5hKevotRwhj
   RyVL55vwyi+eYnbcs4wPrOCaepiksaQn8cZrulMKZ3XBYuagwgPXIOpxd
   +k2yh3P0ivYzDjhxV0ZMsyoiTbU/LFHBNeIM0ZxMewHLSTnZt0G8CwRdw
   w==;
X-CSE-ConnectionGUID: 6S68PWrtRaS4wVLp7AJvwQ==
X-CSE-MsgGUID: H1Ne+2NtTRG2K3uDIF1HaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="59688349"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="59688349"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 06:12:14 -0800
X-CSE-ConnectionGUID: 66snu02YQ1C8Wh5LATTmWg==
X-CSE-MsgGUID: 8+HhNCdgRpqmGG7XsbJYXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="118763809"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 06:12:11 -0800
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
In-Reply-To: <f543ec81-1092-4700-b695-c4126f122444@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240729121718.540489-1-obitton@habana.ai>
 <20240729121718.540489-2-obitton@habana.ai>
 <dc139f06-3f5a-4216-93c2-1e8b3b9c27ba@intel.com>
 <87cyevy9k0.fsf@intel.com>
 <f543ec81-1092-4700-b695-c4126f122444@intel.com>
Date: Thu, 06 Mar 2025 16:12:08 +0200
Message-ID: <874j06w8nb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 06 Mar 2025, "Avizrat, Yaron" <yaron.avizrat@intel.com> wrote:
> On 05/03/2025 13:57, Jani Nikula wrote:
>> On Wed, 05 Mar 2025, "Avizrat, Yaron" <yaron.avizrat@intel.com> wrote:
>>> On 29/07/2024 15:17, Ofir Bitton wrote:
>>>> I will be leaving Intel soon, Yaron Avizrat will take the role
>>>> of habanalabs driver maintainer.
>>>>
>>>> Signed-off-by: Ofir Bitton <obitton@habana.ai>
>>>> ---
>>>>  MAINTAINERS | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index ed2d2dbcec81..a4b36590061e 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -9599,7 +9599,7 @@ S:	Maintained
>>>>  F:	block/partitions/efi.*
>>>>=20=20
>>>>  HABANALABS PCI DRIVER
>>>> -M:	Ofir Bitton <obitton@habana.ai>
>>>> +M:	Yaron Avizrat <yaron.avizrat@intel.com>
>>>>  L:	dri-devel@lists.freedesktop.org
>>>>  S:	Supported
>>>>  C:	irc://irc.oftc.net/dri-devel
>>> Acked-by: Yaron Avizrat <yaron.avizrat@intel.com>
>>>
>>> Apologies for the long silence =E2=80=94 it=E2=80=99s been a challengin=
g period with
>>> the Habanalabs-Intel merger, but we're back and ready to continue
>>> contributing.
>>>
>>> We'll be moving forward with our roadmap =E2=80=94 upstreaming the late=
st
>>> HabanaLabs driver, including recent changes and full support for the
>>> entire GaudiX series.
>>>
>>> To support this effort, Koby Elbaz and Konstantin Sinyuk will join me
>>> as co-maintainers on a regular basis.
>> Should they be added as maintainers in the MAINTAINERS entry too?
>>
>> Are you going to pick this up and apply to the Habanalabs repo, and send
>> a pull request with it? Or how do you propose to proceed?
>>
>>
>> BR,
>> Jani.
>>
>
> Yes, in a later patch, they would be added as maintainers in the MAINTAIN=
ERS entry too.
> Regarding your second question, we should start with merging Ofir's initi=
al patch.
> Any additional/upcoming changes will be initially merged into the officia=
l HabanaLabs repo as you mentioned above.

Acked-by: Jani Nikula <jani.nikula@intel.com>


--=20
Jani Nikula, Intel


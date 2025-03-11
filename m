Return-Path: <linux-kernel+bounces-555700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C790AA5BB91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F781896C07
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D422D7BE;
	Tue, 11 Mar 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXS83HOE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C71E8325
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683666; cv=none; b=iZX31y7h96oYK3KxCCJasOU3LBSXkUioCCAFmPIvq5evpgUZqh41JyNE4r+rgxQK4qXVHW2ehGqfYRaLujh+Jw80fY25Dnyk0wIm5FEhGBbJSLZlR5IPlb1Ko/Uov29ybIX+geVqQOx1wb5ncA6g34NSpIrW72osW5cUDb7NUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683666; c=relaxed/simple;
	bh=GzN/zJQLCijn273VjDtP477zTbCGzrLmSFpEiCk/eYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NkIB+7MUTEnheuomzRvjFUzJGEgtWYfCEW2tIC4sFLoQCxEdQ0gBoyRilOM8hdnRwW3Pm14BkhShus4ie8lKXw1cTXhrYag6zt9C/tA6ZgJgHzZxQtJNP9VSfULQMsZu//0LT3WGbcnPIjitr5dwSZ2NaKONSNNg5tAOctLHhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXS83HOE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741683665; x=1773219665;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=GzN/zJQLCijn273VjDtP477zTbCGzrLmSFpEiCk/eYw=;
  b=RXS83HOEWtKQ+0fvCUb2NTWDL0yOA1dNVpQU+8BQbZjLijlTSvxaQeIf
   AuZ+rDHv2zwzaOLiWcom4KXaU/GcfpItbENsu+yE4bJrbdHPxhs78Gk5Q
   O10HywnOXGMEFs4myoK5PBdtthlfW+3502F7ktcFFiC5eLS0l712PcDhJ
   2+zJzqvHy3whssqpmZAe4+HRyh6+tKOm0L/69G63Hjlftmd3csxfSmTK/
   C5d8h1F5XgITlWOvNIttDqYwglkBG8VPEXDQ6ekmH2MgfeCBSyCLhcVid
   sqwYmGz01ECyTXX+3TcKPwsjTWPKm6haXO4KJhQuSIoqyCN8a9J4IWoB4
   Q==;
X-CSE-ConnectionGUID: cjkHrVtbRA617c/CahHLrA==
X-CSE-MsgGUID: RAKPDwCoSzKSomfvS1Xetg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46358367"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="46358367"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:01:04 -0700
X-CSE-ConnectionGUID: GveN8dxsQFmv5qok75ijgQ==
X-CSE-MsgGUID: RQZDSH5tQViWEi591JPBlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="124427671"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.184])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:01:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Avizrat, Yaron" <yaron.avizrat@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>
Cc: Ofir Bitton <obitton@habana.ai>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "sfr@canb.auug.org.au"
 <sfr@canb.auug.org.au>, "jgg@nvidia.com" <jgg@nvidia.com>,
 koby.elbaz@intel.com, konstantin.sinyuk@intel.com
Subject: Re: [PATCH 1/1] MAINTAINERS: Change habanalabs maintainer
In-Reply-To: <be353276-3dce-49c1-8a35-164a33ddb9f9@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240729121718.540489-1-obitton@habana.ai>
 <20240729121718.540489-2-obitton@habana.ai>
 <dc139f06-3f5a-4216-93c2-1e8b3b9c27ba@intel.com>
 <87cyevy9k0.fsf@intel.com>
 <f543ec81-1092-4700-b695-c4126f122444@intel.com>
 <Z8q6pCmCnVCCvBJK@GABBAY.>
 <be353276-3dce-49c1-8a35-164a33ddb9f9@intel.com>
Date: Tue, 11 Mar 2025 11:00:57 +0200
Message-ID: <87bju8gcvq.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025, "Avizrat, Yaron" <yaron.avizrat@intel.com> wrote:
> On 07/03/2025 11:21, Oded Gabbay wrote:
>> On Thu, Mar 06, 2025 at 03:51:24PM +0200, Avizrat, Yaron wrote:
>>> On 05/03/2025 13:57, Jani Nikula wrote:
>>>> On Wed, 05 Mar 2025, "Avizrat, Yaron" <yaron.avizrat@intel.com> wrote:
>>>>> On 29/07/2024 15:17, Ofir Bitton wrote:
>>>>>> I will be leaving Intel soon, Yaron Avizrat will take the role
>>>>>> of habanalabs driver maintainer.
>>>>>>
>>>>>> Signed-off-by: Ofir Bitton <obitton@habana.ai>
>>>>>> ---
>>>>>>  MAINTAINERS | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index ed2d2dbcec81..a4b36590061e 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -9599,7 +9599,7 @@ S:	Maintained
>>>>>>  F:	block/partitions/efi.*
>>>>>>
>>>>>>  HABANALABS PCI DRIVER
>>>>>> -M:	Ofir Bitton <obitton@habana.ai>
>>>>>> +M:	Yaron Avizrat <yaron.avizrat@intel.com>
>>>>>>  L:	dri-devel@lists.freedesktop.org
>>>>>>  S:	Supported
>>>>>>  C:	irc://irc.oftc.net/dri-devel
>>>>> Acked-by: Yaron Avizrat <yaron.avizrat@intel.com>
>>>>>
>>>>> Apologies for the long silence =E2=80=94 it=E2=80=99s been a challeng=
ing period with
>>>>> the Habanalabs-Intel merger, but we're back and ready to continue
>>>>> contributing.
>>>>>
>>>>> We'll be moving forward with our roadmap =E2=80=94 upstreaming the la=
test
>>>>> HabanaLabs driver, including recent changes and full support for the
>>>>> entire GaudiX series.
>>>>>
>>>>> To support this effort, Koby Elbaz and Konstantin Sinyuk will join me
>>>>> as co-maintainers on a regular basis.
>>>> Should they be added as maintainers in the MAINTAINERS entry too?
>>>>
>>>> Are you going to pick this up and apply to the Habanalabs repo, and se=
nd
>>>> a pull request with it? Or how do you propose to proceed?
>>>>
>>>>
>>>> BR,
>>>> Jani.
>>>>
>>> Yes, in a later patch, they would be added as maintainers in the MAINTA=
INERS entry too.
>>> Regarding your second question, we should start with merging Ofir's ini=
tial patch.
>>> Any additional/upcoming changes will be initially merged into the offic=
ial HabanaLabs repo as you mentioned above.
>>>
>>> Regards,
>>> Yaron
>>>
>> Acked-by: Oded Gabbay <ogabbay@kernel.org>
>
> Reminder: can someone pick it up, please?

I thought you picking this up in your tree and then sending a pull
request with it would be a good exercise to get started. ;)

BR,
Jani.


--=20
Jani Nikula, Intel


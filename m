Return-Path: <linux-kernel+bounces-280968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B032C94D17B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9EB281B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC3719581F;
	Fri,  9 Aug 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFuU4szb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317CF18C93F;
	Fri,  9 Aug 2024 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211043; cv=none; b=ZHwHpXOrgQK+TCPIIuoun++M0XQlBc4Gs4iw/KBO+oMOANOapaokMo60WUUm+obQ27TjbAZDcBIDHsRLoCUA2NQQBL1MIMCwr6iq6Dk/6kRvcNvfW2+LbGv+NzIMkT3I9cxYcaSggK6/fY1U3yvBeVp+Fr+/lXSH935RQdv3mlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211043; c=relaxed/simple;
	bh=2q0JM7DrkXRljkEfvXBBolWlbIn4WXdGt6ny9v9+17A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sgCI3je0STqMdFQvyT7SK4TgK6YuLuoYlrPy+VW6Ga+FGWOnj8fy/4ZYNIZFxza2lqip/hHOjRO4Hez0TuUUaS5bvWuVxMlCHqAoLC1+tq86yYiYhm3pquuEMxsn3BpneCGGei+YroNMoGtbdcHyELnDcbULakWcpONxI4ARj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFuU4szb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723211041; x=1754747041;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=2q0JM7DrkXRljkEfvXBBolWlbIn4WXdGt6ny9v9+17A=;
  b=aFuU4szbdvI/evgEdadBUKbgVnSxpiBn9z1IKXTH81RzMeshPpCn/9NP
   53+kqAy0g8XWRH3rsV7WqNxMOBiDQpiBMyYluXJN3nSIKoqNjIOKTAtF/
   sRZJtqXtiFj8efgUuLQ5d0zVglMwpbrzCOpa+qThiZ8mXtsYHILqoCWO8
   szQBhmqL1gJzI+mukmLwaFVrZe8gznyqZm4Bwv7Dabp9AAO+zWtUvtIt1
   Kjoh3MRTeEqJ9BEdXR9SGNVfAP+Wq3ws4+eZf6g6AKLAlw9wrMlhYQBBa
   bXpSIhz3CV4bjVwgM95bBcdxjTvtVZmp3z4vzZMzTlhxbg76XanpZfNe5
   A==;
X-CSE-ConnectionGUID: MzQm/uSRSSuV2kUGM8RvtA==
X-CSE-MsgGUID: v9+dF5FUTrKw5WSVBQe1Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21042862"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21042862"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:44:00 -0700
X-CSE-ConnectionGUID: NkD5g5i3Qpuz8Ulnc2Fw+Q==
X-CSE-MsgGUID: sKqde5szQASt+0rtduSOPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="58140371"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.18])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:43:56 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Dan Carpenter
 <dan.carpenter@linaro.org>
Cc: Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/ast: astdp: fix pre-op vs post-op bug
In-Reply-To: <57cea156-1abc-4860-9a6a-0a5fdb4a2971@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <f7790a38-6b72-44dd-aaeb-550d2de14cf2@stanley.mountain>
 <57cea156-1abc-4860-9a6a-0a5fdb4a2971@suse.de>
Date: Fri, 09 Aug 2024 16:43:51 +0300
Message-ID: <87h6bt3j6w.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 09 Aug 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Hi,
>
> thanks a lot for the bugfix.
>
> Am 09.08.24 um 14:33 schrieb Dan Carpenter:
>> The test for "Link training failed" expect the loop to exit with "i"
>> set to zero but it exits when "i" is set to -1.  Change this from a
>> post-op to a pre-op so that it exits with "i" set to zero.  This
>> changes the number of iterations from 10 to 9 but probably that's
>> okay.
>
> Yes, that's ok.
>
>>
>> Fixes: 2281475168d2 ("drm/ast: astdp: Perform link training during atomi=
c_enable")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
>>   drivers/gpu/drm/ast/ast_dp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
>> index 5d07678b502c..4329ab680f62 100644
>> --- a/drivers/gpu/drm/ast/ast_dp.c
>> +++ b/drivers/gpu/drm/ast/ast_dp.c
>> @@ -148,7 +148,7 @@ void ast_dp_link_training(struct ast_device *ast)
>>   	struct drm_device *dev =3D &ast->base;
>>   	unsigned int i =3D 10;
>>=20=20=20
>> -	while (i--) {
>> +	while (--i) {
>
> If this loop ever starts with i =3D 0, it would break again. Can we use
>
> while (i) {
>  =C2=A0 --i;
>  =C2=A0=C2=A0 ...
> }
>
> instead?

FWIW, I personally *always* use for loops when there isn't a compelling
reason to do otherwise. You know at a glance that

	for (i =3D 0; i < N; i++)

gets run N times and what i is going to be afterwards.

Sure, you may have to restructure other things, but I think it's almost
always worth it.

BR,
Jani.



>
> Best regards
> Thomas
>
>>   		u8 vgacrdc =3D ast_get_index_reg(ast, AST_IO_VGACRI, 0xdc);
>>=20=20=20
>>   		if (vgacrdc & AST_IO_VGACRDC_LINK_SUCCESS)

--=20
Jani Nikula, Intel


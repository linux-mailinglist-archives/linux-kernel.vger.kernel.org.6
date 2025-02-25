Return-Path: <linux-kernel+bounces-530840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2884A43934
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6088E19E1521
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12426657B;
	Tue, 25 Feb 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcOj4Dlp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B84241696;
	Tue, 25 Feb 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474638; cv=none; b=kXxBEZFRUq4wt5Xeh+XspO0fJBbGwVFclu1uWZrAgUjqRao8zSNvkO3fL9faEpsJaV5VdvK2lM2x23n74e35hbgNFlOzxTqr2QoKNAMD1u3LJwLwU13EnVwznzZZql6iaStZk2f/f2EXWe2TMtdcQhsvIkgYWC3RrslDC3tAqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474638; c=relaxed/simple;
	bh=sQpPwoXRcrLe1y7aA+MEVSALbJkK7A9Ad3ufdJ8khXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ky3MJ3gOMI4eprxqUtU3PWUAwbh8SICgrEjn95wxgNopVdkLNULt7xeclorPEcwA7iApe6192c1MpR0yoAl7Qy+VgSB/CHXWi5htM3DZgBsJmoN9ca4k1pinE2z6RR//LLkNzoTKYIi7VjivWMn0I1jYcINxQVgvloIglPuB7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcOj4Dlp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740474637; x=1772010637;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sQpPwoXRcrLe1y7aA+MEVSALbJkK7A9Ad3ufdJ8khXk=;
  b=UcOj4DlpzgrEzGgt+mDmIgM5fAzVH4tx+bdCR5dXjct4/Shdy0S2Y8Wj
   2EvRL/R9HlLpATilOSs6zH550iS2Pb+eNc7ykTedbmhHampUxuCNmo9ZN
   F+cpLuhU7QjlYSiSWRoT9bfl3kiy60GKiIdnUF/FyBtv8mI6VXLdLJho5
   1NGYdn6vpmWvddWLclRquU/iATod5nlUWq+D/i+jS30qHUBQfHvAIG7BJ
   kSS5Qj2wiIyav0sxc+epecPZmO6LW7ur5UCGNVjMsbtszqtp3VK5uLKgz
   4MtGyIJp29oeALVB5bd7+AB/b1pNSmheUw38PCnBLfSSUbNhq6FYDvFkF
   w==;
X-CSE-ConnectionGUID: 5YBSHX3/To6/WBsGC8CTgg==
X-CSE-MsgGUID: dFk1x64nSwe2VSyIeQDVwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41185115"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="41185115"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:10:36 -0800
X-CSE-ConnectionGUID: lLouOT1dRo6qMbBUadUawQ==
X-CSE-MsgGUID: XZD0O4wkT8KxtqRGM6PyHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116818412"
Received: from monicael-mobl3 (HELO localhost) ([10.245.246.246])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:10:32 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] vgaswitcheroo: Fix error checking in
 vga_switcheroo_register_audio_client()
In-Reply-To: <8e161bf8-70f6-4557-8fa8-81d4bbfab91f@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ae24cd32-1e78-4656-b983-051ed22d86b9@stanley.mountain>
 <87eczn7adi.fsf@intel.com>
 <8e161bf8-70f6-4557-8fa8-81d4bbfab91f@stanley.mountain>
Date: Tue, 25 Feb 2025 11:10:29 +0200
Message-ID: <87zfia5r0a.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 24 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> On Mon, Feb 24, 2025 at 03:14:33PM +0200, Jani Nikula wrote:
>> On Wed, 19 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>> > The "id" variable is an enum and in this context it's treated as an
>> > unsigned int so the error handling can never trigger.  The
>> > ->get_client_id() functions do not currently return any errors but
>> > I imagine that if they did, then the intention was to return
>> > VGA_SWITCHEROO_UNKNOWN_ID on error.  Let's check for both negatives
>> > and UNKNOWN_ID so we'll catch it either way.
>> >
>> > Reported-by: Su Hui <suhui@nfschina.com>
>> > Closes: https://lore.kernel.org/all/20231026021056.850680-1-suhui@nfschina.com/
>> > Fixes: 4aaf448fa975 ("vga_switcheroo: set audio client id according to bound GPU id")
>> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> > ---
>> >  drivers/gpu/vga/vga_switcheroo.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
>> > index 18f2c92beff8..216fb208eb31 100644
>> > --- a/drivers/gpu/vga/vga_switcheroo.c
>> > +++ b/drivers/gpu/vga/vga_switcheroo.c
>> > @@ -375,7 +375,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
>> >  	mutex_lock(&vgasr_mutex);
>> >  	if (vgasr_priv.active) {
>> >  		id = vgasr_priv.handler->get_client_id(vga_dev);
>> > -		if (id < 0) {
>> > +		if ((int)id < 0 || id == VGA_SWITCHEROO_UNKNOWN_ID) {
>> 
>> Maybe we want to do something else here... see [1].
>> 
>> BR,
>> Jani.
>> 
>> 
>> [1] https://lore.kernel.org/r/CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com
>> 
>
> I feel like my patch is good enough...  I guess the concern here is that
> GCC could change enums to something else.  I don't think that's likely as
> it would break a lot of code.  The other option, which is a good option,
> is to change the function signature for vgasr_priv.handler->get_client_id()
> so that we do:
>
> 	ret = vgasr_priv.handler->get_client_id(vga_dev, &id);
> 	if (ret)
> 		return;
>
> That's better code, honestly.  But I can't find motivation enough to do
> the work.

The more I look at this, the more bonkers 4aaf448fa975 feels.

Anyway, I don't think ->get_client_id() hooks should return negative
error codes, and indeed none of them do. None of them return
VGA_SWITCHEROO_UNKNOWN_ID either, but that would be a valid return.

I suggest only checking for id == VGA_SWITCHEROO_UNKNOWN_ID. And doing
that in all the places that have that check, there are two more, but
they assign the return value to an int. So the int ret should be changed
to enum vga_switcheroo_unknown_id id I think.

Any chance of finding enough motivation to do that? ;)

BR,
Jani.



-- 
Jani Nikula, Intel


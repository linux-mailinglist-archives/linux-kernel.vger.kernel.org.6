Return-Path: <linux-kernel+bounces-284948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D5195073E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732761C22CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3472019D084;
	Tue, 13 Aug 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOzNwWni"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010D3A8CE;
	Tue, 13 Aug 2024 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558313; cv=none; b=PnGTd19Am0p0YTKIHv0sPJLCaHtDu3da/msusZwbuZpmZejhauc3ker85Ea2HwSh9mLkzELBx+xvnncujkVVZIgbjW5eulsbem6Vz1VPO6NoekOBhWoN0svJUUj/IpnJmrGqvcXlJAZoMfhSVU7UhsiqSRDmuNU7t8n9vFZe/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558313; c=relaxed/simple;
	bh=jcyO1t/F6QSCuTMPpYmyG4FhhEPbx9Z1SU3Jy9ePKow=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDCjS0xTNOKmqBEvSBPQdned+i8jJtiJiEY3TNkPO3zS1ThqX84K2JNOFiUau5ISMVXZhTXvv8ooLa8RFkFGzDtG4BaRQ/LihXXtgP2sQt1ZcQQq0Tje0W+br9RhkfaSn+SwT5HEDCdhlP3gm2jMJX2iClgUQEvhRESZCAKBa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOzNwWni; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723558311; x=1755094311;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=jcyO1t/F6QSCuTMPpYmyG4FhhEPbx9Z1SU3Jy9ePKow=;
  b=cOzNwWnikyzktEiyvS161v+EvlTx+U0do996mijy1qRduyhwQZJCoYH1
   MV8+fwDsnlX2rJxwXSCQQuMrmKidkH4yBZZrXJKcFxwbfF/fwyYwJFle0
   zhOhOayOw6uD7srYxC9uJTWE2725DLzcfhy9ICraaHB1LdylzBHunoSza
   DfNG6YCLWbXCxlxE96D8muxj7+QvpZ8ecwv6uTnqRiHl9cdKFQrdtAOzT
   VQQbUt7otRAI5JX1nFRutV95r8o1tbtthth9qfhuZ+36woQJzYjKCgjqp
   EvlHb/4OefLeWw6gixmNClZWEhMXoHJc0xFTQgX39Kb0qDwlu9G3x7QGO
   g==;
X-CSE-ConnectionGUID: jaxTS272RuyipXT0KfdX0A==
X-CSE-MsgGUID: cKPGaQuGRv6BNnc3H0Hhyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="33128714"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="33128714"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:11:51 -0700
X-CSE-ConnectionGUID: JxP01tMkQtaJqIAoHGTDBQ==
X-CSE-MsgGUID: r3SwNOPFS2a5ngLhX9Tmiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58764819"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.234])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:11:45 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Bjorn Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, Danilo
 Krummrich <dakr@redhat.com>
Subject: Re: [PATCH v6 2/4] drm/rect: Add drm_rect_overlap()
In-Reply-To: <87frr924nj.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240812123147.81356-1-jfalempe@redhat.com>
 <20240812123147.81356-3-jfalempe@redhat.com> <87sev926na.fsf@intel.com>
 <60e55a9d-70bb-45d1-ac97-e4f6f6ffa9a9@redhat.com>
 <87frr924nj.fsf@intel.com>
Date: Tue, 13 Aug 2024 17:11:37 +0300
Message-ID: <87mslgzf52.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 12 Aug 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 12 Aug 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> On 12/08/2024 15:49, Jani Nikula wrote:
>>> On Mon, 12 Aug 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>>> Check if two rectangles overlap.
>>>> It's a bit similar to drm_rect_intersect() but this won't modify
>>>> the rectangle.
>>>> Simplifies a bit drm_panic.
>>> 
>>> Based on the name, I'd expect drm_rect_overlap() to return true for
>>> *any* overlap, while this one seems to mean if one rectangle is
>>> completely within another, with no adjacent borders.
>>
>> It's what I intended, but I may have messed up the formula.
>
> Hmm, then I may have messed up the review. :)

Yeah, my bad, sorry for the noise.

I think I was thrown off by the comparisons mixing r1 and r2 as the
first operand. Something like this might have been easier for *me* to
parse, but not sure if it's worth changing anything:

return (a->x1 < b->x2 && a->x2 > b->x1 &&
        a->y1 < b->y2 && a->y2 > b->y1);


BR,
Jani.


>
> Gotta run now, but I'll get back.
>
> BR,
> Jani.
>
>
>
>>> 
>>> I'd expect a drm_rect_overlap() to return true for this:
>>> 
>>>   +-------+
>>>   |   +---+---+
>>>   |   |       |
>>>   +---+       |
>>>       |       |
>>>       +-------+
>>
>> if r1 is the top left rectangle, you've got:
>>
>> r1->x2 > r2->x1   => true
>> r2->x2 > r1->x1   => true
>> r1->y2 > r2->y1   => true
>> r2->y2 > r1->y1   => true
>>
>> So they count as overlap.
>>
>> Checking in stackoverflow, they use the same formula:
>> https://stackoverflow.com/questions/306316/determine-if-two-rectangles-overlap-each-other
>>
>>> 
>>> While this seems to be required instead:
>>> 
>>>   +-------+
>>>   | +---+ |
>>>   | |   | |
>>>   | +---+ |
>>>   +-------+
>>> 
>>> 
>>> IOW, I find the name misleading.
>>> 
>>> BR,
>>> Jani.
>>> 
>>> 
>>>>
>>>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>>>> ---
>>>>   drivers/gpu/drm/drm_panic.c |  3 +--
>>>>   include/drm/drm_rect.h      | 15 +++++++++++++++
>>>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>>>> index 0a047152f88b8..59fba23e5fd7a 100644
>>>> --- a/drivers/gpu/drm/drm_panic.c
>>>> +++ b/drivers/gpu/drm/drm_panic.c
>>>> @@ -529,8 +529,7 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
>>>>   	/* Fill with the background color, and draw text on top */
>>>>   	drm_panic_fill(sb, &r_screen, bg_color);
>>>>   
>>>> -	if ((r_msg.x1 >= logo_width || r_msg.y1 >= logo_height) &&
>>>> -	    logo_width <= sb->width && logo_height <= sb->height) {
>>>> +	if (!drm_rect_overlap(&r_logo, &r_msg)) {
>>>>   		if (logo_mono)
>>>>   			drm_panic_blit(sb, &r_logo, logo_mono->data, DIV_ROUND_UP(logo_width, 8),
>>>>   				       fg_color);
>>>> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
>>>> index 73fcb899a01da..7bafde747d560 100644
>>>> --- a/include/drm/drm_rect.h
>>>> +++ b/include/drm/drm_rect.h
>>>> @@ -238,6 +238,21 @@ static inline void drm_rect_fp_to_int(struct drm_rect *dst,
>>>>   		      drm_rect_height(src) >> 16);
>>>>   }
>>>>   
>>>> +/**
>>>> + * drm_rect_overlap - Check if two rectangles overlap
>>>> + * @r1: first rectangle
>>>> + * @r2: second rectangle
>>>> + *
>>>> + * RETURNS:
>>>> + * %true if the rectangles overlap, %false otherwise.
>>>> + */
>>>> +static inline bool drm_rect_overlap(const struct drm_rect *r1,
>>>> +				    const struct drm_rect *r2)
>>>> +{
>>>> +	return (r1->x2 > r2->x1 && r2->x2 > r1->x1 &&
>>>> +		r1->y2 > r2->y1 && r2->y2 > r1->y1);
>>>> +}
>>>> +
>>>>   bool drm_rect_intersect(struct drm_rect *r, const struct drm_rect *clip);
>>>>   bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
>>>>   			  const struct drm_rect *clip);
>>> 
>>

-- 
Jani Nikula, Intel


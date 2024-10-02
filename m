Return-Path: <linux-kernel+bounces-347876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 231F798DFC8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BB51C21F46
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEB01D0F74;
	Wed,  2 Oct 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ArTGtdMV"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A62F44;
	Wed,  2 Oct 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884172; cv=none; b=ksTaBtL9PGwkhPO3fQ60P/y8DZoqLCH3kySKj+9yEXogiO++cdyBwAfCL9nMv+PE/4ybf5OImaRLqQCxexfL6sOm5rtMXvUJIgIQ3bImAJZEL9u2lh3ooQotKq0fuvMjCB5hkYs9efIQxkJ4epE/M5Zwu8H8NXLiEN6jbXk5DN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884172; c=relaxed/simple;
	bh=Gy3K3sHXHuCd56lnx0SvuCxyX9iZFy+ugM3GpFkELag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MsZhA0RInkIpT8WF84F9DiWijn/wup/LLkgtqualUf/VS1fGeaZDyTE7mDLVXUAX5dwuvKMkH+unJcNB7r54Wwc+omyJlpaxq0249Jm0spPUDZ39i461jR/RlV/JovydZbMZM9Trjwe1xfeV0MVj7vd6kesfa5HhN7CXVr3XVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ArTGtdMV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=7RcmtwIDm6JN9AQ9SNlCuNNoGT34XsxYlpE1SCdozGg=; b=ArTGtdMVyIqkeXprOcooCWoMZb
	bygL0njNlsoN89ChNh4ogIkBpNGG1c/GhV9XSJs16QCrvgrxVVXohIx6247HjlMq1iKW4CDUJYIOJ
	gB8oskAaANsmKjAOmrys4wwbnXi/zAhi3iwyPpinS8g2mRPGYXjRmv5w7Y0P0vVH5rccsKtfj1nhp
	FDBjNK8j1ZUKTazEJnFJ6bxZwh7Qt2F+lCj+q0XJBd0gTazkejD0tHSqW8gao5UQMJJPuDyd5chV/
	cD9zgr2/jxDjEvClbZ8Y+QswRHlYWoZVzAvXs3ETi9co1r4PoZgzfPLax/OlOmGf+x9fP47am2BEy
	pmrf34eg==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1bJ-00000003W5T-0Dx6;
	Wed, 02 Oct 2024 15:49:17 +0000
Message-ID: <509aa67d-5bfa-4f37-aae6-ce3786e35596@infradead.org>
Date: Wed, 2 Oct 2024 08:49:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/15] drm/vkms: Avoid computing blending limits
 inside pre_mul_alpha_blend
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, Maaara Canal <mairacanal@riseup.net>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Simona Vetter <simona@ffwll.ch>, arthurgrillo@riseup.net,
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
 Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
 <20240930-yuv-v11-6-4b1a26bcfc96@bootlin.com>
 <30573f5a-d3dd-4aa4-ac5a-cf6df77b79dc@infradead.org>
 <Zv0LBo8OtRHJM029@louis-chauvet-laptop>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Zv0LBo8OtRHJM029@louis-chauvet-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Louis,

On 10/2/24 1:57 AM, Louis Chauvet wrote:
> On 01/10/24 - 20:54, Randy Dunlap wrote:
>> Hi--
>>
>> On 9/30/24 8:31 AM, Louis Chauvet wrote:
>>> The pre_mul_alpha_blend is dedicated to blending, so to avoid mixing
>>> different concepts (coordinate calculation and color management), extract
>>> the x_limit and x_dst computation outside of this helper.
>>> It also increases the maintainability by grouping the computation related
>>> to coordinates in the same place: the loop in `blend`.
>>>
>>> Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>>> ---
>>>  drivers/gpu/drm/vkms/vkms_composer.c | 40 +++++++++++++++++-------------------
>>>  1 file changed, 19 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
>>> index 931e214b225c..4d220bbb023c 100644
>>> --- a/drivers/gpu/drm/vkms/vkms_composer.c
>>> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
>>> @@ -24,34 +24,30 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
>>>  
>>>  /**
>>>   * pre_mul_alpha_blend - alpha blending equation
>>> - * @frame_info: Source framebuffer's metadata
>>>   * @stage_buffer: The line with the pixels from src_plane
>>>   * @output_buffer: A line buffer that receives all the blends output
>>> + * @x_start: The start offset
>>> + * @pixel_count: The number of pixels to blend
>>
>> so is this actually pixel count + 1; or
>>
>>>   *
>>> - * Using the information from the `frame_info`, this blends only the
>>> - * necessary pixels from the `stage_buffer` to the `output_buffer`
>>> - * using premultiplied blend formula.
>>> + * The pixels 0..@pixel_count in stage_buffer are blended at @x_start..@x_start+@pixel_count in
>>
>> should these ranges include a "- 1"?
>> Else please explain.
> 
> Hi Randy,
> 
> For the next version, I will use standard mathematical notation to clarify 
> the "inclusiveness" of the interval: [0;pixel_count[

Hm, I can read that after a second or two.

My math classes always used:  [0,pixel_count)
for that range, and that is what most of the internet says as well.

or you could just stick with
  The pixels from 0 through @pixel_count - 1 in stage_buffer are blended at @x_start
  through @x_start through @x_start + @pixel_count - 1.

but after writing all of that, I think using range notation is better.

thanks.


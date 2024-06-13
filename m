Return-Path: <linux-kernel+bounces-213613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A7D9077AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1641C28F6D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D212EBC7;
	Thu, 13 Jun 2024 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fXxiS3lG"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7CB4C6B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294396; cv=none; b=D5JLzuAwSJ9z5T6qRw5Y9uTLsbPIrjIN5jr1anefdgf4yrz8LAFlEdTQYJKVuiKjEJ/bEM8eGH4jvcd+WZfqSjDl61SAGMgaDB5GqbSNOYQoBxIF9/RtkQRQ8V+uxGCiGSYjSUSag7DxXkkbEZc/pE8o3tr+rntRXJ5zh3KzH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294396; c=relaxed/simple;
	bh=JJ7Ap8agYPGBkmdJ+h8BkIcwZIv5C8EcBj4519tdv68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDjiNcQ70F5wbzE/vpsJjnusXzQaZhNlCsgJOvW2o2FLzY6dOZ3dTtINkLzte0ploC88Z1vQYuudjr+9uvXZSJLgoETziWGqnqRDnq/pF/lwh385cFmPe3g8+r2kCKwJBxc/N7frCyOOe91u3dHt+ki28nU8LvvPWI7peXlKjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fXxiS3lG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3wI79EVibt43SH4PGZp+2uUA06kDU+dXqyZcd/qYGqo=; b=fXxiS3lGkDP8JmTivSEswlAbfA
	zLgBJjYIiwA6Q0FynVr18Y/ep7JICV4keZLGHXWY3xHC5g33QvtsoQ9Lld9HK5BstOkv/mZ+eRuyN
	HdlxUqKeTtnfthHlj/sXHV6rOYkbFwlUx5um1KdzOdJNBfgMm3Xcm3dzH5LpT8eHtENLrmga1fIWB
	WfV4GKoe3hhhTaDdU+31IJxmw8VmdM/XEMgNJeH7NQyxGae1B5kjfyn3XXAktJo2vn/DA/N7zr2IN
	gOLSqJUtleYwHOtQi1YkjIdgMctEQLUSz8maeh2S/IL55y9RHeCDghkPfMjFOrQxYeoLsEgL2QChE
	zJqaQ9qA==;
Received: from [177.172.124.193] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sHmrZ-002nFO-HR; Thu, 13 Jun 2024 17:59:45 +0200
Message-ID: <2a0cd195-b64a-40b5-ba46-364f6f6e0d0f@igalia.com>
Date: Thu, 13 Jun 2024 12:59:39 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm: Allow drivers to choose plane types to async
 flip
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 Simon Ser <contact@emersion.fr>, Pekka Paalanen <ppaalanen@gmail.com>,
 daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>,
 =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com,
 Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20240612193713.167448-1-andrealmeid@igalia.com>
 <20240612193713.167448-3-andrealmeid@igalia.com>
 <pu4nawhvy52imqgpib4lx3s5lsbatmfrq3e7aa4zxfmewt6xrn@ki7woraegakt>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <pu4nawhvy52imqgpib4lx3s5lsbatmfrq3e7aa4zxfmewt6xrn@ki7woraegakt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Em 12/06/2024 17:45, Dmitry Baryshkov escreveu:
> On Wed, Jun 12, 2024 at 04:37:12PM -0300, André Almeida wrote:
>> Different planes may have different capabilities of doing async flips,
>> so create a field to let drivers allow async flip per plane type.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>>   drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
>>   drivers/gpu/drm/drm_plane.c       | 3 +++
>>   include/drm/drm_plane.h           | 5 +++++
>>   3 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
>> index 57662a1fd345..bbcec3940636 100644
>> --- a/drivers/gpu/drm/drm_plane.c
>> +++ b/drivers/gpu/drm/drm_plane.c
>> @@ -385,6 +385,9 @@ static int __drm_universal_plane_init(struct drm_device *dev,
>>   
>>   	drm_modeset_lock_init(&plane->mutex);
>>   
>> +	if (type == DRM_PLANE_TYPE_PRIMARY)
>> +		plane->async_flip = true;
>> +
> 
> Why? Also note that the commit message writes about adding the field,
> not about enabling it for the primary planes.
> 

This is not meant to have any function change actually, just to enable 
per-plane configuration. Currently, any driver that supports async page 
flip in atomic API supports flipping the primary plane.

But as Ville pointed out, that belongs to driver code, so I'll move 
there, hope that it makes more clear

>>   	plane->base.properties = &plane->properties;
>>   	plane->dev = dev;
>>   	plane->funcs = funcs;
> 
> 


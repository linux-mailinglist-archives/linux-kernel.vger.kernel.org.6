Return-Path: <linux-kernel+bounces-382325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0CC9B0C63
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088D01C221ED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318920A5D0;
	Fri, 25 Oct 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="UFU6Hiib"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75B20102B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879190; cv=pass; b=vE0ySHJ+B5wd2OHrMFENtZpYfHFZPslgr0jM2PQlTr4ELROlCITvXrCMkgvq1Zn5ebFzGkEIP7BSSO64yyhTns33ttD3uK8Q0nAmN5EVhnj18JvfMk61w28GOk6UfGdCWOgVPne3l17/MLcMlyp/IrEIBD3/GVSNdB6owbmYnp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879190; c=relaxed/simple;
	bh=hKFUCTWT0BkFYd3KtDUY9k1SzReqA9ctSD2OwdkCiGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuWbYSdo1vjbCSJoO8NlFRfN0PElMXO/jpuyU4nf8Q9dn4/NtT8JLVYruewKQQi2GYRbQrW6sEIx5Stq9/oUUotHozhdQYlpm6tgID5qUsMqyuPrM/wPLeO9WkDQQ6lhoUB7ww1QqQvshNbaHz7S7M3GPkUNLuL4cUtCyGF2VcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=UFU6Hiib; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729879175; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YotU0suanNeLwfdlee4TTl/JSM8MRVMfMZH6cawJ7PepI697YKjEdj6tJPqRT/CN0KU3kKZM9sK6oMmFUsrOtKr+k29XgOJ0ixsIi3Pfp3rB/8LFmb2R1ckwvLDYtFqzxW81eMUSZaxLaNm/75LNHgic73ENG0D2xS+KkktmiWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729879175; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SDR/2walgN8msRG3na8ZVPKgJth6f+dq/ymHTRdWh1g=; 
	b=YZbOFTQ2bqUoKPz1inD0p3qU6GWaygJMWMty7Too31Z3ysdW9xCtKc5VLKTA60inJTMJYSXS+Feube2sAn2TVGZwZaofBTmx86Xv4BiwqaH2vsBS7jju8GO0PsQ2/MGFQ+0CE5iipNMHv7ykUq3fTqfNCjku85c2ZmjAIoS8bsY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729879175;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SDR/2walgN8msRG3na8ZVPKgJth6f+dq/ymHTRdWh1g=;
	b=UFU6HiibijfIbCD3IgoIt0i8YZbW5LaS1WebHtNo7TPkCyVedvSnE2F8lUG84mMb
	sXm/JaTxBbNRK1Ut4k2F68JEotcYd3C2SR91vhY94a556+DaMvPYnHmotmQdikym6Dz
	X86udJP/SpFN1QDvMdRTA9b45iC42fPrbU3FVZy0=
Received: by mx.zohomail.com with SMTPS id 1729879172868517.0244715513983;
	Fri, 25 Oct 2024 10:59:32 -0700 (PDT)
Message-ID: <18415279-39d3-4ce3-bef2-58566276799b@collabora.com>
Date: Fri, 25 Oct 2024 20:59:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/virtio: New fence for every plane update
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@collabora.com" <kernel@collabora.com>
References: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
 <20241020230803.247419-2-dmitry.osipenko@collabora.com>
 <IA0PR11MB7185FA36BD2988FD75239C5EF84C2@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <IA0PR11MB7185FA36BD2988FD75239C5EF84C2@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/22/24 07:44, Kasireddy, Vivek wrote:
>>  		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
>> x, y,
>> -					      width, height, objs, vgfb->fence);
>> +					      width, height, objs,
>> +					      vgplane_st->fence);
>>  		virtio_gpu_notify(vgdev);
>> -
>> -		dma_fence_wait_timeout(&vgfb->fence->f, true,
>> +		dma_fence_wait_timeout(&vgplane_st->fence->f, true,
>>  				       msecs_to_jiffies(50));
>> -		dma_fence_put(&vgfb->fence->f);
>> -		vgfb->fence = NULL;
> Not sure if it makes any difference but would there be a problem if you unref
> the fence here (existing behavior) instead of deferring it until cleanup?

Previously fence was a part of virtio-gpu framebuffer, which was kind of
a hack. Maybe there was no better option back then, when this code was
written initially.

Now fence is a part of plane's atomic state, like it should be. We
shouldn't change atomic state at the commit time.

...
>> @@ -326,11 +348,9 @@ static void virtio_gpu_cursor_plane_update(struct
>> drm_plane *plane,
>>  			(vgdev, 0,
>>  			 plane->state->crtc_w,
>>  			 plane->state->crtc_h,
>> -			 0, 0, objs, vgfb->fence);
>> +			 0, 0, objs, vgplane_st->fence);
>>  		virtio_gpu_notify(vgdev);
>> -		dma_fence_wait(&vgfb->fence->f, true);
>> -		dma_fence_put(&vgfb->fence->f);
>> -		vgfb->fence = NULL;
> Same comment as above.
> Regardless, the patch LGTM.
> 
> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

Thanks for the review :)

-- 
Best regards,
Dmitry


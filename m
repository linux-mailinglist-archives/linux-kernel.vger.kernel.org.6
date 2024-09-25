Return-Path: <linux-kernel+bounces-339266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870F9861E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32541F2CA39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0351459FD;
	Wed, 25 Sep 2024 14:45:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B75D1448E6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275558; cv=none; b=U3hpkiQWCbPFA9qV9aIRQPXfajo5QULCnVjJM/MzjmJDPsWiWaPsH3e78I4awPu2jEhQ5HfLCF6WPf5Q4nueFwXVMjCDzY8USmgwYmrQ90y62MZdpzt1ecgwfhh12I84KXYIFrYaWbXUON5w/berNhy0IwajchHPHLp+nCNjjo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275558; c=relaxed/simple;
	bh=51YIh3MoXVJOH1DmYE2jppK5C00w+soNvQojdZ9P814=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uU9R+ea1x+cAGwJ75aNwxJPrAYAtd6HtDbrWKn7+ByfpwQnPEfGIKllymw02T5NSJvGgpDTpttnGIy+XAw+m2hxsNKQWp16MAqdi8t0A1BmmGZgYzjziYSxOrJIaD51SYjRrHy519nXPbVIyeknHsh3NYpAdhxB1jUcGz18xaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91824150C;
	Wed, 25 Sep 2024 07:46:23 -0700 (PDT)
Received: from [10.57.78.226] (unknown [10.57.78.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C21C3F64C;
	Wed, 25 Sep 2024 07:45:52 -0700 (PDT)
Message-ID: <127aae99-c2c6-47e6-adba-66953e23f94e@arm.com>
Date: Wed, 25 Sep 2024 15:45:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] drm/panthor: Expose realtime group priority and
 allowed priorites to userspace
To: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christopher Healy <healych@amazon.com>, kernel@collabora.com
References: <20240909064820.34982-2-mary.guillemard@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240909064820.34982-2-mary.guillemard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2024 07:48, Mary Guillemard wrote:
> This patch series adds support for realtime group priority and exposes
> allowed priorities info with a new dev query.
> 
> Those changes are required to implement EGL_IMG_context_priority and
> EGL_NV_context_priority_realtime extensions properly.
> 
> This patch series assumes that [1] is applied. (found in drm-misc-fixes)
> 
> The Mesa MR using this series is available here [2].

Pushed to drm-misc-next

> 
> v2:
> - Add Steven Price r-b on the first patch
> - Remove drm_panthor_group_allow_priority_flags definition and document
>   that allowed_mask is a bitmask of drm_panthor_group_priority on the
>   second patch
> 
> v3:
> - Use BIT macro in panthor_query_group_priorities_info
> - Add r-b from Steven Price and Boris Brezillon
> 
> [1]https://lore.kernel.org/all/20240903144955.144278-2-mary.guillemard@collabora.com/
> [2]https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30991
> 
> Mary Guillemard (2):
>   drm/panthor: Add PANTHOR_GROUP_PRIORITY_REALTIME group priority
>   drm/panthor: Add DEV_QUERY_GROUP_PRIORITIES_INFO dev query
> 
>  drivers/gpu/drm/panthor/panthor_drv.c   | 61 +++++++++++++++++--------
>  drivers/gpu/drm/panthor/panthor_sched.c |  2 -
>  include/uapi/drm/panthor_drm.h          | 29 ++++++++++++
>  3 files changed, 71 insertions(+), 21 deletions(-)
> 



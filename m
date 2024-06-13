Return-Path: <linux-kernel+bounces-213544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7D09076AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962471C24251
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D4149C7D;
	Thu, 13 Jun 2024 15:28:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7E149C68
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292491; cv=none; b=jiMpbKEpS/rk+O/1eSfupj9EXBFkYxA4ZltY+UUsfsPAtLAVFW8mLrT7C1Qixe6ab5SSSBK9i1+HagW3lozXpf4BvA8spkJITu01jKe8DpN4lkw3NaUODVp8TEI/yXIRirX080Kg02cHPDyaMete9aAc4YojtU3p/EsX1roFN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292491; c=relaxed/simple;
	bh=ARZDt76vR2K5krolVAZGDnBHqsUFhU8nhZvM4Xnk+eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNZh3au1PZN/j+a5Cna53FQ+xHCCV0UJ1JXVXVdMdggF5Q73CiV2c165WtHZqTts9RBt153X5HPUO8jt27xCK0di21CjdOItDuyes9bnzqtbUXIP/M+4iQajrEgCTb+dO5tgTyN6mjybNzddz+UxbRY1NGXZPUsFylthO6SeZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE1CFEC;
	Thu, 13 Jun 2024 08:28:32 -0700 (PDT)
Received: from [10.57.42.101] (unknown [10.57.42.101])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD5213F73B;
	Thu, 13 Jun 2024 08:28:06 -0700 (PDT)
Message-ID: <ae1ec268-fd76-48b5-94f9-761565153e12@arm.com>
Date: Thu, 13 Jun 2024 16:28:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Support fdinfo runtime and memory stats on Panthor
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/06/2024 01:49, Adrián Larumbe wrote:
> This patch series enables userspace utilities like gputop and nvtop to
> query a render context's fdinfo file and figure out rates of engine
> and memory utilisation.
> 
> Previous discussion can be found at
> https://lore.kernel.org/dri-devel/20240423213240.91412-1-adrian.larumbe@collabora.com/
> 
> Changelog:
> v3:
>  - Fixed some nits and removed useless bounds check in panthor_sched.c
>  - Added support for sysfs profiling knob and optional job accounting
>  - Added new patches for calculating size of internal BO's
> v2:
>  - Split original first patch in two, one for FW CS cycle and timestamp
>  calculations and job accounting memory management, and a second one
>  that enables fdinfo.
>  - Moved NUM_INSTRS_PER_SLOT to the file prelude
>  - Removed nelem variable from the group's struct definition.
>  - Precompute size of group's syncobj BO to avoid code duplication.
>  - Some minor nits.
> 
> 
> Adrián Larumbe (7):
>   drm/panthor: introduce job cycle and timestamp accounting
>   drm/panthor: add DRM fdinfo support
>   drm/panthor: enable fdinfo for memory stats
>   drm/panthor: add sysfs knob for enabling job profiling
>   drm/panthor: support job accounting
>   drm/drm_file: add display of driver's internal memory size
>   drm/panthor: register size of internal objects through fdinfo

The general shape of what you end up with looks correct, but these
patches are now in a bit of a mess. It's confusing to review when the
accounting is added unconditionally and then a sysfs knob is added which
changes it all to be conditional. Equally that last patch (register size
of internal objects through fdinfo) includes a massive amount of churn
moving everything into an 'fdinfo' struct which really should be in a
separate patch.

Ideally this needs to be reworked into a logical series of patches with
knowledge of what's coming next. E.g. the first patch could introduce
the code for cycle/timestamp accounting but leave it disabled to be then
enabled by the sysfs knob patch.

One thing I did notice though is that I wasn't seeing the GPU frequency
change, looking more closely at this it seems like there's something
dodgy going on with the devfreq code. From what I can make out I often
end up in a situation where all contexts are idle every time tick_work()
is called - I think this is simply because tick_work() is scheduled with
a delay and by the time the delay has hit the work is complete. Nothing
to do with this series, but something that needs looking into. I'm on
holiday for a week but I'll try to look at this when I'm back.

Steve

>  Documentation/gpu/drm-usage-stats.rst     |   4 +
>  drivers/gpu/drm/drm_file.c                |   9 +-
>  drivers/gpu/drm/msm/msm_drv.c             |   2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c   |   2 +-
>  drivers/gpu/drm/panthor/panthor_devfreq.c |  10 +
>  drivers/gpu/drm/panthor/panthor_device.c  |   2 +
>  drivers/gpu/drm/panthor/panthor_device.h  |  21 ++
>  drivers/gpu/drm/panthor/panthor_drv.c     |  83 +++++-
>  drivers/gpu/drm/panthor/panthor_fw.c      |  16 +-
>  drivers/gpu/drm/panthor/panthor_fw.h      |   5 +-
>  drivers/gpu/drm/panthor/panthor_gem.c     |  67 ++++-
>  drivers/gpu/drm/panthor/panthor_gem.h     |  16 +-
>  drivers/gpu/drm/panthor/panthor_heap.c    |  23 +-
>  drivers/gpu/drm/panthor/panthor_heap.h    |   6 +-
>  drivers/gpu/drm/panthor/panthor_mmu.c     |   8 +-
>  drivers/gpu/drm/panthor/panthor_mmu.h     |   3 +-
>  drivers/gpu/drm/panthor/panthor_sched.c   | 304 +++++++++++++++++++---
>  include/drm/drm_file.h                    |   7 +-
>  18 files changed, 522 insertions(+), 66 deletions(-)
> 
> 
> base-commit: 310ec03841a36e3f45fb528f0dfdfe5b9e84b037



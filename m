Return-Path: <linux-kernel+bounces-389932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB559B7327
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D0B1C233C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAEC135A54;
	Thu, 31 Oct 2024 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BJXc1OcR"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84181BD9DC;
	Thu, 31 Oct 2024 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730346789; cv=none; b=nTkP3+/JP2hvZIZvN56CgtjnVnicTA76e8WALejd8zd277fRUfp6D9pDDUJSkyKe/phZBI4Nulwm3+iIwjCIfuTTHIklWns7BoLKqT1w/ScHrX714gJeCKY9S1lKMHqxOWEWFpIpgRTxRF2D9kvXBTzhjE+XMkjr1AFnnAORj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730346789; c=relaxed/simple;
	bh=Sk1dznek6EukMWFL0Zj/D4NGKIwasVyLsEo648izxJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPz4R6WZN+4Qc2KAbGXhVjvAJ9uzaN81LkGVUPcS+oPKGXwrfIxWt0cDBY6eEnTyhxrd8/lFeomTlkOGrJfjMQjlqoke04egarr/neOtbJJ1prQP8Wtz+l0MXc1ed4wRzQVofa9uugiBwO8nn5zRdRv4vkjCz0TcTBP1VrbJpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BJXc1OcR; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730346783; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sOP+DFaQKBYehdC1jobFZNXJQ8TaEZTpRfVqUforLqg=;
	b=BJXc1OcRcrI8ICdBUEDjMnnjtu00zQZtF+gCut8hSyr+jd6OUrQ67KBSVgzDKDVVCzlwmzFGhf8d2o3uO2KJ98TlD7jwl5/Rw3SV18K8t1vXKOnPwUwjG5jUhsi4dy9aD7c1cQgEtzMVJy8rj+csL3FMoKrX0EfIVlMHgLv+11M=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIGvEqL_1730346780 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 11:53:01 +0800
Message-ID: <2103c4c9-7da5-49a1-95f7-be11f62b58fe@linux.alibaba.com>
Date: Thu, 31 Oct 2024 11:53:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm: shmem: control THP support through the kernel
 command line
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241030130308.1066299-1-mcanal@igalia.com>
 <20241030130308.1066299-3-mcanal@igalia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241030130308.1066299-3-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/30 20:58, Maíra Canal wrote:
> Add a new kernel command line to control the hugepage allocation policy
> for the internal shmem mount, ``transparent_hugepage_shmem``. The
> parameter is similar to ``transparent_hugepage`` and has the following
> format:
> 
> transparent_hugepage_shmem=<policy>
> 
> where ``<policy>`` is one of the seven valid policies available for
> shmem.
> 
> By configuring the default hugepage allocation policy for the internal
> shmem mount, applications that use shmem, such as the DRM GEM objects,
> can take advantage of mTHP before it's been configured through sysfs.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

The changes look good to me. With the commit message update pointed out 
by Andrew, feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


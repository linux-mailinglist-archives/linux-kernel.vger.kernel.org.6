Return-Path: <linux-kernel+bounces-309667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC35C966EFE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F0BB22B40
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 03:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E952C6AF;
	Sat, 31 Aug 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gos5pwyL"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F721103
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725073231; cv=none; b=d8Y2oaYXh4qKbkHO5BcsQkHRIm8niWYs4q+t4z5tqnwRkUatCFw2YhSFqvNLHta9cSYZKDWNtGqodjOgGHB8Fe3WsUjq0nK8b8HzvdpCrOfvJU08IbTDxEZ5aOM3qlA8s8JbWrj4xi4/kMvKdRejJh8GzgmIpzSW4hSKGfTaKI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725073231; c=relaxed/simple;
	bh=bYrcGfgH6uGFP4Yv80xiqFpFoB6StYL8a6yYsNoq9aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eS2+wWtARZBBTZ2BfMEyPBtwMYjCiLfS26WShnZnTZc8GJvJVaevcMJSq0MO/mGvbltgTmuHz/glZGKmXutx4gM/XjscXTkBBhnxMLXyMbimfPDf+xEpFQm/MvTShhh0BJcZpuGYVuTaDPBdXLsmrtfG12QW3QUzi0RGFmi/ibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gos5pwyL; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725073220; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ncafHe3fLWN/Qi/tx6hfltABIG6ca2QF0UrKkJNtUwM=;
	b=gos5pwyLV+HCCPdrlZXVouH6YHdj/0pcoosWFysl8zA2nTIWe3rQ7yJ4Yjv3txzDcpCt6+vGEu+I6fjqqBhxBPgq7yXCOSpUIlDjUOdcUM/h/LN0nz9koJxkJ5q9jVi54m7CwtnGD4lpBUoF75/5zxSyNXGM+4tLmxgSrZCEWkM=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDyLVXO_1725073218)
          by smtp.aliyun-inc.com;
          Sat, 31 Aug 2024 11:00:19 +0800
Message-ID: <134cbf1b-06fd-41fb-830b-ba97e6ae4bfe@linux.alibaba.com>
Date: Sat, 31 Aug 2024 11:00:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-R3wU7hBBaeAXdkDp2kvODxSFWNQtcmc5tCppN5qwdQgw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-R3wU7hBBaeAXdkDp2kvODxSFWNQtcmc5tCppN5qwdQgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sandeep,

On 2024/8/31 08:30, Sandeep Dhavale via Linux-erofs wrote:
> On Thu, Aug 29, 2024 at 8:29 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> It actually has been around for years: For containers and other sandbox
>> use cases, there will be thousands (and even more) of authenticated
>> (sub)images running on the same host, unlike OS images.
>>
>> Of course, all scenarios can use the same EROFS on-disk format, but
>> bdev-backed mounts just work well for OS images since golden data is
>> dumped into real block devices.  However, it's somewhat hard for
>> container runtimes to manage and isolate so many unnecessary virtual
>> block devices safely and efficiently [1]: they just look like a burden
>> to orchestrators and file-backed mounts are preferred indeed.  There
>> were already enough attempts such as Incremental FS, the original
>> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
>> for current EROFS users, ComposeFS, containerd and Android APEXs will
>> be directly benefited from it.
>>
> Hi Gao,
> Thank you for the series! This is an interesting idea and will
> definitely help the Android ecosystem for APEXes if we can remove the
> loopback device. I will take a deeper look and provide comments soon.

Yes, I've seen no issue so far, and it will be submited for 6.12
since there are many users which really need this and wait for it.

Thanks,
Gao Xiang


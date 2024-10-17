Return-Path: <linux-kernel+bounces-369356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F4A9A1C43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39DF28BA0F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425351D1F5B;
	Thu, 17 Oct 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NCiMvr2U"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2142056
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152022; cv=none; b=XfT3vHSEQhQ8GnZk9EE0yhFxSb1lCfFvoOhqsGNLqoIwf7cJzeez7U9NoJ3EuziHQEHbtqS1tzmiN7kPnD1bRrQRgQr7ZcW5gnxjeIOxu3hc+ArlspO4N+BGZBGf7UXjUjy0RMEVc1V6ztY3lHlWcJECppNvll5NwC51z4VMNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152022; c=relaxed/simple;
	bh=60XM3MLbn0xcEFEBKm2L0+vuagN6fnAcUOYHVasiLI4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rdi9D2L4gtzKZcLUUGgeF/5jopu1MxVEbwneMQpauxJQrJPTquwCMYECcRWW3zSD7ZHOdqn5CmdcWVfoP5aLBIkiff6o3AQXv11ZykwWXDJKmRK22wegiFKhjfrtjLY1zN4BSur3cMRs+t773Vj5D2Z9mdmGRPt239rkuRJUUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NCiMvr2U; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729152015; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=dJCi/IDxX7C53L5q79zWTfQAlZqb4kThVsvTlrezeYw=;
	b=NCiMvr2Uxvi+J7ecy6iyytf2N1ulPJF5beK92ypW5e0oeC/sUxg3kRgHoiJPr3ZqbXpYlDCx94ddqV70RNa6rGEQSyP/DXEQQHu9WDwWsZYCaDFX0Wm+PsZDns7LAcien39I0J5CKq12gJe/CvMV+Hc+jyg0qIt+6V03/CVqLxE=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHK41XQ_1729152014 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 16:00:15 +0800
Message-ID: <0fa18bcf-9af6-4c99-ad57-613fa38ff741@linux.alibaba.com>
Date: Thu, 17 Oct 2024 16:00:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios
 with zero-filled
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Barry Song <21cnbao@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20241017074346.35284-1-21cnbao@gmail.com>
 <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
In-Reply-To: <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/17 15:58, Gao Xiang wrote:
> Hi Barry,
> 
> On 2024/10/17 15:43, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> When a folio has never been zero-filled, mark it as mappedtodisk
>> to allow other software components to recognize and utilize the
>> flag.
>>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> 
> Thanks for this!
> 
> It looks good to me as an improvement as long as PG_mappedtodisk
> is long-term lived and useful to users.
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

BTW, I wonder if iomap supports this since uncompressed EROFS
relies on iomap paths...

Thanks,
Gao Xiang


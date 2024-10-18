Return-Path: <linux-kernel+bounces-370934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2089A33EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0801F23DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E41173326;
	Fri, 18 Oct 2024 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fB5l4iSK"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637020E31D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729226600; cv=none; b=ToD2VB+h2201MLqFf7LI5/TpERUnz06g5GNV1aywHSvuq+zA9oeDoz7lfYZJPefTehI4lNRu+jWi/s7MAXr1Ea35xKe72aqFuTl7so2UO7Q0Qu8TKrrKPaFW/o82tLw8h1RjMz7UP2/8wQhRsvVo+jG8qBp0VIJnDO9Ay728SsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729226600; c=relaxed/simple;
	bh=GJe7mP3R2yvkjzlj3FLKJcdfVcb+FD4eqVw7Feqip0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YG9eww+UnppZo1K6KJNioQ3uqr3QoFW/tMQUXTAXLNmvKosnDZRV3llAh2V2odVVvj14UnapQlopvsKGM3jaDii/+uHwOee6JnBSlDjyMk1taKTpv0j9bRqlSnERW2Gvrdvt5FyS9c5J0JT4cvSq890Yy1CzlIAMknnJGfCaHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fB5l4iSK; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729226595; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=137QX8EpXYzRoAm1DZC6PZJEvNQCF2WinR+2tr9erX4=;
	b=fB5l4iSKjPprgzhrIz/cLp+qcfOMmGy9Lyyw/2PUZPxUVJuopqYalsR/picUJGGsQc/c3FBiYMrR6YvxeHT93KQYoVzrCuVs0UzCzXzRIo2DK34ietin1gg0iTfLlD9uf46AF+sNOJjZP57faXtbzASoEv7cgssy+Helh0jcwGw=
Received: from 30.27.73.141(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHMnL0F_1729226594 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 12:43:15 +0800
Message-ID: <0db205f7-85f7-41ec-93f7-2077ee3dfb9a@linux.alibaba.com>
Date: Fri, 18 Oct 2024 12:43:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] erofs: get rid of erofs_{find,insert}_workgroup
To: Chunhai Guo <guochunhai@vivo.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241017115705.877515-1-hsiangkao@linux.alibaba.com>
 <cd756ca4-e83b-4b10-8792-fc0f1c1ae2fa@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <cd756ca4-e83b-4b10-8792-fc0f1c1ae2fa@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/18 12:30, Chunhai Guo wrote:
>> @@ -789,7 +798,16 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>>    	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
>>    
>>    	if (!(map->m_flags & EROFS_MAP_META)) {
>> -		grp = erofs_find_workgroup(sb, blknr);
>> +		while (1) {
>> +			rcu_read_lock();
>> +			grp = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
>> +			if (erofs_workgroup_get(grp)) {
> I guess here should be modified as below, please refer to
> erofs_find_workgroup().

Yeah, nice catch!  Will fix it in the next version.

Thanks,
Gao Xiang


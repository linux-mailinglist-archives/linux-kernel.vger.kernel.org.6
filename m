Return-Path: <linux-kernel+bounces-360769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39B999F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53CFB213A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F18E20B216;
	Fri, 11 Oct 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="i25b9rfB"
Received: from out0-197.mail.aliyun.com (out0-197.mail.aliyun.com [140.205.0.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71E20A5D3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636703; cv=none; b=B4tClXkDXX1ty1jsTR+qJNifj58lMP3PGmSpa+O8Hu9P74dOfJigpdY+fMLYNYsoZQba2bTqqMiFhJnnbqGYjR5YElpo8fHB/dn+rErDxmZ5gbpYkqqA/nHt3TNzeAGXvimzAtmxgm9WJH3ZFLotBglLy6XsM2kF9UTMPTc9lwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636703; c=relaxed/simple;
	bh=sXQXCSmQQV07JfTUBFPQBOciIyx0KA2zIR2UzsIdbow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bd9KlJLV2beziYWh3ajGkiW/R6dSqpmINgxxOV5wah1VRwgbnWIjw3gN3jiDQd+29b955GnnrSFjfiH1FAd+PO/2lCoEuKXsuurndhJbqrBa/CUHaSc2lYddC47EnOvbg2GmyKdNEk056HHSvd7Zb33DqdwxKgXvwjv3mtDk0uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=i25b9rfB; arc=none smtp.client-ip=140.205.0.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728636696; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MtOXo2p9/XIZHu8Zkzqckg+RKXCzEUbnXFSl6QpaOnc=;
	b=i25b9rfBjV+okLE+Xr9/aQbU7vYpAxBuizaBTMaHMkP2bYsQFrQ995SBynaM0w2Nj4o41//u733MSka9uW/1UK46GKwMub1ksBE8MYfVHNG/APN2Ep/aGTmygwrbH2YYn0caaF4l7XpmzN7DNLqWfx0Txfb/uZ3v9vhU+pZ9kJ8=
Received: from 30.121.32.252(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZeRJfab_1728636688 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 16:51:35 +0800
Message-ID: <5f129f05-1d50-4076-aae6-99638dce35b9@antgroup.com>
Date: Fri, 11 Oct 2024 16:51:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Abandon the _PAGE_NEWPROT bit
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
 <99d9e95fcb27160da5ff931fcfe16a07b3256574.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <99d9e95fcb27160da5ff931fcfe16a07b3256574.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 2024/10/11 15:38, Johannes Berg wrote:
> Hi Tiwei,
> 
> So kind of a nit, but if the resulting code looks like this:
> 
>> @@ -184,17 +172,14 @@ static inline pte_t pte_wrprotect(pte_t pte)
>>  {
>>  	if (likely(pte_get_bits(pte, _PAGE_RW)))
>>  		pte_clear_bits(pte, _PAGE_RW);
>> 	return pte;
>>  }
> 
> then the if really isn't needed?
> 
> Same for all the others, I guess.

Makes sense. It looks a bit odd. Will drop the if. Thanks for the review!

Regards,
Tiwei

> 
> johannes



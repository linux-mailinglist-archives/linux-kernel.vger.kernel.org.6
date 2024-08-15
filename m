Return-Path: <linux-kernel+bounces-287379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885B952727
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E472834B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB94A04;
	Thu, 15 Aug 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqSsNCS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377363C;
	Thu, 15 Aug 2024 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682945; cv=none; b=uyP7JIORWu/dTxsDsmZ1alNCCM91uPt4p6C4r1GJQevZis54CPrKWKLdXhn2KZYHdVWjyq5eogLPBATYNvOdoTCPdcLB9UktBjkyLAYHG0GCCgzgvdGXdUOsAeXAldLIGtmJL+8teNoyOAwg82SA/Cqt+asbHuhByj/NFdFjUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682945; c=relaxed/simple;
	bh=y8xNM5xTWL+o54BCKSf286utnCJvuhLRMKPjE3Q3tLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFIIZxhzL1J66xdhpRTXfJk/VPlqkGveBLEYjBof3XydqasFwLjQ2OF578nUy52hyHVDdrzF06u8vMlQW/6rjiDc9U4s2MuqJAh3+hmRU3tauaCmZaA5t8J1HTlS9nxSXoow9NTDEfchG76p+4qG+2Slrq/jPBFGcFK+Ijalt7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqSsNCS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A801DC116B1;
	Thu, 15 Aug 2024 00:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723682944;
	bh=y8xNM5xTWL+o54BCKSf286utnCJvuhLRMKPjE3Q3tLE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tqSsNCS5y8CTocSxypHY+a1qDcYIxBqGLtoyBzgmDD9NjuNGT0wyctQnGsj8M7atE
	 J4AX9w4buCx2TgttsmVr/nuHND2H9MborhV7a3x3RsVxfEcMCzTQ/neZEU644UGaCW
	 xuK05485TPr6V2AEPrni7Mh71Az82+uB+UHisioFzRUN0t4h2M5i/hV7y9UBZG7lvM
	 ssDB+GJkKOQ5NNBX7hKmCeI1Fjas0UhZcw7T6sFy4SbitcuDP+blwlhm/9d/6C8eld
	 M1+NAqxDc88ok3Jgl72mcBVbYzfAMqZ+A+TvE9qt4/u2mP2ZSXAb/cBdK6jH19qJSB
	 4Y72FSxd9ac9g==
Message-ID: <54932cf8-0381-4e72-a02e-7424e7a3339b@kernel.org>
Date: Thu, 15 Aug 2024 08:49:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: Use sysfs_emit_at() to simplify code
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
 <99199c2a-1dbf-439c-ad24-68ed8844e096@kernel.org>
 <ZrzXIlJvWsOu2IIP@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZrzXIlJvWsOu2IIP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/15 0:11, Jaegeuk Kim wrote:
> Sorry, could you please post the patch to the mailing list again?
> I don't see the first patch.

I've resent it. :)

Thanks,

> 
> Thanks,
> 
> On 08/14, Chao Yu wrote:
>> On 2024/8/8 19:50, Christophe JAILLET wrote:
>>> This file already uses sysfs_emit(). So be consistent and also use
>>> sysfs_emit_at().
>>>
>>> This slightly simplifies the code and makes it more readable.
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>>
>> Thanks,



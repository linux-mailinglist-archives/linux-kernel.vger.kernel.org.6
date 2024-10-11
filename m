Return-Path: <linux-kernel+bounces-360774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A77999F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB58B21011
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974C420B214;
	Fri, 11 Oct 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="M/iauj6+"
Received: from out0-202.mail.aliyun.com (out0-202.mail.aliyun.com [140.205.0.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8720A5D3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636831; cv=none; b=EjW6rCsSVn3D4OOxMr7tOPUmkbnBFRYCWoSqORSSb85XAoVyhn6pVQ2+eO4OSpC4VRdlybBnuW5ofxMh5WVD2yePLV5JdHZQyPSRzEX8vlVzdbht0BzPmSe1oLi4IILqEpnWJ7Ihef58gdYNajHhwkUcrxAUh+psBwj7E+/jAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636831; c=relaxed/simple;
	bh=FbAH51QULPsUhjq2H0eiI4pwGWVK3Q5zZm/vwMHYb0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgQM04D11uOszzD9gf1bUL8+V5SuX3og/on10SI55b8NVMT5PrdEldOvsIkdrW4x1ri6RZI/LgPH7jQbqpn3kLhb2wyZFgLZjSRv4UCT1FdEbAD0B1pcWdyObxaw9b2L2ALfwpUM6S3zYwKfmRyqxVJLYkaNKQduN3el23IhcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=M/iauj6+; arc=none smtp.client-ip=140.205.0.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728636822; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jbUKc6F/J3c7TwVoue/wpb5nObs9+8cJPZcz26Dn+Sw=;
	b=M/iauj6+H2D0S1HWe2uq8GqsDabNL7UzpbV6waqxXW0E7i576cnwVEYsBe0qGh7Mt4tj1UUYxhhqjKw2BygFqEihznQIB305/0t35RgwSDnYPUpwHQ/uycmzxAhteUIZXJKb768sV6oJH7tgvcMhoaWqNLWzp6jVrlrUF+t+d5M=
Received: from 30.121.32.252(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZeQkkfa_1728636820 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 16:53:41 +0800
Message-ID: <fcaa6038-33dc-44a9-ab23-ac2309eeef4d@antgroup.com>
Date: Fri, 11 Oct 2024 16:53:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Abandon the _PAGE_NEWPROT bit
To: Benjamin Berg <benjamin@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
 <6abc79186ace90cd2abe202a4abe0eaf17eebb5f.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <6abc79186ace90cd2abe202a4abe0eaf17eebb5f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2024/10/11 15:39, Benjamin Berg wrote:
> Hi,
> 
> On Fri, 2024-10-11 at 13:38 +0800, Tiwei Bie wrote:
>> When a PTE is updated in the page table, the _PAGE_NEWPAGE bit will
>> always be set. And the corresponding page will always be mapped or
>> unmapped depending on whether the PTE is present or not. The check
>> on the _PAGE_NEWPROT bit is not really reachable. Abandoning it will
>> allow us to simplify the code and remove the unreachable code.
> 
> Oh, nice cleanup!
> 
> And I like that mprotect is gone as I don't want it in SECCOMP mode :-)
> 
> Maybe we should rename _PAGE_NEWPAGE to something like _PAGE_NEEDSYNC?
> I think that might make it more clear how everything ties together.

Good idea! Will do.

> 
> Anyway, the change looks good to me.
> 
> Benjamin
> 
> Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>

Thanks! :)

Regards,
Tiwei


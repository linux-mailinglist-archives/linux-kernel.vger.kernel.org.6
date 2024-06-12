Return-Path: <linux-kernel+bounces-211535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E7090534A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F7D286676
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75F9178395;
	Wed, 12 Jun 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7NHJkVY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11841D54B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197666; cv=none; b=lJCpLd00AG71QG54kqMBzax3mP4bZJL8QYlLjWwfTamFiGBwxsv2Jj6KAYX4rpBhGJSMG+ahrn2ur0EAD7BhvkUy7oZnOnZuiqDHop+hX8B2tfxUUV6Pq3zSpfZLoTojvlTBjIQ8qKeeU81cL59gG+Pw5I+M3bRqXPxDLoZQp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197666; c=relaxed/simple;
	bh=vRQlHNGUb9RMnafK9dTcbbr+Rpm98qcgacrWhXBREjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsORRvRrqitnlOXl3qRETRWGDaBbvfAWolgmZnTfC9fWjOHi3H/410s7jR2V9kdNonFXjRiNhQZx+OEbKYoygoDNTEUvWOFynHjplLsWUbHtX2Gz4hH0Z409EQ6lJz3nyt/ig6S1TczEaDRLvVkYUKsBEbf4UNaT/tAwStrFDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7NHJkVY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718197663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBMW5M/9uCuip/bSRX1dLBTS2ODu1sCKXWa+SRNoHPM=;
	b=O7NHJkVYw5LKBXNZ6GS1p83um6sys1kq+bbwYLEbMDIBhTKxeWkT75mDYx8RoUQAqIN1S9
	XX1CTxZ3a2HdRGY0VU2YAbn8L2YZDhUeTLrUPevxmkXU82Tn//fXUjnzGRXvqhrlpwSSCi
	q9pfni/lGvpX7tCDiRNhxb/TW0Xg31w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-PB9uv3aOMD-2o40qdK_hag-1; Wed,
 12 Jun 2024 09:07:38 -0400
X-MC-Unique: PB9uv3aOMD-2o40qdK_hag-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4C3019560B3;
	Wed, 12 Jun 2024 13:07:36 +0000 (UTC)
Received: from [10.22.32.53] (unknown [10.22.32.53])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 735D11956053;
	Wed, 12 Jun 2024 13:07:34 +0000 (UTC)
Message-ID: <868707d5-bbe5-4f10-8395-333caa867a82@redhat.com>
Date: Wed, 12 Jun 2024 09:07:33 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] nvme-multipath: implement "queue-depth" iopolicy
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "emilne@redhat.com"
 <emilne@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jrani@purestorage.com" <jrani@purestorage.com>,
 "randyj@purestorage.com" <randyj@purestorage.com>,
 "hare@kernel.org" <hare@kernel.org>
References: <20240612002034.1299922-1-jmeneghi@redhat.com>
 <20240612002034.1299922-2-jmeneghi@redhat.com>
 <1307c447-65bb-430c-88e1-045191d8d8ba@nvidia.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <1307c447-65bb-430c-88e1-045191d8d8ba@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 6/11/24 21:44, Chaitanya Kulkarni wrote:
>>    /*
>>     * List of workarounds for devices that required behavior not specified in
>>     * the standard.
>> @@ -195,6 +197,7 @@ enum {
>>    	NVME_REQ_CANCELLED		= (1 << 0),
>>    	NVME_REQ_USERCMD		= (1 << 1),
>>    	NVME_MPATH_IO_STATS		= (1 << 2),
>> +	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
> nit:- please align above to existing code ...

Ok... there must be something wrong with my tab stop.... are we using 8 space tabs in linux?

Here's what I have in my .vimrc

set smartindent              " always set smartindenting on
set autoindent               " always set autoindenting on
set backspace=2              " Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
set noexpandtab              " insert tabs instead of spaces
set textwidth=0              " Don't wrap words by default
set shiftwidth=4 smarttab    " number of spaces to use for each step of indent
set tabstop=4 softtabstop=0  " setting tab stops to be different from the indentation width

What is recommended setting for these ?

set shiftwidth=8 ?
set tabstop=8 ?

/John



Return-Path: <linux-kernel+bounces-519877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26237A3A30D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727AB7A0FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04026E14E;
	Tue, 18 Feb 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6IfKj7k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8D17B50A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896927; cv=none; b=S9TfxZ0T5RL125+UzryMpttxCKSkJHlIhhAHWjo1Ze/0MClrbeDojFpQev6ulFfCqBfQlOOTCesttfgn0sOXhk2VZpvwR76nbr8jknHFeSRFvbwirO6enBbWjkg1azKYh6+fXyQlOa7P8OYrUnEfxASmEdPmJPPjryOllpormSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896927; c=relaxed/simple;
	bh=UNBJ2ClE3bx0hidnmjFEbp89d+HNXAEZUI1bateVZVA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DlT4IMyH3UwQv4D4MNID29dUdNw1+z+y6ImTkOJj6eCv7+mQtmcBsFwQL8kFIA3Qh9NLE0WDtezRfgYTaGu+fWrHT5NX1a9KQl7Jf+DREOvlfr65ozdytZ/uHenpx7eCt2T9u4lMYFy1AAY+eHyaYSiZkg+1oSClBL1qv0vvIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6IfKj7k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ2shq+Ea+M+HlSyRdqdGGltGsI+k+k+AJworNHVRfc=;
	b=c6IfKj7kyGwABcKTa4GGWixxGXcOe65pXwaNFghNRdTQx+CDOp3FrHd5c6EOZ7CTDzRSOh
	vtfVV6YkQJadANHdDJ5PPD7SJ58WODGwT6Bmw/dPiTfw9h4be/sDjzy4iKsY8kCT2rPNyw
	xVCpDc3ifUoiRykvoCqCqtz0cGgVeyI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-ow03Jz9gPGSG0iTbSluz0Q-1; Tue,
 18 Feb 2025 11:42:01 -0500
X-MC-Unique: ow03Jz9gPGSG0iTbSluz0Q-1
X-Mimecast-MFC-AGG-ID: ow03Jz9gPGSG0iTbSluz0Q_1739896920
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E62271800875;
	Tue, 18 Feb 2025 16:41:59 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D040819560A3;
	Tue, 18 Feb 2025 16:41:57 +0000 (UTC)
Message-ID: <03bd60e5-7c7b-4589-a71a-a48ff53a619c@redhat.com>
Date: Tue, 18 Feb 2025 11:41:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
From: John Meneghini <jmeneghi@redhat.com>
To: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk
Cc: bmarzins@redhat.com
References: <20250204211158.43126-1-bgurney@redhat.com>
 <b37a4f6c-95a9-430d-89f9-141b72fd6be8@redhat.com>
Content-Language: en-US
Organization: RHEL Core Storge Team
In-Reply-To: <b37a4f6c-95a9-430d-89f9-141b72fd6be8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 2/18/25 9:26 AM, John Meneghini wrote:
>> +    } else {
>> +#ifdef CONFIG_NVME_MULTIPATH
>>           sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
>>               ns->head->instance);
>> -    } else {
>  > +#else
> 
> You don't need the this #ifdef conditional statement because the nvme_ns_head_multipath() function checks CONFIG_NVME_MULTIPATH
> for you and the sprintf(disk->disk_name, "nvme%dn%d" statement is kind of redundant.
> 
> 
>>           sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>>               ns->head->instance);
>> +#endif 

Actually, I think I may be wrong about this.  To maintain 100% backward compatibility with what the users see in the dmesg log, I think we need this code.

/John



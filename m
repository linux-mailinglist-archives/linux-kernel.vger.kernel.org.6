Return-Path: <linux-kernel+bounces-525981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB3A3F81D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C77B17B5CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347821018C;
	Fri, 21 Feb 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faPTfDW7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55DC20B7EC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150707; cv=none; b=Fh8vTQBUYNpPeSNhWSxOpbzSCdjgFLAg2WouWTuE0rSDVjpGfJx3m8LTdP83d494QPaY+mupe0jxH75Y24U21lA1SbsuUse+kIv5Ds99HYJIIT9M9Evg2fu/jDkfiMNHFdENdGXS5VqEcJ5P49rkHPJ5URwlN9hhBSJZPkbso98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150707; c=relaxed/simple;
	bh=arLh/I4lsr6ZGjo0XHkaCX6T2Wo1BV4LDhM14P7asug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lsqq6VgODCfpBt4VbtZRMSKq4DUiIgTsTskz/lwgPMd1EY6DFCXZxFnwB+5kV6gdETXlFoXZxKffXnExN1bUCbL6gNLkwR3xR7PRzzl//SFRBSLiItO06bVr/Iz4dwptd0io/UvuxRNjAzqtwmuneqKtaaot24MX1XPz/FOQ9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faPTfDW7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740150704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ9r/+kHRjV8toBGSoqWth/+wWu7waaSvaA44C2U1Cs=;
	b=faPTfDW72MoTfgn2Tk8csmWAeQbOsxRXNfGRFwS1DHLY0RextLO3RLTko6+ghPtnV1I8Y8
	5LmRhZy5sM2M+vh5ZURtKyUaRyEsgFX7Dm0W94UDWH8xI/hs2ZQAC3/sEFlrqXWV5dsv4c
	mGMy2NrzfTfOt3ZmO/yTP6YNcKcebUM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-4xRsXt3dNl-4ElKcQwhPrg-1; Fri,
 21 Feb 2025 10:11:40 -0500
X-MC-Unique: 4xRsXt3dNl-4ElKcQwhPrg-1
X-Mimecast-MFC-AGG-ID: 4xRsXt3dNl-4ElKcQwhPrg_1740150698
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10B151800875;
	Fri, 21 Feb 2025 15:11:37 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0575B180087E;
	Fri, 21 Feb 2025 15:11:32 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 Li Lingfeng <lilingfeng3@huawei.com>, neilb@suse.de, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: decrease cl_cb_inflight if fail to queue cb_work
Date: Fri, 21 Feb 2025 10:11:30 -0500
Message-ID: <7034A7D2-7AE3-4704-B30A-7D0D477307B0@redhat.com>
In-Reply-To: <6bdec87c369b61b515a29a6d661b1e9473fba24c.camel@kernel.org>
References: <20250218135423.1487309-1-lilingfeng3@huawei.com>
 <0ae8a05272c2eb8a503102788341e1d9c49109dd.camel@kernel.org>
 <04ed0c70b85a1e8b66c25b9ad4d0aa4c2fb91198.camel@kernel.org>
 <9cea3133-d17c-48c5-8eb9-265fbfc5708b@oracle.com>
 <8afc09d0728c4b71397d6b055dc86ab12310c297.camel@kernel.org>
 <C9BBD33C-0077-44B0-BCE9-7E4962428382@redhat.com>
 <c3f3c740498368905dd4adbabb75ee9e6728730b.camel@kernel.org>
 <9272C75B-F102-4D42-9970-DF3D267E0629@redhat.com>
 <6bdec87c369b61b515a29a6d661b1e9473fba24c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 21 Feb 2025, at 9:58, Jeff Layton wrote:

> On Fri, 2025-02-21 at 09:46 -0500, Benjamin Coddington wrote:
>> On 21 Feb 2025, at 9:37, Jeff Layton wrote:
>>
>>> On Fri, 2025-02-21 at 09:06 -0500, Benjamin Coddington wrote:
>>>> On 18 Feb 2025, at 9:40, Jeff Layton wrote:
>>>
>>> lease_breaking() is only checked when want_write is false. IOW, if
>>> you're breaking the lease for write, then lm_break is always called.
>>>
>>> Is that a bug or a feature? I'm not sure, but it's been that way since
>>> ~2011.
>>
>> Yeah.. why?
>>
>> Thanks I missed that detail when I refreshed my memory of it just now.
>> Seems like you'd want to avoid constantly calling lm_break for both cases,
>> spamming the lock manager adds nothing.  2 cents.
>>
>
> Sorry, it doesn't get called every time. If want_write is called then
> we _do_ check FL_UNLOCK_PENDING. IOW, you can get a downgrade attempt
> first, and then a full unlock request later.
>
> nfsd doesn't do downgrades. It recalls the object either way. So,
> ignoring subsequent lm_break calls is the right thing to do, I think.

Got it, thanks for clarifying this behavior for me!

Ben



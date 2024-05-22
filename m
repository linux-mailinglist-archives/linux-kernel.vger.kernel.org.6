Return-Path: <linux-kernel+bounces-186261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F868CC1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340C71F2364F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97413DBAC;
	Wed, 22 May 2024 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLIFVmS2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2F81AA7
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383557; cv=none; b=GB/3+Qp4xELE1gj3x2tGc18VOzGTEYtXcHy+Ho3etfItkfVe4ZbdEnP7VBlfDs1yiaJgW4s4WUicD5vvfrbO1aBMUfYxbmTOzxIFKf3tqTlcssX7vKQYFsZcTLY4WL+1MfmLGtKiqWxTgjmx/H1eY5zEalKg/YvTUrl0E/EocnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383557; c=relaxed/simple;
	bh=jQOQAWJQIzcAHCNFbYDIo9HGTOvHOu6U/O7t/i3sg5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLPV/vaYTsXIRO+BTdbzzHkiCvaH9eL5H81gzzFeecYGUfxj75mZclPY73OXh7JfzWimc00MzTZF7TA6tpJpiFDRgGSyRdPvE2ECeT6LsBwBEAlCOjALIXo9W5Ta3MKEwwATKkgp6dzyQV7LBMGhTfLIyJTPfvn2cmq44NASIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLIFVmS2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716383554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQOQAWJQIzcAHCNFbYDIo9HGTOvHOu6U/O7t/i3sg5Q=;
	b=aLIFVmS2ZTvzpcWi9LqW1RWNTdMYVqUVbRHvJ4zQTGgGZQxRLIzla30pmuOYWP9ehJN1LK
	mvI+8w1UgI11GoPDIXaSjKyUK00fDt3dVZtFHa22tcLbQLB9iz6hZGQYx1njzAJ3+MCpBz
	O1JuWjbsyosIGzBrMeljSCGuTvP22Bo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Oa7STFArNvCcSFCjpvsoaQ-1; Wed, 22 May 2024 09:12:31 -0400
X-MC-Unique: Oa7STFArNvCcSFCjpvsoaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3D94800CA5;
	Wed, 22 May 2024 13:12:30 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED17A2026D68;
	Wed, 22 May 2024 13:12:29 +0000 (UTC)
Message-ID: <f1b7196c-63bd-4c80-91e3-8d44c460c792@redhat.com>
Date: Wed, 22 May 2024 09:12:29 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Nilay Shroff <nilay@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
 <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
 <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
 <8f5ad047-be0b-471c-a708-f2bc464d29ef@redhat.com>
 <b3ea2812-1110-47f6-88f0-0e9c028c350f@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <b3ea2812-1110-47f6-88f0-0e9c028c350f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 5/22/24 06:48, Nilay Shroff wrote:
>> I has received quite a bit of testing with failover and controller resets.  I shared some of the testing that was done at LSFMM last week.
>>
>> It has received enough testing to make me confident that this code is safe.  That is: it won't panic, corrupt data, or otherwise do any harm.  We believe the error paths will not be affected by this change... but I agree that running the error paths could negatively impact the accuracy of the nr_active counters... which could lead to an inaccurate outcome with the queue-depth policy.
>>
>> I agree the nr_counter initialize should move to nvme_mpath_init_identify(), or maybe be done there in addition to in nvme_mpath_init_ctrl(). I'm will to make that change now... if that's what people want.  I don't think it would require any extensive retesting.
>>
>> /John
>>
>>
> I think with Keith's recent proposed patch for fixing io accounting on failover, the
> nvme_mpath_end_request() would be called even for cancelled IO and so the nr_active
> counter shall be adjusted correctly for cancelled IO requests. Having said that, IMO
> you shall consider moving initialization of nr_active counter to nvme_mpath_init_identify()
> as that's common function invoked from regular controller initialization code path as well
> the reset code path.

Agreed. I'll do that in V4 of the patch set.

/John



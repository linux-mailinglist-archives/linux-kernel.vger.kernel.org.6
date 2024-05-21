Return-Path: <linux-kernel+bounces-185045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0648CAFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B943E283009
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65BE7F47B;
	Tue, 21 May 2024 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bgfg9BMT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD67EEE3
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299919; cv=none; b=Vm+pDEBYWAa4GAFxwV2v+1a51dFogmOs2Y1pa5qlPBerXhLmHtL0iuvjJdzn7SyW1l00A1dy3tfQV9vGg9tVhCaYEsMxRbiOCJzQgBrQZe5ZewBoQ5flBA+pl+WSjkMAaJkwO+krYbxvIN64H1EuqYcG8oCRVBhZ79D7XbesSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299919; c=relaxed/simple;
	bh=OdiLWC8p0c/xtlG1gTvjqnMjTJiLAZdf1ma8L/gIMus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GS7s2WNnSNVy8/rRV5pWTR0CXbNd4C2o7jt6+lzdUO1nOTnwoL7I03+G1ExPSC7xGpDbgGN/Qx27FV8KHxA+HHffLlA4HqBT9SyXS/SG3YXb3jSc3Qs2D7OLrkFwkerdxvhO7mjeJbDeldXF8Hfz/M3ytasfc1ukAni8a61wcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bgfg9BMT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716299916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xFecaKFdNpZIUStP8/Na+T+oYYUztuWZCoP2Kb73pg=;
	b=Bgfg9BMTqM+y9yeEjkMvzeGyzT94m6BSBkTVMBjhAe6ruRMf4uDBU5hk3ajoax/Ju6y/d1
	/J1jEQeb4z9J7KAe4/Aak680iDbRIP79SL7ul2d6RhAjOClv4cKhtjRFFjThEw0JACnXDe
	NFwDd/ex1GNlv/88HDd8J1sxr7XuZT0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-qYX4PxAMPmarNOzC7BUlZw-1; Tue, 21 May 2024 09:58:33 -0400
X-MC-Unique: qYX4PxAMPmarNOzC7BUlZw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4FCE185A780;
	Tue, 21 May 2024 13:58:32 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 128FD40004D;
	Tue, 21 May 2024 13:58:32 +0000 (UTC)
Message-ID: <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
Date: Tue, 21 May 2024 09:58:31 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 5/21/24 02:46, Hannes Reinecke wrote:
> On 5/20/24 22:20, John Meneghini wrote:
>> From: "Ewan D. Milne" <emilne@redhat.com>
>>
..
>> Tested-by: Marco Patalano <mpatalan@redhat.com>
>> Reviewed-by: Randy Jennings <randyj@redhat.com>

I need to fix this. Randy doesn't have a redhat.com email address... Cut an paste error :-(

>> Tested-by: Jyoti Rani <jani@purestorage.com>
>> 
..
>> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>> +{
>> +    struct nvme_ctrl *ctrl;
>> +    int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
>> +    WRITE_ONCE(subsys->iopolicy, iopolicy);
>> +
>> +    mutex_lock(&nvme_subsystems_lock);
>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +        atomic_set(&ctrl->nr_active, 0);
>> +        nvme_mpath_clear_ctrl_paths(ctrl);
> 
> You always reset the variables here, even if specified iopolicy is
> the same than the currently active one.
> I'd rather check if the iopolicy is different before changing the settings.

Yes, Keith pointed this out too.  This is actually a feature not a bug.  In situations were we want to "reset" the nr_active 
counters on all controllers the user can simply set the queue-depth iopolicy a second time.  I don't expect users to do this 
very often... they shouldn't be changing IO policies back and forth too much... but the ability to "reset" the nr_active 
counters during testing has been very helpful and important to do.  So I'd like to keep this.  Moreover, this is NOT the 
performance path. I don't see the point in making performance optimizations in a code path that is run once a year.

/John



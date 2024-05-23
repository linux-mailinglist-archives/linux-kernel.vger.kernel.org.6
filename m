Return-Path: <linux-kernel+bounces-187299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EFF8CCFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571411F23A31
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5D13D2A8;
	Thu, 23 May 2024 10:02:24 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140713B592
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458544; cv=none; b=QhbgMpCYsU53s704C3GlF7f18f+zI0aZvJGioEn2hfquU+9XFA0zsJUSAhruezQBtNDuDdK14gpiCA/kV2yX785UloHxN8aM90VhDsGtJhBS7UVVaNx8+xR8CWqjpS9RfWDhYoiiKE3uH0ZbJU6Axwv/4CYAIZca7MstWkEzGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458544; c=relaxed/simple;
	bh=5gMWlRS41vfYYwjjWOChSkekHr83N8Zpdz0GhxCUzTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOXigFpbk4hfBwR3PeAFjYUtFHLpNhJ/TxrY6lT8KitZLqYYHD7CEhAwRDVQ5tSMOTVlJDWcKr1TpXiM/8i6VhnjHUstPfQVe0TQIiHl4lwAau8ADzFr0c/Kmljxzb4lVmFpArtm7kETgFxLcUz7IuUlJpHC0ZCzzqwVrdNBJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354fa667fb6so69603f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458540; x=1717063340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebL6HaU3GdxWXH9bjbvtlMoHiAW2gcv2Q5qh8IlHrEA=;
        b=vE0ZPkRClecWWg9m1xtPqB9CALRaYK4opxF779osUmuUrtvg5d1hrOicqu7GJyS/U3
         imx3cra8E0AclARM4xBCgmDHmfjwNp8PKCyv08V9787CzuuO7ONlVxoJbvD7unlPF2A5
         9suN1ZwupKWCzczcd/Ho+mPOXvhGyhhCsw0XvvvTW6JUev1DQco+4WJKzCJkSsD7bnbV
         nsH7pGwLhuoA140loM6F/Hx0dGNet8CittOofot5s6SfHkUssvK+fMM4NmSurLQRF0ED
         SALjlPHZEQTD9Pk3FCZNBOUR+tAh3hzo/OSwRu9rydd4D9MThOypIwQC8vjogPvTYWsI
         REzA==
X-Forwarded-Encrypted: i=1; AJvYcCX6pGURJR51aRVbgxNW38ExC9Mers2OHRR3UQflGwH8UcbLKm2fu+yDBQzhGwp8RCx3Re/0y4yhX7jjBl1al6CpNMHy/StYvd82Dr37
X-Gm-Message-State: AOJu0YxGWAtAJlVJv1sBR70J2weVpPT/xzBRIH1ZEmVjrpFRPXWFw3G+
	vVA4MeejhTx0+GNwEFAMW4EGorFVOkNfWbCqLw9kBSW1PQci06kL
X-Google-Smtp-Source: AGHT+IEuPcJDhy4s0Z/XTpgJp2o0aJtzN8RJVfHN0aiN+ZRZkNrh2QTMcFExpfcK3hpmzdL57q6Nlg==
X-Received: by 2002:a5d:46ca:0:b0:354:fa0d:1421 with SMTP id ffacd0b85a97d-354fa0d15d9mr828698f8f.1.1716458540286;
        Thu, 23 May 2024 03:02:20 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354f5e593dasm1702399f8f.109.2024.05.23.03.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 03:02:20 -0700 (PDT)
Message-ID: <98c860ce-57ca-4451-a4fa-1af93834e8f5@grimberg.me>
Date: Thu, 23 May 2024 13:02:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, emilne@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, jrani@purestorage.com, randyj@purestorage.com,
 hare@kernel.org
References: <20240522154212.643572-1-jmeneghi@redhat.com>
 <20240522154212.643572-2-jmeneghi@redhat.com>
 <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
 <cef5a764-ffab-495c-bea2-e4c6a7c76944@redhat.com>
 <Zk4ddPmottdOJND1@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zk4ddPmottdOJND1@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/05/2024 19:29, Keith Busch wrote:
> On Wed, May 22, 2024 at 12:23:51PM -0400, John Meneghini wrote:
>> On 5/22/24 11:56, Keith Busch wrote:
>>> On Wed, May 22, 2024 at 11:42:12AM -0400, John Meneghini wrote:
>>>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>>>> +{
>>>> +	struct nvme_ctrl *ctrl;
>>>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>>>> +
>>>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>>>> +
>>>> +	/* iopolicy changes reset the counters and clear the mpath by design */
>>>> +	mutex_lock(&nvme_subsystems_lock);
>>>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>>> +		atomic_set(&ctrl->nr_active, 0);
>>> Can you me understand why this is a desirable feature? Unless you
>>> quiesce everything at some point, you'll always have more unaccounted
>>> requests on whichever path has higher latency. That sounds like it
>>> defeats the goals of this io policy.
>> This is true. And as a matter of practice I never change the IO policy when IOs are in flight.  I always stop the IO first.
>> But we can't stop any user from changing the IO policy again and again.  So I'm not sure what to do.
>>
>> If you'd like I add the 'if (old_iopolicy == iopolicy) return;' here, but
>> that's not going to solve the problem of inaccurate counters when users
>> start flipping io policies around. with IO inflight. There is no
>> synchronization between io submission across controllers and changing the
>> policy so I expect changing between round-robin and queue-depth with IO
>> inflight suffers from the same problem... though not as badly.
>>
>> I'd rather take this patch now and figure out how to fix the problem with
>> another patch in the future.  Maybe we can check the io stats and refuse to
>> change the policy of they are not zero....
> The idea of tagging the nvme_req()->flags on submission means the
> completion handling the nr_active counter is symmetric with the
> submission side: you don't ever need to reset nr_active because
> everything is accounted for.

Agree. We should probably remove it from the patch.


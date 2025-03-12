Return-Path: <linux-kernel+bounces-558273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D77A5E3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D53BBFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF362528E3;
	Wed, 12 Mar 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAYNAVKx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324571CD20D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804555; cv=none; b=CTQd1hS30+dAiGJYg3OeXSk8H5rReRoYNTSEBPEC/CkIWuSRAkE6IVVSMnkcIZuxIyNpwffbLH0vCwIo9/9fdc6k8WHbnjf8hwj/Dl9b1gwWsEfKDRahX+ceO2X1pYDUCEcO9xA3vAXNXy9x3VbH7PZrPATr/xOpHfihmusSlfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804555; c=relaxed/simple;
	bh=S7e/A0BmpmrwWBXbatt1ag6yFDGwJPQylNsUjR3ZK/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEdxumdIib6Bt4Tf6oJYTL5XKYmjeWRC2N6ld0+bxXHLz+TaD6q4vULQiUtVRn4zVzXeulFNbvwfO/6orQg2XfmUPtB0iqxP62awkkJE6cd9ZgQdw1x9omsYoi1A0587xmTNWxOkUrwvpqSHaxBVjCYobhkuSZvlpu4G8k20zW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAYNAVKx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741804552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kg8OG6fCTKrHasfY8Q5mZEHdaUAY73IbW5wsrfqydq4=;
	b=OAYNAVKxy+qNeFsADcRAFESdy3YT1resb3D8eJUP+43eDbe+DVkCAM3r2A9VSVPqPBWOfA
	bE/Byf18RvPqVpghKm3YkE6zc/iRozFFH3XHKNCmp16B8XXYsh4D45NVa753m0kgFUwHZK
	kM0PTCs2PNgRARpxkyPBIir4wC/djCg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-RNWgj8qUOzaaUl4kjbAZPQ-1; Wed, 12 Mar 2025 14:35:50 -0400
X-MC-Unique: RNWgj8qUOzaaUl4kjbAZPQ-1
X-Mimecast-MFC-AGG-ID: RNWgj8qUOzaaUl4kjbAZPQ_1741804550
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so841155e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741804549; x=1742409349;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kg8OG6fCTKrHasfY8Q5mZEHdaUAY73IbW5wsrfqydq4=;
        b=v3nNUphfp5yzbOA/1MzMAxUobiGRDtzS+L+z/RZ8glQV0irg1kOrDnxLpAGGfMTdxZ
         YhO2R11WMpWQ09NJ46W0Wd3uO0UM6nwkTy/MNtMFt3dQq0FPYfQzx5HSe4HrIqE+7vRo
         CDrr325K4B8MpU2rli4czDSNCqJFCvjQI6FenvuHhqoroTKdFiXGVPcUT6h2rMXaDgl1
         IO9XIb0pA6nQBraLUYjqpYKzl7T+uZr2R7+GwQCini7H7Rn/gZUZKwsmQP33q/Id+Vg3
         QRRXeEtIES+h1iJ+QgcheHUOKNjo0Fnw/7/IyFsjnFpc8mXx64/b+BBTW1PZjClGn7fb
         PhWA==
X-Forwarded-Encrypted: i=1; AJvYcCXP12MQga+1/R9enECnPB+ZGUcKFpiviRpswctQWFq8eQbc+ZaL1Hf6ESodByCj/siZjV0/tHXyVQU+G/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhQuTe58LjUsAdZKFwLhhhdD3n+YyPUeZdZtnR8JfG7zQdTH4
	6ANFyaKw+oZzWf2KAckF+me5wNkhYhJiiJj7M90PDAN8QjW2FjvYoj0y0n/r9bInR+QtvSue/iZ
	0mmhFmMMHp9Ka0b0teuQfV5y5KDCqmkpuIq4/WNV5ij6DQMXecCQluLDQLtygsA==
X-Gm-Gg: ASbGncvn916fQ67QRxYZpfA6oRwPqMzGeflbV+Q9zmrRl5zzTZnsaSyhJrI/apGaL0+
	vdRpvKAkmJvHlr/FzrXps34P8POrW5cz+yp/8mJ7DPaSV+mjtlsJKgGkFL3/Ox3XC1n6pGWd2Kw
	nOCUdFjhhoQ16v6K5wlc/q00oxwAkpLsGmTC9Wft/+BJ76txpEeHCn2ScOIOyL5aivaL4o8WUUq
	Gb/ANYiH8Pex0Rc0bqpXDV8lcdpICU9fu+w1nWoU2NRqen3Rlao3uWpM9OUaCd8wJbUOD7vCFTF
	cPTz2X8GRdsGCbHJSoVjZg==
X-Received: by 2002:a05:600c:154c:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-43cf63cc031mr103512905e9.1.1741804549607;
        Wed, 12 Mar 2025 11:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgUwihZCzD7+DVSttzbZ8rO0kvBaS+3OmjiSWBjMucBzvhILF5dcq8VX5WPbUXHctg2KmujA==
X-Received: by 2002:a05:600c:154c:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-43cf63cc031mr103512755e9.1.1741804549186;
        Wed, 12 Mar 2025 11:35:49 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.122.167])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d0a8d068esm28753615e9.33.2025.03.12.11.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 11:35:48 -0700 (PDT)
Message-ID: <a006b1db-5cdd-4f73-b230-8fd4abfbfc7a@redhat.com>
Date: Wed, 12 Mar 2025 19:35:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipmi: fix suspicious RCU usage warning
To: paulmck@kernel.org, Rik van Riel <riel@surriel.com>
Cc: Corey Minyard <corey@minyard.net>,
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20250312131932.44d901f7@fangorn>
 <e28d914d-5842-4bfa-8208-9ac34fd38a95@paulmck-laptop>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e28d914d-5842-4bfa-8208-9ac34fd38a95@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 18:29, Paul E. McKenney wrote:
> On Wed, Mar 12, 2025 at 01:19:32PM -0400, Rik van Riel wrote:
>> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
>> index 1e5313748f8b..a2823763fd37 100644
>> --- a/drivers/char/ipmi/ipmi_msghandler.c
>> +++ b/drivers/char/ipmi/ipmi_msghandler.c
>> @@ -1235,7 +1235,7 @@ int ipmi_create_user(unsigned int          if_num,
>>   		return -ENOMEM;
>>   
>>   	index = srcu_read_lock(&ipmi_interfaces_srcu);
>> -	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
>> +	list_for_each_entry_srcu(intf, &ipmi_interfaces, link) {
> 
> Doesn't the above line want to be something like this?
> 
> +	list_for_each_entry_srcu(intf, &ipmi_interfaces, link,
> 				 srcu_read_lock_held(&ipmi_interfaces_srcu)) {

Ouch what a mess.  There are multiple occurrences of this,
almost all susceptible to the same warning.

I'd start with:

-#define ipmi_interfaces_mutex_held() \
-	lockdep_is_held(&ipmi_interfaces_mutex)
+#define for_each_ipmi_interface(intf) \
+	list_for_each_entry_srcu(intf, &ipmi_interfaces, link,
+				 srcu_read_lock_held(&ipmi_interfaces_srcu)
+				 || lockdep_is_held(&ipmi_interfaces_mutex)) {

and use the for_each_ipmi_interface() macro throughout the file.

Here is the list... all of them are using _rcu, plus:

- ipmi_smi_watcher_register is using the wrong lockdep_is_held() assertion,
   but would warn if fixed
- ipmi_add_smi is using _rcu but otherwise correct
- ipmi_get_smi_info is using _rcu and can warn
- ipmi_timeout is using _rcu and can warn
- panic_event is using _rcu and can warn, and is also not
   using any protection around the walk.  Taking srcu_read_lock
   would be much better


On top of this, intf->users_srcu never does a synchronize_srcu, so I'm
a bit at a loss at how it is protecting the list.  The safest change
here is probably:

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index f2a56c624f54..dc8936254c1b 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3769,12 +3769,12 @@ void ipmi_unregister_smi(struct ipmi_smi *intf)
  	intf->in_shutdown = true;
  	list_del_rcu(&intf->link);
  	mutex_unlock(&ipmi_interfaces_mutex);
-	synchronize_srcu(&ipmi_interfaces_srcu);
  
  	/* At this point no users can be added to the interface. */
  
  	device_remove_file(intf->si_dev, &intf->nr_msgs_devattr);
  	device_remove_file(intf->si_dev, &intf->nr_users_devattr);
+	synchronize_srcu(&ipmi_interfaces_srcu);
  
  	/*
  	 * Call all the watcher interfaces to tell them that

... plus replacing all uses of intf->users_srcu with ipmi_interfaces_srcu.


A couple more issues:

- in handle_read_event_rsp() there's a lone rcu_read_unlock()
that should become srcu_read_unlock() (currently for intf->users_srcu;
modulo changes like the above)

- while the intf->cmd_rcvrs list is protected by regular RCU,
there are many other occurrences of rcu_read_lock(), typically
followed by

         if (intf->in_shutdown) {
                 rv = -ENODEV;
                 goto out_err;
         }

and I think they should use interfaces_srcu instead.

Paolo

>>   		if (intf->intf_num == if_num)
>>   			goto found;
>>   	}
>> -- 
>> 2.48.1
>>
> 



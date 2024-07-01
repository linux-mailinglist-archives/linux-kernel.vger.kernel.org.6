Return-Path: <linux-kernel+bounces-236277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D5E91DFD6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2B2283C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB615A871;
	Mon,  1 Jul 2024 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDjo20iq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287D15AD86
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838095; cv=none; b=F58XBfzTqBChPpV+pY3rGf7Pjgx3WMw0SphQ5+aFbOASmUTCB15/QOT+kVP2AJ+yLbgjEHNMAq9bGhnqnwI4PP7tc1EUjqkqE/t/1HdPk45Y2Q2v5PwkC7ILEQ94fvlid9jnX2PMBEA/HYkoZxbAGP7Smv67xzbGo4yb5kV95TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838095; c=relaxed/simple;
	bh=2+w07VGTixun3YrVYfOWbI8IrO+IQ9Og5XhTxEoYxyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uhd21YdN29ouEB+/MxBvsdwD+b6UMVqCxqeK1aIBfYifuPQpUTKug6kOjziXyhc0xSVeKXfAIZjUoUcT/oio4iCLioor5cTrxq8evzDST9eErQqX7R8TnN+j5ysA4zZTmqUo9QJvIj22oZQv2s54J3BGKyC58youP2CKWnDPF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDjo20iq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719838093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSdaQGHu+WA1lqEtL+tvPGbWXl1L0DjgwjqzwZRS0wI=;
	b=hDjo20iqwx6mhdqk4hG0q9j6GMTKIrnXTUxeVDQShzsXQXDEANB3VyKh0C5vXWcCl/RVbX
	XaNmfPeMi2O4DhbE0DyHpKYblwgoSYdXFDTIrXClnO0h+3xygdZdDrdhbig0AbVw9NVFZ3
	Vgaau8/l2g7kZdnI+HEoVBtN2NMAfGM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-bOIz5tYdNemDJxR5XW9HYQ-1; Mon, 01 Jul 2024 08:48:11 -0400
X-MC-Unique: bOIz5tYdNemDJxR5XW9HYQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36740a84ad8so2740838f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838090; x=1720442890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSdaQGHu+WA1lqEtL+tvPGbWXl1L0DjgwjqzwZRS0wI=;
        b=KLLnsFqbxMzif5kwChsdQdyllpt2IUGQOFNTihFb9RSKIUCdjEKqGCNeNkXAm4t5Zh
         gupDU8gE9yPlcFw3Kwh0J+vzp/LXnK6Dkm8sezwraO5ztzrbin2pcMQAULWDON6u2k/I
         rMy/jnF+GVW+2SYIo0+RGxY4c+ZFOtGsuh9l52nxPUxv55+LmmvMV8NXlKAk2+mPzbmw
         tm4sxmysq7kc5VuY3YMGlpHpoYePtK30oniFqEv4Hri1vze6jpHiezfNbqe57pZfD8/j
         pITD9gdqFsDnTGX279M6eWlZwJCLcE3QSgDQNM4a6oWV1An6AAa3UNYPnvUmhxWhGOd/
         MpYg==
X-Forwarded-Encrypted: i=1; AJvYcCXywSwJgYUvC/OPKVlgPYfqgg6UURL3vcS3ak1XnHou/EqPgAg9yTBR5KzoAhjGpNWXLqyF66UnLB2zLkpIHC9VShGnDSUwiyhCsvTM
X-Gm-Message-State: AOJu0YxhU+aF4VJKxzjBIiRZfG2a/tAFUhqErQlS1pncy+xCkAzLxM/t
	ZCxlQykkZdAdOA6IZoufdmF3AGpShJNxZtNGqqxm4NaBZsA6Sb5xJn9bYww5RJppCwV/wSPp0SJ
	ivsUSmW77C325OUt4hzU1vZQwHr0GcvwAYHAWZTBqBY9/gttTaku7uYa/P3ygQA==
X-Received: by 2002:a5d:64cf:0:b0:366:eb45:6d54 with SMTP id ffacd0b85a97d-3677572484bmr4620561f8f.48.1719838090571;
        Mon, 01 Jul 2024 05:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdza1ZGuGAwYxkQdoxNZi6jACjn8OTGAy1lVWpizAxSmOuOlfjF4A+YcJua67MKsqon9A15g==
X-Received: by 2002:a5d:64cf:0:b0:366:eb45:6d54 with SMTP id ffacd0b85a97d-3677572484bmr4620538f8f.48.1719838090168;
        Mon, 01 Jul 2024 05:48:10 -0700 (PDT)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd5f1sm10038578f8f.6.2024.07.01.05.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 05:48:09 -0700 (PDT)
Message-ID: <b0e364d2-0def-4909-98c6-ce7188b7819f@redhat.com>
Date: Mon, 1 Jul 2024 14:48:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dm-crypt performance regression due to workqueue changes
To: Mikulas Patocka <mpatocka@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Waiman Long <longman@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Laurence Oberman <loberman@redhat.com>,
 Jonathan Brassow <jbrassow@redhat.com>, Ming Lei <minlei@redhat.com>,
 Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 users@lists.libvirt.org
References: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com>
 <ZoGSJWMD9v1BxUDb@slm.duckdns.org>
 <e64c112-4fa9-74da-68ce-c1eec19460f2@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <e64c112-4fa9-74da-68ce-c1eec19460f2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/24 20:49, Mikulas Patocka wrote:
> 
> 
> On Sun, 30 Jun 2024, Tejun Heo wrote:
> 
>> Hello,
>>
>> On Sat, Jun 29, 2024 at 08:15:56PM +0200, Mikulas Patocka wrote:
>>
>>> With 6.5, we get 3600MiB/s; with 6.6 we get 1400MiB/s.
>>>
>>> The reason is that virt-manager by default sets up a topology where we 
>>> have 16 sockets, 1 core per socket, 1 thread per core. And that workqueue 
>>> patch avoids moving work items across sockets, so it processes all 
>>> encryption work only on one virtual CPU.
>>>
>>> The performance degradation may be fixed with "echo 'system'
>>>> /sys/module/workqueue/parameters/default_affinity_scope" - but it is 
>>> regression anyway, as many users don't know about this option.
>>>
>>> How should we fix it? There are several options:
>>> 1. revert back to 'numa' affinity
>>> 2. revert to 'numa' affinity only if we are in a virtual machine
>>> 3. hack dm-crypt to set the 'numa' affinity for the affected workqueues
>>> 4. any other solution?
>>
>> Do you happen to know why libvirt is doing that? There are many other
>> implications to configuring the system that way and I don't think we want to
>> design kernel behaviors to suit topology information fed to VMs which can be
>> arbitrary.

Firstly, libvirt's not doing anything. It very specifically avoids doing
policy decisions. If something configures vCPUs so that they are in
separate sockets, then we should look at that something. Alternatively,
if "default" configuration does not work for your workflow well,
document recommended configuration.

>>
>> Thanks.
> 
> I don't know why. I added users@lists.libvirt.org to the CC.
> 
> How should libvirt properly advertise "we have 16 threads that are 
> dynamically scheduled by the host kernel, so the latencies between them 
> are changing and unpredictable"?

Libvirt advertises topology of physical CPUs (pCPUS) in so called
capabilities XML (virsh capabilities). For example:


  https://libvirt.org/formatcaps.html#examples

(not to be mixed with domain capabilities!)

From there you can see what pCPUs are in the same socket. And regarding
latency - unless you're doing real time, latency is unpredictable even
within single socket, isn't it.

Michal



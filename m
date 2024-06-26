Return-Path: <linux-kernel+bounces-230190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0359179A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3C6B21BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A18C15B57D;
	Wed, 26 Jun 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHFt9K6Z"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B3715B117
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386691; cv=none; b=EFZPZwoKu0EmqduoMVRFWJcfEVTjBqOtxrl0lqCRG/wKkKljwm6dCPJh/46JqxsZN4eo4UWH0qZ8ThDPo+ZJrVsUtrHULoqKoj05TW2/+i3UyrXloKlvAkJMJqiEWSLEEGmBJmYJFlQzdI3GFTr3dIVVFP64MgblzCLZ1eYYAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386691; c=relaxed/simple;
	bh=ZsJ86r0tLBtmYJ5feBvpqjkc5/6qxNlmh5z5WMB+W/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QC9M4J40IJqjMxqpoTgoXx0a24Gk8wDVvi7HiP7sewwLmnAV+KTddof68sSvXk4Ev8gQvzYxAjGbYp73NEaQpvkfizajMNVPtIfjxJ3DK7ZiNsEmBAl5IDfna6pxFg0MGA4z1Ij3VPMoWzBuGwbZ45exbQDJFbJFSwBwFHooP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LHFt9K6Z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a72420e84feso513522066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719386688; x=1719991488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wWjGkDHT2vKmQnlkJKgKr8DG4ogx+yHjfx+WaQWjqaw=;
        b=LHFt9K6Z3hGBnr4rzDR8vzYS3Gos2bw/b8UWjYbN73tqiYoeSVRj9tyk3FyRz4MzoM
         c1aoq97CeSOKQXDJmB9uqT7uwxEumQdU1+hrBkxq0QLYVRXQB8NRTmWpEaD6HME8JfrA
         IYo/tPYtYcRBfILZbGQblRV1DhxEkAjniAuMNIn+n/U3KJ/4bEuwi01VOx68Nho98WvR
         lWEtYLZe0tsVJKKmt1DhctCI8WnmNootXAbm1VED1T7ulpyZMMZU5l1ndJSsPC7ka9kL
         SmXKk7FmGhzTMjcVgVICXe7w/yahbFITnIpz+IRZwGGbCPfsd4yXNRrtBkwMsP86Stpq
         /PdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719386688; x=1719991488;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWjGkDHT2vKmQnlkJKgKr8DG4ogx+yHjfx+WaQWjqaw=;
        b=VIFcF9qPRQ0ZmBD/iDnyaba3cF5NVZiuY1xFWrzUsjw1FHXhOh31QHB7k9wM1gNlui
         od7ltSBhXjin9od27TNZ8bry7dKuyW8D9j/GiChmd/caoQhM+dS+BMZBY/GT/pVkpw3r
         X9dgG6PUNb7hMci1Ch3W/+urm+QwZFPslLZ5TQT4Rq2NF4krf+teb38CcgWPH/WQMM4j
         TrEt1wnXMuopH6/YkMOVRVFYQt6GJqUyPVbLGvQVzaTDg8Z4WmoELdwpP6JXjFFdiIQc
         nyT3DHuqiOarFlBu6f8A9z6YLoWu3hdMwYVtCKmdtrUrJ1aWR2HRC7TPXbHQHniziYER
         Hwgg==
X-Forwarded-Encrypted: i=1; AJvYcCW3oKt7X2nWfQjJPedbHGhlakrJzPC4k76X+mWiwbgGoi0MciFip1Fq7glPXoksbbTS7pxs/e+03vZ9y1u0zfw730R2lurn78FEkPUA
X-Gm-Message-State: AOJu0YznehLWWtVmprLNVAunD38OAW4LoPQDcFZOxnvN/kWyrFYziLVe
	9RYJcfVtXvepiO4Jko6Ies/m40PAJ3OyF/WyZyXoyQM3L1HBXT0Y66M7MJ0soa4=
X-Google-Smtp-Source: AGHT+IGFz+yEm4BTT1TYAFVaoUl9m79JJ9gAUbvFc6sOaubinySzDvbKypoTyLtyTLQjpUv8DoE5lg==
X-Received: by 2002:a17:907:a4c8:b0:a72:5fd5:ea02 with SMTP id a640c23a62f3a-a725fd5ec00mr613306066b.10.1719386688087;
        Wed, 26 Jun 2024 00:24:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7058f9e3f5sm441522366b.203.2024.06.26.00.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 00:24:47 -0700 (PDT)
Message-ID: <5215b589-d00d-4be4-9213-aaf547228fb7@linaro.org>
Date: Wed, 26 Jun 2024 09:24:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fixing property memory leaks on device tree overlay removal
To: Rob Herring <robh@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Conor Dooley <conor@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Herv=C3=A9_Codina?=
 <herve.codina@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240624232122.3cfe03f8@booty>
 <CAL_Jsq+=mGEJXsjq1UZFMJtHko_z+doiFMXnx9K7exDuznymSA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAL_Jsq+=mGEJXsjq1UZFMJtHko_z+doiFMXnx9K7exDuznymSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/06/2024 19:02, Rob Herring wrote:
> On Mon, Jun 24, 2024 at 3:21 PM Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>>
>> Hello,
>>
> 
> This is a great summary of the issues with further overlay support.
> 
>> device tree overlays are implemented in the kernel since a long time,
>> but there is currently no code using them, except unittest. The
>> largest (in terms of code lines involved) blocker for enabling it is the
>> memory leak of properties that happen on overlay removal [0]. The
>> kernel warns about it on overlay insertion:
>>
>>   OF: overlay: WARNING: memory leak will occur if overlay removed, property: /...
> 
> Maybe this needs to just be finer-grained and smarter. For example, we
> know when we've leaked pointers (because you found the cases below).
> We could set a flag in the node when that happens and then warn when
> removing the overlay.
> 
>> We are working on a driver for a proprietary connector allowing a device
>> to connect to an add-on board adding new non-discoverable hardware, and
>> the driver is based on overlays. This has been discussed during ELC last
>> April [1] and I sent a patch series implementing it in May [2].
>>
>> The property memory leak topic was mentioned but we haven't addressed
>> the detail so far. This e-mail is meant to present our proposed plan
>> to fix it.
>>
>> Receiving comments from the kernel community would be very valuable
>> given the amount of work involved.
>>
>> ===================
>> Problem description
>> ===================
>>
>> In the kernel every 'struct device_node' is refcounted so the OF core
>> knows when to free it. There are of course get/put imbalance bugs
>> around, but these are "just" bugs that need to be fixed as they are
>> found.
>>
>> On the other hand, there is no refcounting for 'struct property'. Yet
>> some of the internal kernel APIs to access properties, e.g.
>> of_property_read_string(), return either a 'struct property' pointer or
>> a copy of the 'char *value' field. This is not a bug, it is an API
>> design flaw: any user (e.g. any OF driver) can take a pointer to
>> property data that was allocated and should be deallocated by the OF
>> core, but the OF core has no idea of when that pointer will stop being
>> used.
>>
>> Now, when loading a DT overlay there are three possible cases:
>>
>>  1. both the property and the containing node are in the base tree
>>  2. both the property and the containing node are in the same overlay
>>  3. the property is in an overlay and the containing node is either
>>     in the base tree or in a previously-loaded overlay
>>
>> Cases 1 and 2 are not problematic. In case 1 the data allocated for the
>> properties is never removed. In case 2 the properties are removed when
>> removing the parent node, which gets removed when removing the overlay
>> thanks to 'struct device_node' refcounting, based on the assumption
>> that the property lifetime is a subset of the parent node lifetime. The
>> problem exists in case 3. Properties in case 3 are usually a small part
>> of all the properties but there can be some (and there are some in the
>> product we are working on), and that's what needs to be addressed.
> 
> I'd like to better understand what are the cases where you need to
> change/add properties in a node (other than "status"). I'm not
> entirely convinced we should even allow that.

Just to clarify that I understand the problem correctly - we talk only
about memory leaks, not about accessing released memory (use-after-free)?
I think that during EOSS 2024 discussions we reached consensus that in
general you will not have use-after-free problem with DT properties at
all. If all devices are unbound, their resources get released (including
some core structures registered in subsystems) thus nothing will use any
of properties. With proper kernel code there will be no use of device
node properties after device is unbound.

> 
>> The kernel just doesn't know when to release these property structures,
>> so the OF core code currently stores the properties loaded by overlays
>> in a "deadprops" list within the parent node. They will be freed when
>> the node itself is freed (based on node refcounting) in order to be
>> safe. However it means they are memory leaks for case 3, where the node
>> can be never removed.
>>
>> ====================================
>> Approach 1: adding property refcount
>> ====================================
>>
>> The first option we considered is the obvious one: adding a refcount to
>> 'struct property'. However this does not look like a very good solution
>> as every user of a DT property in the kernel would need to put the
>> property after getting and using it: this is already cumbersome and
>> error-prone for nodes, and properties are usually many more than nodes.
>> Besides it would add a memory and execution overhead to all properties,
>> while only a small fraction is affected.
> 
> I'm glad you reached this conclusion.
> 
>>
>> ===========================================================
>> Approach 2: change the property APIs to not return pointers
>> ===========================================================
>>
>> So we went back to the API design flaw and thought what API we would
>> invent if we had to start from scratch now with the laodable overlay
>> requirement in mind. We concluded the property API should just not
>> return any pointer to 'struct property' or one of its fields. In other
>> words, this is internal data of the OF core.
> 
> I think we also have to consider what Rust DT/property APIs will look
> like. It's the same problem as Rust has clear rules on ownership and
> lifetimes. So far, I've only seen of_find_property() show up, but
> that's not getting accepted on my watch.
> 
>> We think the API to access DT properties should instead do one of these:
>>
>>  1. check whatever is needed and return the outcome, not the internal
>>     data, e.g. like of_property_match_string()
>>  2. if that is not possible, return a copy of the property value, that
>>     the called will be responsible of, and which can outlive the struct
>>     property if that make sense
>>
>> With this approach, it becomes safe to remove the overlay at any moment
>> _unless_ one of these API functions is currently executing on any CPU
>> core. To ensure there is no race condition we need a lock, probably
>> using rwsem or RCU, to guard the APIs accessing properties. This can be
>> coarse-grained (one global lock, or one lock per changeset) and needs no
>> cooperation from callers, being all managed by the OF core.
>>
>> So this is is the option we plan to take.

... and this leads to discussion of use-after-free problem rather, not
memory leaks. Or I miss something here.


....

>> ~~~~~~~~~~~~~~~
>>
>> Transitioning to the new accessors is not going to happen quickly given
>> the amount of call sites, so we devised a strategy to incrementally
>> approach it while avoiding introducing new calls to the old APIs.
>>
>> The transition plan is based on adding a Kconfig symbol (a tentative
>> name is CONFIG_EXPORT_UNSAFE_OF_ACCESSORS) meaning “export old OF
>> accessor functions returning pointers to firmware data” and defaulting
>> to ‘y’ to avoid breaking current usages. When this is set to ‘n’:
>>
>>  - The old accessors returning pointers to struct property values are
>>    not built, or at least not exported outside the OF core
>>  - So any defconfig with at least one driver using the old accessors
>>    would just not build, which allows to easily find out what needs to
>>    be updated if one wants to remove overlays in their specific
>>    configuration, or to disable unneeded drivers that are not yet
>>    updated
>>  - The property leaks under discussion are not possible anymore
>>  - The deadprops list and the warning are not built
>>  - Note: we need to ensure automated test bots won’t set this setting
>>    to ‘n’ or they will fail
>>
>> Any code using DT overlays, including the connector driver proposed in
>> [2], can depend on CONFIG_EXPORT_UNSAFE_OF_ACCESSORS=n, to ensure the
>> leaking APIs are never called when runtime-loadable overlays are in use.
>>
>> Preventing new usages of old accessors will be important. Tools to
>> achieve that:
>>
>>  * Extend checkpatch to report an error on their usage
>>  * Add a 'K:' entry to MAINTAINERS so that patches trying to use them
>>    will be reported (to me at least)

Or just use lore/lei with proper keywords. I track few misuses of kernel
code that way.



Best regards,
Krzysztof



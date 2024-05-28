Return-Path: <linux-kernel+bounces-191926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082938D162A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10EA284EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96A813BC04;
	Tue, 28 May 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFqcHI+9"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BE1DA22
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884622; cv=none; b=HRaJL5sIv+KvfatxI+ZJa4OeF2OSpz5VKmV/oj3NyAswgdtHp+FNJtFNxQUX3khE+/UqP6QIq6ozD5RYNPSNXeT+jKMagX8tS/uU7Um4EHdb0V/+uXWw2yX35y4NuIraM/HV7ov56vUUrvLCjK1FrmSxJFKytjdYmb6ke2sc5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884622; c=relaxed/simple;
	bh=62Yr6owy48A7Bd4/GXidveMcM9mRsbwypirqtcWfpzc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ta+SizsqWAW2hY/G9A6sWj4WagbhTvVopvoacqFufTAUYuSwXavuKbXEE2U1IPwlKdk1k5cYIPXJDuTd2UFDWgtItK3oy9nZ2LihgSdGlPbsBCUhgLTZldXC7lOJghjRFN57++yexiU9WEBMA974w+a4HkyKzK2sPT6RlHvilRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFqcHI+9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso5047631fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716884618; x=1717489418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pi6iHB0ijBhXGVK0cWOeQi30kiv2TjaO2ZCKvgQya/w=;
        b=XFqcHI+9OSJ7LuQ+vOXm2z7hHAxa7p0IiaUJ29eeKMnH9iWPbklS5jhj4TazX9yqkl
         QqLD7jU6BpASlly6/nCpU3/BPmDCo4udt2ptf8wcvR14BXbC15xnq2dLAQEiTpVUbLsU
         W2pZtd2GLNjpgo7f3du0/b4TTGik06dMj5z4R6+92JU78rG26SIsHEK2UmvSmLPtkRFV
         JI1xhPQvgrJTJun5A0GChWEgdhQLLRhdjctaOXv5nFGs8GoZe7+DV+chTnItKWE5+Z55
         VPFWg6ih0OedMeHlqu6VFAvF7H/N0Uav1S6AAIGIzGaM/ynap1LW9YXnveR1UB5MiEot
         6hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716884618; x=1717489418;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi6iHB0ijBhXGVK0cWOeQi30kiv2TjaO2ZCKvgQya/w=;
        b=wIJKyXVpg8K+B9bR45lbsfmrspOhKbnyJ2wKvjg5B7ratO0Qk7aOaPkr3U/doQ80ug
         RI1MoHGJ5hLekHD0AqkDLnfawbjt0oo0tlK2T+2W3zqt/cNbUqJrSi+plRem2VXDdPu4
         bqL0a3fisoe2TLbveYzKa84rEB59bsxoQj6d0AupzYblB8s/9dVyhGjtn38Z6t5vF5B0
         j3dPd/VTFwUs5cHo2kXLw7KvsGY5w//aRFbyTPsX/Z2O6J7KBc2KSZQt1T6ZjLF/Ky7s
         AjaFOO+1i4utgMAVtNkvIZ7tjtuxEbfk8H+A572/S9kVKKWJug983xTuPmd7x08bumXS
         2Yyw==
X-Forwarded-Encrypted: i=1; AJvYcCXsl3IO9rJdS2ZDvlnmGB6ztEPi3VO4OdwDs8nsarGoz5ydmPOSXF0gCVJje0MJKZFLFpySrn42OSOzrZk1biqOcyz/LtnzQU07Xali
X-Gm-Message-State: AOJu0YzOa0pUe2LDKB95mx5cCcKwexxPV5fvxvL+08iD4lC40jlnk6yH
	wnnvrD7+SV2aMwTRcVTzr//f1zyhv/GWrmW+o1IfB1bE9wZo/fx9
X-Google-Smtp-Source: AGHT+IG8bIM1sfBJjY/FNumKMuGJuuy+pEa+co4Vui8+zjT/05PSc9hHJ+EGJC5HXhKcpl6ydGtmSA==
X-Received: by 2002:a2e:6e12:0:b0:2e7:5bd4:acd6 with SMTP id 38308e7fff4ca-2e95b0bd9b9mr67528011fa.13.1716884618149;
        Tue, 28 May 2024 01:23:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:ac9:e686:e225:3764:719:c2ec? ([2001:b07:ac9:e686:e225:3764:719:c2ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08cc1bsm11113020f8f.45.2024.05.28.01.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 01:23:37 -0700 (PDT)
Message-ID: <bf963861-cc26-45e3-a4a1-82e2ea51a74a@gmail.com>
Date: Tue, 28 May 2024 10:23:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: Re: [PATCH 0/2 v4] drivers: arch_topology: introduce automatic
 cleanup feature
To: gregkh@linuxfoundation.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, javier.carrasco.cruz@gmail.com,
 julia.lawall@inria.fr, linux-kernel@vger.kernel.org, rafael@kernel.org,
 skhan@linuxfoundation.org
References: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240513081304.499915-1-vincenzo.mezzela@gmail.com> <ZkHlHAj1aPEToEYO@bogus>
Content-Language: en-US
In-Reply-To: <ZkHlHAj1aPEToEYO@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/24 12:02, Sudeep Holla wrote:
> On Mon, May 13, 2024 at 10:13:02AM +0200, Vincenzo Mezzela wrote:
>> This patch series introduces the automatic cleanup feature using the __free
>> attribute. With this modification, resources allocated with __free are
>> automatically released at the end of the scope.
>>
>> In some cases, modifying the structure of loops is necessary to utilize the
>> __free attribute effectively. For example:
>>
>> ```
>> struct device_node *t;
>>
>> do {
>>      t = of_get_child_by_name(..);
>>      if (t) {
>>
>>          // some code here
>>
>>          of_node_put(t);
>>      }
>>      i++;
>>
>> } while (t);
>>
>> //       ^
>> //       |
>> //  device_node here
>> ```
>>
>> To use the __free attribute here, we need to move the declaration of the device_node
>> within the loop, otherwise the automatic cleanup is called only at the end of the
>> function, and not at end of each iteration of the loop, being it scope-based.
>>
>> However, moving the declaration of the device_node within the loop, we can no
>> longer check the exit condition in the loop statement, being it outside
>> the loop's scope.
>>
>> Therefore, this work is split into two patches. The first patch moves the exit
>> condition of the loop directly within the loop's scope with an explicit break
>> statement:
>>
>> ```
>> struct device_node *t;
>>
>> do {
>>      t = of_get_child_by_name(..);
>>      if (!t)
>>          break;
>>
>>      // some code here
>>
>>      of_node_put(t);
>>      i++;
>>
>> } while (1);
>> ```
>> The second patch eliminates all of_node_put() calls, introducing the __free
>> attribute to the device_node.
>>
>>
>> changes in v2:
>>      - check loop exit condition within the loop
>>      - add cleanup.h header
>>
>> changes in v3:
>>      - split patch in two
>>      - fix misalignment
>>      - fix checkpatch warnings
>>      - replace break with return statement where possible
>>
>> changes in v4:
>>      - fix commit subject
>>      - fix coding style
>>
> Looks good now to me.
>
> Acked-by: Sudeep Holla<sudeep.holla@arm.com>
>
> It is merge window now, so there is a chance that it may get lost. You
> may have to post it again at -rc1. Greg can then pick it up for v6.11
>
> --
> Regards,t
> Sudeep

Hi Greg,

hope this message finds you well. I wanted to kindly follow up on the 
patch [1] I
submitted to introduce the __free attribute in drivers/base/arch_topology.c

Thanks,

Vincenzo

- [1] 
https://lore.kernel.org/lkml/20240513081304.499915-1-vincenzo.mezzela@gmail.com/


Return-Path: <linux-kernel+bounces-178368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347C8C4CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A158D28241C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617210A22;
	Tue, 14 May 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN+yilHE"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2BD304
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670849; cv=none; b=bSuAVDdEqX0P3DNot/n+zmB0cAgj3jDSnsHsXQVmlv7o9pMvnvac9zGP4sZ6ILH0rR9590LJlOJHryC9T+9VNfDEqRRKjV+oEmmGTz9xJo1tnrzBiwld0M/6QdCAwqiCocVCEpLXVVyQVUyGZgkCqCeTPKcwAlXB3Tv3amotmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670849; c=relaxed/simple;
	bh=tTD0cWYej9ORsfWNkVQZqKAP4MKVnJ3cWaPkJ5aUSC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+cvYZxNmHlaDI17nw4+fyf/7rJIdjvtSv0bLF7z7a/i/15hyQXrj7fbW7/76XMyocX3NuKkkiD50aKpdHKDioy5paSrlC5csvaPGz0zi58lCtu4ZlbZI4hxx9JSh85xtWxWA7xAbrVRhJVuG8qI//BNiyuJaFd3tWfzy0jDn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN+yilHE; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2df848f9325so66331191fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715670846; x=1716275646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2M54heS1wREd+pPH9WixC6wnUwS8Se0aMuzWM9ii2oY=;
        b=kN+yilHER0ahoesFqgwR4lyuRw7cG90CX6BzZgoj7WdllZBJtEfjhD7jHCdBHdORkH
         OCSCz/OXusZwwuurO8z9j5f/nmnRRZRvedMenwtsym39Fp/XvUGVvLb+3Jdruh9DmLUk
         MfPCX1VWPxWlks68JSuVcIe1pUXpFTlpjJZ/JYzS3QpG+5cgzcpdQsv4zTpPR6tlp36N
         Mk/+cKbja6GbgnCuQYYeEFf6EQKZHTCUM8tD1orcyrvVt6KDoDGvCSvCxdBVDJIC8BRE
         B3E/+q6GhsRp4G5KgOLfWwEsgEyUbGl5Upb7ftYKquLuJ2ViFIkZ+sHYjeb/QNyg6N4g
         tWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715670846; x=1716275646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2M54heS1wREd+pPH9WixC6wnUwS8Se0aMuzWM9ii2oY=;
        b=GEQwr+c10LpzvwCC81IAy+Ml5zoSUO0of8i4wbZbtF6JYunN8lQ39kWRs+sViRNiwO
         pcwNlZG8DkFRKVQ68d1U7A/L1flmE5Bvh3Gz21wl1ihn3rwBm0YiFhLeWy0JB5kaXLhW
         Qh+eazmkjmp0MHVBt9uct48+x2Nq42bcZd/TBFhfYZHNYb1NrZgc8/M7aDRh+TRv+hTl
         wwmgAujwLQTGqoZdJasZ2S4wAfksMntih0zgDxmV/tR3rMCmh/ffcpKtyD/MgFWuZgtP
         QtzqdURJuW+ms6yiLJC5TGflw/nuKuFuNvTMjguPqFj6+ykNgUUpAV4fDD+4h8ezCEvJ
         0aLA==
X-Forwarded-Encrypted: i=1; AJvYcCVzrmZYcQSMCK1BAyr+rpdMIxm8mJcmnO0ZWrI3jl63apt3ezl9oC0oA+A7zsWBQHOPq14LLISrmWIK/Sc/Fh4BcJ/ekjDCeTRdwbvZ
X-Gm-Message-State: AOJu0Yzzs58M5j97LI+s5kT03/cLfPQ1vRS3QsehrbkVDjRh2FPo2Df+
	/jOf/M+3pIIfUkF2dLlYuqt8AewGncpmWJkWGAiWC+wr72ydWQJi
X-Google-Smtp-Source: AGHT+IHE8uuq8d6lDEFbCFyjcSusLCXU1JAMQ2bNa5eUgRYG8g7FcxGtUq6r+vgq3L2G/+Ll89hBlA==
X-Received: by 2002:a2e:914d:0:b0:2de:74b1:6007 with SMTP id 38308e7fff4ca-2e52039bd3emr92659281fa.36.1715670845980;
        Tue, 14 May 2024 00:14:05 -0700 (PDT)
Received: from ?IPV6:2001:b07:ac9:e686:5e62:2103:8d45:ece8? ([2001:b07:ac9:e686:5e62:2103:8d45:ece8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce24c0sm183119895e9.17.2024.05.14.00.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 00:14:05 -0700 (PDT)
Message-ID: <8a0df605-463f-4d61-ad64-a39f3ebb3153@gmail.com>
Date: Tue, 14 May 2024 09:14:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2 v4] drivers: arch_topology: introduce automatic
 cleanup feature
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
 julia.lawall@inria.fr, linux-kernel@vger.kernel.org, rafael@kernel.org,
 skhan@linuxfoundation.org
References: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240513081304.499915-1-vincenzo.mezzela@gmail.com> <ZkHlHAj1aPEToEYO@bogus>
Content-Language: en-US
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
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
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> It is merge window now, so there is a chance that it may get lost. You
> may have to post it again at -rc1. Greg can then pick it up for v6.11
>
> --
> Regards,
> Sudeep

Ok, perfect.

Thanks!


Vincenzo




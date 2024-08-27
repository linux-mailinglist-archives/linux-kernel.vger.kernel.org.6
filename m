Return-Path: <linux-kernel+bounces-303397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA457960B88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48872B25BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A91BFE08;
	Tue, 27 Aug 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUpm4MfD"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B591BFE01
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764365; cv=none; b=N/rCCoxtllTDnt7yD9VPDCKY+BITt42MMxpfYGy+y/ZQYAvrdOFAJbfP3Ow5JHjmSSfjI/WXZvzn0wq4rHvOoMi+0nOLl72lMrrvsyHB4ly8wpa+K78T6bGkEQAJqWTBoWecAfcigw+JE6+oUn6ikQ4vWbCMWpoU1yTRLN7+UXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764365; c=relaxed/simple;
	bh=rQgRDesIzQklWac5GhvVr+62VbJaDtwUWCUo2+Vke8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmdnHc5fV4KEH87zVafKrmTgwJbt9ZnOZW80FSV3GAixNBZ999ryfdNH/dtV/sJ3f3aQ8wsLf5PB114ShW3fj4/fwEAikJuYIPpw2xhq8TXKZ4nwUAZt9+j3s0rw4rjw5NzK09ULbvqLi4gDO7K0IUPIBl8zSqATUZ8ShJzEf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUpm4MfD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-204d391f53bso17226265ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724764363; x=1725369163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Tl3rkwR3GbnvJ9cLIypxJvHDjBIdx+vsvF7+3hzGM0=;
        b=PUpm4MfDV1CBf6jFMd6xbgGHyO70En/DsX1xiC+NGe9msh70yqU2uGP/Gn3YjaBhfO
         bcYbc5bChF7aiY2uWmfKNJ3oUjc8sW/L98H6NARgCzd6znyK75n17XmsYWygR7hsflDc
         FW1NcdPRbWD4CuAhQkoYcfUY1QgD01X4y1e0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764363; x=1725369163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tl3rkwR3GbnvJ9cLIypxJvHDjBIdx+vsvF7+3hzGM0=;
        b=B7DfkQBuTKh0g+XsXpvopNg/KZ+ICJAzOt5R0hXcZq8lk0uCTp7bU7nyYEm1eFP3Db
         g7jnNe/IOQRMBKTYwCOgJtow52ohYkRA0+CAOlavJVxZ3FGo4zMGfuILFt7V/tnrM0wc
         fna6d9r8Ssg4ThLNc922FJ2XTbqmeOrV9hshaHAClCLC+JfGDCGwEwhHHSmag/hHfcCY
         cwd6lnsX0ydNI8icVcJey9enuO4G6ymrgbfpwBKphVPVKeRZVdoyxy0FTY953u5MDGTs
         Qiw2ogFfYcneFQvrUmP5wz0Mr3enc/7DFQOQlSQJUXZrBLyuW5efBeVp4PcYY/hvdhJS
         +Hug==
X-Gm-Message-State: AOJu0YzLcpbQHAkNkb46gNjG5+b3dE6n/ZJf+yFjJnfSrmVlYqBa0vJn
	fC1XKOQESjCOLAdWqI+KRV2R7RPnWm7pJBAzriuCbif6OBxazDDrep25rF5ukck=
X-Google-Smtp-Source: AGHT+IHAx1s797kwqvCGuNuI5cLAo0Hep/rE3ZJzRytOFCbJKRUUyMxJ4P5a0TixYSM0XX9xk5JgUw==
X-Received: by 2002:a17:902:dac1:b0:1ff:4967:66b with SMTP id d9443c01a7336-204df4fb9d1mr29261145ad.56.1724764362701;
        Tue, 27 Aug 2024 06:12:42 -0700 (PDT)
Received: from [192.168.121.153] ([218.49.71.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560faddsm83234345ad.231.2024.08.27.06.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:12:42 -0700 (PDT)
Message-ID: <f9e2d443-9d20-498a-a2d7-fa2e13fbb3f9@linuxfoundation.org>
Date: Tue, 27 Aug 2024 07:12:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vDSO: support DT_GNU_HASH
To: Xi Ruoyao <xry111@xry111.site>, Fangrui Song <maskray@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240815032614.2747224-1-maskray@google.com>
 <29c04b2f2b35588824447f4c91d3c89ed3ed8895.camel@xry111.site>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <29c04b2f2b35588824447f4c91d3c89ed3ed8895.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 00:07, Xi Ruoyao wrote:
> On Wed, 2024-08-14 at 20:26 -0700, Fangrui Song wrote:
>> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
>> obsoleted for more than one decade in many Linux distributions.
>>
>> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
>>
>> Signed-off-by: Fangrui Song <maskray@google.com>
>> ---
> 
> Ping.
> 
> Some context: I'd change LoongArch vDSO to use the toolchain default
> instead of forcing DT_HASH (note that LoongArch is launched decades
> after all major distros switched to DT_GNU_HASH), but without the
> selftest support we'll lose test coverage.
> 
> And now ARM64 has already lost test coverage after commit 48f6430505c0.
> 

I am seeing several checkpatch errors - please fix them and send me v2.

thanks,
-- Shuah



Return-Path: <linux-kernel+bounces-363793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5196599C71B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CCE1F231F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579815B966;
	Mon, 14 Oct 2024 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIx97Dxk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26791581F4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901565; cv=none; b=iH5d5wRCBpsC979w7S/abj1lbRV/bErM7CLTbiVNLqhmbbv/wUl47uSc9LV8umcttqSYqea7jxFteh5eh2pmUIi2/39jKc+vnDzu1yGwXRMyMBt7fPl5SXNXX66Y7m0lMmNdeBwq9Wmbr0Ocw5/Cf3+NZQmuYpALh+UTxzAZv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901565; c=relaxed/simple;
	bh=/ST6Ws2sKBTO7rJLa2AQ4+qZHkmohIDh9s3LeMC0jCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y55LuFc0xPGZjOCMbX8hjb3oSZfuoMZaIq3kc3hjqbippPy4/VExcqk99UoTPK2XVOb4jPOHHPMdQ7YZZDm5Is6emAIRVcPiLC2J67a553H57iZ6H6RCnRbXpuUJ/bLQVK4a87iL1VtThiMwbfjd1MFbpPLD9I6XP8McvACI6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIx97Dxk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728901561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iehd1BNUIpWUCUdYEOtgXTd08uhD2ebuXNn5tihq+ko=;
	b=iIx97DxkaADwL/5CQH/Rt5QC8OowkqUcr+46RUw1kMVE2U+Kp1VAMFCMguPC08oXeu4NQU
	8NmNh/jrQiWFjuDGxJQzY7hdMEy1w2xY+FMpHIQpvc4UewztzCt4NIZ4ZuIxegW+iF9uli
	QK6XHKWkAPhd+ddv1wYYRe6SoI+Oi44=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-Y2nA3YfmNYmiIsAXnK-T0g-1; Mon, 14 Oct 2024 06:26:00 -0400
X-MC-Unique: Y2nA3YfmNYmiIsAXnK-T0g-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7e9b2d75d6dso2875688a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728901559; x=1729506359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iehd1BNUIpWUCUdYEOtgXTd08uhD2ebuXNn5tihq+ko=;
        b=vi3BEG1U59iF3s9dCpQLYIN6J53YzafCPMUQggqAbdAh8z5BR450EtJOxp0ZOp14Cq
         5lvbB5jg4sRM2Xi4grq8iqpshWMQCTANRWSZJfpuHRAhKm09ZXusMlLU1hLdYmkm5zfy
         wJbM4UVpdiz0hGXBa3oAyGbH8xh5FssMGBQO6HWYzutBTnm+CPb7yD3GBUhnACDoPBsN
         qyG5gXZf9Q1BJqWnKwvpBoXGiBKrLI7vz6r0IqBNP5xiDIOiWyHCJvxHNz89Zw77lPVa
         tXE4iMs3DYJXltRNOrrq0S4/p13NLIphSyhySdx6ZDUVIHl52TrjeJBWCUJulmbrVe/m
         SA6g==
X-Forwarded-Encrypted: i=1; AJvYcCUmm6MakR4olQ75xKkfXugJsHRIAnErFvRjVLs/fFItI1eGcKZhiUlXyPgw4KnqNAjJ9jObu4+B7pLtEco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6U6LfDa3c1h4HTUUVc6XNFnTxHm6NG6kDVkIjvmtOs4vjLJN
	aOj+m2Ydj7Cb+GZP6bNEd97u6AwJtkcZKq8iWifhZXlvZQXaJd9A5J7CsJeEsXt1gucH8u2j0ov
	TTJCb7FF3Y74kAnffXpG3COgBDdSPE6QGpfcsoWZX2lqNxJKQ06Bi/KBvvochPQ==
X-Received: by 2002:a05:6a21:99a2:b0:1d8:abc6:71a4 with SMTP id adf61e73a8af0-1d8c955c952mr12602176637.6.1728901559025;
        Mon, 14 Oct 2024 03:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4S//5Qp+Gm5n0MIrRdxlFSCJcr23jiAU6pfy10eWEnVFM06aEmjGnFNJFwF+uQsl3N7XTfw==
X-Received: by 2002:a05:6a21:99a2:b0:1d8:abc6:71a4 with SMTP id adf61e73a8af0-1d8c955c952mr12602145637.6.1728901558605;
        Mon, 14 Oct 2024 03:25:58 -0700 (PDT)
Received: from [192.168.68.54] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4495a75asm6524493a12.65.2024.10.14.03.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 03:25:58 -0700 (PDT)
Message-ID: <2ea2b741-3abd-4fe1-b622-b6a4a3c2a92b@redhat.com>
Date: Mon, 14 Oct 2024 20:25:54 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: arm_ffa: Fix warning caused by export_uuid()
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com
References: <20241014004724.991353-1-gshan@redhat.com>
 <ZwztgGdmNMrsqO7c@bogus>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZwztgGdmNMrsqO7c@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/24 8:08 PM, Sudeep Holla wrote:
> On Mon, Oct 14, 2024 at 10:47:24AM +1000, Gavin Shan wrote:
>> Run into build warning caused by export_uuid() where the UUID's
>> length exceeds that of ffa_value_t::a2, as the following warning
>> messages indicate.
>>
>> In function ‘fortify_memcpy_chk’,
>> inlined from ‘export_uuid’ at ./include/linux/uuid.h:88:2,
>> inlined from ‘ffa_msg_send_direct_req2’ at drivers/firmware/arm_ffa/driver.c:488:2:
>> ./include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ \
>> declared with attribute warning: detected write beyond size of field (1st parameter); \
>> maybe use struct_group()? [-Werror=attribute-warning]
>> 571 |                         __write_overflow_field(p_size_field, size);
>>      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Fix it by not passing a plain buffer to memcpy() to avoid the overflow
>> and underflow warning, similar to what have been done to copy over the
>> struct ffa_send_direct_data2.
>>
> 
> Are you observing this just on the upstream or -next as well? There is a
> fix in the -next which I haven't sent to soc team yet, will do so soon.
> 

I just tried the upstream when the patch was posted. I just have a try with -next
and similar error exists.

[root@nvidia-grace-hopper-01 linux-next]# git remote -v
origin	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (fetch)
origin	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (push)
[root@nvidia-grace-hopper-01 linux-next]# make W=1 drivers/firmware/arm_ffa/driver.o
    :
In function ‘fortify_memcpy_chk’,
     inlined from ‘ffa_msg_send_direct_req2’ at drivers/firmware/arm_ffa/driver.c:504:3:
./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: \
detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
   580 |                         __read_overflow2_field(q_size_field, size);
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


Part of the changes included this patch is still needed by -next. Could you please
squeeze the changes to that one to be pulled?

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 8dd81db9b071..b14cbdae94e8 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -501,7 +501,7 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
                 return ffa_to_linux_errno((int)ret.a2);
  
         if (ret.a0 == FFA_MSG_SEND_DIRECT_RESP2) {
-               memcpy(data, &ret.a4, sizeof(*data));
+               memcpy(data, (void *)&ret + offsetof(ffa_value_t, a4), sizeof(*data));
                 return 0;
         }

Thanks,
Gavin



Return-Path: <linux-kernel+bounces-206043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1887D900392
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3119C1C20A55
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175221946DB;
	Fri,  7 Jun 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv+lbW9m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6596194154
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763303; cv=none; b=s40b5iU4OFrOC7ZRngRGJDI8FykRSLRcESW2KQCzHVHWFrMw5rfqhyjZbFMpHhoauCiXxv+3X8EJJz4P3Z6Qof2kYBzXjjMLysPCJS6Ds2laxLTFys46ANqpBtdjTE3qRB8tUMKCDc0nZQVAkUDypV3HJbTZ9TFrEIQnARrOGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763303; c=relaxed/simple;
	bh=2F/1Pw7fg7p1sCas1pMb+GrJ4VRYXNwcvb/GukSp7IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+ZZql5rcEamJCpJneNcs3p3xnV4cEs3/bTuKUdKxHuYY/LelZRgoXbJOw9gQlIH2SkzwgPocLEZTBiW958WZgVX1ovFXZNPes9GmAoEGp/zLmy9ztSr3v1FWVYmq7N2Ao36yln+A/RNodmMvKnw/vvLVOSll+DO2wM54xNxucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wv+lbW9m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FypPKgT3pJsp6KviCFXO/ORbTvZxCPQ2jaD/DLtQnPQ=;
	b=Wv+lbW9mJWyv+0ca23oXV535j4WiY4KeWE1sE7A2O8GrgOwFFaq3ZyqKyAU785Vai1tjm2
	tW/0IFrn8GqMVWs4R1N8UdEoBGgMhaOiTF7ssq74ChJc8TTBCFD5BJTiTQnIyWMNkKEVDR
	qAza59gjwBcAp4S39I1LXmxHD/bGReY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-hIVw5t40P4iTQmAlYOWObA-1; Fri, 07 Jun 2024 08:28:19 -0400
X-MC-Unique: hIVw5t40P4iTQmAlYOWObA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6fb22ecd976so1413942b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763299; x=1718368099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FypPKgT3pJsp6KviCFXO/ORbTvZxCPQ2jaD/DLtQnPQ=;
        b=FfYWJNqJgnxincwJrmGrKYAAbhFm7xkJHTOVZivC0mbKASxND1z5ev/Nkq91tunDQi
         CacS8GvYj9jn+OqjTq1I3FCi7uMynFD0/mu+177eXhXD4SXiAoBVnm9FIFRNnIOF3xRV
         tA/5ZkvMqNtLMs/JIAPCEiAGwvjBJSk8FS1ieRagTZDhvXpdjrAIzUziSLGbnB/5Q9Jb
         XUZvyEB/rpzP9+9F3RSt2ctkDnUUs1fyhA3T4mAhLGkU7d2m6rxLzodMcZPXTu/CZo35
         vVtsYiR5is3200JL1NCp9Xbpc4rsbuTL2fSQpsB947wGmdn0elQIcw/IdeqFICtkTZKu
         mXtg==
X-Forwarded-Encrypted: i=1; AJvYcCX9SUZcezBIsXEAvRIlaELosL6zv1TCl+ccRrI1BhSTTp5MW9deZHe9ZWYecGOQwmksaFbn/M0i68qOPHWxcYLZ4sluRB1VUlHjhQ2I
X-Gm-Message-State: AOJu0YwWJgveK3xYygwirOSXofj0wT2voDYNqta4ubDQn6iOUpT3Ddyf
	Hjdx6kNYSrguYW18lpnEoIZXGEj8r/vNPQ+1+u6hslG6eXcVBe1mQ0IPm3BT2yBbzh8rV4mSMgJ
	VxFpoWcq/w4QK7k9MJouOBCmy9zPFD1pZpOP2sXgH8stfT7/kNVPJQR2s2FQ77A==
X-Received: by 2002:a05:6a00:23c2:b0:6ed:825b:30c0 with SMTP id d2e1a72fcca58-703f88de73amr7817551b3a.15.1717763297900;
        Fri, 07 Jun 2024 05:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqa9G1P1Nfp6M4MFxgwat4T28EeXX617ZqUou6xSlSloKgK/kupjGqVmTHU4L88C/jIn2KRQ==
X-Received: by 2002:a05:6a00:23c2:b0:6ed:825b:30c0 with SMTP id d2e1a72fcca58-703f88de73amr7817489b3a.15.1717763297022;
        Fri, 07 Jun 2024 05:28:17 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3a3a87sm2486990b3a.82.2024.06.07.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:16 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:07 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <epa3mtnac3ekyoq7zykyjnhu3i27mivbtlkss6mbjyaa3kmhof@qwbfshfbtei4>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>

On Tue, Jun 04, 2024 at 04:51:03PM +0800, Baoquan He wrote:
>Hi Coiby,

Hi Baoquan,

>
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
>> the dm crypt keys persist for the kdump kernel. User space can send the
>> following commands,
>> - "init KEY_NUM"
>>   Initialize needed structures
>> - "record KEY_DESC"
>>   Record a key description. The key must be a logon key.
>>
>> User space can also read this API to learn about current state.
>
>From the subject, can I think the luks keys will persist forever? or
>only for a while? 

Yes, you are right. The keys need to stay in kdump reserved memory.

> If need and can only keep it for a while, can you
>mention it and tell why and how it will be used. Because you add a lot
>of codes, but only simply mention the sysfs, that doesn't make sense.

Thanks for raising the concern! I've added
Documentation/ABI/testing/crash_dm_crypt_keys and copy some text in the
cover letter to this patch in v5. 

>
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/crash_core.h   |   5 +-
>>  kernel/Kconfig.kexec         |   8 +++
>>  kernel/Makefile              |   1 +
>>  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
>>  kernel/ksysfs.c              |  22 +++++++
>>  5 files changed, 148 insertions(+), 1 deletion(-)
>>  create mode 100644 kernel/crash_dump_dm_crypt.c
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index 44305336314e..6bff1c24efa3 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
>>  static inline void arch_kexec_unprotect_crashkres(void) { }
>>  #endif
[...]
>> +static int init(const char *buf)
>              ~~~~ A more interesting name with more description?

Thanks for the suggestion! I've added some comments for this function
in v5. But I can't come up with a better name after looking at current
kernel code. You are welcome to suggest any better name:)

>> +static int process_cmd(const char *buf, size_t count)
>                                                  ~~~~
>If nobody use the count, why do you add it?

Good catch! Yes, this is no need to use count in v4. But v5 now needs it to avoid
buffer overflow.

-- 
Best regards,
Coiby



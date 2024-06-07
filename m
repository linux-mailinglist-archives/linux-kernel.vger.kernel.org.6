Return-Path: <linux-kernel+bounces-206042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BB900391
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6C3B25718
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE07B19413D;
	Fri,  7 Jun 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSWjvATN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB3194120
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763298; cv=none; b=bGOYsT9+RGk5UCEszOuxEmfCJq8qzngcbfbtcTABMNlinwM9Esf8tlK6VGaLjX7D0cOMVlovpqINpMldTP6iZkGS9WeYuADdHx2wXqCv5jR09Aw7SNelWHjMH+3VMLQRgEx4eHF3gSfaBLVoJ2IBLm1R3rhW5KJyABGJPo+BeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763298; c=relaxed/simple;
	bh=1aAMjrd4AzwLefMt1KVwrNuAUPL1gW3qkJxQ6CaUyXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekCySa9sie6lDaT4AZtDmMG/ow/oGugf/ucNr2iqFgdyh1yAsZi/uzGy0Wv2Rc6zyPm01Q5FCzQ793gUy0n1Y++ySotTM2l/u1VwWTBPnukwEuhpA57nwcd+hsz/KhLYH4IasKCrXFuDKUcadiQBcDmsgRa+znl0C7o07NaQ860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSWjvATN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/t6956UOv5lCksdjLk7UvP2/agO8Fjf4ixoixsQ5vC4=;
	b=eSWjvATNNTHaqJTnMt6FVtD7vaWRaqROg6ATMbNj1ugKRl8myPjW5jsj7PH75nscLfdnNI
	88/wYfHA72y7JrSecmRFDFsAITA/Ioq2ZMYqvm5tFjlgDhz+qVE5a8EPUvdMc48gUyWSma
	/lRg0dXX3/1m/imUwGZSrkRX8N69XO0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-7gH3fHBfOpe4cX0RnSYyfg-1; Fri, 07 Jun 2024 08:28:15 -0400
X-MC-Unique: 7gH3fHBfOpe4cX0RnSYyfg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6658818ad5eso1627340a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763293; x=1718368093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t6956UOv5lCksdjLk7UvP2/agO8Fjf4ixoixsQ5vC4=;
        b=nhyUA24IVTSgBZOaO0KV0Qdh/XlQLScc5TEEdV+CVJWNnKfGhbLC/PIsTDnFMUBYch
         Z5RI37lZRaXqgA+Fbq9jLc62Ye8f6HSRLhh5V5rjc2B3b6xD9zZqiexYJkWSsRR3rrEc
         SWClMWJZenY4H2as/SObmgmm67WdxdfVUR5BBRND00eUrEzu7AFijHaFLYAf6Wu5vALR
         M4OdeDSZc5lKXvS6vGuMcsSpF+xMPL2CRemJpyuOs7eCj4c3DCxwuP8eEYvDRHfru5/t
         TeY6UvLyE2qjvvnFgXEJtdzEPtsLF3sTP6R8cO74lYtqK8bq3iG8F4A5RvFOGvmI2YPn
         DcLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrs+gWkZP1hrOGB+sv44A5A4dt3QVd0Ho7UFSEwBVXsOvBiX4OuIRc2Yn6kkSXuE6/Sa7M1PVPdtU2ZH0oBj/7BYZYRM1sdDcIDk+U
X-Gm-Message-State: AOJu0Yz9LQFWA9uYeK0U2ps0Kh/mZIA3Ur6Bpp5wdGY03kxQK4ws4N0b
	7y5T9l/t+z96L0PhDwSyHFD9+GrHr/DwyUeWux0xMz4xBVSCn6sWIjAw1vK+q2RMpZciOTUyNHz
	JGXvP/RJqgJ0JOVhzg6BTPh7Pl+j6ISaMsqLO8XXKfzaD6JBzpMO6DHfDGfGd8Q==
X-Received: by 2002:a05:6a21:32a7:b0:1b4:68a2:908b with SMTP id adf61e73a8af0-1b468b1d6b1mr654923637.14.1717763292882;
        Fri, 07 Jun 2024 05:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQo9mPlRLCIa6N5kRoMuchaJ04EmyjXCzB3G/zjo7E3SC6tybqM+xniohJslEjmSTV/Ig+lw==
X-Received: by 2002:a05:6a21:32a7:b0:1b4:68a2:908b with SMTP id adf61e73a8af0-1b468b1d6b1mr654885637.14.1717763292099;
        Fri, 07 Jun 2024 05:28:12 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70410b976a9sm942536b3a.147.2024.06.07.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:11 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:26:54 +0800
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
Message-ID: <y5ah5hdueqh5l5m4ll6qdebvnkvkdfbghvjprgyfeacajo3nhj@zg7qj6vfo3w6>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmEo4rw8Yhu7tspb@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmEo4rw8Yhu7tspb@MiWiFi-R3L-srv>

On Thu, Jun 06, 2024 at 11:11:30AM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
>> the dm crypt keys persist for the kdump kernel. User space can send the
>> following commands,
>> - "init KEY_NUM"
>>   Initialize needed structures
>> - "record KEY_DESC"
>>   Record a key description. The key must be a logon key.
>
>This patch highly lack document to describe what it's doing. For
>example, how you will manipulate the /sys/kernel/crash_dm_crypt_keys to
>initialize, record the keys, can you give examples how you opeate on
>them?

Thanks for the suggestion! v5 now includes
Documentation/ABI/testing/crash_dm_crypt_keys.

>
>>
>> User space can also read this API to learn about current state.
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
>>
>> -
>> +#ifdef CONFIG_CRASH_DM_CRYPT
>> +int crash_sysfs_dm_crypt_keys_read(char *buf);
>> +int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
>> +#endif
>>
>>  #ifndef arch_crash_handle_hotplug_event
>>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
>> index 6c34e63c88ff..88525ad1c80a 100644
>> --- a/kernel/Kconfig.kexec
>> +++ b/kernel/Kconfig.kexec
>> @@ -116,6 +116,14 @@ config CRASH_DUMP
>>  	  For s390, this option also enables zfcpdump.
>>  	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>>
>> +config CRASH_DM_CRYPT
>> +	bool "Support saving crash dump to dm-crypt encrypted volume"
>> +	depends on CRASH_DUMP
>
>Do we need add dependency on some security features, e.g KEYS?
>The current code will enable the CRASH_DM_CRYPT regardless of the
>existence of LUKS disk at all.

Good suggestion! I make CRASH_DM_CRYPT depend on DM_CRYPT in v5.

> [...]
>> +static int init(const char *buf)
>> +{
>> +	unsigned int total_keys;
>> +	char dummy[5];
>> +
>> +	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)
>> +		return -EINVAL;
>
>This is what I wondered and tried to find a document to get why. Can we
>search in the current system and deduce how many keys we can could use
>for kdump kernel? Or we have to retrieve and pass it from user space?

I don't think we can get this info from the kernel space directly
because the kernel don't know the kdump target. So we have to pass this
info from user space.

>
>> +
>> +	if (key_count > KEY_NUM_MAX) {
>> +		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
>> +		       KEY_NUM_MAX);
>> +		return -EINVAL;
>> +	}
>
>Why chekcing key_count in init()? Don't you need to check
>total_keys instead? Clearly you don't do a boundary test for total_keys,
>otherwise it will trigger issue.

Good catch! Yes, I should check total_keys instead.

>
>> +
>> +	keys_header_size = get_keys_header_size(keys_header, total_keys);
>> +	key_count = 0;
>> +
>> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>> +	if (!keys_header)
>> +		return -ENOMEM;
>> +
>> +	keys_header->key_count = total_keys;
>> +	state = INITIALIZED;
>> +	return 0;
>> +}
>
>Please add more code comments, kernel-doc for your code, we can't assume
>people reading these codes know the entire matter.

Thanks for the suggestion! I've added some comments and documentation in
v5. Please let me know if there is anything more to improve.

-- 
Best regards,
Coiby



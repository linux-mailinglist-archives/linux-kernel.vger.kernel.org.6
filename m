Return-Path: <linux-kernel+bounces-188413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25AB8CE1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5ACDB2115E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C307C839F1;
	Fri, 24 May 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6wEbBBN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AF6FCC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536755; cv=none; b=sV0PSJLED/NBNxh2phhtsBql7xLGFfGgHjv34zYXhOWxBMVBRafhXuXNou3Fcq/zbg5xVVR3aSX9ebKBbzkCGbbr4Vxfqh/yWLtHWVjnhh6Qhy9vQWQeuSazjQMadOcwJqJxuXPiYFwk3PiBK93p9u11f+Um+Ouea2tirJQbWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536755; c=relaxed/simple;
	bh=elPQAisHqjTMgnbiCeYkS3YTy1j6Z9gqGDuwGjDHQWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR0O4UFoPOFwbH842jaWSoyi1dPjV6EVgG42ph+lkMfsReBR4zXCSOBf2wa7gtZly69lpQCbr82CxMNS/rfCE2DwvZYAWONvjnN01HQ9+SQanvRbhrgckpK/M19YagW+j5hEh+ye7E97w5oJUnW0Lkas1rjY18Y1r/VHW60TYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6wEbBBN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716536752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pIey9Tt9vhLMK+qG1+4Gr5NV0hqgLZ0e2VrJaCmvI8=;
	b=V6wEbBBNbd02JkaeO9cFAfcNEU6Z7lDrIux/XvwWVgy0zZq3k+MvqtdIM99OSCAC+3nYad
	xspblZrG4uXd/9e+0HhEXInw3CbLTjrLJ/akyfLCkYPvesykoaB1Wp2rQL8eDhVPQrvYTg
	39K3oYIeGxi/8fpcpOeCpPa8igkX7cM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-jY8YJr3SOi-tnkl-a0nl0w-1; Fri, 24 May 2024 03:45:50 -0400
X-MC-Unique: jY8YJr3SOi-tnkl-a0nl0w-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6f105fabe43so2148300a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536750; x=1717141550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pIey9Tt9vhLMK+qG1+4Gr5NV0hqgLZ0e2VrJaCmvI8=;
        b=Vj86AZBKtf1qFAXxGy7Di80P/F4GYOPlMbM49wnZLKHz5S3LrdvG6YrPcn88MBovU6
         2Vkr68qnXqWmq6GXKPRA1cihqmh8uzif6xJeuN+b+C4eLg7TGrWX96YtimzokT2Gm3rj
         5/BbzHXstCMEdUjHJR/vvnV69KweI0gCjgfy2aZXkKsAP2SnzkBpNrKW9IawCFASjBC2
         D0Gh4U3Qw89bk7EB2enqvj7EbmjjYHJFQzGaN/hYl/d2bzX/ApDgADfswNRbYeFd8zDw
         +zrM26yQgz0Ci6fYAkWnOESx/EgK8A1dyFI6ZYQsH/c6mUc5+nhOIYdj+PKhTSWly6Ec
         WY2w==
X-Forwarded-Encrypted: i=1; AJvYcCVko9fTCYfZWB8bNT4R/3v4pAuZNBmPjfozVAeBeq72b17KCM0ZKKMqA/fHWslr8ogI0+3VOcvblhcjassWWON6urqQ2pr+n0ri3Wb8
X-Gm-Message-State: AOJu0YyMJSDUJLM8sQ1c0LOKEkh8QwvY1yrrINgNdOZPAGWlZZti+bwH
	Quxzmn1o3/ZIslHKWNcihdLOtgoKrylQFS97h8cnyAAwJhFNUV7xCm/980/mQ6WRoW8v7Tkow7/
	Xo2NvvcQEcgI+WN8kGf+2Soq3HFirQGZZw8T1mZy4W9xazevv7QFcw3VvoNLmkg==
X-Received: by 2002:a05:6830:19d9:b0:6f0:e79e:f1a9 with SMTP id 46e09a7af769-6f8d0a5778cmr1455359a34.4.1716536749949;
        Fri, 24 May 2024 00:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8hEA6Kc+q4TjSPLiAI2xB4NXupLiPYubi8v4iUlIrGoY5NPXJajUXqtokc1apDgtMt+0tLQ==
X-Received: by 2002:a05:6830:19d9:b0:6f0:e79e:f1a9 with SMTP id 46e09a7af769-6f8d0a5778cmr1455330a34.4.1716536749335;
        Fri, 24 May 2024 00:45:49 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-68220d07fa4sm613804a12.18.2024.05.24.00.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:45:48 -0700 (PDT)
Date: Fri, 24 May 2024 15:43:23 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	 Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 7/7] x86/crash: make the page that stores the dm crypt
 keys inaccessible
Message-ID: <uuuwhh4rhq54owh52oudxirvkyxk2tfmej2dgbvdzq4refnofg@jf264hprcxal>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-8-coxu@redhat.com>
 <ZkwZ+PubwfDzEQ4v@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZkwZ+PubwfDzEQ4v@MiWiFi-R3L-srv>

On Tue, May 21, 2024 at 11:51:00AM +0800, Baoquan He wrote:
>On 04/25/24 at 06:04pm, Coiby Xu wrote:
>> This adds an addition layer of protection for the saved copy of dm
>> crypt key. Trying to access the saved copy will cause page fault.
>>
>> Suggested-by: Pingfan Liu <kernelfans@gmail.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/machine_kexec_64.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index b180d8e497c3..fc0a80f4254e 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -545,13 +545,34 @@ static void kexec_mark_crashkres(bool protect)
>>  	kexec_mark_range(control, crashk_res.end, protect);
>>  }
>>
>> +static void kexec_mark_dm_crypt_keys(bool protect)
>> +{
>> +	unsigned long start_paddr, end_paddr;
>> +	unsigned int nr_pages;
>> +
>> +	if (kexec_crash_image->dm_crypt_keys_addr) {
>> +		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
>> +		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
>> +		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
>> +		if (protect)
>> +			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
>> +		else
>> +			__set_memory_prot(
>> +				(unsigned long)phys_to_virt(start_paddr),
>> +				nr_pages,
>> +				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
>> +	}
>> +}
>> +
>>  void arch_kexec_protect_crashkres(void)
>>  {
>>  	kexec_mark_crashkres(true);
>> +	kexec_mark_dm_crypt_keys(true);
>
>Really? Are all x86 systems having this dm_crypt_keys and need be
>handled in kdump?

I'm not sure if I understand the above question correctly. But
kexec_mark_dm_crypt_keys will only take effect when there are
dm_crypt_keys because there is a check on
kexec_crash_image->dm_crypt_keys_addr.

-- 
Best regards,
Coiby



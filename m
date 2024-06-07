Return-Path: <linux-kernel+bounces-206047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24195900397
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F441C20C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99996194AD6;
	Fri,  7 Jun 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeTaM/+p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F09194AD0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763328; cv=none; b=tMQ0HK17m1hzZ8N8CD0gsULEHzbpD5Dk+BV/KK5Gqz+rAYRmxYogVTqgmGxeAaEgjZtX+rKZP1vEar6S2nJEh/Xm83yR3vjOW7OozBUS6J6szoOnO+oYaWsoNl3lqF3V245trfo9UGCf3Z+0p9VighGsd9HQSjGR5EVFxsJnWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763328; c=relaxed/simple;
	bh=tz/dZ/FNS3ZMp61Ty1Xvh1MauF+y/w7LiHMq4c0Bjls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRWCVXJbcKLRjcp8asbh7vDZXohd5tRk/Z+0jp7ffuz95d3H8XeJjK99+9b+8kp3z8MKZAFrPX9ttCbV8fRoQQYTdWJLUMKecUCBz/h3oZdi7piBJbKoRO75W+yiHm5lT8EU2NQxzJ4jqCfLWxGROhCAPLUE1ugITc8EPHxArZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeTaM/+p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/skENtQAWrkOdc+P7nTP93U1ahaXb/Psh6M3WjuH5Y=;
	b=ZeTaM/+pCyniCH8blduTiC5WjM75I0+i9VdH/TgvPHa34XcM3UR4GLhEW7baVJv7YRZTDY
	6ykt8V1vaNMT1AWfJPEOBQ6CmCquLBxEyJSP/qRzq3a/8WU9fiv1GfIc8+/BbfOQsiubad
	iwBFa05gGWrVL7p2D01JDHMubfXwn2U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-gA6DTvA-MImno4EOBzkxSg-1; Fri, 07 Jun 2024 08:28:44 -0400
X-MC-Unique: gA6DTvA-MImno4EOBzkxSg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f65539265dso20609815ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763324; x=1718368124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/skENtQAWrkOdc+P7nTP93U1ahaXb/Psh6M3WjuH5Y=;
        b=qUw/04Zgq6Fy32DntfWW/FYG2iMNbtnEOJ1+AYo/7b8M9GefOmddXGPMSH03FxnQe0
         pOe362Pe0bUi3Jgu8nx/ks+wgpwq4UHpEM/sNKi4NOLdjOQVEAT+xhe72KEJstVmFa4P
         qhD+IXTwUgYVXmjGzf+vJiwmqIPl0sP7UpQcwtIvNkaRT3NIpFN2qsti9qkolI1JxXFq
         zwQklr6iGIWK72YO7i3tUTS35dsyB+ytgg5/lWeOZ1XaHVLvpe0VvVK14dxhZ3M2PaY+
         x5qBUrQCQweZFbWo3rXPGbXWoPd6rovdTMkAMvJ52i0iy0vF2Ril5fmwxgNQg5PG4ZwI
         wjiA==
X-Forwarded-Encrypted: i=1; AJvYcCXWPgsmP6BlJh3ia78PHLGwe/ofTnfcnb2mez0KbtnTa9yniB+i17T2jraUs87PXCgn7oOBYausGxHra0QpvCk+bnYJV6fLqA0w+X90
X-Gm-Message-State: AOJu0YwGb81QyYObnBZA8FobF7r0wtbhSRvGp6LEPQykmSW9idnF3Dl9
	j32MGA9aVJCPGozTJtXtLI3NiBp9Ub0yF2yY5MWyZSuZ05efhdDUN1pV/wBgN0Rr+XowkCyPoeK
	E5K6tcD1NFD4UmgAOnPAmwqNJurMWogAhn77QvBKAU0atPKPFSncxhySDpoNSZg==
X-Received: by 2002:a17:902:f548:b0:1f2:f986:595d with SMTP id d9443c01a7336-1f6d0398b8bmr31905615ad.66.1717763323526;
        Fri, 07 Jun 2024 05:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6Nq3NON3nNYPSqkTit6b/3ffna0pt3lQ5eki8qMVQI7KM999+GAG3L/ilgwmwBjMln1kHGg==
X-Received: by 2002:a17:902:f548:b0:1f2:f986:595d with SMTP id d9443c01a7336-1f6d0398b8bmr31905045ad.66.1717763322707;
        Fri, 07 Jun 2024 05:28:42 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd778259sm33012775ad.117.2024.06.07.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:42 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:42 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 7/7] x86/crash: make the page that stores the dm crypt
 keys inaccessible
Message-ID: <et3x72uwqo3vdhzcmpq2ptiyrzyjnzauy2mihzfu2phmr5iqgx@klkkai3em2fe>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-8-coxu@redhat.com>
 <ZmLaTJA6Vq1a9x5z@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmLaTJA6Vq1a9x5z@MiWiFi-R3L-srv>

On Fri, Jun 07, 2024 at 06:00:44PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
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
>Isn't crashkernel region covering crypt keys' storing region? Do we need
>mark it again specifically? Not sure if I miss anything.

kexec_mark_crashkres only makes the page read-only whereas
kexec_mark_dm_crypt_keys makes the memory inaccessible. I've added a
comment for this function in v5 and hopefully no one will be confused by
it.

-- 
Best regards,
Coiby



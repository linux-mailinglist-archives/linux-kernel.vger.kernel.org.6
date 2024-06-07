Return-Path: <linux-kernel+bounces-206045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A546900394
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA13028A6A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E398196DB8;
	Fri,  7 Jun 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFQGPlk5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E4198E72
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763318; cv=none; b=jAtZRJPmYjzh4yJq/dLwD76JVDqPIco3mqcReZ4PAtvBsIPPEaBIWmOR9+kqD19uT5QKeSw/5pb2iRxic7SUtQlj50RJ1UAbJFz/oJ1yQ6Crppm0Lbw/XViNH3tomd3DplEguCX9WtbPYBLdvUwbZadyLhxB6ksuY5a3rvbMXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763318; c=relaxed/simple;
	bh=xStbvYB198NJYtPk9K0+0a1xWseZVYkgkN5NrYknv+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N64vcg7Xi1Mri2MnaVptCT86YE6WARfZFfTuS+FdOjX/iOwLGSsnbQWUkbvo0bZbVWRMpC5m5z2H625IHQwnnskVHhjgfFmYFV/6m6vCmNH7ja5ku7Q2h2h24WkSsfkYbuP7ntaZ2Qj0ely39rghFkVaRW6/6ARl7J3AG91qoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFQGPlk5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwPDz8occ/dQmTW/xROoDQYZ478DOM3gjpOPNBITyCU=;
	b=hFQGPlk5qTMbsHTIJRyw/7XOUpjui5jVmjmUb7MynQbV3MZ07TFOhO3a8T3Uy7stnx31Pp
	ZNmjKmjaY1VbU/k0AZfs08J6bfIwQFS+007ZawO+mjR5GiDqV1gOIT17f/ivwfusVgFr04
	VFy75rMRn3H1InN5OwJOL/5801ikuGA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-anGd3v75MRWr1Y8IrQid7Q-1; Fri, 07 Jun 2024 08:28:35 -0400
X-MC-Unique: anGd3v75MRWr1Y8IrQid7Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70258e95605so1570571b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763314; x=1718368114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwPDz8occ/dQmTW/xROoDQYZ478DOM3gjpOPNBITyCU=;
        b=VgJLWVTXLI51TghVSbCABBK8UEPNlIWghzf51YPd1wCBcgjLuuafNNVGu33wRYRTue
         ufAkz9zE36rGkRNSLEzt7p80JxKspIEZhw4EqOBIDvnXjgY58rl7S0ZfJdKVZFKkfp1i
         FU5BoH9pDy1ekGxXTQJN2FgsSJno1zg55y9ySu2dr7DrYeMJx+3SdXN0YOXTM4mUb+aC
         Oln5lfScG/o9It1CeVdPd7atA7as6oGHpve9CVNP9YCsmL979DIAZnDc2WIqclMe34Ax
         6AJbLVNnAZBuMoNJFwp4hs+tkaaxpHuLsjvBQ6daZ6HCVYE01wleOO5Tn3sX9lBtq4ME
         1lCA==
X-Forwarded-Encrypted: i=1; AJvYcCXrscp22uMtuAWTQBZWv707QBpMX6hjfnTiwXALmvHLHXV4AzYHnuZJ7ulXfWKCagODZqhFc8bCYRJA78tpYDLYsqEYGXu/8PJbB7ZT
X-Gm-Message-State: AOJu0YxmR4b4PeBHOH1VPr3kdnVHTsl3CGlSyY6TgwfHsVz46wP0q+Cu
	5orFi2gdpEFPOCrR+pRW9d8ndXZegAtq414/7eZTUrUi+uSN9IbgBTYfeoKql1agtoHRblfBxJQ
	xZRoLy4rQCOXfNqv653dH1mHp/RRFPjvP47ntJ7+lGJBAkrl6pmwcVdHLKMAPu23mQJf6vHqjci
	EDaw==
X-Received: by 2002:a05:6a21:9991:b0:1b4:772d:288f with SMTP id adf61e73a8af0-1b4772d29f8mr495353637.11.1717763313203;
        Fri, 07 Jun 2024 05:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG150Tip3wkIFyTvRDBUO16odC1xEzwii3bObBikg46Rh/1H1mVAdbqe3agN71+jfxDsLeANw==
X-Received: by 2002:a05:6a21:9991:b0:1b4:772d:288f with SMTP id adf61e73a8af0-1b4772d29f8mr495313637.11.1717763312430;
        Fri, 07 Jun 2024 05:28:32 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806cfa57sm5344667a91.49.2024.06.07.05.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:32 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:21 +0800
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
Subject: Re: [PATCH v4 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <qzyj55v7umimqgq265ya4jds4kvzabeq7wg3eah6ppc3a6eygh@4fid6x2vp35d>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-7-coxu@redhat.com>
 <ZmLZkvYRJvdRVqwr@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmLZkvYRJvdRVqwr@MiWiFi-R3L-srv>

On Fri, Jun 07, 2024 at 05:57:38PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> 1st kernel will build up the kernel command parameter dmcryptkeys as
>> similar to elfcorehdr to pass the memory address of the stored info of
>> dm crypt key to kdump kernel.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/crash.c           | 15 ++++++++++++++-
>>  arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index f06501445cd9..74b3844ae53c 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -266,6 +266,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>>  				 unsigned long long mend)
>>  {
>>  	unsigned long start, end;
>> +	int r;
>            ~?
>
>r is only to contain the returned value? Then you can call it ret as
>many do in kernel code.

Applied to v6, thanks for the suggestion!

>
>>
>>  	cmem->ranges[0].start = mstart;
>>  	cmem->ranges[0].end = mend;
>> @@ -274,7 +275,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>>  	/* Exclude elf header region */
>>  	start = image->elf_load_addr;
>>  	end = start + image->elf_headers_sz - 1;
>> -	return crash_exclude_mem_range(cmem, start, end);
>> +	r = crash_exclude_mem_range(cmem, start, end);
>> +
>> +	if (r)
>> +		return r;
>> +
>> +	/* Exclude dm crypt keys region */
>> +	if (image->dm_crypt_keys_addr) {
>> +		start = image->dm_crypt_keys_addr;
>> +		end = start + image->dm_crypt_keys_sz - 1;
>> +		return crash_exclude_mem_range(cmem, start, end);
>> +	}
>
>You need adjust the array length of cmem->ranges[], I believe you will
>cause the array overflow because the keys are randomly set and mostly
>will be in the middle of crashkernel region.

Yes, you are absolutely right. I've fixed in v6.


-- 
Best regards,
Coiby



Return-Path: <linux-kernel+bounces-188412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD758CE1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7901C21080
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB95A11D;
	Fri, 24 May 2024 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gu6nNr1k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FBD33D0
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536754; cv=none; b=eH39X/D7l57tzK3pT8cZaAU5JQCiy3nZ61SGZ+HD1LyZHavxcI7ggdTaAEmQSU2ZPp/qKRg3T7LB0Gq3h8AE/CfkEtEDmkux0SJqAYg0iv9/T/6SpWm3/U1fQ1+gp4NrDvfkU3mbj80h9j/5me0QIRA+t/gCzya2ExIzSGpUAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536754; c=relaxed/simple;
	bh=S/w8vuAudAzfzO1eQeYhP8GUDj4u+DfanX/jFOUwG2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjYD8UxFkkuOnrFv2otjaGY9YuxeJcVV2HUMHQOzQytBKdSGSqjN8axNYNsFT3vu0WzymxtB8Su1QbjrV7sBRw0KOFDpU+NkmaMDwCGIn1KbNTfYKpZnUlimOPE6FpJN5tMJkpBfRGAT8WyOxrHUO+Ce3AgGlcuXPPX96IzVcHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gu6nNr1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716536751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3tXMXab6M77eKvUSzxZo4mXzYc0uhowQ0ZNcQeUMTs=;
	b=gu6nNr1kx+B3X4stMXa6xEtD5m7XsE+ypPn0omv+lawmzWyg5qJIq1/vFoLP61FFTNEx40
	jhkfk/uRfqCXj8/IMt6MOATmw4y4xCjo1vS/BFHwTElgi79gcYXdk/qSqgGvc2/ZLit4hG
	LQZ4Ob1HLSTUKG5ylOFhjVXvJg/L1iQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-1-MaCgaDPGqKvH5ykDe42w-1; Fri, 24 May 2024 03:45:48 -0400
X-MC-Unique: 1-MaCgaDPGqKvH5ykDe42w-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f449f05eeaso4317165ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536747; x=1717141547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3tXMXab6M77eKvUSzxZo4mXzYc0uhowQ0ZNcQeUMTs=;
        b=hUAF6N196WZ/RRx3fBwaGCRdwAvtTXlmQHGsKIxh7k9agOjKyi6VmkBJCnA06ObYQb
         Qi+Ly3n1t9ye7bDfWWdkMvmRLxmx+K6JlpEpsYB+8rWUPDfUnpkp7PzNoLBwpskmqw7F
         pH/yKMUA4XDxXo+WppxvhC0e2KezKlnsHr8W+j58DWhTB8/9jGONEFRaa8pGy9Firhnj
         SjwSWHF40QDamUthygGxE+uUpeBWrBSROcSZty/G2WhSR8vQ54Z9NsZaozUJHuu19PAr
         NdE3Vd/MfzpNBJJ2qfq2GdzLw8+wD+Q0FlTABfjdy4lIq4edy1Cm7FrSVTUzv9sMhrxY
         0WOA==
X-Forwarded-Encrypted: i=1; AJvYcCUABOouwKVYqoRfOxtd38eT6bBK2ONWPloyGCq+jPUSVZeqSfVDm7R4hLc1JNGOK+Mg/I1uS3xX36Gw3tjx1WbT5H4QNLKEzwCeEXfo
X-Gm-Message-State: AOJu0YxTzdPggw2e9dNwI3M7WkMjW3KY5jPeWjhoUHiIC4aXGgCVGl5W
	5LkGuu4efYMrppTgAp1tnjRB+IgrhWqDoVya5QxQbYHbyqGFJnZ3CCp4hXmaWA23M/8HbmpcpiY
	HvaSHdqLAsB2bNmjGTAYsmWCSZuU/syUMLawTpUD5+zaLigLsOHW8alyjAboO2Q==
X-Received: by 2002:a17:903:2445:b0:1eb:5222:7b8e with SMTP id d9443c01a7336-1f448160c7amr23116665ad.17.1716536746798;
        Fri, 24 May 2024 00:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1aJYXjax+8GTKPwvYRs1B8LMFH0sILZ/bVMDAGOOSLXHhLZ7EJHda1gAWcPVxmY0C6kEKMw==
X-Received: by 2002:a17:903:2445:b0:1eb:5222:7b8e with SMTP id d9443c01a7336-1f448160c7amr23116155ad.17.1716536745907;
        Fri, 24 May 2024 00:45:45 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c971012sm7604975ad.173.2024.05.24.00.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:45:45 -0700 (PDT)
Date: Fri, 24 May 2024 15:40:27 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 4/7] crash_dump: reuse saved dm crypt keys for
 CPU/memory hot-plugging
Message-ID: <c5xg5akvf5ikphio4osdbg2giclzvxu5dbsivrvtht6rxbgs52@hriqkr6kdui5>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-5-coxu@redhat.com>
 <ZkwZfcfTOL1UGKJb@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZkwZfcfTOL1UGKJb@MiWiFi-R3L-srv>

On Tue, May 21, 2024 at 11:48:49AM +0800, Baoquan He wrote:
>On 04/25/24 at 06:04pm, Coiby Xu wrote:
>> When there is CPU/memory hot-plugging, the kdump kernel image and initrd
>> will be reloaded. The user space can write the "reuse" command to
>> /sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.
>>
>> Note currently only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
>> hotplug support")) and ppc (WIP) supports the new infrastructure
>> (commit 247262756121 ("crash: add generic infrastructure for crash
>> hotplug support")). If the new infrastructure get extended to all arches,
>> this patch can be dropped.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  kernel/crash_dump_dm_crypt.c | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index b9997fb53351..6ac1fabdb6cb 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -10,12 +10,13 @@
>>  // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
>>  #define KEY_DESC_LEN 48
>>
>> -static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
>> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
>>  enum STATE_ENUM {
>>  	FRESH = 0,
>>  	INITIALIZED,
>>  	RECORDED,
>>  	LOADED,
>> +	REUSE,
>>  } state;
>>
>>  static unsigned int key_count;
>> @@ -90,12 +91,31 @@ static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
>>  	return 0;
>>  }
>>
>> +static void get_keys_from_kdump_reserved_memory(void)
>> +{
>> +	struct keys_header *keys_header_loaded;
>> +
>> +	arch_kexec_unprotect_crashkres();
>
>I don't see the corresponging arch_kexec_protect_crashkres() in the
>following flow. Aren't they a pair when used?

Thanks for raising the concern! The user space is supposed to load the
kdump kernel as next step. But for code readability and security, it's
better to add arch_kexec_protect_crashkres.


-- 
Best regards,
Coiby



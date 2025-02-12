Return-Path: <linux-kernel+bounces-510284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251AFA31AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30323A77CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474381CA9C;
	Wed, 12 Feb 2025 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7Q+1cUw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD371F94D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321160; cv=none; b=iMXq4POTyESsFJiUN7n43ImzKtGlwDMJn4g+mxy7lFns0YzC7y0oMAWCPDOAi81McWCNsVxme3VL5AFpIRoytroBDYrWYj8A5OcwE740HtgJYiBpPsFQhRyIwW+FlflIX+bsROYfCDVwyrywM1pnPEwpp2I6FKa4ADSCOaIQMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321160; c=relaxed/simple;
	bh=L8M9J0DT+3fg7fOa9jiMrBAmSPXuGJDr6zpRasFuZpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+CvYGGAqnokiNtosN+QStmOjlaeO3o4soRoj6za5Vh5ONodX0FqxITJiOuzgju2vHwZdDFDs9Ayc0zOfTtn3L0C3nmmgPFj/2NKZwVVFRZhXsivUYQpR4dTuHPOW6fUXuX+GVhpqxlgLyCvXE7p5AW2GkeW+3q1VRXu6L+DwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7Q+1cUw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739321157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eua/hApNBjEqd+RMENEi87Sr+Mh/D0hB/oWXPr8GJgk=;
	b=F7Q+1cUwtjFx88vB6UAeWKVYkzqr3SgSGz1YoDgIvuLffSVa/NVD4YmmBSWiJnFkaPQ5tc
	IXrlfpAxgDR3k8kdl6/eMgtSyJUHmncLDbDs5NK6AbGUMo7K0OdRVpT7K1dpblB54IwqVW
	ZccO3SbKQr5Xw3ltU07ttRfJCGXT9ac=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-jt4UKMa5O9qdEmhk_P6QFw-1; Tue, 11 Feb 2025 19:45:56 -0500
X-MC-Unique: jt4UKMa5O9qdEmhk_P6QFw-1
X-Mimecast-MFC-AGG-ID: jt4UKMa5O9qdEmhk_P6QFw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso19410388a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739321155; x=1739925955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eua/hApNBjEqd+RMENEi87Sr+Mh/D0hB/oWXPr8GJgk=;
        b=XlvPXuWk7ZpAotC2009WIEOSXyRisFEQnMlSLvLwFk+yAEGXWgB/3qwkn6N4kxFWl9
         JudltO709TYg8av98MHGRj0MhHWLcv9RpsCbTJFPj1RvBp5sNxCtaTLdSZ8PycRgcQVO
         pkz4bRET/O6GfK4hxgTW+IPueL63UncTGn/Z7dI7DvrxbDotozHvvZ9z+G/+PE6yVY6s
         G+upnbpzn8dDtaDs4TC8rDzShqMvdI/y+l4dKqW6eStzyyXA/YnZGOUwKYLTqkdX3jNp
         yXHm6kIUjONUUMl2zzv1TwVRqMDZ7pwibQMjrd+AjFJudiNvuQEdmWGK0nHWLgUgLdb7
         xSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaNFgl5Q9UJE/s9FJ7eJcj8m11tPgv0XN7esbp1vgvh7M7rHPS2YpxGzeOjQDyWgN7B+p9hzvQW5m/0hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAkOW7csjaWfiT9QErYeoo+fU3LlGd3D2G9ccbdSIZFTXPpVM+
	z5u1UaAyPbglaLmh1DPksQlCt0j0PoGjZ548+DX1x0HaI79K/JTiH7IIhZcki75PCTi0YelQ0CK
	z1iWpoiTrx9R1V/N8Cu5pm4XPrNXRiTObFO4F9aU0pOVKMy3bK5tCIPsjUbEhGw==
X-Gm-Gg: ASbGncuajXnbwOCCT8+ku/ESGiKH9YpIZcmfHBGCHJJpQ2tsQVn5yaa/fUMfKQNZtgt
	raGDpN28XJ1JoVGtVRKjkhziE7e0mgNlD1eCJ7vmCP/q/XVg8NDg/riVrxk85UeIm0C1EimYDKf
	L/WaLUZ5NNiQQh3YnNdj1DifgUPeB2OBrjtiglNAQ8IOyrLX4ZumQNtCZ/OxWtNR0CzV97nhSRJ
	txzTv37ToKc0o1M6pwv9UFiG1R7LRDJTxPa5JSD67PLBuq6gESO72KTOctL552hOwMgUY++
X-Received: by 2002:a17:90b:544f:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2fbf5c0f653mr2103365a91.14.1739321155472;
        Tue, 11 Feb 2025 16:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6IIMJ+3Hvx8Id8rTg0AZzH7XEwW28qToMrNpGHIdmEypuProqH9OrCUS32B2pihOhAwnVBg==
X-Received: by 2002:a17:90b:544f:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2fbf5c0f653mr2103334a91.14.1739321155171;
        Tue, 11 Feb 2025 16:45:55 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9908960sm202009a91.41.2025.02.11.16.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:45:54 -0800 (PST)
Date: Wed, 12 Feb 2025 08:43:21 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v8 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <uo2q3jxzcu3d4noiznxpw5woaclikmywyzi7yjlnpef3fdjt4e@idvs7tiv3znb>
References: <20250207080818.129165-1-coxu@redhat.com>
 <Z6sljm1lurDKPCvj@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z6sljm1lurDKPCvj@MiWiFi-R3L-srv>

On Tue, Feb 11, 2025 at 06:25:18PM +0800, Baoquan He wrote:
>On 02/07/25 at 04:08pm, Coiby Xu wrote:
>> LUKS is the standard for Linux disk encryption, widely adopted by users,
>> and in some cases, such as Confidential VMs, it is a requirement. With
>> kdump enabled, when the first kernel crashes, the system can boot into
>> the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore)
>> to a specified target. However, there are two challenges when dumping
>> vmcore to a LUKS-encrypted device:
>>
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes; For cloud confidential VMs, depending on the policy the
>>    kdump kernel may not be able to unseal the keys with TPM and the
>>    console virtual keyboard is untrusted.
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump. Take Fedora example, by default, only 256M is reserved for
>>    systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>>    to be reserved for kdump. Note if the memory reserved for kdump can't
>>    be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>>    1st kernel.
>>
>> Besides users (at least for Fedora) usually expect kdump to work out of
>> the box i.e. no manual password input or custom crashkernel value is
>> needed. And it doesn't make sense to derivate the keys again in kdump
>> kernel which seems to be redundant work.
>>
>> This patch set addresses the above issues by making the LUKS volume keys
>> persistent for kdump kernel with the help of cryptsetup's new APIs
>> (--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
>> the kdump copies of LUKS volume keys,
>>
>>  1. After the 1st kernel loads the initramfs during boot, systemd
>>     use an user-input passphrase to de-crypt the LUKS volume keys
>>     or TPM-sealed key and then save the volume keys to specified keyring
>>     (using the --link-vk-to-keyring API) and the key will expire within
>>     specified time.
>>
>>  2. A user space tool (kdump initramfs loader like kdump-utils) create
>>     key items inside /sys/kernel/config/crash_dm_crypt_keys to inform
>>     the 1st kernel which keys are needed.
>>
>>  3. When the kdump initramfs is loaded by the kexec_file_load
>>     syscall, the 1st kernel will iterate created key items, save the
>>     keys to kdump reserved memory.
>>
>>  4. When the 1st kernel crashes and the kdump initramfs is booted, the
>>     kdump initramfs asks the kdump kernel to create a user key using the
>>     key stored in kdump reserved memory by writing yes to
>>     /sys/kernel/crash_dm_crypt_keys/restore. Then the LUKS encrypted
>>     device is unlocked with libcryptsetup's --volume-key-keyring API.
>>
>>  5. The system gets rebooted to the 1st kernel after dumping vmcore to
>>     the LUKS encrypted device is finished
>>
>> After libcryptsetup saving the LUKS volume keys to specified keyring,
>> whoever takes this should be responsible for the safety of these copies
>> of keys. The keys will be saved in the memory area exclusively reserved
>> for kdump where even the 1st kernel has no direct access. And further
>> more, two additional protections are added,
>>  - save the copy randomly in kdump reserved memory as suggested by Jan
>>  - clear the _PAGE_PRESENT flag of the page that stores the copy as
>>    suggested by Pingfan
>>
>> This patch set only supports x86. There will be patches to support other
>> architectures once this patch set gets merged.
>
>This v8 looks good to me, thanks for the great effort, Coiby.
>
>Acked-by: Baoquan He <bhe@redhat.com>

Great, thanks for reviewing and acknowledging the patch set!

-- 
Best regards,
Coiby



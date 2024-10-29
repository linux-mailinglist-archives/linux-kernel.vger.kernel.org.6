Return-Path: <linux-kernel+bounces-387802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75879B5630
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27FE1C20CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ABE20ADF0;
	Tue, 29 Oct 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T462Yrqs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639D198E76
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242795; cv=none; b=Mu/WwVoDn1hYCwS5R9r4mB9cTTDUBI8UAKikiYU/QyoOpWMngkEFzzSYLiF8LVSP1NpF9iNycJ/zuyXZt89PXqEkX+51iUbXVk11Aj7s9Zn6eW8Vz3pnF7GgibO1IS8lvSyGLEXLLugNxi2s7Py7kgcyoKm2KkfeE3ot8LQMPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242795; c=relaxed/simple;
	bh=JVi7y45kZBWbS2F7GabGE5yhstU057iLHEOvLaL+Vcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/RsnDDadFjsSIXzbjj9Dl11QIho+wfQWCxN8hACJLuJCc+b2rIoaa0DLyLL4AWs0VN1C80jKqLEGwGHMzG+WtVunhgytrFZHK9xN5itWE/TY0BaS8P9wUDaFXJrrRm7tSj7VVT6WtcMtytV2RRC6wSjahlj134BFwI3cOd1srQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T462Yrqs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730242791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uC80EUK0/uILcge2OXCLIRoiryY17Wl0SjIOpx9KtUU=;
	b=T462YrqsN6JVHsN5EtJRNF+uN2Qa2+boA9mQ1oYSOh5RRdCj2u9X1eMyl2mQz1azMiRsVn
	nIpJSqimga0vSfi2b0N4YXg3+m6vgeHw3WKhzeaUYRmIPgwVYh1WHY5B0iebJDVm9iXqya
	G9zSqdMn2wsimACI6VDiLQCG6F0FRZk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-dJZ6po8mOq2KY55hyxr7Lg-1; Tue, 29 Oct 2024 18:59:50 -0400
X-MC-Unique: dJZ6po8mOq2KY55hyxr7Lg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314f1e0f2bso41614265e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730242789; x=1730847589;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uC80EUK0/uILcge2OXCLIRoiryY17Wl0SjIOpx9KtUU=;
        b=V9x9YcHd+GxwifWUx2S11AZsqFwF1IIzvoh2w2qNYPKgRlYeDXeKNchnmB/AeSdJAQ
         x/YvCRXwQe6Blt5EL+ERGYM6S3qQBuJQFWeT3W6dVbJ70Kbk1zZMT6LKb3euHd6K77X3
         ssQ0lNn529Yyfvng8GwwswHatrYiJpC00haMrc6ON+cVBbgM3SWYT1gNXgypyxB009O2
         BJOsR5OUlwKfqf4OI4SU0lWYQS54dZTe/AJBN0gg+x3/rVxyTHLNbOdgW6yGKZc9Bfel
         ynNkt49jtCJ7lQ5/PUhaED1yQ8oDgUFlN5tGw/uW4cgpZqv+obnv635o/Wbl5PHHkNvc
         rdFw==
X-Forwarded-Encrypted: i=1; AJvYcCXb30A8zgCmoRN2xwZt65Xr82aLW5/a8/KS5gEIu/luLqQlVoKJu3gbphtHNvj2vZk7mAVHlIcnY32+X1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2X6Il7wvZ3jzbGU1cfpSaTbHCbN5gj81DZDB/IsAQpr++4e5
	M27GSqtm3lzZqzKJa+FbAoX8gpX6FDCaojzdNT4JFO/7Aa/9EGhR1+SjVXrndSFnHB46RnNoxD2
	yejMIeY0UFF7Fk2gdT+LHSLtlbGK9U14rE5Hbl2EVOx16WBzfp7YFIUSqKHDF+A==
X-Received: by 2002:a05:600c:350b:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-4319acb8a7cmr112318445e9.19.1730242788894;
        Tue, 29 Oct 2024 15:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsm7OZ7MAFVicUj8pTSI6wQKTrCNicjqISkuPLhqcNhR9WTy+4/jAtAk+Mm6Ppb+5nez3Uvw==
X-Received: by 2002:a05:600c:350b:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-4319acb8a7cmr112318315e9.19.1730242788512;
        Tue, 29 Oct 2024 15:59:48 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-431bd98e823sm2868095e9.38.2024.10.29.15.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 15:59:47 -0700 (PDT)
Message-ID: <1998a069-50a0-46a2-8420-ebdce7725720@redhat.com>
Date: Tue, 29 Oct 2024 23:59:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup2 freezer and kvm_vm_worker_thread()
To: Tejun Heo <tj@kernel.org>, Luca Boccassi <bluca@debian.org>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: kvm@vger.kernel.org, cgroups@vger.kernel.org,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 linux-kernel@vger.kernel.org
References: <ZyAnSAw34jwWicJl@slm.duckdns.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <ZyAnSAw34jwWicJl@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 01:07, Tejun Heo wrote:
> Hello,
> 
> Luca is reporting that cgroups which have kvm instances inside never
> complete freezing. This can be trivially reproduced:
> 
>    root@test ~# mkdir /sys/fs/cgroup/test
>    root@test ~# echo $fish_pid > /sys/fs/cgroup/test/cgroup.procs
>    root@test ~# qemu-system-x86_64 --nographic -enable-kvm
> 
> and in another terminal:
> 
>    root@test ~# echo 1 > /sys/fs/cgroup/test/cgroup.freeze
>    root@test ~# cat /sys/fs/cgroup/test/cgroup.events
>    populated 1
>    frozen 0
>    root@test ~# for i in (cat /sys/fs/cgroup/test/cgroup.threads); echo $i; cat /proc/$i/stack; end
>    2070
>    [<0>] do_freezer_trap+0x42/0x70
>    [<0>] get_signal+0x4da/0x870
>    [<0>] arch_do_signal_or_restart+0x1a/0x1c0
>    [<0>] syscall_exit_to_user_mode+0x73/0x120
>    [<0>] do_syscall_64+0x87/0x140
>    [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    2159
>    [<0>] do_freezer_trap+0x42/0x70
>    [<0>] get_signal+0x4da/0x870
>    [<0>] arch_do_signal_or_restart+0x1a/0x1c0
>    [<0>] syscall_exit_to_user_mode+0x73/0x120
>    [<0>] do_syscall_64+0x87/0x140
>    [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    2160
>    [<0>] do_freezer_trap+0x42/0x70
>    [<0>] get_signal+0x4da/0x870
>    [<0>] arch_do_signal_or_restart+0x1a/0x1c0
>    [<0>] syscall_exit_to_user_mode+0x73/0x120
>    [<0>] do_syscall_64+0x87/0x140
>    [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    2161
>    [<0>] kvm_nx_huge_page_recovery_worker+0xea/0x680
>    [<0>] kvm_vm_worker_thread+0x8f/0x2b0
>    [<0>] kthread+0xe8/0x110
>    [<0>] ret_from_fork+0x33/0x40
>    [<0>] ret_from_fork_asm+0x1a/0x30
>    2164
>    [<0>] do_freezer_trap+0x42/0x70
>    [<0>] get_signal+0x4da/0x870
>    [<0>] arch_do_signal_or_restart+0x1a/0x1c0
>    [<0>] syscall_exit_to_user_mode+0x73/0x120
>    [<0>] do_syscall_64+0x87/0x140
>    [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The cgroup freezing happens in the signal delivery path but
> kvm_vm_worker_thread() thread never call into the signal delivery path while
> joining non-root cgroups, so they never get frozen. Because the cgroup
> freezer determines whether a given cgroup is frozen by comparing the number
> of frozen threads to the total number of threads in the cgroup, the cgroup
> never becomes frozen and users waiting for the state transition may hang
> indefinitely.
> 
> There are two paths that we can take:
> 
> 1. Make kvm_vm_worker_thread() call into signal delivery path.
>     io_wq_worker() is in a similar boat and handles signal delivery and can
>     be frozen and trapped like regular threads.

For the freezing part, would this be anything more than

fdiff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d16ce8174ed6..b7b6a1c1b6a4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -47,6 +47,7 @@
  #include <linux/kern_levels.h>
  #include <linux/kstrtox.h>
  #include <linux/kthread.h>
+#include <linux/freezer.h>
  #include <linux/wordpart.h>
  
  #include <asm/page.h>
@@ -7429,22 +7430,27 @@ static long get_nx_huge_page_recovery_timeout(u64 start_time)
  static int kvm_nx_huge_page_recovery_worker(struct kvm *kvm, uintptr_t data)
  {
  	u64 start_time;
-	long remaining_time;
+	u64 end_time;
+
+	set_freezable();
  
  	while (true) {
  		start_time = get_jiffies_64();
-		remaining_time = get_nx_huge_page_recovery_timeout(start_time);
+		end_time = start_time + get_nx_huge_page_recovery_timeout(start_time);
  
-		set_current_state(TASK_INTERRUPTIBLE);
-		while (!kthread_should_stop() && remaining_time > 0) {
-			schedule_timeout(remaining_time);
-			remaining_time = get_nx_huge_page_recovery_timeout(start_time);
+		for (;;) {
  			set_current_state(TASK_INTERRUPTIBLE);
+			if (kthread_freezable_should_stop(NULL))
+				break;
+			start_time = get_jiffies_64();
+			if ((s64)(end_time - start_time) <= 0)
+				break;
+			schedule_timeout(end_time - start_time);
  		}
  
  		set_current_state(TASK_RUNNING);
  
-		if (kthread_should_stop())
+		if (kthread_freezable_should_stop(NULL))
  			return 0;
  
  		kvm_recover_nx_huge_pages(kvm);

(untested beyond compilation).

I'm not sure if the KVM worker thread should process signals.  We want it
to take the CPU time it uses from the guest, but otherwise it's not running
on behalf of userspace in the way that io_wq_worker() is.

Paolo



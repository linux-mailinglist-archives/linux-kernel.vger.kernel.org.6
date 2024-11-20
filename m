Return-Path: <linux-kernel+bounces-415808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1289D3CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC8A28275D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1791AAE3B;
	Wed, 20 Nov 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nphh5FYt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B51AA787
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110960; cv=none; b=J1rbncfZIW+U1+edrWzMEbyWU3uc/64axMrplrVWwReiRw8GKUoWkdCe7OG+kFgRPSxX3HrU0TggwR8Cqjm4UCfGXGTWcVMzKSAILcneI7DoelSlayoLvBITz23FBY5PJp9Df1fIp9facKqfxPpJkkNnaWBetoJowwVK1VSu5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110960; c=relaxed/simple;
	bh=lS0k0QVCakrIVbVemWDBp46czig0ShsrxsyUeBX5S/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYkIGUE5r0AB8oTeTHRAaLKIUDcdZRX2fZa/mkFwy542KqrkpwEgMhkuQT9xW280WbcUOfOeA/94awT1le90NibC7ya29yFoXkJLoCskDbeem5n/aW8lAFLE/byuxeupHJKpU1Wogu0Z7ZkvbfREOkMH1hTk4PiCBEoqNedveY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nphh5FYt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732110957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Leu7njKM4u8OR2ZgAY8Gk/TTu8WWKCDop5cA+VNKFbo=;
	b=Nphh5FYtH111SiIt/TFxhLA3lXXKkwoHLJLygi8SDy6cwZYT77cP/8CAqwAeRwKs5IRTTy
	0VSm0KuZ9fxAB2o3I92xGPg2bgOtZau9FwooAWu40PNrEkJPfomxem90gegj0B4G7Cqx13
	OWgMMigu1ybwPfPjgWjQ4sSD8qkNxgs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-4tnwTgjtNY25sKV03yt4Aw-1; Wed, 20 Nov 2024 08:55:54 -0500
X-MC-Unique: 4tnwTgjtNY25sKV03yt4Aw-1
X-Mimecast-MFC-AGG-ID: 4tnwTgjtNY25sKV03yt4Aw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-432d04b3d40so42017835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732110953; x=1732715753;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Leu7njKM4u8OR2ZgAY8Gk/TTu8WWKCDop5cA+VNKFbo=;
        b=QMyEOJV9vZmkZMx+06J8/fae27cHx3UC8DTUXcK7lv4ZWetiaau20CK8clqgwYa5rj
         WhsmSl/hxrhXXbUFuw8d2Edno7qRtjquDeWRvMkr3gpD8CImMNKnYAyp10Zl9oBtTJZN
         1bH27OxNc1tPNIntYxH876akQOjf+pM4qoi4sAa4jUr4ow36jeGzmxT5hl4zpRN23k7p
         g8I0jDk5p8YbsT5PQXbk6bmeuagI04L14frxPg0wJXk/ABCdrLOEyqu8T5lbydoge6V4
         wuZOj+X6DqwzViTfNal4Po8gzNBT4bfplr2gXCTfug5nu21cdrM+Uhx+G2irU0/NLvlb
         jYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA43bmuIU32D92T9V0G+63o4TzumtCGXt5Yh0613DQVwsFrq+gQpblhIfwFyuMacKTmt3StB9EuP4KrhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzS1cto0J4FJy3UUCnrVfa+O5W32gfZMGE2oYPHKBHXeKZjTDq
	QlU/vNqDBbSREg9GOrjL6SxXJPHlCSHPoyMsOnMfc9pV1K/5zMCYnKjffj/9AEPQQRsuDhZr/A1
	Oy1lPxphVZlR0Vzc0jKO3iMQqIVAlZKqXVUNOB0KZDtBTGv6jN9POTuTpN9Lr9Q==
X-Received: by 2002:a05:600c:3505:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-4334f02192fmr27169965e9.30.1732110953528;
        Wed, 20 Nov 2024 05:55:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG51bpAuR/KKUWNbo3qmyx1+cV+HgfoA7+yduGe4E6R+OdTUIKh2z/ixXanUzaRBf/n3m5+HA==
X-Received: by 2002:a05:600c:3505:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-4334f02192fmr27169745e9.30.1732110953176;
        Wed, 20 Nov 2024 05:55:53 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-433b45fa706sm20639425e9.16.2024.11.20.05.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 05:55:52 -0800 (PST)
Message-ID: <86811253-a310-4474-8d0a-dad453630a2d@redhat.com>
Date: Wed, 20 Nov 2024 14:55:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] KVM: ioctl for populating guest_memfd
To: Nikita Kalyazin <kalyazin@amazon.com>, corbet@lwn.net,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jthoughton@google.com, brijesh.singh@amd.com, michael.roth@amd.com,
 graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
 nsaenz@amazon.es, xmarcalx@amazon.com
References: <20241024095429.54052-1-kalyazin@amazon.com>
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
In-Reply-To: <20241024095429.54052-1-kalyazin@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 11:54, Nikita Kalyazin wrote:
> Firecracker currently allows to populate guest memory from a separate
> process via UserfaultFD [1].  This helps keep the VMM codebase and
> functionality concise and generic, while offloading the logic of
> obtaining guest memory to another process.  UserfaultFD is currently not
> supported for guest_memfd, because it binds to a VMA, while guest_memfd
> does not need to (or cannot) be necessarily mapped to userspace,
> especially for private memory.  [2] proposes an alternative to
> UserfaultFD for intercepting stage-2 faults, while this series
> conceptually compliments it with the ability to populate guest memory
> backed by guest_memfd for `KVM_X86_SW_PROTECTED_VM` VMs.
> 
> Patches 1-3 add a new ioctl, `KVM_GUEST_MEMFD_POPULATE`, that uses a
> vendor-agnostic implementation of `post_populate` callback.
> 
> Patch 4 allows to call the ioctl from a separate (non-VMM) process.  It
> has been prohibited by [3], but I have not been able to locate the exact
> justification for the requirement.

The justification is that the "struct kvm" has a long-lived tie to a 
host process's address space.

Invoking ioctls like KVM_SET_USER_MEMORY_REGION and KVM_RUN from 
different processes would make things very messy, because it is not 
clear which mm you are working with: the MMU notifier is registered for 
kvm->mm, but some functions such as get_user_pages do not take an mm for 
example and always operate on current->mm.

In your case, it should be enough to add a ioctl on the guestmemfd 
instead?  But the real question is, what are you using 
KVM_X86_SW_PROTECTED_VM for?

Paolo

> Questions:
>   - Does exposing a generic population interface via ioctl look
>     sensible in this form?
>   - Is there a path where "only VMM can call KVM API" requirement is
>     relaxed? If not, what is the recommended efficient alternative for
>     populating guest memory from outside the VMM?
> 
> [1]: https://github.com/firecracker-microvm/firecracker/blob/main/docs/snapshotting/handling-page-faults-on-snapshot-resume.md
> [2]: https://lore.kernel.org/kvm/CADrL8HUHRMwUPhr7jLLBgD9YLFAnVHc=N-C=8er-x6GUtV97pQ@mail.gmail.com/T/
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4e4c4fca5be806b888d606894d914847e82d78
> 
> Nikita
> 
> Nikita Kalyazin (4):
>    KVM: guest_memfd: add generic post_populate callback
>    KVM: add KVM_GUEST_MEMFD_POPULATE ioctl for guest_memfd
>    KVM: allow KVM_GUEST_MEMFD_POPULATE in another mm
>    KVM: document KVM_GUEST_MEMFD_POPULATE ioctl
> 
>   Documentation/virt/kvm/api.rst | 23 +++++++++++++++++++++++
>   include/linux/kvm_host.h       |  3 +++
>   include/uapi/linux/kvm.h       |  9 +++++++++
>   virt/kvm/guest_memfd.c         | 28 ++++++++++++++++++++++++++++
>   virt/kvm/kvm_main.c            | 19 ++++++++++++++++++-
>   5 files changed, 81 insertions(+), 1 deletion(-)
> 
> 
> base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da



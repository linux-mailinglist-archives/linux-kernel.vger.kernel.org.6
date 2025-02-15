Return-Path: <linux-kernel+bounces-515839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E300FA36990
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B6B18997CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FF0567D;
	Sat, 15 Feb 2025 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+rEuEUb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB42907
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578088; cv=none; b=Fktpv9XczMVoWXl1buNXktWCAmarvjE5Sy9dy16MUZl4oL2gWE4oBtu6t8d3mfnmiQRUi4M0e/Ws03QQFSz51EXD0gUDeUf90KhBT3P747figFWfS6Qy62masZ4yic5O9NYGk+f7MfexRdvV1y+01KsHJlz/gQZxPnPRU8UDfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578088; c=relaxed/simple;
	bh=Fvdkd5oSUL8Sc4FxfhwLiEeosfdsIkh2xZkpznLTiKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lj07ALB0/OpQR+6Yx3gA3PDBic8ke+n1GbGEd2nWF3PH8uXjmy0k9pqwrPrv2DTshruNAyBSXQczJPF1zPVwkSyUpRBOYuiBRjBpNwbJposQWYN9KZJ5ynlpKBQ383rXlNRruOwwbdBGWwo5xFXNznx+gjA0IBSrBOFQKnAE9WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+rEuEUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739578085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dde8t2t0iRk/0B4RUYBxeInO7gUe801780SUKxb18V8=;
	b=h+rEuEUbgyTizKExOOZVqtfK3oMA725lAjctKhw7BlGNBgMgqP95OMVc5us4D16ktfceSl
	3cGKdXGtZeaiC98ZuQ6ZI1nKXzTGMmJtJd4z88vYJpIZE9wB/1YLQt+V73JXDq2w+njlJ6
	L+26hTSzHA/6x1PEjzKhk8/93a6WZRw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-5YUSMxnHOCeQuUAFG7FTWQ-1; Fri, 14 Feb 2025 19:08:03 -0500
X-MC-Unique: 5YUSMxnHOCeQuUAFG7FTWQ-1
X-Mimecast-MFC-AGG-ID: 5YUSMxnHOCeQuUAFG7FTWQ_1739578082
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38de0201961so2577268f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578082; x=1740182882;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dde8t2t0iRk/0B4RUYBxeInO7gUe801780SUKxb18V8=;
        b=bzE1vuflK7SmuNLnxTV69nJ+KnNODwA4AJ6ZnJ53j/A3r/Hb9OJUH/ZDB+tSJ4EPvy
         OujBDxTKGFaXM8eHW8HnghmfOMqqs3zVTJAVArVA9xpbeaLFCGAca1Mm2lIAH32eXMls
         vmhSM6N8MbPtx9rDMjH0v+Mppju17H6XSzVPQ+fQr33Wkht8js54RIWZa73wlwyO0xc7
         tMz5IAh2rTrxAyjIQhhmX5RfdiKX89DMQ6tLGaUYFnxl9HBAAyb5zPTnsf6ugN1BTsIu
         Gfip2tAIjRMmIDwLZ6QdpaAWgIaVuMKLP49BS4yBVbwnotcS6fEOqPjzhptlAOhwfef1
         O4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX45qYhCp2LYmpyn10Y5gKUpQsH5Vi1XM75YLrJSGwNbP3WaGdBOBeCEs5vwM/YfGUhwTeW+TO3Fb3qWgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46fRDpwPL8ySYYse80MaMtXczULnAXdpZ+imnbCkGWgKZUhnd
	ebFIdhz2gFP3eeLxD7OPr7qVZH3OB/hlwm5Sg/zMldl6O5epqKeHCEdGWzwLf3qjosalbY10kWR
	NRte0AoTqdUh8CSerTDyIri+1OxGE8ltVkhjqqF1ALrM5PStYNhTrwvbrxOsuIA==
X-Gm-Gg: ASbGncvz0l90YTxCJYHKE2adJa/hyibAGXhrrG0Pak2cfBvGSIXm98vYDluJqRVf0Fv
	B7Mk2jxtkADfgF1DJBUavSC4IDFkI6ngMvkoDcmB/7RUlh2dTA17GDjX46lbNKXjt224V/PxtfA
	FJ4aUNEUTgqOsb1ece2UxuJ9FaQHY2FUOT30Gg8UByrADWVfQp1Q3Fx8vnFOQIAX6KZ22vp73YX
	05S1NqcNKEWb06HxVI6NO6DLmIYULR0JbSuEKmBJ61skMOgNv2nuRs5By7det3OGT8BVGzAk5+P
	+M+11lE9QOw=
X-Received: by 2002:a5d:5850:0:b0:38f:31b6:4f30 with SMTP id ffacd0b85a97d-38f33f4a8c6mr1261801f8f.35.1739578082503;
        Fri, 14 Feb 2025 16:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjg1xvjCQd4TrCjV6sMCBq5+kC10xDRLuwFyQIXZtPyJBIJeUWsXqQgGAKLPfsCZx/sYHMkw==
X-Received: by 2002:a5d:5850:0:b0:38f:31b6:4f30 with SMTP id ffacd0b85a97d-38f33f4a8c6mr1261774f8f.35.1739578082120;
        Fri, 14 Feb 2025 16:08:02 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259f85c2sm6050514f8f.91.2025.02.14.16.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 16:08:01 -0800 (PST)
Message-ID: <1db73488-4095-4ac1-ad10-139615981de2@redhat.com>
Date: Sat, 15 Feb 2025 01:08:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Load DR6 with guest value only before entering
 .vcpu_run() loop
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Stultz <jstultz@google.com>, Jim Mattson <jmattson@google.com>
References: <20250125011833.3644371-1-seanjc@google.com>
 <20250214234058.2074135-1-pbonzini@redhat.com> <Z6_ai1HdLWiTJ2Pf@google.com>
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
In-Reply-To: <Z6_ai1HdLWiTJ2Pf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/25 01:06, Sean Christopherson wrote:
> On Fri, Feb 14, 2025, Paolo Bonzini wrote:
>> Queued, thanks.
> 
> Drat, I was too slow today.  I applied and pushed this to "kvm-x86 fixes" and
> linux-next (as of yesterday), along with a few other things, I just haven't sent
> out the "thanks" yet (got sidetracked).
> 
> If you want to grab those, here's a semi-impromptu pull request.  Otherwise I'll
> just drop this particular commit.

I had "KVM: nSVM: Enter guest mode before initializing nested NPT MMU" 
on my list, but not the others.

I'll just pull these, thanks.

Paolo

> --
> 
> The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:
> 
>    Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.14-rcN
> 
> for you to fetch changes up to c2fee09fc167c74a64adb08656cb993ea475197e:
> 
>    KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop (2025-02-12 08:59:38 -0800)
> 
> ----------------------------------------------------------------
> KVM fixes for 6.14 part 1
> 
>   - Reject Hyper-V SEND_IPI hypercalls if the local APIC isn't being emulated
>     by KVM to fix a NULL pointer dereference.
> 
>   - Enter guest mode (L2) from KVM's perspective before initializing the vCPU's
>     nested NPT MMU so that the MMU is properly tagged for L2, not L1.
> 
>   - Load the guest's DR6 outside of the innermost .vcpu_run() loop, as the
>     guest's value may be stale if a VM-Exit is handled in the fastpath.
> 
> ----------------------------------------------------------------
> Sean Christopherson (6):
>        KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
>        KVM: selftests: Mark test_hv_cpuid_e2big() static in Hyper-V CPUID test
>        KVM: selftests: Manage CPUID array in Hyper-V CPUID test's core helper
>        KVM: selftests: Add CPUID tests for Hyper-V features that need in-kernel APIC
>        KVM: nSVM: Enter guest mode before initializing nested NPT MMU
>        KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop
> 
>   arch/x86/include/asm/kvm-x86-ops.h             |  1 +
>   arch/x86/include/asm/kvm_host.h                |  1 +
>   arch/x86/kvm/hyperv.c                          |  6 +++++-
>   arch/x86/kvm/mmu/mmu.c                         |  2 +-
>   arch/x86/kvm/svm/nested.c                      | 10 +++++-----
>   arch/x86/kvm/svm/svm.c                         | 13 ++++++-------
>   arch/x86/kvm/vmx/main.c                        |  1 +
>   arch/x86/kvm/vmx/vmx.c                         | 10 ++++++----
>   arch/x86/kvm/vmx/x86_ops.h                     |  1 +
>   arch/x86/kvm/x86.c                             |  3 +++
>   tools/testing/selftests/kvm/x86/hyperv_cpuid.c | 47 ++++++++++++++++++++++++++++++++---------------
>   11 files changed, 62 insertions(+), 33 deletions(-)
> 



Return-Path: <linux-kernel+bounces-529845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44F9A42BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D523AC87D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D64266190;
	Mon, 24 Feb 2025 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCxEbFQV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A3233709
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422389; cv=none; b=p4ELQl+YpDv9e7UcWq2JOC2AyXPkW3s3hlWKNU3VwpqCs+mahV7SnBwh6TXZKBSLnt7KPnpF1GioymOvCdIJDyTftuzBgM85NnZ6hppLqUdLgXD6uou7BEC0TThh5oo3pgV5gnyZJB+/qIikQ804i9LxZRJfkYvI/S4HFgz3uis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422389; c=relaxed/simple;
	bh=17WXvve8KQac6zX+R+4Naj7K5+dLJdHWaTN6UDlVQ2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWfjpk4nrHJtvA9skuKsx9egiM7R+1MSg/mYWRn/rhKfDya3UbLPqsKBi8JkpNkOteLmzwv4X5YqStaDBvhKlEzUoWsxmHmMit/WKW6BZXPPwMvwN7v4K5kSesr08OwOScIKmPsKboIU/nVu6dIgigPWmI37CdOgEHdg4SUt0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCxEbFQV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740422387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hjEUyHwOXVTWGrdMyVvXac+RzjdIiQNyg6ok0Fq2o54=;
	b=SCxEbFQV8YrEwaM9DhBi2ePwfmtOqnE3JpEnUfxNDKTufkfEFeb+4lxSozRdLCnUvaIgVM
	ehD9OGKE7pUs/mcF7gU/pJsp6e7fBNJUMhV6z5bs9t5qznjpVDz9Etpg3AX2z+XdHDuE1n
	XfTjZeQ4Eq1DxCgXxR/p/h6DxkBj3ds=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-W5RSd6etPSSm8rmPqLYIUw-1; Mon, 24 Feb 2025 13:39:45 -0500
X-MC-Unique: W5RSd6etPSSm8rmPqLYIUw-1
X-Mimecast-MFC-AGG-ID: W5RSd6etPSSm8rmPqLYIUw_1740422384
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f36f03312so1837121f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422384; x=1741027184;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjEUyHwOXVTWGrdMyVvXac+RzjdIiQNyg6ok0Fq2o54=;
        b=hX4Hw6t6oPzNa1dxD1vYrumoW6HgIR9w2oTg/zNsHvhQ4qb9KXI1Z225cpSjOuGv07
         kzm6NPY783pP9vXwTSd5WrVPytwjuiHb1YaNIaEIyYjDkW+vfHTgGzRj++n/GnruVnx4
         OWWa99AkKEwIiq6AEbJz+lssHFVAUNLDXH8e6pr8zXjQglaaUSAOYOhgEXkJaRrEs5Zc
         3K4tPSYuuLkRM4ZUVwipnaAKL3KxgWMAUqlfUDzgdparYQp3AJgT1aaBTDT+EPX+U+f0
         hxl4hTOTDkApC1lhjp7Yxy5qINyy9jDl7H50xE1ToGTwNYwhWqjGAXoa7q6dGqep8R86
         h+Og==
X-Forwarded-Encrypted: i=1; AJvYcCW8UzTlps5FRLNxKdFhKF7/p9PMxSIP3gE0+rpTA73jo0HOZ8dk6xA4cdiKFlH2669THywLSnZ5uTo/2Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+dHWDySzjWEz2Dn86bedEnmt5dXySmMNdhxj54IDRwVoyppN6
	JEdcShw4bURxCtenQxAkrQcALyfoK+OPpvzmLa9wAKbfLuBxymWyPcgjCtGekgNrM4Paqnup1kJ
	TliGEQ/nuInH9BM9DbY7KIwMagEvjXI9wlInIPjjwdxNwjIzHPmi2LMmRIXn+C3hLQ/QGQQCy
X-Gm-Gg: ASbGncvJXkc3ZXpFQ9caPMyGc3GEe9xVuObeI0QkTTGAj8b4yomVjnqeO6UR6m2Riqn
	kg+L2MzGsJ5VoJDcF0SYAHOmEwX1l5wzH36Th34/+BdEsPHmMJP+bzgZTkyH4hAYdcAzwB3Kbn8
	ZE3JoqqhO2vSrhLk71nHgEgkL8FIAtF4mIqgXrJLyOqv4MHP2aQGe9hYm/AODsnC9IjpMW/Bjcd
	VjgBjAESViCNYqSUGdBQyFWgk0O7TeLHg5lfuwOACxNzshbEP2uWX64iKgacym5tHL3aznm8W06
	LlnmMj8CL0R8kDgjuLf5
X-Received: by 2002:a05:6000:1f88:b0:38f:6697:af93 with SMTP id ffacd0b85a97d-390cc5ef413mr110550f8f.9.1740422384021;
        Mon, 24 Feb 2025 10:39:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8QBPsKUxM4TvjlFph6t12eGMjkQHjGM7uJzw1fITu60B8CDyiB6RK3SMiLUQxVzwe+zdKVQ==
X-Received: by 2002:a05:6000:1f88:b0:38f:6697:af93 with SMTP id ffacd0b85a97d-390cc5ef413mr110537f8f.9.1740422383696;
        Mon, 24 Feb 2025 10:39:43 -0800 (PST)
Received: from [192.168.10.81] ([176.206.102.52])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f258f5fb6sm31846189f8f.44.2025.02.24.10.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 10:39:43 -0800 (PST)
Message-ID: <bb9e45ae-11ae-43bb-b53b-cf2e9dede3e5@redhat.com>
Date: Mon, 24 Feb 2025 19:39:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] two KVM MMU fixes for TDX
To: Yan Zhao <yan.y.zhao@intel.com>, seanjc@google.com
Cc: rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20250220102436.24373-1-yan.y.zhao@intel.com>
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
In-Reply-To: <20250220102436.24373-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 11:24, Yan Zhao wrote:
> Hi,
> 
> There are two fixes to KVM MMU for TDX in response to two hypothetically
> triggered errors:
> (1) errors in tdh_mem_page_add(),
> (2) fatal errors in tdh_mem_sept_add()/tdh_mem_page_aug().
> 
> Patch 1 handles the error in SEPT zap resulting from error (1).
> Patch 2 fixes a possible stuck in the kernel loop introduced by error (2).
> 
> The two errors are not observed in any real workloads yet.
> The series is tested by faking the error in the SEAMCALL wrapper while
> bypassing the real SEAMCALLs.
> 
> v2:
> - Use kvm_check_request(KVM_REQ_VM_DEAD) to detect VM dead in patch 2.
>    (Sean)
> 
> v1: https://lore.kernel.org/all/20250217085535.19614-1-yan.y.zhao@intel.com
> 
> Thanks
> Yan

Applied to kvm-coco-queue, thanks.

Paolo



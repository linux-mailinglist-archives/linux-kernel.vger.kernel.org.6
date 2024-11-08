Return-Path: <linux-kernel+bounces-401317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29C29C18C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22ADC1C21F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547B1E00AC;
	Fri,  8 Nov 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBjxDHUG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA951E0DAA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056866; cv=none; b=ZIZHv/2JjDknLZ0YsIvEtBb3rBhL4yXup51VOzkPyd01JRMj4A4jIavUpsMT13daXeVrEg1diZ+aMWejTxv2ID1OKh63mTFuFESNA/PQj5wKyWzFI3Ua7A8+oIei7pUvSG/qQnkrtakM588PJ1WVoBiAMWGwVu9szTZf/KtVlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056866; c=relaxed/simple;
	bh=RaS1Ypktj7/Y2jpFd2NCDI+iutjiDR606DmvM1f9xLs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pf7I5rypwqUbpCJRCaQjPvzAIdEVYQ37QFCszoPnrvlLgbR5WCQIsvLmF2Op0sl4tS02/k4vhke3VN7uZoPbPXZmCicEktc9nhAugU1mU62eAd7b2s4K6cjPRgsNRF4nlBQgiKSDlcInosPvznXjwgBqM7dlryVkA2tgmRr6N/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBjxDHUG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731056863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RaS1Ypktj7/Y2jpFd2NCDI+iutjiDR606DmvM1f9xLs=;
	b=UBjxDHUG0j6RvRiw7SIy8mkTNAt2DVuravdjtPxNY4yk+3wO/db+vr0xGKgNxe1YGGCw5I
	Pw41Z4i4yV3t7Utg+8OmwpYvTLcpeMZNmx5eJf7/9O0QlhhRV1PB0ItjzdWlJvUPwFAf0G
	Z4i+rsRg/Je8ytA/WpFD6tQz3kI6Dqo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-ZamyDa40Np2mjRxgaldqMA-1; Fri, 08 Nov 2024 04:07:42 -0500
X-MC-Unique: ZamyDa40Np2mjRxgaldqMA-1
X-Mimecast-MFC-AGG-ID: ZamyDa40Np2mjRxgaldqMA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43157cff1d1so13607485e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056860; x=1731661660;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaS1Ypktj7/Y2jpFd2NCDI+iutjiDR606DmvM1f9xLs=;
        b=LKewsnlOptiCYoAZvul4maiR7MqWWg71QZtMYKjefDswghn50rWxqjhLWrr//LK/nS
         6KdHkiTWS0IOV6CxMLQII11eQWDE7eY6RWo2TOsbJuoBkM4coK02wb2lZAQ8Tt613kXH
         1MaW+KFs5uO8y0ZddY3QNOXY3OZY8JZSN9+3eD9tmBu81qvMAsXfVPMakIO4W1Uezfya
         O/sAjaHUCS6HshcqzfuhYWFN2T5l1nc/MQf3vbgLlY28Gh/7xy/mIzUykdG48QfcXFjp
         9tSXvU0H2WCaDXT2kkDc9fBmkcy9WOOr/iZVRdyAi/sfc64fkYiGuLtntvHxmD7i9aiG
         +CnQ==
X-Gm-Message-State: AOJu0YyeR6H9ut2oux54SE3kTuQpi+BAAFNqLzEP1WO7y1wOEVNtcygs
	+5QMqq5zsgf0pnq4fxGyM8HkHbwA25x0y3Lu/KgHfY6tKE4VsA3Pbr1gCA5ZnIryU8xINqlcVLO
	MBCf5CWXxfXazc9oJLvkeADOYuhY+0bhlA++LlMkBQgWac8YoihhBTNYmKbBIFhP1VseluCAeuT
	m/PBzvyWZAvX8lQggu3E5nI9YVEDXfa1JwJ4sgJPfChTO2zYJu
X-Received: by 2002:a05:600c:46c4:b0:431:5aea:969 with SMTP id 5b1f17b1804b1-432b7502702mr14917045e9.8.1731056859885;
        Fri, 08 Nov 2024 01:07:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN78jYVFKGdWICbO5G7/cfI+8GH/WDQcaui7K4HFnC75BLpLVIJ82ch3DGh2NTHJcJ7UaQAA==
X-Received: by 2002:a05:600c:46c4:b0:431:5aea:969 with SMTP id 5b1f17b1804b1-432b7502702mr14916585e9.8.1731056859379;
        Fri, 08 Nov 2024 01:07:39 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5fc9sm91606505e9.3.2024.11.08.01.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:07:38 -0800 (PST)
Message-ID: <fda9058a-d3f2-45e8-a0d5-ee51284b9582@redhat.com>
Date: Fri, 8 Nov 2024 10:07:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Documentation: kvm: cleanup and introduce "VM
 planes"
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: roy.hopkins@suse.com, seanjc@google.com, michael.roth@amd.com,
 ashish.kalra@amd.com, jroedel@suse.de, thomas.lendacky@amd.com,
 nsaenz@amazon.com, anelkz@amazon.de, oliver.upton@linux.dev,
 isaku.yamahata@intel.com, maz@kernel.org, steven.price@arm.com,
 kai.huang@intel.com, rick.p.edgecombe@intel.com,
 James.Bottomley@HansenPartnership.com
References: <20241023124507.280382-1-pbonzini@redhat.com>
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
In-Reply-To: <20241023124507.280382-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 14:45, Paolo Bonzini wrote:
> In order to add the relevant text, there are a few cleanups that can be applied
> separately.

Applied patches 1-4.

Paolo



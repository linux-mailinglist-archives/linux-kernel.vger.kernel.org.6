Return-Path: <linux-kernel+bounces-287013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB1952191
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF8F283F63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972611BD020;
	Wed, 14 Aug 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZTM1FSP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560363398B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658044; cv=none; b=mWoQK3tcYX4oPIydFYMzGKIyfSth9EYxEujmZZgB2JT/Ymb8VgjlXIBLEcRNnzt4TE2zT8+wDC4NQt1dB5ci5/LEwaBnOx3rUmhm/7q53Qo2R6jGmgcXQCmcxHzc+dg3QqEFDF8j2iZla0LlOgygBnMBlmORpOUrqE5oHTZYicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658044; c=relaxed/simple;
	bh=K9ZcCXNR6AhP16LYTClrH523SOz36Om1uAG1kkWUekA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpNQRLlV5K5n6cQHaB3nT93e4ro21sB7Kh2sxnnXeJhG5w42uqi3oht2kxPcxi5xk7rDh+iuGj3KwjTaVyh3VFPKu92ZHdiZ2Mn++DOkAzniaeh++ckOCGdFJx8NWKvEzvBl9BOi0woEsEoulEwwpXb7OD2tI6GGCi4YZ5vq0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZTM1FSP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723658040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aqW1pStkkqE8bSHAyK2eetUPj2vtzB+TVj0YShqKUw8=;
	b=BZTM1FSPQVW5zw/8N/grYxcDGW/1Skdz+elwCDe9QAG9wu9ZI3GUHbDHxFaM40xTO2xOs9
	AjLUFvIwy2uYzHNmdsYmQv1z38/PC7zHgTClT0vtmgsebzD0VgFgO/lgNf/oW3pFIFu+zi
	TxAhP9Isvo89im5iVmdrFyEA7kkOczI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-oHGxPuS-NmSVWhT3ThGUIw-1; Wed, 14 Aug 2024 13:53:58 -0400
X-MC-Unique: oHGxPuS-NmSVWhT3ThGUIw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-369bbbdb5a1so49364f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658037; x=1724262837;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqW1pStkkqE8bSHAyK2eetUPj2vtzB+TVj0YShqKUw8=;
        b=cjQOwzKcMOoUyWd/SicE3yV5H9+Y9+WVJkxxvXnTozjhY6W9efLMgQUrTFfBnZEMif
         LgvvBIU57VPY8KD8jeAtUkLY/G/+6/MtXzItTI4eSQpDgsdAkj0mScVcAEMoaodvdVsH
         kQ4Fs2DcQemM9b42qhtR7YxQ4GaQt9btDZBvqJ2QgCTYMN3zigILM6TXvkpi5Bp2JiBh
         Tp8gKXZMwgIHkCCl2UXLUPB5JxBiaDVPrudV1OrEImeU2Yr3kf9HoVbBoRlqMzSDOeGU
         4s5AWWr63JvP9ELK3alehj6SJNDi58ufvmTXj80pjYjg7EJm0AydevraorLbnEjsMITS
         p2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVP0piIS+8VGMfCbmCMOQz2Zfc4urnZiLjdmrqwYbxsHOasEwCE8J0xlle/Ocg621Q4oC1pbmFfO0lrH/wblTdIUlOZ8THaqvz+s5uj
X-Gm-Message-State: AOJu0Yxb/FTGxNndVxHk+hT6b/XBTGyCYmRWSs+JYOFA9VSVHk1hREW3
	5jHJbYSRQ/VZRChhDP+1kHncxEnp3DHQL4qsK6fANdaNgZ8sDi50jVg5MdbjslZHs/BHRB6bzj2
	YLB5YHcUz8wKid6PK8vklEXYQZkQ1AWWpqdO8zSG+BAv7YbI0p5q/0QfQdvl2ng==
X-Received: by 2002:adf:e3cf:0:b0:366:e9fa:17b with SMTP id ffacd0b85a97d-37186b85f8dmr478964f8f.1.1723658037486;
        Wed, 14 Aug 2024 10:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0gtugkRTcQm7G8pkJF3tmkwxTEKg02g/XJX7ambB07oT/yEXqXmEM1X4Q43rWoTjJipEklw==
X-Received: by 2002:adf:e3cf:0:b0:366:e9fa:17b with SMTP id ffacd0b85a97d-37186b85f8dmr478945f8f.1.1723658037010;
        Wed, 14 Aug 2024 10:53:57 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36e4e51ea09sm13463097f8f.71.2024.08.14.10.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:53:56 -0700 (PDT)
Message-ID: <aede9ea1-099a-47db-a133-28ad22206858@redhat.com>
Date: Wed, 14 Aug 2024 19:53:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] KVM: x86: Check EMULTYPE_WRITE_PF_TO_SP before
 unprotecting gfn
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerly Tng <ackerleytng@google.com>
References: <20240809190319.1710470-1-seanjc@google.com>
 <20240809190319.1710470-18-seanjc@google.com>
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
In-Reply-To: <20240809190319.1710470-18-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 21:03, Sean Christopherson wrote:
> +	 * Retry even if _this_ vCPU didn't unprotect the gfn, as it's possible
> +	 * all SPTEs were already zapped by a different task.  The alternative
> +	 * is to report the error to userspace and likely terminate the guest,
> +	 * and the infinite loop detection logic will prevent retrying the page
> +	 * fault indefinitely, i.e. there's nothing to lose by retrying.

Putting myself in the shoes of someone unfamiliar with the code, I might 
prefer "the last_retry_eip/last_retry_addr checks" to "the infinite loop 
detection logic"; after all, you're saying in the same sentence that 
it's preventing an infinite loop.

Thanks,

Paolo



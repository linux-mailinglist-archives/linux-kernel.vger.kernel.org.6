Return-Path: <linux-kernel+bounces-529878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC86A42C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E223A76B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC626659C;
	Mon, 24 Feb 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axFhju3T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53882661B7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423432; cv=none; b=f196qk8FqUdz+y+5ZnwmTr+0Kqm3DkGi3keO7pgwaxbraFJlLllR54tjMsPZBoNFDQlLn7V83Ox2JMfAvP0QELY+3K3XEKedQnqH90RO78jtetJou3i++PyUIVeaqHweXP5TEyuqtU/UMmdckcRhsFVWA9W/DbzyvlFqcQHvmYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423432; c=relaxed/simple;
	bh=Hz84raVLuAyjyzzMgm+1gEgjbyKFbxIRw4xCAdr99vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cONLj3nhpw8aZDhT4XlrKcQPckkCkJzQxdD1mcMALpb1NL4ebne4RhvirLjMkUzB/x7UrxpE+BcSZpr49yYpba2lEUaWGEOnR1+h5JK9zTCqLKOb9//KSWl/F7PLxb8bRQfxrC2wl5esgYSaWFqVATxv/lW1EvIZqsWczHU1owM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axFhju3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740423429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KhfTh7shoIpSJvz3/05psXcWqpHL6Z0qKaX1gsQGMTo=;
	b=axFhju3TMmbqpU6Yz90cZvigA+rKf76t1hb9wFOy/ZVFFbrI9EO0ymT7/kkLq9EkZflUBW
	Mr3421yRMnFdnOwc203nxX49nJeCjimX3bcpyUQne0xXrmLJ5a0KproCMUng7BCFRuJLMv
	1tA+kd9gOq9m9cgrsahyxdEPUJYWvpQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-rbdOpq39Nb-canRfLWj0gw-1; Mon, 24 Feb 2025 13:57:07 -0500
X-MC-Unique: rbdOpq39Nb-canRfLWj0gw-1
X-Mimecast-MFC-AGG-ID: rbdOpq39Nb-canRfLWj0gw_1740423427
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4398a60b61fso24240065e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423426; x=1741028226;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhfTh7shoIpSJvz3/05psXcWqpHL6Z0qKaX1gsQGMTo=;
        b=qb7YttYoBJco6eZJv08aYCe9nErjZjckf7J+53BNmZPPmm/AmaLMCALAGCXiT4jhXB
         l6D6e4iS9mFf+rdLA9cdw+TCkWBxvcK69oVvHpQ9uaW42g/ixzOQbdRJhJsIJPxoLbJg
         atf0K9Y5utAygal+BbQsIftYNAxXFKXhJj2eGFojA1ITblCQxA4QrrYW5WTjAOZuXrKy
         NdOgxCBIfk8nCG+R3ID3Pyf3+aVfb3xukiRJXq40FPhFWHM1lFvJCBM2PeLEIQbaApAH
         D5+3BHvxwPqTyqIB33/RJlgwN8NGMnz19O1LS1m/hWHYOSEvsoWbnNDhffFi17aoC21a
         8aEg==
X-Forwarded-Encrypted: i=1; AJvYcCUvG0CjqGDeVFH0YwFf/CygesZRYFe5PetWLl3nYI2r1KBBFhiW3tIbOqbUvgMn8rSujRO8q9vQb01l0Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQX+TnJZsj3MswT4z4/cu9NrldADQK093eR67QRJOqDg7o3D/
	PGRwi3fUFXo0Rn+UYZESYUse30dIcNTZFNtRU8PTxbQIy2u5NNBrnXBb758CGFO0/tjhIjtbqob
	7zcj524qHuEjaBrMmndvWsRwvnbB7WWUysONQis5XV6jL9WR7vIor0YkR4sU3wg==
X-Gm-Gg: ASbGncuH+lE/jTLCUUfZF7K15LpOOtKmWn0ifZHDcPrw0LU1XsdiVr/hgpG90Do1zH2
	hMhsTXbQWt+JP2BM2qgCgvOwSNzb5PpwJiKactfrTVZVpd3AfQEojnUMPqqoT4iRlAFsSdu2lIH
	AwMxBMGHIYtNaCDoI1DivatmgaICa9N5orHME2ovEyWth+b5/Rg/srT5sWdTD+aXwLViZh1cJbH
	iqoBD450nrBs9ze0XBLiTjusbsRv6WXmsrGUKklRy3LP6O5M+925kJiX+OLcUGlvd1YKNMnkzfr
	Kg+PuFYahNDx7L8LfkVU
X-Received: by 2002:a05:600c:46c7:b0:439:955d:c4e2 with SMTP id 5b1f17b1804b1-43ab0f3c192mr3563305e9.13.1740423426560;
        Mon, 24 Feb 2025 10:57:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYk/+XqvAO4i3wE4t9kr3Urlqp2iSHktd2AnVHAeLhyw75bcJlxWN+dFCI4JqLkRH1xhEx3g==
X-Received: by 2002:a05:600c:46c7:b0:439:955d:c4e2 with SMTP id 5b1f17b1804b1-43ab0f3c192mr3563135e9.13.1740423426153;
        Mon, 24 Feb 2025 10:57:06 -0800 (PST)
Received: from [192.168.10.81] ([176.206.102.52])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm32368269f8f.26.2025.02.24.10.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 10:57:05 -0800 (PST)
Message-ID: <03baa2d7-b872-4348-a166-a8cddb3033a5@redhat.com>
Date: Mon, 24 Feb 2025 19:57:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/30] KVM: VMX: Initialize TDX during KVM module load
To: "Huang, Kai" <kai.huang@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "seanjc@google.com" <seanjc@google.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20250220170604.2279312-1-pbonzini@redhat.com>
 <20250220170604.2279312-13-pbonzini@redhat.com>
 <64168d1d11afb399685067c6f8d57a738bb97eb6.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <64168d1d11afb399685067c6f8d57a738bb97eb6.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/25 00:27, Huang, Kai wrote:
> Hi Paolo,
> 
> This patch still doesn't address a bug Chao pointed out, that the
> __do_tdx_cleanup() can be called from __do_tdx_bringup() with cpus_read_lock()
> being hold, so we need to use cpuhp_remove_state_nocalls_cpuslocked() in
> __do_tdx_cleanup().
> 
> I posted a diff to address here:
> 
> https://lore.kernel.org/lkml/46ea74bcd8eebe241a143e9280c65ca33cb8dcce.camel@intel.com/T/#m1e86328e69b27e6cc9978f90df923144d699c350
> 
> It would be great if you could squash to the kvm-coco-queue.  There will be some
> minor rebase conflict to the rest patches, though, so if you want me to send out
> fixup patch(es) for you to squash please do let me know.
> 
> Btw, the diff also moves the 'enable_virt_at_load' check to
> kvm_can_support_tdx(), which isn't related to this issue.  Below is the diff
> (also attached) w/o this code change but only to address the above bug if you
> prefer.

Thank, I applied this one.  In fact I think we can remove 
kvm_can_support_tdx() altogether and inline it in tdx_bringup(),
since there are other checks like MOVDIR64B.

The conflicts are not problematic so I'm happy to solve them for you.

Paolo



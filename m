Return-Path: <linux-kernel+bounces-182296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94418C8952
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805F5288EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ABE12D74F;
	Fri, 17 May 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3aJOB7I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6627E8479
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959658; cv=none; b=sRus5k4Kkmf8ifxacymv8K6h2TKNjDOX9RZSOwRK8A72FeRUeeiUkxCdi42osttJmGUjf6qnzqhrXgFWr9RsFTU1c6/C2nxDhUF4gjcFVjeHBtfS4ya7xB2GevLSbISoR9gaQMick61f07NA8dB/yUfan4JUXmK4wtRu0TckRHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959658; c=relaxed/simple;
	bh=3XMr70djBC2wwTiLy0f88qgaJkOG35+cgZjEnDTWZ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVNa14axQRklmCTuTdJ1zC/vBupuAB7UGOQFHNWlnm8UwGsNJs/ALB/S/uNoqCWdm6uqPjgzuC8v5Jvru3VRTWcKRJw5oVjY5ZKsR0AoQ4lntKQX8qT6JydIxgdj0IEshA+DzuS9FrxZc8c4YP2qS+i+m8750EaZgOYBsJAPVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3aJOB7I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715959656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WGDY5Z28wVzuAjsQs/ta+6J/yuKLaL4MRw5s433qlXs=;
	b=F3aJOB7ILGQdIDdezOcED7asNYBfkjYbBDQ5hqbvtln+VU4a8aYYsd9GKpoiKMnaERME8t
	ydVgLOkLODMpiZDiDvT6HIe2mJ3b0E/95wNSMMc+38r4Ozn+dv6Rx0uQO04AaLDhDJ3bWi
	KNUByI6YaguxtXhen2V5miIH4isc5YI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-dM5t9CBSPlyElWhXr3x2jQ-1; Fri, 17 May 2024 11:27:35 -0400
X-MC-Unique: dM5t9CBSPlyElWhXr3x2jQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5a180153aeso573026066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959654; x=1716564454;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGDY5Z28wVzuAjsQs/ta+6J/yuKLaL4MRw5s433qlXs=;
        b=cnAu9UwPd4Z24reKVhsfTgy9bbE9m9B0RHJsZkjktwSKWeLX/EpVRtMwLsc+6ynfXA
         MpNPi7ek6HOBptJG1/ZaPiPdRvwupvk6vf150lbbOBYfO4Ci5nM+E+H21xhHccjyHefY
         ew3TJ5jJ/DXVDAcNmtu9ctvd9wDTE8/M0dGlHi+eSkKIAlisoGqp5Gt3nFanhwDfOkq0
         +T/ChXs4xPknkkV4xT+HaWTNFSN3zhNJ/X3//MKmdSairfCfPXmyOV25VRgp7MRa/z+V
         TE8TZFSV7f2zvfrgP3fRS2zgFzBhtvFss+hklUhWsmd4xTfrKncyIz/ztFIk9YT/y1zn
         JjOw==
X-Forwarded-Encrypted: i=1; AJvYcCWV6oqjkw+yAYQm0+1zNbD4x3+Dw1UM9i/e6LM6StUg7epYH/shL0j90rYILE7BZa4dbEr2vA8hungxK1ce2i14X17sBG0GfRdypYk9
X-Gm-Message-State: AOJu0YztdB8UHdk4Rr46EQQu/ON2Y1xrHXxgTOD5jOihvildFj3focPh
	yqGLH6lz9NxyT4YHw0pmMh5CaZKgyinpSMgPehrDC/f7wVdW3+Z81wjxMDUL7M3MrOZ0OOyYCUX
	1NdP/eeAktzcrVjD9ouRa4i/4yYm4hLkJ9Ui3Mv95wGqgipAusdnO8JelKsQiYA==
X-Received: by 2002:a17:906:f1cd:b0:a59:af54:1651 with SMTP id a640c23a62f3a-a5a2d641977mr1356727066b.57.1715959653859;
        Fri, 17 May 2024 08:27:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+l6w6qSHk15/SFXoayH2qKkKWEuppAZBqG5jkguylL6yIWhzCVgRBwcrCwOwTm7Za2LzYKQ==
X-Received: by 2002:a17:906:f1cd:b0:a59:af54:1651 with SMTP id a640c23a62f3a-a5a2d641977mr1356725266b.57.1715959653523;
        Fri, 17 May 2024 08:27:33 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm1129188766b.129.2024.05.17.08.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 08:27:33 -0700 (PDT)
Message-ID: <fa88344c-cf0b-478f-9713-906aeb616da7@redhat.com>
Date: Fri, 17 May 2024 17:27:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] KVM: x86/mmu: Introduce a slot flag to zap only
 slot leafs on slot deletion
To: Sean Christopherson <seanjc@google.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kai Huang <kai.huang@intel.com>,
 "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
 "sagis@google.com" <sagis@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yan Y Zhao <yan.y.zhao@intel.com>, Erdem Aktas <erdemaktas@google.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "dmatlack@google.com" <dmatlack@google.com>
References: <20240515005952.3410568-1-rick.p.edgecombe@intel.com>
 <20240515005952.3410568-3-rick.p.edgecombe@intel.com>
 <b89385e5c7f4c3e5bc97045ec909455c33652fb1.camel@intel.com>
 <ZkUIMKxhhYbrvS8I@google.com>
 <1257b7b43472fad6287b648ec96fc27a89766eb9.camel@intel.com>
 <ZkUVcjYhgVpVcGAV@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZkUVcjYhgVpVcGAV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 22:05, Sean Christopherson wrote:
>> Again thinking of the userspace memory analogy... Aren't there some VMs where
>> the fast zap is faster? Like if you have guest with a small memslot that gets
>> deleted all the time, you could want it to be zapped specifically. But for the
>> giant memslot next to it, you might want to do the fast zap all thing.
>
> Yes.  But...

On the other hand, tearing down a giant memslot isn't really common. 
The main occurrence of memslots going away is 1) BIOS fiddling with low 
memory permissions;  2) PCI BARs.  The former is only happening at boot 
and with small memslots, the latter can in principle involve large
memslots but... just don't do it.

Paolo



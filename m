Return-Path: <linux-kernel+bounces-182295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478108C8950
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C4F1F225D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F52512D76D;
	Fri, 17 May 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2EdMMMn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C038563B
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959535; cv=none; b=t0HGUD7PVidZIjOlnVh1g6Rm0vAFZrXj22h0cbrRTm8LsS5oUSjbuUM06E5ti0jJuY4Lur0Ci61KaO1Cj/Cpa7aMKM4D6v7C9sBrKwTOtPhKpy+Gg+zdeEPlay4DGdT48wIsaCoWp4viFeZQinLPTpGVlNEkknNTSE5pwxvTT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959535; c=relaxed/simple;
	bh=L/hQ9hsxly22NSdyX1KQ/qYOBD96PL0OtwxrOLLdb9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLuKSPu1AD09Kx4lUR5/7IgphDawFuBhYaLPk/SOsQhLNvBLUydgCFLYcazEDxD5KFM11e9rUs+22EG+UISuZm0xNdsCSyvqKIaJudy0HRnUWy6jbWVSPd1RKtMCrPUdUmrW58JsaCDdcLbSAIctXYwMjEHI1PS9xSW5FcgNMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2EdMMMn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715959532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JMkuMCExkd+jnHx2CQIdqcNWY4Tk4zsm7c4CxYEL2E8=;
	b=S2EdMMMnrVbfBsrNgVfOsp2rHC4/Ng1pq3yLxihs0gy/wUxIXDLN1t6f4MsJphY+KlT5SS
	vaEa0+hVMObOhTht5qUc3fUx4r9UZrv4zFhVMqswiyhloACd5YdkJjqAQskfBtzHEoq4za
	KlBVeCC3Aqvd1PZaCv0YbvGc2bf7+5Y=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-NahIQEnSPfuFVBtDTzL1DA-1; Fri, 17 May 2024 11:25:30 -0400
X-MC-Unique: NahIQEnSPfuFVBtDTzL1DA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51f843d9194so8631057e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959528; x=1716564328;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMkuMCExkd+jnHx2CQIdqcNWY4Tk4zsm7c4CxYEL2E8=;
        b=bQKKjEPq54K1hPzDdOFjrG66W8bEDh1A9SZh22rAs8CGBA/yrvmtwoFSocv+aNTfwu
         l75EQ5rIRFas+FRHFpaVPj+be4eswWSzbILgBb3599oTAcJnR4yUjsMU/FhSDeMFy8xM
         YfSu7NEI2pE3z99MxZqfirY4Ss44W+pi+R8MQyFCRqGvZ9RjyWJV+JbenS9v2DkpaMLF
         Bszk7aoGgeqME6j5zzE4+tRj8ciH4WBsP5B/cQiIkIrwHQ3dAzHq76fnp01qrXoEJdfg
         4rF2yjrGNInyOF0YiV7cCowVbUwcIEucNadZYAcj/mSnIyNMNhAX57GvzkLm2NaCgAWu
         wvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6LziDPJ57PjBw6rta8+xc1PhBNuyq/uiyuJeE2b/vXwuGRr2Xa1Oi6R3Wg1hBiwmkTzANIISlmG+G0QSLa1Y96DG5fCoA8XSyNQHt
X-Gm-Message-State: AOJu0Yxi/XKYPmu/ymwKRTZfSeAOh8fcDwjbWMg0b1YXR+hpBVFXAkwH
	fUljVxrSlbP2gkLaTV6n8UQSvozg1e74nnzIAZaqOSqkWTchll4Z52uJ2pcPH8upgK9HKRM3XTr
	5NsB9ZJNuHGcpS/xzjeTk5pFLjlhI7tEE8DL9CoOQv3hXqD3WltMa6Kr0WrRPDw==
X-Received: by 2002:a05:6512:10cc:b0:523:683a:f5ed with SMTP id 2adb3069b0e04-523683af738mr10692178e87.9.1715959528616;
        Fri, 17 May 2024 08:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrmYgUnrOxXhnTdO+jAf+Nk9lW2hqldnTnE5hM2ZGy6e6Ncy4hqF5NqGe5RxXtLfWSnyPFFw==
X-Received: by 2002:a05:6512:10cc:b0:523:683a:f5ed with SMTP id 2adb3069b0e04-523683af738mr10692152e87.9.1715959528137;
        Fri, 17 May 2024 08:25:28 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323887sm12211509a12.89.2024.05.17.08.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 08:25:27 -0700 (PDT)
Message-ID: <a52c307c-66a8-41df-b40d-d4b4fcd5da5c@redhat.com>
Date: Fri, 17 May 2024 17:25:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] KVM: x86/mmu: Introduce a slot flag to zap only
 slot leafs on slot deletion
To: Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "sagis@google.com" <sagis@google.com>,
 "dmatlack@google.com" <dmatlack@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
 Yan Y Zhao <yan.y.zhao@intel.com>, Erdem Aktas <erdemaktas@google.com>
References: <20240515005952.3410568-1-rick.p.edgecombe@intel.com>
 <20240515005952.3410568-3-rick.p.edgecombe@intel.com>
 <b89385e5c7f4c3e5bc97045ec909455c33652fb1.camel@intel.com>
 <ZkUIMKxhhYbrvS8I@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZkUIMKxhhYbrvS8I@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 21:09, Sean Christopherson wrote:
> Hmm, actually, we already have new uAPI/ABI in the form of VM types.  What if
> we squeeze a documentation update into 6.10 (which adds the SEV VM flavors) to
> state that KVM's historical behavior of blasting all SPTEs is only_guaranteed_
> for KVM_X86_DEFAULT_VM?
> 
> Anyone know if QEMU deletes shared-only, i.e. non-guest_memfd, memslots during
> SEV-* boot?

Yes, the process is mostly the same for normal UEFI boot, SEV and SEV-ES.

However, it does so while the VM is paused (remember the atomic memslot
updates attempts?  that's now enforced by QEMU).  So it's quite possible
that the old bug is not visible anymore, independent of why VFIO caused
it.

Paolo

> If so, and assuming any such memslots are smallish, we could even
> start enforcing the new ABI by doing a precise zap for small (arbitrary limit TBD)
> shared-only memslots for !KVM_X86_DEFAULT_VM VMs.



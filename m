Return-Path: <linux-kernel+bounces-321544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0A9971BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9B11C20327
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE01BA894;
	Mon,  9 Sep 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWuPA7Eb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AF1B9B5A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890018; cv=none; b=a2Fwb6Qr1L8tbtEfW5VlUgyIX3UTl6xDl7zlKTID9XhAAbZd6LqV5oxa0weO8fzNMl9yVsJ+Pdv5Y4HznBsQb+usCq3HLQjdJVAv1++6YTiPcFP4A3Bz2ME3iDLF7uNoQ5OGwbNhYc9w6yWXMAtG4+tiDWW8Np7x0Z7t78N8Z7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890018; c=relaxed/simple;
	bh=6lpFZDhVrG3/GaSlPVPc98y5Bs5EC0xSL82X/4smWvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn9Yo3xBe0qb6kbm0L2lqwr/ZnPWCADEIjwyRLYWcCfaYgtWruHIqwzvjnQNtdMULluQVvLNkll0RfmKdmx6gsJ6MgNziq0Z+nTnAq9jveXgmc0U4wFDmYrg4Ihnqsed3h8R9tt5lGxpzajMBDUQ+7Vk70DCqwA+PM8YmEH4ckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWuPA7Eb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725890015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IsQRnE8iGkIDPevlzlo6+DQHj8Ph1msQbFaOs1yRsTg=;
	b=eWuPA7Ebv7mq6nGkgLxaIcPaxB3T8KXJ5cEzacWU25iw1PwQm9CNb3zgZT8BZyV56CdSIf
	fn+ztbKvvp4qaFFg1pvnVhNIq86c4qwaujnVop8xeSChP/5J7w7WGgd+npZvUkavaHDzXT
	epgjbFhlWD47UU1LWcyB14M5jmp0NNQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-IH-jwIeJOnik1znKpcr1Lw-1; Mon, 09 Sep 2024 09:53:34 -0400
X-MC-Unique: IH-jwIeJOnik1znKpcr1Lw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374bacd5cccso2453973f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890013; x=1726494813;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsQRnE8iGkIDPevlzlo6+DQHj8Ph1msQbFaOs1yRsTg=;
        b=oZM8tbd844OvVOcdhcPvcq+0Fz0HeTRK5zMSw7WeFo8RsrC/+A07AmLUC0nYwX2WRx
         BGX1iv2ELbnAF6Sfjj4M6L5vG02WNZ0LnaVKcLzyTZOt6ixjs9Z6vG3nlQCqt0QWPMY1
         v0hNdo8x6i209Xxtlto4kc7Cl80t2+G+mLrYzXFGjsLDvCzB6pUFeVYDzSUsQIxG4/eX
         lEGFeQXxKNMu1CP1dQAp38C/PQ6txRnkUUpIa498ppFP+vz7IALT6W/2buHfY//q3FCH
         6D9Q7u3/2d6/0WCuLCn4+UX39Tgm7roSzpbJ7EiqfEWXt0YzKSZtTi1PmQoIeuxv2xzk
         TQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGSSn3bev87UqhKxgko9gtT5yYO4inIEyNX+z5Skv0WjkVxNzdNqh4zPgYs/vVRoZ6/Uj0VQcx4c3hxVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgI5qInuYnh95P9UVL0wPqoFh5vVpkzfGnHxWUOV5Zj882sKX
	L4g8FOLyr12klMuMCyjAQa+4PMo0AyYHi/sqN1haW2n5/GkdCWGmpalxjsUxRRmIXwwsgp+f+Yl
	haM7tbtbPqC364MODltC/paoVXjONjEPGa5PTsM/M2A3ATDeV67FYg105pnvWJA==
X-Received: by 2002:adf:f582:0:b0:374:bb1b:d8a1 with SMTP id ffacd0b85a97d-378895c8952mr7037647f8f.13.1725890013455;
        Mon, 09 Sep 2024 06:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk/RZdu5hJmqPBD1gLK2Du0vc3Ucd0dFI9zif6lUjbFOdQm054xYpFZmm6lHghk0+9DSd3kQ==
X-Received: by 2002:adf:f582:0:b0:374:bb1b:d8a1 with SMTP id ffacd0b85a97d-378895c8952mr7037624f8f.13.1725890012968;
        Mon, 09 Sep 2024 06:53:32 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3789564a1absm6201030f8f.1.2024.09.09.06.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:53:32 -0700 (PDT)
Message-ID: <7d986ebc-f3a3-4a06-96a9-8c339fdfb23c@redhat.com>
Date: Mon, 9 Sep 2024 15:53:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] KVM: x86/mmu: Do not enable page track for TD guest
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, dmatlack@google.com, isaku.yamahata@gmail.com,
 yan.y.zhao@intel.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org,
 Yuan Yao <yuan.yao@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-4-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240904030751.117579-4-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 05:07, Rick Edgecombe wrote:
> From: Yan Zhao <yan.y.zhao@intel.com>
> 
> TDX does not support write protection and hence page track.
> Though !tdp_enabled and kvm_shadow_root_allocated(kvm) are always false
> for TD guest, should also return false when external write tracking is
> enabled.
> 
> Cc: Yuan Yao <yuan.yao@linux.intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
> v19:
> - drop TDX: from the short log
> - Added reviewed-by: BinBin
> ---
>   arch/x86/kvm/mmu/page_track.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> index 561c331fd6ec..26436113103a 100644
> --- a/arch/x86/kvm/mmu/page_track.c
> +++ b/arch/x86/kvm/mmu/page_track.c
> @@ -35,6 +35,9 @@ static bool kvm_external_write_tracking_enabled(struct kvm *kvm)
>   
>   bool kvm_page_track_write_tracking_enabled(struct kvm *kvm)
>   {
> +	if (kvm->arch.vm_type == KVM_X86_TDX_VM)
> +		return false;
> +
>   	return kvm_external_write_tracking_enabled(kvm) ||
>   	       kvm_shadow_root_allocated(kvm) || !tdp_enabled;
>   }

You should instead return an error from 
kvm_enable_external_write_tracking().

This will cause kvm_page_track_register_notifier() and therefore 
intel_vgpu_open_device() to fail.

Paolo



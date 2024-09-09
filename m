Return-Path: <linux-kernel+bounces-321681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF00971DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CE61C226A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59CF3A1AC;
	Mon,  9 Sep 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOdzRvDR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD619BB7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895313; cv=none; b=PoWqHs5eZkwS4AuraH8V+FZ3BLDnSAzRR5ySF27KN/alGGslNS9FRqSDk0R40sDKHYX6H5E9UFNPZmhN5mx9u/FQr9i7RtM/hYG+r3/hLkgoe0r7yxpCSu0w29IFV9AcpAsMyD7oV3HaylaTTJ198Eb1K9N6B9w/NSf5TGjwLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895313; c=relaxed/simple;
	bh=yJVDZXZfOWTyJlLxMnEEh1yIxf8KjO5Ya23OssuFGro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTnSqlAXF3m7+kQJ+JKSSdB46iP8h+q4VdjrYOyzKkF2XWnFzUDwrYPNnmmdby3ahkxmO6qma7WxJZexUFhe1ePQ6eCwKA0U0rm0tGqKaJtlKdQMDTjf2T/gMooHb0DvfJLqIhbyWIIi18Vy4sFWoV4ZBGlJAiYi+7SOHu0HpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOdzRvDR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725895310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L3QclMeymb6kfLxVIICQgJq1vJUPKfTORSTTm/45/q8=;
	b=iOdzRvDRpWiynrIA296NOrmVd0WzDXF5CQly8MzV7+fhgk3lZ8CecwN27p0r4TvXm3Emu3
	3IFztcgP1zbB35J6CtwHpYKJ4oCjSBhU31ALXp9pbw9Sw2EPGlYKwt82Rqz3GiWqUDgmG3
	AGSTnPrKxM69z/Nrt5HgL/Ja4/tg08s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-peGvFsbMPumSCRY_4VE_1A-1; Mon, 09 Sep 2024 11:21:49 -0400
X-MC-Unique: peGvFsbMPumSCRY_4VE_1A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42caf073db8so18431365e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 08:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895308; x=1726500108;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3QclMeymb6kfLxVIICQgJq1vJUPKfTORSTTm/45/q8=;
        b=IdTBZuUn/Y3LTh8y77+Iac4e9zVHP11L+QlH4+y7xerSPdSRG8Ge0w6o/hZVmaPtmo
         3Huwu+IvCfbXrTaLh/JLst3ksXLtS2ZAfsxDiVoGsmuRN0TK+0lkHYYpNrCg9LpivIEH
         L250zj3hLXidgqfjB2wp7OmQZIfbk06oPptPyA7butriNR+zOxy23189lQETEj2QQcbv
         VoXJFv9v5XdCwOFd8aejR8VJpMn5De6c+Gq+wfFRt6BQQcTw7b+Zm03Hag//10X/m7JM
         7X4fVEUXmvlTFq1oHsrdBdBqgSzXSSH+Uu8mdAMijVo9udaZSjqTnVb19a/p6dMZekwu
         Yv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3DwNhfCO45HHvd8trtePMGcCYorfv3fqYDxMl9cOccsje9O3JRKZKRkv+cHLlr7vyS6yrT0TFfkLBUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPL6VqxQfngbjxm1TSm4vRbCD6oRDxY9xRnIkfLNrZ4d36rmNq
	IL36a1kq0FQJpSRef5WyENi+FxuEK7v0eZCJ7gfryhOMhKWtEAT+kfkAVrEo6uIMleFjItKJ0NM
	z5p/5UfysvU85zcc4WAdSqz0Bc5cLvtnLETxO5z30wSwj8RoHRGvj2tJYfbfmig==
X-Received: by 2002:a05:600c:1d23:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42cb9052dc8mr21322425e9.16.1725895307836;
        Mon, 09 Sep 2024 08:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUaHAw6AcLPJ5Yl+KNst9aedtHjb/6uXn0IwCVt0Ckx9IoosUGwxPRkLSTG5sr8vA+XzOQjw==
X-Received: by 2002:a05:600c:1d23:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42cb9052dc8mr21322055e9.16.1725895307217;
        Mon, 09 Sep 2024 08:21:47 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3789556aa7dsm6434334f8f.0.2024.09.09.08.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 08:21:46 -0700 (PDT)
Message-ID: <00bf666e-590b-42c6-9473-9c287b940eb8@redhat.com>
Date: Mon, 9 Sep 2024 17:21:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] KVM: TDX: Set gfn_direct_bits to shared bit
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, dmatlack@google.com, isaku.yamahata@gmail.com,
 yan.y.zhao@intel.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-9-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240904030751.117579-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 05:07, Rick Edgecombe wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Make the direct root handle memslot GFNs at an alias with the TDX shared
> bit set.
> 
> For TDX shared memory, the memslot GFNs need to be mapped at an alias with
> the shared bit set. These shared mappings will be be mapped on the KVM
> MMU's "direct" root. The direct root has it's mappings shifted by
> applying "gfn_direct_bits" as a mask. The concept of "GPAW" (guest
> physical address width) determines the location of the shared bit. So set
> gfn_direct_bits based on this, to map shared memory at the proper GPA.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> TDX MMU part 2 v1:
>   - Move setting of gfn_direct_bits to separate patch (Yan)
> ---
>   arch/x86/kvm/vmx/tdx.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 8f43977ef4c6..25c24901061b 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -921,6 +921,11 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>   	kvm_tdx->attributes = td_params->attributes;
>   	kvm_tdx->xfam = td_params->xfam;
>   
> +	if (td_params->exec_controls & TDX_EXEC_CONTROL_MAX_GPAW)
> +		kvm->arch.gfn_direct_bits = gpa_to_gfn(BIT_ULL(51));
> +	else
> +		kvm->arch.gfn_direct_bits = gpa_to_gfn(BIT_ULL(47));
> +
>   out:
>   	/* kfree() accepts NULL. */
>   	kfree(init_vm);

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>



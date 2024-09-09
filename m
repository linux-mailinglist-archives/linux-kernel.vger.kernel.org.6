Return-Path: <linux-kernel+bounces-321685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D59971E01
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E683C1F23B21
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557DF4D8B0;
	Mon,  9 Sep 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPx9YxJg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507419BB7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895549; cv=none; b=mPH8MS42DMr7bneWlRlotokXhSMjEVo1K7TyR1uUjV2oCZ1YjOtP4B+JSHZchiES5NkiwZFbV4Gt3HdrKXf+6QJ+HkGf+wUCmKDoYgXCRiFIn9lU+kpaiUIXP5Dyb9GLssQ7ors00OTYm76angr0klzNkANaoBVg0duJV3Vkk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895549; c=relaxed/simple;
	bh=tlCYtKahROV3VsjOM+YPDe2BGK2AOjdvImPasKV7l64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6w2bNlnfFI1ap4gSRULBqvlpNYRGoCB+1BYQlDm5f/oaez2LvSMaUQlJloKXWaHa5NRkm1k/80uFkFir+VVpHGngUSllT0F+TxwR+FZNfdMhYTqW55N8he+QldLRl1fkOIENKnhVv1+1/N++xI0PefqZzhMjh1WSznnfYFc+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPx9YxJg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725895547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RlbvYEkgBxi2Mz8fQboxRC+ha+02P41tXE1F1YPb/Tg=;
	b=ZPx9YxJgByH5rVV+AhW7ZCTu8j8XoZEbnjgLzoqd+u9Qpwm2B0JlIXb1Qfll/SSwg7Eq6y
	iMkJ2AZMtaTE6UyXAfolMIS3OfgmQxxXVRFTsF8FVOUZKfwdFHJvY3qMq/yVb9Ki2GDc60
	UKPc1/Y+P6jmU5jkUUIHHX9ywYmmrvA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-RfX7fH2UPZaZL07lE8IcEg-1; Mon, 09 Sep 2024 11:25:46 -0400
X-MC-Unique: RfX7fH2UPZaZL07lE8IcEg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3750b4feb9fso2263019f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 08:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895544; x=1726500344;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlbvYEkgBxi2Mz8fQboxRC+ha+02P41tXE1F1YPb/Tg=;
        b=ntgTHFOKPaCGTsDGIUk4X7lBS4GFalr669IhWWs3xtvHGjInlsL7tVKX1f1Ay7f2RL
         0jMccMHtH9GvXG/S3gtqRgDnTysOxpL3KzRszt8FXwnJ/2ywi/dvI3EB90H4BMIWaB3L
         6piyRJlQmC9M2fTD+ZiBkiJLDEA7iDVbowKg6RRDPJ2awDHlw9n/Vq6E2xiif+2r5+YN
         JNyBs8ez/WZXnACc5UKK6X188vzNOdA67HJRgmupxE1piCVHrHdTAeC3kTBZMrXRumVZ
         XkRjX5bfO+d6yOYg9cHpE6ZtlaRhK/YJS8TRqDXPxeYWg8CZGbu5BMqn1aZstP9rrkyf
         21Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXOG27z64znxwzBPsdrLEi4qYNXVIyJIZmXpXUr7+0CDYq5Db5Lishzf6ML9JwhX4X1ko8ZHhur6++CqFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMuD6K4NrJDFObcYqxvp/KYl0QieZzYtTpOgjl03Gbx2Q3JlUh
	20/ZpXfgOBptNP+FDL3tymuqoTXrMFrn3gkFeWdmzyRlSvNkeRiNSwO063YSZDJBKJA6h5+QcUw
	o0TjBhOMjItgMwTs6GaJYOL9mX6dpIU8QnlEL01VkN7QZ2Tz0EIJ34Ccin0zmdg==
X-Received: by 2002:a5d:53d1:0:b0:374:b9ca:f1e8 with SMTP id ffacd0b85a97d-3779b847b95mr11413014f8f.20.1725895544616;
        Mon, 09 Sep 2024 08:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWB2MIZSAJKjE4LgStSN9koDl+B+2JL02GGOwfQWxBmFKYYFH87nVsPRla9zoA+2xpU7p78Q==
X-Received: by 2002:a5d:53d1:0:b0:374:b9ca:f1e8 with SMTP id ffacd0b85a97d-3779b847b95mr11412988f8f.20.1725895544166;
        Mon, 09 Sep 2024 08:25:44 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cb5a66475sm49806075e9.44.2024.09.09.08.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 08:25:43 -0700 (PDT)
Message-ID: <6449047b-2783-46e1-b2a9-2043d192824c@redhat.com>
Date: Mon, 9 Sep 2024 17:25:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] KVM: TDX: Retry seamcall when TDX_OPERAND_BUSY with
 operand SEPT
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, dmatlack@google.com, isaku.yamahata@gmail.com,
 yan.y.zhao@intel.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org,
 Yuan Yao <yuan.yao@intel.com>
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-10-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240904030751.117579-10-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 05:07, Rick Edgecombe wrote:
> +static inline u64 tdx_seamcall_sept(u64 op, struct tdx_module_args *in)
> +{
> +#define SEAMCALL_RETRY_MAX     16

How is the 16 determined?  Also, is the lock per-VM or global?

Thanks,

Paolo

> +	struct tdx_module_args args_in;
> +	int retry = SEAMCALL_RETRY_MAX;
> +	u64 ret;
> +
> +	do {
> +		args_in = *in;
> +		ret = seamcall_ret(op, in);
> +	} while (ret == TDX_ERROR_SEPT_BUSY && retry-- > 0);
> +
> +	*in = args_in;
> +
> +	return ret;
> +}
> +



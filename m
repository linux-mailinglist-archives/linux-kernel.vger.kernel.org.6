Return-Path: <linux-kernel+bounces-370246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66A9A29CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CFD282E12
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537171F4722;
	Thu, 17 Oct 2024 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZ2dKSlv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105211F5848
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184027; cv=none; b=m4wNlSvgwmSvf4Y/Z0AKn0GlseTFy5eBx9qByOtVd6dh59/77QWSJyYoQFdvzhAKHKV80IJoWnOJ1nkTLT+Gvf9KWxmbLN1LY6iPRSgINMSzTeaX6/90tcX1EU0T5/k870F1iCuslgCJLYH3dNE5XK1pFHtr3xEPymPzfA3rE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184027; c=relaxed/simple;
	bh=v/R81eV4s1wGmETmkamsehWGcUohD+1F/Px24lHIzr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwLXRu6n+U8pMPqNSMH2iVEo4HrKAvnnN4icc7qJ3zR9NSQAWvcuvionT3EkK6p0QFI5Y8ZgFo+Lz33+/6zKK6BM9zulED4Cb1nAf92WuDy1pPDyp/s89hQnqC+Eb0fWJjOlt1D86yWA9EM9psm1/45rjE9b06+LLzc+za+auWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZ2dKSlv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729184025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9XbYAOM0FZRDyrY920uwf/7Z7ESNlYTyEbyjudrIOjc=;
	b=eZ2dKSlvx1kEVlrNuqfprPhhr0NadAeIrJQaNSj8XbPE03V17IyUdxdSTgjAuzXDdvoq1g
	ageQX3kOVlBfAcrPHJ/qDqCMy4iz322uHdWqh7FbvM/NuwmHBw84O4iUPv4zgJoR5WugFU
	54yUIilUy9QtDv+0U/zn58b+9S2JnHA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Jzn5-iiCP2KK6pzARcqACg-1; Thu, 17 Oct 2024 12:53:43 -0400
X-MC-Unique: Jzn5-iiCP2KK6pzARcqACg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d462b64e3so420491f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184022; x=1729788822;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XbYAOM0FZRDyrY920uwf/7Z7ESNlYTyEbyjudrIOjc=;
        b=gpnN8aYgCiPWoQKAGxWlhRNx9Nnt0OSs+0QBZup5Z5o3q8drwryfGR1gD6USEEqRxY
         mPiHaXHTmu2/IKTVec/14x7F4UsPBZ8nF9f0JDEtxoXG3xxODE1k6+WGmzpBzTXImEUq
         4AvjbiMBv35i/wyK1rjT4povnyLzTL7FpsHBDcbBYnpAgEaO/ZxGOl48sMsObsy0TDFy
         LwEf8Ny8iaRGm4j0Hw+yjs2WQ7vxMglfUt9VSzn0gBYBW+YLNtzsk1LLwoCkgT0HSUfc
         9DvL3pVL71EHMVyJm8yUkF6XPJQT1PF+WuT7g/QvxOB0OSBNJaF2n7vnNTXpTUqxvEYU
         /vCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY4V/eeg2zmcHlgs8zkd12X2dZkYubqr4QAWJAZFlQohKII6u9vOpKYqNuupNRKMOveVq6Q6wDr2kMvuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWa/IVYCxGzc0N4sAVk/hPIxBTMHw0MeJ8naw1xQGRRWgzwfTM
	1lYVAJopJmG5W1q4FhdVr6khGrltp4h+v3wr2s9Cf2WmcWQL3aEoC2PiG8xSVK+0uX/wZzmRR2a
	ICQqW2m7oQDUyPeOR8Gsnlv6N8AINDrnSw39KC9VcrNdiP5hUofv4f7AM2vEBIA==
X-Received: by 2002:a5d:457b:0:b0:37d:38b4:b2d9 with SMTP id ffacd0b85a97d-37d5feae565mr13650641f8f.20.1729184021822;
        Thu, 17 Oct 2024 09:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4UCFWdwJ5xt3EKlDxp1lCWMBL+3nFkQaULzW/yCUcZKYHZlMqQuXMDMCThd69h5Kaw5P0Lw==
X-Received: by 2002:a5d:457b:0:b0:37d:38b4:b2d9 with SMTP id ffacd0b85a97d-37d5feae565mr13650624f8f.20.1729184021378;
        Thu, 17 Oct 2024 09:53:41 -0700 (PDT)
Received: from [192.168.10.28] ([151.95.144.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d7fa87c27sm7771464f8f.39.2024.10.17.09.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 09:53:40 -0700 (PDT)
Message-ID: <33db440c-40f1-4203-850c-c43e05758335@redhat.com>
Date: Thu, 17 Oct 2024 18:53:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] KVM: x86/mmu: Dedup logic for detecting TLB flushes
 on leaf SPTE changes
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>
References: <20241011021051.1557902-1-seanjc@google.com>
 <20241011021051.1557902-16-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241011021051.1557902-16-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 04:10, Sean Christopherson wrote:
> +static inline bool is_tlb_flush_required_for_leaf_spte(u64 old_spte,
> +						       u64 new_spte)
> +{
> +	return is_mmu_writable_spte(old_spte) && !is_mmu_writable_spte(new_spte);
> +}

Shorter name? leaf_spte_change_needs_tlb_flush?

Paolo



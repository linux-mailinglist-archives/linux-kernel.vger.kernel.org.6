Return-Path: <linux-kernel+bounces-246681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E192C528
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121EC1C21ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D54A185635;
	Tue,  9 Jul 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml6QHzGu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0645182A6E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559380; cv=none; b=hu8mmLtr6mP588G3rIhM9GcpwlsI4LzXLVlHQm2/vzr+2q/y/hy8QJ1nEJJh2y23/WOHmGUcwS45WUd25rzpn02K2E/mjjA3/Jgu7nJyD4ymDQsvwKypM7BnNqQ49H/wWw9GQEiUTMOFOnmIAeW/ADXC9RBSCVlUuKG+Q9JfGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559380; c=relaxed/simple;
	bh=G4sqLN36Av0Aipun0m/BkomGGwch1eUTwiy2tZMAgLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdjVr8eHeJkx67qn0lF0t5Jvrk2IvCJSSsAa20YAkCBV9AFxHw+46PpF/aFBBTqzcbVljGUiVIfNRt3tHTvapRTN//aY27SmbO4b2VDiyk06HRi4f99YkzwWariQr/P/Z9LoSK7zW9ZAiHbJzk2y71GbK0J7z/bjW6e7CtPO5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ml6QHzGu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720559377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=odS83l0DT88K5KKMun5tLUrS9pX9A9r4YSGjmmOE4KY=;
	b=Ml6QHzGuYkQGT6EXdwgsVzsvMsi0neyJft2+507DEfbM58jwsq+AlfP2haMk8xV5eJKP7L
	VGKE43JOg1w0QACEWn3Hg4/9e1JZZpLYCSQxH6Any5G9hMyLSUVZMC3f0TZ58IeXUdKdBe
	q6+gicAr0AQAwf33mPVbek0BItfqrrA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-gLnehZuyNeaVsxHaOTqa0A-1; Tue, 09 Jul 2024 17:09:36 -0400
X-MC-Unique: gLnehZuyNeaVsxHaOTqa0A-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7623e193d89so4233665a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559375; x=1721164175;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=odS83l0DT88K5KKMun5tLUrS9pX9A9r4YSGjmmOE4KY=;
        b=WpnsPumfW4F0QVvRodSCa89XIdPj7bOLeALzf03dLKMimO187HFsSOlEjn2EW7cM1m
         Oy0hCGAD+DVsmWtAWHagLW3aRLuOR6jRuhE8TeNhJDetMNnyok8f0h0LYXJEHdZAjD8O
         kj6855QNGIHfNCbgcpuR2RmFgkYGqfw+NsSB5wszROvGLnBgEO9AF2HU2uG+VJHdflEG
         c3i0xQpGy2qV280132X5ZDFPvWKCY9KKl2joRiReaZOPOLO0s0Mg9/UN/Pb4vQx0xw1x
         FvLXGZ+mfQRb2M6DnJ9HCpUldY/NVdU5CYOZ2ebJZdHqQ9Jmp14Rl3mN+g5XKMjGcBmx
         CUyw==
X-Forwarded-Encrypted: i=1; AJvYcCU4PrYyYPMM/euX5OVYAwKLHRmwqu8tymZEJrsTtM/ZXQKhuLgkQ9dNIOpmPENnNi/n++fip47wHvwgoBbz6T/EIvmhajYHFRw308PC
X-Gm-Message-State: AOJu0YzQgVuiL3NQCtx++HuJeOl3E27bBWXQvp0C0kNGZtQkDfW2reob
	a/twJvAZlhdTZUqAnR2VxbNXEXMCP3k47WI/YBpW6+jiUVUJB8ZB8lB0iqWb6NufEor2RAFjbfg
	QEt/5G7jBfzd+EDqaBHglH1IIL+F4woCb0A+wkawNQZU40s0iZBNyTPLxnyXHZA==
X-Received: by 2002:a05:6a20:a111:b0:1c0:e925:f3e1 with SMTP id adf61e73a8af0-1c2984c9de7mr4305585637.50.1720559375111;
        Tue, 09 Jul 2024 14:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUIpwg0q5tX/615i6NZ/zZJubSifIfLGh41ui/wVdDDxeaKO6CBzN2Bumt/d0xd4q/gI7xDw==
X-Received: by 2002:a05:6a20:a111:b0:1c0:e925:f3e1 with SMTP id adf61e73a8af0-1c2984c9de7mr4305537637.50.1720559374128;
        Tue, 09 Jul 2024 14:09:34 -0700 (PDT)
Received: from [172.31.79.51] ([216.9.110.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c70a4sm2290324b3a.83.2024.07.09.14.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 14:09:33 -0700 (PDT)
Message-ID: <0dc45181-de7e-4d97-9178-573c6f683f55@redhat.com>
Date: Tue, 9 Jul 2024 23:09:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] mm: secretmem: use AS_INACCESSIBLE to prohibit
 GUP
To: Patrick Roy <roypat@amazon.co.uk>, seanjc@google.com,
 pbonzini@redhat.com, akpm@linux-foundation.org, dwmw@amazon.co.uk,
 rppt@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 willy@infradead.org, graf@amazon.com, derekmn@amazon.com,
 kalyazin@amazon.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, dmatlack@google.com, tabba@google.com,
 chao.p.peng@linux.intel.com, xmarcalx@amazon.co.uk
References: <20240709132041.3625501-1-roypat@amazon.co.uk>
 <20240709132041.3625501-8-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240709132041.3625501-8-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.07.24 15:20, Patrick Roy wrote:
> Inside of vma_is_secretmem and secretmem_mapping, instead of checking
> whether a vm_area_struct/address_space has the secretmem ops structure
> attached to it, check whether the address_space has the AS_INACCESSIBLE
> bit set. Then set the AS_INACCESSIBLE flag for secretmem's
> address_space.
> 
> This means that get_user_pages and friends are disables for all
> adress_spaces that set AS_INACCESIBLE. The AS_INACCESSIBLE flag was
> introduced in commit c72ceafbd12c ("mm: Introduce AS_INACCESSIBLE for
> encrypted/confidential memory") specifically for guest_memfd to indicate
> that no reads and writes should ever be done to guest_memfd
> address_spaces. Disallowing gup seems like a reasonable semantic
> extension, and means that potential future mmaps of guest_memfd cannot
> be GUP'd.
> 
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---
>   include/linux/secretmem.h | 13 +++++++++++--
>   mm/secretmem.c            |  6 +-----
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index e918f96881f5..886c8f7eb63e 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -8,10 +8,19 @@ extern const struct address_space_operations secretmem_aops;
>   
>   static inline bool secretmem_mapping(struct address_space *mapping)
>   {
> -	return mapping->a_ops == &secretmem_aops;
> +	return mapping->flags & AS_INACCESSIBLE;
> +}
> +
> +static inline bool vma_is_secretmem(struct vm_area_struct *vma)
> +{
> +	struct file *file = vma->vm_file;
> +
> +	if (!file)
> +		return false;
> +
> +	return secretmem_mapping(file->f_inode->i_mapping);
>   }

That sounds wrong. You should leave *secretmem alone and instead have 
something like inaccessible_mapping that is used where appropriate.

vma_is_secretmem() should not suddenly succeed on something that is not 
mm/secretmem.c

-- 
Cheers,

David / dhildenb



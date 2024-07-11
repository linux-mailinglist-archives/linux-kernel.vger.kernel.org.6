Return-Path: <linux-kernel+bounces-249752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C7092EF51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652311F219F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF716EB63;
	Thu, 11 Jul 2024 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObawRis2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025015F40D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724885; cv=none; b=jlZd8VdKi14R7LGIF045MZgrPSE/Vh1wnGi6GfQ2yujv8sZVNEvE5YWziTcyZ2jmr7jg5ncjyvpuxHs6pg5K1+p8dETphuAeu0IR5YpiQ1RRxzunCAewhgCU8IEmi+PGHsmtU5El1X+hqL9GwALtynmynca62V3RWnTMRafAnTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724885; c=relaxed/simple;
	bh=6kogFYB4OR6TKsjTDplZW+tTdaQ1xknBPxEFwwPmg10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUxSLzzLtsn+pY+JOwsB77ucFsKb5htRHxNUCcfa/Lkcg1QPgfxDGNn5dGE220jvIlX+i4uNGeS9xTy+Rs3Tji8GCBZ72tnYm0zGda+NZ3uBHYPmfhQ1/GU4I1OMOniVf0GfW8xqAzWiw9YLqB26duhq1N+UyT4xd2JD+P8Z8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObawRis2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720724883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gN118Bf0dMZbC4SSR++jWEtpRjXul+fiQ4mzACL/3FA=;
	b=ObawRis2vBF78jXezbOA56QmKFIqowiR8wX3PW7yQtdE2DGBLaAsics7x/E5XIJg/FOMEN
	tAAHC2hFBHfLaNmV5j2Q7cUpGrxwV5eEMmHw7KaYJ10X9GanNB1CRsrfJkYtv+ceEUSpCy
	fimS70wM46WgNvQl4BGHszK3cBucfko=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-AtDnKLViNw-aeTkK8XStyg-1; Thu, 11 Jul 2024 15:08:01 -0400
X-MC-Unique: AtDnKLViNw-aeTkK8XStyg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70b0bb79c49so1228245b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720724880; x=1721329680;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gN118Bf0dMZbC4SSR++jWEtpRjXul+fiQ4mzACL/3FA=;
        b=lxb9jUxY3l0NtDo7mppJxhtaQeQYs2Xy4qJgZ0VpwvGQlfyEpE4idmFNkmXt/Ln3to
         Qr4pJmspTRHZ94bJX8eYECf11wA6y48KSMjJrE5zR4PODcvXSC7uStdv5TZJTf+nS2i2
         6oUBi5poB7+0zigns1Pc6oocSBYUglt5Sn7PZDApKfixkg3+sNhZpkEwFDErC52sTaho
         ZQiz3x09U8voAG/G+INNH+TOHcfIj7ARYsvXj7yWtfYZ7ZbQwRyt0ifJfsniS8JaUDLp
         7qfgOLm5useN72NrmbWXehJxm9C97tZrwTjzyNkmYWOnO4M4N0IM/whZJGmeB6abMrNY
         upJQ==
X-Gm-Message-State: AOJu0YzkLt5DecK/tmEr8jm9Lo1b9EPlyjrYr3jTP+r7Ty/r4da5mAye
	IRNauBpn5qQLw1d5koTdXx9y1h3VL1rDPWovtf8HO3vTfyAsl0GTeXp9nzdeiH8v98V3pWJ2TDN
	vsi4/GzAV00vubjS20VRf3S6AGAeqzT5WiYcNJkt0Rtze0+14mIWqAZq5JXgSLg==
X-Received: by 2002:a05:6a00:1c9a:b0:70a:ffc2:ab with SMTP id d2e1a72fcca58-70b4364ff01mr9404100b3a.26.1720724880281;
        Thu, 11 Jul 2024 12:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHjeNGhXBJQW4LrMH9bg1VvNK4tctYuPaCd5OYA1ndZsyAlmuQ3OEsDQ9sB1zzDupJjW1PUQ==
X-Received: by 2002:a05:6a00:1c9a:b0:70a:ffc2:ab with SMTP id d2e1a72fcca58-70b4364ff01mr9404072b3a.26.1720724879837;
        Thu, 11 Jul 2024 12:07:59 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4398002bsm6224007b3a.148.2024.07.11.12.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:07:59 -0700 (PDT)
Message-ID: <37da7835-0d76-463e-b074-455e405b138b@redhat.com>
Date: Thu, 11 Jul 2024 21:07:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
 x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com> <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com>
 <CAHk-=whGE_w46zVk=7S0zOcWv4Dp3EYtuJtzU92ab3pSnnmpHw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHk-=whGE_w46zVk=7S0zOcWv4Dp3EYtuJtzU92ab3pSnnmpHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 19:57, Linus Torvalds wrote:
> On Thu, 11 Jul 2024 at 10:09, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> When I was working on this patchset this year with the syscall, this is
>> similar somewhat to the initial approach I was taking with setting up a
>> special mapping. It turned into kind of a mess and I couldn't get it
>> working. There's a lot of functionality built around anonymous pages
>> that would need to be duplicated (I think?).
> 
> Yeah, I was kind of assuming that. You'd need to handle VM_DROPPABLE
> in the fault path specially, the way we currently split up based on
> vma_is_anonymous(), eg
> 
>          if (vma_is_anonymous(vmf->vma))
>                  return do_anonymous_page(vmf);
>          else
>                  return do_fault(vmf);
> 
> in do_pte_missing() etc.
> 
> I don't actually think it would be too hard, but it's a more
> "conceptual" change, and it's probably not worth it.
> 
>> Alright, an hour later of fiddling, and it doesn't actually work (yet?)
>> -- the selftest fails. A diff follows below.
> 
> May I suggest a slightly different approach: do what we did for "pte_mkwrite()".
> 
> It needed the vma too, for not too dissimilar reasons: special dirty
> bit handling for the shadow stack. See
> 
>    bb3aadf7d446 ("x86/mm: Start actually marking _PAGE_SAVED_DIRTY")
>    b497e52ddb2a ("x86/mm: Teach pte_mkwrite() about stack memory")
> 
> and now we have "pte_mkwrite_novma()" with the old semantics for the
> legacy cases that didn't get converted - whether it's because the
> architecture doesn't have the issue, or because it's a kernel pte.
> 
> And the conversion was actually quite pain-free, because we have
> 
>    #ifndef pte_mkwrite
>    static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
>    {
>          return pte_mkwrite_novma(pte);
>    }
>    #endif
> 
> so all any architecture that didn't want this needed to do was to
> rename their pte_mkwrite() to pte_mkwrite_novma() and they were done.
> In fact, that was done first as basically semantically no-op patches:
> 
>     2f0584f3f4bd ("mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()")
>     6ecc21bb432d ("mm: Move pte/pmd_mkwrite() callers with no VMA to _novma()")
>     161e393c0f63 ("mm: Make pte_mkwrite() take a VMA")
> 
> which made this all very pain-free (and was largely a sed script, I think).
> 
>> -                   !pte_dirty(pte) && !PageDirty(page))
>> +                   !pte_dirty(pte) && !PageDirty(page) &&
>> +                   !(vma->vm_flags & VM_DROPPABLE))
> 
> So instead of this kind of thing, we'd have
> 
>> -                   !pte_dirty(pte) && !PageDirty(page))
>> +                   !pte_dirty(pte, vma) && !PageDirty(page) &&
> 
> and the advantage here is that you can't miss anybody by mistake. The
> compiler will be very unhappy if you don't pass in the vma, and then
> any places that would be converted to "pte_dirty_novma()"
> 
> We don't actually have all that many users of pte_dirty(), so it
> doesn't look too nasty. And if we make the pte_dirty() semantics
> depend on the vma, I really think we should do it the same way we did
> pte_mkwrite().

We also have these folio_mark_dirty() calls, for example in 
unpin_user_pages_dirty_lock(). Hm ... so preventing the folio from 
getting dirtied is likely shaky.

I guess we need a way to just reliably identify these folios :/.

-- 
Cheers,

David / dhildenb



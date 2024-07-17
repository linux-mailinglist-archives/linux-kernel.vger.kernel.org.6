Return-Path: <linux-kernel+bounces-255219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0B933D96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3984B225D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081F61802D3;
	Wed, 17 Jul 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cui45AeF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162717E8FA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222900; cv=none; b=uDIQNIEDFeiH86iI1fAeHWr2vQKODAa8rwSMM2qsq2jhRj77dkzn869a8/2j5XbDFKlg5tXvjhw8TLE43LkrEa7ndw57j9DggyygVw/MvZEjGicaLiCCqYXgcdtRtg9YyrQBj1u/+KbBkk1fiVnAEuDjKBI/iAPufWXnO+1hxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222900; c=relaxed/simple;
	bh=i5fDdDHEtX7vNR12mFEKIETqZ0WT4Yxwoz5sgAv+nGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eeTdP8HLoKCZgqYB5tCNs3EDVkGUdi3Kry7Fny5OrhGHYkCPW2qQb9mM/TZRU0VeOKsW93RGe315ypIflCZgHnK44hc4e6LLMDtq7mOkCgXUR68aRO0Dc/YkdjWOF8CxVYyeQFTA7rf1XEm3cip5HABMusXHH1lTHz4Doh5/UY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cui45AeF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721222897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItohwBK9euwv/uwdzmdFu/crsWLVAK5HqaVyEtkiNe8=;
	b=cui45AeFvzHQNIrk260iF93DDatA6Ax7gapUNnkX/o40nxw+nqzVTMBKaWhFHGZ7jP2TZx
	FIweR5vNSn0CyphuVha5xIZGoNdpwNdhAT4X02Bz0f4KV85WT09b7q5WpyFzFaPwYjGgcQ
	7DRQm5/ArFBiWZh38ZPklxIRQVU4pbM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-3H0p8EQ0OiW3ZEnmTkaTgA-1; Wed, 17 Jul 2024 09:28:13 -0400
X-MC-Unique: 3H0p8EQ0OiW3ZEnmTkaTgA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36795e2ce86so3897572f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721222892; x=1721827692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItohwBK9euwv/uwdzmdFu/crsWLVAK5HqaVyEtkiNe8=;
        b=EUJh9HXrRdWMQlDFAQkSIvN9Nixi40JzZ4+bsw9IOBZxSqxqePembn+DN/w0b2Fh28
         hRVHbt0DDWxPxupw4Yz3jrP8VbX0ZDf6D/84cGqRBuU8NczU1vfynIq3F/Jli4BH3U18
         gnToh1oK1WxNSB6b1KHSpev/cpfcYaqeWMEhf+Qp5XCujTeMsIEAApmcEt84u+Qfkbg8
         HNK9jYFf8fPEAr2IFomMHlXfaCl+6xg18jRBAH5TfyxiY/NlXo334A9SYCYs62jPhDck
         m7VguFXdgNcrGP7/sCmpHGBqTf9w+B7puhg02vOfsKPtVrghHaUyC1J78tfczYBr9vej
         Vnnw==
X-Forwarded-Encrypted: i=1; AJvYcCWBIK1oqqWastOIcKz01y6hfMinj112I73072rchwZt0OCAZ47p6nIFNAZ0M0D2rDnU3YJMa4BJ//j9yDV9rMK4HFdj39pEEvuN9XOn
X-Gm-Message-State: AOJu0Yzui+QyF+rPmQNP1OAOh7UJTSsptycPJ/NCqP8Wc+W3osKck/J7
	6xbbYza6FdYx/8mtZwjdukqbdGg+8ar/1cjsl3QPi6rre8/Gb/r5f5ozcGY2m+omhcn+SqlDQOj
	GniCqv+7buXcXIjieKYd3KAyQxRQI8eLkElvgDMwxs8ZXH6Ywm6W2oOunBP6k2w==
X-Received: by 2002:a05:6000:d90:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36831948efamr1354439f8f.7.1721222892505;
        Wed, 17 Jul 2024 06:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpTaAUfRVNU5Xu+qR1JE/9Bc1YiuNYvppU3YdvKcMCaYdPaRWowG53BU48+Swh1yPrb+brsQ==
X-Received: by 2002:a05:6000:d90:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36831948efamr1354427f8f.7.1721222892139;
        Wed, 17 Jul 2024 06:28:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db04731sm11642192f8f.112.2024.07.17.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:28:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 42675145D491; Wed, 17 Jul 2024 15:28:11 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Michal Switala
 <michal.switala@infogain.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, revest@google.com,
 syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com,
 alexei.starovoitov@gmail.com
Subject: Re: [PATCH] bpf: Ensure BPF programs testing skb context
 initialization
In-Reply-To: <250854fc-ce22-4866-95f9-d61f6653af64@linux.dev>
References: <CAADnVQJPzya3VkAajv02yMEnQLWtXKsHuzjZ1vQ6R19N_BZkTQ@mail.gmail.com>
 <20240715181339.2489649-1-michal.switala@infogain.com>
 <250854fc-ce22-4866-95f9-d61f6653af64@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Jul 2024 15:28:11 +0200
Message-ID: <87y160407o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 7/15/24 11:13 AM, Michal Switala wrote:
>
>  >> Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
>  >> Closes: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
>  >> Link: https://lore.kernel.org/all/000000000000b95d41061cbf302a@google.com/
>  >
>  > Something doesn't add up.
>  > This syzbot report is about:
>  >
>  > dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
>  > __xdp_do_redirect_frame net/core/filter.c:4397 [inline]
>  > bpf_prog_test_run_xdp
>  >
>  > why you're fixing bpf_prog_test_run_skb ?
>
>
> [ Please keep the relevant email context in the reply ]
>
>
>> The reproducer calls the methods bpf_prog_test_run_xdp and
>> bpf_prog_test_run_skb. Both lead to the invocation of dev_map_enqueue, in the
>
> The syzbot report is triggering from the bpf_prog_test_run_xdp. I agree with 
> Alexei that fixing the bpf_prog_test_run_skb does not make sense. At least I 
> don't see how dev_map_enqueue can be used from bpf_prog_test_run_skb.

Me neither.

> It looks very similar to 
> https://lore.kernel.org/bpf/000000000000f6531b061494e696@google.com/. It has 
> been fixed in commit 5bcf0dcbf906 ("xdp: use flags field to disambiguate 
> broadcast redirect")
>
> I tried the C repro. I can reproduce in the bpf tree also which should have the 
> fix. I cannot reproduce in the bpf-next though.
>
> Cc Toke who knows more details here.

Hmm, yeah, it does look kinda similar. Do you mean that the C repro from
this new report triggers the crash for you on the current -bpf tree?

-Toke



Return-Path: <linux-kernel+bounces-289593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 242D79547E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF4B1F228C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B84D19DF42;
	Fri, 16 Aug 2024 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2dXlMio"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16B8472
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807190; cv=none; b=u69XR9yVZ+4LftrZ40pi8wdxYEg4WRiP1Sj06m2m1aX3KdOmG2DkktAZu/Vl+nuKiYUilp5JLuT/8NtoDsRNDwItYZPTriLPryte4jL+0xEkQM/HFGk94SmV6RxCfMxX4K4GnOeKjMC9969IAxqy4tbW+ErvmejOpznBF489QNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807190; c=relaxed/simple;
	bh=0YEKbCgqjCKTnqIvucJPhNpFU/zKUOwOBiiXIpasgTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWcqV2aixi7ZijsxM1TAoOGZemGS8eMgjihwyrfGeN0UjIvKRCta+kVwNkjOvZQvjb5f74WlW6p+HCqTOiA/qG3c/BqjS5qlbHbdpfE5i52SLpSTpJEO8ZUL3YOGzmhP925/q3VjLGQmcBzHBtbmWazCP1+7GenzamTA+UU/g8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2dXlMio; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3719f0758c6so33750f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723807187; x=1724411987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rZ/Girz08IZmHtZsrVU+idIVHnjPppCsG5oXI3Hdtsc=;
        b=s2dXlMioN1qbV4CEl5gw2hyxbqedO1CTzQTK/YbtSZXVwjP7eDi2YFlS6KGltDTekd
         SZNLndwRF9Mcw3f0e9ITiALoMsA8haeQhxxHdmf6zFjtXhlz8kmA7L/j8BtcF8Vz8OUe
         vzLqyvE45hG+2Wt8L1rkzTzFzAFyjAh6k/RMO87AGHRsnTf7oeD5V2Z65z2/LloblcHq
         +SdPxtfr41P6+A//WreI682gTlWGyAs96Pl8OLMtIbk/dLqDDiC/m9iXI7Nen5i+uOLn
         p/CBfSE3wyyeqPUZqsJUCa+yT7QEJY5mrNdKNEDbzvQhiMD0SatoSFVQZFr7UXF2sMGC
         Sh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723807187; x=1724411987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZ/Girz08IZmHtZsrVU+idIVHnjPppCsG5oXI3Hdtsc=;
        b=Vo6RPpg+oWY5y5NrS/NscUO7Fo3ZWt2f9LUSWJXacSZMor7uUPOim+eePeza/bO4jC
         LqGZ6f3graK5cAn150fe8Gaegpw9eDGISI4xnPrqPU2Fv37nCoP2KeiEcShKKArn8iNM
         Kplf0IcSmPCNxJ1hqzfDZD0o+3QbOq2+P4Lp8Cf6GLkapLfAMSDwoGZGN7VMv9wXSObz
         avDujuESbk9/37KRxk3bGNPGXFPMgnXidLql7thnR7pAwagafe7tjYZgsKRfWrBRtKo6
         42G53APEHeP7m1ujD/4nyou00ehiIdxVZaznRPlCE/Vk09fx+uRN24YIIXd6G1rd3nG6
         Hm2A==
X-Forwarded-Encrypted: i=1; AJvYcCVLZkmJEyxlvkb6T5I2BCpHgAQNBfS1323cB+QF1ubju6MyfVD/JITrNNoWWQDlOdXeviqFcae+AALNR5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7lwwYWKasiWtSnKqygWSJ/IeVNBhZRZtPF62U4H1uphIQBhmq
	vab2M6iMg92DBJ0HtD8GD/fb6BBv2ntv4iq70jNwQ7SyG9tctLLiP5vZ2ainsp2adLdHSeIPG5Q
	2JsjUiSjsvgD36gBVoIucfR7UNAZu03ccXcvq
X-Google-Smtp-Source: AGHT+IFjh0jaZHz+bXJLGOwDlxY14HFpbgg6MC9AUdExHwCz1VC6lyjw8E/zebexbyTLHtHDRbeRFor8g+UdLx/zwRY=
X-Received: by 2002:adf:e388:0:b0:368:4e28:47f7 with SMTP id
 ffacd0b85a97d-37194314f7emr1429125f8f.6.1723807186811; Fri, 16 Aug 2024
 04:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-guest-memfd-lib-v1-0-e5a29a4ff5d7@quicinc.com>
 <20240805-guest-memfd-lib-v1-4-e5a29a4ff5d7@quicinc.com> <4cdd93ba-9019-4c12-a0e6-07b430980278@redhat.com>
 <CA+EHjTxNNinn7EzV_o1X1d0kwhEwrbj_O7H8WgDtEy2CwURZFQ@mail.gmail.com> <aa3b5be8-2c8a-4fe8-8676-a40a9886c715@redhat.com>
In-Reply-To: <aa3b5be8-2c8a-4fe8-8676-a40a9886c715@redhat.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 16 Aug 2024 12:19:09 +0100
Message-ID: <CA+EHjTz6g_0P+t3wzV99hBtf9rd2Lvn-vwYb2oKZaXxSLs5BzQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] mm: guest_memfd: Add ability for mmap'ing pages
To: David Hildenbrand <david@redhat.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Patrick Roy <roypat@amazon.co.uk>, qperret@google.com, 
	Ackerley Tng <ackerleytng@google.com>, linux-coco@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 10:48, David Hildenbrand <david@redhat.com> wrote:
>
> On 15.08.24 09:24, Fuad Tabba wrote:
> > Hi David,
>
> Hi!
>
> >
> > On Tue, 6 Aug 2024 at 14:51, David Hildenbrand <david@redhat.com> wrote:
> >>
> >>>
> >>> -     if (gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP) {
> >>> +     if (!ops->accessible && (gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)) {
> >>>                r = guest_memfd_folio_private(folio);
> >>>                if (r)
> >>>                        goto out_err;
> >>> @@ -107,6 +109,82 @@ struct folio *guest_memfd_grab_folio(struct file *file, pgoff_t index, u32 flags
> >>>    }
> >>>    EXPORT_SYMBOL_GPL(guest_memfd_grab_folio);
> >>>
> >>> +int guest_memfd_make_inaccessible(struct file *file, struct folio *folio)
> >>> +{
> >>> +     unsigned long gmem_flags = (unsigned long)file->private_data;
> >>> +     unsigned long i;
> >>> +     int r;
> >>> +
> >>> +     unmap_mapping_folio(folio);
> >>> +
> >>> +     /**
> >>> +      * We can't use the refcount. It might be elevated due to
> >>> +      * guest/vcpu trying to access same folio as another vcpu
> >>> +      * or because userspace is trying to access folio for same reason
> >>
> >> As discussed, that's insufficient. We really have to drive the refcount
> >> to 1 -- the single reference we expect.
> >>
> >> What is the exact problem you are running into here? Who can just grab a
> >> reference and maybe do nasty things with it?
> >
> > I was wondering, why do we need to check the refcount? Isn't it enough
> > to check for page_mapped() || page_maybe_dma_pinned(), while holding
> > the folio lock?
>
> (folio_mapped() + folio_maybe_dma_pinned())
>
> Not everything goes trough FOLL_PIN. vmsplice() is an example, or just
> some very simple read/write through /proc/pid/mem. Further, some
> O_DIRECT implementations still don't use FOLL_PIN.
>
> So if you see an additional folio reference, as soon as you mapped that
> thing to user space, you have to assume that it could be someone
> reading/writing that memory in possibly sane context. (vmsplice() should
> be using FOLL_PIN|FOLL_LONGTERM, but that's a longer discussion)
>
> (noting that also folio_maybe_dma_pinned() can have false positives in
> some cases due to speculative references or *many* references).

Thanks for the clarification!
/fuad

> --
> Cheers,
>
> David / dhildenb
>


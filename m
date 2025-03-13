Return-Path: <linux-kernel+bounces-560186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC486A5FF14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5F019C4E08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1011EB180;
	Thu, 13 Mar 2025 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8czMGKj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FC19E83E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889893; cv=none; b=Q8BXdBL8GMrRwFv6V8ni7COrBH/4CPgtvXv2XiusCXitoPSXAWHCbCxcmT7KHd4e63ZBROPVOHB/yzsx3GqpQ7R7FLQmGCyYIzsT/E09KeZl+wmwxDScgxvPaL8GREKisK6XJVNe1TbE+TF6iqBsRsLLF+zeM22gMd52zvVHsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889893; c=relaxed/simple;
	bh=YDK1UnGTu5tKXMAT6GFEDBy3mzaOn2JOJ7gYdpgf/eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M95pssDOscAL9Noojm1fhaW8pyCJnmQb09CCV11pZBFgvTiJDc7RAVk5bjrqMHyvjFLsQx2v1AbAfcANaj5ynxV6VUX8nWUi2zIuIzVN9FJTuqZ8sHEiRJ3D5skUOPgqnRJJXwV37ORQzGoJwG/3o5dVMhkAoFLDvNDsW+UsRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8czMGKj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741889890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdQ16etKuay8/M8ZeflAa/ny4zk3TfOP1l0ObABhMrk=;
	b=a8czMGKjyUHbvEANTlWyN/2++MU7zhSfZSm7DxMUvYr4/9nD5ePIXzC5zEXoBsZib99IGx
	K+i9y3cmwiy/8xtgODs8bMkZCGVSd97ooHfetOs7CdLomeYmtaSk5ScQdUBsTROPdHjfoN
	PFAsM8g33dy+Jku1HuOF5b9yzD0WQuM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-xr6L0KCNNmioR_8zAbLN5g-1; Thu, 13 Mar 2025 14:18:09 -0400
X-MC-Unique: xr6L0KCNNmioR_8zAbLN5g-1
X-Mimecast-MFC-AGG-ID: xr6L0KCNNmioR_8zAbLN5g_1741889888
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391345e3aa3so751273f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889888; x=1742494688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdQ16etKuay8/M8ZeflAa/ny4zk3TfOP1l0ObABhMrk=;
        b=Te8hPWkznLlWcEXNJlhq+1VwXKvHj3XQziRsJn2scJ+ckUP8bHe/eRLnbYLswiRSbM
         ++TazzKvfefFzfNb4s/m7RJbOyGNemDNoY42O3aTLT8mr59oB8nX3ZCahsP2wWYCT5T3
         hdtjSl3lTDIw39pRl3ni6tjvRtCXoN8l9aM2z3YWCPq+CZAo9EtVBk2+Zf5/OpsAHST2
         1JiyK/ObfEbTqzfdBa5wQcnG1KOeK5rWSzbJOQcK1OQtrK/niUl+wIdTq/q5gho3Gtaz
         JUAHlmmOZLFUmzzMzwBmBfr4knAKcprw+yi/IrllW2ra+vFz0Exy91EpKdXxTEs8x+8+
         w6YA==
X-Gm-Message-State: AOJu0YxY4GUs8rZMY/mxQIUOtEGKG2XsTWqmbsQ+t3LCid/ch4oZZT7Z
	MY9ASoEp7S1Re8uX6mstAG7aom7YOBHS6RJQHt9Vs0C+CTdIDvHEkOlpR5wboo62uzsOLnoE+2t
	sOfqJibzCoNcXsNQ2rooli5yveGxQQMohVshKjcj6z3r/daNxj6A9hUvaLSHo6fVfd254XC3hy1
	QIpIKo0OObj0YFyphNRv2mUnGUaiYokrEavAYb
X-Gm-Gg: ASbGncuJDGnXhvVf+sR4zIaOPnu9+mXGfwAJvIDxPrLompXTsrkznbCneOrApYNmFme
	sFroPiIvU4nmCcKrGMAFCkewC8CU4m9TXoAi7Wk90uuWajtP+j1GwO2iJgctcnQJwpJHBZQNp
X-Received: by 2002:a5d:6dac:0:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-392641bd284mr13164380f8f.14.1741889887912;
        Thu, 13 Mar 2025 11:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn9uBT3IvkVOhIdiFhj/VXarkQD69iABYBq66Zxni+59eGj+sxJz3YR9nw6jw3mk1ZsbIyl2zzBh8ze+xcYvU=
X-Received: by 2002:a5d:6dac:0:b0:38d:d0ca:fbad with SMTP id
 ffacd0b85a97d-392641bd284mr13164362f8f.14.1741889887561; Thu, 13 Mar 2025
 11:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307212053.2948340-1-pbonzini@redhat.com> <20250307212053.2948340-6-pbonzini@redhat.com>
 <405c30e9-73be-4812-86dc-6791b08ba43c@intel.com> <CABgObfZOhNtk0DKq+nB2UC+FFhsEkyiysngZoovoJP-vF43bYA@mail.gmail.com>
 <91208627-74a6-4d19-9eef-cc8da7b0a4dc@intel.com>
In-Reply-To: <91208627-74a6-4d19-9eef-cc8da7b0a4dc@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Mar 2025 19:17:53 +0100
X-Gm-Features: AQ5f1JrZCM2rJqjJTTEzsnzrQOtrlcSbz__RxA5gYQFOWhjv4PSLeDpmeqbE1lY
Message-ID: <CABgObfb50fyDXnQawQQregR6UzH5mZukjX9iADtcrv1VemrVXg@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] KVM: TDX: restore host xsave state when exit
 from the guest TD
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, adrian.hunter@intel.com, 
	seanjc@google.com, rick.p.edgecombe@intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 4:17=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> On 3/12/2025 7:36 PM, Paolo Bonzini wrote:
> > On Mon, Mar 10, 2025 at 8:24=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.co=
m> wrote:
> >>
> >> On 3/8/2025 5:20 AM, Paolo Bonzini wrote:
> >>> From: Isaku Yamahata <isaku.yamahata@intel.com>
> >>>
> >>> On exiting from the guest TD, xsave state is clobbered; restore it.
> >>
> >> I prefer the implementation as this patch, which is straightforward.
> >> (I would be much better if the changelog can describe more)
> >
> > Ok:
> >
> > Do not use kvm_load_host_xsave_state(), as it relies on vcpu->arch
> > to find out whether other KVM_RUN code has loaded guest state into
> > XCR0/PKRU/XSS or not.  In the case of TDX, the exit values are known
> > independent of the guest CR0 and CR4, and in fact the latter are not
> > available.
>
> In fact, I expected some description of how xsave state is clobbered and
> what value of them after TD exit.
>
>    After return from TDH.VP.ENTER, XCR0 is set to TD's user-mode feature
>    bits of XFAM and MSR_IA32_XSS is set to TD's supervisor-mode feature
>    bits of XFAM. PKRU keeps unchanged if the TD is not exposed with PKU
>    in XFAM or PKRU is set to 0 when XFAM.PKE(bit 9) is 1.

Ah, I didn't include that because it's just information from the TDX
module documentation.

Paolo



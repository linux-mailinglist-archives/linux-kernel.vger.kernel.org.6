Return-Path: <linux-kernel+bounces-573079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70952A6D2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0979E3B0D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38222EAF6;
	Mon, 24 Mar 2025 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wyt43Jgo"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6552E3385
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742780067; cv=none; b=WqZTagTb6b4vPwkeT4OCM23+BQ3TQf2wBI8+Ri/K2dS6D40Pdagfjql+4NbeUrMkp6EMyT/CqZMpALlWrXruhLmvBE3Cw90gEaXWULjOGh+nH2IwwdLNUJyKp6iWSkYnA9EkffLlHyT2TCJZfZQfj8Xwvu82LclzQMzXp04cWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742780067; c=relaxed/simple;
	bh=IepzFlLNScfGDcKTDuj6j8Snuej38vRVrxhhP4BgSgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsSjJlvGDwmxdDSlGp7yzcUmueQsNEzDBMPCYQaxA+AGYIPJ+mdhOt4ddb4TTiRvqZd4pHDp41h3ayyZUvd7e7Q0yQ9xfS8V9cXO9JgANK6s26mNudAsEZMnw1HczObljCKp6Yyc4pYwxTymBtatuurTSbgmCyRWsV7gnygFyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wyt43Jgo; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3feaedb6670so2264574b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742780065; x=1743384865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84ZRmXHdIlIW2QrucBXK2LcEOPMw3sQpnxJmzSe2fYY=;
        b=Wyt43JgoOZZFtaL9k5FiC0UIze5Z+psI3+3To21uHgDgZOzYx8gQr5yefx5yGiq8hw
         5wNq61XXOjhWO4oDXfbSaL8H4glllsZGpL0NFMDF05fJhjMBrFaG9BsOohNip+0ZUlC2
         wx5Glz7MrvgIB2nuwJlppOsUW0cTnJNjgNqW9VnKbOUT8z+6zF63HYYUSKwI2Q/gRIDx
         0XOcMj4n+MNQn6l8j3I4R7eIlsqAiYCRuvoMGtCvvLQM9J1syAIIpWHexi/2g1emu1Ce
         RZVnQNqxLwEcm7iABJ1H6CJB1RMirowxt7bvOcIOrngheOlB7SWIw25nEVE8O8mWb/h5
         Ltpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742780065; x=1743384865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84ZRmXHdIlIW2QrucBXK2LcEOPMw3sQpnxJmzSe2fYY=;
        b=hIN2GrkJAohRi11EO4tg21pZHKz3Ldcu/9PQFYzq2aWY2uxG6SYV92xmesSdJhb4Xx
         oZSg5pWl1NuLwFZfmJX6fwWHlaoBZbngkE8Lz3AOFrZJ5v/B0INFFJrcnhY9z1SwjrYJ
         sjZk87I/+QYkQbitS3briktaNxDm6aWBrwShONRxjCcKD46SrXr7ftEj3EsyYHjF2KWY
         Dr2AJxcbghJPa8FrMcVDT4efWNoqqhVD1bf4E60pVGqCEwGIFvoIobhgnGun0iXwgnkG
         Ks+iN0ZVwe9Pp+TaRG+jnt4YzHrXN51xYuCm8eflEh/zJs3bLVX3BUM0tR0UiAuRxrIE
         ENeg==
X-Forwarded-Encrypted: i=1; AJvYcCWVsGS0wSaJ39r6X09/WPjK1Uidr09eQPSR82RxPEPZCyl66/8FvIVntikbDP6hoN68s4hm/oeZ29++woI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dWlNw7vV41MfBuFavnqjmi0LMq30PzeCjB1iZ29a5dbQRscw
	VR6cjsjYOaMbJCEGdmdUfe/VybW58Vss2HQeDnMLNdQ9l93i/18dCoLYeOIxQe6QuYbBXeGOfoE
	B2xuQPcKHB0J55rjO9QJrEv8p5YSmaXoNS0B4fg==
X-Gm-Gg: ASbGncsSktBbmXO1B8TY6WBl1sYzL4rrtP+M795KsFC6877+mY2knkY4/Uho349bOC/
	NPX1YmadiG5lsE5oZFdzk5BCm8YMH/xhNAUT0tJ6ZRIVXx3fVu8snIOjs0l4ZMIe5VGlruRS8Zd
	xGjOjMPS3Ciw2VUn/4hofaTmryt5OFAoEovlmrthU=
X-Google-Smtp-Source: AGHT+IEBi0qD3dAhIDqlfsTYch80KE3KLMOKPcQ4suA7sZ+2dCIppDWsbTicY5SGje03vIW/RCMO6QwRkXTfi7jsVGg=
X-Received: by 2002:a05:6808:6a89:b0:3f6:729c:810 with SMTP id
 5614622812f47-3febf70248emr7710632b6e.4.1742780065101; Sun, 23 Mar 2025
 18:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320084428.51151-1-cuiyunhui@bytedance.com> <Z9w3LL8oZixBKM3t@infradead.org>
In-Reply-To: <Z9w3LL8oZixBKM3t@infradead.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 24 Mar 2025 09:34:13 +0800
X-Gm-Features: AQ5f1JrRd8vI7xXgnP8nskMr1xMc7v2sqHXC3TCQNbIuoPpLKlAmWZRVrCNasoA
Message-ID: <CAEEQ3wmKGGW_FnmHrggBoQBCz2OA2EofLtts=hXLmxqdGNGMBA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: introduce the ioremap_prot() function
To: Christoph Hellwig <hch@infradead.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, anshuman.khandual@arm.com, akpm@linux-foundation.org, 
	mingo@kernel.org, catalin.marinas@arm.com, ryan.roberts@arm.com, 
	kirill.shutemov@linux.intel.com, namcao@linutronix.de, bjorn@rivosinc.com, 
	arnd@arndb.de, stuart.menefy@codasip.com, luxu.kernel@bytedance.com, 
	vincenzo.frascino@arm.com, samuel.holland@sifive.com, 
	christophe.leroy@csgroup.eu, dawei.li@shingroup.cn, rppt@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Thu, Mar 20, 2025 at 11:41=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> > +{
> > +     phys_addr_t addr =3D PFN_PHYS(pfn);
> > +
> > +     /* avoid false positives for bogus PFNs, see comment in pfn_valid=
() */
> > +     if (PHYS_PFN(addr) !=3D pfn)
> > +             return 0;
> > +
> > +     return memblock_is_map_memory(addr);
> > +}
> > +EXPORT_SYMBOL(pfn_is_map_memory);
>
> This should not be exported or even exposed.  Please just open code it
> in the only caller.
>
> > +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> > +                        pgprot_t pgprot)
> > +{
> > +     /* Don't allow RAM to be mapped. */
> > +     if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
> > +             return NULL;
>
> Or just use pfn_valid as that's what we usually use for that check.
> Or am I missing something specific here?
>
> It would also be nice to just life this to common code.

Thank you for your suggestion. I was planning to do just that. If
possible, I'll make the update in version 2.

Thanks,
Yunhui


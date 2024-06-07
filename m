Return-Path: <linux-kernel+bounces-205578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298028FFDB4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204851C21E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C135215443A;
	Fri,  7 Jun 2024 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmtCiTiM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA8155324
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747176; cv=none; b=da1RdYEoM4jNcoimzp2QKrA03bkBHmdADJKAnT4ENQPxhREiLC8YKM3FxZVsR5J+c6O5+n9THQSOAHx+74x4BrvPXz4t29bVrU21NrK/JlYZXjyHrhGJCLVk+lq3NVkMBUBnSkb0cIlpRWvraed9ucWVB0daxdnhXQEAbKH9XQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747176; c=relaxed/simple;
	bh=B3zFejdivwq58sgCde+xSIfN+D1xcBhW5FLNsFIOMwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByMUusEmEVdnb0NS7paO00VvccuxD1bYi+67hwE7D9IBXrvhA6Y9XJ21UqWPNc/Nuzqd5HV6vV5zHYB5g8raoCmNMIzOkX8BG0E7QUChGuqfFuw0pFqXOEn3sgdzCUSw2cqmdA854YmQ59JpJnPvaa9xbyfSom6LXEIJM5PQ/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmtCiTiM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717747173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQhm7jjOeb+Mr4nwJj/w2jq/oUM2mKSIcTrf/W4eUYM=;
	b=OmtCiTiMYSiEEqNa9WSmuid91Xe8K7Eq+AoWahCFQ6kwU3c9s8HbqSHEeWoX13bUds/Cur
	bE+WbtLSb1pGgBoHCn5yqO+XqJQcdW4cserAzE4y5DLgTNwi1tsip0H7YtV3hCEM45vLKM
	5OPuET2ARxwzIlRDGZj8uFjYZB0S1u4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-EmHI3JQHPJiumP7PSUy0cw-1; Fri, 07 Jun 2024 03:59:30 -0400
X-MC-Unique: EmHI3JQHPJiumP7PSUy0cw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35e7cce4c32so1295333f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717747169; x=1718351969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQhm7jjOeb+Mr4nwJj/w2jq/oUM2mKSIcTrf/W4eUYM=;
        b=WoUw9xCIQy5kvGxHd/wiItu6AMejOSOQnEMhMOR3QLJsHoE18E1RPM64RMYUz5DXjt
         nxj04wbv+4zIOXV790NW59E4PgLSnZj3hGbDwswqyHMIXIirFJrvr54P51xBrAQ3fh4W
         jS82t3yUs1o/3Cyq9XGtJ/isZLGISyZzB0C5gEs2yFcwPrd6heeCiE4zXqyr+qtH7one
         Vd/SNsVboVzpJogqPEiVgn63PIn0MUneayVU/KLHCPIq/N/2Qfk1d5+PGSrxtY6N5W3k
         1iTDS7c3DQfmdNknjFzXtdEcv1zFCyJNuJReRtvUgPb2F+AJU3iWo8oeNW+FNREQ/36s
         48qw==
X-Forwarded-Encrypted: i=1; AJvYcCVVdzIqyZWbawmYZD7Mg4N5nN4HfKl+3JTJi5yL8BBBNKIaP4jhlvBgAarXTW4A2+JB+8G1165NfQBQow3KzoWjhwJl2A2tPCGCxhts
X-Gm-Message-State: AOJu0YxMMOgClDLy8tNDDsobXWgpPizssyfa0/SD4e75aB76yEdBWr5T
	/UME/5MKu0P5pcwCReSSF19Y485SVYikYXHNTk4VKB4TzZK4K3b0LkrtZCAKH5YUQjdrOJpxXc+
	Se05SyPqZQgYHNI48MwJfJ4aTFp6WUumYK7Evy7SVIBtgP9yirMeODfVKhnw0ssHG9ROnKntpPh
	DXgjAAR1ufYnuBoGIVYzCuXPz4RX14UHtdcrX0
X-Received: by 2002:a5d:54c8:0:b0:351:d491:de84 with SMTP id ffacd0b85a97d-35efed3d5e5mr1231161f8f.21.1717747168967;
        Fri, 07 Jun 2024 00:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBsIcE5rCNw57VjfIaOqz1IAcOjWCZ6NCRVCzb1cYbFdHyrKvv1lsQmZX4+seYcaGVCjDvSIUEsIpuWv1C77g=
X-Received: by 2002:a5d:54c8:0:b0:351:d491:de84 with SMTP id
 ffacd0b85a97d-35efed3d5e5mr1231139f8f.21.1717747168547; Fri, 07 Jun 2024
 00:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com> <20240530210714.364118-7-rick.p.edgecombe@intel.com>
In-Reply-To: <20240530210714.364118-7-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Jun 2024 09:59:16 +0200
Message-ID: <CABgObfZuv45Bphz=VLCO4AF=W+iQbmMbNVk4Q0CAsVd+sqfJLw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] KVM: x86/mmu: Support GFN direct mask
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, erdemaktas@google.com, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, sagis@google.com, yan.y.zhao@intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Keep TDX specific concepts out of the MMU code by not
> naming it "shared".

I think that, more than keeping TDX specific concepts out of MMU code,
it is better to have a different name because it doesn't confuse
memory attributes with MMU concepts.

For example, SNP uses the same page tables for both shared and private
memory, as it handles them at the RMP level.

By the way, in patch 3 it still talks about "shared PT", please change
that to "direct SP" (so we have "direct", "external", "mirror").

Just one non-cosmetic request at the very end of the email.

On Thu, May 30, 2024 at 11:07=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> +static inline gfn_t kvm_gfn_root_mask(const struct kvm *kvm, const struc=
t kvm_mmu_page *root)
> +{
> +       if (is_mirror_sp(root))
> +               return 0;

Maybe add a comment:

/*
 * Since mirror SPs are used only for TDX, which maps private memory
 * at its "natural" GFN, no mask needs to be applied to them - and, dually,
 * we expect that the mask is only used for the shared PT.
 */

> +       return kvm_gfn_direct_mask(kvm);

Ok, please excuse me again for being fussy on the naming. Typically I
think of a "mask" as something that you check against, or something
that you do x &~ mask, not as something that you add. Maybe
kvm_gfn_root_offset and gfn_direct_offset?

I also thought of gfn_direct_fixed_bits, but I'm not sure it
translates as well to kvm_gfn_root_fixed_bits. Anyway, I'll leave it
to you to make a decision, speak up if you think it's not an
improvement or if (especially for fixed_bits) it results in too long
lines.

Fortunately this kind of change is decently easy to do with a
search/replace on the patch files themselves.

> +}
> +
>  static inline bool kvm_mmu_page_ad_need_write_protect(struct kvm_mmu_pag=
e *sp)
>  {
>         /*
> @@ -359,7 +368,12 @@ static inline int __kvm_mmu_do_page_fault(struct kvm=
_vcpu *vcpu, gpa_t cr2_or_gp
>         int r;
>
>         if (vcpu->arch.mmu->root_role.direct) {
> -               fault.gfn =3D fault.addr >> PAGE_SHIFT;
> +               /*
> +                * Things like memslots don't understand the concept of a=
 shared
> +                * bit. Strip it so that the GFN can be used like normal,=
 and the
> +                * fault.addr can be used when the shared bit is needed.
> +                */
> +               fault.gfn =3D gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_ma=
sk(vcpu->kvm);
>                 fault.slot =3D kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);

Please add a comment to struct kvm_page_fault's gfn field, about how
it differs from addr.

> +       /* Mask applied to convert the GFN to the mapping GPA */
> +       gfn_t gfn_mask;

s/mask/offset/ or s/mask/fixed_bits/ here, if you go for it; won't
repeat myself below.

>         /* The level of the root page given to the iterator */
>         int root_level;
>         /* The lowest level the iterator should traverse to */
> @@ -120,18 +122,18 @@ struct tdp_iter {
>   * Iterates over every SPTE mapping the GFN range [start, end) in a
>   * preorder traversal.
>   */
> -#define for_each_tdp_pte_min_level(iter, root, min_level, start, end) \
> -       for (tdp_iter_start(&iter, root, min_level, start); \
> -            iter.valid && iter.gfn < end;                   \
> +#define for_each_tdp_pte_min_level(iter, kvm, root, min_level, start, en=
d)               \
> +       for (tdp_iter_start(&iter, root, min_level, start, kvm_gfn_root_m=
ask(kvm, root)); \
> +            iter.valid && iter.gfn < end;                               =
                 \
>              tdp_iter_next(&iter))
>
> -#define for_each_tdp_pte(iter, root, start, end) \
> -       for_each_tdp_pte_min_level(iter, root, PG_LEVEL_4K, start, end)
> +#define for_each_tdp_pte(iter, kvm, root, start, end)                   =
       \
> +       for_each_tdp_pte_min_level(iter, kvm, root, PG_LEVEL_4K, start, e=
nd)

Maybe add the kvm pointer / remove the mmu pointer in a separate patch
to make the mask-related changes easier to identify?

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7c593a081eba..0e6325b5f5e7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13987,6 +13987,16 @@ int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, =
unsigned int size,
>  }
>  EXPORT_SYMBOL_GPL(kvm_sev_es_string_io);
>
> +#ifdef __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 nr_=
pages)
> +{
> +       if (!kvm_x86_ops.flush_remote_tlbs_range || kvm_gfn_direct_mask(k=
vm))

I think the code need not check kvm_gfn_direct_mask() here? In the old
patches that I have it check kvm_gfn_direct_mask() in the vmx/main.c
callback.

Paolo



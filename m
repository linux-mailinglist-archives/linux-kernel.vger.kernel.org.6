Return-Path: <linux-kernel+bounces-200490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D2C8FB0C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E08828129A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BD1145336;
	Tue,  4 Jun 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dg+bcibE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D95145B02
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499385; cv=none; b=GBsyonXLjM+Euij1wukQGTzXjrRjNAVzTN44ARQquH36JfSse8eIkT+NeMkpEXeRcy2fGpsTXLK8q/61CATykXVXxbedfRLhZksYCvhYXhmJbyEgDjXhxhlzUEzFVi0Cz0vaLh777Nlo0nlnD5VoIRsCFnm0eG03vCxt62lFHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499385; c=relaxed/simple;
	bh=lYunvJ6GmzDvX5Mv0MNwlWNQS4u2NfOKF2xbK6rhKRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX9/kncHIcYkUjbNQhdMJuc7lMvb3pfsml99AtD6+ywwY7eQaZ9kcdIAUY5GSlWh94j/LupRPO1qVNbgNXH7e877Ufd5vlWOJTHFoNy5Ffdc6Be4wcm1cB0TapsNn+rYlTOpk8Z7arMw38hjPq0in0xESov2LekAFP4e11Pu5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dg+bcibE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717499383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g1CYcVwVGdFbPFSwugJtb1aKEbbUUrRo/R593DHF02Q=;
	b=dg+bcibE8locu5CjNq2G/Ce9zuSNbUIVbyXGcFXlLuk8vORcancxrd7fXBuH7ErGXeGIS5
	Zw4ma5wTMX3uT6lkTEtrabBw3aVxFQGr4G+ZbtrKagXc7hXlWS8iw3J4egGplH2/pw3mVa
	4XrqB7ZgFs7NeREYzbSc04tKg0bN/Os=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-KjJ2ed1JNEy0R-ZGN-0_aw-1; Tue, 04 Jun 2024 07:09:41 -0400
X-MC-Unique: KjJ2ed1JNEy0R-ZGN-0_aw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-374907a1f84so6601305ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499380; x=1718104180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1CYcVwVGdFbPFSwugJtb1aKEbbUUrRo/R593DHF02Q=;
        b=DVOKtEvALQdz7D3LOs/P1YvBblyQFuafbddibn3Hv++RolhBZxkYZS+X6r6xmy9+Mt
         jRYE8YTdMkenPpRncaafWG5LZ1a/DaKzwjSjLAxE/fkY9iSFBEaSzzKVjmG8/hJq4R7V
         MYNitjNOTtxUYhXuzG7KT/j2QMU8I/zc7n/vmPc4Xq78wPlMNQaJfGkmY8RbqJZwPCfD
         YUisFUEVdVa40OriegNbkMoOvL8l/ZrUHRRSJTsafPO2xh+oLy9KzVFf1X0RvR1vGlzh
         uJ+W2ptgQ0oR/n3oEflefYEPxYON8xZVXvSnXZhrGy0Qj5BAkL6CndhzMjB62gzfdZyp
         ufWw==
X-Forwarded-Encrypted: i=1; AJvYcCXMxMnt5t/U262KsmGJQFQbdHrZyKo2vb2aQK/UBD0PcQc+KQ76hW8wmJwmIwOwUTgjhRgx2OFDjRdu4DYd9iCPhS2hipcFHFRn7SU/
X-Gm-Message-State: AOJu0YwAoVBJ2uzW/Q/4KjKXuSGh+/FC1WfZOoPT6hkC4eMBvzAfi40d
	DuAlCd4TisRt0Pz7yd9Y3KbtItX1r82BO7+MOV88tNNQmCvpwHt9eOeKV43CZdz/KswNR6M/AB3
	zY7aiHrzi4i04pBQfIDRs1GdAUe52vaeK0c30cXxdrZ/sPpnI8ZOhR0dGI4DqBiGb8xb0w+Jwgq
	WF4qFb0WXKjGkcftTMS7yfLz36FIBiqB/Q/Kq0
X-Received: by 2002:a05:6e02:1e08:b0:374:85bb:7592 with SMTP id e9e14a558f8ab-3748b8f5126mr139247975ab.0.1717499380382;
        Tue, 04 Jun 2024 04:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFst0U81Ttgn3X/ZFD/HP/TlZoB/pgBQKLugq4Ox4uYNFUHLID+6ovlnSkl6nuMD6Uc/ffi7a31slBzFXhlhUw=
X-Received: by 2002:a05:6e02:1e08:b0:374:85bb:7592 with SMTP id
 e9e14a558f8ab-3748b8f5126mr139247745ab.0.1717499379997; Tue, 04 Jun 2024
 04:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com> <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com> <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
In-Reply-To: <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 4 Jun 2024 19:09:56 +0800
Message-ID: <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Borislav Petkov <bp@alien8.de>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org, 
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 17:44, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jun 04, 2024 at 09:23:58AM +0800, Dave Young wrote:
> > kexec_in_progress is only for checking if this is in a reboot (kexec) code path.
> > But eif_mem_reserve is only called during the boot time so checking
> > kexec_in_progress is meaningless here.
> > current_kernel_is_booted_via_kexec != is_rebooting_with_kexec
>
> That's exactly what I wanna check: whether this is a kexec-ed kernel. Or
> is there a better helper for that?

No general way to check if it is a kexec-ed kernel or not,  for x86
one can check the efi_setup as Ashish's original patch did, as the
kexec booted kernel (efi boot) will have efi setup_data passed in.

Otherwise there is a type_of_loader field for x86 boot protocol,
kexec-tools is 0x0D, the kexec_file_load also uses this.  But adding
the type_of_loader was only added in kexec-tools code when Yinghai
worked on the kexec-tools bzImage64 load, so older kexec-tools will
not set this field.  Anyway the in-kernel kexec_file_load code for x86
added 0x0D as loader type from the beginning.

Anyway there is not such a helper for all cases.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>



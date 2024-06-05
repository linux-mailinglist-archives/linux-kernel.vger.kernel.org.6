Return-Path: <linux-kernel+bounces-201972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E48FC602
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20D1B28C12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B2192B9A;
	Wed,  5 Jun 2024 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOYwMeyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE5192B93
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575455; cv=none; b=jg0OCyM9zUnh18GrsuQJRBF8cutkgTvGoBOtYKs8aKB+ZiXifa1pCnxhod9v5nXFZCru4e0evmcMDGMc6lrJCAVIGVs1thHhpIQ5GidIs97KcBTVF5QWdKHYdo+pq+LwyovvuMYc/Bk9YVJE2E/oph1ayMm1kNCXNRvbw/MN+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575455; c=relaxed/simple;
	bh=SyrCABOxfzWFSovPG3pWSF6TsrdkmMeE5mrN2ab0BuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STBfw4FzzjeuYnvLJIVBEMzj9yB7Z7qC6MzHdy/BKeUG4Q38nak1L0Y7osX4Qp6y+VtHT4RzfsYqrA8cUejqdgvHnmEV+RZyLbMI2KtLcMmszrJwozLnk9LX9jvAr0bwoR7KxdbVw/MF5cshJZInASf5dvngkgU26H72BnPlxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOYwMeyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA92C4AF12
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717575455;
	bh=SyrCABOxfzWFSovPG3pWSF6TsrdkmMeE5mrN2ab0BuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hOYwMeyt6KjHJb7oSVPiIx5+HiDOtXQJqB7D9+ZexeaHGSC5KMoYs+c2N/wJLvTN5
	 quDQeGSSixVbR402ue2n0pm5yYNYEhDAEAXUIZcitDkcDT/BESBDtTxBj47TB4PnMw
	 jFUtgVow+fsyxLmkshuMrTDl4kfhE23F2bmjpNGpkUUPCYiDdSLH7E4ci8QJOeOYCD
	 eJElqYGf9Ov/JxKkyklucUnk5QW9t7sKotGUXeTJ+45QIgfiECyZ3gZDQlO7fEXCTd
	 D7CNI84EVS92oDzwdgWDsecEDMTt0X5Ouur4WD6ocV2A+GvMMIgopWbjprJdI5EOfn
	 8bV4rZqb2PWAg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b992fd796so2305670e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:17:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoTe0yImRkQSAlxTJeG8DbNlMNSKsg0CqE8yD4KWiuhBO6SqQDSfjEvCENZ5SQWu+B7oYX1+fGnHTwxEf5b2HfN3x22wM/KTi58Zw+
X-Gm-Message-State: AOJu0Yy0guV+COVm3rlmg/TdCjYUUQQrEyw7ehIcBAigWIsVM9EI+B56
	Rr9bMtEkGK0Qc2KA+71/N4RWI0IQm1TWoTVUuDcamKXQezDYp+FSNLCRTUZ0pL2y5URCOFJh8Av
	aiy5Ol8ZkWtJKuHWbiVPJt5cCUMI=
X-Google-Smtp-Source: AGHT+IGlZ8B/8qUP04+W16z855ba/YXAp1EIwaPL434uTzFqdW4tr39B39lzlfhSYchjCrvswDx/zghAaOFUls5LZKc=
X-Received: by 2002:a2e:a173:0:b0:2e1:e33d:67f6 with SMTP id
 38308e7fff4ca-2eac79e9d52mr8409391fa.28.1717575453266; Wed, 05 Jun 2024
 01:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com> <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org> <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local> <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
 <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local> <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>
 <20240605074257.GAZmAXAbkc5TGVds5u@fat_crate.local>
In-Reply-To: <20240605074257.GAZmAXAbkc5TGVds5u@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 5 Jun 2024 10:17:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFweoskB_qnUFA1b+QXWhjovwMfpM00cGb9KMcm4Zr7EA@mail.gmail.com>
Message-ID: <CAMj1kXFweoskB_qnUFA1b+QXWhjovwMfpM00cGb9KMcm4Zr7EA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 09:43, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jun 05, 2024 at 10:53:44AM +0800, Dave Young wrote:
> > It's something good to have but not must for the time being,  also no
> > idea how to save the status across boot, for EFI boot case probably a
> > EFI var can be used;
>
> Yes.
>
> > but how can it be cleared in case of physical boot.  Otherwise
> > probably injecting some kernel parameters, anyway this needs more
> > thinking.
>
> Yeah, this'll need proper analysis whether we can even do that reliably.
>
> We need to increment it only on the kexec reboot paths and clear it on
> the normal reboot paths.
>

I'd argue for the opposite: ideally, the difference between the first
boot and not-the-first-boot should be abstracted away by the
'bootloader' side of kexec as much as possible, so that the tricky
early startup code doesn't have to be riddled with different code
paths depending on !kexec vs kexec.

TDX is a good case in point here: rather than add more conditionals,
I'd urge to remove them so the TDX startup code doesn't have to care
about the difference at all. If there is anything special that needs
to be done, it belongs in the kexec implementation of the previous
kernel.


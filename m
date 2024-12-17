Return-Path: <linux-kernel+bounces-449267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F419F4C86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698BB1891EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DEE1F3D55;
	Tue, 17 Dec 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1u9sZZCJ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390851F3D3A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442443; cv=none; b=BmnEQYfKCEHhJ9868R50IdCNVwFbaCxthNzGbQSEMdgjBegoP1bMyzjwrWyC/vXXxIfurijLj7IYnKq8OIgTlJm+JRZ94qErCpTwtMah4IEo5PmgbbM7C2YwRYCRiggHQziKk5lwmselrg6lR/hbJ5Byaz9b0qz357f3I6cyd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442443; c=relaxed/simple;
	bh=5xutDIjCyMIitN2CQux5XcwFtIsmOsvNxx/cYCqH9pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNrcVg1NoMzHwJY9XAk0fTqQJxYLCmTxX2QxaW3ABmw5hazkkq1R/6k9vGlpvaRW4SpFZAD+2gdmudUX9iiIqTaQAGFp2qKlneYcA93e8DAJvLHtNFiN/lKIh2mwFz6dS+RtyKwv2n3XAM1lBlq+imAdIZ2UwcyQ+xESibK05gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1u9sZZCJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa66ead88b3so946000766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734442440; x=1735047240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QNzKWwcjuKoS1G8q7vft+5gTVP09htSDXmMOavO194=;
        b=1u9sZZCJforiRLnXjMWvYrWvPIF7gxdEPW+r5xqXzpqCUJLM9yc/ue6s8HlF9sAaxJ
         fGSh/C/JSPP1Ufff8raa2qoP05q0X02wz0kQN6XDoFaEaZxq164eGxxRomJgf6vU/rfb
         etnaFh8KHgNlEbHelsePXLHiRmMxXMx+0ZV13/Un+Pauzl4t3HxxpC6FSgaE7nghL29N
         p/cppF0t7JVdvYx3RDImPe6FHwIRUXEky16UHm5BWPxodCHPGE9dSw/JecLWehiIG7Lb
         EoqvpJZlaK/e1CMLxkKcJuxZOWFZd9bfZ3WpndgK9LnLSA8EbH5QaM4xT0Fv0UcuF9WU
         T4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734442440; x=1735047240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QNzKWwcjuKoS1G8q7vft+5gTVP09htSDXmMOavO194=;
        b=GMYmErL4pbmTKkfQJsxEPdv4lW0+9w6LF/LOVdtRQjF05JTfEKN44Gxhhji7MatqWr
         lhP+sHURHsAQyAB8UvLT+25OceN2+BD58YYgvOFsOtYue0ncudUm2mXOUecp1U0tlaZE
         s9XTdz7HJBYr94T1AqnRifzcOXDVYfn/LO26rvDKdSsLnroZdD6WTX55lPpHGqjVrvw2
         f+bEMFIw0rAgmrTFmEpMAmsMGSotDr6bx33MxZwIhw+N8snLjn3Uo9kfYkpSw1DEtndC
         FjEcTkike40yqGSjo/2oJWG1v9/26fPpXpllKzrPQ9hAEYlP8JkjYXdOx9L/Br9/49PA
         t07g==
X-Forwarded-Encrypted: i=1; AJvYcCXkyiccrEUiXVQo0zMpCgUBU0jTxBfswdYINQLMF2qD7qbLOYxID9SeBZbnjhpQog6fiDIzr3ioFSARJ/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyAiFVpEjzDGeQlJJkZdVk8et/UPaZtZJmY78ZoAwLgUHHP7k
	LHtgZujEQrn0iUKG/VSMsVGiFeuVh7CP0tN9XSZ7CjOB09si54CG32Qo1+TmKA==
X-Gm-Gg: ASbGncsYg/ikljGJPIiLO1x/oI47nb36YAaZA0kKRjGAYR5w2lCeMEEaRVoA4QPJatd
	hTAwP/KEKPiRiWxQTMXjnoMG1VlJVQeWLyFytPguyy/5n/vlVb2/BNFPBxDpLOoNR1fbHN1vCDO
	5VGcc0+xuhDM9q3M2MbPRH1TUcAIWBeQ4/s5Os+8Qzs1oPS0vYwCtBKjEm+ACc0DvEpaXvZHsBz
	EO2+jvh76OC0aK2meMJqN75gx7+AbIYgKEQmgKKev/NvUI7JltJN1jtlEDDrzXgMd7CB6/0Sp/J
	SvgIDJ3QBuec/WE=
X-Google-Smtp-Source: AGHT+IHaaBpKehN/3xKCSI4k6TebR04IYJYJaUaIapMz4+szmzBaeqriWGDQgSt0k6S3fPHQK0lNaA==
X-Received: by 2002:a17:907:7296:b0:aa6:6c08:dc71 with SMTP id a640c23a62f3a-aab77909ee1mr1749746666b.23.1734442440424;
        Tue, 17 Dec 2024 05:34:00 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963c54c7sm442926066b.195.2024.12.17.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:34:00 -0800 (PST)
Date: Tue, 17 Dec 2024 13:33:57 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/18] KVM: arm64: Introduce
 __pkvm_host_unshare_guest()
Message-ID: <Z2F9xb4jrK1zRtNV@google.com>
References: <20241216175803.2716565-1-qperret@google.com>
 <20241216175803.2716565-12-qperret@google.com>
 <86wmfyr1j4.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wmfyr1j4.wl-maz@kernel.org>

On Tuesday 17 Dec 2024 at 11:29:03 (+0000), Marc Zyngier wrote:
> > +static int __check_host_shared_guest(struct pkvm_hyp_vm *vm, u64 *__phys, u64 ipa)
> > +{
> > +	enum pkvm_page_state state;
> > +	struct hyp_page *page;
> > +	kvm_pte_t pte;
> > +	u64 phys;
> > +	s8 level;
> > +	int ret;
> > +
> > +	ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level);
> > +	if (ret)
> > +		return ret;
> > +	if (level != KVM_PGTABLE_LAST_LEVEL)
> 
> So there is still a very strong assumption that a guest is only
> provided page mappings, and no blocks?

Yep, very much so. It's one of the main limitations of the series as-is
(with the absence of support for mapping anything else than memory in
guests). Those limitations were mentioned in the cover letter of v1, but
I should have kept that mention in later versions, sorry!

The last patch of the series has a tweak to user_mem_abort() to force
mappings to PTE level which is trivial to do as we already need to do
similar things for dirty logging. And __pkvm_host_share_guest() doesn't
take a 'size' parameter in its current form, it assumes it is being
passed a single pfn. So all in all this works well, and simplifies the
series a lot.

Huge-page support should come as a natural extension to this series, but
I was hoping it could be done separately as that should have no
*functional* impact observable from userspace. I'm slightly more
concerned about the lack of support for mapping MMIO, but that too is
going to be some work, and I guess you should just turn pKVM off if
you want that for now...

Happy to address either or both of these limitations as part of this
series if we think they're strictly required to land this stuff
upstream, this is obviously up for debate. But that's going to be quite
a few patches on top :-)

Thanks,
Quentin


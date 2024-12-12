Return-Path: <linux-kernel+bounces-443073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2429EE6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2484161B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4202063D3;
	Thu, 12 Dec 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udV4JA3b"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28A212FB8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006436; cv=none; b=S6juKOTiP47MaA4t3/3a/Zb5Rg98zwQviJGQLFE1c+BB2QTQiTB5hcUwBVBl2Ag42sm5RoVsz1UQoZYCfaYaVqZCAdi688FNEn4YKETElqJH3XpGO5eeB212OnhdViClzkUfZv/WA26FkBtdXgSXjFEXuYC3/iNjU4JeUzbP3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006436; c=relaxed/simple;
	bh=q6ynNeOCDXVuRvdmL1PtiLEOqRo/4ZyxNQAlf4XcaRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zvc6M277ROvM4bVhqaQ8TIpxJHcA6YjEb18qGQ9gnMMyv9BtGl2DZ3wdUf2MU8pTGaYesXLGEQDcQpEPHCAM3fElH39lKeGil+xbFI4pwoQxbLkHAz4IDhjoLR0c6oy8ZXP/Nb7sJ+dkij+SHMUNjtVgJWhZXAadqXr2o8Lqmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udV4JA3b; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e44654ae3so73012166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734006433; x=1734611233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpCx9eEDDQPBSqjdyYw4LOrb6jdU2YEGsy2eXplgVns=;
        b=udV4JA3b/2swQY7TUMbI9nyU+zH6qZ9AgYLP5qweuqu6wG1n1zZccRAYWGmPrnugiL
         MCjDHu3UicyPhaDQELZwVmz2npJgiCsju2Gi0jOuqpMkMGws/ah/Ah9t82hnRxhA5gOI
         Y9kX7zpV2HXufOCRzaoySX43rQm4vSMHklWaNegIm8XgMAcfQta6yvXfhkChc3yf/rqw
         n4LE9DX04TG7QAQg6pe52Ge6pzuFubqOvzWWOLZxVEx6jep08NPECtml+xuXxH5dbBlP
         gcLFo26XT4ENhSsU9vSSQCCK5tswx6MrlC4ZAh+qq92VJOQ4rkFcSv7RZMU3B6SNJ69O
         v30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734006433; x=1734611233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpCx9eEDDQPBSqjdyYw4LOrb6jdU2YEGsy2eXplgVns=;
        b=ohEcZT0msvSXGO8bNF79j1L1F/8ocKJBF7+MtlHDkLceFqok/n3WehvrtTReuEIhkC
         /5KkLeKd6Qk2PzZ8Esg/Ok6az8KymQ2BSUrLfu2In0jkGWJexsBnmvNPhxi6UvkhJI4s
         /vRXLI7SRkNFtHmezE6xr0KVHz2rsu0L3y00dU4YMDs5QnAkeoy9+IFPvhFXs7LkXvU7
         IDIE1lfRxQWKbOBHrro35qapYrthLZ5hsYqpoNSzVr55tV5lKT+TOBK7zW2KmZQotBf6
         kPek0NiOCdQNayhMkatZH17FcvzMSBmTfRCwQmlmY5TLVZcQ61HjkO4clJc0oRgQgslG
         GB0w==
X-Forwarded-Encrypted: i=1; AJvYcCUm1YgFlO4OrQ16hqWujlBGCvEqK9iObpEbXv3MS8F1lSOFIXmlkJuxjdY9MqB1vppX/iytDdv1PdZkyqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrgZuElEm+7sADmWxvjPrN7AyW4z04YE167c65moglOpOs0W/
	D6Em1PYEu/8BoGSAqBy7w7L66KIKLT9i4xW8LqghvPi2LmodVZpcG5Bbj7Iebg==
X-Gm-Gg: ASbGncsHY+Tx4X4nnJShsNamhEjagKU/6egEOrGWC7jpiK5gelnoCGDrDtG42vOXCN1
	lch/diSmPcGeeCSGg8aUcfEZHciJNXBs91X32PLeL6HUe7nygbEAWUpcCoN2nTNH1Co+L/JRZbk
	2BySAKligM3zmqdmFf0QxRC9zGhC3uMwjRDfH5e8OaThfA82oEJeBInvT9nbizSqO1vNKRK5nFX
	MQ5T/O6JpJ3UnQHb4EHw1jT3ZuYmIai5Y+5h2NPThGszd/9++bV6XGddRiY6P8XUVWDN08jhomY
	PK/a5SEuTwvxi4M=
X-Google-Smtp-Source: AGHT+IFFYyzPYoG7tPh7WgbnFd5v9cmFfs7rDc+kSSl50Gc/6DepQiqRz3hckPhM0D2fVycpQfsYQA==
X-Received: by 2002:a17:906:32d3:b0:aa6:967c:9aaf with SMTP id a640c23a62f3a-aa6b13da9f7mr673167866b.50.1734006433119;
        Thu, 12 Dec 2024 04:27:13 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67c7bd55fsm657911666b.116.2024.12.12.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:27:12 -0800 (PST)
Date: Thu, 12 Dec 2024 12:27:09 +0000
From: Quentin Perret <qperret@google.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 4/6] arm64/kvm: Avoid invalid physical addresses to
 signal owner updates
Message-ID: <Z1rWnejzN5Zk8TDU@google.com>
References: <20241212081841.2168124-8-ardb+git@google.com>
 <20241212081841.2168124-12-ardb+git@google.com>
 <Z1rJ_dMJJzGOmjNs@google.com>
 <CAMj1kXERuRK_MdHJOY+SKR=BJ-Yi+q0FNgVayq3W_jL9zdjLVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXERuRK_MdHJOY+SKR=BJ-Yi+q0FNgVayq3W_jL9zdjLVA@mail.gmail.com>

On Thursday 12 Dec 2024 at 12:44:38 (+0100), Ard Biesheuvel wrote:
> On Thu, 12 Dec 2024 at 12:33, Quentin Perret <qperret@google.com> wrote:
> >
> > On Thursday 12 Dec 2024 at 09:18:46 (+0100), Ard Biesheuvel wrote:
> > > @@ -908,6 +892,9 @@ static bool stage2_leaf_mapping_allowed(const struct kvm_pgtable_visit_ctx *ctx,
> > >       if (data->force_pte && ctx->level < KVM_PGTABLE_LAST_LEVEL)
> > >               return false;
> > >
> > > +     if (data->annotation && ctx->level == KVM_PGTABLE_LAST_LEVEL)
> > > +             return true;
> > > +
> >
> > I don't think it's a problem, but what's the rationale for checking
> > ctx->level here? The data->force_pte logic should already do this for us
> > and be somewhat orthogonal to data->annotation, no?
> >
> 
> So you are saying this could be
> 
> > > +     if (data->annotation)
> > > +             return true;
> 
> right?

Yep, exactly.

> That hides the fact that we expect data->annotation to imply
> data->force_pte, but other than that, it should work the same, yes.

Eventually we'll want to make the two orthogonal to each other (e.g. to
annotate blocks when donating huge pages to protected guests), but
that'll require more work so again I don't mind that check in the
current code. We can always get rid of it when annotations on blocks
are supported.

Cheers,
Quentin


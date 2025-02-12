Return-Path: <linux-kernel+bounces-510918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5EA32396
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4203A052E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77E2080EC;
	Wed, 12 Feb 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4tp6urpp"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9B1F9A83
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356732; cv=none; b=SsBG/nE9WTp+meH1zOFP1CLysx0tZER0j11ITTWhFrD0CEl8fXYUSRD/Brt4AC8UnDC3tHJcXaoMBZI69dpOqIFldjqjojbaPV8zmej334b2Q+EV1roEGpCvEqOjUY522JxFDGyEzFkIQm2lz7jvvZndtSvxliyAC7mobhfCkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356732; c=relaxed/simple;
	bh=0wgmTsr10OPshSJjg/RI4bOCyUwctdiqcc0r0Tpeesk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEdhwWJYHxHcZs71I11C4hYSaBJslFGYLokejpe53p7Am+yhRio2bAP4+5olBHxdGja7FKN5RxrGdGW8U6a8JySAgcn7BLFlm4SX3KmMdSx8oipQRENWbvMhf2076yr54QPtewaI23hArmHx05/kfQiJunw8X8v2Cx+KUG89i6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4tp6urpp; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47180c199ebso232741cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739356730; x=1739961530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SZypuT5krcMP4SFZDITfjouL/pSMfKVuh0e51cR4PXw=;
        b=4tp6urpppnKzp0mavBq9PlRdKsYBHWCcgBlWSUVtWQDS9KCsKnErkyoSFtfzgily3N
         6Cd6gplO7+QxaFVj+XcadJVYelyJHOJuH/umnYcYE9hcoCUnNP07y87p7BeCAjXUyzCE
         HYqHgpbRTxtjPHM/B6Se5lEx/i3++iY9Yz0o1Sysl/3HLkNfdulwlPezQWgXJAePXcwH
         7Ui6aWX++sTXNioFIa5JXpbIuPmiTm0Hu6xZ8IhMhAVI94YpXxsIsklhAzEFiXLw3r1o
         wS2RFkoEj94427tHqcR35p8E6qZbD0nUJ37wvoxzSARU/lvcCXBAu+EWdQp4VP2YSTJ6
         FNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739356730; x=1739961530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZypuT5krcMP4SFZDITfjouL/pSMfKVuh0e51cR4PXw=;
        b=tQrKFICIzoPAmOm/IKm+yJJ7hptinGvN6mtpXUdVQP77VcdAZpuifck/7LSZxzdYcQ
         mK4DfJ4El1vHTCZ0JthVpN2bqpmMevOwc2mjykuAp2gOTfMNAnFd4vMBXJ7kzrxP1AEu
         +1vvR0HspGBTJjudfQISLfiIErCmEdrQaLaIWLbOcuB+YOkr21nq1nnYbSdUWR3rDRUV
         M5IsYETbQqec96LHYiE49W+vEgtgH/GU+ZknQopyqj0ThqhqKQC+4X3XSlHHc917VmDO
         10SvO+QogVmn44cezoKazJA9w5KiGY/L77fc7W3VLJkXbWfAidWqOLjjdBcg9AL36EHM
         XdQg==
X-Forwarded-Encrypted: i=1; AJvYcCVf0YLOJHkLKlRoDkNaD4GxbB4HbexvPbj1/2nOOmF0q8mo3UmWBgXNMGcthvHfHtC9kqfSFhHNG/+cnKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTe0R1liA3RLIHhmixwVk0n6iVsk1kxBsMMk7MzjKFL53B1ob0
	Qo+1Cxpexe69EsOzTgePNMPGgBTQeaz7XX1BkVExiUaCKx8SRXsq21iGP636O6T2806O/aaNF9E
	cGWTs7chjvvDWXH7NA+SOYJVB87/n6ufvioeF
X-Gm-Gg: ASbGnctZkqF0n7YCmAsHjHg3Orta4tITNmNA6BmOazmlaHIAiBjVdxCG3Fl9KQ1UglW
	iqMv43L8s/KMxMNlXGzmBPl1piPySGlT7GwvgiLCKMKahF/eRrjhLAev3uF9luxc++mr0TMBZZh
	w0QJwLP1rkqmKZMgPRtr2v7aEnwnw=
X-Google-Smtp-Source: AGHT+IElrirA3T7jJtl/cF/qJPO6MJFdNGdFKOFef6rccKK84LMIwNutRdXvIl2RlySmjN1aEpZkNiDKbr1f4jbgcCo=
X-Received: by 2002:a05:622a:59c5:b0:466:8c7c:3663 with SMTP id
 d75a77b69052e-471b1c02099mr2335441cf.5.1739356729767; Wed, 12 Feb 2025
 02:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206044346.3810242-1-riel@surriel.com> <20250206044346.3810242-11-riel@surriel.com>
 <CA+i-1C2zuctxx6oPVVu0zBJ=Q=Hs73mgrWs5jsp8obARNcUS9g@mail.gmail.com>
 <2d20c333400b890f4983cf799576435abf1d8824.camel@surriel.com>
 <CA+i-1C16x5u-1qAqDPSONgs+pGWrfUTO1zq2r6Rrvq=q48NHpw@mail.gmail.com> <e8a156d4c8f5db07cf03b55fb81c75d523cac680.camel@surriel.com>
In-Reply-To: <e8a156d4c8f5db07cf03b55fb81c75d523cac680.camel@surriel.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 12 Feb 2025 11:38:38 +0100
X-Gm-Features: AWEUYZnnptWZviVi5t3DfNQp_oZ7iOddvpSL765Hw78lYEAmJd91yLLtDHAOK_E
Message-ID: <CA+i-1C2CcQmrbdv0wLUJFD6m85D7LekejU=VdgMxnqZW=DRPxA@mail.gmail.com>
Subject: Re: [PATCH v9 10/12] x86/mm: do targeted broadcast flushing from
 tlbbatch code
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, 
	peterz@infradead.org, dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com, 
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com, 
	mhklinux@outlook.com, andrew.cooper3@citrix.com, 
	Manali Shukla <Manali.Shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 21:21, Rik van Riel <riel@surriel.com> wrote:
>
> On Tue, 2025-02-11 at 11:02 +0100, Brendan Jackman wrote:
> >
> > So I think here we're encoding the assumption that context_switch()
> > always calls either enter_lazy_tlb() or switch_mm_irqs_off(), which
> > is
> > a little awkward, plus the job of these functions is already kinda
> > hazy and this makes it even hazier. What about doing it in
> > arch_start_context_switch() instead?
> >
> > That would mean a bit of plumbing since we'd still wanna have the
> > tlbsync() in tlb.c, but that seems worth it to me. Plus, having it in
> > one place would give us a spot to add a comment. Now that you point
> > it
> > out it does indeed seem obvious but it didn't seem so yesterday.
> >
> While that would be a little bit cleaner to maintain,
> in theory, I'm not convinced that adding an extra
> function call to the context switch path is worthwhile
> for that small maintenance benefit.

I don't see why it has to introduce a function call, can't we just
have something like:

static inline void arch_start_context_switch(struct task_struct *prev)
{
    arch_paravirt_start_context_switch(prev);
    tlb_start_context_switch(prev);
}

The paravirt one would disappear when !CONFIG_PARAVIRT (as the current
arch_start_context_switch() does) and the tlb one would disappear when
!CONFIG_X86_BROADCAST_TLB_FLUSH. The whole thing should be inlinable.


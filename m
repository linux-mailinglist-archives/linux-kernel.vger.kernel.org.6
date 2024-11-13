Return-Path: <linux-kernel+bounces-408146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B089C7BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664F2B2A781
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F9203715;
	Wed, 13 Nov 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCxJqXdi"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE271586CB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522163; cv=none; b=RDoAmQ55E0DtQnP1MRQH3n09kFSvcGWz42FEndajrXmByAxkkY0u7uVaid0TnwMPufEp7mVJeCNUBrsQKPpQQLM6XbjNipqBpX8DieuGRMKKKbjU0knFBP8bx3fkCHYWoBO8KHOB9QXjvDAzcpVo7xaImp6Ujz7UhtxXYmdFFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522163; c=relaxed/simple;
	bh=owvgf1xfhUwmXeGNbhlBFgN1MNaRZnrXUUz7/mLOXlg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BsvaH81Sme/E5FMITvfwgvy+c04/esOHCK1jR95OszbSzqoJG+WLnw6vgCQe7lg+LCcqRLON8uB0uzHXM60VhBSOS6VuhvX2E6GyMoIiTUobUbyOokVX+kAKFKGj96AZ1ByQZ3BiveIyXZDJu8AQ1Srl0E1gtnl5N+0kSMy1FMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCxJqXdi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e380e058823so194178276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731522160; x=1732126960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=foXo4SwpQ6+tkfr9q/YAIXSpHlhXaZLsZbO7fGNTKRc=;
        b=WCxJqXdiIwuH8lp32Lfn9jYuU/jdCYSoYo/vLp5lXGNgeHZCy5nBBtbuDHJdy+Z3OA
         mufb1hY1dm7cHrGGAWyTIyZaPOd8zxhYsZY5TnHmMq8ABVt/n6RODH2tqhd7pmJVdgN0
         fvXuNC0sgNx7XIzmhVTGHLRK3dlS6V5bifVI1gWYLPrsRETl/4BAU3p6Pg90KI2Hx4dK
         r7GxvFPmOQDMRMZ7f4/YvZpSNm08BlFeHJLVRD9LNTZhod2efiI3iiiR247LUieJ9y49
         rIOBSMztZEKGQNyvEa7AweSFJNsR9+YGQF2vVx5y9yISUrZ+4EtHf3QcnjX6pmhFPBMR
         LrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522160; x=1732126960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foXo4SwpQ6+tkfr9q/YAIXSpHlhXaZLsZbO7fGNTKRc=;
        b=H4PlZWV5rYpaMt4/45s8cAFM1GlLAPY6Q+9fyKDOW2D0oSJhm5cjtcx/+kqMdQIUyX
         TykCNQwCJ3E8g/TPBmgae71OYJqjQf/RPRpIOj0F5n/QKaQPLjQs+uiV4rt7B8kLpQ7n
         KmPPrhxTM8RGjrLqWg3YOVq1iC0LTXCAFQib9Qppb3MWdJnqcbGoJhy6LoSu8TjQWRmr
         2s3LYAMwr8lLWkjfMeW/HwhQ+PSX+ILLzSZ6ZG/EVgwLiC+MSwn6ghup/TK/Jhq8BHi+
         uVAeVBhKete4mCs7cFwa2R46VlLokGk1O8JN7da/goRjPK9TvkVhneTBi79bJLd9I51H
         QWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxWD2eozykG1DMHumxfzs3N49xS3kakEneZ8EPKqp0HAl8xqWy/z1EJ+3ERv2uX79Uol4JGkBxoTlltWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEeu7fvt4JlR6sThsXVgjSvuEu45zwkj6y4hlFCHk+8BwJsKkn
	ryVzWKCABOZNOu2V3/8ZMKNafWW/kFkL/RtEERemkSWo8qlQD9RPacQsUZqXKukw9Z/z3ObkRsO
	3Ow==
X-Google-Smtp-Source: AGHT+IFDlulUlqQJ4uSoLm5pSTu7Qe8PBX29jVHGo6PIKHEOxVPRJED4+2XYHeYgGpbn2As2bUG/FqkmGqI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:6888:0:b0:e29:9c5:5fcb with SMTP id
 3f1490d57ef6-e380e241492mr3384276.4.1731522160502; Wed, 13 Nov 2024 10:22:40
 -0800 (PST)
Date: Wed, 13 Nov 2024 10:22:38 -0800
In-Reply-To: <308f26c5-d47c-df63-19eb-59ebbf1e16dd@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
 <20241107232457.4059785-10-dionnaglaze@google.com> <43be0a16-0a06-d7fb-3925-4337fb38e9e9@amd.com>
 <CAAH4kHasdYwboG+zgR=MaTRBKyNmwpvBQ-ChRY18=EiBBSdFXQ@mail.gmail.com> <308f26c5-d47c-df63-19eb-59ebbf1e16dd@amd.com>
Message-ID: <ZzTubiWtfmNTPlLK@google.com>
Subject: Re: [PATCH v5 09/10] KVM: SVM: Use new ccp GCTX API
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Michael Roth <michael.roth@amd.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tianfei zhang <tianfei.zhang@intel.com>, Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 12, 2024, Tom Lendacky wrote:
> On 11/12/24 13:33, Dionna Amalie Glaze wrote:
> >>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> >>> index cea41b8cdabe4..d7cef84750b33 100644
> >>> --- a/arch/x86/kvm/svm/sev.c
> >>> +++ b/arch/x86/kvm/svm/sev.c
> >>> @@ -89,7 +89,7 @@ static unsigned int nr_asids;
> >>>  static unsigned long *sev_asid_bitmap;
> >>>  static unsigned long *sev_reclaim_asid_bitmap;
> >>>
> >>> -static int snp_decommission_context(struct kvm *kvm);
> >>> +static int kvm_decommission_snp_context(struct kvm *kvm);
> >>
> >> Why the name change? It seems like it just makes the patch a bit harder
> >> to follow since there are two things going on.
> >>
> > 
> > KVM and ccp both seem to like to name their functions starting with
> > sev_ or snp_, and it's particularly hard to determine provenance.
> > 
> > snp_decommision_context and sev_snp_guest_decommission... which is
> > from where? It's weird to me.
> 
> I guess I don't see the problem, a quick git grep -w of the name will
> show you where each is. Its a static function in the file, so if
> anything just changing/shortening the name to decommission_snp_context()

Eh, that creates just as many problems as it solves, because it mucks up the
namespace and leads to discontinuity between the decommission helper and things
like snp_launch_update_vmsa() and snp_launch_finish().

I agree that there isn't a strong need to fixup static symbols.  That said, I do
think drivers/crypto/ccp/sev-dev.c in particular needs a different namespace, and
needs to use it consistently, to make it somewhat obvious that it's (almost) all
about the PSP/ASP.

But IMO, an even bigger mess in that area is the lack of consistency in the APIs
themselves.  E.g. this code where KVM uses sev_do_cmd() directly for SNP, but
bounces through a wrapper for !SNP.  Eww.

	wbinvd_on_all_cpus();

	if (sev_snp_enabled)
		ret = sev_do_cmd(SEV_CMD_SNP_DF_FLUSH, NULL, &error);
	else
		ret = sev_guest_df_flush(&error);

	up_write(&sev_deactivate_lock);


And then KVM has snp_page_reclaim(), but the PSP/ASP driver has snp_reclaim_pages().

So if we want to start renaming things, I vote to go a step further and clean up
the APIs, e.g. with a goal of eliminating sev_do_cmd(), and possibly of making
the majority of the PSP-defined structures in include/linux/psp-sev.h "private"
to the PSP/ASP driver.

> would be better (especially since nothing in the svm directory should
> have a name that starts with kvm_).

+1 to not using "kvm_".  KVM often uses "kvm_" to differentiate globally visible
symbols from local (static) symbols.  I.e. prepending "kvm_" just trades one
confusing name for another.


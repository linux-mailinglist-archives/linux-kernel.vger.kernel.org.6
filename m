Return-Path: <linux-kernel+bounces-406634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15D89C619C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0551F2433E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336CA21D218;
	Tue, 12 Nov 2024 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lu9J4MnX"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF221A4CE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440043; cv=none; b=VRU27ikj74zT/nr5jJB2tcxwe1Z0Lt0mAzZbv+4/8Jv6t4t918YZBxPdv2VPbXtVB954J5wNjKFVweFip0NoDlpVrAXthgTErq/QkFRw6HKoNS8vkGhbrTaUxZkvwTFhtFm5cP7yFQSwXxFyryjxn83qz0AVAXoz5XDMESFgOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440043; c=relaxed/simple;
	bh=8Zw9VxaGNKeAshrG2DVz/boJEgYN8+U9vCybtzTq3DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/6SBNanUif9xcxPEdDoa/jiZ2okJTOnnX2bVJb0IjonDpwAzGGIRfCEn8HH38CqIarwMGyA5AxQWiQMEI0+cCt7hkwnZ3oOHgwtKPqRA70CDhjZau7o0aN5Ydn+7P0793/lMnj3E4MQhdE6HvYx//CQTQ1xBaf7FUrgK474YUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lu9J4MnX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so5592063f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440040; x=1732044840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y9wb6AkvqlKLFv6CsY4nbWvFqgC5HzXu2/jh/XKH3TM=;
        b=Lu9J4MnX0Tfs5U9qfyePnTDpqzHilgAarFqlHiXG/QnvASy1iPMfKN3jZU1MghoGkH
         UjQRcZQDqVW0u7IRz2kHUUl0SOmwO9cSeHGchdwyFRYT+2MIFVdE/8tsYXe3QCnLPAG5
         TUb8N30iz12uBhr2GAkyCa77BkWvqKxajw1LnlbctHuYFfiIolCmrSFBUzJjaTaIPgfs
         I72oWYz1a90RrqR53Zr5PLXZkqZzF/FNYRWCWmIgpHkiVN+M7A5sYc8+jbbXJXUGsOCs
         jG2bo9qY8wB0iNtyV9iSEhc+atWJJ0cYnlDG3haBIDx6vmV5MlkoSFzXWhv0ppXnB7DV
         Bz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440040; x=1732044840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9wb6AkvqlKLFv6CsY4nbWvFqgC5HzXu2/jh/XKH3TM=;
        b=hCrdZeHPYLHqOpEEu4NvxJ1LS4PwN/T6dI5eDjeuTc3qBH0OELePkNtL3JKbA1F5as
         tdUFUuuCKmPjteH89GoY7hDH25GZ1frSfk+e8PV0bbiBLviUZMhni/CJhOBfE3UrPpnJ
         sY8r7+11W+Be+BBhITiM4+b5m+RFqHGmsE/Um3IfyVuKkceO/3pWwFtFM1qhmbipG4/e
         JQHfykB7IKlIBUAZEi+Rc/Fpsiumg3mW/1i1PZNX+O0mWxJhV3Qb3juw71mWLcJDGNo1
         htoEediSf0J4sLlJfIw+glGz63dSkWZFj3CEzzl4rC532qGkK0W2kG8nVUkOxMa619ww
         D6/Q==
X-Gm-Message-State: AOJu0YwMjhpU3yCvDpByYnZFt2Gy8gRnPvqmux3Sy8SUaEd/TKqKd/bl
	9kPN1m67PJG/nVR1mKoS+ZHvOwmCzwVDyMay9MCDiJ1T+xqsj7yG1DYOTZJYVVIQQP+CcyYnJHg
	SlPT3ZcbWHcyOM7GVLibbFwV0tEddJx3zQlZe
X-Google-Smtp-Source: AGHT+IH2loZRrvGX7OLDNAn4wYJUo+4ZKUEg9FXqo8fn5IA6xVdWeodz/p2eUqUKInKsvo4Oso+ZqW477vo9YTiTm1Q=
X-Received: by 2002:a05:6000:2a8a:b0:381:f443:21d1 with SMTP id
 ffacd0b85a97d-381f443259dmr17589618f8f.54.1731440040288; Tue, 12 Nov 2024
 11:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
 <20241107232457.4059785-10-dionnaglaze@google.com> <43be0a16-0a06-d7fb-3925-4337fb38e9e9@amd.com>
In-Reply-To: <43be0a16-0a06-d7fb-3925-4337fb38e9e9@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 12 Nov 2024 11:33:48 -0800
Message-ID: <CAAH4kHasdYwboG+zgR=MaTRBKyNmwpvBQ-ChRY18=EiBBSdFXQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] KVM: SVM: Use new ccp GCTX API
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Michael Roth <michael.roth@amd.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tianfei zhang <tianfei.zhang@intel.com>, Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index cea41b8cdabe4..d7cef84750b33 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -89,7 +89,7 @@ static unsigned int nr_asids;
> >  static unsigned long *sev_asid_bitmap;
> >  static unsigned long *sev_reclaim_asid_bitmap;
> >
> > -static int snp_decommission_context(struct kvm *kvm);
> > +static int kvm_decommission_snp_context(struct kvm *kvm);
>
> Why the name change? It seems like it just makes the patch a bit harder
> to follow since there are two things going on.
>

KVM and ccp both seem to like to name their functions starting with
sev_ or snp_, and it's particularly hard to determine provenance.

snp_decommision_context and sev_snp_guest_decommission... which is
from where? It's weird to me.

> Thanks,
> Tom
>


-- 
-Dionna Glaze, PhD, CISSP, CCSP (she/her)


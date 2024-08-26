Return-Path: <linux-kernel+bounces-302208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B8895FB23
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E28B22F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F26828DC1;
	Mon, 26 Aug 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXQBwP4z"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4261991BA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706004; cv=none; b=b4myXs2dQi7DLVkKbqnuhoRdbZJ9u/rxC7bxad7ZhuaEKxai2bqvGuTpEEj0Jro+ZQV1FF1j/VF8rbRtT6yH6SEU5HVfRnY48NWrxQ/DgyIdWw0Uv4aFa4DHXe1NtLF9LaSzJuoCNg2i3zC5d8m6T1pT1FUY1y+cVAEqSd4WzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706004; c=relaxed/simple;
	bh=2ruOyogdIf90kRS5aDeFcltxiwdAst+Mnulv/TyjWw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iySQMS8uUMRn916z6D+17yMTu284l450ZHgq4B369ym3zdeQGBzyxYWTOmRa5C0kWB6fgDPkREjs3Hqm7NwYKqWAvGADD8TzFH+4oKPieHzBcLj5IUowSBnDHei5D5RJ3fT290izTs0cetbGXm+vhxG8IYDR/m/aeqT2+x2P/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXQBwP4z; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45029af1408so24621cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724706002; x=1725310802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVEfW6TQ0hNW6j7JrK27dAV6DKxhXDBh4IjSm2S6kp8=;
        b=YXQBwP4z3sjReWeYI8c95grJTM8Pg4Eh0Lx3scq1skH5ArbGNI99vj9nQ4x1WtOZN5
         RFdVHLYigEUm/AM6+WOLVJib83g9wLHB+8+Sxtlwkwwc77BbppfvlBeAzfeOcfZ3SHvh
         1L9nP1VZmwhOaRKiuLW7khHDrrgeT6QKIqAONX7WYqZaNODj8DDtVmIHOR2D3yGFdwYm
         T/iQVDbAszvdaR8lHWWEcygBcfUm718YORYYUK7pQ+XbBJGsN6WzTVr4KVTuY6/IK8qU
         xyOEjcIrT4vl2jclWv3J3HwGtUy56yICzzvgwONQvQWHpraoBZo3Gw3IARgq+qy/6pbr
         5Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706002; x=1725310802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVEfW6TQ0hNW6j7JrK27dAV6DKxhXDBh4IjSm2S6kp8=;
        b=tFYFQTuwL5mp/rN+uwRhAuXCXenIsbDc94RWBRnIOECi7UjSUoq/oOLPQixAzW4czb
         AFPwq5Kt8uCtXiDk7u7G/M0L/hhTGIrzeLIJuZuydpNT8iWRJuUV6TZqowE6z0gMQX3U
         VVT0VRi40wth9n6xwPfcsmNB23uiCCJ+Oja3kF0tQBrMfzkejSGnL3rhR2JVgI3TFT+U
         rdCXuP3QvuOyPmYcqflC2UQN9byYEQxTv6t3tn7oXfjfC47sgwnUW1Sgq4sjvY0cqAsn
         4wAJQl7pmElje6qwxXSvWLnlMgXVMYsuELwq5QKAs9B3sfSJgvqy2tZl7LLpcH4vTce3
         e4dA==
X-Forwarded-Encrypted: i=1; AJvYcCVCefnGHuwtmIiZiEERJylwP7CydADntR1sNILoMkGd0VheNASUpvB2ywOBSB3bU/TOcfYCzRXB2xiyw3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5/coZRv048i7mVW6csJ2+GS0zy6znuN5gYdPDfhk44qhYRWG
	yaXzTjmfalF+LzIXm21/lhayTBc82BNJAI30hPsH/mM1UNcAtW7cpZkfLarVQduUQJ+ybgfJA9p
	59pY24JTpY2opQhqfg7wbx1/Bxaw3fvjC2KB7
X-Google-Smtp-Source: AGHT+IFHV5LY4R0wuFIWWzaCqt+lYVB9gaZB5Srpu5shv4KRElf5kMj7ONS8iMGo9WDXlnq9aLqRuVYbZGS3AdE75N0=
X-Received: by 2002:a05:622a:5b97:b0:444:ccc5:f4c0 with SMTP id
 d75a77b69052e-4566321b920mr132841cf.15.1724706001629; Mon, 26 Aug 2024
 14:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823185323.2563194-1-jmattson@google.com> <20240823185323.2563194-2-jmattson@google.com>
 <20240826203308.litigvo6zomwapws@desk>
In-Reply-To: <20240826203308.litigvo6zomwapws@desk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 26 Aug 2024 13:59:50 -0700
Message-ID: <CALMp9eQ1tSQtmvF+7BVdpYto8KPN5jfad3o6XPnU9oVOrfxvjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] x86/cpufeatures: Clarify semantics of X86_FEATURE_IBPB
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Sandipan Das <sandipan.das@amd.com>, 
	Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 1:33=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Aug 23, 2024 at 11:53:10AM -0700, Jim Mattson wrote:
> > Since this synthetic feature bit is set on AMD CPUs that don't flush
> > the RSB on an IBPB, indicate as much in the comment, to avoid
> > potential confusion with the Intel IBPB semantics.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> > index dd4682857c12..cabd6b58e8ec 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -215,7 +215,7 @@
> >  #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE        ( 7*32+23) /* Dis=
able Speculative Store Bypass. */
> >  #define X86_FEATURE_LS_CFG_SSBD              ( 7*32+24)  /* AMD SSBD i=
mplementation via LS_CFG MSR */
> >  #define X86_FEATURE_IBRS             ( 7*32+25) /* "ibrs" Indirect Bra=
nch Restricted Speculation */
> > -#define X86_FEATURE_IBPB             ( 7*32+26) /* "ibpb" Indirect Bra=
nch Prediction Barrier */
> > +#define X86_FEATURE_IBPB             ( 7*32+26) /* "ibpb" Indirect Bra=
nch Prediction Barrier without RSB flush */
>
> I don't think the comment is accurate for Intel. Maybe you meant to modif=
y
> X86_FEATURE_AMD_IBPB?

It's perhaps a bit terse, but this is what I meant. Perhaps better
would be "without guaranteed RSB flush"?


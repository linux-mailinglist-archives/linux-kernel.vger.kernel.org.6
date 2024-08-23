Return-Path: <linux-kernel+bounces-299323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10495D2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4962128625E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752DA190470;
	Fri, 23 Aug 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiH6RCdi"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE718FDD0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429730; cv=none; b=Kg0DGHzzoP5zcB4/310ZKeBScZHeyKQHQEzZDdM8lf3Mkm9+ARGS8Oz0rzl/UskhRDi/q36B81Z/Txlu36zfyAVZnMyJzdwg4KXIQzkEJjMsuNAuXCmTg+T0HjRRR4vT8ZBH2rPIRr19pQpvAjbXkZJr5bGZC6epCdRuydqdZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429730; c=relaxed/simple;
	bh=2P7uVtwXEpn5LIYDIU7MVXXUFLgfOOcTHFPvSvzJGp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVWSHl1YomU5ZYvO4vwOvlFkXSQ+GrJZLK9f65Kj4/jHuaQy/c50pzoXsTAjL1DKQ120WgSHie1b3maqH3SuvHPkOPv7+Df23yoKRS/qHhRH9dn2rw83dOUkLHaldySz/Noy1Ln++pamuugnjO/S/W9uZTcp3kM5xCtkkFUsEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tiH6RCdi; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45029af1408so227121cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724429728; x=1725034528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzOUQahuaEVr/jXJXRfy3a5IurUuGUZUJtsvoKA2oNA=;
        b=tiH6RCdi2zADOYjmNUC20cXuH/YCDaLkB1bV6gbxAgiJiNz8itFDGzKCwYeZq0X5gG
         oCm3x0SqvUd8B+IUfp6AM5WlziZ3uKjRSRbFw4Dg18icBB0dawjfhnjFML8rMG1GFiJv
         UCAkmjsRIrYRRxfKr5C5FpFtI7hdsxdQh/CFV9/jwoLZU4pL3yD3zl/9PjzGxpcZeAMp
         Erwi+lgGRpt/RsM7nzntSmBQyNWON19IqMfPUUkkMfaQ0/j/HnUpefC+X39bbImM/LfU
         jjXRIZMELd+JSKW4NxTiTYT4o2APwwWGOd9Qbld2c03o+nK8dEcfZpuw7ltfaCl4kQr7
         sqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429728; x=1725034528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzOUQahuaEVr/jXJXRfy3a5IurUuGUZUJtsvoKA2oNA=;
        b=vNCrGfQicC0OE4Zw/zVozW2Xf8q0ktfwAmseaKgxzNVm077eR6pNVzBl2Clam90GWv
         gF3szQc254j4V058f6eE55AJgn/JDz8VPLnoU03UWfvaIneFMNX5Tc+9LTJrhpEqYDM8
         /KVSxEQkbi0BR6c4bi5qoe+6Xzen5vJ7yNBaqMbYvzs/PKvO0g9MvHWIuXxX+yyJtvQW
         i4kjEmpc1jLIfp6q4GtIP8I1GgtQC+SqcfQnUTe725JSiv+UeASx2x6+jvWSDNVe6fhQ
         yEsAPk6Y4N1bYfaTMVKhQoC1bHXI23kBQcDBZLYZW/hvg2WCY65c6l+6yyK5m+tTVPRN
         /hgw==
X-Forwarded-Encrypted: i=1; AJvYcCUNxQb2nqphQBTc0zRE0bP20bykzDKLj53Y/sTLltT4MCPp9kPe3H/W7CCZ248bgWSuBQ7Z1rLYqG9+FZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3k7w0744Ug7LCsUG7ijJ6cjz8XVcmpy3nYqmb2xp9TRjwljHb
	Rgd5CmJt9uCEVyi7rC4lZ1ffYYTvBRFe7qpsCgGp6+W1WhxhFyKMO+JZxtgduVCfAOdaAsRzkdk
	6ptvC5Nc1F7YljV1rxS7oSKLGK6FQLLjaXzKX
X-Google-Smtp-Source: AGHT+IFwIq85yyGGE9G+4sWB5N/KRrLxWGPbYJOS3NicOjmEjLDu3CdqjVnFODqsQZC2R43u3DHnI7ESG0FTyiBSk+o=
X-Received: by 2002:a05:622a:2b0c:b0:453:5f64:b6de with SMTP id
 d75a77b69052e-45509dc37admr2860731cf.5.1724429727750; Fri, 23 Aug 2024
 09:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723723470.git.kai.huang@intel.com> <20240819212156.166703-1-sagis@google.com>
 <29fba60b-b024-417c-86e2-d76a23aa4d6c@intel.com> <CAAhR5DEEsFNqdxbd62tGh9Cj7ZQMQs6fEjAKs6djkZzgZALOfw@mail.gmail.com>
 <f4b60d0e-bec7-45d0-bbdf-fb04362c863a@intel.com>
In-Reply-To: <f4b60d0e-bec7-45d0-bbdf-fb04362c863a@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 23 Aug 2024 11:15:15 -0500
Message-ID: <CAAhR5DFrOaXDbndFOSWAfdu-79buSR2ki_AU=z68FcHmn9o4Ow@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] TDX host: kexec() support
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "Hansen, Dave" <dave.hansen@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "luto@kernel.org" <luto@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:44=E2=80=AFPM Huang, Kai <kai.huang@intel.com> wr=
ote:
>
>
>
> On 20/08/2024 10:28 am, Sagi Shahar wrote:
> > On Mon, Aug 19, 2024 at 5:16=E2=80=AFPM Huang, Kai <kai.huang@intel.com=
> wrote:
> >>
> >>
> >>
> >> On 20/08/2024 9:21 am, Sagi Shahar wrote:
> >>>> Currently kexec() support and TDX host are muturally exclusive in th=
e
> >>>> Kconfig.  This series adds the TDX host kexec support so that they c=
an
> >>>> work together and can be enabled at the same time in the Kconfig.
> >>>
> >>> I tried testing the kexec functionality and noticed that the TDX modu=
le
> >>> fails initialization on the second kernel so you can't actually kexec
> >>> between 2 kernels that enable TDX. Is that the expected behavior? Are
> >>> there future patches to enable that functionality?
> >>>
> >>
> >> Thanks for testing!
> >>
> >> Yes this is the expected behaviour.  If the first kernel has enabled
> >> TDX, then the second kernel will fail to init TDX.  The reason the fir=
st
> >> SEAMCALL to initialize TDX module in the second kernel will fail due t=
o
> >> module having been initialized.
> >>
> >> However if the first kernel has not enabled TDX, the second kernel is
> >> able to enable it.
> >
> > Are there any plans to support both kernels being able to enable TDX
> > in the future? Either by changes to KVM or the TDX module?
>
> AFAICT we haven't received such requirement so far.  Let me double check
> internally and get back here.
>
> Btw, if we want to do this purely from software, changing KVM isn't the
> right thing to do.  We need to somehow pass key data structures managing
> TDX module to the second kernel, e.g., module status, locations of
> PAMTs.  And the second kernel needs to be modified to understand those,
> which means some old (second) kernels with TDX support may not be able
> to support this even if we add this to the kernel.

Would it be possible to tear down the tdx module and re-initialize it
on the next kernel? I don't think there's a requirement for the tdx
module data structures to remain intact during kexec but it could be
useful if tdx can be enabled on the new kernel.


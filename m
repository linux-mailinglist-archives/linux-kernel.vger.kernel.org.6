Return-Path: <linux-kernel+bounces-542994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8DAA4D05B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED721766CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725701D86F6;
	Tue,  4 Mar 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qArVyWMM"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C5A78F2B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048796; cv=none; b=Kyb1eMa/XJls1ZxQCXBQb6n7d2GHyE/hPk6BThSpGAqn/hUniCorjuZQf5wNGbFCaGVS7I2+ZHibme242choAIXUmf4rtbCZsGlEmkBgF01VsHDbqN1vfxBT5RtSW+y7oft/gAXQ9STzE+XIF+m1dOrYCV5SXuPDzi2zBhZZkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048796; c=relaxed/simple;
	bh=rkWPmAk7WVKWGqIACfOChkzLOcxrNPRKbBUUx4bSPOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddeNn5U5p6LLSipc9r6xTs0fMWoE1KiWewGWgluPwiHlc1WfRbV1/JAMcz9dRQBdrMqJ8OXpwZ842qKgdAqG2c4a49ves/x/lFu52BwsP7w/6sT0oJXvlOfCWG7zhy7KqseXBSarPbkmEMmRm2lyF2Qr/MPko/kzWgpfz9Ohl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qArVyWMM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22342c56242so72235ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741048795; x=1741653595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZZ6RWDnljKub/rNqmhOhGtUl9a9akOzeS+eKL/NSi8=;
        b=qArVyWMMKL8YstysnALLXFKe/gPNIrW4TqIFc7h10y1oBHcQpbcn02BCNoIYmgIhTV
         +zSu89EH96kFAL0/hN423fcHpmQ7Yhu16BMDsBq5lOA3iuFwIOZ7c7pgM0JXAiwzIPeh
         NiGrXZ4oxf53BwmotCbM9EBOEorWKnRGCfUtegitMV9pg5i4EYCvxi/EfcvEHo+rxT0d
         vqPtDKSaBFdIFq2Pjv/oOjjWf/rpAQLcfFzWNfVfBbqzqe0k1gvS5vDu6ngSkAkk8+Ys
         pVr9Ilt1PU4zr+b4kW2MxaKjNPrd+uSNdJBRpL+CrRMaqFpTKY8JUIId9Hels6ei85fq
         kTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048795; x=1741653595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZZ6RWDnljKub/rNqmhOhGtUl9a9akOzeS+eKL/NSi8=;
        b=rl+MI86J2lW906fJTjAeUDPAf9byr3VjefZuVYU4qvPYMv5kvSzX18fQQGo0xVS5HB
         BTV0prU/sAmdwhmq4hdReq6aUSsvCYHx6fh9l96BDc1EALp8GKMZOrFjvaWMtAMGIa3O
         gO23bka6S7bqpucxrKzSTBbCH14yNbCs5+pxV0FgHay0FxDScYrGmgjo+mX1ylYI5mxD
         D2DW1yCPthriuInF+rhxiCWfexY988YquWr5xWNdIzDTaBgQIYW0kEhB7O4jmoaLy9Iq
         CHf++YQVjaalsNwT4aUC+dmvys4uxJh9CmUoGmL2XejfVN8mcMJS2Rcd2309VmffpFMs
         XHlw==
X-Forwarded-Encrypted: i=1; AJvYcCX82dcWTvJWtSBusrhGiGE1Q7flkOwlulD+JSOii+6OCBwzTrYrM3v6h31hx0qHnrWE+154P4UG9TUZKyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPpmuu3mRaAt+wyK7haGZWg+ByIYARVUs7GLLatMg0UBXuOk1
	iUce/+JArF7hEMyZr21KFKe+lECFHjCDZPkiHHHoO29MVSbIgpspULwYT4CtqQ==
X-Gm-Gg: ASbGnctxTuU9WG2yzqwI9b9+z+0ZewWTcYFxN1CGDFDsuhOpJvZ2NE7t4tlXKK2l7zQ
	KXzDAKsCM7ZEOZqt1yE0dvbf7vTB+sCEfTP+t50/SjdpnFJE28FhEngQSt5xnoa0+na/fDN0pm4
	7xupVSeGpzWTtGFBwwwADqwxSaUvPsIh7GbMtnsMsKHpyq6ESKvJEPb1er983f1ycZL7STXkdUb
	2l9bxz3dDTz0KnGBTJZLF5MJ+nG8h+k+ktJbO1xe1+0Mb6dFhEJgtN48BvH++8kkRSJbteNOQmA
	BgdOIokIxWKcyEkLGAi+73B39VnxD1xjdgCyym8iWakXxsCYIFigDQwUuColSXp5Jqex2NIQvz/
	SB2aGwxM=
X-Google-Smtp-Source: AGHT+IEFZMvKPvqJtn6porx/jOyYtLyQRQGPPfM3zCCktwuBu79Q8Ew7WkeXkukdVZEY0NkgznAoKg==
X-Received: by 2002:a17:902:ea05:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-223d9e0df5cmr1199935ad.16.1741048794489;
        Mon, 03 Mar 2025 16:39:54 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee90c7e519sm6971619a12.61.2025.03.03.16.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:39:53 -0800 (PST)
Date: Tue, 4 Mar 2025 00:39:48 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 1/6] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z8ZL1L69z8XWm8vl@google.com>
References: <cover.1741046028.git.yepeilin@google.com>
 <b0042990da762f5f6082cb6028c0af6b2b228c54.1741046028.git.yepeilin@google.com>
 <CAADnVQKX+PoSUqPBB2+eZrR7wdq-8EVaMxy_Wur7g8wyy3Dcmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKX+PoSUqPBB2+eZrR7wdq-8EVaMxy_Wur7g8wyy3Dcmg@mail.gmail.com>

Hi Alexei,

On Mon, Mar 03, 2025 at 04:24:12PM -0800, Alexei Starovoitov wrote:
> >         switch (insn->imm) {
> > @@ -7780,6 +7813,24 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >         case BPF_XCHG:
> >         case BPF_CMPXCHG:
> >                 return check_atomic_rmw(env, insn);
> > +       case BPF_LOAD_ACQ:
> > +#ifndef CONFIG_64BIT
> > +               if (BPF_SIZE(insn->code) == BPF_DW) {
> > +                       verbose(env,
> > +                               "64-bit load-acquires are only supported on 64-bit arches\n");
> > +                       return -EOPNOTSUPP;
> > +               }
> > +#endif
> 
> Your earlier proposal of:
> if (BPF_SIZE(insn->code) == BPF_DW && BITS_PER_LONG != 64) {
> 
> was cleaner.
> Why did you pick ifndef ?

Likely overthinking, but I wanted to avoid this check at all for 64-bit
arches, so it's just a little bit faster.  Should I change it back to
checking BITS_PER_LONG ?

Thanks,
Peilin Ye



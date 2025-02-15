Return-Path: <linux-kernel+bounces-516038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1596BA36C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8041895AA7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 06:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9095A190685;
	Sat, 15 Feb 2025 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjwO2miR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034E156C5E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739600254; cv=none; b=P3+TGaseQEHdihCw0nK7yHPvy7c2F4nE3h2vuuJPrgkSi2FEw5g77iVtKd1ZoZlRSwL9N4SqjCcVt7HiAPtjG22Ib9Qx0XGv4vCzoXyZYOJ9x97f8tHm8bbDjVOVdOtuMX6hyo0CYdcFciSkxSRqXTsnGZd+D+TUGpMu4VZHFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739600254; c=relaxed/simple;
	bh=9pM4MZBrccRRjYXvKtvulV3cwNMSnWTBuYn+ZE0uDdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GggliXLvLNwHlAvUnQK4Gkun2UdaxKRCKwX/SbanC+q91HX7EOCDr3gU/77TanuZVrYa0VfMuZR8+NDleVqenhSgi5EDpu81br5/n2IEePJJ81LNE3/6GXUQqABhOc4cpqgRuiy/dQ4zJqo5UZcV1kgYpswdoz6e6LRDODiL+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjwO2miR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e0575f5bso81135ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739600253; x=1740205053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3AY5WU5lQWjVx2WV5S/fns2o9ZSTHNwmgBqh8WjXEwg=;
        b=fjwO2miRNPTw3s8nRiORXZftUpF8N6dUG2vpi64oTrFYa27x9CWq3lEPGY166XpGaU
         21Iq0+gf0z4A94p2BI3jksZNL9HI4e8VyHrEdB0BiGiLKRdwndTaSjtz9Na8AFH/Ik34
         h1PhlOuvnc1D6KNY0JSpKwQJqLDhN3f/nmKyMqGckpoiiMXgckODUmFez7CyAhi7baqe
         3j5Ouky/u5CHiNYwt9pkAwLOSfgpKv2xoipvFAR71ag2+tyvCpJ314fzpqq2uer6EGo8
         XVk+ZOd2UVZ8fyFLe3ASM5jLh0ueKiJZAA2S/u7CmLiHhgwX0/Jegxefc0qCqZ8r1+oT
         VAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739600253; x=1740205053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AY5WU5lQWjVx2WV5S/fns2o9ZSTHNwmgBqh8WjXEwg=;
        b=LLMPTfjlxsp1zsE8K+MGRZw03qcnSOrnvDyBF4eXQPX9kTo1GYXA9u9+cRGh3MtkCo
         MFKM1a3jYGDjeoWO9/hEF6+08d5dIspP+RqG3n+eyDkg5zeeDIVkAZq6tdxdcSQxM90I
         Ut1AblEyHvypJVP1B6JIvo2+nbBAwNycRWxy8AEHtfTRGqJDyG+uFfASu93rvBREsxwv
         DzOqrd46KBkj91tYcabNZSQa8OUXjYy3i3NjB/BbRtunGatodDCbtykrilePvoQUNe7R
         0zUw147Ck2Yz1MJ+cVwFbCD1r8JiFxZcPDMM3SiDcohLyHPyoSUBnc0miBPHnr2LVwq2
         fbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1YtSMd6aanNI0/upGKCu5CRkfDg1rCKj95ZRRr48QUf8jliqALyQUQLn8sed5Q+LTgXF/T39n7Lt5wic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQ1VLPyIeryDD3hW5ygTGzHl+gZO8GV3C4SYxEiAvVpBwo9Xm
	AhIoppnWtuQd+KHLK7IkwIwujzuek2UN2DnOo1KVRuo2ODScqCL0bd+/eP+8GA==
X-Gm-Gg: ASbGncsMWMRtYJB0s6Is5KPwXec6AzvFFZ0oKSMySucyufA/hMudSXSjhW9Yun9zUhJ
	oTPikwvQh3ZwTt2brv3Z1fHJ3jfcT+JKLWbvpDSFBQKgkesP6VF36FYdMRATeTcFgwbMRgbAqEQ
	cVUEMwS0KfOsEmRMAByv80/iRzi1/imthHFg/DFizJMaY9ECHwJP38mqNKVFJY8DabdwIqxoVuG
	0ipNqaVit+1NytMibeIpk3P4o+Ojvdp1Gv7YTELQvXgQtFfP6irdszW+67IJGk16u+yEcUjRwT1
	KzkBA8tMAxiFu6njQ0e2QPNsCcUMQy/Ot9CGJUDNVlr4hxY9bDkPGQ==
X-Google-Smtp-Source: AGHT+IG3gQqGGdGWUSbEL9fmOrHw9BsfZ57p5du2ldVLToKKJX9c4jY9plcbSAXbZCMwuUN119NPhw==
X-Received: by 2002:a17:903:94e:b0:21f:465d:c588 with SMTP id d9443c01a7336-22104c9385emr1243535ad.14.1739600252382;
        Fri, 14 Feb 2025 22:17:32 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e318sm4272875b3a.96.2025.02.14.22.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 22:17:29 -0800 (PST)
Date: Sat, 15 Feb 2025 06:17:21 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z7AxcSwD-topj1bk@google.com>
References: <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
 <Z6gRHDLfA7cjnlSn@google.com>
 <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>
 <Z6qC303CzfUMN8nV@google.com>
 <Z60dO2sV6VIVNE6t@google.com>
 <CAADnVQ+OyoBPOJk6dcUFozTt0RD-o-hHdR4Dgy+dK2r0uHyC7Q@mail.gmail.com>
 <Z63aX0Tv_zdw8LOQ@google.com>
 <Z6_9LgfOMeR18HGe@google.com>
 <CAADnVQKZ=pjXjyzB8tJj5Gen4odcj5H5JhXyRtVgphTEDCisTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKZ=pjXjyzB8tJj5Gen4odcj5H5JhXyRtVgphTEDCisTg@mail.gmail.com>

On Fri, Feb 14, 2025 at 07:04:13PM -0800, Alexei Starovoitov wrote:
> > > > How about:
> > > > #define BPF_LOAD_ACQ 2
> > > > #define BPF_STORE_REL 3
> > > >
> > > > and only use them with BPF_MOV like
> > > >
> > > > imm = BPF_MOV | BPF_LOAD_ACQ - is actual load acquire
> > > > imm = BPF_MOV | BPF_STORE_REL - release
> >
> > Based on everything discussed, should we proceed with the above
> > suggestion?  Specifically:
> >
> >   #define BPF_LD_ST     BPF_MOV /* 0xb0 */
> 
> The aliasing still bothers me.
> I hated doing it when going from cBPF to eBPF,
> but we only had 8-bit to work with.
> Here we have 32-bit.
> Aliases make disassemblers trickier, since value no longer
> translates to string as-is. It depends on the context.
> There is probably no use for BPF_MOV operation in atomic
> context, but by reusing BPF_ADD, BPF_XOR, etc in atomic
> we signed up ourselves for all of alu ops.

I see.

> That's why BPF_XCHG and BPF_CMPXCHG are outside
> of alu op range.
> 
> So my preference is to do:
> #define BPF_LOAD_ACQ 0x100
> #define BPF_STORE_REL 0x110
> #define BPF_CMPWAIT_RELAXED   0x120
>
> and keep growing it.
> We burn the first nibble, but so be it.

Got it!  In instruction-set.rst I'll make it clear that imm<0-3> must be
zero for load_acq/store_rel.

Cheers,
Peilin Ye



Return-Path: <linux-kernel+bounces-515974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ACDA36B74
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB0188ED98
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0917814A62A;
	Sat, 15 Feb 2025 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NydxG9L0"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC018052
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739586870; cv=none; b=Ooc/FrhVs5+54EowvdQ0bb40H+OA4gFuJpy4U3fx1g3bExj5RYVWkOUuNOiaiBMPG4wCKfAaVnl67vkRjyk1QPIri6F49uAoYcgAe4Ar6Yk2miVNvjLrlHgLXZjvN1ROc6tDi5bWmiWcqcAbm/HM07385cRSGg7zflRdU6BWmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739586870; c=relaxed/simple;
	bh=D5g2JjePT9Li3N4jsbj+c3j2Ctg1j9JVYh+ATXOYcaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7uMvIxAuS5ZFSl6fTgLJ7qKV9PRdncp69nQs0OzGQyAD1AA0IAzzByBSNtGiheakkgVu2BKPuCKGkNB47tNATLPqA4/76PS93VN35MA4+2NSk6wxijHnErZAPh1nllr8rnZnwDeTmvm2SAve94m48klmLU6YHaB3/9WyO0W42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NydxG9L0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e0575f5bso71015ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739586868; x=1740191668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AlsOGf7IVfiuJuWsz4rHg+FclrcKaAc+bMOJnywnodY=;
        b=NydxG9L0KI+A0c76fLFz1S/IVj1iRWpYh0YrTfakXTqRE1o90Ea4hcFDzsP/6b6dGl
         akSvU5v4+WKuN+ogn9jA3Z3YKZ4IZ4kR5Mx+5zldFrSI8Xe/PpZzItRvBS2x+k4MJW8d
         Rxr+pIcxt8ZSsoNq1sFHhsGg2h47ANsT1si6N03EOnSkW8wScDmewnpCNJ3LGbCiyCL1
         cg+FryibsL//JReEQpDw0fRGbLVbzex3nfSN5/BkCJN06vjCwpmYqY5DZ9QFYppoDUry
         aZAq48iUz9rOmgZ/JAF9elSpj7weFJIrxVhG+t9f+RTx7RKbPyXy6jAN+3q/FF7QV7Ws
         gGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739586868; x=1740191668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlsOGf7IVfiuJuWsz4rHg+FclrcKaAc+bMOJnywnodY=;
        b=NwiR8eqv3IOYkN32UOJC1QC26kZpzEeN602WzsOZ9vbzV548VqKT2HpxjI8OxN9EJI
         blgF3JDhtpBdXFrxImNfefRcHJ7UqZNPBiBfslWNvg0db3OjvsDN+7vqcmdywpXhkc7c
         d0yyM/94O0nGnIKJTT3TnmVE+53B/DuA3DSJjb/iEPAxGIhAxNmejA/0Wsuaty4YXZO+
         R4gsDem4a5zCEbOzLbhBbWexDPPgBwZq2oiQh3FOOIBuDTD1z/ybrKa/Y8tlha7/sPG9
         Es+E88XN89h/UUUiTO6hxgY9yyqGdt1K50d0blOVqOUb3M6RzRQVR4hCkIcwhOJBpHjK
         LVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUXmghZFGgEll5lmvss5aFLK6giQ0Mkf4KBoAyB/EKQI9wydX/XypTMK9aYsa1btGsGjft9bmgRBKB9N3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7uu1wp7RSaxHu4zUT3SUQB0m8Yus+G8vxlTTjwKRaY9VdrwC
	Gg2vHF2D2RbVyPQqURR5BAT6E4AHZFecyjlCGSo1u1U591+EeRWqUcLmR3f98Q==
X-Gm-Gg: ASbGncuxHgjFxfdXUm+20H9tx7ql9s0z9oRl4IGEt4qRiAWK7sH1T7FpFhsKsARJhtR
	HbRdEq00Drm+JCQ4hpJ7USz4O5g1M8wZONLZ2n3hhW02ksw4eM+zwQqhsF92nlAtj23k5JUnhAe
	KVhqvDsP2NYzXQuJ2JjZKPC89g7UiM0X9Ma9ag24zqprWs9XrhwAyoDpMQzcQrWyLJ4s2Za1ii4
	f9d/QHlM7JAHx7Uhi+ztwqVLYVCGaR//myfSDPZhSVEoGEjOoJloBs28rWTMrHdaWJewbMN/ewz
	o/qV484sBJR/Jv3hx7cbvH1xn8qoKaijMTOPqpd9DYb9AyEkvAvIHg==
X-Google-Smtp-Source: AGHT+IGfipWS3lePNyfw2OAnUDFzBPOd2RcLjMRS5BFNs2D/0kpSqL2ZxDnM8Wu4sQ+j1giPIanbUA==
X-Received: by 2002:a17:902:e883:b0:215:7152:36e4 with SMTP id d9443c01a7336-22106004f44mr574015ad.27.1739586867956;
        Fri, 14 Feb 2025 18:34:27 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d66fsm35562035ad.180.2025.02.14.18.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 18:34:27 -0800 (PST)
Date: Sat, 15 Feb 2025 02:34:22 +0000
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
Message-ID: <Z6_9LgfOMeR18HGe@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
 <Z6gRHDLfA7cjnlSn@google.com>
 <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>
 <Z6qC303CzfUMN8nV@google.com>
 <Z60dO2sV6VIVNE6t@google.com>
 <CAADnVQ+OyoBPOJk6dcUFozTt0RD-o-hHdR4Dgy+dK2r0uHyC7Q@mail.gmail.com>
 <Z63aX0Tv_zdw8LOQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z63aX0Tv_zdw8LOQ@google.com>

> On Wed, Feb 12, 2025 at 09:55:43PM -0800, Alexei Starovoitov wrote:
> > How about:
> > #define BPF_LOAD_ACQ 2
> > #define BPF_STORE_REL 3
> > 
> > and only use them with BPF_MOV like
> > 
> > imm = BPF_MOV | BPF_LOAD_ACQ - is actual load acquire
> > imm = BPF_MOV | BPF_STORE_REL - release

Based on everything discussed, should we proceed with the above
suggestion?  Specifically:

  #define BPF_LD_ST     BPF_MOV /* 0xb0 */

  #define BPF_LOAD_ACQ  0x2
  #define BPF_STORE_REL 0x3

(And document that BPF_LD_ST cannot be used together with BPF_FETCH.)
So that:

  1. We avoid "aliasing" with BPF_SUB or BPF_MUL at all.

  2. If we need to add cmpwait_relaxed, we can then expand imm<4-7> to
     e.g. imm<4-11> and do something similar to:

     XCHG             0x0e0 | FETCH
     CMPXCHG          0x0f0 | FETCH
    +CMPWAIT_RELAXED  0x100

     So that <asm/cmpxchg.h> operations can "stay together".

  3. In the hypothetical scenario where we need seq_cst loads/stores, we
     add new flags to imm<0-3>.

Though considering that:

  * BPF_FETCH doesn't apply to loads/stores, and
  * BPF_LOAD_ACQ and BPF_STORE_REL don't apply to RMW operatons
  * We only have 15 numbers for imm<0-3> flags

I do think it makes sense to define BPF_LOAD_ACQ and BPF_STORE_REL as 1
and 2 (instead of 2 and 3).  With proper documentation I believe it'll
be clear that load/store and RMW are separate categories, with different
ways of using imm<0-3> (or, different imm<0-3> "namespace"s).  That
said, I'm happy to do either 2 and 3, or 1 and 2.

I'll start making changes for v3 and the LLVM PR, according to the
description above (with BPF_LOAD_ACQ=2, BPF_STORE_REL=3).  Please advise
me of any further concerns.

Thanks,
Peilin Ye



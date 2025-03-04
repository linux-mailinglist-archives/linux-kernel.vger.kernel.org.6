Return-Path: <linux-kernel+bounces-543003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF3A4D066
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259BE172031
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A48B41AAC;
	Tue,  4 Mar 2025 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uX3BZD4P"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164586AAD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049374; cv=none; b=fTVgjlyuTDl+uASQrwLp4nMd3GjtN7PL9xac+dvYhq/EEDWlpVny1QYwtdMvX84Gzszp/auFslHDC1LJ5yBLoNgCkCr/dozsusCsQw8qTlhfRPkCGf31Sah/E6Kk7tL2PN4WkUb2mnx6RPleNNqQOZ8nT7he668JWbIGZeZHMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049374; c=relaxed/simple;
	bh=9Cuxea6jaAQ5Ccz4WBstSM7X3jXsIm1ctwUtsoe/RuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXvrFwS4uBVtkkw2Amypoae8Jz5yLZGhPxBFaLbSwIYCnYr7h5Gf4X5aFPwxJYZv4/vCyANqMSPLxoLN+N8yJQ2KHVqA73b96OXH/KbjlBcOX2FH7TW5XP3uAxekfw/y+IW41z7I7ZHI5PUqnJy3vQgvKiASk986sxwre8i/55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uX3BZD4P; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22342c56242so76325ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741049372; x=1741654172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoReuE6asGDfkwfGwhoKqE/8EGEbi/2qhNeBk7ffGnY=;
        b=uX3BZD4PtzWZYHao3IDsV9O5BsWr1uc+022nDgV7l6ceGDNQ0LtX1vZJOV7Jl3x+Qi
         QKq/cDCn7aSnWPfzln27VXK3/9ksmmsSyBrKbtOBLXQI1r7cvrss5cljoD8ADfmOJVYu
         VIJFvDuvZwkLIE4r2VAcdUuNNt5Z2/1z0LNFYqaochtxJodoWmTLPky9az2pFYq6xSNa
         PovtiLV9sQZvUpSHTKJ51GuGr8LsQS8FFy1hf4ktZ4PlKYqEUutOQ2xTWPt3UOpm5jp7
         MJ2e0NfhoidQ8cMMHPEt9SuuJHyuRwbkN7AGrYb4kMXtu+dKcn7GpOhnjBKRGdshm9Hj
         PhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741049372; x=1741654172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoReuE6asGDfkwfGwhoKqE/8EGEbi/2qhNeBk7ffGnY=;
        b=n4YX8qcp50EhwVqs3O13K6BGvXUjTGdOm/l0TBMuCXfTz0R01OT2Oldk0/zglN6UEw
         pVtFokA7YBUln1CSa61RiqzVDk20fqKaD4+Fe4bQ1rnSto7cJFUPj4VTpS3qFgOfR833
         N2mzdp+2bUkHuc7ctPuWqg1Fag2cmkTkL87xGvtL9RZMlm5nQY4P/cfzD6RxDJzRNk9U
         Mji5//2PFKscKuE927PG+EXdPXQwbVmKIyTj+OnM+nooPxiUspZ7XEwhPPKUQ3Q4JLaR
         NrmrEfIx0aWJywlGfiE3GstUtoQ0tv8nN92NABql97U6q3PodOOnAqJomtCCohs2l02E
         yw6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgB1IT5VjPDnZEJ8Nyg90XZaivgZYyfTzSCMyjWSc6cCt9NbRdKAjfzfcEWwCdSeyIKQxPsRNDLHphGNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzhVq1pRm86rz57oxchdbfVcchqSmBxdP7dISOPN9dgmxVkPt
	Kqa0PX69IfkR7/RZNO8BJcuJwF37/q/wdNjGIJ8T28wt3zFxhb023ICRyQWd0w==
X-Gm-Gg: ASbGncsZj1Ov7bWbkhfWPgpgHpd75xU+ndERDVobQbSta0YQGppELzUfMFljZLOl3zB
	cDVWPRvohtbXodtuOclw5RFzeAN4D6l/4+vqlVlw4W50PZau73duKjRxhOe+i3YdKXUe138QDCX
	yc5nsci9D1VsoVbAF4pZy5UnNkHRDWAmBWpfLW8fSSQC27Ox+zm283pSTcBKi08HcCy+OMnu9tH
	hvxe9eYrDVoZt4TKUXAeGNtNL9hrHv4gCAt6zHl4JVKJcJiZGJKe+nuLjjKvIPFu4UBbf7UC7YL
	f9be6bogmTWbs6/2lbnU9OW63Q0Vx5HwJOf/e8FzlEg5DBagU7BIN3N3p4HtqWxB+cjJK5uhYr7
	aGnNOFEk=
X-Google-Smtp-Source: AGHT+IEKJygGea3iGVQpLJ5KAZvsaHIEMaMbTiFzmDyQ9aOxx03XBE9WH6aGAXRtP8RfT71qOYfUXg==
X-Received: by 2002:a17:903:244f:b0:21f:2ded:bfa0 with SMTP id d9443c01a7336-223db43216emr594345ad.25.1741049371943;
        Mon, 03 Mar 2025 16:49:31 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2b85sm11728851a91.26.2025.03.03.16.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:49:31 -0800 (PST)
Date: Tue, 4 Mar 2025 00:49:26 +0000
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
Message-ID: <Z8ZOFuipuznnOD-7@google.com>
References: <cover.1741046028.git.yepeilin@google.com>
 <b0042990da762f5f6082cb6028c0af6b2b228c54.1741046028.git.yepeilin@google.com>
 <CAADnVQKX+PoSUqPBB2+eZrR7wdq-8EVaMxy_Wur7g8wyy3Dcmg@mail.gmail.com>
 <Z8ZL1L69z8XWm8vl@google.com>
 <CAADnVQKB-9q6fxcVPbd7Ee+QBH=_ySv2EyULkgFhv_n2i07L1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKB-9q6fxcVPbd7Ee+QBH=_ySv2EyULkgFhv_n2i07L1A@mail.gmail.com>

On Mon, Mar 03, 2025 at 04:45:45PM -0800, Alexei Starovoitov wrote:
> > > >         switch (insn->imm) {
> > > > @@ -7780,6 +7813,24 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
> > > >         case BPF_XCHG:
> > > >         case BPF_CMPXCHG:
> > > >                 return check_atomic_rmw(env, insn);
> > > > +       case BPF_LOAD_ACQ:
> > > > +#ifndef CONFIG_64BIT
> > > > +               if (BPF_SIZE(insn->code) == BPF_DW) {
> > > > +                       verbose(env,
> > > > +                               "64-bit load-acquires are only supported on 64-bit arches\n");
> > > > +                       return -EOPNOTSUPP;
> > > > +               }
> > > > +#endif
> > >
> > > Your earlier proposal of:
> > > if (BPF_SIZE(insn->code) == BPF_DW && BITS_PER_LONG != 64) {
> > >
> > > was cleaner.
> > > Why did you pick ifndef ?
> >
> > Likely overthinking, but I wanted to avoid this check at all for 64-bit
> > arches, so it's just a little bit faster.  Should I change it back to
> > checking BITS_PER_LONG ?
> 
> In general #ifdef in .c is the last resort.
> We avoid it when possible.

Got it.

> In core.c we probably cannot, but here we can.
> So yes. please respin.

Sure!

> I bet the compiler will produce the exact same code.

Thanks,
Peilin Ye



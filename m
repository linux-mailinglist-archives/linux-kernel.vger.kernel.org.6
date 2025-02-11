Return-Path: <linux-kernel+bounces-509986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C606A316E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF13A7DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE726263887;
	Tue, 11 Feb 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVeKMY2g"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2D265608
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307075; cv=none; b=L8lxySWFcxDav11+Riu5brKXZ+VmzQXlkToPOMYbOBh06xx3ZD9XsaPaSH2wNKiHpHUTsz2DnY3sk/Y4YiSB+O1LBkBtQmcAg7IwaTY7H/uva+YT2lx2JsxNVitSbqtZ6oJ3zhUZZBC04bBrldmhYQQVbTxO8rMEeqylip05xqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307075; c=relaxed/simple;
	bh=cN8hjohr4uZfGrxF/+5QGRtCwHHv05h3us0uD7VGO9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtsPlyurDSBoTVVCgZXE/OkB8bM4OJHU8iEbyZLBrdFLoHZ7lf6edPDrJVct25Sc2lMKmLGIs2x2palSkLLpPmpIsV8rOt584FCee+YbN9KvQnHr328wCDUlGzZrlMoTQ73tg4dXupx+FX2OHXaxmBLxg34SqodivppMor4EsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVeKMY2g; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f8c280472so925ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 12:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739307073; x=1739911873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cbp44K+2t2aI4JlVPc3K/t0BQ8ZOkIpiOPV8PBHdLU=;
        b=QVeKMY2ggy+pUOAvwXLYllgjqOD/MLCBnq5B/Iwa5F8UW+LIqGhM+BOPexvQ8lEZUk
         KKhEeoKqRYv5S9pM5RJ59VZPaQHwo216DGSw6Jc2ke1VCLjbyZTgrGlkDdrLlsWQPPhD
         Jy6+9Gz8XJhQjZizCuCy0t+sWyZ8OmjX6kM7/j+xRAwSfCgHAy7bJjh0iEq8JzgVsMKi
         CMlAMcERbpZM3p0OH0j5rg07Zn255YFE0ZWXliQ+/1LJ5K6a1Jg248ej0LhwG1UuxBNH
         99bGYhJ2y6uFTEt6vYKIkZfLxZ9JenySHlKtCPEwWDFjtb7yohUrf7EfW7JT5VyNWa/O
         LWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739307073; x=1739911873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cbp44K+2t2aI4JlVPc3K/t0BQ8ZOkIpiOPV8PBHdLU=;
        b=Ph/LKkf7attVyKCHVXl+2VfDyP4hdyr1aAi7om01h7ByQSq6VtS+oJHgaXHN2Kw073
         UiVR7qwDq+rqatxlW9bxjh294eAuk9ULcyNSBO7rKrFRYJRFujWZxH3xviv8QdYDI8WX
         rTuzLE8LekJv7CGabed0sh1lAeDUwnSn8OBxcNzDQNwY9elJFnY0RAp+fkT0hWQXnrL2
         vx9bZeQ/wy6jeDYhK/7++euAwXbfYUjNZz3ohMduB4BSWVow6aVZbf+nQIx3g79odeja
         RwLFGpZWrXUR361mW5pu8lMjpB0N42ohQ96hUXt4+rzCMqFtepN/EbhhCTNuJ/w2rbhj
         wuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzcBqSXszLcmXMfOlba0DwoC/piNO38ktAwMV1RMzfcmliSj7iCuN7IfgK21DLIo3WnHgcgdGTVRI5Jxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMX2cDSj/ISSzk+1WOn37HkS0LPyNyBE/7ZxWuxW8Tizhadef
	jR+6U7PeI2eYNQTGsyU65+x51jlm54idsmhbzRRn8/lGOC9oWFTUvYBc8hOcbw==
X-Gm-Gg: ASbGnct03AaMmEH4OApIgzi8QXKcSF+NcfrY5gUWERSgiFjcbsYCRuROFtEFTVeXjNk
	N2d/1/zl9uTkH4ePX8iVJWlNB8+6DXP4ELvh5s2JOH7xRVz33WvmN60BZuVPBnpiFL40sKl+AB2
	Pchc4NZz7Qpp5o+OkBBovxKtb8scjrd4FBVLHL3aqcSfqnEbC3WS6o2pWTz3Yz/NC5eaj562Gaa
	S6diQf54TQqBN0MLBOrMxFJ47l5bi9IPvWx5z+s8hY7na1wZ48fscL0kn8GSKvhozy6z6J3P8cK
	QQXm5AKETWLTyBBsMjc3b+kQvktj3NWx4UTN+W61hMysTFDab0r4AA==
X-Google-Smtp-Source: AGHT+IEoYw6Xy6tdvQD2RuJDCstg+zNrGFKyrdHcKRTwJeauQbld+07Eum8Nx/l1zp9xSJyZ06hmGQ==
X-Received: by 2002:a17:903:1013:b0:216:6ecd:8950 with SMTP id d9443c01a7336-220bcea1c92mr355775ad.19.1739307072784;
        Tue, 11 Feb 2025 12:51:12 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3ff14a28sm7543706a91.14.2025.02.11.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:51:12 -0800 (PST)
Date: Tue, 11 Feb 2025 20:51:07 +0000
From: Peilin Ye <yepeilin@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
	Xu Kuohai <xukuohai@huaweicloud.com>,
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
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 8/9] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
Message-ID: <Z6u4O930eIbAVVMZ@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
 <6976077bc2d417169a437bc582a72defd1dec3d4.camel@gmail.com>
 <Z6ugQ1bd0opoGRYg@google.com>
 <1d2d919ae6848e2cf80b81ffe5f94fd31b8ea6ae.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2d919ae6848e2cf80b81ffe5f94fd31b8ea6ae.camel@gmail.com>

On Tue, Feb 11, 2025 at 12:15:25PM -0800, Eduard Zingerman wrote:
> > > Nit: why is dummy_test() necessary?
> > 
> > It's just to make it clear when these tests are (effectively) skipped.
> > Otherwise, e.g. -cpuv4 runner with LLVM-18 on x86-64 would give:
> > 
> >   #518     verifier_load_acquire:OK
> > 
> > With dummy_test(), we would see:
> > 
> > (FWIW, for v3 I'm planning to change __description() to the following,
> > since new tests no longer depend on __BPF_FEATURE_LOAD_ACQ_STORE_REL.)
> > 
> >   #518/1   verifier_load_acquire/Clang version < 18, or JIT does not support load-acquire; use a dummy test:OK
> >   #518     verifier_load_acquire:OK
> > 
> > Commit 147c8f4470ee ("selftests/bpf: Add unit tests for new
> > sign-extension load insns") did similar thing in verifier_ldsx.c.
> 
> I see, thank you for explaining.
> We do have a concept of skipped tests in the test-suite,
> but it is implemented by calling test__skip() from the prog_tests/<smth>.c.
> This would translate as something like below in prog_tests/verifier.c:
> 
> 	void test_verifier_store_release(void) {
> 	#if defined(ENABLE_ATOMICS_TESTS) && defined(__TARGET_ARCH_arm64)
> 		RUN(verifier_store_release);
> 	#else
> 		test__skip()
> 	#endif
> 	}

> The number of tests skipped is printed after tests execution.

Sounds nice!

> Up to you if you'd like to change it like that or not.

I'll do that in v3, thanks for the suggestion.

Peilin Ye



Return-Path: <linux-kernel+bounces-547980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77FFA53E69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB90C188A416
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595902063F1;
	Wed,  5 Mar 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJCQM3Cu"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194451FCD07
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217235; cv=none; b=VXRS/w7XkMBV7OK9N1SyNRSNIxLyUo3TBEjcS6PN9l8zib5G8iHfkSDcEQ9K/cAvB2eb7Qh0Pg+jfkhel3IXBQ62+Xc5pd1aEDy2FrG52XbsArE/m7GIbAbuQ+Rl/58PjM67hVkUu/J989NidqYWNxvEH28YEgwijAn7EsYVJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217235; c=relaxed/simple;
	bh=kQ4hezEE5TmAsqk2WAkK9xJajndCWQ5kOHlA8k+VDEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dak453UgPlgA6dW6tOPeP4LD7n2ppWcMVA7qyRSZI/Tm/Um5E5VOCJ1oPIUuXjM7LwSCtm3H31ln8sQNyYeefnQZMg650nleoQu3iSm2T03ZJgKODEr0LjDXBx0i8j+is145wApcj1ZSegY07227PX44D9Nmxhg8OW529dYnxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJCQM3Cu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2237a32c03aso26735ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 15:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741217233; x=1741822033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b78GvVu0xnWmLt5AL+u6OyUDxJQRRkmBPD2yBcWIHCQ=;
        b=aJCQM3Cul8Vit37NXiDwsaGK4g+hiizmUqNFsRGbR5soATwz2zx6mB5AuGcFkJ3l+E
         Op9tEUzDZ5DKXBuqzMEsE2kodi44pkMDBOreCHdu8BCbnl/331b5pzO31BhpkOAUozVa
         GACQn6vw/ZPBIbbk2NM5yy3n+nH4cL+72e2VUoFGTRA8sau7ElZdtteiq2aROJVHnkLg
         4vic7DbQ3qvCKgZcCVVtxw7iicXWMbOfDPs9KT/y8D5Q5NIVxcyGzqNT2qFR45jtsiM1
         xVSibz0IC6eFd9bMZ2+MxoCgEJVypp+A/JG6WWVT3AzyfhZIcCNWXyxuNai4psG+xmDr
         9ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217233; x=1741822033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b78GvVu0xnWmLt5AL+u6OyUDxJQRRkmBPD2yBcWIHCQ=;
        b=oHu49sFR+Vc4bzxPO0niJoCmz3+NQ5cP7cgkY5w8dI3XCfctTKHsdb5K6S7PzsKjoJ
         W71AMfMNObbv7mI5YK4YrJVRZpcjM/EPG3Acbev7Y3ej4gPZ03IuaVPyqEJpS5+CiazB
         3RbamLPJVp8DdQFK3QUaL57sLtyGtmSpHgV4aNRqGOqV8/3qVr0uZVg/juzsY5Zd7MwG
         pDBoFHjiYB2K/hRoa6vh8VPEgSHsukzgBYDl+/3MIuCWFgZggpSbj7f9eninSKF9qrcz
         52KRbSa5TYOwfxmPo8OyefUnEL8MYbn5kXbXr/GrKsQVu9p+NARfc3RYXA1+2a9fDsxQ
         6Osw==
X-Forwarded-Encrypted: i=1; AJvYcCUV3DUHzvzsHSEF5frUeCnI1qTitan0hycvKiF6j6p3hCDAxyCXjyCckK97VqnI5l3LekCWASvpk0FnFbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHsx1oHP+gRVz0Y0QoWHEKUS6Bcp3BxMVsSEtHt3KCChTa+hr
	XOjUHLvM/AVr/I6ve0o+EtM03J1xBBw4y93Fanrj7/t3MsXk0sxHJvYehvyL7sTeziequYNmiKR
	TG50NoW5zgLqUoVBU3iJN2iSDXZNIs3RTgljp
X-Gm-Gg: ASbGnctj0BAuGyJIKy4drztWfRkfg5yD1c65HFxLdbvTwXA6g4Q2FgdHK9SvN+3Z//X
	rNJ3N7SJIQ9lcJQBXB09OR2g5bDBMUqkcjdFefCxqIMOzMRvUFuP3SAYNMhEzmNERqGPwtOGtn2
	zlItS+SL6wMxwPvFawOUas9Y5bfIawz/3fkWt8THg1mciZYrw5+FebxGk=
X-Google-Smtp-Source: AGHT+IG8+qBUF66j4mvD54ub1vH2+W8LJGgI3MhpKV5V/6Im8HW7QSvd8RmanFmCncVmiSzxslxDSfFOcNRK8sP7sTc=
X-Received: by 2002:a17:902:dad0:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-2240ab17780mr985015ad.22.1741217233070; Wed, 05 Mar 2025
 15:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303173807.1765098-1-namhyung@kernel.org>
In-Reply-To: <20250303173807.1765098-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 15:27:02 -0800
X-Gm-Features: AQ5f1JoNnrdbH7QlMsVMLKh1Na0Oad3qbsV_KKA7XclbkzZq4q2jW4wlZ-HBeDM
Message-ID: <CAP-5=fX5CYk__B=QuP8nUXUMxq765v-1ee+apxiGurOrxp87dw@mail.gmail.com>
Subject: Re: [PATCHSET 0/7] perf annotate: Add --code-with-type option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> There are roughly two modes in the perf annotate.  One is normal code
> anootation and the other is data type annotation.  I'm proposing a new

nit: s/anootation/annotation/

> way to combine the code and data annotation together.
>
> With this option, "# data-type: <name> [offset (field)]" part will be
> adeded when it found a data type for the given instruction.  This is

nit: s/adeded/added/

> for every instruction in the function regardless whether it has a
> sample or not.
>
> This will be useful to understand function level data access patterns.
> Currently it only works with --stdio, but I can add it to TUI later.
>
> Here's an example output.

At some point I think we might as well have our own disassembler. The
annotations remind me of the relocation and other annotation output of
objdump.

>   $ perf annotate --code-with-type --stdio
>   ...
>  Percent |      Source code & Disassembly of elf for cpu/mem-loads,ldlat=
=3D30/P (4 samples, percent: local period)
>   -----------------------------------------------------------------------=
-----------------------------------------
>            : 0                0xffffffff81bb7060 <__schedule>:
>       0.00 :   ffffffff81bb7060:        pushq   %rbp              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb7061:        movq    %rsp, %rbp
>       0.00 :   ffffffff81bb7064:        pushq   %r15              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb7066:        pushq   %r14              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb7068:        pushq   %r13              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb706a:        pushq   %r12              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb706c:        pushq   %rbx              # data-=
type: (stack operation)

data-type: looks a bit weird here. I wonder if the
.cfi_offset/.cfi_restore could  make this information richer, maybe:
       0.00 :   ffffffff81bb7060:        pushq   %rbp              #
*(frame-16) =3D caller rbp
       0.00 :   ffffffff81bb7061:        movq    %rsp, %rbp
       0.00 :   ffffffff81bb7064:        pushq   %r15              #
*(frame-24) =3D caller r15

>       0.00 :   ffffffff81bb706d:        movq    $0x33180, %rbx
>       0.00 :   ffffffff81bb7074:        movq    %rbx, %r12
>       0.00 :   ffffffff81bb7077:        subq    $0x38, %rsp
>       0.00 :   ffffffff81bb707b:        movl    %edi, -0x5c(%rbp)        =
 # data-type: unsigned int +0
>       0.00 :   ffffffff81bb707e:        movq    %gs:0x28, %rax           =
 # data-type: (stack canary)
>       0.00 :   ffffffff81bb7087:        movq    %rax, -0x30(%rbp)        =
 # data-type: (stack canary)
>       0.00 :   ffffffff81bb708b:        xorl    %eax, %eax
>       0.00 :   ffffffff81bb708d:        movq    $0x0, -0x58(%rbp)        =
 # data-type: struct rq_flags +0 (flags)
>       0.00 :   ffffffff81bb7095:        movq    $0x0, -0x50(%rbp)        =
 # data-type: struct rq_flags +0x8 (clock_update_flags)
>       0.00 :   ffffffff81bb709d:        callq   0xffffffff81baa100 <debug=
_smp_processor_id>               # data-type: (stack operation)
>       0.00 :   ffffffff81bb70a2:        cltq
>       0.00 :   ffffffff81bb70a4:        addq    -0x7dcf0500(,%rax,8), %r1=
2                # data-type: long unsigned int[] +0
>       0.00 :   ffffffff81bb70ac:        movq    0x960(%r12), %r13        =
 # data-type: struct rq +0x960 (curr)
>       0.00 :   ffffffff81bb70b4:        movq    0x20(%r13), %rax         =
 # data-type: struct task_struct +0x20 (stack)
>       0.00 :   ffffffff81bb70b8:        cmpq    $0x57ac6e9d, (%rax)
>       0.00 :   ffffffff81bb70bf:        jne     0xffffffff81bb7bca <__sch=
edule+0xb6a>
>       0.00 :   ffffffff81bb70c5:        movl    %gs:0x7e47b87c(%rip), %ea=
x  # 0x32948 <pcpu_hot+0x8>              # data-type: struct pcpu_hot +0x8 =
(preempt_count)

The variable name in the struct is really nice, it is a shame the same
information gets repeated a few times on the line.

Thanks,
Ian

>       0.00 :   ffffffff81bb70cc:        andl    $0x7fffffff, %eax
>       0.00 :   ffffffff81bb70d1:        cmpl    $0x1, %eax
>       0.00 :   ffffffff81bb70d4:        jne     0xffffffff81bb79de <__sch=
edule+0x97e>
>       0.00 :   ffffffff81bb70da:        nopl    (%rax,%rax)
>       0.00 :   ffffffff81bb70df:        cmpl    $0x2, 0xe86b3a(%rip)  # 0=
xffffffff82a3dc20 <prof_on>              # data-type: int +0
>       0.00 :   ffffffff81bb70e6:        movq    0x8(%rbp), %rsi
>       0.00 :   ffffffff81bb70ea:        je      0xffffffff81bb7a0b <__sch=
edule+0x9ab>
>       0.00 :   ffffffff81bb70f0:        nopl    (%rax,%rax)
>       0.00 :   ffffffff81bb70f5:        nop
>       ...
>
> The code is also available at 'perf/annotate-code-data-v1' branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (7):
>   perf annotate-data: Add annotated_data_type__get_member_name()
>   perf annotate: Remove unused len parameter from
>     annotation_line__print()
>   perf annotate: Pass annotation_options to annotation_line__print()
>   perf annotate: Pass hist_entry to annotate functions
>   perf annotate: Factor out __hist_entry__get_data_type()
>   perf annotate: Implement code + data type annotation
>   perf annotate: Add --code-with-type option.
>
>  tools/perf/Documentation/perf-annotate.txt |   4 +
>  tools/perf/builtin-annotate.c              |  19 +-
>  tools/perf/builtin-top.c                   |   2 +-
>  tools/perf/util/annotate-data.c            |  34 +++
>  tools/perf/util/annotate-data.h            |   3 +
>  tools/perf/util/annotate.c                 | 267 +++++++++++++--------
>  tools/perf/util/annotate.h                 |   8 +-
>  tools/perf/util/sort.c                     |  39 +--
>  8 files changed, 236 insertions(+), 140 deletions(-)
>
> --
> 2.48.1.711.g2feabab25a-goog
>


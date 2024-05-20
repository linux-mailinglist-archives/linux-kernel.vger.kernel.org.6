Return-Path: <linux-kernel+bounces-184284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0605A8CA4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559C7B21978
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92F4501B;
	Mon, 20 May 2024 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3wd4++dZ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506C45BE7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246181; cv=none; b=rguTfd1sv1ekSI/VMbEBlge1k9whLcXL+O1BMvjZexMxW90iLRvjfWGzkENNbjoSQEVhrByl9hmHWMrlAlc449umJhgahH0nVBnrsQeX85IkREyF2M8o3GpPjJ+L9qHb2um8Tz0c0nyaR5WYXBAsW+I5Kp7Fft+7rByPhQ8PDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246181; c=relaxed/simple;
	bh=YYCn5DU0BRg86YcFP1gvZ12Pp9o7w1dKSDgFLl47yi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awpe3O3FC0nSYjxqHws9Jo3byA+KriJYPaXSTNbJ9RsiugujVAz3U6wvsdzvPHeeztJ/lBbIkizd+vYzyCEz+ce8YYr+wZqK5VgXqrhLtwnpzv8AEAQf7Vo7EQJjmLUBwWd9+5e3+NWi+HNeigBgBeJH0EV+KKKHs2nZCzTbkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3wd4++dZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-351ae94323aso2393288f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716246178; x=1716850978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnBN2AJ+C4r+I3b8Px2gKwiIz+2UCq076e9/dAr3Nlc=;
        b=3wd4++dZyHbukCUXZwgTPVdfDsG8fDLvrcSopkIj6Me+GGfdj/7Hjls6dAlJx+2gK8
         gdeQYJRUEUcq9/2UzlkvYag6qWrBQgwAULIlhCOUB+cWZuOp2aU/JyVq9y+bpCOCzDmB
         AupAmx3PSyhbYgV0tyZ1dg9HapqoTpjH7dNQDj3SEOGnlPHTh7QzIGClMpyshvh72uaT
         kWDHdZhdVw7hzIxJC7r9d84OeMjb8hJmyuTbfY4bvFp860x4sdhQEPRALk+OxjLWXeOM
         2gRRHiExbehgyXNp2Oa/IOycHXKRlNu3UX7JcL95pW04eCoJnctHIc3YVvs9d3xg8/5p
         bjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716246178; x=1716850978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnBN2AJ+C4r+I3b8Px2gKwiIz+2UCq076e9/dAr3Nlc=;
        b=ZO6Q47E2ulv5oOdOs3JGrtqs3WxIoKpvOO5iEf4o56g+P62Mi1x2ePRP0yPHJe+1bc
         DinjvUZSU2r6CFFau1HLlMWnQf2TNfnbJ2Ms9NB0vgE/JvDOqbYqENdvM0w6nSjO5tRG
         ArYqOPzD0fIwUb2d7fW811U6fMfskp/6n7oU7E3BtlrjupFjaiEaXm6Lc6HGfJqE2wxb
         FRR/5LtZRZX4Nk9XGBZRVwjv9Se5gGy/SZRmTgUYXX/w/Gy0HmTJV4/gZm3ybyk6TJII
         TjcqphDQrNhq8XSJN5pQo0ZRzzXNdZ/7GfoBJxHWBOgFcRjRfiUc2Y6sN4QiroCOFoZ4
         IKUg==
X-Forwarded-Encrypted: i=1; AJvYcCWy5LWm5YmtKfE4ZXI/gyfVMifUGQe5ov84NqK9R6/odb3qJ+COOaQzZNLHT7SmKCkoSET6CqISvOabIbkeNuNYP4tY+hxCn6Rtlpgs
X-Gm-Message-State: AOJu0Yy05C0wqWLQAETghAbviqnjAMO+cYp3j/jCZl/bDohiXyB3tgjh
	bZ+UGd2yVfn2strkpv+iX7B6YOTpwy6DizeL47SuAtyZuazjv56OZrqEEg4FDJL3DyENqAfvLdF
	xet9RA5xkO6tX0FvkOKs88U12kRkO/TRZNCjC
X-Google-Smtp-Source: AGHT+IG4cEEKUkzo/+CBd+YpcfA7ZHQM2JEsNWhdsouLB+NgevotUCG5aMQE/0G3uNB4T/otNQFC6GRKTsRtoO0t8u8=
X-Received: by 2002:a5d:6190:0:b0:34d:bab1:26eb with SMTP id
 ffacd0b85a97d-3504aa62e31mr20183750f8f.68.1716246177862; Mon, 20 May 2024
 16:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520225149.5517-1-ivan@cloudflare.com>
In-Reply-To: <20240520225149.5517-1-ivan@cloudflare.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 20 May 2024 16:02:43 -0700
Message-ID: <CAKwvOdk+K=Ne8APreZWU0DxRkLq6aiKUXiX6v_hJJ5sug0cQAw@mail.gmail.com>
Subject: Re: [PATCH] bpftool: un-const bpf_func_info to fix it for llvm 17 and newer
To: Ivan Babrou <ivan@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Quentin Monnet <quentin@isovalent.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Raman Shukhau <ramasha@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 3:52=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> LLVM 17 started treating const structs as constants:
>
> * https://github.com/llvm/llvm-project/commit/0b2d5b967d98
>
> Combined with pointer laundering via ptr_to_u64, which takes a const ptr,
> but in reality treats the underlying memory as mutable, this makes clang
> always pass zero to btf__type_by_id, which breaks full name resolution.
>
> Disassembly before (LLVM 16) and after (LLVM 17):
>
>     -    8b 75 cc                 mov    -0x34(%rbp),%esi
>     -    e8 47 8d 02 00           call   3f5b0 <btf__type_by_id>
>     +    31 f6                    xor    %esi,%esi
>     +    e8 a9 8c 02 00           call   3f510 <btf__type_by_id>
>
> It's a bigger project to fix this properly (and a question whether LLVM
> itself should detect this), but for right now let's just fix bpftool.

Right, looks like we don't currently have UBSan instrumentation for "I
modified an object declared const."  Instead, it just leads to fun
bugs like "why was my write elided" or in this case "why did my
constant folding change between compiler versions?"  Such are the joys
of UB.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> For more information, see this thread in bpf mailing list:
>
> * https://lore.kernel.org/bpf/CABWYdi0ymezpYsQsPv7qzpx2fWuTkoD1-wG1eT-9x-=
TSREFrQg@mail.gmail.com/T/
>
> Fixes: b662000aff84 ("bpftool: Adding support for BTF program names")
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> ---
>  tools/bpf/bpftool/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index cc6e6aae2447..6d8bbc3ec603 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -338,7 +338,7 @@ void get_prog_full_name(const struct bpf_prog_info *p=
rog_info, int prog_fd,
>  {
>         const char *prog_name =3D prog_info->name;
>         const struct btf_type *func_type;
> -       const struct bpf_func_info finfo =3D {};
> +       struct bpf_func_info finfo =3D {};
>         struct bpf_prog_info info =3D {};
>         __u32 info_len =3D sizeof(info);
>         struct btf *prog_btf =3D NULL;
> --
> 2.44.0
>


--=20
Thanks,
~Nick Desaulniers


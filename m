Return-Path: <linux-kernel+bounces-411622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1316A9CFCEE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0E3287EEA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62321922E7;
	Sat, 16 Nov 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="cGSemp/Z"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8930219FF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731739818; cv=none; b=QnEiAlZa4MbUHd/h+/iQGxbCvycDPw7mYp6EIvt0apO5bIIurfAnxQddlELILReM706efcBcI6N2wRko2a6v0wUIAtuMUcxcLZUuNmriWWO5/qCI4ws7UU+VlCCDqcQSC/aUySD+DRRBH156Y/aVVSHf8R47ZgYWazlJeiixjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731739818; c=relaxed/simple;
	bh=/P6tzQ3jCbU4ozrnMlYolzSCUtUa5M0iUS4CiRbpWEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbySBXyUB6nXlHqQU4Sq0/WtuO70hOzEBHFymd1owHsYJEkJZXIjj+Rz1k21AAkNpYzoWWDrm3TulBoHbruvdzzri5wXOW5Sqcd/K8vBA5up4pJuR3eKb5YfjM9Cdgc5L7h+0vnRc/z9+YACij7x6zwkqrMCMui9ugOera2Cp9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=cGSemp/Z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so248890b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 22:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1731739816; x=1732344616; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c4VBGS9p3/wEN8k1kiifz4J5yc3uB+1rJ8EImtBi29I=;
        b=cGSemp/ZYlvQkmiX94i62RMy9cxaqc8GHakHZ5ZhTtMgF4Ps/BkGz94azoT9sOQKMU
         oNrI6Ta6J+kXETeGf0L5RHD/LlOb6DJCx7FLHJ2zjLLIu+/f4+lQFAKgedfRRYKworCG
         C4PcJwt80VsB7Nl+rYQUBChyrSJbloubFwtQqcDmppbSV3ur51ZAwzX+JAW8ToVb8DfJ
         s3lgZGvnQHhYyUVnj9pqOaLzlVSU3riK6rdjgWAjA/R9FIRDQnRwUBo6eXWHTJnreHhX
         VQ5cUaUNAU3AvI5FQHas5wtXocfkigUF/92ErhAt5BoV0Cv3VrrknR2PTLaJ8MOaLby1
         P/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731739816; x=1732344616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4VBGS9p3/wEN8k1kiifz4J5yc3uB+1rJ8EImtBi29I=;
        b=tgJT5JcccBct1GPuOV/EqG/fOh+CakasbT4J+VkcObefx92evEX/C9LTahoK1VY8mA
         cNzKX5+tb66Oew9KExDmh/DPU6AzpH2NZ6nx+x1EdvA1mrnJTcsSbMOQtNuL7jZb0SwC
         nghpemYYk4x3V9U5Da9oV3K3yuEGi4MY17ClZAfXcxw5b/xTX6LfJVf+E+btNPHppodH
         37iomae/SCutzBk5FMIh7G+mfZ5rbyqW3ZNlutOb1xdMsp53jURttAENZNt7BHrVjXYO
         WzIbHxOpnniqifP2veH3GEs0yoQq+Fewi9ztm0iGFmd7so8XcQViOfUIS4kpDj100lyH
         +5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCULQ9wcDRCKEPzRnJT2xL47UD2lCOJsD5q+F4xeEiGtBUQmvZHtnT20zytae9tUNeDGnoYbbMtvmgJdR9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlOfDjAhcFu/a5Mn8ZS3JQc7iOZu9yRQKmxQN6Inr6bUTm/QZS
	9zItv5EdiiZ0b2KLdCevNXhTOZ3lIFWp96OlcodsEI0REhv6l4hVZ9SL3HKJ8vU=
X-Google-Smtp-Source: AGHT+IGPPuhjLcU/A66YDv5cAy1wTsRTnc6IZLLAYcTu3EDd6cNPf+3YTAmY1wso/rfgQDwMYtkRCw==
X-Received: by 2002:a05:6a00:3a18:b0:724:680d:d12c with SMTP id d2e1a72fcca58-72476bbab62mr7233301b3a.12.1731739816057;
        Fri, 15 Nov 2024 22:50:16 -0800 (PST)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0d43sm2444873b3a.114.2024.11.15.22.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 22:50:15 -0800 (PST)
Date: Sat, 16 Nov 2024 15:49:50 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] libbpf: Change hash_combine parameters from long to
 __u32
Message-ID: <ZzhAjkELitX3byqR@sidongui-MacBookPro.local>
References: <20241115103422.55040-1-sidong.yang@furiosa.ai>
 <CAEf4BzYape9gtc7k1NQMD5BrfakzDXV_9SHNqZeamcaSKn744Q@mail.gmail.com>
 <Zzfo8YCeNkbCQDTg@sidongui-MacBookPro.local>
 <42a9055c-0bca-4bc6-acbf-f177de1ba2d3@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42a9055c-0bca-4bc6-acbf-f177de1ba2d3@linux.dev>

On Fri, Nov 15, 2024 at 08:39:05PM -0800, Yonghong Song wrote:
> 
> 
> 
> On 11/15/24 4:36 PM, Sidong Yang wrote:
> > On Fri, Nov 15, 2024 at 11:57:24AM -0800, Andrii Nakryiko wrote:
> > > On Fri, Nov 15, 2024 at 2:51 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > > > The hash_combine() could be trapped when compiled with sanitizer like "zig cc".
> > > > This patch changes parameters to __u32 to fix it.
> > > Can you please elaborate? What exactly are you fixing? "Undefined"
> > > signed integer overflow? I can consider changing long to unsigned
> > > long, but I don't think we should downgrade from long all the way to
> > > 32-bit u32. I'd rather keep all those 64 bits for hash.
> > Hi, Andrii.
> > 
> > Actually I'm using libbpf-rs with maturin build that makes python package for
> > rust. It seems that it uses zig cc for cross compilation. It compiles libbpf
> > like this command.
> > 
> > CC="zig cc" make CFLAGS="-fsanitize-trap"
> > 
> > And hash_combine's result is like below.
> > 
> > 0000000000063860 <hash_combine>:
> >     63860:       55                      push   %rbp
> >     63861:       48 89 e5                mov    %rsp,%rbp
> >     63864:       48 89 7d f8             mov    %rdi,-0x8(%rbp)
> >     63868:       48 89 75 f0             mov    %rsi,-0x10(%rbp)
> >     6386c:       b8 1f 00 00 00          mov    $0x1f,%eax
> >     63871:       48 0f af 45 f8          imul   -0x8(%rbp),%rax
> >     63876:       48 89 45 e8             mov    %rax,-0x18(%rbp)
> >     6387a:       0f 90 c0                seto   %al
> >     6387d:       34 ff                   xor    $0xff,%al
> >     6387f:       a8 01                   test   $0x1,%al
> >     63881:       0f 85 05 00 00 00       jne    6388c <hash_combine+0x2c>
> > -> 63887:       67 0f b9 40 0c          ud1    0xc(%eax),%eax
> >     6388c:       48 8b 45 e8             mov    -0x18(%rbp),%rax
> >     63890:       48 03 45 f0             add    -0x10(%rbp),%rax
> >     63894:       48 89 45 e0             mov    %rax,-0x20(%rbp)
> >     63898:       0f 90 c0                seto   %al
> >     6389b:       34 ff                   xor    $0xff,%al
> >     6389d:       a8 01                   test   $0x1,%al
> >     6389f:       0f 85 04 00 00 00       jne    638a9 <hash_combine+0x49>
> >     638a5:       67 0f b9 00             ud1    (%eax),%eax
> >     638a9:       48 8b 45 e0             mov    -0x20(%rbp),%rax
> >     638ad:       5d                      pop    %rbp
> >     638ae:       c3                      ret
> >     638af:       90                      nop
> > 
> > When I'm using libbpf-rs, it receives SIGILL for ud1 instruction.
> > It seems more appropriate to use u64 instead of u32, doesn't it?
> > I'll work on it.
> 
> Yes, this is due to potential integer overflow.
> 
> I tried with clang with additional flags
>    -fsanitize=signed-integer-overflow -fsanitize-trap=all
> and disable inlining for hash_combine().
> The asm code (the code is compiled with -O2)
> 
> 0000000000007cb0 <hash_combine>:
>     7cb0: 48 6b c7 1f                   imulq   $0x1f, %rdi, %rax
>     7cb4: 70 06                         jo      0x7cbc <hash_combine+0xc>
>     7cb6: 48 01 f0                      addq    %rsi, %rax
>     7cb9: 70 06                         jo      0x7cc1 <hash_combine+0x11>
>     7cbb: c3                            retq
>     7cbc: 67 0f b9 40 0c                ud1l    0xc(%eax), %eax
>     7cc1: 67 0f b9 00                   ud1l    (%eax), %eax
>     7cc5: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)
> 
> Here 'jo' means 'jump if overflow'.
> So if overflow happens, 'ud1l' will execute and dump error.
> 
> Changing 'long' type to 'unsigned long' should fix the problem.

Agree, unsigned long will be good. thanks.

> 
> > 
> > Thanks,
> > Sidong
> > > pw-bot: cr
> > > 
> > > > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > > > ---
> > > >   tools/lib/bpf/btf.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > index 8befb8103e32..11ccb5aa4958 100644
> > > > --- a/tools/lib/bpf/btf.c
> > > > +++ b/tools/lib/bpf/btf.c
> > > > @@ -3548,7 +3548,7 @@ struct btf_dedup {
> > > >          struct strset *strs_set;
> > > >   };
> > > > 
> > > > -static long hash_combine(long h, long value)
> > > > +static __u32 hash_combine(__u32 h, __u32 value)
> > > >   {
> > > >          return h * 31 + value;
> > > >   }
> > > > --
> > > > 2.42.0
> > > > 
> > > > 
> 


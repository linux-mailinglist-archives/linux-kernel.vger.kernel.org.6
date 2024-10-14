Return-Path: <linux-kernel+bounces-363931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E206499C89D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E141F243F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EE17C990;
	Mon, 14 Oct 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyTM4y0P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E60156F3A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904647; cv=none; b=kC2NH8RN8ixQE4YYh+dpqQ+Z3wJ9WNn3LJtgsasp50PIfKvcyn15mpdBY6zYFJBQ5yeAsuDdDFTAlRHxT65bvaz3+W7SmYxN6CLUnLiVfh96YimGEYIXGz8ldtw2Wj26XBVXjLG4z3OoMgKFly0SERLPuglOP877DFYBYc36EXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904647; c=relaxed/simple;
	bh=AdrCz5TQyjL368SqkMsGbALovCURVew64GlLWY0THNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLbHGpam4jvBR1it14DY+gOzZu+oEA+5jV+gQciswkwKqGy+88DO0K3kyU6qw+aBMnvOCsOHZkEclpCi3XBVx3IhZ3QMBh5iDnU11hos49gq5Cws1bQXRmvIkigVB1vXZ75FclYkcESxQ7e4b4HoTODYC/H1BbULzdgIMVmcN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyTM4y0P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728904644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Z20Hm7NvoaOPIqaaBV3dbvsrnKroLLcxG4BMXJ1Npk=;
	b=EyTM4y0Pl2mSz6kS1TO46GgEx26sjuque9Fw6Occp+P315f/rgylCtAnxh5tEinKnBDiTb
	HbcJjrXmX/o0AMR3SqXi0CzH1j72L6/qBBbhpvqo4ke69ttM2iCB4uAeGJMNPLSf5HUfgV
	W+tnSYD9QY/Sb+sQDPfte2qAxbWPVgs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-Rs105iVtPw-JbIiAM4FP6A-1; Mon, 14 Oct 2024 07:17:23 -0400
X-MC-Unique: Rs105iVtPw-JbIiAM4FP6A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53691cd5a20so3754399e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728904642; x=1729509442;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z20Hm7NvoaOPIqaaBV3dbvsrnKroLLcxG4BMXJ1Npk=;
        b=rD3RoKAewFLPfCfhVOqFN+k/M2KZqOyzOe+qffCAfogC1iOTUTHPjmsUtspb8avX85
         JCzjnyn/NhN3K+fATvOXmzxVzsaxciFvya7IA2cQ6C4G3WNPoJoVoMVuJmiCsMvrPWkG
         6sEyh81OPDFYi24a1F8K9gLkPgJDWo6Mod9CnFEu1Sdzrjw8Ls8Qd8THABaqsFMqy1kA
         YUzkVb3PvYWGjIACSO1f7mKCK77qLBwVS1++MoYkjX+xQ4hkAMVwl40PmfKlZK7djM/E
         S20FM6BMdeJ6MJpjUMhab5Bj8rfb/UK2HOybN4CNW2RcT/McwH+7VBKou9O6De1byI5i
         QboA==
X-Forwarded-Encrypted: i=1; AJvYcCX01eCWWkAH1PTKxh5cJW7Q2O76ecqOrnm6jsIxAskf+4c9xKCanuO9iOLXbsDysTQCIREKBH0cYgnoQXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb22A13FApdaI8C6NTD3ehLXWlgEX1Ok5DBL8MIdMmBodiwIJZ
	L20TMixVispRZLPt7lMYqoe2bisw8qC66GT+wimLy2aexXrMAQhHPlIMElt3JEpZ6FI6LWwr4UL
	bfqmsg4vUPj7r94pN36Os09Xh6ddROW6a9BnKkAVLI1xi8LmsBjgP09FW1eUo
X-Received: by 2002:a05:6512:3085:b0:539:f93d:eb3d with SMTP id 2adb3069b0e04-539f93dedf9mr949021e87.46.1728904641719;
        Mon, 14 Oct 2024 04:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbhkyTUng0BBXHiCbt8YBIXjwPpHNKvU13Nia1aMAMxSPrcXkzbeul0nRmdlFmP/GxEZkPHA==
X-Received: by 2002:a05:6512:3085:b0:539:f93d:eb3d with SMTP id 2adb3069b0e04-539f93dedf9mr948994e87.46.1728904641255;
        Mon, 14 Oct 2024 04:17:21 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f797sm151207925e9.4.2024.10.14.04.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 04:17:20 -0700 (PDT)
Message-ID: <ba11f117-3ac6-4747-92d5-65a3012e598c@redhat.com>
Date: Mon, 14 Oct 2024 13:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/resolve_btfids: Fix 'variable' may be used
 uninitialized warnings
To: Eder Zulian <ezulian@redhat.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, acme@redhat.com,
 williams@redhat.com
References: <20241011200005.1422103-1-ezulian@redhat.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20241011200005.1422103-1-ezulian@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/11/24 22:00, Eder Zulian wrote:
> - tools/bpf/resolve_btfids/main.c: Initialize 'set' and 'set8' pointers
>   to NULL in to fix compiler warnings.
> 
> - tools/lib/bpf/btf_dump.c: Initialize 'new_off' and 'pad_bits' to 0 and
>   'pad_type' to  NULL to prevent compiler warnings.
> 
> - tools/lib/subcmd/parse-options.c: Initiazlide pointer 'o' to NULL

Typo: "Initiazlide" -> "Initialize"

>   avoiding a compiler warning.

I think that the three changes should be split into three patches so
that we don't have one patch touching three different tools.

Then, maintainers can also decide whether they prefer your patch of
subcmd or the one mentioned in the other thread.

Viktor

> 
> Tested on x86_64 with clang version 17.0.6 and gcc (GCC) 13.3.1.
> 
> $ cd tools/bpf/resolve_btfids
> $ for c in gcc clang; do \
> for o in fast g s z $(seq 0 3); do \
> make clean && \
> make HOST_CC=${c} "HOSTCFLAGS=-O${o} -Wall" 2>&1 | tee ${c}-O${o}.out; \
> done; done && grep 'warning:\|error:' *.out
> 
> [...]
> clang-O1.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O1.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O2.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O2.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O3.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-O3.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-Ofast.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-Ofast.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> clang-Og.out:btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
> clang-Og.out:btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
> clang-Og.out:btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
> clang-Os.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
> clang-Oz.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-O1.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O1.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O2.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O2.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O3.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-O3.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-Ofast.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-Ofast.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
> gcc-Og.out:btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-Og.out:btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-Og.out:btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-Os.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
> gcc-Oz.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
> 
> The above warnings and/or errors are not observed after applying this
> patch.
> 
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  tools/bpf/resolve_btfids/main.c  | 4 ++--
>  tools/lib/bpf/btf_dump.c         | 4 ++--
>  tools/lib/subcmd/parse-options.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index d54aaa0619df..bd9f960bce3d 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -679,8 +679,8 @@ static int sets_patch(struct object *obj)
>  
>  	next = rb_first(&obj->sets);
>  	while (next) {
> -		struct btf_id_set8 *set8;
> -		struct btf_id_set *set;
> +		struct btf_id_set8 *set8 = NULL;
> +		struct btf_id_set *set = NULL;
>  		unsigned long addr, off;
>  		struct btf_id *id;
>  
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 8440c2c5ad3e..468392f9882d 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
>  	} pads[] = {
>  		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
>  	};
> -	int new_off, pad_bits, bits, i;
> -	const char *pad_type;
> +	int new_off = 0, pad_bits = 0, bits, i;
> +	const char *pad_type = NULL;
>  
>  	if (cur_off >= next_off)
>  		return; /* no gap */
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> index eb896d30545b..555d617c1f50 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -807,7 +807,7 @@ static int option__cmp(const void *va, const void *vb)
>  static struct option *options__order(const struct option *opts)
>  {
>  	int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
> -	const struct option *o, *p = opts;
> +	const struct option *o = NULL, *p = opts;
>  	struct option *opt, *ordered = NULL, *group;
>  
>  	/* flatten the options that have parents */



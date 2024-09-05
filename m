Return-Path: <linux-kernel+bounces-316550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811996D11A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5CB284417
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1428C194139;
	Thu,  5 Sep 2024 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEEaNkXn"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD275192D9A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523218; cv=none; b=pAPi8Z95y0VWnv56mIEjPVe4QUHzypcjuF6SRs2uP2FathHePc+ic8K3v9YWsybSVZF2kgNsHzDr6DZBr7kZJ2QjYn3gprsDeBLw/YAYsc7N4VIo92DRiExdWqDdMBD2UNPlzJMjcfBxbNupv6VfkYRSUGvy3n97k3xpZOeXvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523218; c=relaxed/simple;
	bh=BSUExMVgIEzOBG0R8CEOmy3+yDoIc5dtgYLCVfHdhcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1D1VY8tZ4q4ydVRIGqztd82d1rECgKpeGFdzuYaCPJOr7eBPGkbnNZ7+9wC7ZwiDNaiyITzgwm3YHx/S/99Nmo3E3qdS1F+6V/d4P3V9at3l+RgIeCOZ7+TUyN25BDm+VOKkdOVMwgOlGIThKAsRU05sltM5yg8fzYhu/KcJOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEEaNkXn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a868b739cd9so70055066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523215; x=1726128015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CeWOMVsY4lOSTsqa1+JGIPgERJNf7ZpGVHqbFOMj74=;
        b=JEEaNkXndWfn2uQrPeztfLKbush9Bc2Ws673ozUQD1xCFqimBrKQQ/7GeWpaP1eM4d
         XuDSimqSUx3fneIJqJxu3V97gDh7MFduyYThjxG1a1OOZWRBatSU4+wG67GpI0Jrk1lN
         1R7VcYlur49VIrMoDBx8UX+UhAKmil6FZkSx9Oq3UM4lUPc2LHdy0vybqmPYXkGCHyHu
         rfU1Z2idI9AWOrnwfGF+GXOAPUhon2ZSIc61knamo/al/1t9rJE/B7+/hj9JMtdFn8Ne
         R6Z3J3sfsopoNWvHSnB/kwEPkCdF95n9Wzd03QiMyCy/ickb1Y2NtF+DnrxwrSHTcelm
         XBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523215; x=1726128015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CeWOMVsY4lOSTsqa1+JGIPgERJNf7ZpGVHqbFOMj74=;
        b=KiKd6c+5ZploR0kJ59RYlLR8YQ90QIaqDZpui9KPdL11qqL5nUYTx66Vs6a2QVDR9w
         rw3ruxki6VadIzWMhlHK2/ihZt6ALRUmnUZh+2XYnWZxfyvuLQo2rD7yxuBJbPlmoxEg
         QadPeKKTkMAWwImJSkNdYz/3dNAlB0FCkroJDYaMugFKubs3iv4yVgahQkyKKY96ovTf
         5C5Hlle4Azn9Ww55SIdk5K6yqQ1/VAfSTuORH2ImIiKvDgxeNztpREKTR9oYToGGvaz+
         cuv2D8SHPKdTtNyyjkxUlRlwjOxjTFCGLKBBXNr42n+HcqIuIg1+JE/RdtzGQl+0aup9
         iM/g==
X-Forwarded-Encrypted: i=1; AJvYcCVbWVkZZmwoOZDtW5/iy8iU+1k3Y5Zbv6wDLCKy5cauzIf5rjwtq1IveHucF3oBkwv+aEiB2OKMxzDJyRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXMwxEbGnnK2KzcY+gulNcQK3Ww0cAcAcaxs+ajPWHQSOqOZh
	kXWXt7liLeJv+JY8KTsOdQ6NpJr9tyDY7EB1Wz7ipGBNrdl9VC95ch9OOP4jrw==
X-Google-Smtp-Source: AGHT+IFviDrxNsbRMp4ewEpx5PPQYwyxtIhIxSJX09RAM8NWfw4PRdDyWLHHUzJs7xsj3SHRzGHCRQ==
X-Received: by 2002:a17:907:9708:b0:a80:7ce0:8b2a with SMTP id a640c23a62f3a-a897f84d44cmr2006052266b.19.1725523213892;
        Thu, 05 Sep 2024 01:00:13 -0700 (PDT)
Received: from google.com (172.118.147.34.bc.googleusercontent.com. [34.147.118.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e64e6sm97013066b.219.2024.09.05.01.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 01:00:13 -0700 (PDT)
Date: Thu, 5 Sep 2024 08:00:09 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Vernet <void@manifault.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: use type_may_be_null() helper for
 nullable-param check
Message-ID: <ZtllCZOrO9b-MDtE@google.com>
References: <20240905055233.70203-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905055233.70203-1-shung-hsi.yu@suse.com>

On Thu, Sep 05, 2024 at 01:52:32PM +0800, Shung-Hsi Yu wrote:
> Commit 980ca8ceeae6 ("bpf: check bpf_dummy_struct_ops program params for
> test runs") does bitwise AND between reg_type and PTR_MAYBE_NULL, which
> is correct, but due to type difference the compiler complains:
> 
>   net/bpf/bpf_dummy_struct_ops.c:118:31: warning: bitwise operation between different enumeration types ('const enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
>     118 |                 if (info && (info->reg_type & PTR_MAYBE_NULL))
>         |                              ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
> 
> Workaround the warning by moving the type_may_be_null() helper from
> verifier.c into bpf_verifier.h, and reuse it here to check whether param
> is nullable.
> 
> Fixes: 980ca8ceeae6 ("bpf: check bpf_dummy_struct_ops program params for test runs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404241956.HEiRYwWq-lkp@intel.com/
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> Due to kernel test bot not setting the correct email header
> (reported[1]) Eduard probably never saw the report about the warning
> (nor did it show up on Patchwork).
> 
> 1: https://github.com/intel/lkp-tests/issues/383
> ---
>  include/linux/bpf_verifier.h   | 5 +++++
>  kernel/bpf/verifier.c          | 5 -----
>  net/bpf/bpf_dummy_struct_ops.c | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 8458632824a4..4513372c5bc8 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -927,6 +927,11 @@ static inline bool type_is_sk_pointer(enum bpf_reg_type type)
>  		type == PTR_TO_XDP_SOCK;
>  }
>  
> +static inline bool type_may_be_null(u32 type)
> +{
> +	return type & PTR_MAYBE_NULL;
> +}
> +
>
>  static inline void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
>  {
>  	env->scratched_regs |= 1U << regno;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b806afeba212..53d0556fbbf3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -383,11 +383,6 @@ static void verbose_invalid_scalar(struct bpf_verifier_env *env,
>  	verbose(env, " should have been in [%d, %d]\n", range.minval, range.maxval);
>  }
>  
> -static bool type_may_be_null(u32 type)
> -{
> -	return type & PTR_MAYBE_NULL;
> -}
> -
>  static bool reg_not_null(const struct bpf_reg_state *reg)
>  {
>  	enum bpf_reg_type type;
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index 3ea52b05adfb..f71f67c6896b 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -115,7 +115,7 @@ static int check_test_run_args(struct bpf_prog *prog, struct bpf_dummy_ops_test_
>  
>  		offset = btf_ctx_arg_offset(bpf_dummy_ops_btf, func_proto, arg_no);
>  		info = find_ctx_arg_info(prog->aux, offset);
> -		if (info && (info->reg_type & PTR_MAYBE_NULL))
> +		if (info && type_may_be_null(info->reg_type))

Maybe as part of this clean up, we should also consider replacing all
the open-coded & PTR_MAYBE_NULL checks with type_may_be_null() which
we have sprinkled throughout kernel/bpf/verifier.c?

/M


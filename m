Return-Path: <linux-kernel+bounces-318046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56E96E797
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C5BB23054
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD42D600;
	Fri,  6 Sep 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AL7SFQw/"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208A1EB3D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725588657; cv=none; b=oGXX5jD62ZWsloVEsoWmUUuth7yNhBu/1OZdfd7mMmbm8baBA12toMGV9qLVBzSidGGKX1pUnqlprA3BpL3LGUT4JjW4E3msEe2MlyZcQggED7xDxZ2/gvErXaWGGwLkM9rZYOxZOKXIW6q0jsXGAW/bGqyn1eUuVpKMYSeA1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725588657; c=relaxed/simple;
	bh=2E7Umks8wXQUo5OoAJfXfZ/E5X7wq5YaMefduwHtqmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2EJvYKPibPWT0R8lbFK96aDf1xjVC3tllPKhNaEOqvy4oSp4fZE+7yRm74Ddv1Mtoo9nEXpOB3pS1AZVwgEtjm96F+/6LhOgDbpKH/Di1k9eob6rMPiLMqPFPFp8WUKCHlL6c+TdbaOfAt85xpxOQp4+5H38xGAaK5V0rYRB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AL7SFQw/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3780c8d689aso837378f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 19:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725588653; x=1726193453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAvARZINz4vJQ8c0Q/MMgM2aRtDQKyDIrx0VwPcsgnw=;
        b=AL7SFQw/7xv1QvTBilP2BILhW6P1cFMTqQiNCvUwROUBMrj94QKiAjioPffvImQgJL
         ZpxdVhJs+dWKSvXGuvun/9vocTgTlZm+SGD8fNOH1VjGHjwDuFrz4zwVSsyBtnvPLWB/
         +bwNTe7aUX7eoz2k0Us9eEALQyAX2kgJyyZjGC2bI1EuKel7Qo+7Ws4I+qZrGDiC2/JT
         Guhb5IR93bG7i6fBNf/zKMiOOVjzsV7NsgZbjALpjjSAI9MzyFtlAErE7eDAl8JYD6Cv
         EMLAJaKE5NfB2Ze8TArZWuO5sGmIHT2k2xl98atPfSLcYWse5sPCiFOTOn0oOw5hY4f7
         m+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725588653; x=1726193453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAvARZINz4vJQ8c0Q/MMgM2aRtDQKyDIrx0VwPcsgnw=;
        b=B0rpGlkC5p8zUUaBBv+LwzxKhJInkUBCT9CpqNSE/TAMhDq6nhQmPjTUhozZq1jpmK
         gimu6A131SBzF+HugocKxqoMM8rxmDjf3NOU5Fnw2qC8t5zQGCpd/k4UbzpDJJ36no2U
         wC9ZV0aA2TrqjkLa5k5NlHR73TdFGMQi3xn4H3d00ZALzOcBR8jAi2Pd6dCMMwaVhvz/
         6GbE0+wB3TtlrDHsS5KzixQcXeOZkT2Aob2bfpqCXkuzxarrmtiVUB4zEIPQWcm4+nRQ
         4C/ReFpQZRYPOh6ThFycVAmw2LbWo1ZtkQls/C+/r9EHAGjitICwf2gDJDKoD65Z/BCK
         ofWA==
X-Forwarded-Encrypted: i=1; AJvYcCX6CiJoy+sqYYKqPnQaOF6XiKkAmI1G2Pyhoz0MZFiJyTUFyGKBRnozoG9a0a8k+Ogk9aDX9Uus2slX9y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ySBoFyi/Y1UbHUU3jZvjS6Xl9ugNRkRmO2wG3qA/E6i3XDus
	neyvyCwDRdvHhnYwjzNTOhsgslG/83QPn57tE0EXBxn8wkvRiO/WGXMVKPuI2xc=
X-Google-Smtp-Source: AGHT+IFjmciqCusWNY5Mnsq94uColtksFwX4WGKvTbnvpcRTzIUgwHdV7sDbQD63Er44q1qv/Z99rA==
X-Received: by 2002:a05:6000:781:b0:374:c56c:fbc7 with SMTP id ffacd0b85a97d-378895ca924mr625193f8f.15.1725588653187;
        Thu, 05 Sep 2024 19:10:53 -0700 (PDT)
Received: from u94a (39-10-10-202.adsl.fetnet.net. [39.10.10.202])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de5f52sm3891880173.44.2024.09.05.19.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 19:10:52 -0700 (PDT)
Date: Fri, 6 Sep 2024 10:10:40 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Vernet <void@manifault.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: use type_may_be_null() helper for
 nullable-param check
Message-ID: <u33xtqql46ppe2ebqj7u26so4b7my6ebsdeoxdb6kn57ygbniq@3vmbbct3hphm>
References: <20240905055233.70203-1-shung-hsi.yu@suse.com>
 <ZtllCZOrO9b-MDtE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtllCZOrO9b-MDtE@google.com>

On Thu, Sep 05, 2024 at 08:00:09AM GMT, Matt Bobrowski wrote:
> On Thu, Sep 05, 2024 at 01:52:32PM +0800, Shung-Hsi Yu wrote:
[...]
> > --- a/net/bpf/bpf_dummy_struct_ops.c
> > +++ b/net/bpf/bpf_dummy_struct_ops.c
> > @@ -115,7 +115,7 @@ static int check_test_run_args(struct bpf_prog *prog, struct bpf_dummy_ops_test_
> >  
> >  		offset = btf_ctx_arg_offset(bpf_dummy_ops_btf, func_proto, arg_no);
> >  		info = find_ctx_arg_info(prog->aux, offset);
> > -		if (info && (info->reg_type & PTR_MAYBE_NULL))
> > +		if (info && type_may_be_null(info->reg_type))
> 
> Maybe as part of this clean up, we should also consider replacing all
> the open-coded & PTR_MAYBE_NULL checks with type_may_be_null() which
> we have sprinkled throughout kernel/bpf/verifier.c?

Agree we should. Usage like this could be replaced

	if (ptr_reg->type & PTR_MAYBE_NULL) {
		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
			dst, reg_type_str(env, ptr_reg->type));
		return -EACCES;
	}

OTOH replacing & PTR_MAYBE_NULL here probably won't help improve
clarity.

	if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
		reg->type = PTR_TO_BTF_ID;
		if (arg->arg_type & PTR_MAYBE_NULL)
			reg->type |= PTR_MAYBE_NULL;
		if (arg->arg_type & PTR_UNTRUSTED)
			reg->type |= PTR_UNTRUSTED;
		if (arg->arg_type & PTR_TRUSTED)
			reg->type |= PTR_TRUSTED;
		...

For such case we might need to introduce another helper (bitwise-OR
between enum bpf_type_flag should be free of compiler warning).

	reg->type = type_flag_apply(PTR_TO_BTF_ID, arg->arg_type,
								PTR_MAYBE_NULL | PTR_UNTRUSTED | PTR_TRUSTED);

WDYT?


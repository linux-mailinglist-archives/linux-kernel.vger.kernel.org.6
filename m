Return-Path: <linux-kernel+bounces-364694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E6699D7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A18FB20DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD691CF7B4;
	Mon, 14 Oct 2024 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0qdaVLU"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6561CDA36
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936850; cv=none; b=acofDNrB/IQNlw+zMBTTZogEZKt3DIa0sSyT2zANfN+iAaQ23g5Gsog38k5m4T1PkWlYGHPZLob8TGRpWrhLPXtyqSAB+aZnuogVA5pWF0e4p1ylmmAnvoMQ9Fs/CdsXS9Bpi1d0MTb6zOkK0PsOw2X9b2U4PpGRexIPWqlrO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936850; c=relaxed/simple;
	bh=2duR3Up0Fn5AOkwt8Y3KyMWalTj1cYda1NyQh+hNLQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDJpJrkzREsS4xo9Nm0oTA6QDNGtcRNEObrZIT5y6MjqbVZE4HYdx1+q3qt4m6OybfCf1asTHolZ4iqDZZ2MI7kq4QSndJwxAiGtfFNN0fn5A8PQqvddxo2w3UNjMDwt+CFxlqEVg5Sbr3nIhB4T655eErm6KVC90LVE7JpCRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0qdaVLU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea8d7341e6so797661a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728936848; x=1729541648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFfdktb8rvun4C2wfO4YRLva+QImGAd9cuW+Tla0apA=;
        b=d0qdaVLUUomwytgvLgVcbUBpGqZAn67e7NmFL1AHxj788yo5YIFFjhLnTZWiTJnp3L
         +QfrxTEJk+eNzZfaEAFd+B+NnbGgSqL8YWYA3ffO7jzdWQEV3nytaQnP0eYmKilPzsyU
         tu3VFdxoyqJbnFcCXh3vineEtqMBdjYsF3nDE0DtZqG2J2lySgQPg1bV9BJtapHuquql
         NtQ6TArC743MLxI5cHh5NdFQ0OxILfXSRbq50VEA5ivT4nSTwCYiTpwIxureioA3r7ga
         h/YugKdejfmiIdId+Ln02TDSWZX/zBT9dxSSK51zc8/5GouuZurgj9HSs4lf3ecdCfL2
         geCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936848; x=1729541648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFfdktb8rvun4C2wfO4YRLva+QImGAd9cuW+Tla0apA=;
        b=Y0Y1PQBP5g18GrnYXFdO6Qghj5yVY4Pqe7MvDofgxK6m/dPs5TZt87kVsi7sf4Tk+J
         KQPBu8K9w/ijtyhdvX8m5EBglHQZnnaX7cqw28keyp+bzBW5BL+TKpvVe8QFgaR+ixoP
         UNYJ482Z+53vCT6pvYTyLGm73ekLf9J+2HjxDEHnDj0Y/zWJsHJAEleukq5FkNH96oMV
         W0rD5a8QTcoWtxNrhlPvjQQKsTaEQkYkiqASkTtLrxdzO0oj66ejz9lsb/t6jU0wCx8x
         2zDlUTwzjfBcu5Wqgwms2kadnA5N80M7IrQP+2Y/3r69lpa0FQkQxEWbg7H7hvU41VQ3
         q7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXsdmGMVYGxDce1yh4d49lj7T2SvHvuMQJ42tOZs609uLL5VEf4yh9MtvvowDFfHQWae+lf9YbDA5ElS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CTTEJ4Ndpkg8hXu0c6X4gcj1J7+OYpgHmI4GRo8W1C6vlTE2
	PhCKAyn8Wnd+U6EnfcdP7qaSxNMr1DbHb7jkiiMR9YCfDZHGWdzQVLJJXjVkw7NKmGCpTDW5aUV
	OyCLNcfzOVL3KClNfff3dYIrIy5U=
X-Google-Smtp-Source: AGHT+IGf5MMcJ2y8qfgoEJL7bFDS/ZZdYZAzuWh/eyTLLRCFeltSfO1qVJVuLGKhHCLCOPuuS5PiKfOACdNpMayGFtU=
X-Received: by 2002:a05:6a20:2d22:b0:1cf:4fd9:61db with SMTP id
 adf61e73a8af0-1d8bcef1217mr22175364637.8.1728936847787; Mon, 14 Oct 2024
 13:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410131412.5csjqw8L-lkp@intel.com>
In-Reply-To: <202410131412.5csjqw8L-lkp@intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Oct 2024 13:13:56 -0700
Message-ID: <CAEf4BzZ=Rf+-_SSbtL+wZkX0XPrCfh3FBUCnR21qENAh0YMcFw@mail.gmail.com>
Subject: Re: kernel/bpf/token.c:50:6-27: WARNING: atomic_dec_and_test
 variation before object free at line 54.
To: kernel test robot <lkp@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 11:58=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   36c254515dc6592c44db77b84908358979dd6b50
> commit: 35f96de04127d332a5c5e8a155d31f452f88c76d bpf: Introduce BPF token=
 object
> date:   9 months ago
> config: alpha-randconfig-r054-20241012 (https://download.01.org/0day-ci/a=
rchive/20241013/202410131412.5csjqw8L-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.3.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410131412.5csjqw8L-lkp=
@intel.com/
>
> cocci warnings: (new ones prefixed by >>)
> >> kernel/bpf/token.c:50:6-27: WARNING: atomic_dec_and_test variation bef=
ore object free at line 54.

Can someone please explain what this means and why the code below is
broken, according to coccinelle?

>
> vim +50 kernel/bpf/token.c
>
>     44
>     45  void bpf_token_put(struct bpf_token *token)
>     46  {
>     47          if (!token)
>     48                  return;
>     49
>   > 50          if (!atomic64_dec_and_test(&token->refcnt))
>     51                  return;
>     52
>     53          INIT_WORK(&token->work, bpf_token_put_deferred);
>   > 54          schedule_work(&token->work);

this is not "object free", but even if it was, I still don't see the
problem, tbh...

>     55  }
>     56
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


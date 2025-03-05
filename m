Return-Path: <linux-kernel+bounces-545870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8DA4F2E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527AD3AAACB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0C53365;
	Wed,  5 Mar 2025 00:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LYBkBoct"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056A2747B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135218; cv=none; b=Bj9WiVvBjLqUWx7zeICmF4pvmT/8cv8byEjwbRABMHkW4lz68ZewBF3FNoPgX9Sv5NmA2OZeQEQ3Q8xuDVV+ZUOpSul9fzSTHuzf3JDIcKu8J6bPN1BuRy7m1vOI3AQIa8Rl+e7iw+7TC0FidxRtdXhPW4h2Ypv2YdZ3tQ1f1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135218; c=relaxed/simple;
	bh=8KEjXP08gAH9mtHlZwTSZJHkrRvWvyV0abRhH8806fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq8tY4SXQHoUPSB9NW16yVdIbjQDzyNDkWB6Bl4bvV1X9H4CR9iRZ8cxkX8iaAG6qSCUi7V8s9I/iIwnSy7PctpADovLk+AghCg+wM93+nILesW94YKpgBy8oeTnfdOyStdvlSwypp2g+wGj6nVIgxTC7KZM3X8dbYNrKq8/65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LYBkBoct; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so5305432276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 16:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741135215; x=1741740015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLByKeK9jbAcIudXTB8h4/g+eKrBdZDjVDhHL4wGDkY=;
        b=LYBkBoctszf5rC2eNNrABPFqPNlWLnGPtCrmPAusBquV+EryKb8A1dvWiljC9Rn+hV
         kRELiQPMw/E8sYsPnvn/tSbrBuie6kxnJuZcSqtCmUaWbGtZWf/cj2EbZkgy6xfS2/D7
         C1DiH52qG9CG6e7kDNY7x6zXDtzMMFfGcn9e4q69JHr1YHXLssTqTq5pHeg06ZFJuu4d
         NyOC1FY4GBYEH/y0QDZ499MtiCdozx1VCrxY2HCyR1MZ3PnKwXaHDbBGnrL0KJzoYoIl
         1rGlsDgmk2ZvKNd2rFtyCpqVNUodm7/LuMHlC7nK+x2mTie2SXOh7qHk3WNRQAhmJfA0
         t08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741135215; x=1741740015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLByKeK9jbAcIudXTB8h4/g+eKrBdZDjVDhHL4wGDkY=;
        b=NTjYAqPkhaK9wAqoruY9KXqQQ5MkfeAMmxomnO0MnJxxPCs6Rvom+PcVkHYlbb1z9S
         mLkTuIstRCw9xPhwCdznblwBLYjec6y2IJ5v+Z/aLOy7d2u6Le70GLr9qwUGRlKdxg8D
         NaqDHXAtsfpPsjaYlIyAgCnOgmqRL3/EAxF7BSlFwqRStR2wFmbJKar/XYsrwjM5zmg6
         ccuZkzVY+dtO/zry+gDVsBhIJkDOWRt5fo0OaD9VDtXFMhDU22T2+dYq2grO3saBs6V7
         2FlbVMKkpkKfHIoQALmje58xbFfGgSZjOL0BdJzyhgD6HOK0EZP1FMp2xeo2z6h9ifTu
         Dhaw==
X-Forwarded-Encrypted: i=1; AJvYcCV+iyEcEmlT44/V3M/k/fFQsX6zJEF5ceVUCosEXXHLiIJ1DN5jappkKiQRhKrbkLXXt6m7XTdnNOrzVN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGmHO1IHvV0zEevja2XuHK/1JAyinYhpNE2s1qKma1vswTYH0U
	w9ChnnSU2tFJ+qsveLt+9cQOo/gc4hCApCj9U06TRHpYpWGbLYWrAkbB46wn01qGS4a6W4X5k/l
	NcX+IKXwneGkOTCtWdYslQU6XKyB1GhBM4WTT
X-Gm-Gg: ASbGncv08oRMoBAtBGepjXinfpIDPEe5LRNwp4QEAtG9x1s95tYbdHe4UEvr2W/WFml
	xWccUeIsuYcofXSIF7nu9QVnseqt9qJp3efzS92LCt++eLl3iFQ/mQSj3RRt+qxcUgbXTNiRHbB
	w+1zKmGFdfFkguANKWfyiZraPzEA==
X-Google-Smtp-Source: AGHT+IEzmMWOQvRMnjDkFhghROqg9lxOvTBles4ByHr5bhpu3fcrvkVJICgDGQ2HmqiNLuH79Zde6tj1J0pYKTCXHas=
X-Received: by 2002:a05:6902:2009:b0:e5d:92a5:9f79 with SMTP id
 3f1490d57ef6-e611e35f307mr1471560276.34.1741135214898; Tue, 04 Mar 2025
 16:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com> <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 19:40:04 -0500
X-Gm-Features: AQ5f1JqF5eg5kGEnn453gAfWw1axYxi2H7tbUtolXQD5gFiAWaVD4kDHxBozzFk
Message-ID: <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> The security_bpf LSM hook now contains a boolean parameter specifying
> whether an invocation of the bpf syscall originated from within the
> kernel. Here, we update the function signature of relevant test
> programs to include that new parameter.
>
> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> ---
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++---
>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
>  7 files changed, 11 insertions(+), 10 deletions(-)

I see that Song requested that the changes in this patch be split out
back in the v3 revision, will that cause git bisect issues if patch
1/2 is applied but patch 2/2 is not, or is there some BPF magic that
ensures that the selftests will still run properly?

--=20
paul-moore.com


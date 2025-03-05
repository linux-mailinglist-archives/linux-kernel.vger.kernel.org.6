Return-Path: <linux-kernel+bounces-545956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3EA4F47E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152CD16D656
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB2156C79;
	Wed,  5 Mar 2025 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HvgnQkLF"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252F14B976
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140893; cv=none; b=e2J7HyriVWM4vgUx71xvLQ9PYyTbbNGkdpUhQIvHe7WBilMvEQAV1GuQS9VfvmBU7iv1p56mMzm8eUkldrw4DzBvDm0NLsHjbqsSuudy16sdtVkmsnqvVHrMvYtR07J1dTnKmme4YcRnYyrxML3CoL3KTqnECdtd9kdxlJXmq9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140893; c=relaxed/simple;
	bh=qQ7kaU1aXWa368p5QkZafRlvPh4Fd0DUTFztungHHGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HysHz/6g8WAo5YCogyt+atV4Yo2jRAO/UjScaYVxaVDuFG6fNJGSDQB6cyDIaujH8W+Wk0Myby+DWjsqJMB++vkibVI9j6wJZvXCHW1EiCi8h9WnjdRYIiZ5N2Tf1WZ1kplc+YTSwO+/F46DIe4S3zZiJkWEeFPsUM21e46VBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HvgnQkLF; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso4607606276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741140889; x=1741745689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdHvaBKg4GleexXjKKoUyEO9pX5GSxnW4KE6dqvkU54=;
        b=HvgnQkLFwLcFLN4ZPi2E9d9WKKyDc6LC+vLKHcTJjkm4MgWYNtfSRnmZvkZ+ONpDog
         zSI6yu69Lul/YwLMxM82+pJ9XhQnJsbzF29fGYrTvf78PCci05yYK5z3rczvgGFtC1AP
         XJTbPZXmlOMgHxvRXsUlEyXZlCWlSG4yX0d94YypbUjbJUNsorCJnIPR/XQWrOdvuIZ5
         eufCuoFmoepsQGlDuHfAcARmPP+r2OIqiQQBbrzPj1JKmk1skk9Bl/YVsnU5Pa8TwsWu
         5G5N/rDRqNe9Hz15dFNo4GobJjW1vuiy4Ij94xzOJv+iMNWx78QRt9jdtjmHbNyEjIGH
         aRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140889; x=1741745689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdHvaBKg4GleexXjKKoUyEO9pX5GSxnW4KE6dqvkU54=;
        b=IOHtZZ3/seEe42nCSIR7EgDGhv8APkyLIoQKW5ex8NE+7guyFInp2tRgDyTk91zxBX
         t6YrhPRx4ZmkyEjYlQ4FHEYRYkd3b16PcTozmFlxlQj3ruSY3/ApOcL2SbP6ML3Bfv8E
         gfMa3VNzx7+7ykSylyH/jT1pUsMkk50k10GVNAIAvueasgzxm6s6R3tFtSe1tKzqz4HU
         1uUp2vhYjY0Rc9y+neFHCLYXXdo0ftdSAYCjzQR9eaJ/zDLcg05/Wfu46vi8zQNNj/qp
         iuVd21xHtoRGqtZ65hBfcG3okuZyWZm4HcPnpPvrASqRRWnqXEuAQNJn/aWcWLjBKyCe
         1YDw==
X-Forwarded-Encrypted: i=1; AJvYcCUp5rtOLJZkPksb4lM/ns3JXGTc26FqUHn1pR/iEN+aHBnP1XRdab0Vl8mMMTk01WpFG6ZglaBlkbnaP9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcJ3b3m6h8OYJSEbVvqTe1A2h5mhsMgOjjP7/L3D5RbyqFs/H
	kt+1ULY8wpH4ndLBe/XW8DY0Dz0hQmLg6z16vzX1rXhvbCgWbcdHEKk6jxRLLPxLuV/1OCdBHNg
	B2wlRKSY72xsreoAS8ZjJZNJG03kC2d4B6QO0
X-Gm-Gg: ASbGncsl7of1BKgG6PwLnAzcCmB0Sh21swKBxVNFVew563yA//dMJqBsnpo/1W7E5br
	tOYLh6L747DcIVdYNSHNk2dIRed7VYQX8gJHe9CX9ZI00RBkm+vM+rPa+3K4pM3SWQTfMh5GPGR
	RkjyCqJYtfgKxkL8VzOX/5Np143Q==
X-Google-Smtp-Source: AGHT+IFJme71+h5rqacVhXNFVVflQX6fN8c82oiacs7z+wy8sz5kKm1uZj7SdqykCNgwPKPqL++9yJVZA6PUA9xV/X8=
X-Received: by 2002:a05:6902:120b:b0:e60:93c5:9b1f with SMTP id
 3f1490d57ef6-e611e19a06fmr1861920276.6.1741140889157; Tue, 04 Mar 2025
 18:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com>
In-Reply-To: <877c54jmjl.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 21:14:38 -0500
X-Gm-Features: AQ5f1JphmYgOBnsZGxupPq2rhiEO06B4bjDitVWyy9PS-JrQ5h-eCAMlWkvCD6Y
Message-ID: <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
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

On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> The security_bpf LSM hook now contains a boolean parameter specifying
> >> whether an invocation of the bpf syscall originated from within the
> >> kernel. Here, we update the function signature of relevant test
> >> programs to include that new parameter.
> >>
> >> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> >> ---
> >>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
> >>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
> >>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++--=
-
> >>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
> >>  7 files changed, 11 insertions(+), 10 deletions(-)
> >
> > I see that Song requested that the changes in this patch be split out
> > back in the v3 revision, will that cause git bisect issues if patch
> > 1/2 is applied but patch 2/2 is not, or is there some BPF magic that
> > ensures that the selftests will still run properly?
> >
>
> So there isn't any type checking in the bpf program's function
> arguments against the LSM hook definitions, so it shouldn't cause any
> build issues. To the best of my knowledge, the new is_kernel boolean
> flag will end up living in r3. None of the current tests reference
> that parameter, so if we bisected and ended up on the previous commit,
> the bpf test programs would in a worst-case scenario simply clobber that
> register, which shouldn't effect any test outcomes unless a test program
> was somehow dependent on an uninitialized value in a scratch register.

Esh.  With that in mind, I'd argue that the two patches really should
just be one patch as you did before.  The patches are both pretty
small and obviously related so it really shouldn't be an issue.

However, since we need this patchset in order to properly implement
BPF signature verification I'm not going to make a fuss if Song feels
strongly that the selftest changes should be split into their own
patch.

--=20
paul-moore.com


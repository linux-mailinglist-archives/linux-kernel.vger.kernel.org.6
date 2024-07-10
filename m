Return-Path: <linux-kernel+bounces-248064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D992D7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D364C1C213E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C7195B14;
	Wed, 10 Jul 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VK8yHcxG"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD4194099
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634543; cv=none; b=S/W6teo9gd5tjEoSfehMDN+ZRJM5z8Kvpqp3t3WvLx0diI/hRiXDqEGTrW1Nq9tdd4xLJWZ+5xzySw7PRmD0CeeOJs9ovOdhJQdWroDRef92rR3vvcM9BUtYKm+KeZ8QdBYPkzEeCG1BWj7zgAuMJLkrh4t55bQ/jE9qXvgd9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634543; c=relaxed/simple;
	bh=PdHPvlbEI3WkdsdnZkmhStlR+34lGMLayWBOq8cq+fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaiOiSs5o1sR5iJ/uUXiWrAQi0GS6Cs4ZQFGWhGuQ8CASRykf/9o/va3cI2St/fR+VJ8wb8hLI/SbZ7Jyh6erEpwYY/eNmqI3zISGgLt9mcYorZEuUjERq6JOvJI06dpZzpZE4JKqVayIz0ThMf3GTxbwjnqc1IESM5xkXl3vnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VK8yHcxG; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-375fc24a746so9895ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720634541; x=1721239341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOsNmbPrF2STZyyL5Kpp+cQCII13OaquvqokEKK2An0=;
        b=VK8yHcxGEJJbA76IrPr9yeXh2M0GFSTS+TyGoaukf0XbZ15Tv41fFw0SG3pHWzIQir
         fVgyXbjiD42NbUJHqsQVYqxjADVpCqstyRgKUQLJ23JBLeD0WVNzQTTNHKPPPUJZtrum
         TbBG9+jOG/7u0oVq2PqrVEzcKQWGGs952/+kXlJ63khJ/RRu9fIHDQLeXsfpxT5iuAw9
         VTEGzypFWLJAIt6DxbH8bRUFnGQIe30xnhTSfqs03XXd4lhpu/1YX7OrauueeSoNyFuc
         S9DBNHI7R76ZEeeYqSVROSV919/K120cbTgCfT2VgtDNAGJucLl/BmhGkD1J+9mE2bLn
         +A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720634541; x=1721239341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOsNmbPrF2STZyyL5Kpp+cQCII13OaquvqokEKK2An0=;
        b=aTmGJxA9FoMPFoTjmp0EBSyo0mEhDq9RE6ANjAfV7Wr6EZ/r2kXEy1CoVX9Q3mBSR0
         7HB04rpTaVCbvyQbZm1bIZJZ3ErTQyQD7bommQbTRb5gXw2B0ynklWObRSVCumwvqm3x
         ZQGB6fkKoBm1sguAV2Vm2NCNdepKBZl9Oy4H4JSKp47RpUcFOiUNhlrcNtq146r4RuFm
         G6qqrdtMWHJvixytRLX82jgNG0mZ4jJaoyWqDnHhiJte6NU8/U3d+NQagRxgzxhD1gwI
         NKXIsir5VpORQflrkEAaReBDeeE9LZBAMgkXJEB+nyoScO0eczQ/ecwIip4RjyiRKka4
         EbHw==
X-Forwarded-Encrypted: i=1; AJvYcCXPnRIzobUH0LMVeu29y6MSFBmVJ7jRdiJgST8n41dHHAh7dFJK6jCic/3VDVR7wUk/rieesx+HaSPeoMA/b1GyNP+22qK5GEn9Nw6d
X-Gm-Message-State: AOJu0Yztzp7s65hMuOlkVAND7dWBPW17KI4Jhprn+Pl0hrqWir8OJBAW
	XWFz+ZOy9D/rXH6pzgJ+kmhgfgbT5XU9kLYbqUTI9a4RJoje641Yz+DhCcbsMRRB2UBKKU1qyDr
	WjqMFCLTIJt72UrKbKq/ua17e4vP4vPOWSIlf
X-Google-Smtp-Source: AGHT+IEHo7LR6ArOXTJkal+hND0YIB8MGeuzD4QP2Kr9qu/4LstjGlefnnRc8EIaqJgafRoLSx1q0y46haL1FbJ5qSM=
X-Received: by 2002:a05:6e02:184f:b0:375:edce:baf1 with SMTP id
 e9e14a558f8ab-38d2c77159bmr34315ab.13.1720634540903; Wed, 10 Jul 2024
 11:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705132059.853205-1-howardchu95@gmail.com>
In-Reply-To: <20240705132059.853205-1-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jul 2024 11:02:09 -0700
Message-ID: <CAP-5=fVoXg4sPnyEJ095YkXmYDtW35d7mRjoWfO8=KEr7Oc-Mg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] perf trace: Augment enum arguments with BTF
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 6:20=E2=80=AFAM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Changes in v5:
>
> - Use hardcoded landlock structs and macros for landlock.c workload to
> make this build in older systems.

A few nits but otherwise:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Changes in v4:
>
> - Fix landlock workload's build error.
>
> Changes in v3:
>
> - Add trace__btf_scnprintf() helper function
> - Remove is_enum memeber in struct syscall_arg_fmt, replace it with
> btf_is_enum()
> - Add syscall_arg_fmt__cache_btf_enum() to cache btf_type only
> - Resolve NO_LIBBPF=3D1 build error
> - Skip BTF augmentation test if landlock_add_rule syscall and LIBBPF are =
not
> available
> - Rename landlock.c workload, add a comment to landlock.c workload
> - Change the way of skipping 'enum ' prefix
> - Add type_name member to struct syscall_arg
>
> Changes in v2:
>
> - Add trace_btf_enum regression test, and landlock workload
>
> v1:
>
> In this patch, BTF is used to turn enum value to the corresponding
> enum variable name. There is only one system call that uses enum value
> as its argument, that is `landlock_add_rule()`.
>
> Enum arguments of non-syscall tracepoints can also be augmented, for
> instance timer:hrtimer_start and timer:hrtimer_init's 'mode' argument.
>
>
> Arnaldo Carvalho de Melo (2):
>   perf trace: Introduce trace__btf_scnprintf()
>   perf trace: Remove arg_fmt->is_enum, we can get that from the BTF type
>
> Howard Chu (6):
>   perf trace: Fix iteration of syscall ids in syscalltbl->entries
>   perf trace: BTF-based enum pretty printing for syscall args
>   perf trace: Augment non-syscall tracepoints with enum arguments with
>     BTF
>   perf trace: Filter enum arguments with enum names
>   perf test: Add landlock workload
>   perf test trace_btf_enum: Add regression test for the BTF augmentation
>     of enums in 'perf trace'
>
>  tools/perf/builtin-trace.c               | 229 ++++++++++++++++++++---
>  tools/perf/tests/builtin-test.c          |   1 +
>  tools/perf/tests/shell/trace_btf_enum.sh |  61 ++++++
>  tools/perf/tests/tests.h                 |   1 +
>  tools/perf/tests/workloads/Build         |   2 +
>  tools/perf/tests/workloads/landlock.c    |  66 +++++++
>  tools/perf/trace/beauty/beauty.h         |   1 +
>  tools/perf/util/syscalltbl.c             |   7 +
>  tools/perf/util/syscalltbl.h             |   1 +
>  9 files changed, 345 insertions(+), 24 deletions(-)
>  create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
>  create mode 100644 tools/perf/tests/workloads/landlock.c
>
> --
> 2.45.2
>


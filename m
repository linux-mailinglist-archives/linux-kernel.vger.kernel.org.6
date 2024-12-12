Return-Path: <linux-kernel+bounces-442572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7E9EDE71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA37A168225
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79315B0FE;
	Thu, 12 Dec 2024 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYaq0Zam"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F7414A627
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977549; cv=none; b=bVXYDaU9U3kliMg9GOR9WcSbcFHE9SRWkug2JypfzsEpoeiWBK/CD+Y25IbT8S3CgIhEoIDeVPEnizi+aOkyktcNdQaE3tsAp1ZyG9EaTSYELdinyG6mNen77UJOdJgjM/2i9HK2VPklxZQgU6Khcr2AZvjVbDr3TJlDwi8zbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977549; c=relaxed/simple;
	bh=7Qvs01/BejNv9rHlb5ktozEHtjnwpusW63FoyHDxM/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2GRa5UBO2Q2vZNDxmKfyQ3X78FAYwf6FzzmZL/icgGkmgI5vweueEWx4PU4ZGHDv1jh7jLH9ZWmsEoiLPlN8Md7x966h2fR+cQSdiSDrjnB7vVZxCYOYMa9kdhUdBs+7PNdeZzBHb0dVZw8PwBovaSYBZoh0Gz7oBpbw9l4XGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYaq0Zam; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso53155ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733977547; x=1734582347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrGgTd6oD7cu/uVCzqBxXlqwiU4sXdR14b9ViH7/yCU=;
        b=BYaq0ZamKoz9moI1Mvw9I1H0NbkOGpeWkc5Bwq8yCtrElHU5euI/MuknheJMKUMwFo
         CSD7vCM3M03WRYphmDbZn8coqVwE+dY7VLJlv1UQd/Gbzgd9sHTr0/7RZZiTnz9CeNmx
         qaKM0j2nWoU8hsteZVk0xnLNKj3fONu48qWrwPgryA8OZA5w8D4+JAJAZ6o2AB+ZXQPX
         nFdTF+zRZZiqwzeHlOH96BT9oEMcmXF6cgqHRvCt/+RKaF08fdSyCeRD6tY0N+YwN0Kp
         3YuQ0mnDWBAygcW594tCf3ipO67ffk2Jh8sTs6TNI9Zc2sD9v5iMZIfMl4dBEO7JPtBK
         L5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733977547; x=1734582347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrGgTd6oD7cu/uVCzqBxXlqwiU4sXdR14b9ViH7/yCU=;
        b=UndYvSTsFXqtMwAROHR7okFHb7Rxv/a1N6kBeyTQiakCqJ5FsdIQ4aKqUb1OIZuWnz
         S6nexu4aC6SpyHKeRt1gAKxFf1BJSHEKYU5ruabbqt7Pk+qlRhjoEZ1jb8Vt5rjcgVzx
         gGMmDpVx6Tnov+41a6QckJXTmiI88/w3OIun+0D6QTMdUX85Vq8IE+YPigIWsbpZhdqx
         5PPOI0w7LH/djaSQDN8novQgOr9JrPtHP3fR/3uFTi62FBx4bTkxyRGF6f+1gyThI+3j
         i0AFuUX60F+uvxF+K44JnEum1H3dUIsb4G4nYpM2N6yoFH+TYPoM46lmBBncOMFySoZb
         MwCw==
X-Forwarded-Encrypted: i=1; AJvYcCUQDDE5XQaam/oimdmie2l5OU++Nkut2ukzhrpLxGQK47yS5cBWMK66KglZYr70IDkQLhuo9tKytPpgtjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XA4lFDmeuSJUK96uiPQdo1P7PQvpU7TnoT8OEw9h2dbDRFGQ
	orUMb4eWH4iORRfX+qnsXddtG7beX5q598dKOud9FSNGBzErqF68p9e/S9SyK7XET0bcBitNVHa
	3A9xam0zW9IJ41KPorJTxZmW7SWjvSPF4SYlM
X-Gm-Gg: ASbGnctpKuYOfjMI5BGyZtb/px9Rql/fvk+zBO3aSUDxQBnFURSig/BqSWrS5ucr60P
	Ygw2OjOP6jH+3shuhMWWm65dAYJEZwKbxnnqpnBM=
X-Google-Smtp-Source: AGHT+IFeac093aPHT58jDw2lyM0tERSxKFUNRS9QFs4KAEwE6D1MsO2nfZhs5ws67/hHOLSlvk1Aj9wt3HeqrSYPjWY=
X-Received: by 2002:a05:6e02:80c:b0:3a7:c733:1c63 with SMTP id
 e9e14a558f8ab-3acd78fe2e4mr1009635ab.5.1733977546297; Wed, 11 Dec 2024
 20:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211224509.797827-1-acme@kernel.org> <20241211224509.797827-3-acme@kernel.org>
In-Reply-To: <20241211224509.797827-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Dec 2024 20:25:35 -0800
Message-ID: <CAP-5=fWqBrw1SuY8ue2X_xOv=yStPANM9NGUBkeo+_s2O=bKTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools build feature: Don't set feature-libcap=1 if
 libcap-devel isn't available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	James Clark <james.clark@linaro.org>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:45=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> libcap isn't tested in the tools/build/feature/test-all.c fast path
> feature detection process, so don't set it as available if test-all
> manages to build.
>
> There are other users of this feature detection mechanism, and they
> explicitely ask for libcap to be tested, so are not affected by this
> patch, for instance, with this patch in place:
>
>   $ make -C tools/bpf/bpftool/ clean
>   <SNIP>
>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpfto=
ol'
>   =E2=AC=A2 [acme@toolbox perf-tools-next]$ make -C tools/bpf/bpftool/
>   make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpft=
ool'
>
>   Auto-detecting system features:
>   ...                         clang-bpf-co-re: [ on  ]
>   ...                                    llvm: [ on  ]
>   ...                                  libcap: [ on  ]
>   ...                                  libbfd: [ on  ]
>   ...                             libelf-zstd: [ on  ]
>   <SNIP>
>     LINK    bpftool
>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpfto=
ol'
>   $
>   $ sudo rpm -e libcap-devel
>   $ make -C tools/bpf/bpftool/
>   <SNIP>
>   make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpft=
ool'
>
>   Auto-detecting system features:
>   ...                         clang-bpf-co-re: [ on  ]
>   ...                                    llvm: [ on  ]
>   ...                                  libcap: [ OFF ]
>   ...                                  libbfd: [ on  ]
>   ...                             libelf-zstd: [ on  ]
>
>   $
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


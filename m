Return-Path: <linux-kernel+bounces-255348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6657933F82
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D531F24368
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D80181B94;
	Wed, 17 Jul 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNLxIZ6T"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD965181CEA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229792; cv=none; b=WuFSk2PANdleNXuEjYFvD/Caj9dR2EXnGvYQxlfHbuDiNaiarPSOND86DNbcVr6RSe6ZyOOUqoNw5pQP+nGftKrqN60q1dy44dDgTwMSbchpysJNF5MVBxgqBds4eETpS31+eMKjBvtMRSQYf7SLaAc9On5Aq8CmBrXlA+9Y8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229792; c=relaxed/simple;
	bh=2uUzUI45oTnm6sXU/3A+RvL1dLhC3gg3sqx7aB+ucus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uu9Vm+sd6ajL7wv6GJwe1Vz4a8KruO1LWwIGI5BrTQEnl7MzfO4QSPSpYrHFHBnyvEMctvhQNa/Gasq+wSMZndkKf2il1Ysfcb9vucOF05fuID1pszwKXFWhRrZWMfAItMWadH9F1TB/4zo0Lhu68lSUgCpTBmIl/cf4eIxA6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNLxIZ6T; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so139315ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721229789; x=1721834589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iRLHKzItM20H7XSXlQZgREwapn4lm7JLNhhvUHXBIA=;
        b=NNLxIZ6TpOiKOXgxwr91MU8Tcz/gvNlgRWDqhNROArWTassjBqQ+RZcKyI7PdfrMU3
         yWXEYsK/wPAEvWyiDAUnHiPyZ5yA93YtgLZyPqyWgx8heytps7RZ+H5vwFcqd8ADFNLh
         sXkEYYLg2DMMvilEk13K1uhhVK0GRS3/wHj1WurGnPurJElMwdiGEoQI396SG1ZUAMbB
         KD/jvhaN1Saje3tTj4ZwSKpOCrzE8rewG9K4KD9qDTkjklQXE/bhlNJMPoIMIIwA/MA4
         Ylug56GRhkt7a2NrS3sowDUXsS5SChN2Dcw7LWWwCJpOLVGZ9ztBOCk373xhan+0MQcd
         cT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721229789; x=1721834589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iRLHKzItM20H7XSXlQZgREwapn4lm7JLNhhvUHXBIA=;
        b=B/eVJs4bJ5eH57TdKZTvVD2MlgDJGupgVWrvpaD16pipdkEzSUgCWwijgKS7Ht2Xb8
         lEdP50p0SknIZJ47cJbMDzaJuhW8ftsUzhGN6pkLmQm6oJxet9C0u0dmcrSDQq8y24Bc
         5D7HJFVE/LCcGMMo+Ayf81TQnhllNyvAzS2E3Wkh3j0Ge+0Nm8kujlJT1yzjhUdFEcwG
         TKs6Ml8gmu1lwEm2LRGMEDjmCaOqnEYsRMrM7IHaCEtjfYcRLsuYyDJYPUxJ9ggNaN38
         5UIEZXG23NKRtu6sXe6Ov4rEzoCqkM3swewfuF+GaZWWCdqBlDNe8xa5+tD5e817inLB
         ftUg==
X-Forwarded-Encrypted: i=1; AJvYcCUHy/T1DoeLye4xEMNFtGTA1M3G6ycDmeSkRNUeoyr2U0DMiMWZAd6B+mpkl9L23pmUoXBkWjdMBE42j/nH1jU8HdB9yiheaA64XlQ1
X-Gm-Message-State: AOJu0Yx/LaHScHo9Fndn82I35pWKCXCDYYBLFF/TH2sW2vOTew4GiiOU
	LVHnL7iWA6fzZ41bWrR+L58qCfwdqWMb+4I+QE7hNWrj8SXtO/t65kNCQwKHae0bHGAOlQxoa58
	lgwZs2JPTRHAvShoMukBzE78ovS9z5NDMnRLx
X-Google-Smtp-Source: AGHT+IFT2y/sDTIlBGHR8EoRgqXZAbbNq0Z4632Y4MppMRrjz83PHM2cGFfDcvuwyep8nnVsDqauOePmYcWdIerzBf8=
X-Received: by 2002:a05:6e02:1388:b0:377:872:cf6b with SMTP id
 e9e14a558f8ab-3951364ea53mr3776545ab.2.1721229788751; Wed, 17 Jul 2024
 08:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717082211.524826-1-leo.yan@arm.com>
In-Reply-To: <20240717082211.524826-1-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Jul 2024 08:22:57 -0700
Message-ID: <CAP-5=fX_h9ySEDwN8EWLdE2X8c_LivjoGd=7+aT-X8W_RdwcyQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] perf: build: Fix cross compilation
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@linaro.org>, amadio@gentoo.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 1:22=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> This patch series fixes cross compilation issues.
>
> The first patch sets the package path if the package configuration path
> is not specified. This helps the compiler to find the architecture's
> package in a Multiarch system.
>
> The patch 02 sets the Python configuration path and renames the .so to
>
> The patches 03, 04 and 05 fix the static build failures.
>
> The patch 06 adds document for how to cross compile.
>
> Changes from v4:
> - Polished patch 06 for removing redundant sentences.
>
> Changes from v3:
> - Added more completed comments and logs for PKG_CONFIG_SYSROOT_DIR.
>   (Namhyung)
> - Didn't include the patch 07 for "perf docs: Remove the Android cross
>   building document" in this version, which will be sent out separately.
>   (Namhyung/James)
>
> Changes from v2:
> - Reordered lib paths for PKG_CONFIG_LIBDIR. (Namhyung)
> - Verified the Android NDK and based on the testing result to remove the
>   file android.txt. (Ian)
>
> Changes from v1:
> - Kept the cross-compile-pkg-config if it is available. (Namhyung)
> - Removed the patch 02 for fixing pkg-config path for libtraceevent, as
>   this will be resolved in Guilherme Amadio's patch "perf build: Use
>   pkg-config for feature check for libtrace{event,fs}".
> - Added patch 06 for document.
>
>
> Leo Yan (6):
>   perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
>   perf: build: Set Python configuration for cross compilation
>   perf: build: Only link libebl.a for old libdw
>   perf: build: Link lib 'lzma' for static build
>   perf: build: Link lib 'zstd' for static build
>   perf docs: Document cross compilation

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


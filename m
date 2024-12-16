Return-Path: <linux-kernel+bounces-447782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461AB9F36EA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F62816F17A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9538207A19;
	Mon, 16 Dec 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkk1Pycf"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA43205E01
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368222; cv=none; b=k388/0OEZ/1jQ2KOuSKiWS0xyMlLm7pUcn2xkpS9eIjrtD+0SHqHeZ2w1hQO7C8ZrNtJ29IpN0uuk9owa/xki+vJywcRjLpocavW6SsG4deGE8qtP3CJt/CfVxT5clbmfRTV2QbzcJr2VacnvpsAI2JZTDdMXTSn8sGmdJKj1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368222; c=relaxed/simple;
	bh=tUN6QyLrUQtqswwv+FWZ6ZBH4o75Y0O/ZF/rjsabplQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Nhk5EbhzacCc/lonOovFrXfoX7O7HZ+9vfBtLU6cQPFPKYUAMczWCj+JE5Xy3lAQkhsXoqwlc96giTaQJEHPThE7cSQPivDpoaDUXfQmFxxWQpeEhKHZqr+dReMm+cZzVxoxzauyag63T37UNg59X87vSpb3GiLR05zcW+wTSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkk1Pycf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a814c54742so425055ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734368220; x=1734973020; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUN6QyLrUQtqswwv+FWZ6ZBH4o75Y0O/ZF/rjsabplQ=;
        b=vkk1Pycfezmlwrvk22zev0avWgwLpfTXeZQLZz83AbQ1URk5LPT+41yyvWYUXXToXg
         ZyFLGp8gIshQhVLuCuPFNkgAFp+41+wBvpTOiO9VT0Vp3J/cwoKuoJurKDxjif4kih07
         nxV6H+7lIF6fMtWWPiO2I3FCzz2vZwHTYUuUwzd++nX+oFvjvvbkEivtWoyah0NCSW6d
         Db5JKq57LS6E4ZhQBZ4sxS/VcZCTE+y0W2A/WngBk9QEj0/KZkgFV4qD37IJ2Hv3PZmJ
         0j0Jvu8JWM3BvkqjNnRZwXYwWV+tUDKFpZMwVTHDemKh4DO2COUS1tHDUtTn+CK5ukKM
         bfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734368220; x=1734973020;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUN6QyLrUQtqswwv+FWZ6ZBH4o75Y0O/ZF/rjsabplQ=;
        b=qKB0XLO9uUFvlzDXoqX7XyONcp5AixC7Y+L953SFFJGo6wg0VjhDawrgzdUBDuOLnL
         euN1LL1B0u9IPyziPyo/0PQb+8n40v3Pxbkt0B5jeGx3lsurpWUsQDd07KWSjIsJc2Bb
         rDNWgG5sNa5pkc0ArAT9CBFTnmPqsXNvQmkOA0Nyg+wuqtEO6fKztrGHZ9onGeKVPwj4
         8ebk6QJlfsJmKL65yW6CCHt8xsxGA2PNAbQf2WcBI10PCJ+hZIeh6/5H1y8rwObDgN2V
         xo6iC0v17t7/sxj8LTaq6eYVv727oz8RwMXL+x75Vc04/EEXRYMnBk3GR9slckj+dwLY
         1SXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVNpSdENjXJL3/sZ5EAfx86j/NC5AGNL+FEb7V1da3V/QcbrQy7mmKdrj8mHDie9woK5jfbLs+Lx2Jhfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxngi5Gj+fdGkPd4rw/0cjO2w3LTCuKDE+fAJkMfihkzaKNGINf
	QsaxNIeOTE70DZ/sI8MIQkvVHrUm5DfYnDrE5uL0cO3TP5FvIO2OMys7BsreogU1gBga3MS7ZzY
	5gShgWFOVe2VCV1YOBAdViusRzew3BuWFTnqQ
X-Gm-Gg: ASbGncslMyUqbPA24SHTLRX/aDPwZDbwv8C0tAq5OMZLe9rwVojy7/i9Cw8IaZrE1Fy
	+TKEeDY2EKnjZciiarGyaAQoeax4MSWdDrPHwFMw=
X-Google-Smtp-Source: AGHT+IFenKD4P/KhIiSws3yn5GuMSBGYBSQhOYwGdU+AxUyjmLfeKG1/Yy+/zpPC+OKRBfJ/iyoKqrB/AotlSl2jNqU=
X-Received: by 2002:a92:ccd0:0:b0:3a7:a468:69e0 with SMTP id
 e9e14a558f8ab-3b2c2a279dcmr5132185ab.1.1734368219531; Mon, 16 Dec 2024
 08:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216014637.304761-1-irogers@google.com> <20241216014637.304761-2-irogers@google.com>
In-Reply-To: <20241216014637.304761-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Dec 2024 08:56:47 -0800
Message-ID: <CAP-5=fXsO2i6UE6FrQFLOyJP4xbH1E0-2W5b1ejN=MsGs0d0QQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf header: Write out even empty die_cpus_list
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 5:46=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Reading the CPU topology is tolerant to the dies_cpus_list being
> missing by using the feature's size in the data file/pipe. However,
> the feature's size is just the header size and may be
> unaligned. Making the header size aligned breaks detecting a missing
> die_cpus_list. To allow the header size to be aligned always write the
> die_cpus_lists even if empty.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

This change breaks the "Session topology" test on ARM with "Cpu map -
Die ID doesn't match" . One die id is -1 and the other is 0. I'll look
into addressing this in v3.

Thanks,
Ian


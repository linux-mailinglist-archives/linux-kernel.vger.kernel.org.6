Return-Path: <linux-kernel+bounces-302639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B896014D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A530E1F22C44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426913CFB8;
	Tue, 27 Aug 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="D0MFbysh"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02538C13
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738801; cv=none; b=s6Mfpo64B8/i7mT3bkw6qv1RB2dWn4a8u3vBSA0L+rYoF8H/GDgU8zJhr+eE/HZ3HSD5VZawUzRdkPCeoMy0u2z/3bYBJps7ceWNTeS/yOVTjQh7du619JyUM48Ilup2Qqo87oaYxp6F27t4W4eYut4kJ28NvwvE05UP9jOhD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738801; c=relaxed/simple;
	bh=bKDSwXhu1A8U1DQ+S1xtWcyQhh34SXxPMHfZm8i9NFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0JMpEq+qYxvB0Abt44ecGkjXnuULOj3vp3HQ77ZJOdrcXn8+3Ai6AE1L3W66/g9YuwSubpSM8eJeCvq09Uz1Gq/ED9UGvQdAsZMODt2dXAUw8974u+3Wh02aqpdE3HYBzYzIQMW3KzSQc8L6aaAe7eHGUGhyuUIDGp8nN3Mx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=D0MFbysh; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso7054003e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 23:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724738798; x=1725343598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTrR0BM4ODiDkdhs0fxD9YCdOTbXeH2dM84cX6npY98=;
        b=D0MFbyshmqq0KZkQZgmOkgu6IrCKzNUus5k2ecn/EliI3ITITWHsfBnf5QbEW2Qe7u
         jUwxajQ1yeMQw9ZZJvtWQhTCcsNhc1Es+LbwUMUZ35hRZy3bhJbq2lWBli2spjFMizmR
         gGkEYLYEg6jQL7y6NoG34eZgWx3XxKwiieSZnV0qUwibtVJ1xQhz2iBcvMPbTedlwnFh
         wbx1Wkwrbi7Z7URyV5TDFu/6fqMleJoQ4fCZoXPph73D6RYdTV5UZpwdmCb+905ntHMm
         PEUgFN3yyhWkMjrtzWDee3i67s9BIx8X4Dh6WvwT4DMw6ySeMMMUsHAJxZDVeF+W7D3g
         Gvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724738798; x=1725343598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTrR0BM4ODiDkdhs0fxD9YCdOTbXeH2dM84cX6npY98=;
        b=TU8w5974PB1k75CWwYSEDilJJ9EnwlOFoLo4tkaYk8nqVW639OJ/oZWEY6e4ObG3rs
         wOJSWwhw83YOS0NdX9fBe1jtDhN3K38ub7gFE2nr3uMZtsYa2j0AheImvW9A4CJibvSI
         MUoXMDW4hIu1/3HrjqTdLGf0p/RE0qkY0nnmk/I7KCFFRJsBUZ5631+HOXr77wa/uyaD
         EqV9zo1Z8TGGKEGhN3G2RIBhNQtge+gnLn2mowcSzktNp4qQzokOiQl0JCDM92RlIWmy
         YlfNWviAPpfN+7gzl6il2D6GVZwVsYTdAZL30bH7DvQ3UyyCGsV3KSzFW0azeljbhI4B
         si6w==
X-Forwarded-Encrypted: i=1; AJvYcCXCoM83OlkziUZLsG17AGJmrjxWgEjg7hI816TIEgurhk/jBXAm0J4z8wBStYxCDgEKsegrICEDXBr/FgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0TNVSjrKPhQeKItEPh1ZXicwhjlqKK/G8QFrbnoDrBXHGeaZ
	k6VaglNGlAMF7Io1vbgxUfbYnYHFRtYRtdgCmiaD/goOZnoNMvOeAjZ2YjiqXdfaT3LzD+CNdqF
	ZEKIvKg5wNRW4+jLH/F2jVtQydx55NAwOOEQrSw==
X-Google-Smtp-Source: AGHT+IH0GAeFQVloNzRRFQdxxP1U6JC1pb+UF15amHRXtNVp9K9yOTWAoBaHBI4ogBkWM1d+wDyqOUtogd6HaEzb87g=
X-Received: by 2002:a05:6512:304f:b0:52e:7f18:176b with SMTP id
 2adb3069b0e04-5344e3ba53bmr1027589e87.11.1724738797413; Mon, 26 Aug 2024
 23:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826165210.124696-1-alexghiti@rivosinc.com> <ZszZHycX31dGeP4O@andrea>
In-Reply-To: <ZszZHycX31dGeP4O@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 27 Aug 2024 08:06:26 +0200
Message-ID: <CAHVXubh+yEROx-P0iS06J4BSc9bBzi8D_FUFAG5mHXAvuE7TpQ@mail.gmail.com>
Subject: Re: [PATCH -fixes] drivers: perf: Fix smp_processor_id() use in
 preemptible code
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Nam Cao <namcao@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Mon, Aug 26, 2024 at 9:36=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> On Mon, Aug 26, 2024 at 06:52:10PM +0200, Alexandre Ghiti wrote:
> > As reported in [1], the use of smp_processor_id() in
> > pmu_sbi_device_probe() must be protected by disabling the preemption, s=
o
> > simple use get_cpu()/put_cpu() instead.
>
>   simply
>
>
> > Reported-by: Nam Cao <namcao@linutronix.de>
>
> Reported-by: Andrea Parri <parri.andrea@gmail.com>

I added it at first but since there is no link to a bug report,
checkpatch complains so I removed it. But I have just checked the
documentation which states:

"The tag should be followed by a Closes: tag pointing to the report,
unless the report is not available on the web"

So I'm sorry about that, it won't happen again.

Thanks,

Alex


>
>
> > Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@lin=
utronix.de/ [1]
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Tested-by: Andrea Parri <parri.andrea@gmail.com>
>
>   Andrea


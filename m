Return-Path: <linux-kernel+bounces-546642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F62A4FD33
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385CF1891E7C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5976B233708;
	Wed,  5 Mar 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RBn/DkfT"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A1D233707
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172848; cv=none; b=fXIA/G0m/oMfbcX+pK3gS1e40+W6lQFC1P7Ke3KFQkCIpOn4bPcnL7Wsv/R30NQITpzI+PrixdOpmje4Pz4ZoP5peWWknO2hKCJ1Jl3damDiDzNNlgjx2K3GRsdGR/hkOzwbxUzSIGbIawEro8s2IbJFOtXfJTMmpSww1KgFgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172848; c=relaxed/simple;
	bh=YCPEr84HADNtZknZjlNwVsT95fK47HMoG4o4XVCziNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiL0mS7fTandgJ79oqgV8MWuhqcGuHwMeitk0crehP3xt6cUr3EgzTP94mDU5QGQmHy6tIu7u2/nETBudMuVSmclDd7M6XTu/wJ2wNwbxtt1eDd++LhZyJkWX/LSmn1eJ4dQ88tOEVEJLzYIqZeQ3bQt0gVltCaCqNuPe0fUtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RBn/DkfT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-474fdb3212aso286721cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741172846; x=1741777646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3b8bsvWe2wdOZZrFq+eS3B5w4t8qU8Mzx9aXoXYEXfU=;
        b=RBn/DkfTgORoPAY/GGtHj5Y3g6Q0xYFSF85N/BbMzHkjii63OndvU1QlU+PY7KXdNx
         5+0Qz7dwPYkPgB5bdkaWW8KQT4ImmXJlm+vnRylPLjH4sasW6+PGLYmoRsfsfIDFsKPi
         sm/IY9zjx1TsWtSxvgptShcQER/+Y8o5sG2QwnmMPm4wU4bA299VVxDy5ax1w3C5IdU1
         k7WUUVCMMRtOcPXUpyufqwL8GGpC5dRC3M4fZa/p5/dEUGwKb5kflN/mJZiGUa6Pa8zt
         sxCVpshLC4TjD4wgO2usdITAjnimtYQcwYQfaL0B/Hp6qVPc25tvLan8PeINbrozm50i
         lGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741172846; x=1741777646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3b8bsvWe2wdOZZrFq+eS3B5w4t8qU8Mzx9aXoXYEXfU=;
        b=hnEI+c665EcWjEPulpLbkQR1zWegrj4BeSKDeZGMGMFfU7DFyd2oshiDBKVN09G3JC
         Kc0+RmXXo5K5CbIvmooKH+bQ2XAhWXHHVgpSGp/tecczV340RQyGNQpbOxh1iooUN+v9
         o3CgytxWZunkN+P7/sMEX/5BZDfQYVLeOeCOTYbjEFl/chfFWV7uHIzGudjwmVrGSKmF
         T2ULJD8WhKEsTjk+59HfJzPwEMoa1qUX5NK/zkI0p1f9c2jV0DrlgJXVV6BP/0+gZOji
         fmv3RDwNZa+Nkme6gGsN8KTF1NtL2RkKjZULohusQ/vEHmAtVG01R8ggMzywzjn/89ZN
         SOKA==
X-Forwarded-Encrypted: i=1; AJvYcCVsYpBRA52B92Ko2FJF8xd94TRwAsbKWoRjDPHGvfCm15xKo6EQhGV4ePnATYJubyVO3cgWktA5Xn6TFUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwV9RhOuS0PXDtQwgfh1bdIJJaEpOKaUtCvRKEgJkVU4y7GxXi
	F7zwlI34s9oL8tzc13T0DLSM6/dqiE8nyiPYUNDk9+N2U//grfP9kaX+IaIiiqWh8fyyKsr+ulg
	jWc9qNUS+Idh0S1okXnRrOZ9o+GSZf4iwCcvi
X-Gm-Gg: ASbGncvur3YQ1Dv6f7drr1rVBoQY5IbHNNS2kEjxrzHWVVG0OcWtqjABdBle0NRUgn0
	Me4TUlft1vbesmA62cgErqrvdVpcHCKXZRtQS4z/fA1WT4qIjPBtfLZsi98TjNZEi52pdEQBMrw
	I63sJ3DNTnuOQ/W0uUWozF9RTzsPA/60ypmzU3W7KYMflf2fscoeA0IvUk
X-Google-Smtp-Source: AGHT+IEL760KZkjyd/+1dFxx1ZG+sfvkJ/ZLzkZJdVLCh1mgfXm97SH5uL0JtnEwSYgrbAmRC3KYpD6jfIDV3TRAsks=
X-Received: by 2002:ac8:5807:0:b0:474:fa94:8d20 with SMTP id
 d75a77b69052e-4750b53c11amr3965601cf.2.1741172845959; Wed, 05 Mar 2025
 03:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com> <20250228-mm-selftests-v3-6-958e3b6f0203@google.com>
In-Reply-To: <20250228-mm-selftests-v3-6-958e3b6f0203@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 5 Mar 2025 12:07:14 +0100
X-Gm-Features: AQ5f1JqnX0ORyymHsw5kQxZqiZ_jVU2MAEIa8yR0CC4Q6dLgX8mYcADTJ_z6BII
Message-ID: <CA+i-1C2pn90pfB6qhuGV8ecUw3YKfg1b8tSTsXs4n_Rw6US9mA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] selftests/mm: Don't fail uffd-stress if too many CPUs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 17:55, Brendan Jackman <jackmanb@google.com> wrote:
>
> This calculation divides a fixed parameter by an environment-dependent
> parameter i.e. the number of CPUs.
>
> The simple way to avoid machine-specific failures here is to just put a
> cap on the max value of the latter.
>
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/selftests/mm/uffd-stress.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index efe2051c393096e237d942c04a264b6611a6e127..5656128590373ed376b3b5d9259e5ca3867a4099 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -434,6 +434,7 @@ static void sigalrm(int sig)
>
>  int main(int argc, char **argv)
>  {
> +       unsigned long nr_cpus;
>         size_t bytes;
>
>         if (argc < 4)
> @@ -452,7 +453,15 @@ int main(int argc, char **argv)
>                 return KSFT_SKIP;
>         }
>
> -       nr_threads = sysconf(_SC_NPROCESSORS_ONLN);
> +       nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +       if (nr_cpus > 32) {
> +               /* Don't let calculation below go to zero. */
> +               ksft_print_msg("_SC_NPROCESSORS_ONLN (%lu) too large, capping nr_threads to 32\n",
> +                              nr_cpus);
> +               nr_threads = 32;
> +       } else {
> +               nr_cpus = nr_threads;

Won't have time to send v4 for a few days so I'll just note here: this
shoudl be nr_thread = nr_cpus. This causes a division by zero on
machines with less than 30 CPUs.


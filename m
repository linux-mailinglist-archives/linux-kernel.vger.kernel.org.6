Return-Path: <linux-kernel+bounces-524028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED44A3DE33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AFD3B7CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EEC1FDA99;
	Thu, 20 Feb 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWFTYJUD"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8741FCCFF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064654; cv=none; b=k+xEAzvy2FevnTF2WAiRacCfmdUZyx67ViZs3t0bTUct5jR55qDkx/BANtYE8MHE53yy16teo6s3bxt8epCClonAz2uHU8NBcD6gcND49sc06J7dYxR634D/IDaB6+jw3HjnRP8ooxWA1zBbKLwtJsvfjmyvBOkUV+dHeUJbpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064654; c=relaxed/simple;
	bh=hjbVevJDsAnw9R1jKzAcMVdMe+e0Cb/Fj4Olj9+4LeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQoYhJRe7xFhAeS1YaRk+SSvA5wlxQVo3M1d0zIbeu/+oQcyz0har/SQFHQ82L5f/ZfY8G/7Axj/9f5+dt4t54oijtcKuxiXLnRgCjKLUY6KrLw5dQal5VEf+VvLHLoc3dqQfmU+LX2WCUdTkBXHJqGgczadRzkD1qalDPDR+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UWFTYJUD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-472098e6e75so286451cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740064651; x=1740669451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nfqLAf2Bt1MZOxsTzROGpX4mEJpPOhYETeaZVqIiLtY=;
        b=UWFTYJUD7pS3GoygUk9JfskGqEhvOeau99u+wB6fxkIyLvLz7Ht5/VbFnPYHYPeQ+e
         dugAJzBy5hRVyXjm3yztp/bOiwOUitjvSgnjSNWa50amsQSt83thDkabxv7h5bgpNlG0
         dWIkBCpi+rgqdYLifERzQ5ZaFdIBhceNNYuyfm9AUPeOLzxi40QfmiKkgpTl7V5R5+mn
         6yBVAHAL8cg3junqRA8dVe1EKIlfhnOfPMEHWLU5os/W+6clQEh7D/gPTd+3ajWpopgw
         9A2CnVpJ566AhDMI3hor1u+7eG5+bfV9odbUkqDbNGHcsqKzWz2GB6I4EkE878iV5Psu
         FA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064651; x=1740669451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfqLAf2Bt1MZOxsTzROGpX4mEJpPOhYETeaZVqIiLtY=;
        b=qIT+mQ0MnzZvSBZ/cUo585j9qsA2rElRLVuIyhijHe0zQNaF5oCViEIdVpEIZv5qz9
         tCHOuIZID9WEPgo9MWsu2au8881SQgzY4NhCRVM4atFwVmPSCxLrR0T5ss5mF8VDl/aK
         WS2/3oEsPD9ARc6/4E3m5Daf7vLU2iJ8NxNr8wrYplQMvHjyX2xT3FZZX/N92e0LwtxM
         TVyKxCBlxDrvz7vI96AuTOglyr9zI6HLrQuvRPu0Ef9zgtMmlhbPhzEsjZqme33ah1kS
         XRFnGZl8b7fIpLPPi+9VjAFmwDqXedshEp3xxn7kbL9aLJtEgnQ8NJzW2VGHDsEbfwOM
         /EGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9pjUgpvHh/dHkzgWV4T/eKWfVuz1YO2KoFadSAck9+i9g6VGRyhl8GQgAWu2Kvy+fMH3y8ppSSmf1gy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw79ZEdQxBqZ+mKXycR37R745rxUQmp9Z1n7itSQl0nb1fE3TtC
	gQyqjKRTIo1UWDZeJ5M7O/shqwlXcYsxhdDSq/oj47ygkdkrFORXgodUnmDfdqiA7OtmSOMknrQ
	d2Q0wDll/7MqJ073+wTrSr5A/HKe/bKYWkW8A
X-Gm-Gg: ASbGncsSmoRoM/GWtfkaTkuJRV6CnT8DGh5q4MSn4QqS23R7n/8K+lr5gHM5fLyJjXL
	HYdEsTofrM1UV/mVcnJhHkhZpYIYQrRbxUL3Ts8UgJH2ZoPMQTRQWgs3HLuT9IdAjI3RSQfgsaI
	hs/V0Gi0gpu/EPxXSZ81VH/pi1l9g=
X-Google-Smtp-Source: AGHT+IGhyGVmDHiveCYislzBLpxmEyFf8bbj2ICmMKfXu+YhRG0z57YQ28qadOmItdhl4ZLbIN/D33o1DiOb1WYbGYM=
X-Received: by 2002:a05:622a:1a88:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-4721708fbf4mr3622511cf.1.1740064651173; Thu, 20 Feb 2025
 07:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com> <20250220-mm-selftests-v1-5-9bbf57d64463@google.com>
In-Reply-To: <20250220-mm-selftests-v1-5-9bbf57d64463@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 20 Feb 2025 16:17:19 +0100
X-Gm-Features: AWEUYZkyoMHZt5wOSmW4C7MoQ1154jjgu5NFAI7r6rF-taWxuY5uZ_vFpxeDUv8
Message-ID: <CA+i-1C3K=Fm=OfNy_5a40HYDwp_FBy4BBV9+4L0gF3S1grE5sw@mail.gmail.com>
Subject: Re: [PATCH 5/6] selftests/mm: Print some details when uffd-stress
 gets bad params
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:03, Brendan Jackman <jackmanb@google.com> wrote:
>         nr_pages_per_cpu = bytes / page_size / nr_cpus;
>         if (!nr_pages_per_cpu) {
> -               _err("invalid MiB");
> +               _err("invalid MiB %lu (%lu / %lu / %lu)",
> +                       nr_pages_per_cpu, bytes, page_size, nr_cpus);

Oh this is actually wrong - the number it's printing isn't MiB.

Assuming there's a v2 I'll fix that up. Otherwise honestly this patch
could just be dropped, it's not important.


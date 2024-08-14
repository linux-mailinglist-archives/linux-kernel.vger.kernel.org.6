Return-Path: <linux-kernel+bounces-287051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2853B952224
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FC71C21C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96A1BD50A;
	Wed, 14 Aug 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="e9JkOX6I"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687F1BD515
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660979; cv=none; b=MS8/+JT7++J3kqJ+oFNz1ab5HiOuJYpNUi7sieqitBGFyDV8qSCoE3R4q9BD8lWKATntgYfwi0tK1Zt16fl66tFBv98RWc5hQbRnuxTLSJwmAIpfrmeWQoJlYjyyKDV3tugf9voZxG8preK9dOxxYlrqrPb9UdKFAxClNrpCLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660979; c=relaxed/simple;
	bh=/l49U/wxdV2hskoBO8oUszPFooh438tGs40jvUIlB9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjneklqiAAcQqcSTVO1fviBblriquwgoYPsDeDa4C2HPe0JLFgb+9WxN71RZCOB5VxtYJ5WRr2UEBoaCKVV5PaFkLD/1IHchqZ7p4P7JrrNOFF8V+iW/EzFKJIPlNCILEGH4LfhlzZHU36cHvZTBzm7xr86cUmSuSAZC0VhJ4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=e9JkOX6I; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093ba310b0so61982a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723660977; x=1724265777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l49U/wxdV2hskoBO8oUszPFooh438tGs40jvUIlB9k=;
        b=e9JkOX6IWBf+ChF3nnfw3wZkX0loVWADFNfKR1E6EF9dI/Y6+5etqTKNRjQHs+PMr6
         Psgs5EuWDdMVjkThorjTTyGJld/bTrZY9w0J7npZqHFjU4rQ9vQT25xnezkkEBR6S2ra
         XnCwSB1p1aM5MTWeLAy2WK5p1Cuhw7Bj4oAAioPbdEZmerYJeyOWQa2Y2RFqLiuwGY47
         OpikZ6wUlilJ/oxbqTjF2+xnteXoshdrKCgykaRjAmuzX0EfuXZNwqjmpegDSAup/DMR
         ivwRRgkknEszpV6AZX6Hai67UtQyN19wKkAtlqqTFw1j8Fo2R1l8vFlRMuxPtONb0JIl
         VL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723660977; x=1724265777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l49U/wxdV2hskoBO8oUszPFooh438tGs40jvUIlB9k=;
        b=kwchdalx3bqkMlybvbU4skhrpAxIHEiEAqfXAScxRnjS/H0eBjNc+vMQDWna4jdXhS
         kChm3EMMU+jNE0dq16ga2BT15/a0PICf5ggduGJXucvIJC4BWatiDLaXSgCQx9JlIZS5
         pzmpuw3FzgTbiP6HO/QK5eg967pCbh3ceTK71mWgM02bOGtDLHdWkTgFTXB60OFgRRAJ
         sKDGhhZPkE+RX5AcDV2PZs5o7KYLP7AVNXkhYqIR0U//q6xfVsldfj8GDpuzRI5I6map
         0nmVnjYiFC+2ymFNS7Nn38WZEIWRYGutMrIO/ya/LjILpafEsphVVs1tPkyJIhB6trIs
         nvBA==
X-Forwarded-Encrypted: i=1; AJvYcCV4I9A4EWLKKDWnsddV5ud3YuLicAU3z6efiHDdhRnxxD7Exp5DyeDF6V3xqsisoUB1ijuBgNgNstAbcThNAxLhRKGLQEUK+5xpj5X3
X-Gm-Message-State: AOJu0YwuJAnsj9N0bvEp7KGtjz5NbvLVgYBcmBTbjqcWFRUUx4sT07p6
	0cNr8sVnOY0qJIlIUkjkyxu+faqsmaF0ic0IuhglgVqsIfpQB8XNd2N+GaIpQD7xFcOwTlppDfJ
	198yAfPF22/9mknaZzSa9oqLrWs9Oo/jtMeJRuA==
X-Google-Smtp-Source: AGHT+IF8wcHTAzyZP47djK/jxXQWyvawwUBnhudvKFNvL5Or8b6sQKz1htUdOL48QnhCh+43PeAg8Zrl5zPb3/iHg88=
X-Received: by 2002:a05:6830:3812:b0:703:6988:dbed with SMTP id
 46e09a7af769-70c9da243afmr4702408a34.34.1723660977004; Wed, 14 Aug 2024
 11:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813150758.855881-1-surenb@google.com>
In-Reply-To: <20240813150758.855881-1-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 14 Aug 2024 18:42:20 +0000
Message-ID: <CA+CK2bBzRv70ECqkQOtvpPBuxKo=iAePgO5+UGuA7c9TwEfPqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] alloc_tag: introduce clear_page_tag_ref() helper function
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, david@redhat.com, 
	vbabka@suse.cz, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> In several cases we are freeing pages which were not allocated using
> common page allocators. For such cases, in order to keep allocation
> accounting correct, we should clear the page tag to indicate that the
> page being freed is expected to not have a valid allocation tag.
> Introduce clear_page_tag_ref() helper function to be used for this.


Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>


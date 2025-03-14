Return-Path: <linux-kernel+bounces-562298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DFEA6222D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892A03AF12C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B51EF0B7;
	Fri, 14 Mar 2025 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P9UP7RVk"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4651A257D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995984; cv=none; b=PwZi9mhv2Yx4kbySEgSIXghdi454rYjBkUfyrehdkkd6uVyk/hI53nqmx6Ozk04r/VJQBu7oU593Gq53QloAyQfILyL+O6mNr+Z2+tIDTA25/ipoD7D1N45oONSqUk6it8+T+joCxPP75piV/0s7kysfVl7MW9dBx4YOL8iW35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995984; c=relaxed/simple;
	bh=sDOfXAXzx5D3kpzvL4bf3WLKj3zX404RYsS31fiBHz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMzjuy/u8vNwdY2TKqLkkpyVnR/qX5T7/hHC/nWgKWFDllVUiUR5OU8q6psLARBVRfFevDQ5c3wnJeWll0rM2SWq4Ds4qcqoOQhV9bjpoI+KmbNRo+RoabPDSbinBrpeOAwB0LS0SBeC03HdF+waFjOcs+YMQV12FuMugVpujpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P9UP7RVk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso502454766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741995979; x=1742600779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9/y7EM2Lg92fDl97meUZg+yFVClzpaEkHcF6bNK9aE=;
        b=P9UP7RVkRlQ3d/PKi87rwiRDBXxNkRtkPxZt7Asv1wxT2PVpVJ+04K35+Z5SruwWzA
         QVuyJjFB0FYjsYTDlC/MS43O8yHnyvhHE/OcyaO9ozany6hb1fwLyJitQQeEFYcOQu7K
         rEW3/8TJyMkpZEljDQwi1FSm9pkOPob3us4OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741995979; x=1742600779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9/y7EM2Lg92fDl97meUZg+yFVClzpaEkHcF6bNK9aE=;
        b=A/fMmmetFD5438fGwsIxthSTiFwtqvXlzMKwXvMuAzXXj7XlOuoKjaIW3mjAG1MzAG
         3Wc2YCKGHYjUU9OouZ/WzTqQi2l91A1fq+RgS5n/5dq9uYSSUW7BvCvTCTlWUk/USJXc
         btMtobdc8yU3atlfh1sVKskar3FnssQC4Dq1pgM34DB5fx3MRknt+6zwdDsQ8hjcVI/0
         HfNFCYE32sj6JhoYTej+oVdyQW7nNHSNrDj+IMXDpZH7M9os7zYcBEhE+IbVuSlqqtFL
         5vfPCtN43/gyIMUHAWjiljatMlUMuSWLpbPUsBmlhueNzA4HxatmOpBespanUtwIlycZ
         hTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWqLGj/PG3EPMC+UlPPJQaF3KzVNmMLLpdxEuAYfWnWYc1IZXFTDMuM6go6Wj51OICVp8VDGjlSxHkYK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4tklPfczFflP7SmdcRDHrCSv/4R6lrDCpnKOpejf7sNzNUhY
	ywTHkb5NWzQPL1bvdrTX6Jn7LZb6yXUt6BcQkUfBufs+yw1g69SnM/868TqpoODpiImwzGDkRkS
	VQuQ=
X-Gm-Gg: ASbGnctMfsXxD4aTFkjk/v97oFl6ZS+g71b1Y361rwtuDRfDPpLirf5Wqyow2HkcLH4
	DiV3t3l1Lp1R5Nn45mbERCWCt2J8F3CgExRLfjQu5J7YavjQLr5+NgNPZbA3SPH3X8E++kAB/y8
	ky31YE5ZSh9qaCj2eIncqX0LXp8OWyeE7bpdvoLZjSwCP2FJhlOdG2bETuesCDUVGIpRk5l+dnT
	Ptzg7WatMd+vzpG9elUeGI7EmCr7o3mrVGqWzHuNkYvGBqO2+avZofQOGMhySNts56wd+oQXke9
	jpnifd65lbRJ0ADPfVVICplks4QslJeaSpS9t+8cy3UTK1fhjQ2dUfdyX3ZYB3N+XRf4csNKUTe
	hwclaspDJtJW2Ifb5Q+s=
X-Google-Smtp-Source: AGHT+IF00aukK8Xj6I0qIAJwyNFAkS9wD9TkZUevWI61n8CXuxwzGX9MJ8oiEny7Nd689esywYXkVQ==
X-Received: by 2002:a17:906:7311:b0:abf:425d:5d3 with SMTP id a640c23a62f3a-ac330373b47mr492721666b.40.1741995979233;
        Fri, 14 Mar 2025 16:46:19 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aea93sm287636766b.30.2025.03.14.16.46.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 16:46:18 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso502450466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:46:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmYp+aZsdbhArQSQFua/TkMiKgMw9KNIuXsOazZx3ePwJFk+R/ZcEHRizHk8oLCQiey9nOlAOTn/es9V8=@vger.kernel.org
X-Received: by 2002:a17:906:340f:b0:ac3:4487:6a99 with SMTP id
 a640c23a62f3a-ac344877921mr146008566b.47.1741995976980; Fri, 14 Mar 2025
 16:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <c007f4ddbfdfe92777a7df35bc121cf9bf0d0682.1741988314.git.jpoimboe@kernel.org>
In-Reply-To: <c007f4ddbfdfe92777a7df35bc121cf9bf0d0682.1741988314.git.jpoimboe@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Mar 2025 13:46:00 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjBjq6u+r9KGTHQ5nOA1L2TDhz0JPL_+eE07un9y9Qm-w@mail.gmail.com>
X-Gm-Features: AQ5f1JqtNPoY6M1QnRnhfz_dPwWFomE2jxyWXH5pkbBIhtTwGucRAbCwwZA7N24
Message-ID: <CAHk-=wjBjq6u+r9KGTHQ5nOA1L2TDhz0JPL_+eE07un9y9Qm-w@mail.gmail.com>
Subject: Re: [PATCH 04/20] x86/cpu: Use named asm operands in clflushopt()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 11:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> +       alternative_io(".byte 0x3e; clflush %[val]",
> +                      ".byte 0x66; clflush %[val]", X86_FEATURE_CLFLUSHOPT,
> +                      [val] "+m" (*(volatile char __force *)__p));

Hmm. I think we could just use 'clflushopt', it looks like it exists
in binutils-2.25, which is our minimal version requirement.

But maybe that's a separate cleanup.

             Linus


Return-Path: <linux-kernel+bounces-561445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94AA611CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1861B620E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F01FF1BA;
	Fri, 14 Mar 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gvg7MuZ5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA71C878E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956926; cv=none; b=A6OJwCrbG2tO+L4tNWqmctGFIbd9GpZ/AJjF3704Hfr7Mfrh5NGsg+i6TDSqGGVHe70UB6mURLxhbJOhufuzZWRxMDAvI5C0OsbvqamZFSWrTqeQA52uMjBo9NwZppUTPG1tIMNSb2AUYlFFwuZAM/PQ/cnkWzTMGHVOIHqpUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956926; c=relaxed/simple;
	bh=9jK0f3uZnQq3BPWPfouIRDNoRNT6gfQkiuDANJz56G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI+QeREs50cfOcnYpisHj+tzfMx3Bb/c79rjQdMBYbqFPb/IHnk2yLoUAHjso3Jf8LMOLW0KuJL9h7XIsW53XwQhl0NSq73/31jRhLpS+1GURuFUKgh1KnsadRUaB8DAkaFdfD9B3/gjW1L3qQF6LaSXnlttXluA7CvB+rdFk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gvg7MuZ5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso13934735e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741956923; x=1742561723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jW0gDL8Kna/PJVCnp4wFYE71t7XWzYqNhyjthOw/IdY=;
        b=Gvg7MuZ5mox6DGPByIB6bz8VbOA57qlGzMGE+Y+woagnaNbdOdGpstrzWKONKqnhIy
         BakllLtNMlA3dDporsaoLw+Dt1ccrmgqRWYbJkVU5jDzsdRjiE9HkaMXa2hSAAMHw1Om
         emBSVGIMgraMD4Q1V2heUPlb5vsjkOyk9BbU8oOoLbBSIEomaBe58ea/lVUm7ulF/4gR
         eseugb4z6sZWp+TI0/XjmfpY40VJsfBc966VIMgv8chhI4+vr/DS8Y03EKvAqV2XGrSR
         ZDF62VtcAWgwiHo7APlwEN6DqD0grBjnYNwgA+GtAAYpRpmoXIbi8QD/spMZvDlQiUxB
         qMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741956923; x=1742561723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW0gDL8Kna/PJVCnp4wFYE71t7XWzYqNhyjthOw/IdY=;
        b=TFELpGpPkxrhcKtJSjtUQRLm7epE4bxHK/edX0LTfyBoSjX55j8Ps8WYAWOd4ZrFI8
         Z0lImp6RzAaBHibLoGIs0zs0Dku3Mq5XI/YSHWK4NffZw8fA3pjj9K57xsHCpj+Itbua
         /OK7AI6T2Gc6BTOErL6qskuu5zCN1eqQQvG68N2HoNFTM79DX+yxictHojno39isKrT+
         tDXl4uh4cHNMQ2G6XDd+OdAfLRJMLbNUfcknw+m0QPLR1/bQcB9r4VaZUvA8oaEiPiWH
         6gBCyoUW9Wi+53zm7y7n3rHm0SRpt8hXu3Rqk0nYMqTzTahugnVfCyjMjDw3p5ykqRvX
         iMtg==
X-Forwarded-Encrypted: i=1; AJvYcCUlyoFgcpA6VTnc++2U8jb/IBpYrmP8FXP4aKiHLJ9nXK13YkXmdDwfpDcl4YedyxExYKCAKBG1bZdO7hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUF2sP85nTIhlCylixUjXr1OzzdOjNMcrH9pSVAN3pOuavk9YW
	R2tCDAf2kufvoogrwbmDOB4LReBcjLXojvwt1/0qrqhYrtDgg6ca8EjVJaByxMI=
X-Gm-Gg: ASbGncs2/U2t52EDnb5dhkJogZtR4ov4gx9Q48EWQaPEAvzTwP9c5UGnV8tdTtSNJJl
	faj8WWNan0sI5sj5nM77TcofXLR+GzGY7Hw0nNhFEuWrnmWcPSePcC4/XMDIXHmiO/X2EcZ+mlS
	Zdbw2Hll46boa0oJJ4ipz2E9SvX3aQgWMt6VK2SdgKVMHGssVgD1uCV6iT3T+Yc9rMsYfzU6yCX
	vlAKdiMrMK5DygjOhvQX9ZXtsU+o5bs58bxPOVNq36NNb9PoEB26TryAvpYvKPihpqSqMlEmZXf
	0fdNsmhUf64R6Kebl7RZaQxWNYM1G1PUkTefsz3lJup3kjE=
X-Google-Smtp-Source: AGHT+IGP/UzftlRh1pjMmvEXqf+wXC6TdWjAmGoFJkKf2HYEtOlmmlvDDOzWeFGP8hSZWK0Rt4MT2A==
X-Received: by 2002:a05:600c:3591:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43d1f1d26cdmr29402245e9.2.1741956922903;
        Fri, 14 Mar 2025 05:55:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe152ffsm16623115e9.13.2025.03.14.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:55:22 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:55:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 4/6] scanf: break kunit into test cases
Message-ID: <Z9QnOGdEaOP28YFv@pathway.suse.cz>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <20250307-scanf-kunit-convert-v9-4-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-scanf-kunit-convert-v9-4-b98820fa39ff@gmail.com>

On Fri 2025-03-07 06:27:37, Tamir Duberstein wrote:
> Use `suite_init` and move some tests into `scanf_test_cases`. This
> gives us nicer output in the event of a failure.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


Return-Path: <linux-kernel+bounces-320043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D897055C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32C41F21046
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC99762E0;
	Sun,  8 Sep 2024 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLP6ezko"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B84D8B1;
	Sun,  8 Sep 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725781147; cv=none; b=PGJTAlOzeETgwIj0CY1I5S9bTmHL4KqHn3WsHCfX/EpWvmeYmCDUZww8iOg2tzU7Cdo+oORJVb63jAhl92crK8zx0ePgPTmpvc6iJ4Vdmm6RSqNGtelilzvA8yJ4KB8Pmbzj7lsYBOBmEL0a+DKK7wITw1Jffl8jhXdOxcFPVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725781147; c=relaxed/simple;
	bh=64I7vfErZOzod4k7qSFK2tbeV/wuaOMW25Nmg9N5vL8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KxxYiPFK9IEH4qemq6A59Sats3v33D19cXSj/kG4h0QOIRJglhYh/dfXWCtbZ/0NwhSgHbJpVWrSfzH5Z7tzAZNSX8I7sf/NSk4Dr72mCAIt4WV0UGe3hqMm4rzcjX/tmNuSAfxsQFtDh2oZk1I+mrYDWtkoFez5oBP77F/YSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLP6ezko; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365cc68efaso1323373e87.1;
        Sun, 08 Sep 2024 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725781144; x=1726385944; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64I7vfErZOzod4k7qSFK2tbeV/wuaOMW25Nmg9N5vL8=;
        b=PLP6ezkocVlZSbvGFFhV6pVjkLtdtCgG+sRXOVUs5wm9hadCvmLRZlpsizp89L0492
         AakbL/xT2DWnxD3W5UuXtnk1IvOiBc3PojDQYe4IHP+QiiT17ygtvhR2ujV9R9Qq8/Yy
         1Venizh67mbaMOPZwxrlCjlR9tuKZgrUZNPjWvI5kC07IEM0wO4YxD+Vrlx5b5aM6mDN
         fF/P+SLyh2j+53jPLdjVHXR1ExY5jo2mEmmwxabq3+E4ZsP/q7MLhCPFYw6SnsEjj10v
         Z5HQvfKHgJDC8R7y9q8MpBpjbnXTEiogDVlr+3DGLW0jCaUIa1N/wM3+4a4BsWLdlL1A
         Q0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725781144; x=1726385944;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=64I7vfErZOzod4k7qSFK2tbeV/wuaOMW25Nmg9N5vL8=;
        b=W463Ab8yzpaMWh0He9aGqi/nCWlPrBSvuAOHO/ArrF7Km8qLLrnSf46zQ5T7JnqCIY
         6wXej0JLpLY4TGktyyUO0IjEjpt3rqozaWpGHZStmVJXgA6BxaLuZx2ZWOP0Vj73VU8k
         6rwmdpA1JbRuqa2V3AeavJSiSstvsxL87obmBSwLSuNlfn4Nnoeuur/pIV7dSLkHBN3+
         aKCpRjd6KRvbgi1uZQQGTOcQK5m6207bxVlnYlxHCjDhAiOE6sTODRIgnWU4J3JWfBzB
         0msrT5xQhzK2ARDR9GUwj9XK+j8FlSlorvMRbHTdaiL9MPtLm2D6NMrqWT4Tg+YQ+OcN
         UXxA==
X-Forwarded-Encrypted: i=1; AJvYcCUod7rOIpzv8XH08msjT8kR+n7dmIuWmwd+SPozq3DFCQVncEHef0kjpoc4rYULoL/y4ZjApfM3KwoaUvuYuDE=@vger.kernel.org, AJvYcCXeT6WrCinWOzazB2zWi2CPj5tGNbiVKX09pfyB3LVkOrS+Ff9HqsS4JCy5tJXbhJKPi4lJ8aPhZgfh/Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAv/crVMFGDC4ApuJrUu7ltKKAIFJfpgCv+TONLrGpR6W9XFn
	svwU3PnWXtksql0m7PZofGR1rjUFrEJvuT9jq1gL/rvuOQ23WcRZ
X-Google-Smtp-Source: AGHT+IGYbQ/tZ9A7jEdogRo13GnwZSRpklkA0CVbhjhsug/z070+DfvvvS9FBenqCOz9K4c+wdO3vA==
X-Received: by 2002:a05:6512:2313:b0:533:40dc:8248 with SMTP id 2adb3069b0e04-536587a5453mr5317598e87.11.1725781143815;
        Sun, 08 Sep 2024 00:39:03 -0700 (PDT)
Received: from localhost ([194.127.167.96])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f9139e4sm352736e87.302.2024.09.08.00.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 00:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Sep 2024 09:38:59 +0200
Message-Id: <D40QCUK9BVHC.8W0E99JLSXX3@gmail.com>
From: "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <patches@lists.linux.dev>
Subject: Re: [PATCH 05/19] rust: enable `clippy::unnecessary_safety_comment`
 lint
X-Mailer: aerc 0.15.2-211-g37d5fc691aff
References: <20240904204347.168520-1-ojeda@kernel.org>
 <20240904204347.168520-6-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-6-ojeda@kernel.org>

> In Rust 1.67.0, Clippy added the `unnecessary_safety_comment` lint [1],
> which is the "inverse" of `undocumented_unsafe_blocks`: it finds places
> where safe code has a `// SAFETY` comment attached.
>
> The lint currently finds 3 places where we had such mistakes, thus it
> seems already quite useful.
>
> Thus clean those and enable it.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/unnecess=
ary_safety_comment [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>


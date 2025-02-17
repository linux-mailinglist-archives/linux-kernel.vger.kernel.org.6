Return-Path: <linux-kernel+bounces-517386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F0A38024
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12A63A2154
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362881802DD;
	Mon, 17 Feb 2025 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aKdVlrzk"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD1216E14
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788064; cv=none; b=lzj2uZi63PChT1MeeDA/0ThbX4z+p1CzyFi6RbuFIidyT0EVGY15lIgQzSSW4DW7wmficJk1U5TYP1YETwWs2yvhpdgUI3sJsohpnoAGlLoWNn9U86wDkUWwydJcTLF68h0Cr1IrZkD5iZwi8A2rsdUhltGpbcvue78RbT4lcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788064; c=relaxed/simple;
	bh=EK+112KzZRYcpPHXSL1MB9m3HLKRqSwNI05I9TJltSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8BTe0RJhEXkwXNXU1yoXaBaZtl42oCPomMtsHs5pqS7tT1IXoeQvbdViO+AAdGM3LYVliHXA2hEfTTZ9shsEAfiRZwiAC871AGji8zNgj4NWKKxzwCTaF5j1Ku7SrKOMJr6BYz7Q8XFaeVfsK0ivOLOyaI24DWm1iV2XP2/f1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aKdVlrzk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so7622203a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739788061; x=1740392861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUsyjtdwJudOrq2BVYPPPLmXtZGANjt6rB5YxXGDCHQ=;
        b=aKdVlrzktnUkea5HDMMTnv4ZhtKw1+cqiE2E7M/JLSD9dR1je6nfLe2j2xbFdPKUqM
         3bX9gCAsdlslWcmwZ4MWquO/rzZjSjbtzutHhQT3MSFvuG3rgIcKmS6luCa7Js+op8Jk
         7o5ZJ90RwwoC1O6PT9CuXGfxrkugtmxsnj+3HCq0lD4cy9GqvIoiK09QGSLZ2eE44FtZ
         I4bTF1qy/Powhb6dEiItCyRjdDDHnutTYmqReZH/Zg2KeF7/8nJPL2DcFpDwZnlhWRHK
         P31pQEMDuFWtXqk+LJkbqWC1fIYDPkBQpwFrXzuiWVarEsZEFPTdt8h7T1stS2K27QEa
         YsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788061; x=1740392861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUsyjtdwJudOrq2BVYPPPLmXtZGANjt6rB5YxXGDCHQ=;
        b=uLjy7gUbW7aC8vWSnHLpjx5xdz6tT9hoeOi/D44Be1ScyG2Xgj09f46gJF5Q+oqBcj
         d0SlK9u5ry5H5Ici429x8QAzz60SjH4+i1IF3PM6YI5+pYSDB53X4vwuzv/lVJZprtRp
         xeMTQXcv5aAWosjQG49JMzvYrKYz8Vs5NR3xhPs1p8ta9P8BbmVuSE8WpBFEsujNYFNa
         tGHjfa6oLchXbO0mr99kXcKH4lPW/NBiq9itHW1ikyfV6QX9Qn/iNNzxciznU7AhTWzd
         LScGSM+qnc1eXyRluaXGIZC5jbAWkQjcfOa24e2HUiLcHhRBiL5+EIWXnzQiHpll2Tsu
         4vEw==
X-Forwarded-Encrypted: i=1; AJvYcCW/pup1g2cjho5Wq7TAAUDmjkq2nLn74ojfh/8xnA4ZR0cel2lwi1AC3HaGPxzGfXVLNPxjIHaauXNrsm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIwyLbRvF0/+QvVqQFoBYjQTc1uE+ujNnu608sWoO+xRByYpt
	GLjtvX2PSp5I7SzivqnLBMiK46XZGB+g09dy0OxNgNHFidF+dsQ8vYBGsroME1k=
X-Gm-Gg: ASbGncty08obgMtFxiUsmD94AfwOf7uVvwKt/TPhuxRfTDw4TLc1gCAYW4I3HP/DW79
	T5gEO/goF4+WspV/ivJLUpo1cOap1SIFNnIwIBPJucTc4ZhDpReJ0Tcfn/6PBPxA7MV1KN7t0A5
	C/UdoAiuztjW2fPPqLZW3z7ZzEhh4+kohrHtuOnSW8H9FeUAB2ZbtbIZVDug87WAaQjoQLIE6p9
	EpIHRi1F6+h9PONOw0VtfgPzmGprABHzy4yAYxw8dBrdTJj587/9dV9azhsgHBO3A5H4suBlN6R
	d31B5WUS9BEBfr8o6kk=
X-Google-Smtp-Source: AGHT+IE+SP8oa6aMi/Tazd2StJ2PQQ1xliUBBqg3M956avxBmZaXfoRNcJbotwH3UYKzBBxyZyxzjA==
X-Received: by 2002:a17:907:80b:b0:aba:519b:f774 with SMTP id a640c23a62f3a-abb70df5d81mr943214466b.52.1739788060920;
        Mon, 17 Feb 2025 02:27:40 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm309892566b.174.2025.02.17.02.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:27:40 -0800 (PST)
Message-ID: <7798e5f7-11bb-4ef0-8956-1208827cb097@suse.com>
Date: Mon, 17 Feb 2025 11:27:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] rust: add parameter support to the `module!` macro
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Luis Chamberlain <mcgrof@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Greg KH <gregkh@linuxfoundation.org>, linux-modules@vger.kernel.org
References: <20250211-module-params-v3-v6-0-24b297ddc43d@kernel.org>
 <20250211-module-params-v3-v6-6-24b297ddc43d@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250211-module-params-v3-v6-6-24b297ddc43d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 16:57, Andreas Hindborg wrote:
> This patch includes changes required for Rust kernel modules to utilize
> module parameters. This code implements read only support for integer
> types without `sysfs` support.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

For what it's worth, this looks reasonable to me from the modules
perspective.

Acked-by: Petr Pavlu <petr.pavlu@suse.com> # from modules perspective

-- 
Thanks,
Petr


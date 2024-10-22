Return-Path: <linux-kernel+bounces-376184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47E9AA140
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DECB22D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D6199FB5;
	Tue, 22 Oct 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RvmdFMmj"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51719B581
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597178; cv=none; b=N8Z+f/4vg+mThXCloGaMHomSYzDJFMj/51Qcqe/an/JlCt2uS7vv9m4YdTD8lBpZ+JKQgUuJyCewgrzlxyZJWF8AnEeIOsHxFG8M0bkEZtTmgimTCEwCqYmJKovz+3E7UodAgNQIslQpNjV3fUhD9vuxUuEEKW0MTD/cphz/HKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597178; c=relaxed/simple;
	bh=Q7UvAeo7wgj55k0tHHcaQIz89W2aiZuE9pPZIebFQSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDRF0n/BbX6dyl9l31tkkApvlOyt7PxD7w+u7gU8BaEdKTbWpACg4RWxfUUNV/GOpYsU797jDXx9k3dTF4ddTdIRdyUAaXAFUuIpg+3WMtYXE1AxUMXFd1JcCpM53gpOCBQaUedgVnYP56+euZGbwa58c12kg9kvcuIQxiAH1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RvmdFMmj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c962c3e97dso6612299a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729597175; x=1730201975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdmnWgCwPxxjygGThsGOmIi6siTSsGy/bxkMND48qlU=;
        b=RvmdFMmjjYHWYnajh/TV7Yo4jUiYxdg9WqunYp9YZ4vZ2Boc0uNgAIgqpd9T6u5QFQ
         zXWwBwFeVnCSBvqlHb1pkT+0tSLTK7pXcFYgVH32Fdoo9J6ZuRopWqBck6NDGw+ktMvZ
         JACvT0YIwNfSTjMugu/TxrVOanU4BGlLXrw4xIwf245lmulnNGjfjtt4p7LkROZp2a/Y
         NFC2bS1lAsCgSzUtMHp7rvjrlN13USTmio1K9HpNwR6qn+UtG0d9syUZEb4vI9BCBpEz
         0oLzM25D2f8fDQqkmnZe3RyPs9Mwm550p/yZ6A6eXsjpoFrgdLN0RveZAiLKVbG9YmOC
         iS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597175; x=1730201975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdmnWgCwPxxjygGThsGOmIi6siTSsGy/bxkMND48qlU=;
        b=P/YJqy24n2wyzahS+DEw7U/vRw+Ai88O5e8GPwnnm0AfcPJ5oUyQ9mMhmaPhximvwA
         wgs3LKfXsMAK73AMfVjEPQD//pXGwOZszNwNbMuYARSO3p+TRCtwOjMAfPBhrc6rXcC7
         bw7B+FOmylD/yRr6oaaXHUqCzvKxgmbIfiKgOSL9W7sSRfufmiWELrQ/Ac+M/0Td58Tj
         8lP9CxwzM0om2FXJMmU9Kde/uK+3ytzINWnlDXVUE/ozHo9o2mtRtqwNppjYSp/57Hqj
         yi1fH+DGh/PQNTM5W1Gn7+hqB0IZd4BjeFZ2Lc3R5kim8BuyX9wo5YOHAr4tMhVYU6zI
         gtHw==
X-Forwarded-Encrypted: i=1; AJvYcCXWmpzS+RppQ3jAqtYddR7vON+SAbGIxkVpfCbPIAjNRXTQETRB+7PsXZyPOLlHcq31vbspUYxGENabmTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56dtN/agfgAsUc1c9CaC+RViMMTJL/edvdtN0coro+xt2zTqT
	Zp13LY2EXd4cef0n9yc9HanpVhh5285Pmte1S3gDh6GKMSlRIeHY8eE44S61jJ8=
X-Google-Smtp-Source: AGHT+IFwOWA+ThxyNU6js2FSv7eSZcv26U7aBvfGZRHfZ7plL8dQmDR2VvtmtU0l0YIs/RmLPfk0xA==
X-Received: by 2002:a05:6402:370c:b0:5ca:e5b:bbdb with SMTP id 4fb4d7f45d1cf-5cb7fcfdf2bmr1649962a12.18.1729597174872;
        Tue, 22 Oct 2024 04:39:34 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c737c4sm3006495a12.96.2024.10.22.04.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 04:39:34 -0700 (PDT)
Message-ID: <5dd0af61-05c7-4a17-8fbe-31a317824ad6@suse.com>
Date: Tue, 22 Oct 2024 13:39:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] gendwarfksyms: Add a cache for processed DIEs
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-26-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241008183823.36676-26-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 20:38, Sami Tolvanen wrote:
> Basic types in DWARF repeat frequently and traversing the DIEs using
> libdw is relatively slow. Add a simple hashtable based cache for the
> processed DIEs.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Neal Gompa <neal@gompa.dev>

Looks ok to me, free free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr


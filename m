Return-Path: <linux-kernel+bounces-272509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA96D945D55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85462281818
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADFE1E286C;
	Fri,  2 Aug 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgH9HJ8+"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3F1DF67B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598923; cv=none; b=cmyAaOo8pPYHYpJmEHa3q+TznVjHXFz58R8wB9LMMYZ7HCpBtnfQep4BdGXFEDcv84IIko1OiLdC7N7xoYh6lIEqNwR2z101PQIKVNAiDytRiUIUqeFKYUQEOV/hzp3jl3Qn4lVRS0xTTbY2z7YKKjkeHlPskDmS9mA13nIKP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598923; c=relaxed/simple;
	bh=8S6p9awCbWfTs8HBlKagADZW0s6ZNmODF23unQPAk7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+6GE0hdRHAMo3a/10yeDQGFxU+uu2CG23Rhc5vE9CSXN/yJYNBE0yCZ0U5jRt+5qqti8rYVepbKzlR09Mvc12LLY9B0sIITcmVKH9doEg918udacafw3EkleauauRqn6PF+wxlfne6Q71vWcyvzP8BC6zpnQyf578FsNQ4t44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgH9HJ8+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso5507971a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722598921; x=1723203721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S6p9awCbWfTs8HBlKagADZW0s6ZNmODF23unQPAk7c=;
        b=mgH9HJ8+KeApHbOAGPrqD7v5NOPKcb1d8ODdbZJeBvBkFsA7r52/Iw5Lo486KPVeRk
         L9kgHWduPQEg32o/Pr2qYiddrxs+kv7pWCRJkkE8Ac/fjrfadUiQbQkjwLqO5xkz+O5F
         AB9zkTt2+JhQyTLkm/dq0VN0eXUnV2/2gaQ/u7pRIsDT10x4cYHrdZLpXZCntQBUFu7g
         Os4bhGTfZw/jQxVzTO4y7QfZlBGFvvZiWwMTK9n47LL3p18S73PGhWBLAO8RCZ2KYM1Q
         42kIzv6IfhL3Rt+7gbQv1xiRWXz2Tk0JXQo/37lcqPzWlnqX7p7P0Ht09esj6I89lQOJ
         V7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722598921; x=1723203721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S6p9awCbWfTs8HBlKagADZW0s6ZNmODF23unQPAk7c=;
        b=EGG59D9tds7aH56pk8KsdvxK2jvfkqvqfeC4t5fVpUUEmr8ibC8TQcNJerqmfb3SPt
         ih6eYVbv5+gGo5BfBGf1WCgI3VXn09M7MdELnINT/hRqFNE8qKWeZCUvrT4X0PNkM6Lz
         oQKD3XTAoASMF0jrb09XTvpQrA6vaaVGlgkWSNgSxtyYQhox6jd1QJU/BZ6d4/D7vEoo
         WrUIF6GqrUZuIHHS39hxRxqtJg0hiH4GzXMd9DpTJPsW/FU0LHvuN9mHNXjp5aIKLL4n
         5Vq7zT/cWXLG08vKJuqNxn34LkJL/5urDHIt2IXF2MOZVCDAlBgj1/12e17nkT4r047v
         2+jw==
X-Forwarded-Encrypted: i=1; AJvYcCWh9yrAfRlZO+2MEheDCrF+36p48iNwlyIcV52zcFUx0tXCpAUkihqWhuth3znSzah4NrYVjFH6XMx6cwfs+sIJCy/aTyh0mv1BKb/n
X-Gm-Message-State: AOJu0Yx6jXqk6VeoF4QvCB8nQjrzBPtIaZmA6yeApmefau+iFQuxOJUO
	TSufYx0tnDLu2thQaVEVlzMxbRvOvubyP5B5Q508spB1agUPr2oSYAlu90z7HPpXzvDZd8YGBBA
	qqA4v39LGQVYz7YzWjoeJcXUYcz0=
X-Google-Smtp-Source: AGHT+IFfTNp9sbkfU2rlJ0CAP0uftsoVr57L2GgZMd1ai2v8/T3RPaZ6pt3iGQwfXmZUpG+qZxLYAFaOA4J6UzOiw4o=
X-Received: by 2002:a17:90a:df13:b0:2c9:77d8:bb60 with SMTP id
 98e67ed59e1d1-2cff95670e3mr4034882a91.35.1722598921465; Fri, 02 Aug 2024
 04:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-clang-format-for-each-macro-update-v2-1-254fca862c97@gmail.com>
In-Reply-To: <20240730-clang-format-for-each-macro-update-v2-1-254fca862c97@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Aug 2024 13:41:49 +0200
Message-ID: <CANiq72k+7dedfMpQUgA6ZuNmWwQJ-oQYQWzhN1JGynbxix5bPQ@mail.gmail.com>
Subject: Re: [PATCH v2] clang-format: Update with v6.11-rc1's `for_each` macro list
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:54=E2=80=AFAM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Re-run the shell fragment that generated the original list.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied to `clang-format`, thanks!

Cheers,
Miguel


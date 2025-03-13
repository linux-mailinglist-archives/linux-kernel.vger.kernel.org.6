Return-Path: <linux-kernel+bounces-560418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE8A603CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2706319C3418
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348EC1C07D9;
	Thu, 13 Mar 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLp/Hzsq"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70D1F561B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903070; cv=none; b=VvyOt1K47ofZPT8l9m50nf6gaM8NFgbfAV5YapF92U8rQX8CnAH/3lqHqdd3u12VRTE6ETjLUZ3j58hn9jvJ880mdnV7ZB8QVTThXqQwvzWQ1GsB/BUWMUAEpR5t18cruA2FIsVleuXKHi0uVsORUi0lp7vZr104g+XteFUZs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903070; c=relaxed/simple;
	bh=wkxUnKWC2Yc4q9NrIhzQPhasKzAvDUxfsq4o/HmyFUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5aZipFlaTkmyGZGwJDCueR06m8bYlralzRT3RhSpaWI8lfvJPjCL24Fk6YORzIUFI/sCeMolTilz29AV4hU2wKbwgEah3MESL8MRR/4k+JMUsIyDEqOqCj5H8S5v53j4c1YSYGlm10vz1DufvmV/verOnUYjPBA9rdNp90NXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLp/Hzsq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39130ee05b0so1447778f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741903067; x=1742507867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3M8X2QWckUY8UVMTuD9mXen2KDDE46RLeaO6zC7dTM=;
        b=VLp/HzsqOj8JJZA6vjsf9oU5ukkoIl97W6Zu+/lQdyNQd/6awJWq4Rj079511rqNZl
         +Jk03ttfmqhxv+SzhVnX9HlRJ3w7TeJnYg/Zeqn/Y/GSdElAl+243jRikIBlLRlUgGGP
         p/VNYPjUEl88B1fcMrcpuJvM5tnqhw7i2rQLPhUYITmAKZB8XyIWkWzYR2cz1GmGTQs3
         z7cXWo4w6Tsv+VlwzeRuCOy+dPN9SLmlqS0NDYAn5W/b4rY/wVHwaNTprTHd2i+xZYw2
         DE+/LIcmMzU9c54R4u/3GxafjyOwGVCLnp0kFP4kUwgHtlMPzTr/fpAHtxulLio2wmOD
         kGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741903067; x=1742507867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3M8X2QWckUY8UVMTuD9mXen2KDDE46RLeaO6zC7dTM=;
        b=nPQ/G9tym96h1ffI5suRYTdzO33zmC14RNkDv7z8BrajzY2bxLgszmCg1QFHlwRiI5
         ExbJtAR5zXCP2+oWmMNONJmXP9069OmXqugIdr7Yun6BvrXnb1j3qi/EG2uJWRuRtrDe
         WBrWeBUGJ7v2rUYY79E2x0cGItjHfZdqQsB8p8Ex8tQP14orMv0QZJMLSKPylsjsUm/g
         D+kWkFL++RYSKVgMDzHwTAYoM3HyvDznWLPDDG6ekScOqnzwCOrJCrEKJy8nOT1owiTC
         SmBjOoyXMOZAeaLrhyLTuvA4wUTr+aXxVlmosRTyshTi5qtO4ODjfdVm0xqmNr395hzu
         QZEg==
X-Forwarded-Encrypted: i=1; AJvYcCWHY8Es7f/YnPAPbkjWSqeWNsw3GxI1Zd0dc/yET6OregNBBW0nK/wYa7JUMtfDHqp/UMdbownorKEW3b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYh5KxtiVGHkXRtKeFjJGNEcFY2OdDAiWlJPzA2e+LIIAQav+
	Omt/HSR6fBPdWpjo/k00BH6I2mTH6kf9a/iTlDy3Heqi0w1W9vKL
X-Gm-Gg: ASbGnctKze4ETmZvN2gJ46J6KRWqgvW0StErb8Sis+HWua3EMJwER9pxsxmlrxuJf8+
	hJhayf1EuI5EHiykdRQ+ujGziSoBlNJGZqy74epOiBj/Pa7Jzycr5VmmCZ6ZYQSaWCEDtrGdf0u
	/IpZ01Rem9LXmgcsOOw+sygtsVHnLZe0FSRczSZVB9w9iNJ9G7xQLnTPH6TBrU37GnqP0YfdR1H
	LQltZiaUTVxwlX/IsYixIDjPlPGq7TuQJcI9qr3sqggvJlzRQ9JmnSy+NSmBt3Ws42KW9PZvzLp
	XrrWRIcBqg05hk4jcg80oDcEUMp5l4ge1mvcRAakMz3ZM5VGVys2nDk3Dgzp2srhLoxST6L9hPj
	kA+ufstU=
X-Google-Smtp-Source: AGHT+IHH24pd+b5gL54NDaWwuWMDj9OGu+oF3QMwmPgdGW9oUb+b+U4WJtKrTTYmfKHOFBN/QTa6kg==
X-Received: by 2002:a05:6000:154b:b0:391:412b:e22b with SMTP id ffacd0b85a97d-396c200fc00mr1190205f8f.18.1741903066987;
        Thu, 13 Mar 2025 14:57:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e92sm3443876f8f.38.2025.03.13.14.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:57:46 -0700 (PDT)
Date: Thu, 13 Mar 2025 21:57:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, yangtiezhu@loongson.cn,
 maobibo@loongson.cn, guoweikang.kernel@gmail.com, agordeev@linux.ibm.com,
 ast@kernel.org, usamaarif642@gmail.com, jiaxun.yang@flygoat.com,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhanjun@uniontech.com, niecheng1@uniontech.com, chenlinxuan@uniontech.com,
 donmor3000@hotmail.com, Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH] LoongArch: Fix use of logical '&&' with constant
 operand
Message-ID: <20250313215744.69a976aa@pumpkin>
In-Reply-To: <EEBE30D1ACFF646F+20250304105246.766404-1-wangyuli@uniontech.com>
References: <EEBE30D1ACFF646F+20250304105246.766404-1-wangyuli@uniontech.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 18:52:46 +0800
WangYuli <wangyuli@uniontech.com> wrote:

> Fix follow error with clang-19:
> 
> arch/loongarch/kernel/setup.c:335:40: error: use of logical '&&' with constant operand [-Werror,-Wconstant-logical-operand]
>   335 |         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
>       |                                               ^  ~~~~~~~~~~~~~~~~~
> arch/loongarch/kernel/setup.c:335:40: note: use '&' for a bitwise operation
>   335 |         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
>       |                                               ^~
>       |                                               &
> arch/loongarch/kernel/setup.c:335:40: note: remove constant to silence this warning
>   335 |         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
>       |                                               ^~~~~~~~~~~~~~~~~~~~
> 1 error generated.

Isn't that just 'an error too far' ?

There is nothing really wrong with compile-time constants in conditionals.
The kernel is full of them.

Why not just disable the warning?

	David


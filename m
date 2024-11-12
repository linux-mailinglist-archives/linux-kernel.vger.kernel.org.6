Return-Path: <linux-kernel+bounces-406674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BEE9C6218
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B171F21C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40D219C8C;
	Tue, 12 Nov 2024 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IDqYPjp5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7E2194A1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441821; cv=none; b=P2JNDigPJGNv9/PXSY09mt9sQnMPcJFLrcCgdtGpGXbuoNkZVFxPdRSetxS0Ag9Tj06xpSFL9ot2dftfEsBVO69uMPLVye6SWWfhH0aoTLmB61lY6meBQRAszobC/7MTfm6g9IJRr85RARTq0YIDGvRrDI5/aIMFa/987P7HOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441821; c=relaxed/simple;
	bh=xrP6+FGE2fwqgOYkUpIVQ5whv+1GBy2TTVi6q8Xo+Wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVltieax/aktV99OEcv2wwwbx7+WR3MAcUGT0kQRB7TP6KJhqSeVtty6K6DR9TKz2PB3nZyuRYAd1rptDk4paFGEANPMRgoB6HD701o8H6aNRAWM+kt4jyILcc4VK1RvN2x2PKStWk+bA8N/qCbj4UoSlA27B8dNGHS0S25g1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=IDqYPjp5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso812148866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1731441817; x=1732046617; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucvXhHsK+I+uJFEbTUTgZDfG36LwLVhXYuwztsDoTzg=;
        b=IDqYPjp5JkJnabzBQjEnLtazW3ZwvWmdFMxLKxR4BzHRHBIVxWh9pBXn/UtGOW+F+0
         4Yjqqy/I0os5ExnLw2NxXzxtBcpeXbOmiuujEabh4j3tXNi5lYbQTdsLV7Dx5zcaE82r
         dQmZ49wICGPSFmvJcsNWYf/5AdoxnaxvuagMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441817; x=1732046617;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucvXhHsK+I+uJFEbTUTgZDfG36LwLVhXYuwztsDoTzg=;
        b=CLJbXgatmu4m8AWlJYvPr4QnlJYs28tofP/gvX1f6gvUi3o/uO4QMBtJu15VaQUuBa
         DLGXrM0BdQE89tOh0kYDtKu9cSa2bn82Tt8qOde19ESLtBRCTMbA+p84tf1l4Fn8K4kM
         14UuhNpsyOoAnqygSWMqPpObuY7L9bduilr10dFh3NogDkcqT1krCYrdgeTNcpkHhMFu
         14AjlzvHC6PvkfDcdzTfkDjCHkipT1bA+JyHqIZXypmHIH/KuxkspmTkNE4btkmi+JNq
         1MyoJQ35rhuMTeTpMK1t1bMzdcVoDgULHUcAGdXHwR4BaIYlFxCdJK+tD/7nZSDwvRT/
         oB5A==
X-Forwarded-Encrypted: i=1; AJvYcCUs0HON9zAqXgflFeFffSwoaheq33vF8jurVYGymlJGW+q8AV/8A0DBH292y1R6bXr5V3YpcdzrAYFHNlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbrnQm0WunRMnZ/SfArZTFNXr5bd/Ys+7wvuUUWs+6Es0KcCC
	lnGfEmzcLPVuRDIC2Kz4V5/t8UAyJjJdlv1YHj01rMnti3zX+x7osPILB1qSCJ8=
X-Google-Smtp-Source: AGHT+IEfm/HYhyCqDsIA0pNxgclgk5pS0Iwj7opt28zFm1yUmMwGW468e0PwLXcdMCNdjBqBgUzgOw==
X-Received: by 2002:a17:906:c10f:b0:a9a:8028:45d8 with SMTP id a640c23a62f3a-a9eefe9bb73mr1840741266b.7.1731441817489;
        Tue, 12 Nov 2024 12:03:37 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c18sm764625366b.121.2024.11.12.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 12:03:36 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Yury Norov
 <yury.norov@gmail.com>,  Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-sparse@vger.kernel.org,  Rikard
 Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] compiler.h: add _static_assert()
In-Reply-To: <20241112190840.601378-5-mailhol.vincent@wanadoo.fr> (Vincent
	Mailhol's message of "Wed, 13 Nov 2024 04:08:39 +0900")
References: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
	<20241112190840.601378-5-mailhol.vincent@wanadoo.fr>
Date: Tue, 12 Nov 2024 21:03:44 +0100
Message-ID: <8734jwnrrz.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 13 2024, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:

>
> Declare a new _statically_true() macro which, by making use of the
> __builtin_choose_expr() and __is_constexpr(x) combo, always produces a
> constant expression.

Looks sane, but $subject needs s/_static_assert/_statically_true/. And
to be completely pedantic, macros are defined, not declared.
>
>   - above examples, and a bit more:
>
>       https://godbolt.org/z/zzqM1ajPj
>
>   - a proof that statically_true() does better constant folding than _statically_true()
>
>       https://godbolt.org/z/vK6KK4hMG

At least the second of these might be good to refer to in the commit
message itself.

Rasmus


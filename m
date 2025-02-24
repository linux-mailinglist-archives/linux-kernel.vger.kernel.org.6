Return-Path: <linux-kernel+bounces-529739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E679CA42A60
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C4516777B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E86264616;
	Mon, 24 Feb 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HHEU1r1x"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249A263C7F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419627; cv=none; b=NG/KPrTUHFKoN2gtYHD7BL1kIcgYXjqm1AKVn9a9SbYUtquJSILDZio7WmyIGwVtAw47LNBcHyIK4KjVQ7zfiB1YYv+WafPSElLY2BZg5DBF8yA7ge+tJylqtVtCHUwtXNxf4KdAlnfj3FArQMGcczvpP9G09+iReI4jq4RdK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419627; c=relaxed/simple;
	bh=TJOZAeIIJjbAum7vKPxxSUEgL+PtYhuuKao3f1L0n1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keEGqvuxAjFUx5r0ICVC3brlVgw1ktvcCjaFQm8EmgESWokzwgZZfcZXhCKLCBwxcILjCbvY9LVhtywxSdSVJON1nucvKGaPfgVDRMxqQkAkH3TUza9wXfPAE/TSuwhegVPtzG4TGkYbAI+ti1aFYKAD+IquQq9ZljmwQIO6Im8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HHEU1r1x; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2217ea6d8daso12111965ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740419624; x=1741024424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJOZAeIIJjbAum7vKPxxSUEgL+PtYhuuKao3f1L0n1w=;
        b=HHEU1r1xYZyGse+hRh6l8mD+rHhmHd2yf1+BobGqZvaNHSQsOeQ0C7XC1WTUjjqGQc
         PUyvc3ekQ0sw2PpXrHQfAhYM7my1h8l/edTEqYPQwl4L5o6DGpfECeGtt6MvaYuesgqL
         4YJ5rFK7awO0CUEkbrACDaiAuRzrNZyqGZR1jkIiOCjZXLQabxuAT25VKiegQHc6vukL
         K0REQyckzVbKzhhAT3aFJpWMzUvTOVBG4gft148c9CY4ANTBQxAKZ/Hcu0xg0PfxpWQ1
         +sy7AADJnWKutKenjokbYD/CO1bzc3nyMyGt2Gf2N3ElYJYyQmTuVawi/8A1qwcVPUAN
         uRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419624; x=1741024424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJOZAeIIJjbAum7vKPxxSUEgL+PtYhuuKao3f1L0n1w=;
        b=eoEfkgCPWX5/oMDX9xgImaSazir82CX+Uf3LqDbhHKWd+mM/Kld78cNbdj045sEIX5
         IpIqK6KnmXSHat4Rhjm38ULGI3p6E1uulRiOgmDxSTmuD06N13kU5LlxQPyE0o1/DvmY
         tJn1qC8JERcGo66ceKhwZz8kPtTLN8vhtiUw/LZ0wlnt9J8gQFz/ewxd0AE75iLOG6Bo
         FHbsBtDjIXOP5HYVlilbBROvCNjuKQ30xrzTD0KsAkm+Hfq5e0kwOT1Ym18XOhfSZnqf
         DUTxZxg/x/WwAJxK5mQVOxjOimfCcaC385SGkxh5+tvajiFDd3h6sms4CUwNIvrUq3Ut
         RqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK9AWSVXjSVU+uO8FFiHrjyO/D5FNW191K5Ac5uzQfq0yfvw4n0qyygQaKXm7BEKj4xYDTMd33cg4I670=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzWfu28EKPs6BBxsnHnV/TI0Ef3CwHg7ZepOPNV5NDGcEEBBtG
	o31D1r4WjVYK4hFpGi8q9kAyD/sXLEso4SgmWz5IbHq/xTJrKQn7lqekyU59pSAc/J5kLl/bj7/
	OrjrdOcg3JIwYvPirEdertG+fN3KLw1FdOuy5vA==
X-Gm-Gg: ASbGnct1dXjKf2TEuFzJBChHxsjgVbiVBz6kPCCHIG7g/qXyOusflYiV5HSjmQXccDa
	CBMUbMaDKsSVLgg/Y55gQZNKewFP7O1QiV+N6RibOfaMVWwS/Kk2J7hgSEXwxq9DIMwHsB/MHhM
	h77LgfhWY=
X-Google-Smtp-Source: AGHT+IEmKSr9StH1o6AjwBks6b3kLW4tgV8ow5+DNqt2NPti+5RsJWBpzngd6Sal7T/kd3TjhPM6F1HxVfZa0gJCX00=
X-Received: by 2002:a17:902:ec8d:b0:215:435d:b41a with SMTP id
 d9443c01a7336-2219ff31246mr85389055ad.1.1740419624625; Mon, 24 Feb 2025
 09:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224172337.2009871-1-csander@purestorage.com> <ebad3c9b-9305-4efd-97b7-bbdf07060fea@kernel.dk>
In-Reply-To: <ebad3c9b-9305-4efd-97b7-bbdf07060fea@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 24 Feb 2025 09:53:32 -0800
X-Gm-Features: AWEUYZlZV4sj4ZGftiGUyWKPl8ccOi3mmENvFBBeSC3j4cgo_ltS-EW9ZaRDYOk
Message-ID: <CADUfDZrXAn=+4B9boaKe3aMBq19TXn8JDQm4kL0ctOxwB6YF9g@mail.gmail.com>
Subject: Re: [PATCH] io_uring/waitid: remove #ifdef CONFIG_COMPAT
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:44=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/24/25 10:23 AM, Caleb Sander Mateos wrote:
> > io_is_compat() is already defined to return false if CONFIG_COMPAT is
> > disabled. So remove the additional #ifdef CONFIG_COMPAT guards. Let the
> > compiler optimize out the dead code when CONFIG_COMPAT is disabled.
>
> Would you mind if I fold this into Pavel's patch? I can keep it
> standalone too, just let me know.

Fine by me, though I thought Pavel was suggesting keeping it separate:
https://lore.kernel.org/io-uring/da109d01-7aab-4205-bbb1-f5f1387f1847@gmail=
.com/T/#u

Thanks,
Caleb


Return-Path: <linux-kernel+bounces-511392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631CA32A57
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DA018841C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6DB212FB3;
	Wed, 12 Feb 2025 15:42:28 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87427180B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374947; cv=none; b=Qpf0OsyX3NxCzCm7JeuxDx4xilpjWrVWac/2GGAtJa0KgmIK5cOfHIpinHI/Ew5mI50vc9K/rW3Q9REs17RqJ9MR8c88vCM+gmcqjgHyKvZJhMu8cCT67RxNta+EhNb+vs2x+WNjn3+JbfB2lGrPwDIuVMJJ7g0UwDwvjzOkMQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374947; c=relaxed/simple;
	bh=CVqII1S4rZjar1numyYt6ePWthTCjPSKc/XcmKsEYpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMwK7+1nP84qFyGN+G5/aLK9WkSa7IIUIx5Y39iCLC4R2CUZmp9w85WEHD5pp3c7/thge+zeEP3gMdb6nCzzVnjwztDyw/cJV53pzVo1TMKDp7HIOvZPGbQ9olK1+grtkoboFznSqy6+umR9D0teIVoxOFIJVU/795MyyVcv8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7b80326cdso666493166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:42:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374943; x=1739979743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9Gpp6exxOAKgR4+qfssuhnpHihI75y6MvQ08e29riQ=;
        b=ARpraRx0nB7oALQ+EnmLA+/TUdO4NPNkr9HYIF3A3sIixxtm2gBfvc+eOLfvc1VFJ2
         b5Wyrf9fvYE0OFRNqW7+Wuzt/puOb9ROUp7Fhb8uZ44+RC/EUWrEzPGJVu/h+z3Xc8Ba
         gDouv+3c1350YTSja+MKVY1hxiwm1W7UwS0aMrEGV+T7B2pfW6UBwtEhQcEc+I6qAyJ+
         4YIvTJTrKO8ZDj6KDY5271hL5oKfWd/XOXpXeM2mYp1/eyIg03yQ/dkGzFhSV4oMQxwI
         Nv1ZLBpRQF/CF4+uZp/MQW9Tyb36UWonuw3z8USDCmVzK8egVdcKp29WZ0EUdgDP1CEF
         mNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmaRqHJ43ojO3wBmqHlDUA4RpjIxWIf+iwlpe2bhtEu2jWIdGFvGkoPmWNpRKiGaGiS0u2r3u84+uu26U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTsrQm/JbOrgyzkQUP2DF6XrtErLd8y0E1MEJU99ZVTZdu+Nl
	/XDC3kpujrCXDEN9fpFMdW6o6BqI34fQtdgCJYA0DOfhQME/LvaPNzaQ75sQ
X-Gm-Gg: ASbGncvt81ety/4pXMW6VjzLJB4h9/bX+BB7hJY1FZ+rWntvEHxO7SUYEzf6wnfQTyT
	IVZioXLxo0ZbObK6AO7jn05NYm/dfhMNJUVedpsLCkqNjYCZ/B8BFwe8te21lHXMwmF/DLll+bK
	RdaTh7eiKKMbKGp7C+O3JnuJlQLxt87VLXfIxPQ8Vjee7oFmQMX7NSndJZPGC5zC1ufbwpGuECr
	wwknfhQM3zhj1fusYVlxv8NgrMdvYrNuflhvrJ1vBEgkE8xZcHVy37MQqsxG+ySU71W53Wpz7eN
	hhlcG2GrQOI0l7wbKqT7msZaY9DbtkIHCT63lF21nZybjg==
X-Google-Smtp-Source: AGHT+IHnd/38fiict9Z4R0buYYkwbjY3FI99zVEdHd9f85QT23KaewbDSnYX8TPEWm56OYn1mmvlGA==
X-Received: by 2002:a17:906:da81:b0:ab7:4632:e3df with SMTP id a640c23a62f3a-ab7f33d851cmr384854466b.31.1739374943149;
        Wed, 12 Feb 2025 07:42:23 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d18e006csm483291466b.52.2025.02.12.07.42.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:42:22 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so10019821a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:42:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXX7Ek/w3mYGD3PU8Wfdj1jxcmrTQe+LJt9IEX4jynKZhPpChdacdAuPVqxu1X0xwKrqf5GAwQftA+WLNg=@vger.kernel.org
X-Received: by 2002:a17:907:d8f:b0:ab7:be81:8940 with SMTP id
 a640c23a62f3a-ab7f3365c62mr272181066b.10.1739374942419; Wed, 12 Feb 2025
 07:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
In-Reply-To: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 12 Feb 2025 10:41:45 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9cagWShwMbSqdrW9iqV+kiwJMdJBfjUru6kjXvoZ9rmg@mail.gmail.com>
X-Gm-Features: AWEUYZmWQeHLZ0J8NFYXZ_GuzgNgnx9jWhxS5Mn1NK7iDLLdbRqxrj4qVt0xYjc
Message-ID: <CAEg-Je9cagWShwMbSqdrW9iqV+kiwJMdJBfjUru6kjXvoZ9rmg@mail.gmail.com>
Subject: Re: [PATCH 0/3] apple-nvme: bug and perf fixes
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:26=E2=80=AFPM Alyssa Rosenzweig <alyssa@rosenzwei=
g.io> wrote:
>
> This small series fixes three unrelated issues with the Apple NVMe
> driver.
>
> * fix NVMe on firmware/machine
> * fix a power domain leak
> * fix pathological driver performance with random writes
>
> The first two are strict bug fixes, the last is technically an
> optimization but given the measured 200x performance difference I do
> consider to be a fix ;-)
>
> Given the early stage of mainlining for these SoCs, none of this needs
> to be backported.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
> Hector Martin (2):
>       apple-nvme: Support coprocessors left idle
>       apple-nvme: Release power domains when probe fails
>
> Jens Axboe (1):
>       apple-nvme: defer cache flushes by a specified amount
>
>  drivers/nvme/host/apple.c | 124 +++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 107 insertions(+), 17 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250211-nvme-fixes-29c409c2553f
>
> Best regards,
> --
> Alyssa Rosenzweig <alyssa@rosenzweig.io>
>
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


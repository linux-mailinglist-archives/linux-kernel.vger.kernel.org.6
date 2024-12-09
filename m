Return-Path: <linux-kernel+bounces-437427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B09E9317
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E496E164333
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDA221461;
	Mon,  9 Dec 2024 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2NI2Lc/"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C71F931
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745592; cv=none; b=udzPoPhMr2FtalowLCdVNMYfLN8vQm9TPPCrjpyPkCJLMoei87k+iXQKXtJOIeXYkIw3T21znF0lT/nV055kywdzumuvfk9YAyIvHwXJkWbtdnrcuq6mUBjrlqMxWwZeERQrsnKRj70708Mwa4Mlvo02rA2c67M5I5TD7/LjPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745592; c=relaxed/simple;
	bh=PITUM+sT+e3xFyHEUYXT/ouCOLk6At/xyWLtNKCzF04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqvTfy3eFjqEvq3+KqTetxHkw54BcewSHVxrGgpt2CwionfI6UKsVzLSsqsjWT0EUFH7uod1OIgeTgU7SaUH13jX519+NsGDXfp9ZlBtJ32Nd8hEVaNOgCuAsut+XUzksrR4q3/C9CosSMi18NUnZ0YwcDZGqyYXKLtOcvv+Q8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2NI2Lc/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725c0dd1fbcso2799131b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733745591; x=1734350391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqCPPWzVQxOBmnci+RfM15WUylgjOjs3mfjGuo8TSiY=;
        b=m2NI2Lc/6I/Lz3qXBOliPt+V7KgjUJd2A1KS8e3O6nSw3J5TAO05A9ks7G4p5VvbCF
         gFB/fYW9TZnYrbzR7raAar1ptJj4nRq30XXxqzbw6bnLTm1qoX5dS4iTFzMhlttNbocW
         fC1BDL4qj/Z8Wa0V7zQ1u29IQAdfkBLfADrU0MxYGV5DLYzkXWvaSreqap0YM5XDv9W+
         f3bIGWhN99J8SjZsMsZ2a0f7h/d1ieRa4bayvRrldnEp2Y1H1eIRT02tjV+e0pAMxeO3
         gCE01kqMqZn+VcxgP742gspj6yEIJkbpPg/ZcA0Sacs49CBmKRVIHkMS1rpZsLznhH3b
         wNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745591; x=1734350391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqCPPWzVQxOBmnci+RfM15WUylgjOjs3mfjGuo8TSiY=;
        b=TVDf+DYhLHjLM56tZg6xn6XD2fXWpTcnTb3uJAx0YPNOB2EEMv945tNMylyCDnrLGd
         4zPqr7X59aXhUOYWS2AZ7Z+zLcIf/VBfh/gi+SUVl69T2fokiP1XEZZrE5nhjYC5MtTW
         QuDDQys6VRZhVdyr4jUklKYbCKldTN810gyyJUkkRqbqnoieC0Bi2Iwg5hn3m6HDc4Es
         KCj/hjwtUrglrpm1Q3SATjiz/NSUYZI/61GnzRtTNu4UW+WZJZ1XRpdJ6w/hEgI8QjX7
         qv0HBgB5MhgTY6FU57P97L65nUhvfrVL782bh2/AIC44IpM3lsWnI8z7WCXAECj6m53I
         ctoA==
X-Forwarded-Encrypted: i=1; AJvYcCWQbEvfKl/slvz2YxUMbk+OKu3fZKqU9veoTwXEbfsBMkHuJv1XxKW+nahdAH3DPFpYW6+46VB37D9C0iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMePIl67VqvkzFcAPKqSxqagIrtMVumsaVyp9Ho1d66eCXD1K
	NR+olYg6CMDQJGamytr20IWBXzJOWZZs1uVQYzLHY0c4PgJyn/xIbkgzN93lATMnzdF6GkAdF4s
	psYw5k9yPGxzXuF5UQzPUAgsbZtFImQ==
X-Gm-Gg: ASbGncuNSaDcYUmhwkfr8R8zonf4Vq7BRHn3SzLkIdNGlRqolktEIoZnI0Qj7cpGspH
	iLcx1tp3R3stQcNhNp3jff2fhWcc0WVGG2g==
X-Google-Smtp-Source: AGHT+IF0cbahbnj33eBzN3yu7fahBgEOizVqiEHYagR/jqlvroJLPvCt/UvBYlV3UknK/pf3DPjcoiKh1lsX8x8XeYc=
X-Received: by 2002:a05:6a00:180f:b0:725:db34:6a8c with SMTP id
 d2e1a72fcca58-725db346df9mr9092568b3a.13.1733745590810; Mon, 09 Dec 2024
 03:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209110856.40132-3-thorsten.blum@linux.dev>
In-Reply-To: <20241209110856.40132-3-thorsten.blum@linux.dev>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 9 Dec 2024 03:59:53 -0800
Message-ID: <CAMo8BfLheCgX1DVoX3FGDGrfD1wUDFb2g-hetgJGbT7=2cD-Ng@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Remove zero-length alignment array
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:10=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> Align the whole struct to 16 bytes instead of using a zero-length
> alignment array.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/xtensa/include/asm/processor.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to my xtensa tree.
--=20
Thanks.
-- Max


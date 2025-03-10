Return-Path: <linux-kernel+bounces-554641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A849AA59AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C8E188B16E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D964B22FE13;
	Mon, 10 Mar 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="AhYxiKbT"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31DF22FDE6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623645; cv=none; b=npDgUWtKPonp3NPy8eUK2jSMytXpkkPQ6ryBYt4nddS90xpeUB2Ij0Bm8IQ+eNyYoRWcAYdqpMSNz1sAx4Gks3ahraM6kG7hexd26EhQVc+g3c27/ue57+GIwgEHqe53St/d9iiw0Jal9IIFxKlTGDQU2oJYDv3MSfSZK3F7G0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623645; c=relaxed/simple;
	bh=T6iOa1jZH3wgWTSAzUB8I9yXEJW5ocA2pmnyyr8ieeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eq8tqb1W+SLfi6YSgmfPkkP34yO2/Kk4+/sa2XaawSt5t+9kXRYVDpRmCOBOuq40BwOtN0UQY4MsXKKbSiSkuNn8al117sqwe932cvXwWtRUJVrVsW6jmeTpE1dfGscjesTwhHpzp1ikHq+5SgTCidOG66dYK54+DPzwSPIm6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=AhYxiKbT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef7c9e9592so37390467b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741623641; x=1742228441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6iOa1jZH3wgWTSAzUB8I9yXEJW5ocA2pmnyyr8ieeg=;
        b=AhYxiKbTLT4VCSsgd/ZD5OXeuMxASNKAwHr7HvvzaO4vwMZoGbYlrHD6Sa9pGd9CHg
         7m49janNLJoL1FwCox9pf/Ep/f1IliG3xry20IaT1nuuXwNBRcYulToYfH0BQwImiN0Z
         hZdfyaZJPHQ4JyoamfqHyT/2dzMLfKjNydcIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741623641; x=1742228441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6iOa1jZH3wgWTSAzUB8I9yXEJW5ocA2pmnyyr8ieeg=;
        b=OnGT1MutYGtfrnm0bT70rSCMQ9QB8KuMHAVO0NxLqHr7iQyoYtetpc0Z+HYDEMuOiC
         oKCsLMmcse8boUO845o36uth7YHX5M/OHmKprGK8RNRBrnkQwepB2XbD1+OeX74pU71o
         thDgEHndVNysia1uwrxHslD9uQPpzhmj5ZGuab2UO7dmOXs+prA2uu6ulegVW8epWvJE
         TTVr0rcUtArk0wK2wz1waUih/oNcxbOJ5Rvb0WPLjAvFyIwDz4t/ULVEY3Tdku2C9xFO
         0GE51r8yNz4D7HDLnICfsm+RK7AymQ8x1HixFXWYEs7nINEOR7MydqoABP9ZnEoUogj8
         H1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXHCp979AOEQge8/3zl/MFbPxvqSekFYHcZlGichAM5RdTR6XX63sNh5PAg6EPpSOlmNY/6jMAB72stk2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Tbwil1XqB1hsqN3OHjAVZfnRfJgeFX1BAy13D4z1HBE9CrwJ
	OY2ui0rIy6qnwndVtiQBW8LV1Cnpj7uDRXcKzqIgDKSFRRLLpMf0DBFXIyWxJk/YCrZvtx4iz8j
	lxD+RAUBNb9M58W2QmLZJ2nq0XdLN8TamVxApD3nPKkSHozOn8y18
X-Gm-Gg: ASbGncvgkaB2EhPCYk5PTz7n/0ePNS/9opVCxj8xUwQbHkfmStZG5v0ktMxjp3yzJup
	OZIk0CmOHMpqOiD3MtbvpKwtvCNBSrIAIAR7+gZ0du4/FR50IiwpLDeW4D/747MlIQmk4rSmSck
	VLAYaPEvGGYEL+iubKjLMLHkQjYf4=
X-Google-Smtp-Source: AGHT+IEATwLgs4c10Hn/o/KpnRHaC9/EmHSULlF6S+MyWOY6uz29zZxyL5phU+mos9IlnqhGr01S3PTPa3io7zY2X1g=
X-Received: by 2002:a05:690c:6109:b0:6f9:56a2:80f9 with SMTP id
 00721157ae682-6febf3c2cc9mr176692547b3.27.1741623641365; Mon, 10 Mar 2025
 09:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z88Bstpob7Jueugd@lore-desk>
In-Reply-To: <Z88Bstpob7Jueugd@lore-desk>
From: Silvano Seva <s.seva@4sigma.it>
Date: Mon, 10 Mar 2025 17:20:30 +0100
X-Gm-Features: AQ5f1Jo2J-5qX7H_tLcvyVqMf_OJ7vZ7IojegLdd57E2VU8_5xZ7EmyYnmvUOLQ
Message-ID: <CALKJsrr6iahFVT-cycrvzkOKQAOvzAxo4trvWvXK0D1cEOy33Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: a.greco@4sigma.it, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 4:13=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> I guess it was v3 in this case :)
>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Regards,
> Lorenzo
>

Yes, sorry. Is the first patch I submit and I still need to get used
to some some parts of the workflow.

Thank you,
Silvano.


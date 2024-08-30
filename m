Return-Path: <linux-kernel+bounces-309551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D6B966CAF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2142851E2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0665517C205;
	Fri, 30 Aug 2024 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Et3v/1aY"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98746165F0B
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725058133; cv=none; b=Cpz9QY+VKhr/+pQVTQZK6Q9eJn7u7LapVkl6znw/b5ruG6FqwsB1VT92uJBt+NyKEE6TO+jvbGTF3UN9Z1omCM99/JZCQAXmV4AESnkGVP4MnW2mMHTq1HFhPNBh+wcOfF2iEPdMWX9rWQowbFlmtYJ4Oglhm+2QWe3JLMYU2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725058133; c=relaxed/simple;
	bh=JYUyqjMtyPycxjQHE/amwVFlyjc6VQU5XnqwL5FD0Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpiZhDhXuC8Ryi/E8kyw9yJLipkh+vCwdqeKNRUgITduaTpzkLE4A+gZBXGSMU1RSU1JhaLgSQ5OrsVAKm5aNVlcXNEGDuSTIkn8KbyS3LE4BXbux80fFVJWNpKIy4gzQX2D0SS3BZDDwcCUYkxXFFWYIaYHQLy6CRWdKnHJVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Et3v/1aY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-533463f6b16so2950762e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725058130; x=1725662930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYUyqjMtyPycxjQHE/amwVFlyjc6VQU5XnqwL5FD0Mw=;
        b=Et3v/1aY/P/GL9+K/j4z1Fha1lb2+soZ8EARbXIYUgXwYMZp04V1QDqmNr2frUR98e
         HCiN7rjn1/ryu4PXAZsQ710rlChcauOE2dqwlMrdIe4Yh2CO4U3ZkS0a0EapChC3XZ3A
         mjqZNOOJxQ2eh5eAzBsSevqhNggg6mWmyrCePo03pKbPuZnqZ7Bz89anHDEbYJxJekmf
         TytTz0kLEGXccVyZXGstpaZ80CpMhNY/PKnUQOGYiivhuEe5unoofuCa7sJLYMNlT8k0
         xARND6J3zhr3L/N5eiY0De/l8RkA8kIeuWYv0X/Uw8fcsMz26MvamfRu4P/XLPK57XAs
         iF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725058130; x=1725662930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYUyqjMtyPycxjQHE/amwVFlyjc6VQU5XnqwL5FD0Mw=;
        b=UIXAvWUKMAPJ+0yfqCRT2LlM85HOZ26jCYOPZHqL+IbRu8qagnHJT0qqOh7cWi4dfB
         VtC/DRpmLRK1ErYiUBNG7onh3O8w3CXsUukXK+FGk6Ek0iarDLklYFZwkdwCZxr8PDtL
         usNVE3XAk9f43RkhuEqD/Jn7kDdJ+B09awMzookP5oERUTl4qcnQSlfnzI4hPjwocs/P
         njPxbPg7HCwgtUNTiDZml6FNTOw5mcvBIqA0APbTZsf88K4dPdYSkuEvQU+yf/Qmejkn
         v/6ToCg9YxrPXBYHFSJQFWCQ5c/MrvkGYhVAs6I5tdEpzDDLJ/MiBEVKtTOvLjuo9uv2
         mERQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT2nCnCYrwWlD0pjggVVzElWeknl4cZqxLkRSggT9d0UIGVLYqWbGom92EJf9q62kPrn+N+yhq51Lc590=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGuPRXyTW/h4F/JY3SGwneAA8Oo7LfCZqgUhmB7WRJBr64Qtss
	9fT0u7Bf+vdyzBTkQFtImeFFrTEqXIjcC7pAxyCp2QLCROfxsYZY2f+DQjMoKRkcM1W3RgAeF0D
	bHbQuyKe9MdV9Fg33FdIRm8gXDTerMmNZ7wCGQA==
X-Google-Smtp-Source: AGHT+IHb8yYNqKvXobOLtm71pbJH/2OmtII9Yv4T1KNsEkIknUIBZXanlwk7I6MTZZWDZYu7FBbkwa/j8sqao3IiWt4=
X-Received: by 2002:a05:6512:1294:b0:534:36bf:b622 with SMTP id
 2adb3069b0e04-53546bc7f40mr1908506e87.61.1725058129075; Fri, 30 Aug 2024
 15:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131051.43200-1-shenlichuan@vivo.com>
In-Reply-To: <20240829131051.43200-1-shenlichuan@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:48:38 +0200
Message-ID: <CACRpkdYhi1syb+-PO41q18=rU0aykgNKzg2j7zmGQyH6Vbjqgg@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: stmpe: Simplify with dev_err_probe()
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: brgl@bgdev.pl, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:11=E2=80=AFPM Shen Lichuan <shenlichuan@vivo.com>=
 wrote:

> Use dev_err_probe() to simplify the error path and unify a message
> template.
>
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
>
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
>
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


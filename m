Return-Path: <linux-kernel+bounces-430534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B25A9E323D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B05B2840F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1E26F06D;
	Wed,  4 Dec 2024 03:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YqOz8u5T"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102942746C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283939; cv=none; b=abLnu2R9YN/8sC5q3fI+JC98SJFNmjN/l24Mz2YQd4siRNUMzN4omn5JZvYLqH/mPpvjWqDDfD2d10vXl8d9MgaqPo/lFWVoRUIYxwf8k/J4OwB3w0vP0q0/RnLSsrXzAJFHl37tY1TKehlZDcvhzSmCQJ3FXyLNONRTcqO4AMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283939; c=relaxed/simple;
	bh=z1XbbGsUJBtc2zHLxA0NJaY+IxjwSMN+nIlUbS9g7z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBFzvMEIwMbko4gnq0TbKMJXkBiezG67aBVOdKW6TC7ESDAaR/ZFJgpONSM33NEZjlblzxO85KwrSGlNHt67fw+rcsY/EHiOP2qDSwRVT+jZ+TI5XsTYUaSPCpwtei/L/df+C1++/Gi6/69apQwChFRFHKm8vI17cW4EAOB92fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YqOz8u5T; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e396c98af45so5704016276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 19:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733283937; x=1733888737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1XbbGsUJBtc2zHLxA0NJaY+IxjwSMN+nIlUbS9g7z0=;
        b=YqOz8u5TnRcqvD2j2R+fJYo5RYCCQmSjn6XkK5dm2c384gnHP9I0Qj8skbh1mjFbSZ
         sHFW8IOZezK9ANBVt8WDiuNmFhrTZXaH4kyPiCFQLqwPk7xIuSZqUiWIY2hijrI377er
         YvoHUL6Ig+2k44oxYur1LQFNvQ3XdkCQb8qPbB4w55gfHsXEvwdmN8esI+vN7DM4V2Ts
         cl8ZEPrm06ZDSnFvhcoUwNUi202XpbAwgQ5HdECrT02xw11znyq3pLZzjruog+KqIZm1
         8E6oti+kxHQUj7YhcOXHys861gjAUTwaNrD4pWfdABlKQLNHwXdmQcPQKSKggNoBJQCn
         gHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283937; x=1733888737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1XbbGsUJBtc2zHLxA0NJaY+IxjwSMN+nIlUbS9g7z0=;
        b=RYeIdrK7iT/C1/HrJkfmlw6Hi1MGpzkOd1vWP/4LBpkdEGxp1usW4LsqQE8khDfa86
         YLaXBaQ25ZSlN5e/7X/3RrHnb19a1Smg755qWuDVlozghIo4usSBU4nBRLDLd2Q1IhDR
         rQKjhq6cyQE2A0AjBsi64y5JIF0ssHNgddQ20fsY7jF61jdEmiKJsGhy1FUKvqN4ua5t
         srwfYyu35ok1zwnwXJ34VfcMm+v8leid8kZRCD5Il74hcPhcKhyLFQ7b2dEisNO8cu2T
         pbnWDSGIXnGfxPO8c2hqf31F565ssD/JN7VRjfI5D1lx4VAvrSlzoYKGSBBPH1eZ0wKJ
         hwHw==
X-Forwarded-Encrypted: i=1; AJvYcCW2CM6aHkFZgnl9l9ruVbb29GOD3V1AWo8i03nriVZU2xCPSI9CCqEyc94HBhVEBdkCL8PAdt+Qibj9Mqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSl8bRUMW6xTif1wXsimxnQX9CYoOmGhmQ0cuItqHy+ynW6jRu
	JHAR80CsZuPMQiVAvpFfMXAIDOfFKbRRLwJ5aTyFWf5RSoPoAl8xEUZA7dP+lc51kw63fXdsIDq
	fyJVxX+OQdk2EHNppqNczeDnp+xUaW6dPzJYCCeNInqRYQ3k=
X-Gm-Gg: ASbGncvipwn3XL9XaTDnjD7mJAEQznNxcMEhB6VyGcaN9u+PqvG4UfkJfjVsUFkQdoU
	YfsPN8Tbu0sjSBFaO53i33jgVfiIwnA==
X-Google-Smtp-Source: AGHT+IEnXWo1p3qjR3U8AU/4Sw7qLma2QQ0LRrci3nJqI5tWuNU5cRLLQ8tXAXSK+umt83Aaiyni6AwdQeANpibv2VY=
X-Received: by 2002:a05:6902:340a:b0:e39:6c6a:f2de with SMTP id
 3f1490d57ef6-e39d438d9bbmr4803300276.47.1733283937166; Tue, 03 Dec 2024
 19:45:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112182810.24761-1-av2082000@gmail.com> <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
 <CAHC9VhTJERn54qNDDOwNrJ09VWrmq5Qn+sPQV__LyeEUgSi5pw@mail.gmail.com> <e8e6824c-61d4-48f9-8547-628bbbd3063a@linuxfoundation.org>
In-Reply-To: <e8e6824c-61d4-48f9-8547-628bbbd3063a@linuxfoundation.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 22:45:26 -0500
Message-ID: <CAHC9VhR5NVHOz84RBzi9L+h=kqpe3RfaEXDa+87BCLPAt+Qskg@mail.gmail.com>
Subject: Re: [PATCH] selftests: lsm: Refactor `flags_overset_lsm_set_self_attr`
 test
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Amit Vadhavana <av2082000@gmail.com>, jmorris@namei.org, serge@hallyn.com, 
	casey@schaufler-ca.com, shuah@kernel.org, ricardo@marliere.net, 
	linux-kernel-mentees@lists.linux.dev, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:00=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> kselftest patches usually go through subsystem trees because of the
> merge problems you mentioned. I take them through kselftest tree
> if subsystem maintainers want me to. Some do and I pick them up.
>
> I pick up patches if I don't see response from subsystem maintainers.

Thanks for the clarification.

--=20
paul-moore.com


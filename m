Return-Path: <linux-kernel+bounces-230486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF70917D89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8358228501C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB16617C7AF;
	Wed, 26 Jun 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pSJhfLsL"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F5178388
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396882; cv=none; b=jtHhyka2u4owO+QwDgRy2eqvfADi+Mcu6QYbVKffyvgp394aevVLsh41oyGVoMUim4psxaSRhbMQC280mDiqvBGoFvXPsRnyZ1qLPkxN60Tem+lyiWRAZLHywdjs8DK5DdaclYWDyPcgWl9AK7BSYuzVQcAYJKsdGCT57FjIp7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396882; c=relaxed/simple;
	bh=6XQ2pTvFVEbYAST3NGhXhfNbq20t52CTftouk2JNdhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZKWbOD8ykTi5cqMSmhguxMVq7lyUSiZxJhfYXGnL8uboOJleBAhysDKh9BhKXl2NbQKv1q0xSEBjgZJMoZK0AGDDcT50ovD0lhBBQ7VZ93i8mm/PSl3AFcKd2ukBg73kqyKTjrAioIxVKkoO0lqHqbzSjQo+mcaXzYTCq8zz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pSJhfLsL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cdebf9f6fso5263734e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719396879; x=1720001679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XQ2pTvFVEbYAST3NGhXhfNbq20t52CTftouk2JNdhE=;
        b=pSJhfLsLH61fDM7ZeFtEGBa0TNpskhhdJpIOYhKhSB0Wdn1GwCuvPZpTPMIwM/ajen
         MgBGTesykaq9Pff6ULts1Qh3PMyCORrAThVfekHylF/N5C9HFEE4te/ggL+bV6lchFh3
         02V7xWRIYZ++4GzIgNqVZCIVCdH78kd6qwwqH4x780B0EZtXNI4MbhB6VaUAZPB5qiZq
         /fGJhtXkUe9/id6DS6gtTJVrmWAMJiB1mmI7OaxYfgOZ7Fpea74jJvgzaagmE83W6ZA6
         MEWUi2PLSy3RNPKB9GBPezEcsw8+3IU6qu7fDWLJtUdmU8F5+/OJ71NMcJsod/3lpyLj
         Ej9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396879; x=1720001679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XQ2pTvFVEbYAST3NGhXhfNbq20t52CTftouk2JNdhE=;
        b=IPchPxAVY7eW/2BVI9G4rwjGFgmqTWELutBOok7rJodJNJ/cSml6/o7R3VNkI103Ln
         E4VO6ABUhcfRLEfc616LK+0Z8MNvqBiP4qE+QdLWTDG+lKUUd+PTlicoCKHwDR3gXh8c
         qSqvp+o6ApX/lI5prLEyZaMAeh9mz3tQ2uOhJ1ov1dFG2a7cEhbf6FwKikbDa5FpA6A+
         FAsYZ+uquChnO1LirrGd5E72sGqsiZvqYZ+aD4AoPUxtb4KOdWVzvw9Bzc4WctHt7WlD
         /OeWZlGDL+/ZVApdV7Fx+F5/DOqnt8iptUbqSrk1VjBDIgEeGBYU3d5c3s97LkL+UcJf
         zJjA==
X-Forwarded-Encrypted: i=1; AJvYcCU52BD1V0otiMuAiPoJqCT+uG55qO31Zu8yfzsW9HKJz6WJmph8W2QE9/7XLQkdUpRtZQWhSShBWEm42UtP72FlbL5j6qQWyxB7FYFe
X-Gm-Message-State: AOJu0YyYw5Wj7oox+d/rtfIhFdBBPIfTdGVvU+YKhWQMWdoQv6pck5EJ
	9zUvUbQ1GuQR6/ey4fjCKBa1Eg65loo581wW28T8vZPoKY858Vnz9fBSBygfMelbdaWxtkDoxH2
	XDfaah1citO+W55lQ81U1XmmwnpWo3+fjEp3ZwQ==
X-Google-Smtp-Source: AGHT+IGd0xNNrA5h4U5v1nImX7eX0z63kjBSZzzGeZCpZWttZ5iQa/kspmC0q9On0PVRRo7UKWbhGIaE9NhldX0tep0=
X-Received: by 2002:a05:6512:230b:b0:52d:a55b:fa9d with SMTP id
 2adb3069b0e04-52da55bfbccmr2105965e87.38.1719396879156; Wed, 26 Jun 2024
 03:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621091637.2299310-1-nichen@iscas.ac.cn>
In-Reply-To: <20240621091637.2299310-1-nichen@iscas.ac.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:14:27 +0200
Message-ID: <CACRpkdYv3uoO4iASNtRVaioX9gP_XsUs9CSECsB3=oj8aSA2AA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mlxbf3: Fix return value check for devm_platform_ioremap_resource
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen,

On Fri, Jun 21, 2024 at 11:16=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:

> Fix return value check for devm_platform_ioremap_resource() in
> mlxbf3_pinctrl_probe().
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Well spotted! Patch applied.

Yours,
Linus Walleij


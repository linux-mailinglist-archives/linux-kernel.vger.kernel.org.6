Return-Path: <linux-kernel+bounces-372959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A09A4FD7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56241F26096
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CE616A92E;
	Sat, 19 Oct 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAM+JCuL"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067910E3
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355492; cv=none; b=tyKn5TOppV0Do0nRBuBu8IbkpZpoCA06Lq2qYtS+SR0TmT7uGqfb00zvQkK5qjRmHl9h9sYdiOzj5s41RBDjvuI2IKkfm2YOT6aiFSF01Rs0vxSgg6FJ0q5OOU2Ub8U3vkCSY/ufVoU/EDvT1/rQKEFWUO/IgrOJyCh8LccwoNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355492; c=relaxed/simple;
	bh=yYnUdQlkAllB8NFE8I8MCkeRvhzgIEdTSR3fgIafyQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIXr309CmrVTP4IUKrYR29MSNZ0f/IhKOBUzH+82iLufIoltSgaTMxOAyJK3h5tQN8uW9qGQZNx77TU2ODJGtVvwadMngF4i5X3J5bqJT5A1KOlFuPapxSN1G0r88BMca+WAnyF2PwEoK3SEjAPEd1NFrgq5AmNZ2Lf8xULxGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAM+JCuL; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so36399051fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729355489; x=1729960289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYnUdQlkAllB8NFE8I8MCkeRvhzgIEdTSR3fgIafyQs=;
        b=NAM+JCuLe6xSLyA4zn9ZibwZT1bx2D36fvUm9Sb4oR5hDmvMN/Nt5Lp57dAGLLerit
         FJpcE6KGbIahLoaoydEqVOqFU+yQk0TyoNMoTZnuwUL8CkS6jc771zR1zxoLfc7EXGsl
         81csavoCruKMrGJ+y05hcHkyCi0PWknl99HUuqHy3yw/gQOPw4j8+U/USal8olG56RJD
         I0NjtRsYh0tqENjn7InzuYuOfTCcfGyEuIDXbMNnATOVAOzIEdAPZqwWTYjoF8E5chz1
         XHwItq7hez4m+UAfliyn6x4UdpS1LXrLXrIE3+LIQpiDdKmWGlXXiDsqLuwAtHvyfkl7
         Xw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355489; x=1729960289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYnUdQlkAllB8NFE8I8MCkeRvhzgIEdTSR3fgIafyQs=;
        b=LRHUAVqxsY5ExJm6xQ4ZE4sYvnSH3UDshzRVew3WnFX5wvrt9Ake85bX8S1gwHSh8G
         vaVBffUBfmV6cpIas8KvIyn2YGtbGVyVYD422oNBnLK5pW8m7EEW8/zCpVzpwEFvxkJh
         dkwGexmqCxn2XfluEBWQm62X6YInX4asqIJ+rqBvC7onx/FWXh8k+PB0SpFJ6+SZBebK
         ylLk5iWiT1apycBA/ZKjodjs0NJ+QfUcWHI//LDilpVEa7vbGC/wFmmaFT35MzuVtp4R
         FFUQYmQ4RzdT1hNEVrHrlqAtI+btE9dPIQJq7Lo/CeZlvUUvTSwYhidFqyC8vuf1Q5/R
         QfXw==
X-Forwarded-Encrypted: i=1; AJvYcCXHZiHmcI+6ETZo9DeiNpNFz5DbUhPASw1DWmpvoAUl2ZDuzfMd72L/7janYtIA7Ebr33hgGrOsSk+Aqxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkYKem7S+mnGkcXBwcdMAmj/gUsefxnRsnNNeRGDGHCA9mHuWx
	9Gqs1BJHXTz2Xnj9lqR3HJvRmcdu2WNXqV7dDUOEqoKixPEkVJApcLJLg/4F1+BA1p8joejYJ1n
	r+IGW6akGPlDnkW8p752GU4F58DM=
X-Google-Smtp-Source: AGHT+IEtXQrMU8EqKEeu90T5HObr8qTTnedWd+rk7D2938zT7b4OU2DsWnwAyQ2ldBZnmR5xo1nEAEfXknvzYWCI6E8=
X-Received: by 2002:a2e:a585:0:b0:2fb:527a:815b with SMTP id
 38308e7fff4ca-2fb831e91e6mr30573161fa.28.1729355488395; Sat, 19 Oct 2024
 09:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019-checkpatch-fixes-commit-v1-1-0d0cde18ce69@gmail.com>
In-Reply-To: <20241019-checkpatch-fixes-commit-v1-1-0d0cde18ce69@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Oct 2024 12:30:51 -0400
Message-ID: <CAJ-ks9k4COk4EJqOgjCpeZ-FfmELnR4T2HV0aMPkzQ2BX-PSAA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: always parse orig_commit in fixes tag
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Louis Peens <louis.peens@corigine.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas S=C3=B6derlund,

It appears your previous email address bounced when I sent my patch. I'm
adding your new email to the thread to make sure you receive the patch.

Thanks,
Tamir


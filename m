Return-Path: <linux-kernel+bounces-353044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1EF99279D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B171F22D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D7518BC31;
	Mon,  7 Oct 2024 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyssuzw8"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B56518BBB4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291281; cv=none; b=C6SvEvlyjwz97n4P01ELxFThnlVh5YEKeW7fJN55s+V3ZRqczQiTUhyR50URnAd7qe+km0Ap+EfZnH21CIrPnMtksz6kF0VasbG2WgtehzS0fpOPFNW6roiK0BfqExUkRjHHgCUusvzdoCcl1WuLWsZwPPMiZrTRPYHqJzt/Eok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291281; c=relaxed/simple;
	bh=OUfE1o2HzBKKhR+SxUsllx8cqGS44Q3syYwiuBt8www=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPHTML10eJHIWiL5x0iPYtsaRWfIImG6bCYM7UsEX87pnP9fGh9iX3FEvz5GtGCuoyyAzeOsHPAey+qngOeWO3XJzCt5vU6gIfrQxAyEXHqwnM9cv8cZckMZhk+iY99GbsQhc+FdLyNmNqnPg+DmBg5ydrGy8OxL5QwZ6GoEwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyssuzw8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71df7d6c3b2so169178b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728291280; x=1728896080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUfE1o2HzBKKhR+SxUsllx8cqGS44Q3syYwiuBt8www=;
        b=Cyssuzw8epcigYBQZDR0Lg7y9tlckYFcfzjlRRqU0C3tx9VSygxl2n1HuA7uVQKWPz
         HAqWbZSDqARGr1SEzlPHUsGN7eYg9QSEWI0UbP3tpRDbUSkZdXUu6RrstPpxcCYnzRNN
         Yf1jFYcmpsMBw26+lkZMqIoUJZb6an/uWHl6Z77B5T+HL/qDiaYOMVodz5ly/kfOQ3HN
         o5191z05wBdcXkUG0ScSh99sK5ER70F511MVNzAI9mUeVOIDtSBuVahnVZQ4lFn0esNO
         altuweodRsLEeR1IixYDsEK9vwVu8IEb3Yl38T1skQwPB2gbq1rIInzFh40YsizzCore
         vgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291280; x=1728896080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUfE1o2HzBKKhR+SxUsllx8cqGS44Q3syYwiuBt8www=;
        b=cDnvM0eQ4VVfI5toQCr1m7xamgH1v+OrZwS16TTx+mvbRZERwfyg60OD9s6ouQo1sl
         f0TWSpU1lt0kbaNF3dQcMJd3tqNORvZP8BiiAUajW5MjIYgHUM0xUc/CL+AJ9rMSOL9/
         KrW0AuhlBOfWXtQoul6COp+WaV0BXeCCx1DRXZRu0otduoEh2tL651GNbKGhG2K+aOCz
         ry/wcv+FjJOVuK/q6t7zEaPt7LyPu0UyMk5M/76oL2XGDYb6PUJiOeGPs7Tjrk9g9yW7
         5jG9vSsJ1t2JY5hMG9OPLwcJJYv7JOKxcUF/g7iB1KmdHS0hopveP6LjQDQucnwF/tVF
         Q7xA==
X-Forwarded-Encrypted: i=1; AJvYcCWAu2MzV7WA63hJ/gd5lbdAnecKjYN73pjD5b0ZX8TbmTUeYmoT4tRhWSVAWIaRom9TXdYL02yi3UjtUjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYoIptT/iU05ZP38gqQ0JcNEo1/3vONn0XtDRc54qtPo2OqiH
	duilLcj+Rdk8YLdGIsI7OoGyEKttnlWI5E0oNx8BYSWflGrsy3bRLCtUQa332yuCqp4WSwbeCLI
	BOYDdHMqi1YF3cPD8QK5HKWOdWI4=
X-Google-Smtp-Source: AGHT+IHJz1pizuVd62NJ7Q4bXUgGdgu3SY2d8zDnBAxjeBsDR9ctmzU+ELMZzk52Hjc4X7YTbdWXw5a5ne0ozVY3nyc=
X-Received: by 2002:a05:6a21:789b:b0:1cf:2be2:668c with SMTP id
 adf61e73a8af0-1d6dfaef1bfmr6372042637.12.1728291279798; Mon, 07 Oct 2024
 01:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006225511.121579-1-linux@treblig.org>
In-Reply-To: <20241006225511.121579-1-linux@treblig.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Oct 2024 10:54:26 +0200
Message-ID: <CANiq72mAfL7Dukpav86hkjQstcWv2J6y5uRTiRQq2TXEg9bNZw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Remove unused functions
To: linux@treblig.org
Cc: ojeda@kernel.org, andy@kernel.org, geert@linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:55=E2=80=AFAM <linux@treblig.org> wrote:
>
> cfag12864b_getrate() and cfag12864b_isenabled() were both added
> in commit 70e840499aae ("[PATCH] drivers: add LCD support")
> but never used.
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-309550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9F966CA9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8502284642
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF618950B;
	Fri, 30 Aug 2024 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRSRONkE"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2869F17C205
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725058030; cv=none; b=ZZrfJEE63EKgH8Q1fCMZ73WUQ9FxP0sIIETNLiWRuaHE+wtLUfXbb/tqYEzTs7Ld8Qcs7Bxh/pOFkcUsqhkbQEg5oEYczRuGah5M8HMJcaDrFt83Y3B6DM2ZZIFUFlUfwXENiJQKOzbsxlHYpQE2sz+BpkWmbAdX+ImWpKEc7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725058030; c=relaxed/simple;
	bh=FcERWZl1wa1DugmkSLGflqWj3fp23asXRiIxBMGAnUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYuIhTqSeQK6ek3O917FmCdBBBzHGjfWfO56dTilEZYnaVsu71/bU4rIU9fFxZJUCfadLOTkOyS8lbSY8NjFgt0kB5gTkRz5Bjqhu5Rb6pHLx8j6imamliYqRrWXvXRDazOgcXO58b1ilgqeEv+chCE5yNfKAhQA+HsoFVmsbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iRSRONkE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so2819370e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725058027; x=1725662827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcERWZl1wa1DugmkSLGflqWj3fp23asXRiIxBMGAnUM=;
        b=iRSRONkEwds+0Z2B3BS/qBG/xWaD4a2ZBX0GqOUsh2h3gHOq4+rGtuJxF2vWURl9TR
         ihi2Hb/iGyPVYYd4suql36XcT6aUz3x9DDmlEzQ/GVpfKEdgsqkpgtneMP6a1CP0Ps1/
         tp5zpo0kUCtFbvSsygvskeT9+DKj4PiltYXZrdmr09xx1JaY/ptv1pSx9hlEBiZqOZW4
         +R0mLhThJJYvtE+/yHmx29mnh9HRIjeFfJA1hrai2jbc7PK6aYIh/rwI3YSeuJGvKDZf
         1Zvgh2lvZHf7Uze+RtVVgVr6F7od7QBVLnlqgZXJFtGgq2ASvaMPmo85nCOPS8lvlL+f
         pVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725058027; x=1725662827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcERWZl1wa1DugmkSLGflqWj3fp23asXRiIxBMGAnUM=;
        b=SOsjEkKwe0/y0iiiRuNvqORYbe/aikf8Fuc2Q6GeDflSuRM2vNvG3CNsbriPnUkNtw
         rh8M38OxWn4Z+xJwqCOfxwSsx0vpTs43G69XpN0ckMdm/vXVVm4ZTT6Wms2F2BWhkhT/
         DlYlJ868HkOhbPYDWx3AFQhcxnZAnGsd5SNMDcstppvBOoOoeFkXxHaK7TLwu+sTfUVf
         1u0NxfV6BEmjMnZ2ZvUPiNLDrGaEpKqJoCKVmy2ojBfWTO/XNKd43+/wAJ50Xomlr/7c
         ItENgm5V2khuxZeWEyDJOJQS5MS4XCSzSINXJnIFjeMGKMrKAJ/37+rHvHsmEXcqSxBo
         uqTw==
X-Forwarded-Encrypted: i=1; AJvYcCVqhJOdWp6aPXVgUV6KAdaWCxpDFCWKHuwSQ1EAZFMrAMyqNquhOwC+OohxNVTy6JPMoUnStPXFjlURyv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2AksC+uzdETAdiLORDENpcnuGNYYI2VS2NmP9IgklYbe8zsr
	J8pzARV9GMBmAEPLighUzwehFNKeJXIcuMKMTdGzl4xnCEn9Y3B7CoKkIgMhpKDfnGdvgk1kd9n
	QU1DJ5uBbbLNxUdX6Iu79HKp8Wl7pyL9zQTk2EQ==
X-Google-Smtp-Source: AGHT+IE6Pux6xBCNKx6NzrDxkiMvpKkwNksEL+SETGgBL6cWj2r/5BXlHPx1T6w7EQGMUKy947gNiEBsSCvPbrCisNU=
X-Received: by 2002:a05:6512:2346:b0:52d:582e:410f with SMTP id
 2adb3069b0e04-53546ba061fmr2649566e87.46.1725058026553; Fri, 30 Aug 2024
 15:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230113205922.2312951-1-andreas@kemnade.info>
 <CAMRc=Mf4-8AfTHLrvaF14tc2TJatxZJWnMOF-1G8HmDhPKSFAw@mail.gmail.com> <CAFLxGvyX1Q8qGXkWW+JiyQSfP=1dFzeZ7C4OCJHk2pFGX7zygw@mail.gmail.com>
In-Reply-To: <CAFLxGvyX1Q8qGXkWW+JiyQSfP=1dFzeZ7C4OCJHk2pFGX7zygw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:46:55 +0200
Message-ID: <CACRpkdZY5CROs9EeRSYnOzFvr_Xgnw66ziKqYH2LE=MQe4OWLg@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: use dynamic allocation of base
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, grygorii.strashko@ti.com, 
	ssantosh@kernel.org, khilman@kernel.org, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:52=E2=80=AFAM Richard Weinberger
<richard.weinberger@gmail.com> wrote:

> > This could potentially break some legacy user-space programs using
> > sysfs but whatever, let's apply it and see if anyone complains.
>
> FWIW, this broke users pace on my side.
> Not a super big deal, I'll just revert this patch for now.
> Maybe the application in question can get rewritten to find the gpio by l=
abel.

Ugh we might need to back this out if the userspace is critical
and you need it.

Ideally userspace should use libgpiod for GPIO access, but I understand
if it's a higher bar.

Yours,
Linus Walleij


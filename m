Return-Path: <linux-kernel+bounces-310836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5D59681D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5CF1F22CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECF4186604;
	Mon,  2 Sep 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAbeW4gg"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597BE185B65
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265743; cv=none; b=Sl71ESiNb5OiUIjq7u/qYoo41Vo6kr4ry9v7Dau0G01u8t2pR+OdfTOLjF0nR8/VGE1DzQNYjFDKXIW/VdFcBcsELqHA7KMYMtNrqdaj2XKwyL0TKa0pwdoq6xB6SmbbJU6CHE3Nt500W//L/65rD26xm8RrOSr6ApqQcExjT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265743; c=relaxed/simple;
	bh=MIaHRBbleOvp5Fm3wN0MH4xZRqewJGpHkVCnZieq1Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjO6xC3+jklh7GVX8/i9qmZY9GhypeXFr8PyoxRNeZwgy2Hmmh8bx9Ec9uUQaGZuRAsjgbwpFrvxkNifnSmfgSk12PewOKi8gR9sG4wjr00ZE6pVrXaa8bCSJiYzR+20PpVA2uPJMlgElrLhOOhJWlXQGzIMnNg4p1CauZp3nGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oAbeW4gg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso5476934e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725265739; x=1725870539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIaHRBbleOvp5Fm3wN0MH4xZRqewJGpHkVCnZieq1Fc=;
        b=oAbeW4ggX0U4yqUs0IosVF8L62fxzOdOxQKGRYvIrHSB2mpCicW40wLgftKlx5WFwb
         bbJzm6eokrSy928Ld+WMT2Q8oPAuMowVAD00HSl1aAEh5l+F/mgnMuB+56CYXLq8Z6Cy
         e+fqTfmIYdVnUU490uF0mPfg7CaftHFGQOxSLKBCnnS4uEQqsh3toV2zu9/SLvwltcMp
         H+rmUKPaqKHyhpSOKNE1W8MuC2LxvUjWyIzmaAmACiyPqmDKAMZ6l+iGYIlVqGlzkauM
         3bwjZm+1PPH4OHOdVuLdkYXwk4YHbizlN2/XN1+SsNirjNtbINujcn2qkysgUR6UF7m1
         ncIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265739; x=1725870539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIaHRBbleOvp5Fm3wN0MH4xZRqewJGpHkVCnZieq1Fc=;
        b=r4TJxh7kznqqMNO9WSt89rgfrKP8Sc+/xPwSpBHbLIETcYNPUVoW1iQ18gNuruKeAK
         3p8SwVlIvFtV87YQLWnG/G/nzp/5YAC17GoyXgEZOSz2mQvNEXje3DbWU6PtILZGXocZ
         1NGeaDSaK4IeT5XeLBLqCVQd3MI8wD8gWxz49x3K5aH2mBvWbmQcW+AiYojO42bx/yNX
         UCcgtIhaF34oxK2kkbDYujmf/CbaHIduI/Ufd5P9g16glZErxBhAdyX7VBe4/MHEbMSm
         Ye9HaYBfsqZe+xs7QD/NL52qa7dHlDq8ZfYMuVm+sBJWeamX/iCNJqtxb1Zvkf8SJm+9
         fJxw==
X-Forwarded-Encrypted: i=1; AJvYcCX1CjPwhs4128Um/zm/9ev1pIUUF4ko6hUa4E2GklqJlWefMkV0+rU7Gqp/tr2rhTvEUhwxQA3whJ3XxVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8hfVWgD7WwNWLv06U4Zf2YMe4AJ/kyw2LYnIQQAuRrKWmTPQO
	RRu8S03kW6DtJHYdDR5mY1ip0nc7dWdBdFiN0RcKXbQeKnkxXpLtZI5mh7w1oWry0kJSYOGh8c1
	o1s9vzjwNWv/Psqm2Wsr+fOpGsgsFj42yBmvSGQ==
X-Google-Smtp-Source: AGHT+IHPWy3EoCohm4ZQ7Nw+pjtHINUGWbi0iXZ9E+VhoJRrDChfQmlQqhKT7iJcy1rrIoGEA3CKMiarlVi0MZwFT9s=
X-Received: by 2002:ac2:4e06:0:b0:52e:9481:eaa1 with SMTP id
 2adb3069b0e04-53546b25d21mr6803224e87.23.1725265738824; Mon, 02 Sep 2024
 01:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829044835.2047794-1-yanzhen@vivo.com>
In-Reply-To: <20240829044835.2047794-1-yanzhen@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 10:28:47 +0200
Message-ID: <CACRpkdYMn1FyUFrhGMx=Kq=zK28o1QX-pnJ_tKihduouML4aeg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: Simplify with dev_err_probe()
To: Yan Zhen <yanzhen@vivo.com>
Cc: ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:48=E2=80=AFAM Yan Zhen <yanzhen@vivo.com> wrote:

> Switch to use dev_err_probe() to simplify the error path and
> unify a message template.
>
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
>
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
>
>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Fixed up the subject and applied the patch.

Yours,
Linus Walleij


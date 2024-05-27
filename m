Return-Path: <linux-kernel+bounces-190746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B28D020D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108F71F292F9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF115EFA8;
	Mon, 27 May 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B38+Y98K"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0713C676
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817448; cv=none; b=fchY73F0aapu8a56Fs/BRdSXW6SDgdQqeVHHq9ZPQnyK+ihwxiSalsmviLTVq1G4x9WtUisqUo5L75QuYkmWzTuX+YPvQfvx7HrK4JnSml0EpUJi549LsgopFfdVBRq/uZEXRp6sbfsVdOfjzxg2DexRhgX8tTER/baUgQBIgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817448; c=relaxed/simple;
	bh=xC0rMsBfc/v6Q75/1SSXM8lANe3fe2OjXkC+R5uz5t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucUtLS9GhhCckMleXwecRLhVsARfDB3PifPfGqucppM52Q8HlWRqAAL7X8GoWkCST8ij48acbxOoA3IyusOweuybsSWGIptxtKAKM0TY2dDc9a3vZuP3WDZRaOlKFW+S5H+OQNeustJKFVIGP7UEwrZvMk8ijRexnVwoG6/rqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B38+Y98K; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df4f05f4cc8so5170807276.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716817446; x=1717422246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjIOAA6f8vKpkTNIxYlPLCqq5B6g/WubZZM52K6hpRU=;
        b=B38+Y98K/ykaKAveY3tZ1XmPXUyHPoTQ7rPBTFeeoeLPBiD1vb1WkMq35fVlIo665W
         MWWsAgdgtoXmrEW97dqzy98G83SiBTMvPAzAj/j/woFrU/f673Occmot///2WJiTh1QI
         kGMM2VJDJJIvHhsFLzUmaoizbTa5qU55grpl1gI0O1CW07FCOoLHHNwcjkGZpHzr9+yn
         JkkZvRN7i0TnfrfH36W3pT0NB3KbupXiqIxqUHhA07BlSJbVp/Hufmqku/tGxuD1WYW7
         GPvyFXwsleWgw9jiGOfBGp7QBkcGeqOCvxxEOws3ZIOb1bH/aD0FC5gnatqHST6pO7Jz
         10RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817446; x=1717422246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjIOAA6f8vKpkTNIxYlPLCqq5B6g/WubZZM52K6hpRU=;
        b=dIRGjHnumeB+DqiMLgGBq+zjWFSVePjJ/w7gFa1bUslw8zz7UXCvhHifM70gOKv9xI
         QUtQSMd89YBbftzxleNpp0DWjOcotfsDKWxqjx3ORD7XHxFoCeEjU6h/MQa1eBQIypAF
         aQOxL1+d2I6jL5XohZjKgDxd1YV9pTzBRXism+S/rvE2hsFZsX7w6ufNWzq584dLAzWo
         /+c/oVVP7kc9gib2DC4s3z46YC2u9/V9Aa37XkiydXC709SlbzexMassqDNhp6j5XzT4
         kXQktTMTfYV1+B1q5tdLLU3Yyp/2z1eqZ7PVZkvtih+Hmws7C+HluJyTMoqsHVPc4RhP
         JZLA==
X-Forwarded-Encrypted: i=1; AJvYcCXJKAwXbq5hHdQYCnmufZEFLKnZx6fgUcd1Pc7Bf8TW/eYRRPC4Wn6T+S1entPq+lkSmkP/AU4L99KTr4fGMz/dE/w9d4ob3H4Wn477
X-Gm-Message-State: AOJu0YyXCn6kgITdAw0VDtCZKsMftSR9Iyvg9+fhvr8bGjuCHSz7piG7
	81TM9t+BWBUCuooNVJ2QTwMXs9MBv6jEOOxutYWfrvmUvBR5uQ3JiulDy03ePIcMc3L8gHtH9hI
	DVi9MZHjXbMnOFH8ICCYp9QZfOTMl5Iltocrttw==
X-Google-Smtp-Source: AGHT+IEmdednX66G4yc6NfcpxB2AnEfEXaBughw+ikECCE023bpfAarEUu73fl8FtrlMCXr8PprIFqLNw62ozoIj14U=
X-Received: by 2002:a25:69c4:0:b0:de5:9ec3:6475 with SMTP id
 3f1490d57ef6-df7721e8ec4mr8443108276.31.1716817446028; Mon, 27 May 2024
 06:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714049455.git.lduboin@freebox.fr>
In-Reply-To: <cover.1714049455.git.lduboin@freebox.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:43:55 +0200
Message-ID: <CACRpkdaM1pxweCPmhg5iQKgVVYBij4fZ7OUf-HRKvPeBJg49uw@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] pinctrl: core: fix untreated named gpio ranges
 in pinctrl_pins_show()
To: =?UTF-8?Q?L=C3=A9o_DUBOIN?= <lduboin@freebox.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 6:26=E2=80=AFPM L=C3=A9o DUBOIN <lduboin@freebox.fr=
> wrote:

> This series covers errors I encountered with the pinctrl_pins_show()
> function when dealing with named gpio ranges generated through the
> device tree using 'gpio-ranges-group-names'.
>
> These errors were introduced with the original implementation in
> f1b206cf7c57561ea156798f323b0541a783bd2f.
>
> L=C3=A9o DUBOIN (2):
>   pinctrl: core: take into account the pins array in pinctrl_pins_show()
>   pinctrl: core: reset gpio_device in loop in pinctrl_pins_show()

Patches applied for kernel v6.11.

It's debugfs so per definition no regression, people get to test it
in linux-next.

Thanks for looking into this!

Yours,
Linus Walleij


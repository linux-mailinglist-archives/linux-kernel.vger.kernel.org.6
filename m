Return-Path: <linux-kernel+bounces-542893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAFBA4CF23
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7786D18951A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF4323A58F;
	Mon,  3 Mar 2025 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZwTJNTS"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51054235C11
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043852; cv=none; b=NV3J7unE5LedprUkLmD4HrAnjy5bkoWoMocCZlSW8IrMaEapPJwYkbxWKExbbgNS9NXm/ailc8ET93FGevt3pofDAWH1B3JH0dP/SzoG7F8WvskKhrkdFDczso72stdpS7PboibdJ0mUsBnGzR5iDQGkOFXXoaqJxFTM0y5UX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043852; c=relaxed/simple;
	bh=NPxdklpo+hfB6Q5aEYjRbk28iZGSbxF0mOWy2NS6sNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGDYep637fQxYwYtYklf4D0anRe6iB97sigenxU3ouczS11kL9vz7lm6tBFdSg/sglwabBYuniZdGIFH5GM1CM9LqqQCIUBAhluoXJnnFOYY0N7ybJCqr76onQsrRRnEN/HrIylV0p5q6PNuESOvVku2QznoARj9nKgWuWYxgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JZwTJNTS; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e608b2698fcso3439384276.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 15:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741043850; x=1741648650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nJU/yvYz6haiwFOMPRsCHOU6kFhXq6ZBBygufHFSnzw=;
        b=JZwTJNTSJ03cFQz1dWsA/AU9gfbqKKpWb53dCTMAxSDFBa4bQAUB4Gq9V0YAuAwavQ
         rJcTfIChgqj0TQ4GDoHoZlXfOePZ49Rh2mO9VxlJ4sLVLQgX+tXtdhC0oEmXtjhJiQC4
         LR4PFmpw4DnjrQkH2dVDgsFJuMwoSxHgipvDOK9CXDlE/gEypP9WoA8yHOGoe1y6plyg
         +b2H+PWHY9NhdSaUFNeDwbznzU+6S/qTeQOlfMnZZNEpphuDS5y+vjHaXKTJjfV4ZRxM
         ia7FUPwZxiL66EcFju7Y3sakaRMe2uytakcxz6NJ6we1OZfc4XSvjcNcMJy1TrMjEEvs
         nQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741043850; x=1741648650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJU/yvYz6haiwFOMPRsCHOU6kFhXq6ZBBygufHFSnzw=;
        b=Hkgpnwunw7NeDCrqkxICXrd0BM2otE7JbS+K4v9rZ50QI9XGgbhPo6U/DnlRCv5Dcx
         18XZIQzp16ltdpJKE2LSSkdyuk0G7Ar96YueL2l8TbyjpkFbFshTXzXZKDwPu3kZWlmQ
         Pz6Lr0mOOSImk/eni1iZZrZBfMpysogDsGL0jCuBrddWb3LNDtE+i70ZESTmDq36OYEQ
         Y+010gW7xpX2+DEPk7drYiBamw12uKujVObDIR8QgyR4k1Zvt6CwVyTA3Y3rTWxZFCQY
         35mZVrdL7r+GEPijCBsoA2Pcjk7cissR4RM26phXs14jplszOkV/MkWoDueuhLUkLVa5
         HmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYuusN7gCpDNh0ZPhiiwj7G7BkaUn1+MWFR6TpW5Hb8bkFlgfC570uDjU7V/5AMkulXSSEru01/FGw76o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMbr3xnc+LnhaA05C35cFH7suncXHM/tT9EdqFaQ8ojlibnyU
	MGLs9G4xUCWNzKh1HuWNcR4cLKAp1UOgGHRuyohD6X7W0G0O7nhknPI5ckrPjMK89KtNbhKW0yn
	pWggEpxPf50V4hNUk0hFwMjQncyjRePlpMZeUjA==
X-Gm-Gg: ASbGncsyhdG9gsA1hCHHMF8gI4AqJEq826nGu8AFMwX9Nmf1nC7az5s6ntEZHzR+xAm
	QS/J3vHnVq13RDAw/dg+xcrT94+On/IsyCAe1vuv/mJmEuUTWPU56eJgiLossnprW3tNvPpdNl6
	R/UGKUSIRmReProkbf3ygkAYkz8QHBqOdsv7oNLyQ4R6HJvZWHg8/exgFNe9M=
X-Google-Smtp-Source: AGHT+IE6J32scZcQCUr9Yh/ghM/bua+zO4/HH6rxu31moRlCqq0EicPtjHBgPE4qSnbGz5efb6sDCSe0Ys70/YyeEEs=
X-Received: by 2002:a05:6902:2405:b0:e60:9f80:535 with SMTP id
 3f1490d57ef6-e60b2f1ceabmr19768288276.40.1741043850226; Mon, 03 Mar 2025
 15:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201-topic-ignore_unused_warn-v1-1-f29db78cea3a@oss.qualcomm.com>
 <93b5004dacfe1151ca3abbb0fa31eaa6.sboyd@kernel.org> <87241686-90b5-44fe-b4e9-1a59451e3575@broadcom.com>
In-Reply-To: <87241686-90b5-44fe-b4e9-1a59451e3575@broadcom.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 4 Mar 2025 00:17:21 +0100
X-Gm-Features: AQ5f1JrNfSaFjOZVORaIa_wvDSL26potTqDwKAKcZrvq460zrESF_F1ECLmvBmM
Message-ID: <CAA8EJppgU7_BoVCDfTuKVveBnnhtHUN6jEzkUaAou7=aypD-Dw@mail.gmail.com>
Subject: Re: [PATCH] clk: Warn (and therefore taint the kernel) on clk_ignore_unused
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 00:16, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 3/3/25 14:48, Stephen Boyd wrote:
> > Quoting Konrad Dybcio (2025-02-01 08:52:30)
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> If any sort of ignore_unused is in place, it means one of:
> >>
> >> * power is going to waste
> >> * the platform description is incomplete (missing consumer-provider
> >>    relationships)
> >> * the platform description is just broken
> >>
> >> Many people will happily declare their job done when a platform
> >> magically happens to work as they make use of bootloader-enabled
> >> resources, which then leads to double or triple the amount of work
> >> of another person, as they attempt to reduce the unnecessary power
> >> drainage and/or ensure stabiility throughout a suspend-resume cycle.
> >>
> >> Issue a good ol' warning (and taint the kernel) to make such cases
> >> obvious and hopefully draw more attention to it. This way, it'll be
> >> easier to avoid effectively untested code or DT description getting
> >> merged into the kernel, or worse, going into production.
> >>
> >> The clock subsystem plays a crucial part in this quest, as even if
> >> the clock controllers themselves don't draw a lot of power when on
> >> (comparatively), improper description of clock requirements has been
> >> the #1 cause of incomplete/incorrect devicetree bindings in my
> >> experience.
> >
> > What is a user supposed to do about this warning stack? We already print
> > a warning. I don't see us dumping the stack when a driver is unfinished
> > and doesn't implement runtime PM to save power.
> >
>
> Agreed, I don't think this is tremendously helpful given that it does
> not even tell you what part is incomplete, it's just a broad warning for
> the entire system.
>
> Assuming you have a clock provided that can be used to turn clocks off,
> and you did not boot with 'clk_ignore_unused' set on the kernel command
> line, then you should discover pretty quickly which driver is not
> managing the clocks as it should no?

Unfortunately it's sometimes not that easy. And some developers
pretend that 'clk_ignore_unused' is a viable way to run the system.

-- 
With best wishes
Dmitry


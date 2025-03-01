Return-Path: <linux-kernel+bounces-540071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381EBA4AD3F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14DA1895D5A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9AD1DE3CA;
	Sat,  1 Mar 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwNuzjJh"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971231E49F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740852731; cv=none; b=Npp82g1GGF6sjoarjsGbP+IszMlHmwJTIzE8vjAyKu0b5vTI59W+QuCDg89Sc1al9E4Gym0kogj5gqW/fC2LktiSbKWLUBB0v80ErJU7sjzV+NGTxwivDoIx9nB7FaeGTr1DNpRU3cu2oM3XvYjdDVMBvOK17CtyoGGTSknUEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740852731; c=relaxed/simple;
	bh=Eg0hFQaD8ycLhbpwZvT+7PAZXueZuxzeChkcp4728Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNIB7GodCsFgEeBAEEJBTwWqEAbwtrd/nbwhSixTe394LBywRIT+yixocrOLBJ6rFkNIfUkvEIfI9oSqUY0JrIb7jW0040NHkNRueSIWo3eWXWd4OiBtbmeEnpbcIN83hH60j81Mc8QEylp6LZclHiNXj/JjCRUGo3sl6i+WNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LwNuzjJh; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30a36eecb9dso36626751fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 10:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740852728; x=1741457528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg0hFQaD8ycLhbpwZvT+7PAZXueZuxzeChkcp4728Mg=;
        b=LwNuzjJhf8t9gZFJEzYdneEttpVvh1M5eiizXXvuG/Jto1lri+V+J2W0n55nuC7flH
         tPthnUkFlSHBwpcq4OkxyFDhQ6SdBsVOQiWRV26MVkT78mCpTH8MoMMw7Eg3OYrLLYyK
         cO83MtN0um/VtLfV41ho5z93VBU9jo6q/6fTz8iSy9MfI5b5T1lGFbCIYc5Xoq69WOcu
         YP2VZ+/AJkWZM1HsOC4x2/Yj/hiUNEA27MYiBBRHwRMPThB8l4rThWVf3PDk6DSal3KY
         vVgtDJBtNhcu6f3tGIljGTyJTDOoHkLO5eflGtRBkVewkcxs5LqDE8a04oGztKIrhGmf
         UM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740852728; x=1741457528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg0hFQaD8ycLhbpwZvT+7PAZXueZuxzeChkcp4728Mg=;
        b=urUNf21V/AYVsOhLEB9UOL60spvGixFzucuVQhXBHqpkr0N/KS8mlQmHO5krKe815+
         wD2GndhO7aI54mKOWpchX9p96MJJsUQTUvVVXHFiCUu/88vQwQ7PQjO5C6qCyftHYm7v
         u4WCBJ+0G+6Wf/PthS4KBYDmrH9fom2sLl6tmROgat7ritWC0XFkZBCfiZngPfolQ/Z6
         UsCARdVCej//X5AK1o3upeNe8hobBdKi1s368WKyEGU7xhKQW/xTwe6BivxK+7d12xxM
         bsogB82fGzZ3OO2Rl4wyI6gzt6wJFWL9UbFrp9sXZ9BexQC7cB6DM/Fl9XoVKXkkDTzb
         UFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo4rhjAcG+51FcXtuHOlh1/G2xDvnpOME3DEP5jjYrU7hIasC4SwPsO4ZsYk0rtbNiz9LLtTBXIIZp0WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyljcZvqRSXWnqW5GHkCjb/XSnRmcrGVCIJNfra1DV9FeL3p5rn
	NjwjW8jnI5Ew2ePHcwAUQO5xejYjyajkKJc8L3ZJAuAIlkkWJOEh/EYgdm5pSHr2zCnWc5Gjrom
	QysWhtpXX+ggxK1+XXH9r3siIOgyVdwMNBDe7FD7ji34WtGe1
X-Gm-Gg: ASbGncuISxUQgVNlwZX1Fgshk8XBhcGPAOICGEcHkOkBKyCKyY0iNGDsi7gw05w3wYz
	e3FZjbFhAg+cB//ie/PVdq3fk5xbl0A4fGiKeb55KvSbSkQl0H6a81brS3UtEfX/FpbjbCqCen8
	6SuhWVmBh7L6/dn+K99M6r1xcouw==
X-Google-Smtp-Source: AGHT+IEH99Tq5urSrvxoc72GqejnsJAsNSDML6g3rnh8KP+Vmtk9gqB7j3gZFHmLs6QHmiQqUlP2gDlbwUBJuyx82iI=
X-Received: by 2002:a2e:8052:0:b0:307:e368:6bd6 with SMTP id
 38308e7fff4ca-30b933037d4mr26808421fa.32.1740852727658; Sat, 01 Mar 2025
 10:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org> <20250228-rtc-cleanups-v1-10-b44cec078481@linaro.org>
In-Reply-To: <20250228-rtc-cleanups-v1-10-b44cec078481@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 1 Mar 2025 19:11:56 +0100
X-Gm-Features: AQ5f1JrUCPCMLG1ATCrGher1b7FQk-JSwRhx_use4qjyzNuoMvAXn5iqo9KhAOA
Message-ID: <CACRpkdamF4B1y+zr-Y_XB8gAoSv2Q2U4VxuZd+ivZq7KV1Quyw@mail.gmail.com>
Subject: Re: [PATCH 10/18] rtc: pl030: drop needless struct pl030_rtc::rtc member
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, =?UTF-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>, 
	Dianlong Li <long17.cool@163.com>, linux-kernel@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:07=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:

> The memory pointed to by the ::rtc member is managed via devres, and
> no code in this driver uses it past _probe().
>
> We can drop it from the structure and just use a local temporary
> variable, reducing runtime memory consumption by a few bytes.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


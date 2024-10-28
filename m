Return-Path: <linux-kernel+bounces-384996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CBF9B3130
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09424281CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232331DB34E;
	Mon, 28 Oct 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnCfI7vX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4A1DAC9B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120361; cv=none; b=PrOA2vVhCuPAmgb3dgFZemQpEVAEY09Gqu439Z88EIXc1+oJlveJdT2bNKjzV7xM6VRVPTait7ad69QBb3VUu8nLKKee8A8KGeeJKo7ffZaJxV+KzfA/EgNsBFohD+bH2jpu3GDE3/9nPXPxgrjTFFa2aoC3xqe9TRIgJNvpv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120361; c=relaxed/simple;
	bh=8FPOv073XmotRWP+rOXc9l76Bgjr4K2jU62eaHorWlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smD+HiQhzrG6VbFrSWMjXao0VKPS2PDFY+M3q0Kbpp+ZQctimr0osWpOnJN1xYq+x6gSCdJtOdTnh3ZG4invjmlEfrhFedGPDRi6eLTv+UIUc58V0BaD/LvESR1Of9Lq2nYNfybyM+sqsmpacseTDDuUxl8LNfW8ko6hEiU16Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SnCfI7vX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a0c160b94so4693791e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730120357; x=1730725157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FPOv073XmotRWP+rOXc9l76Bgjr4K2jU62eaHorWlA=;
        b=SnCfI7vXHl6HHE7GwLtS7AXDj2CHgM0IAmvoPLalA66p8Na07OBG7mmbD9xBVYfAqs
         iRzJdHy/hbUFeGXSD/x1iy+GZZj0Xu4vmjCPYWHtH9uYIU6H+JggvMFG84oOBzKXdxz1
         PDIZBJTGJ3pt4vnRo5taMz6RV5CLooDi9P7PO5Sl9wT1wZBTv4BYw6ZmeiBBTVJyp3Bd
         N9OpLSDh2ulq3z3Ocp4sLuZerqXW5+NYhqOP3UUxlzCvKYHHSc7nvi8ay+4Vo0NjcAYM
         8SgLJyfYAOHurMJXqZGGEcLeqoy59/EhN1knvTLScDi/2+RW/Ohv+KXPssUCd0eRR8Fd
         9qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730120357; x=1730725157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FPOv073XmotRWP+rOXc9l76Bgjr4K2jU62eaHorWlA=;
        b=kCS0pcKaCTqnMiZO4U/J0Kp35dScuhK2peipIFkXi8ogORPoiGO29J0H3g0d8QxYld
         yN9GnBszn3JSpXMi2I54xy153rOnIw6rUydQfw6+Das3UQjOKWC0Dm03dJx7F52Ufq6f
         GIirgwPNCDHd3Ysv/lKb2Q51hKORzh7oBIn1ScL8MJddQCigg8lNq89tJn7AcACf8i/+
         3ulz6CHfyGws2XbIt+kzEVMOTqX726VUheWA/os34fMoEtS9sLBsi9f7QFuiyzlIatZQ
         Xc9V20U0P+DVFOo3SoQo0JFVtL5TxxfB56aHavHbTyrG9PuWX4CH7jxk5biBRN/708sl
         4exw==
X-Forwarded-Encrypted: i=1; AJvYcCVdPqNK6wWE1HhQbScX7ieMvxBqYifv6xaPj6GcKIJzFXQjKsk9HLXuhPPmvMLxwqhwpyRvZq+MyghAhoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynCm6GQhIqFgHf3b/KGHnCsX3AYQY3xaigEJU5Hgt6Q/ytZTwV
	tAoR080ABfSf62XkfG5OxIsGls/IUzmtePP1SkGcYHD7giDBAk1y2pKrb9y+UkFfk37AFwyEEzj
	R0JYgy1hyp9OlbDudZ0GvIKVoJBgh/X8h/jvHbw==
X-Google-Smtp-Source: AGHT+IGx7tfNH0mZRuKTFpu/Lt1lVaJ5wzth2GIk/zrU6MEJ3/k+kc+DMdfavO6Q5ppLTlt1sP5ACchOTuFdcWBszp8=
X-Received: by 2002:a05:6512:3e11:b0:535:66ff:c681 with SMTP id
 2adb3069b0e04-53b34a1b681mr3290500e87.48.1730120356663; Mon, 28 Oct 2024
 05:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023104406.4083460-1-billy_tsai@aspeedtech.com>
In-Reply-To: <20241023104406.4083460-1-billy_tsai@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 13:59:05 +0100
Message-ID: <CACRpkdYEbczXUFD-CFpE6SYiqhwTdxS+w5+dDtLF=2BmeiJeVg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed-g6: Support drive-strength for GPIOF/G
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:44=E2=80=AFPM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:

> Add drive strength configuration support for GPIO F and G groups.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patch applied.

Yours,
Linus Walleij


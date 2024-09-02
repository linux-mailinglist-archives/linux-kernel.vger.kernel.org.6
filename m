Return-Path: <linux-kernel+bounces-310826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA999681B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EE9B20A10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCB185B7F;
	Mon,  2 Sep 2024 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKQS66DY"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEF617A5BD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265620; cv=none; b=VopJfgi+/PNnaSx84/ZTDVHUjEVE8Vt0wgoGg8aBdIxLFPhFlmbkTHmVyVfIC3UfuBHAl/Jx8McGr8WJujB+M+9tuW0mMtRRQHo4+u359GRfzngU1Qwt5DxEsHTYxoT/sAlduazCP1LYjAHqDVajCMtf9llcN+RZJ/dMyizI7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265620; c=relaxed/simple;
	bh=4lmuq5BO94kHKYjwf/STfshOSd37lqKljCe+/DQPnQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZhyqrE0KfJRwW8yV/j+S/lGDlYOTI1ncWO6Eiej3mFMwrxRuHB2h2VNBZs1bd8FwX3vwpFfiW+5zsnu+yiMGo6KbHmi1PG3V00dBmclj3G1y2ELf3PktXPSrcxT1wOpy2qukvwbKuR45u2gtHtu9ghGnNwEWY/sf/rTJ3p37HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BKQS66DY; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f401b2347dso35144001fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725265617; x=1725870417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gqoKM1aect4l0xgmZSyLQOJVqgjUZqiT8L6Ldx5788=;
        b=BKQS66DYGwCmXx+ho3tP1ku7WGrTdKuYxTiBmj9XaD/ILWcsJKsPrf4u1rd1eclvSA
         Sz6QSWxUWIOgq3Xmy/cPLkHwuBt3z1uYAFmTuKafMKhbrYUlV+GDYoODsgMpVJgrXTuT
         JDUF0/MPdqxJOzMECveEuITXpp/ocOUsazQPZiiO4xS8vp4I8wHa4S6wL+oj65z/+EM/
         /tdhDijme7VC5sSFZKMEuMEC03jJV3apXQs2HaxUHjZZBp5ZIrvvm5oOybVIZKEgnWZp
         JzW7OsyonB6nH03SkA5LgEij7iRpu4S5GY9s9D4EQzUZa0HT2PQY9TNN+KuNbFQ5378O
         4rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265617; x=1725870417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gqoKM1aect4l0xgmZSyLQOJVqgjUZqiT8L6Ldx5788=;
        b=cbx7PR2ijFYO3Cn2m1EVIV7vA91z/2UBv4pgfhNqR7LG6bn7jub25lvZ2AdwGF+Hr2
         orHeoO97JPdeoXNWo49quCgKqe52Ex+3/uylXz28ZwlCBu+GC46w/DJgV98k58+hKqyH
         ijWJTfKIHBVdIcj1bbqi+Axw3eHyvUuY0iig8dzlq3dUAGDQYiKe2xFVJOrWvsDP604t
         13byo/2iYfojf3gcyvZ5iqyjJE5zwR5vQY20IbeUrSS1i2BY2fcv3PpxRqoNfwkh+/lT
         M/aprMgRv8Dn/JXfLFkSEDksMagAPX8akeCpoeDouixbrfk4oTuOdauIOfXRWVmPV6rZ
         1Alw==
X-Forwarded-Encrypted: i=1; AJvYcCX1FOAxBCzoL7eFjLLkLHDRkw04w39a6wa4s3xiMcbF4721VNmoOMxqxoatmeb3huAdCo+Kz2cH3HtBvLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL6sedRWS3xf6U/0wdSA/QnecR8/bIsMdwqWNW1LLV/dXXhk+r
	bzqW5msmBsQDK6u4SA7p3s8UVGTcZfWm58eDQltatoBQg1uyizkwUemr5OH4dsR7Dwnado5hLa4
	HS2H9lQgAcTawfncZih4Q+HOpCkVGthjbgMD2+hHo43n0Sb/i
X-Google-Smtp-Source: AGHT+IE19as9qXHa80m04976+p4Hw7/SgTBETcs9158iDLNlM7aXWSyyuCdphZi5UDS6RxRBqwZgoqzaVDQwX8yRgX4=
X-Received: by 2002:a05:651c:2209:b0:2f3:ac23:b1db with SMTP id
 38308e7fff4ca-2f61299d997mr48523101fa.4.1725265616566; Mon, 02 Sep 2024
 01:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829064938.20114-1-wangjianzheng@vivo.com>
In-Reply-To: <20240829064938.20114-1-wangjianzheng@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 10:26:45 +0200
Message-ID: <CACRpkdZc2L2jLufmfrWzqCp3A4oS8w+K6oD+FNyX5pJvE3aw-w@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: k210: Use devm_clk_get_enabled() helpers
To: Wang Jianzheng <wangjianzheng@vivo.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
	"open list:CANAAN/KENDRYTE K210 SOC FPIOA DRIVER" <linux-riscv@lists.infradead.org>, 
	"open list:CANAAN/KENDRYTE K210 SOC FPIOA DRIVER" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:49=E2=80=AFAM Wang Jianzheng <wangjianzheng@vivo.=
com> wrote:

> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
>
> This simplifies the code and avoids the calls to clk_disable_unprepare().
>
> Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>

Patch applied!

Yours,
Linus Walleij


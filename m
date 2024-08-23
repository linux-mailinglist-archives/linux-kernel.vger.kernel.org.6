Return-Path: <linux-kernel+bounces-299322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E73095D2FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B974E1F223A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9690118BC19;
	Fri, 23 Aug 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeVrAUHt"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428A18893B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429723; cv=none; b=TvXBIrmUcMXJDz+5+eFJN6CEId/P5WN+gyf64Dqvtlj5UFcnNOik4ouflnzb24dWUyKwpSHPqMQpMCjbnK++BJUwuuj8TTYVPhvljfRln8MwN+ZtMblQe0NA0RyUvxu7bktln30OJ9eLn0sIJaD8fanQrOQkoTBG5x7W3SSXcRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429723; c=relaxed/simple;
	bh=C5Gy3ZId6yOjmctbIVasH93MCo94aby8IKwF+9R6dBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhqjAG898md2E3JBFw81WS/H2zqkbrcyCdb+8v5GmoXB3jNruStMqo9noJlVnop86edsPkMHNfyWekiXDmsZivnhlrnXz+LjKAUx5t4yAnv5fAu3wB9hr6M2SC3CxiQqgHfY0FrE+8Mo+8MHq/Y20FDx98m90tggqSYLVSuwzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zeVrAUHt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efdf02d13so3152640e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724429720; x=1725034520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5Gy3ZId6yOjmctbIVasH93MCo94aby8IKwF+9R6dBY=;
        b=zeVrAUHtYNyzCVOhCxPtOx/PFzqms4CRAYeAMWfQJUkSo7cJqHtyXh7i/oE3v+Po5x
         qpeBRPUMWnNwhkmhSW1aeq80/n5yEWDrmulqnyeceJRFkYLBtDYcgoLoQ5ZxjpJWSRaI
         tbhBmr6YJDBOXaVU8MLixHqo0vRJPk0ts1KIxgWYEz+rM1r1/f7St5Wk8HJ+9L5Il9h0
         vasVXLH1bdtnBT38s0wSeObDv805d/v9Fdpb7yQ1nRRxGGCUMJOVuYcrZg5shvT07eC8
         znK9ji7bqVeLElGXb9KY0O0livs+EljLeTA2Ddwg4xXfuhMZtEEUeBMZ79EouPI3z5WU
         ThUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429720; x=1725034520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5Gy3ZId6yOjmctbIVasH93MCo94aby8IKwF+9R6dBY=;
        b=kg7OVuoFG3dPNvemuyrJLFq4/YB9DNl7S/bhgVaRneLWXgZwQvcam8n8hH1Zs3Lxnc
         4ve1bqN2hTuspNByChiJCtPBPNWsfD3xYb2KmPSZJ2V1C167e+HLS8QfuZKl6YY/iQAh
         VOR0AI1u4UpoFapDMGDH3k8UouBeu1OB7mRsrkY9U3SogxGfp8XuMNeX444cwQKGkBzY
         2sUrUeBBz0/pnlk6ffErFijSVYUMK+1IWdC4/FRN+10bh+ULo+BhiCtjHmKqS3Or13EF
         s+/KcqkHLm1Ps9NeQkvAK1f4wUPge8X46h/MgBj7GYDAGNVlSwffZsyMRjT33mF7zNRp
         wktA==
X-Forwarded-Encrypted: i=1; AJvYcCUzkOOBGePevu/8uipcnI0v27WE4HFJGNc8vKWAadwzaRoJpkB8gKmYhCe7sdYiIzU3wFvkw8C2QXvdP9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBthCk/3glOnL4/Cnk+8wPcq4xnHg2N2u17XMz4jBPILhOHQh2
	wV5YYpV9cbNGaH3qWS7uCneCCF1LPeaU2x3JEgaWAC49IpAmang824V3LCsC/W5k0Efv9eZkp8R
	XqW+BFFTjyl4jKi0E1TMRHT50CnvI5dMQ9j8Z7OV6P1gK+Bpj
X-Google-Smtp-Source: AGHT+IGJPc27ebiUmoATDf9yag8DXGApJ/P5FrQbUYThINyChz3wQOt+1Fq/9yZmuLv1y4j4c8GOPP45gknN67Is4t4=
X-Received: by 2002:a05:6512:68f:b0:533:4785:82ab with SMTP id
 2adb3069b0e04-5343883d67fmr2325707e87.1.1724429720087; Fri, 23 Aug 2024
 09:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812070108.100923-1-hal.feng@starfivetech.com>
In-Reply-To: <20240812070108.100923-1-hal.feng@starfivetech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 18:15:09 +0200
Message-ID: <CACRpkdZQGpVusAg3tZ-sNC2WENrBdLhN3SaEYFCbyx_fVmKDrA@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: starfive: jh7110: Correct the level trigger
 configuration of iev register
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Jianlong Huang <jianlong.huang@starfivetech.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:02=E2=80=AFAM Hal Feng <hal.feng@starfivetech.com=
> wrote:

> A mistake was made in level trigger register configuration. Correct it.
>
> Fixes: 447976ab62c5 ("pinctrl: starfive: Add StarFive JH7110 sys controll=
er driver")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Patch applied for fixes!

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-431341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FB09E3D32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B1BB31F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F941F7594;
	Wed,  4 Dec 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cF7yiNON"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262914884D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321229; cv=none; b=gwZZoGZePaMZXCT6aH3bdZcf88w8LUHTrX4nYVBLbT0SpxTI7SJH2HrNIFEJPmCOXH1FYAVPdHRcNqEruzxOTivJTr6MmY4OpqNOLbMmneKUOqtF6xjLGnMLDUpmwCKBVo3spVV3/ABQ6ULi+hfHMaGzbUbDqpZR6+P+19acKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321229; c=relaxed/simple;
	bh=hgOnyvSPsysP0N8uHf75Ej+i9XPK5nyimRqQNT4YvFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYTrwOJrTdDQbtWVunleE6I6dKr1+kngyBxb6LLnw0rsWxmtIx8KMHmTa54qfgYZEJxCVSBWmE/gJLzkjjMNCNrSDhrATndfc0dheWchtMFvNHh9aQy5TO4T63RNj7MeB4ef23FqiB4Odln+EI/u+AydN+lJJFYZDZNOfgD8Zpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cF7yiNON; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3983fe3aadso5221497276.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733321227; x=1733926027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgOnyvSPsysP0N8uHf75Ej+i9XPK5nyimRqQNT4YvFw=;
        b=cF7yiNONGIZADcz94bx2MlGXEz/tmtB63N01mRBjIbdRISHpUkkUbGweoXMmN63kdy
         yfoWj+LWkTgmkn3SQWlndhNdeZtyGMWGClnoGz0wjYJvVyP1LUyhnRNsRjPDNRamR/gW
         IKAkV5BMXDT9CuE5Z1bib9coFzUen0yT18EdP5RL3TjimMX5zPzg4r7cIz80tIaJ7oKs
         unBvV2gfQY34CuEJVSl5MDz5ATX8Mh4ELeCCcou9l7LhBpYGi9ZrrNYXsUIruZEJzyxs
         LFDV1FNdE8StI4nacBvrnWG+UhOEcmRExtjV4rZ4AW4YZrZUI9MRpM3w86XoXY/clZsv
         7mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321227; x=1733926027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgOnyvSPsysP0N8uHf75Ej+i9XPK5nyimRqQNT4YvFw=;
        b=c8zkcKj8/tYDdKk20JXy5/anmAtsiRxJIC/0FHXL/c09e6AsRhhTx48C5exKZtz5s4
         AD8CyYnBIQtI5JSqhBroYWMsfqLZ3uOelCNyp9TvWQcxKi0mskCDhbkOX7/p3YWtcpMW
         RZF1DArLsyPS7JNCFuZIqgdHtECBKd2LAsZE5ZvemJEujkQbphSqRhbBvy/zNLBsH10Q
         tStAMiaxFRF9bb+H3KhX01txZP5kM4cLY9GQ/pSb1JaEE/dtz/bLiiHOuhfjGqMJiTYk
         febCX9dLjisZucPo99YWRQsAxqmhTNll/uqpa6hK2bWxWwt6aHuxg+jtDwH6pVS27N20
         +RnA==
X-Gm-Message-State: AOJu0YySpytoPl+LbN7X9ApKKfFcyPqpZeGH7KkTuX9rBs06yupCRhVj
	+3mvyiU+ElE3h0EdVMxHMSSsERON2JZS9iNrTt49rYt8wf2IlZi0n7pI1Wan0T4XpGPgYSUN5LA
	fQyF9MoeJpsdfABWTSwvwd63NDRNZU2MF2s11CQ==
X-Gm-Gg: ASbGncvpkeGjXVKPvdNXbbXVN++99D7DBUHHQyyxawcQjcLltlQDNlfub7Sw+bWQOZU
	BWSFEOZ5KLDISUM/y6kWsA34SP9ee2Q==
X-Google-Smtp-Source: AGHT+IHdSV8FvjpPXzF7FPk1hnZCveFPl+7GVKODFFqqEft20XPKzT/tp/zHk5OEUZhTvdJwQSxDZSuS6skZEdlIf8c=
X-Received: by 2002:a05:6902:150d:b0:e39:3168:ec4 with SMTP id
 3f1490d57ef6-e39d39edb7bmr5375982276.4.1733321226883; Wed, 04 Dec 2024
 06:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-9-arnd@kernel.org>
In-Reply-To: <20241204102904.1863796-9-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 15:06:54 +0100
Message-ID: <CACRpkdaj4DqETs8ueH9mVuGWfu4LgvWNKy-fb+3NKaUaCZY=tQ@mail.gmail.com>
Subject: Re: [PATCH 08/15] ARM: update FPE_NWFPE help text
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, 
	Ard Biesheuvel <ardb@kernel.org>, Daniel Mack <daniel@zonque.org>, 
	Gregory Clement <gregory.clement@bootlin.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	"Jeremy J. Peper" <jeremy@jeremypeper.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Ralph Siemsen <ralph.siemsen@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@armlinux.org.uk>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:30=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The help text is seriously outdated and predates the introduction of
> VFP floating point units that were available as early as some ARM926
> based systems.
>
> Change the help text to reflect that this is now a legacy feature
> and that it will go away along with OABI support in the future.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

On my affected silicon everything is custom compiled with
software floating point, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


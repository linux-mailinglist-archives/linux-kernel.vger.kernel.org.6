Return-Path: <linux-kernel+bounces-199563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC968D8898
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977D9282613
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465401386AB;
	Mon,  3 Jun 2024 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b="KW2VNNtd"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC5132804
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439325; cv=none; b=Aj626JynJEQgwWZGLL1X3Rt0hfXh0B0rqO8MapEnONdg84YzXlrjv8VME4ycncuRuaijmeoPFaNWk8NRdfycCnBEXtZQvozrCbH0Cx1RyTtvVzu3m6h8gebOg1wooSPr7DbZZISfqRz8VhOOsKKIdyr9rGaoTqcADQwZHmU2m3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439325; c=relaxed/simple;
	bh=5pzzmTHBAXlzWf0fDrqD3054nWAfrzHKttjQoBvV6sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyM36jkH/FjIuB17NnwuKV0uYeXPH5HKQkGQGey6em6KkCFWSJrDejsOsokqyDViwqKyXtVFKEoqpDCAFOCW2DCDwtXUkwUAU2heLHm8Kq/HjGXWlFrEdm40WAtOTfeqMz4co/hceCRxirep1Q5TMcVV9gs/6xYVaKBC6DKVwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b=KW2VNNtd; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a087c3a92so2543837b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20230601.gappssmtp.com; s=20230601; t=1717439322; x=1718044122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pzzmTHBAXlzWf0fDrqD3054nWAfrzHKttjQoBvV6sI=;
        b=KW2VNNtd03rWqwEQzf6Q74A20dPzap/wjpDFbYjtTevnIbj3QzQCt9Hrowxtx6BkiH
         c52JA/OCIHm5gf0xTz2hPLHimhQHIaajSdYg0fzCvnODGYXFcubW+MZ62VMH3bh66EwJ
         D6CWnHQg38eXudwJ7fi9pwFp+vtx5wolItg4kaGfXCDLseGMi9/9o2VX147JJsfIa4xG
         RgoMbId4OhQw0KrvyXubfNWwKggJJFod6gybvhVuEN5vOVsmYxGfacebm9qHrQTqwLws
         oETRPCJCwmtqbJo46H/haCLk5laEL1QCO9d1JJYiaduJf2LdmGm/dvFKzHZbdfgDGuzB
         5O8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717439322; x=1718044122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pzzmTHBAXlzWf0fDrqD3054nWAfrzHKttjQoBvV6sI=;
        b=uVupg5294sQTjVqXyry+3rSCwAKapQAd3IVVsuNLlqmnfvEK/kN3vtf0vzIu+G+mby
         bGa1eEBcOdtkCgsjS91HZ7vAYr0dsICX55tAk+56Ge0d2Y9ZiKNtT/TdHOgaacdcSsTh
         n741X4j9fgoSmvIYs31N344/PyhPWnrfryMpjMTNQw1IzhomWCul7FM3udwVT/Kl6G7H
         jbqhSBKQTOZBxHpKw5J0UheiY05g+165u7+Z1bMWk/siKi9a8fPJu4vtubJUPpmBUaZF
         Y610iRg+eTLccvLsfP0orICKrv6dhUbKz7SFUiaPuyv2FcLNubtmiGQOc5UEbhHQZuf7
         pKZg==
X-Forwarded-Encrypted: i=1; AJvYcCUuREf86Gvw23/puyuH4zF/kUDUNhpGCEpKExBlgvTdjSbFayQyNnCv40niK32iL9gxjbJCUtqNzOU/KeAmYRen3gSI4/hZgPJ4vhCq
X-Gm-Message-State: AOJu0YzuqCxqqvvnHBl7+fTWIJfPQIzxU424qGlhUVdamvFfMqJEnbCr
	XSug4bcH+K0K3lwUHNJTzmTuuKrzbbAQmCISot50bE2+t3W4VyQh6TY63QXflPfEJc7qA8JcRRT
	PoLSE59b0VKdQxrKmAEsjD0dE2mAktjXpO6ph
X-Google-Smtp-Source: AGHT+IGulLHiVlAu1zMn1t7/FgP4mCz1TMuwVkx21CLBQBobctyxmCSyaH0vfSMDP6EvEXT0pr2zriPWNX0ELMfuTkU=
X-Received: by 2002:a25:db04:0:b0:df4:46a6:77ed with SMTP id
 3f1490d57ef6-dfa73c4df61mr10211456276.27.1717439322486; Mon, 03 Jun 2024
 11:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603063834.5580-1-ben@jubnut.com>
In-Reply-To: <20240603063834.5580-1-ben@jubnut.com>
From: Dustin Howett <dustin@howett.net>
Date: Mon, 3 Jun 2024 13:28:31 -0500
Message-ID: <CA+BfgNKcG4ShokZ3ERmg75nJXMRbwJeAH=GnWwHt6A3XRar+gQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] platform/chrome: Fix MEC concurrency problems for
 Framework Laptop
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, Kieran Levin <ktl@frame.work>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Mario Limonciello <mario.limonciello@amd.com>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 1:38=E2=80=AFAM Ben Walsh <ben@jubnut.com> wrote:
>
> It has _not_ been tested on any Chromebook devices.

Good news!

I've tested this patch series on the following devices:

- Chromebook Pixel 2013 ("link")
- Framework Laptop 11th Gen Intel Core ("hx20"), firmware revision 3.19
- Framework Laptop AMD Ryzen 7040 Series ("azalea"), firmware revision 3.05

It works as expected.
There is no detectable difference at runtime on Link, nor does the
driver appear to improperly bind any ACPI devices.
I cannot reproduce bus contention on hx20, even performing operations
that would consistently fail without this patch (e.g. long flash
reads).

Therefore, for the series:

Tested-on: link, hx20, azalea
Tested-by: Dustin L. Howett <dustin@howett.net>


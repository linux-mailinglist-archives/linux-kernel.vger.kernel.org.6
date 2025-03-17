Return-Path: <linux-kernel+bounces-564229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F8A650CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEAA167FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA0723ED40;
	Mon, 17 Mar 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNTNn934"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002F22759C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218109; cv=none; b=eLJXCTQU2wG/GFk7H4N57JizP6RNWSeU7iQi5nX0YwFVoxLGDaQm8bG4DwQD0z8ULedzNEXDytqPrW7qqKq5b13FG/RE2z7c5kz7J3mzuYAYw5g0iCLtE/pbEwqdm/W617+wuH9FzsNnYZuY2Zx9uftzibu9B7eVCrxbDI7udyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218109; c=relaxed/simple;
	bh=lEmfNyIA6RNJ3ny5+YoC3NGJhAIqHrv/+7Ma+TDB3uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3/Pp9/I8+VNdyMo9nf9Hq5CDs4Q7l6Ai4JpZaeN3ZSQp6BBkQ7Y37s2CJkgbguOGNqvuFDDJaykh3FMQ+plVY3NhBCdY5YUHRAA3ThM/tVIUB4fU7N9b2BIVPnBhuyl64m06rEgFLIZmYBm7iwbf/jA3MPQfmV5EauFPZ98e3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZNTNn934; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a59so49633331fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742218106; x=1742822906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCb4df9E2zGdFeYXN7RFk9uBy6N11qlE25jYcmNSEUM=;
        b=ZNTNn934T0vMmGq8TugDom9m98NBkAy2UN0yw+1/yHAf4dUzjAISv6yww3avgTzb9r
         Fnu+XXIsnzzVxNjb3epLPT+PY7xIHlY+986vPyGjOjRUeuGwGKmdvK6N2deLaDPh05Wb
         TBui02AWR4m1sJsEaXaveiqjEF5uNW2WJQDPGGV3g13nFfHP10Vyl86IWQh9t0DK29/B
         HNK6gzjhT5Q1Nd6Re6vHnqDbFJR51JFEvpbWdm1rD3/I9wMwOERL9axWpbkGCgt+XE+o
         VypVQ71erJbccO6I9im9kgq7rHZh1dooM70W6/cDYJSuKAjm74fNBrYsLdaWfE0zQWpL
         a+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742218106; x=1742822906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCb4df9E2zGdFeYXN7RFk9uBy6N11qlE25jYcmNSEUM=;
        b=uw3l2rMUwZ/N4/O9eOuRbeYdX4EreBaMiKr1U1L5dSgvNw6BjSYweqK0W/Odjtr1e6
         vSZxN18/lJYWE/3JAZ+t2TA0LGy32qvgIZs1ywB1VRxTUpfukVm1oJ0SKJQaS8iErdg+
         2PBADbsOVcWnxiEMr+SODfdPMV7uGU8WYhrhAj0ch4/anNgdLSSWX6yBsgcnR+j5gw+X
         M5VyfZbTmM4zc1RF1dfVm3LQW1wRC1kNFeOIrgdOpWU1w2RN16k48UVHhGr+dUv6spOx
         tIUZ1elqgJDh9Uf4rNIsU2x0swUh4eGRzGuJs7/RTxaZcIcWOMLDS/BxtDV5DlaUQorS
         MYOg==
X-Forwarded-Encrypted: i=1; AJvYcCWMItiItNE/filKb1bZbqoonRPFJQFygtLujPWGmMXGA6Ron4si5+TyENd4sdvU3jWqh6WHsPA6UkDdNTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFI4XB7SX8iAEUUF61QD9e0GjpYyBdlDD0I5c3rjtFr6qk6IN
	LHFNSVRiWx+dzoAc4leiZNEMcgX/usjx3NlgfCNkZ/kouIeSOEw9UhDTMu4xVyeTNLxOpLezNj+
	GFBI4qqyOcx+/i7qk8hriztc4M404GSUMje0Q5A==
X-Gm-Gg: ASbGncuEpOMei7Ze9rP8tZzCqqO/H6EFLWlaZ3djJKuIB/385xvf8j9pnY3u5QyjtHZ
	FYMRwiJNDr7T/swmvMuDTAZt29Qtmv62jCeMHORu07QHdtsW4j+hPeuHQbkaW1Ue8+abMY+XuuH
	FskKH6TWiGtXeJ3D8DtJnLLz2LXbxpr/bWgg==
X-Google-Smtp-Source: AGHT+IHfDvwh0B6r6tp0N3rPaDV+ueRiI+e16YoknvYQYEn15rtBX3cLUUUSuskc9RIR+xdHm27WD7RcqnQ3U6ffaps=
X-Received: by 2002:a05:6512:128a:b0:545:3037:a73a with SMTP id
 2adb3069b0e04-549c39045f1mr6739117e87.13.1742218106136; Mon, 17 Mar 2025
 06:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317084331.032c61d9@canb.auug.org.au>
In-Reply-To: <20250317084331.032c61d9@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Mar 2025 14:28:15 +0100
X-Gm-Features: AQ5f1JpHY_xjtnDU5i4KEaQWMkGw18yj3KS7YcrQUBJ62FogfFBiv04Z1Kwj2Es
Message-ID: <CACRpkdYMo7wdnahe8rCtUB0epSz4j=0d5r8GxZn0AbrLdU_yXg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Prathamesh Shete <pshete@nvidia.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 10:43=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:


> In commit
>
>   a906b771499a ("pinctrl: tegra: Set SFIO mode to Mux Register")
>
> Fixes tag
>
>   Fixes: 59b67585e242 ("pinctrl: add a driver for NVIDIA Tegra")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 971dac7123c7 ("pinctrl: add a driver for NVIDIA Tegra")

I went in and fixed it!

Yours,
Linus Walleij


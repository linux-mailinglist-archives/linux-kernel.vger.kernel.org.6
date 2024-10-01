Return-Path: <linux-kernel+bounces-346116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD498BFD2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E171F25D91
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582EB1C6F46;
	Tue,  1 Oct 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9PUZspV"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3AB1C4619
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792662; cv=none; b=iu9rK59IvpNyl8OcnacwuRo5GfVNfwYSrbxy7Dx9h7lGhmRIpWMYvNaQE4yeG9o6xkaGba/JW6cNpSjriW8u0cSr1PGMASr4YS0fhgb3UdRnqH6Czhe5Ty7QkUDIPdYufzAJymeKw8EaunoVhsE1PX/0gW4NCIqGjoRMBdac3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792662; c=relaxed/simple;
	bh=l5BM5b5k2TCeltBEWllLsPAl1pVOeHprS9AfvY9vl3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niY9VjkybAM4zxgi6i3iVWBvhZjKcPY2/w+QDzu74mFqe1CGcbLbaPcLipfFcOXwLE5K3Co5XNpKiMhLbAR3HsLrsILhDag/icv74Ul8qApRzTvzWJJKwFDZXpnm2Vq1ausrQuuA3mE/AEF2NGhzwNibV8w7dSa2HZHiVZ6QQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D9PUZspV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53995380bb3so2600987e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727792658; x=1728397458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5BM5b5k2TCeltBEWllLsPAl1pVOeHprS9AfvY9vl3M=;
        b=D9PUZspVorhQtsRqfM5wsx/gttEoAbJ81qsgaxxtysDkPGiodxQz8tX82vPdKVbeh3
         UHeKYdcWoeO4nXam/lPEgxs2G/CnBJxblUOAhvopKeKQUw3rxSudWwT5WqZwt+U2g2mm
         G/QBEXgpXTVoEm50FBllIsX3RM9EifxGZGMIFfnspvCTeegjANensnwRotenaT8YzyZh
         ODbH+bxye3rkhybmVKjo1RJAsPfprhgTXaKLBzqcrwP+n23ZCv8zY8F2ELOaDkmiMu/T
         B0YLrawa8BOmi4AnKVhe9f2YLkRh7+1aVsgSXEGAqTqNUN0roRI2CsjRCsa8PMR0aQWK
         UWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792658; x=1728397458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5BM5b5k2TCeltBEWllLsPAl1pVOeHprS9AfvY9vl3M=;
        b=Ff1ZVWMVv9ZCYiTHXWskOLyfJWxbpcSAAQjBdPVQVT1DGpRDK9Cmi6wTlHz/T9txOb
         1KVlNN6CkzfwLBmV9vf5IDU6hXpQMW7u5ubQL7c+YudKnunoKhWgs6A/lE3wf7zUUbds
         2FH1+0KN4OFquIRJ+beEADGEdYqogdEv2qWI4Venc8OK/T3BUZe6MhjKEkKC0SiO7Bnl
         U/40+7gQHL/fHUjfKSrWdpRMk7a0rVXmWFh0z7WIGiJBWh6DVHirLTaH+rp/DUcFAa65
         sA1deXql1fu4sc5pgdrZnIq0mCBqSm5m2Lpds6PGTPIC1JV6psglyAfHUeGwIs+3FPX7
         +GrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbjJv2INCQZeh2j5lFbWdCW3sXNGtASt8mwBPu0ZnM8DXvtQIIyijgKrye2bANd/n594XTSe6g79rY79A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz490VGrN6OXMhKLj0Lx2WYte44upJztJUGsuBnucTgcJ+2xWeF
	o2mnUDtSVUrK0bj7P2IjnGh5UyLcHD1PAOemlFOC1hU4thtiSqvXKJ6X70GXpQE/8+B5KZx0X0d
	8aIgSHnU02XqFWCtAc2kpOU0gA8lwvZRYHcu9yg==
X-Google-Smtp-Source: AGHT+IGh+SAH0HiND+WOSGwD/VcAkilCZpxlY30ljLulS1hHuVO95SRQIQeLKJV15FnjaJtEFiG6shIsDh0YJ3psq+g=
X-Received: by 2002:a05:6512:39c7:b0:539:918c:512c with SMTP id
 2adb3069b0e04-539918c5352mr4435735e87.57.1727792658142; Tue, 01 Oct 2024
 07:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920154508.1618410-1-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20240920154508.1618410-1-ivo.ivanov.ivanov1@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 16:24:07 +0200
Message-ID: <CACRpkdYoVnG6dSpawFvkj-2KthNKWnfo8h_icx+-5_JLoHVDcw@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] Add minimal Exynos8895 SoC and SM-G950F support
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 5:45=E2=80=AFPM Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:

> This series adds initial SoC support for the Exynos 8895 SoC and also
> initial board support for Samsung Galaxy S8 phone (SM-G950F), codenamed
> dreamlte.

The pinctrl stuff looks OK to me but I expect Krzysztof to queue it up
and send me a pull request, he keeps the order around the Exynos
pin control code and bindings.

Yours,
Linus Walleij


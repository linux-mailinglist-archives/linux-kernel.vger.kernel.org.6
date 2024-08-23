Return-Path: <linux-kernel+bounces-299278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6E895D246
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64613282B65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419C18BB8E;
	Fri, 23 Aug 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iiwad0iV"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB318BBA0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428806; cv=none; b=SQIOS/WPgxJd7zU4sR/QATJeotjhjvYN6KsYRYp9s/yf1+il0Hm3lEja5Bi3xET4sISBjxbrDiG6MhZl5B6WW5IPXKB89e9nMaoKwXSJB3Vqt4/hnT1cOEbVmyrc14L4lbdyYYNrMus03IzPGmfyZd/O8OPXxdK4mO9YJrTpuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428806; c=relaxed/simple;
	bh=N9Q+HfstvZrc3Uyj8dpSq40+6yhOtXrkXeQ5BkBE9Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVwXpHShqYAMf9nnurg+MDQ+dTnb+Tyh+rGfJJGgPybI4sotZYlltHqq9vAmv/is7ZcupXIVOtbv4We+t5NJKNeLlYqsi+mmVi73fNWrdu/8HhTZDiDEkLZai0gLWy0qC+nLEZ5f9ZsTrTzjMTX5eSdRUi1Xz49rwSR5No/0dTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iiwad0iV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-534366c1aa2so1329927e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428803; x=1725033603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9Q+HfstvZrc3Uyj8dpSq40+6yhOtXrkXeQ5BkBE9Xc=;
        b=Iiwad0iVu258zc/Oqitvsvpcp77cYcfVRtrErPCrrzbY1n7eWb0M4IWsouWyn/FVMD
         QC0evnXVtfiTNNkndOJniMSABAjTrilzlrxkM2yF8w+/mlQDkmSJWvQZC6nW4UosyNpK
         y22ZhrScMOXJVw4rRjW3a5QFd7qcJtkfPXO1dx6ofEZl7FoQebvE6RTCNbRSz27IrtSx
         DSFsx2K/WWCfyYZ9pSPzNrbU7B2U8gXsUvhvNl8JqAyFT+kLqX/6cKjzf2xREr4w8/Um
         iQGSM/a1QFsJNIwkRD2DnJVMsXAgSCwMZcMP2Fu9jeT31owhD1hQExuSxljO42SJyKrj
         /jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428803; x=1725033603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9Q+HfstvZrc3Uyj8dpSq40+6yhOtXrkXeQ5BkBE9Xc=;
        b=buvBqKjTd6ZLpQqEWDeR5kCbFWuz/0YwqvMxpOg3zCf1czSRseLF1+ww0zLZT8noMI
         KnzZVRzZ0I0ivEeTE+VnRpebsTebv3oGMbScvbz7VWk91QJf8Dv5YlEyd84MWcNV7+5P
         hKr0+BeaWi79iLXvtJhCKjNFoYUgOG+1HHXHAFmSxz2CXHXdunqn5I7cG9lx/uRTFkXz
         Otm3wBdtoMJAl7tzlBYD7TjvJk366iDrFxUS9yPdznRJEStFot34hY91eWDHuZIynPFw
         EdQMAPCLAO2GdYZR1pLCpR7yTugbCohHOPRu9kDZj+6xpFYNOoUU7ZTomfS25r5cv1bG
         Cdvg==
X-Forwarded-Encrypted: i=1; AJvYcCXA6q7sa0Y8uJYpE35d/TYcFWwAkPUyZ+FjtXXt8GAnFTQMdNU8/ZpLF2PcSO6epcHMkDKzGH3+A2rt7+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDDBcvOQLognNtSYWqkH9c88CYUqDu7ntkPhzvcKf3Tozl2RAI
	ruwVd5+1x+YrnFEfCfZe/MGdPSeEORp1rhL175SD/XN4nKMeGp4JRbCBYgMvQPggsXC/0LjjgJF
	z5IpGuMXT7Jft8BjU2xizjjQdivtFfvtkjNKKrQ==
X-Google-Smtp-Source: AGHT+IH08LPEDFU5VHx7AqFMaGHbX23x27JBvOmuBNgaED1KnPIFyOCr2R1LWU/ISWTOYE+H7pGSrEdTHvtQQQj5kqg=
X-Received: by 2002:a05:6512:3088:b0:52c:9e82:a971 with SMTP id
 2adb3069b0e04-5343882d1ccmr1899018e87.7.1724428802573; Fri, 23 Aug 2024
 09:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807082843.352937-1-ivo.ivanov.ivanov1@gmail.com> <20240807082843.352937-7-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20240807082843.352937-7-ivo.ivanov.ivanov1@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 17:59:51 +0200
Message-ID: <CACRpkdYdJn3jSmur6q3+NrURFTQJO5tcxV=aTGXk7JfPyN1=ng@mail.gmail.com>
Subject: Re: [PATCH v1 06/10] dt-bindings: pinctrl: samsung: add
 exynos8895-wakeup-eint compatible
To: ivo.ivanov.ivanov1@gmail.com
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:28=E2=80=AFAM <ivo.ivanov.ivanov1@gmail.com> wrot=
e:

> From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
>
> Add a dedicated compatible for exynos8895.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I expect that Krzysztof pick these up unless he has already.

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-521024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF78A3B2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7FC7A4A46
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE511C461F;
	Wed, 19 Feb 2025 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="frd3p2yW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8841BD9C1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951606; cv=none; b=DUak2ZmvMNy9C1pHyvJdRPswi5l3O0a7FY9Q/QADmru+1ON0nrO0gYE/xmcqu6pxB/7p7edATFI0jR84thRblvaZja+6LsWqm7FwJPVufaGnxAZ+QmnZvo9NRf9vPCUpeXfWcNT07r7Tt79CASgU4EJQ9ojtF4wjxGgczn5JzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951606; c=relaxed/simple;
	bh=o0ZVQ1Yg5DGbJ5wB18BjpWZFp5JxkdPvBDEOYEmNAZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk5pD/nGsQrBbIvePfq3k07Mo3BUvw7NkqqhslZykthguKR23jsM7w3wExxXaib2voom6h86UPuEIPiKieXkrJZqXjJvaSda5gfkJB0oI1dKGV5zxmWraR+5mIMZTYYjbe0jsCEBuw9bC3wzfZNA8dilMK2bWTGL4tyNqxLo9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=frd3p2yW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-545316f80beso3471440e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739951602; x=1740556402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0ZVQ1Yg5DGbJ5wB18BjpWZFp5JxkdPvBDEOYEmNAZQ=;
        b=frd3p2yWth5IRMRSr1E+vnZgsYNrbpv4JzvJSSFK/Xl/hYGeR8bxJpuZAqRhaN9LMO
         DS6No6srf9/oJVtpA4S0lkDstijL+YjRDJPCjTpUxS9jaeHQp+45/TcMoBkgFLMafvhs
         MjRSvA8IiS48bH9DtWFAOl1VPNAwCfXbq2a/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739951602; x=1740556402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0ZVQ1Yg5DGbJ5wB18BjpWZFp5JxkdPvBDEOYEmNAZQ=;
        b=f2QP2/XSjOTnZuNlglN6NGTLbIiMYZ58sqbqIGvcNwOPpo2mIwoIVrq+hJ0vtKxi2L
         Ix3Ohfa6VA0pl6UmPZmi00NA1Kfwzr1UB8j87jgyS8ZAuwthOnOlpM927j3jb/DxcWoq
         3wjDujZ0od+6hIvmRfB+rUhcrg5IJNhZI4jAzs7sWRGCTcYZ4j2WpxVTLG1dxpzCSIJq
         d/OovekAdPg6jh9YFqPzkbKVSDzIOzOvv1GVSzNBm6lQsdFL6++/NJJTIf0YrLtChmBi
         +gZ4tbR/37lEmOcg0e7K6M89pJEXYO22/7nbcLJ+4uDkm3/rRPy7sjPDb8wvVrcaQcdj
         BYHw==
X-Forwarded-Encrypted: i=1; AJvYcCXBsGDJOI08XwIBwLfQt4t4Vm33LWrNbx8GxSX+mbdMI7ETXPLsprFF7iWhkVl+jf7xg16VfZLjvub59gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6WD8AAElxULwGOshbUfo9NpzROo5L+Q6f/FD+DMl1nqXI+OZO
	O1XIfYMXcmfXabKqusXOr9kic9FbryIYUmXOUHPLFC2DAdz6xHYL9UCsteC0fpx0+JsH21CsEkr
	whwyBbyWPqEDkJ23yV5Z+o7UUN3jgY/yXWUX+
X-Gm-Gg: ASbGncsrHcMG+h0EgPEO4kI2QDn0FJkxy/mZyQyTuPCU2z34bFtZ9N2n9+73QplvdTD
	+S1RUtP/XAt9BgLZz+fYXqwJbIFyyeN5oJaH0YpQWX86N9Z1GzgQhQzJ57+CY4zypCa1wfaMTlc
	9J9Q2rIx1SErlbglVz71cr8qLH
X-Google-Smtp-Source: AGHT+IGy4VRhutR0vRN13zFXFDojHsEJuy46LrrJBV/lkfpvoUaq2PR47QMvQ2pB0zIzS5cf5qZ8oAPqBxANqsj6Ktk=
X-Received: by 2002:a05:6512:ba6:b0:545:22fe:616f with SMTP id
 2adb3069b0e04-5452fe45d87mr6468841e87.24.1739951602616; Tue, 18 Feb 2025
 23:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125025145.14405-1-ot_chhao.chang@mediatek.com> <20250125025145.14405-3-ot_chhao.chang@mediatek.com>
In-Reply-To: <20250125025145.14405-3-ot_chhao.chang@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 19 Feb 2025 15:53:11 +0800
X-Gm-Features: AWEUYZlvGLuYzddD01vTxGm9KhUE8PoFe7dSks8I_T3Q6YOVZu9GJJUxvzhxQB4
Message-ID: <CAGXv+5HLmmNV9WZFjOoJdLQNvEW6-FVdgCDrgv2LCoYUrd2Bsw@mail.gmail.com>
Subject: Re: [RESEND v3 2/2] pinctrl: mediatek: adapt to multi-base design
To: Hao Chang <ot_chhao.chang@mediatek.com>
Cc: Sean Wang <seann.wang@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, Axe Yang <axe.yang@mediatek.com>, 
	Qingliang Li <qingliang.li@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>, 
	Chunhui Li <chunhui.li@mediatek.com>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 10:55=E2=80=AFAM Hao Chang <ot_chhao.chang@mediatek=
.com> wrote:
>
> The eint num will obtain the operation address through pins.
> Change the traversal method of irq handle from traversing a set of
> registers to traversing one by one.

The change only covers "eint", so please adjust the patch subject prefix
to "pinctrl: mediatek: eint: ...".

> Change-Id: I3962b78042d32501a73153201cddf52c6b62a695

Please remove the Change-Id when posting the patch.

ChenYu


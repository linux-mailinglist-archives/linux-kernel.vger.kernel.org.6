Return-Path: <linux-kernel+bounces-420916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0EF9D845A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B1316620B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742E1993B5;
	Mon, 25 Nov 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9JyVjr4"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A501990D3;
	Mon, 25 Nov 2024 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533870; cv=none; b=ZOire7f4i9JDAKjzTevwcckKxi6NT83SEBquN7v1MWHkGbW7AyAl+janQpNicoOIVxrwqXh92NyzaSALyOKSLX9X2LruyPsuDOsPvU1bzP/2X6oyPM38x0IZnRc7nJO60wjhwzgpxoYhJCwbX30Q1kbGg1M8xx1yneHwgRhPdRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533870; c=relaxed/simple;
	bh=atTGdQENg6nCHWrmtf7VN4oYXAt3UDEdIH0WpKqyH3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkbZEqamgTLnsB8C9FXO5TJmyz8OkaJqRK4qzdXORvFK1i738jllGjJkAV0GtByxklyjK1m7ejwMCiw1nj1IKS5+LfWxxiuPjUQQDp1ta28MfPt4uZGF46gF+wndX+WqIxoMXSaBKOwQV5MjJAPb8dLe7xoP6TKcaqgGZaMgvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9JyVjr4; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6eeca160f14so45680647b3.2;
        Mon, 25 Nov 2024 03:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732533867; x=1733138667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=atTGdQENg6nCHWrmtf7VN4oYXAt3UDEdIH0WpKqyH3M=;
        b=Q9JyVjr48EpCxtzv5z6lxtOFctS+fRcHcmoD2HdhLt3pwHLLz6ap6Ykndf9Vi7lBCh
         8bz1olrrKkGodYdD+m8nRyqPpgUfQjRy/4QSSioq7H4PrRP7ccesZPS8WriQKTXB9SZh
         QoNQnJqMlzfitt7Y9q6S+5mGlwSFfJTO1/aeUlQi1tGYuNCXI10UiM/zRHYbNUWewChs
         HI7IstsCGPMLDSlcSJJHfDj+JwHO3+gWdxJY/yNPnxXf/J8ygRZFxeAHK/MRr5pqyfsz
         Oakyqru4+R9nMyFz/SWOocJfkKBH51l6D82MrYE/5AaT2yKZZkZvoGeTEiQzyLB1Kj0x
         y9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533867; x=1733138667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atTGdQENg6nCHWrmtf7VN4oYXAt3UDEdIH0WpKqyH3M=;
        b=sgwKVpXSvaKKDxKSONvViuZvYEUDupdx9r3PuOo2envHCCiTuQamXjl8TcAgmfOVMQ
         /D185iYnVqemHxW1U5vEi9P/553Ka3QOOjDHloFzaA/ctsqmFnByYxuMvtd1R0R9wQVm
         DM6KW0l7vwKWxv0tUViL3mQJhYGNXTkjU22ELga+Vbi7q2DiZ5bgFKT/qm2H3nyyBtou
         z0pZ2nK7lXHXCgFY+b4iliKElz9Vm0gkCzWuAQ01yUe5/hvGvqi1XOs6jMa7ET7yhq6H
         eK76DW+EycmZwevEo2nXfLOpqpUf1rrhdqyzbbIic1pzKBXdhMcjoJkoAybqq/3qg1JC
         idIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV2Jwwi/ercA6rBCxVaPzMABXdtzhcMzavBCU2wACyTRx8dRMN4zN3gPmHsrlcjr+lTDp4ReW/i56tj8sV@vger.kernel.org, AJvYcCVdvBB6tIcmoQ4NzhrD0Th4FI8HizZwj1Ot6KbFcuE/uvUBnvWsRFr1/w88kb3kpigNseyriDxhZ2iV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/1dUKfeeBC3rnDUkn9ag7b+f2EinmaIaBvfgdURp+t+WrdUQ+
	xnJI8xYrCjySi+2/uZrXMsBwQbRGJP1U2Gi8MJ+kZcM333PqQJXcJ5sHQPxWS7PiCTruWtmC20F
	2Za5j+IS+qa7gWUbFAio6Yvi7B1I=
X-Gm-Gg: ASbGncvTodVzNrf2zr5SoWECgEKCGh1asSW1kUX6yYAvDN6/C06LzXV20fxLHSjGe+D
	FN/rzSRXhWgMNneR8XXlsNC174G9sKC7r
X-Google-Smtp-Source: AGHT+IHoeHq1SaOkzoegc7LOfrsp5NCsRkFD5zT231LvZh60oKXqnaI9hhCjtdWG9vlb54GAx+il0BMwPnlOQyc601A=
X-Received: by 2002:a05:6902:2684:b0:e38:b2f3:b7ab with SMTP id
 3f1490d57ef6-e38f8b346femr11037579276.24.1732533866931; Mon, 25 Nov 2024
 03:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com> <20241124-adpdrm-v1-2-3191d8e6e49a@gmail.com>
 <10d0aa88-de2e-4856-a137-301519e58b2d@linaro.org>
In-Reply-To: <10d0aa88-de2e-4856-a137-301519e58b2d@linaro.org>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Mon, 25 Nov 2024 12:24:15 +0100
Message-ID: <CAMT+MTRWZWj=3AP7wyooXr49-W4vcm0ZbAoqPyEuNkQBMOaJfw@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpu: drm: adp: Add Apple Display Pipe driver
To: neil.armstrong@linaro.org
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 09:50, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> So this controller only supports a single mode ???????
>
Most likely. On all devices it is connected to a single built-in display.

Ack on all other changes, will be fixed for v2.


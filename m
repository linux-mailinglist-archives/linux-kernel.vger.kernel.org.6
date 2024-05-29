Return-Path: <linux-kernel+bounces-193789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE48D3235
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97ED1F24798
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770EF16D9AD;
	Wed, 29 May 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="saQFZyJw"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DC16A369
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972311; cv=none; b=L6c8IM/f7iCtlZpWkGW8hZzyrvrj+Glr8ekaiJiGaqcPJZ1/VjctgJyM7K39YaMf/ZjGlfI7nHIFTqGIxAbMYQjYwlAHV1ctU6J960htPlTe2tlJEnN7IQPmtZXJsFsTmiwRExr8m3j1z0vyi4fsmEngwOPHKR2UUMOo5pPjqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972311; c=relaxed/simple;
	bh=cEQZgv7lA65Mqddsp2++Rozt4mjzOKyK0xJtWUBpnoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPRhq6TtjcEYzyU/IPg85BUi1D6xC12lfDzlBbX9yxHE/BIHqxXwzz1orxHNNAdRII+ebn/q7gubKOw5Nzpx0/9AnGlq8aEVeFA59+1yUsib3UDZt1qG9Ly6wLOReuihUjNeRtMojbdcEDO8Ku4iAdWgw4xU/T6xP5mePowxxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=saQFZyJw; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df4dda88ce9so1532921276.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716972308; x=1717577108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEQZgv7lA65Mqddsp2++Rozt4mjzOKyK0xJtWUBpnoE=;
        b=saQFZyJw6Z0aBDilz+Rqg+rlTUm8Uc+eEZo5bPFXI6grbjxNdTaCQI+Zh/2hZ/U/b6
         taYs8d9H+9QLieLnosucA4wggU3+bRlYRaWW/t1Wg2GNo8vln3ujJRzKLxDcWANj3dQd
         e6gyuPR5/Ht6Y18uUTuUC4zFn3QukRE9QFLlFdz7MmYOLoGAjU+YQByTQanpG3Naoxii
         aRue3zC/CCx7SOiCBk4onLxsie2dgXjRrL4v1AG+7lCAgWgJuF9HDPLVtaZqIbL/v3Sg
         tbfvn/+XXTG117zdzLNxniDsiXRD206pl2CO8AZ3LKYhHOQAti+IJTqF69wurw8rfpj5
         iBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972308; x=1717577108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEQZgv7lA65Mqddsp2++Rozt4mjzOKyK0xJtWUBpnoE=;
        b=xGrxcbMAdOd5z5Wpc5mr5gu79XNAFKaaWWOeNY0AJgJMli8MiUduPMy5AfCWN2oONJ
         cqKuZuLTtA7y0Z07SjTvs4NDgThFnHLWuFCYmZ/3beQkxlh7ajdkm3AZoPFBbHwrmiwx
         U0BUIyFn7PAchJOrUePbB45kX7+hZLI5o8tMUQnDiqhobbDOdMMCdLS73pXsY1zMCQJw
         FK34BIxbZGNkyng5T9n+jfMNJJnuwWzrFAc3iDM3SsahgJboxSKa6Obwq+JHc0f+iifz
         M9cCXSbA6CuAmcYnFiZE8qy4N4ROzwv545KsYtCX7/CQkkCh31Zw3/s13hWxYaJlL8O3
         2gcw==
X-Forwarded-Encrypted: i=1; AJvYcCW9PpqhYfMldSSY1D3lXBWCfxuwkQaMS8s2H2yIXkq86ItT79jtR/jVk52j92Am4Q2oWjzgLQWuAz8GqPtW4UxQudjyuXHBhKUWpbQe
X-Gm-Message-State: AOJu0YzSanmx1PUMvgHe4R5PbEjnRwPW0Jb6HgBhIA4RsNNXisi5+89i
	zW4Nfq29hoHrecfJJPIifoKIK5mckoOjKdQ7/bLM013XFLjzwF2n1cjoe+IWIfS+HFUYYMh1ifB
	NV8uHodc+Lol01AJbFyWjdOb7e3n5MT8bHte1ZLlmF5XxeA0r6uHyqA==
X-Google-Smtp-Source: AGHT+IHG3pzJxRaWvOHhrglnhPYr6/z3Ebb+ReDnEzXNEKzJNc+W87h4giJSH+3km64fkbhWxZHVbzSqpA9BcH4//5Q=
X-Received: by 2002:a25:8183:0:b0:df7:9762:ba42 with SMTP id
 3f1490d57ef6-df79762bf78mr9594641276.31.1716972307863; Wed, 29 May 2024
 01:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528191510.1444068-1-robh@kernel.org>
In-Reply-To: <20240528191510.1444068-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 10:44:57 +0200
Message-ID: <CACRpkdZpdjYNci0uN4yxZhYforA-0FV=YBXhmcKCw8L1NYMUhQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: realview: Add/drop missing/spurious unit-addreses
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 9:15=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Various nodes on the Arm Realview boards have missing or spurious
> unit-addresses.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I send pull requests for these files very seldom and the risk of
collision is practically zero, could you take the patch through your
DT tree?

Yours,
Linus Walleij


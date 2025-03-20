Return-Path: <linux-kernel+bounces-569286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7655A6A0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59197178758
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9F20ADF9;
	Thu, 20 Mar 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWhxWzso"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE21CC8B0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458418; cv=none; b=oh8hAdSkwDEvBvcDkREPU04i1hmtO5CITKofDQ7YyVVVNFsWN+4uTRoebahv5RGs0N1jWFDcxcLUDzTLFbweJOC9uLlLX57fAnH3ns5X2wblc3/I70hYSkSPZ7oCNIgCQwTeqPXfqC0edk6GULhSEuwNpfTlOkTlWuOwjxX2a7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458418; c=relaxed/simple;
	bh=6Ji1RBIOpRF3KKxjONADrWSLZ8hGYxB9lOHKQd1SPN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIeSRZbZIRjhITiz6oUaX58cSDR1woxUKNODRurBcT1k3OpOg+O+jOIeudfu7J/ej/JZegyTgmqjNl4b4Gj64Hi8nQkF93dUlzWYSQnfoFDRhLsqLpgDGlkFMJQWzcCOih9AtMTU0mjo4Y8U3vkSyHLWduSLVkje+RcjgArinQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nWhxWzso; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54ac9b3ddf6so565672e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742458413; x=1743063213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH/3f5Dac1JZ7PB6fCTYluQ28FDUu14YKXsBxY9FGQg=;
        b=nWhxWzsobggiluwJCxbDVfDnPmsDCfvAABhSrHVU5Iw1vBbjUXA1W/RkeIUwka7q0N
         i37OH3tnLf1Na42ip7whz+23z+xpuTwg0QViQMQwueWsGXdEWqesVJxYMqg+TJdEVK2I
         5G0wFEosfn1XtAEaq7eRrnQPdXuUE00Uhqhr3tGOZgfcTOKv2Ew2yHN5BudbFdfaAwaa
         NdTs6KcEJNc9SB6rTscuRJwz4pfJ8tHKnYRvx1+n98L8LOa35gjHvGaFZOMYrA2xQpbJ
         n/RbxVB+RmoqP9WaTzEpBCtVho8h9QnZmSRDU8/VtvbnKWUWA1ynSRyBGrAvJ1QkgRaB
         AcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458413; x=1743063213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH/3f5Dac1JZ7PB6fCTYluQ28FDUu14YKXsBxY9FGQg=;
        b=nfLa//5a+8MqpiAbvqE0FGgYmdNAr6r7tvKdzLU8or2458fClpucSHCJFzUGGJRuFT
         C0F1cnoTFqFFliXFyP9ma+wTfWwqclWQST3v6uWVWkCK0R8sZ92xKbuqUPnB15V3HwkR
         emrdEUWIpc8y2l9WaQ+RURSrWz7X3rOrifiR2ERtlXZ08dXF8gCgk/qQaBJ1bIGQ0m3R
         vh307VM7cE1mfp4saWIB7MBce6xJyfNOsAwZ3Fk0NXKRkX05DeQOr0e7gQ2DjAgBG/XO
         cG0dcq4WbH1MsDMxk853xs3sqNm51j9lvm8xeVpl9t55MymdgpOIDu5zvy2e64PlkuKb
         FbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD6MK64QI+47OQG9RJTDjJzcYyWKqlkonZ6MtYt3vLp7dYc4gWuLxpmeZOEkMzLf+DRe6FOFoB5gVSEmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4MwujP0g0GLg2WPknkbPQ9ocWi5ASSJNDi0gMz5+qQjYtVzj
	YFIJYA5L01HfbcwT9xdvZ5yjdFC/ZqaTpAPO7RF2nsyBTJkI7fiULlbHqQx81cAOgoSTlPLisgb
	hQ12a+4kY13IhKazPmxVLyYoZKTgN+OBaie4KPw==
X-Gm-Gg: ASbGncterdX1TvKGLcEb0FjUJqTlyOiMdojGM4F4Pbkz3nF0l084B9d8rorclxpFIKV
	w16g2mtMzBkNO3tGbaWe5n1nS3ljDKIATLoy1ePAOyI+tWFIWiCqGSF0MVE23ZayqaFJ2CHF6Gv
	Ow9JiV49JEz2AqZOinwpaDOWA=
X-Google-Smtp-Source: AGHT+IHlRAMm6DHFmGnX4O6qtM7WU7UfemcO1DW0vJWDefpFUiW/wKer02pkqfNiLKCodEdnMprWlIdw9ApK2Vl4254=
X-Received: by 2002:a05:6512:3d27:b0:549:b0fa:6733 with SMTP id
 2adb3069b0e04-54acb1fc7f6mr2205401e87.37.1742458412840; Thu, 20 Mar 2025
 01:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82b40d9d-b437-42a9-9eb3-2328aa6877ac@stanley.mountain>
In-Reply-To: <82b40d9d-b437-42a9-9eb3-2328aa6877ac@stanley.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Mar 2025 09:13:42 +0100
X-Gm-Features: AQ5f1JrO8Xfjg5ntIWbaCB7qZbTiTVkH-WMLNIyd4WNCkBTjqRZTBB1zv4h7_O8
Message-ID: <CACRpkdY1NhHQ43L+pAoC6EC_ydJKY2u+P=nhNAgo_Gw9McNngw@mail.gmail.com>
Subject: Re: [PATCH next] pinctrl: tegra: Fix off by one in tegra_pinctrl_get_group()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Prathamesh Shete <pshete@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Peng Fan <peng.fan@nxp.com>, linux-gpio@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:05=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> This should be >=3D pmx->soc->ngroups instead of > to avoid an out of
> bounds access.  The pmx->soc->groups[] array is allocated in
> tegra_pinctrl_probe().
>
> Fixes: c12bfa0fee65 ("pinctrl-tegra: Restore SFSEL bit when freeing pins"=
)
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks Dan, excellent find.

Patch applied!

Yours,
Linus Walleij


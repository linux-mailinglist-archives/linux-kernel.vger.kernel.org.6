Return-Path: <linux-kernel+bounces-239363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30622925EEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F51B2A3D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CCE17B425;
	Wed,  3 Jul 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqSgrbUG"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567317279B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005330; cv=none; b=gkoahEjYS5YTIKVnPoin5KDdtyNo+TpDn1BcDI+Rzjv7xxTsLYCghw2PuhP576t1GdpxiV57LUrWL8ToU7QYnMLF26/WbVETq8tepddMYNAHE2bxj4uLDhe/4zMCqDcpLFGRnAiqPR5nsdOF7dXlDHuRZxf/+HQYy6MuNQsATdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005330; c=relaxed/simple;
	bh=i4GqndXFZM81jlZR8iscmB7axnoq9nzeXi/e1qzd7d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtYmZbFbj3x/V7zp7LzBKrNEvZSHRaS00w6BvqoWxOcxQVY5YyrmhAED9aTuc1aR6bFygtMrgmRfNzwb7jBBx521THAnE8Hzr+eCxh/VauB1IgmyRhVyP6sin6yH0ZX2tFQTHOsiIEfBrb4hezrcoYyUA6r76oMgtQtBBGlm3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pqSgrbUG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee794ebffbso22865421fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720005327; x=1720610127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4GqndXFZM81jlZR8iscmB7axnoq9nzeXi/e1qzd7d4=;
        b=pqSgrbUGfYJuHRyj68GyK0IwZxnSspaJeXa6zvP9PGSrs9t3WFDLWvyXNfDc6oAVsv
         ZH9TX0eJeEJJ3QspTd84wHATGh73A3ZCR6hj0xlGBWZtBPrcEvzYXdnM0fSPu5j2lK11
         zqHkYgXUJ8PY3Hn616/Vbz+dRZ/e4FuHMhxm6THp82cemd/zP+v2B/XPUyT42EqTNDN8
         BkOwzOSuevn5Bg8r8eh+uR5E2Q+IizIA5z262bZVfrtaGCZt4O/N9x4cwjqvI5sBsCJ/
         TZSh05FDLYmvjFoelCYyevaOC5kjfjbgGz5osF5P9Lgbaw9oaJLjcfNyBf6eC7vgDh5d
         y+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720005327; x=1720610127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4GqndXFZM81jlZR8iscmB7axnoq9nzeXi/e1qzd7d4=;
        b=TIdhqxJaGzFEtwNwVMFn7nlzg5rf/25emVZWqoEez3bUFRn03t/YOb5ieCsMqaQgoT
         0MdStQbebvD9U0PLCjTuuHiYUKvWSy4uOm3+0SJXDbrhsgBjTmh1kQxbP/5zz0fgu6x8
         rIm4+774whZ0CHxdDJli5w3l/P6GTiEqQSK5p8fPEamRRlfHRIqLmRaKjS09Blb7gpT8
         EsyXCAojr6S7n8PgqXIVMI0XDwXLFJ76lzW5AqWR7EaBYP2gw78pCBxv7R6T4Xq21Rem
         pQBxXqOwTFnQ6CFPrM3OG04r01mWa2rYTsZn5HkXBQW37aSBVxu8v0o0QcmAU21GS8en
         fp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKXdNZO8127dJnYTyfHV69XvI3Dahh726xB5aQs7fnfR5QGb31AsU4i5T0q1pVKwL1ndJ7DXLF0wiedG0reqqPGU2Rs9E946Aa4LgQ
X-Gm-Message-State: AOJu0Yw/lndPLqxrQHiBPwUbasaHdxby8XN1b0mRM5xqCLTk62uaKOVl
	69bHweKk/8cUEOn/dDfak1oA7E8hOLKPcdIJPzoiVRuIgKXRbCbn6RMCPfzk38ZgLIVJgmFcSj8
	/n+UDKP4DQWzFfz+Nr2ScZ6jGGOzr4zQy0og/xg==
X-Google-Smtp-Source: AGHT+IEmAeBABD5FWougATTrgMC1g4+yTZr5u0+Oz4+OF5M2a3tUCptIbjatJpqzRJBEFZ1XyR3LRao330sV0pe450s=
X-Received: by 2002:a05:651c:b14:b0:2ec:5488:cc9e with SMTP id
 38308e7fff4ca-2ee5e3bbd14mr89990521fa.26.1720005327519; Wed, 03 Jul 2024
 04:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626084525.787298-1-patrick.rudolph@9elements.com> <20240626084525.787298-2-patrick.rudolph@9elements.com>
In-Reply-To: <20240626084525.787298-2-patrick.rudolph@9elements.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 13:15:16 +0200
Message-ID: <CACRpkdaKSkZvTvxcQk5TTWLb_MeSMODVcstWpD9ek1y5--o=-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: cy8c95x0: Update cache modification
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: naresh.solanki@9elements.com, andy.shevchenko@gmail.com, 
	broonie@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 10:45=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:

> In the previous review cycle the regmap cache update code was
> questioned since it seems and odd way of using regmap_update_bits().
> Thus update the regmap cache modification code to better explain
> what it does and why it's done. This is no functional change, but
> it's improving code maintainability.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Patch applied.

Yours,
Linus Walleij


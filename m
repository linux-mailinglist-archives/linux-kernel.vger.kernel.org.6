Return-Path: <linux-kernel+bounces-192164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8378D1958
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77C31C2204C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08E16C69B;
	Tue, 28 May 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9RU9NBe"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7816133E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895406; cv=none; b=ssm2st7LItoUhVQfrW6ObPVQK0a3Z8yajGRjcD20yRcyTfnKjWVrMrBLxsypB8Fqn6d8uB1No03lYCllfULF/5dat9tZpDS86SvthvCqM1BIXXbwq7iEyKnQ/Xq/pNdotTOzCJRvtngE/mtzTBkBZrNQAp70/7Ks8eyYilRnjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895406; c=relaxed/simple;
	bh=o0jVo10rUkf0hnMGC1osUVoTzkkTpvLNKjNHzwYPz2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLw5/qw/OjgxK41UAUM6UsUPzLyWL6pPMIHNX7Usw6l02PU9opDkpbK/pyEzZLion1U/YVC+hnHE3Mq182nYD8yxLqcKN2y4GbFUrEajW9gaiVnE46VxHz/hEl0cKX4a4CjjCpF/66miauEqKqqb5n+kc7Itja4iiCdY2hVS/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o9RU9NBe; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df7713445d3so742278276.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716895403; x=1717500203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0jVo10rUkf0hnMGC1osUVoTzkkTpvLNKjNHzwYPz2o=;
        b=o9RU9NBecXj4luhS+tWREpwQDvx4K778DXDAol/amldfzwtZJszZwl2BNh7WWbmdgC
         R8HeWW7KmX7s5cvOTI36i/WXEQ2bfEMYip1DVtttSX4eE5k0pZJ7iVd3FWq0sOOGu+ZO
         gBdK6XbVHEhov3hkNVPhu8wTpPbg5er0y983G+NLOUBDiU8duGUGDy5SEzR8mCzc+qGm
         seTWxe+ump38dLBt3xj9tiCRYPKsEt94qKqif/7ntcqJNtLe/H79Rei6sTYT5iF+GWY6
         yedvoXEJa1R2gV0NcV7aUQd7QXlf4Au0Cbwxy/NBzxvddyh43KnfzpR9PeCKnHjxVRz8
         nLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716895403; x=1717500203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0jVo10rUkf0hnMGC1osUVoTzkkTpvLNKjNHzwYPz2o=;
        b=Efw2cexdlVzAmnVgxPsIGSZ0yqTmqDc7CnCUX27K/viaCXqaI1FRk3tmj3R02iCPNT
         mPi8Esvi0zlwcYj+XwiBi7M1M3itGl8oadtaxAKUuR4sY0daKbgxWjGxqGhfx5qEHZHA
         KwvUrLn4+OnGrpm4IgaDqM0cK/s9kNP6VPpAASMh+nqQ1JK23QepmVGyh2b1HjOwIzxD
         heKPQFiRZEtxIbOAO/rLM7R7PQCh7Wh9fS3rLVqh+GOjy3pkZsUSGz7msYMDpyGlzWa1
         H5qghX7e9uu2qgHjaX84m43b/VNLx3uLjsp7UY8dsuf+bHY/d0uzc+LFFedRDJEg27Yt
         jarw==
X-Forwarded-Encrypted: i=1; AJvYcCVFgmiz/CdKHw6JW9Bl/e+ArQaoyPYepLGVWS05MViIG88t1leDi92UIeCn0iYwlMURJjfI/0S60+VucvESzRtMZeKz6hSUJvOS8xkj
X-Gm-Message-State: AOJu0YyT8fIp+UZFxdJ+mUFNgLJCHXatig/OnZOV73bXCoPgollHr1nq
	bWQLjpOchMP+Q/tF5woF+PB25aiAacEUcEyACqhTdzhIPMV4AGOir59VXVKSWMYykwlXg+3wqzO
	IsHZJuflXv/CqrDGa+y/xpWlNdFiEbw/xDJPoLg==
X-Google-Smtp-Source: AGHT+IFM89jAkbAeUASNdtBBxhAcMHFPFYE/DuNZA8xET9DT6Q3ZDVSx4aTUQ9VgOHYs59aDbb7k8SWmtYtPVwlakAo=
X-Received: by 2002:a05:6902:1342:b0:de8:9a4b:47e4 with SMTP id
 3f1490d57ef6-df7721c75famr10787522276.35.1716895403027; Tue, 28 May 2024
 04:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
 <20240515014643.2715010-5-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240515014643.2715010-5-yangcong5@huaqin.corp-partner.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 13:23:12 +0200
Message-ID: <CACRpkdZEXB4t6V67FwexOPYtpovXkJ+WsG57VG_p04Kv1LSatw@mail.gmail.com>
Subject: Re: [v7 4/7] dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	dianders@chromium.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
	conor+dt@kernel.org, airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 3:47=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:

> The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
> controller. Hence, we add a new compatible with panel specific config.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


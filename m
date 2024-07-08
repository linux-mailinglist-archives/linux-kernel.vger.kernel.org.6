Return-Path: <linux-kernel+bounces-244927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E092ABAC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C10280E89
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A77E14EC61;
	Mon,  8 Jul 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IYv6ei4P"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4AA29
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476153; cv=none; b=SUlm9dWjL3iPvqp2ZmFiD2+3eUCGHNP0rDhfHQWKNZazNqkuC7do4PLwGGQnQLD4hAlfiCCNNKJLRWy8PkqKNdDXH++B2TTALidPi/IeFYCyLfz9xImBX3mzGDEqj4Smby8M7i+nGYtp0AvUIDxxA+H2S2DiQbCJOVklIjs10W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476153; c=relaxed/simple;
	bh=8OVXbp42/iCfjHuXvJmECuOHqicvfCZWVVW3q5Irl3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7M6vyRKerzW1/oymAp8OI6JX4L7mYEI7MvOXeT6hLHxRC099KRbR69d0AThq6Gi2zihKgr4Qc4OHfjPbZVadTizpAdhiy9MQM/97rXtVOpeahdfhZKe/w6dLfnfnzHBVV+mvHXF9/AxrYtuqTcFII+BVkKoAe/LuJisK8cY/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IYv6ei4P; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee7a1ad286so46441381fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720476147; x=1721080947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OVXbp42/iCfjHuXvJmECuOHqicvfCZWVVW3q5Irl3s=;
        b=IYv6ei4P1NMXTSWQ5yNgZLXpjxMT6QCC1ulIFEuWsNthODd9hiTaWjfOdZs9PyiQ02
         zAeBPIVS5OwjXcItPynsb/DuaZ5bcaHHP5Hpo28hL9uowVX1tMBDAPdEPO7PO3/4Oe87
         ctw8RCutBGi6HeFVt07sBltJBHso5W0jcFDj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476147; x=1721080947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OVXbp42/iCfjHuXvJmECuOHqicvfCZWVVW3q5Irl3s=;
        b=XLmnNiElYPeL+KM/opy6osOqnlFxMkXvQ3JflMcW3JR8X3EAdJfaosHr87NIqG/0jn
         uOi2BLklM1F1WPKsY2ZyIfRaA/QahT/R3SpWru2m6/Qyq/5zfxd6fHkWtP7KglgprB0Y
         IbPDQNEasaMWSCt8xFs5l7i61BfG001h7Ue8t1omesQdaF4fGyiewbqjDD7w9UxjVNOY
         bUfeVbfT2+wVYdc0I707+zMYqrcYe9QB3MAQ19WQJlqsVoB+z09FIAeVv9M/0KWcNkCY
         zaIcB3KLrsqysLciSXwTywbX2q0oAk0d0SGFKokTLpIQpeN1fywDNUkWQAPe3BW0i4v3
         SS0A==
X-Forwarded-Encrypted: i=1; AJvYcCV8QAj6yz/ymxm8tqcPfNQtZq2+Wfs67Mi48bUYBQ/ft4j7gh7TEWjSiHEAFXa5mEsvQHBDSqMk4y8Nn6vVTWyVLeysskb/EbxmsC7P
X-Gm-Message-State: AOJu0YzzbPtfNXSpvEj2pLgyMZS85ufLhfdit5X5sE0qaJcQ7KyuMW+e
	XCbRFCodozSzzDEktykzF9+gxjh/d8dlQWD4PFo25vjGkBgxBnmJ9moTzYRSnu0j1IXnbCyqGQZ
	sLA==
X-Google-Smtp-Source: AGHT+IGpv5rH4S1++tPbjka4aS/AfAnn4ijYzLItlB5ZbCEMvs1kXmYYjTMJ+OKXtixDFqEy3t0+sw==
X-Received: by 2002:a2e:b0e4:0:b0:2ee:87ce:c863 with SMTP id 38308e7fff4ca-2eeb3182243mr5450471fa.32.1720476146818;
        Mon, 08 Jul 2024 15:02:26 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc4e81e9sm288047a12.52.2024.07.08.15.02.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 15:02:26 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42666b89057so32505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 15:02:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbjgfhAH6SRT2rBJ2ggMBnE9D4umgrr+YnaK5F58Cc3D0TaDBfPXmy4fPNxlZPgdvGPP1nQgLh6jFvUAfd15DvfOXcA2ammnKer54E
X-Received: by 2002:a1c:771a:0:b0:426:6837:4cf8 with SMTP id
 5b1f17b1804b1-42671c0a512mr657505e9.6.1720476145006; Mon, 08 Jul 2024
 15:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
 <20240704045017.2781991-4-yangcong5@huaqin.corp-partner.google.com> <CACRpkdaj2quvNdD_UDzyYPK9LyBndDHr0GNb_y8CBFAWakSU+A@mail.gmail.com>
In-Reply-To: <CACRpkdaj2quvNdD_UDzyYPK9LyBndDHr0GNb_y8CBFAWakSU+A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jul 2024 15:02:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VssfZBxwh6i4e_mHhT8vZ_CnXCrUhoeTUeo5xN-FmASg@mail.gmail.com>
Message-ID: <CAD=FV=VssfZBxwh6i4e_mHhT8vZ_CnXCrUhoeTUeo5xN-FmASg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: jd9365da: Break some CMDS into helper functions
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, sam@ravnborg.org, 
	neil.armstrong@linaro.org, daniel@ffwll.ch, swboyd@chromium.org, 
	airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 4, 2024 at 1:03=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Thu, Jul 4, 2024 at 6:50=E2=80=AFAM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
>
> > These panels have some common cmds (e0h~e3h,80h), let's break
> > them into helper functions.
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
>
> This is a good start! :)
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> If you get time one of these days, see if you can add some defines for
> the other vendor DCS commands as well, but no hurry with that,
> let's merge this series first.

I agree with Linus. It would be great to take this further, but this
is a good start and I'm OK with it merging.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'd tend to assume that Neil will merge this series with the various
Acks/Reviews. If I see it hasn't been merged after a while or Neil
says he's busy then I'm happy to land it.

-Doug


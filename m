Return-Path: <linux-kernel+bounces-178049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5D8C47DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF11C286000
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504AC7B3E5;
	Mon, 13 May 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xis7omeq"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B797711C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629829; cv=none; b=WBqaGey/ZyWU7cVOiQha7uY3Kt4RUe8k66ij40CM4Ws+Yl6cAybVTbQuPOEUzpam/Yc4t0rHWoWBfnalZ8fQ485bxbl9GcR3XeuETs6fxEX/Rp412SvDWucuevbA38kcfXcgftqYn/HxHE3RmeDmBnJ7T/mKQjO+WHtpPRp/Idg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629829; c=relaxed/simple;
	bh=kJ+U9abf2mW0eeEE14BP2LpooQOPOgLcaQz67J4MGiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUvB0veDC2wW690Ql7jW8tDP9gtIYiN2SAvcrYLXjfkR85c6SVptvQHNFLAsqst7M4JVJphOzG0xu0CF9aTJGvNuuNaBwErGMUnUAo9rlps2laUMVkpXsupetOCqg50uE6JZH0YXbKpDjjS0Rcq7wccIbveIN59uNGDvYEHVxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xis7omeq; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc71031680so5036983276.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715629827; x=1716234627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/qKZTzYNiFMXq0/lcLabXSWeWsLTd94wbNDqyfK3Dc=;
        b=xis7omeqigxkGRwmMY6HO7wSyn/fE87MkTHN8Zu7c4eE+DkeYiOfpwvinrBUCa5Qpp
         5w5lTaZNIxGyY64SayvFTeykqmgKDmhh2vyCUw4zji75pFbbCh5ScdkW9Xkzj45XId0c
         q7qbmWo879L96jakhHmARIRrq6h/DiaoNeukitUG00cuxibwzehuS35uV0qfcgTUyl82
         sV3Mfu04XUbMljz7BaNtyXWEQmD8na0SkUhqlemzE7hP54u/PtAjibdLCFtus4ul2fE5
         Ccd9UPK6wopZeD+PuDSqqIH7YJPxlgFEv53DUdCBjpdbRPfCc02/fCHo1XYIedMejfeN
         kT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629827; x=1716234627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/qKZTzYNiFMXq0/lcLabXSWeWsLTd94wbNDqyfK3Dc=;
        b=e8zSfil70gW2fDIrb4z6HAfRByYQJtpnCZ/EIh00NF3jDdOgKjJAz4Ii8vykeX2cHk
         saydleDFAizY//fMzSC0boLYq0kPO/5neE2BRqkT665BNxA/+xYod9RmqeLvTzyHL28z
         vtWYn9eR7zKqe3CizQ0GcCxtFrJKifUAl16aW6diXwdvpZ8rST5Wf7VlMgvh3ExkcttD
         RCiSxyCxT8pyUMkGkYaklyVnK5QvqKMvL6NFBhXYhjLei9BdMNfofzy8MyBoAaZNo5Dx
         wyt+raw80ge98XOqYlHc7dO3H2IMLVuNmtR84pO48VkrP0YUeWLnVu+CGPoitCWGw+k2
         RaLw==
X-Forwarded-Encrypted: i=1; AJvYcCUG4KyOFtS/6xXg4nl1KrHD5cy5O3nZ0ESFOohDvQ7ZNcYGA4SDcaRSludOdpwsrlK9wa59Gx48lDBVOyrXHFWdhomiGyjCR2+2NLcx
X-Gm-Message-State: AOJu0YwCOphZayzTIKJZKDgCHkkVW6PrESXp9Qxmz7AlWifoPpFs+qwL
	3lCKr83an0F5S9/iWxebx6FXEPSnYOpVxfm24RDBJyIP7OiISodU+J+6b7npU4f7xykzm1Rz2u/
	LhUALu6zctF6MEjk8hhz/gORaaIqI2sulo6Z8qlnHYrpMJfpQ6fOgjg==
X-Google-Smtp-Source: AGHT+IFnaKh2w4CELPExkFDCenu+egk7lmFps6WDdYu5ZgbYKuFj29ldNzVqJvgWYvBt/PEDOb2Sf4f/bh6t4gh8doM=
X-Received: by 2002:a25:870e:0:b0:de6:1056:c9e7 with SMTP id
 3f1490d57ef6-dee4f2f6b6amr9939798276.8.1715629827278; Mon, 13 May 2024
 12:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com> <20240511021326.288728-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240511021326.288728-3-yangcong5@huaqin.corp-partner.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 21:50:15 +0200
Message-ID: <CACRpkdaAUU0NM63ZYRNVy0gBEKG_5Ey1NVJuNOsohdEOuE0i7g@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	dianders@chromium.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
	conor+dt@kernel.org, airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 4:13=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:

> The Starry HX83102 based mipi panel should never have been part of the bo=
e
> tv101wum-n16 driver. Discussion with Doug and Linus in V1 [1], we need a
> separate driver to enable the hx83102 controller.
>
> In hx83102 driver, add DSI commands as macros. So it can add some panels
> with same control model in the future.
>
> In the old boe-tv101wum-nl6 driver inital cmds was invoked at the end of
> prepare() function , and call 0x11 and 0x29 at end of inital. For
> himax-hx83102 driver, we move 0x11 and 0x29 cmds invoked at prepare()
> function.
>
> Note:0x11 is mipi_dsi_dcs_exit_sleep_mode
>      0x29 is mipi_dsi_dcs_set_display_on
>
> [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=3DzBQJUC4CB2wj4s1h6n6aSAZ=
QvdMV95r3zRUw@mail.gmail.com
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

With Doug's comments addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


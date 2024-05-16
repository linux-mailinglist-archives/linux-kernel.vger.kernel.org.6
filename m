Return-Path: <linux-kernel+bounces-181123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB188C77B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72971F24099
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0B147C67;
	Thu, 16 May 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="feh08rjo"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE221474B4
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866334; cv=none; b=KpOD4v6SFJtff6pd9fROxP3fsZqnQP5CoYmqUdwz4dFXGxc9BgXY6H8eHmnIaUaaOiSaFByV4EaD8olAv4asAjcHO/2AMwz87rbt4KRqlc1HxGabD/cXtG59MgLJ7CJf71H+mLEcAkczCgxRCWigxJbs29Is25DxArbv1YjukHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866334; c=relaxed/simple;
	bh=Mq2Sul2x7kmO3kQH+vqqcNhY8EMA9s5vcYxIfsi3Cqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxC51PSy8rX4Wur/NmtdjJGKrPj9zTPA068FhEZ9JeSHVI4/R5njj9MLdLeHNqssTrrP0vG30XrVfMwAQadXmI20q5dxoku1dJpWArnEHcpglQHBt+wabaCT7Sg9AdvixMKsNsJHVP77v4Qp8uM+L75nGVjYaQb9ljwNNN/SVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=feh08rjo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792b8efed93so709360285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715866331; x=1716471131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq2Sul2x7kmO3kQH+vqqcNhY8EMA9s5vcYxIfsi3Cqg=;
        b=feh08rjozYVOeFQppa3PVIjDr6fmcDtRDm1+Fu30+pzas/TH/9Vzk6LhDHJf5BlThB
         O8gSnLTYOb34Wlj/LQweYKddo2UFXie2uY+yfU8gDRz3wefBEDSzt3yzD8+8/0F/3Ckr
         8DvgX8tHlMqZ54TZshfHoHNW+YqKULXNtopN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715866331; x=1716471131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mq2Sul2x7kmO3kQH+vqqcNhY8EMA9s5vcYxIfsi3Cqg=;
        b=c0UDHUKRUzQkUELy/0yxZGew6CEYtYEgbX5jMjmV+oMcRG2/6cM5WCmmxBlEF8X93A
         ITaUwTuSwngkCZcE8rTwFWNRKPaCrTyK9iFEhBcYpohFGAztYaCLxKZR7NEBcJuE/A+R
         WaxuDA2XU908UfqQ4OOIBjFaw5/wrep0VKjiqwZZDOxLdyIBWVIJjiU1343aJRjmLAJw
         t9zJ2yOmKMrSbyat0WeEp7Ns2KGepkffPNHyqBJ9TNcipgT8T3RV3UBuyKEOyV6HS/Bo
         ybAjvewlQLCNZ2qiAWWck7qK1kX9FhvUbfa5srYms0l6H5/W0ksPM85SFK74/L6maPIY
         OWUg==
X-Forwarded-Encrypted: i=1; AJvYcCX+l0mdRfpuPRZCDW65Yr4H1mHtksi7GuHTQyx7NuuowyUKR5nkQZcssKv5z+OeeuK8BoTYvSZdU5SH4szBZ6KraY247peaTqHMMjXX
X-Gm-Message-State: AOJu0YzA/asXM5oh2ITv1Ia/Q9Diuy6EmKidRrC7LMP4t96Yj9dzdmW8
	Xpz4XnZPiBkOqGdYBf/sCexstKcajLKGrIbM6Lq62tv52wVXWk5Sy/qIRwSgwOK5HOJCQ2sUATE
	=
X-Google-Smtp-Source: AGHT+IHDAo4/C/PGjnqvHUIAHjaKN930yOa92FRVowuGvRmrCwz9B7z34P+C2OIQXK5sC2IdKFWyKA==
X-Received: by 2002:a05:620a:70ec:b0:78d:6182:fa35 with SMTP id af79cd13be357-792c75f3f51mr1859962785a.53.1715866331411;
        Thu, 16 May 2024 06:32:11 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a572fsm800722485a.61.2024.05.16.06.32.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 06:32:10 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so2769961cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:32:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw8MZXcloEesoBlprYpzvgSkshAJ2mKptGvnSH+2hOs1/viPocoiP0uwjdG+O/D6N5ASXrQjqxBiSMebD8DrlsQeruTyYhaKgC0BsL
X-Received: by 2002:a05:622a:6089:b0:43e:33f7:600c with SMTP id
 d75a77b69052e-43e33f7623fmr5149201cf.19.1715866329914; Thu, 16 May 2024
 06:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516072039.1287065-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240516072039.1287065-1-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 May 2024 06:31:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WNgF7X2=Q-yujVfbTpir3-5nN85Gc+hV+xXY6ZOWSwSA@mail.gmail.com>
Message-ID: <CAD=FV=WNgF7X2=Q-yujVfbTpir3-5nN85Gc+hV+xXY6ZOWSwSA@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Break out as separate driver and add BOE
 nv110wum-l60 IVO t109nw41 MIPI-DSI panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, neil.armstrong@linaro.org, 
	dmitry.baryshkov@linaro.org
Cc: sam@ravnborg.org, daniel@ffwll.ch, linus.walleij@linaro.org, 
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org, 
	airlied@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 12:21=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Discussion with Doug and Linus in V1, we need a
> separate driver to enable the hx83102 controller.
>
> So this series this series mainly Break out as separate driver
> for Starry-himax83102-j02 panels from boe tv101wum driver.
>
> Then add BOE nv110wum-l60 and IVO t109nw41 in himax-hx83102 driver.
>
> Add compatible for BOE nv110wum-l60 and IVO t109nw41
> in dt-bindings
>
> Note:this series depend Dous'series [1]
> [1]: https://lore.kernel.org/all/20240501154251.3302887-1-dianders@chromi=
um.org/
>
> Changes in v8:
> - Neil think need sent separately to ARM SoC maintainer with "arm64: defc=
onfig: Enable HIMAX_HX83102 panel patch ", so remove it.
> - PATCH 1/6: No change.
> - PATCH 2/6: Fix Doug comment "return ret" change to "goto poweroff".
> - PATCH 3/6: No change.
> - PATCH 4/6: No change.
> - PATCH 5/6: No change.
> - PATCH 6/6: No change.
> - Link to v7:https://lore.kernel.org/all/20240515014643.2715010-1-yangcon=
g5@huaqin.corp-partner.google.com/

This all looks good to me now.

Neil: do you want to apply this series plus Dmitry's [1] atop it, or
would you like me to? Dmitry's series has a fix in it but I don't
think it's critical enough to warrant the merge conflict that would
come with putting it through drm-misc-fixes.

[1] https://lore.kernel.org/r/20240512-dsi-panels-upd-api-v2-0-e31ca14d102e=
@linaro.org/


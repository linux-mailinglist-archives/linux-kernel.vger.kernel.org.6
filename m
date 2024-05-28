Return-Path: <linux-kernel+bounces-192163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA248D1953
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B2C1F2329E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC516C6A2;
	Tue, 28 May 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vROD0i24"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139716C690
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895355; cv=none; b=QBu5xQfIaP1oyKS3FE4lrEax2FM3pH/WmYewXngdHotXVpFqY5ZHW8fggIypShD4Knvl3OqGP0dyx+jcssFNT8wmIJNwukQKq90kJOzbxY98T2Mbvw324HRM3g1IsAYrCbdORk2CI54SM1tImizRyolCxOGYLlCS7UQvml39TT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895355; c=relaxed/simple;
	bh=vVnrDTGTD1jTPXsabavO9KRkROagr7tEQ9cYmmbnS2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDWvOd/4hbFmcBKaeUEtX7pb7PGWSk/ee3kuuIk/DKWOgIZF2ZtWGdL8iBFYhVOHEnwOtwApahq0fm1wGIiYwkOltB/Go44n5RhxvZJY0GzSPqXHFNDRBTGnU7QIqdQrXEU4CAWK9U/q8AgZdk+aDewQdbgteInAle+criFfA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vROD0i24; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df4dce67becso612854276.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716895352; x=1717500152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVnrDTGTD1jTPXsabavO9KRkROagr7tEQ9cYmmbnS2U=;
        b=vROD0i24IuiBHKIk81B6293YNhjIRxEWItJywsyFsTuinLoEdk248ujFLZpmsS1n0h
         KQD6MqLg2FRSCHCW7Y9vl8bvb9WBVjwFfu1GXscpDW+aD+SBERlsE+FJrwFaCugrSZFl
         5q5FTbx689v3GmyV+PgpW2wJKG5mzv/J6kW0dAt3M3MthPWxGdzTICsfh51m3Fgz3HQa
         hapBKYqq0z2aFNKy9v5AF5XGhMvIxrAqbx67ofEDKaBb8jqSAqz3w11xl62NsEUeatok
         242vxzeAEQXm3XhHp9/pNBNO7Dvh6OkzdMn4HDqf7vuDORAtQXDDfNWUZNpeoTrl0MT2
         A72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716895352; x=1717500152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVnrDTGTD1jTPXsabavO9KRkROagr7tEQ9cYmmbnS2U=;
        b=ke4y1Lbs+Oz7sPPRtUhVx9iDSEPPytkSPuMT3STT6bVc3wjVqBR+vbqzKhLL+M6g9J
         nqQcGtaB3/BsRUJfs9G+h3VSkk/KGRh3aWFJTDr4K8IWyPp84SLdVjELnO1lm59uSTWT
         gTbCB48UL+M1PZD1nXpQEG3gxKIke/pCUx3KRNkfxMNbFkdNycpJ2M8IYL7gIIkOwriv
         AiIjx0fkIj0HO1ONf/tmssBV39v9/p2SZW2DmyH7bOxbt7WAXh7vDGH4IOztCC6dunb4
         kp9FnH0g5aucH7QTWEUnfjBZjovYK+amgC6MeZAA5O09Guu71OguEZLhe/0fqoAqE66S
         0njg==
X-Forwarded-Encrypted: i=1; AJvYcCWCCbdhynAJXX9YCvmnUDhE/kITmXoEZxERCfILzLvbRaqdLtBxEYyk1dfhZcuO9yBDMZ2j56QcLaGL42vesxXzOOxq36q/FLlrLgUi
X-Gm-Message-State: AOJu0YxRrQWwhOFrv1S0D2dWFH2+XKsfUBKXnBc/vHk8ViuSETQwS39F
	dS8vDFafcle/vcqwLl0gRBQ9zp1NO0wQW6Hs0wQ2mWnFBGA87q21TrpRAOAJBL3s805Uz4ltJBD
	wsOuIhb+OFcuU0hZZ7cOucbWe2iYTUysVBhkp9g==
X-Google-Smtp-Source: AGHT+IHD5J3DLTxyYoMzPiDDOZC0S/UzhoN+Hfi8cgK3hs+6ZRNPHnTS5nc3W1mkS6q9XlpPWh1tPo0b8CZO3gohUX8=
X-Received: by 2002:a25:d384:0:b0:df4:f200:4580 with SMTP id
 3f1490d57ef6-df7721e0180mr12372977276.29.1716895352516; Tue, 28 May 2024
 04:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
 <20240515014643.2715010-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240515014643.2715010-2-yangcong5@huaqin.corp-partner.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 13:22:21 +0200
Message-ID: <CACRpkdZuX1gi8No1eOC2GjCZOA-1vh5iBokR75dXmc4SLy6ROA@mail.gmail.com>
Subject: Re: [v7 1/7] dt-bindings: display: panel: Add himax hx83102 panel bindings
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	dianders@chromium.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
	conor+dt@kernel.org, airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 3:46=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:

> In V1, discussed with Doug and Linus [1], we need break out as separate
> driver for the himax83102-j02 controller. Beacuse "starry,himax83102-j02"
> and in this series "BOE nv110wum-l60" "IVO t109nw41" panels use same
> controller, they have some common CMDS. So add new documentation for
> this panels.
>
> For himax83102-j02 controller, no need 3v3 supply, so remove it.
>
> [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=3DzBQJUC4CB2wj4s1h6n6aSAZ=
QvdMV95r3zRUw@mail.gmail.com
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Nice work,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


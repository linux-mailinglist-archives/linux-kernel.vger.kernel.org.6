Return-Path: <linux-kernel+bounces-403705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A8E9C394A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B80C2810A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11215A85E;
	Mon, 11 Nov 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WFn0Mnep"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669514F9FF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311542; cv=none; b=jNULN1O2IG42ma8xPko+6x9J6eF8tGTdmWyPyFNZe6GiL35jkFk5np/emXOLsInx72u7krlzHyY3YBijKV4Qw0QsdsQzId4QLB5jV5uD843mKWuTrR9i0A40AyGZij58fxYWcDvib4KXn+UnPW00O+nIflRdASea/+3w0aRzjec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311542; c=relaxed/simple;
	bh=CKS2ivMfGZwRbgqnCIUlWddkSsDm0WEsgdFK/5SEzuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxA6piyEetPlCjbwNOl0Hfb2pr9U08sDpbY4OZILaGrGMfu7DL6JVzgn5oCKXp1g+Wl5xr5p6HoSHPptaUXA2RI9QdImGZir5nsv9V2g8MkaLMPAor0SINLgQh+fLOI8+QZ2AFFRSLK8vf/OgtnV1/KsfHXV43nx7lc+QEkHOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WFn0Mnep; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so5208350e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 23:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731311539; x=1731916339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKS2ivMfGZwRbgqnCIUlWddkSsDm0WEsgdFK/5SEzuo=;
        b=WFn0Mnep/+Qisp9d/SolZN+GM0p9epGVObmtfCcg6nkx54ReoDvq502oGAQ71hP+Ju
         dxgGQaBnNtUC1vUx0RDBK5fVLx0igcqAVJMT1VYC9X7rgt8RgLSIRafX+7HCGEoHB3Wi
         MMXiUMiFJFUbIpGwRtNQJz9AbZzlpK8/lC2vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731311539; x=1731916339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKS2ivMfGZwRbgqnCIUlWddkSsDm0WEsgdFK/5SEzuo=;
        b=acRdDdxdBgbXlyWYVmhMLhvtPS3qdyPc0DUe9wBdM4e4FYwOSUIu3EL0aivs5GYzjm
         CmB64n3ss3RzhNgbwHBedqVbjidIVVW0soDsfQZYu0LDoHt6LQMsESteFXY2ZfG7AuXq
         RJGycghAsrvDw0hlGGvjtjrdeFiEXcg//PPYM/7Dz/FoRJeXpr85+mfsndl8dbc5nSzo
         BpJFc/kit9pmQQKKVurQQc+ICj5KxwfJK6qlQ2MpjufGqwbT6k7KwrbqHcdx8r/61xZ4
         raCV0XmqzLr/USceaqH4qS7tX52OBIYiTBHB/0tm7k2i1OaGYO1hVEMIh+xppIcHFv2L
         T/+g==
X-Forwarded-Encrypted: i=1; AJvYcCUm7OcRC/bXSMB1TM7YFrIJKNguOue/Tg31m4SFU6hJli1jsancn2p2wJAZtbV4Uu8bMxGteP3xcefIzVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhOsh8Unlh5QzO/j+sVXq5bU9rbd3ELeW9vSxo2V+rxslHsjU
	dXM6puCKIolx9UsFRrggTfox8X2SWS2J/GDtHnEwv6OI5MVuctrNtRJyF8bZimZbzw57QHm86XD
	vmIYHRLefLhjxIT0HMFLYH+cLtArrxF+kGXGF
X-Google-Smtp-Source: AGHT+IGRHfTP9Kqq9mD5swqZoNxYRg8klYW5cXpLbVdWWLihAGznsqQ/hB9z7H/R/X3QaXj3PIOAVkGZbB37Lx2K3FM=
X-Received: by 2002:a05:6512:2214:b0:539:530e:9de5 with SMTP id
 2adb3069b0e04-53d862798damr4078071e87.56.1731311538956; Sun, 10 Nov 2024
 23:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111074030.25673-1-ot_cathy.xu@mediatek.com>
In-Reply-To: <20241111074030.25673-1-ot_cathy.xu@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 11 Nov 2024 15:52:07 +0800
Message-ID: <CAGXv+5GC1zoTnSQueDOtH8JRB6R5cg6mBMzAoRTsWPKVWAxGyQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Add pinctrl driver
To: ot907280 <ot_cathy.xu@mediatek.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	sean.wang@kernel.org, linus.walleij@linaro.org, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Guodong Liu <guodong.liu@mediatek.corp-partner.google.com>, 
	Guodong Liu <guodong.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 3:40=E2=80=AFPM ot907280 <ot_cathy.xu@mediatek.com>=
 wrote:
>
> From: Guodong Liu <guodong.liu@mediatek.corp-partner.google.com>
>
> Add pinctrl driver for mt8196
>
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> Cathy Xu <ot_cathy.xu@mediatek.com>

No tag?

Please rewrite the subject as "pinctrl: mediatek: Add support for MT8196".
The current subject is too broad.

ChenYu


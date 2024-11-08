Return-Path: <linux-kernel+bounces-401238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25F9C178A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629AE1F23E74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4481DD55B;
	Fri,  8 Nov 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDfDMZsc"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C41D221D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053349; cv=none; b=Xd/BfShb9pNMOeENdzYdjo8riUWLqxh1T0Ik4AtUBB9tPGiklsymgUYyvJEo+WHG322M7Jvki675HSAs24LE4f1PgAZRR8CjLjiJQZ8rDzRFAQu/OqLAaRdS/AapYvo3/gL/LiDbwitq/CqV0aybvOGCquz8XbycvkkVA3PauwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053349; c=relaxed/simple;
	bh=G9Z7xx9wUle37htzOFI0joTWlzfhv2aXAeez5YH7IZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWq9raeVNx9XzX31rOoMesQvRzJV09lELrRbnOA6Gicq2+l08eaypx5oiQ//yTKi1sU296DW7HXNVESfR6b8Jp3lScogppAYCislduAIFBXiw0lIlO1Mx8xuvaZmSDm0X9SMblTigdDv+FKBLh4s5c3SNPwUI98UVmzoFB4mFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gDfDMZsc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb443746b8so15876331fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731053345; x=1731658145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9Z7xx9wUle37htzOFI0joTWlzfhv2aXAeez5YH7IZg=;
        b=gDfDMZsc/rmQTR8GkAm2GQjLPVA76RZd56HY1vbpuTZMFuKi0nPDy+5+rtTH7D6c4G
         XclK8OpyFqfQ635pBPD1VA2y+w8PtyaPYe4kwXX8/LvlFdb+sgY0kMSX1JQzNhlDSX5O
         AroVCYJKswjBwsztSgSF5yi7ERQeUMztNU89BM2YWcx/n7RJFKjG5v9nBEGSpVpMVG3L
         FH85ljAM+UxhrNr4J3vh55MI99dqzaXWqIEanj0Mselsc//CjDkxAdbnP2ODus/5loCT
         oXQUxZ1QGdyFb5sQkAAXia0SgYM4YCMN9ihtgzGfR8XqHkYe+p0tVlVJPC1PLNlghDAM
         c+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053345; x=1731658145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9Z7xx9wUle37htzOFI0joTWlzfhv2aXAeez5YH7IZg=;
        b=gh9QJPecnALXSNA0QvaKIHQA5MWK/zONzpTRrfP/w2VfxnZYbGnoap+4t5I4SiNH6E
         JMmP1iR981rnVj9486/wlCdjfpLbM06vqZ6/Sw94UniXBRY0G4tBdruxgOhL62gJLyYC
         osDA+nr5vQh4aPyeHUtY1rONV0HgbYeDzkBXnKqGyJkVmn7vqKFIEzTAlok3dwh38Xqf
         wWsIVZK+OC0jV4dZKR0VempSSu0/9/qUGmijwrrj+E7ZY2MUnNHDuhkiYXC7YEpNfsUa
         q4jPFCVTXNpbKDLVr67lhbCu1IW1DLVvFmuxkPrVvKUCw1UmWG2+PuM03eNQdpVeIXRZ
         bfag==
X-Forwarded-Encrypted: i=1; AJvYcCVZaN5UnhfckIQUTShqNHwPJxQiWsgvOmmKYxijfSoSRt1tt2GSLO7iGQkv7i/Lcv30tnBx4a7i7bXfdpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWASowf7NyxtGiljM+E9WE3avcYpzoEf7TetzUIGamBbiPj5Y
	02A+yEIcBorqOGJkKuTATSsXutgAJEWVD6ulXsdAKjcjNtO0p0gGAfYRrnHMgk/xmkC7VeK1TCb
	N9NI9UKydp1qA0g1qSwpImOM8J7voJcoW65Puow==
X-Google-Smtp-Source: AGHT+IF0UB7o0vuS6Bty4AeOnjqYdCjSMRlYLH8+QDSVbXDnav7cLaan9vUhNYyE5wm0llxN2dvFNKermU2/At8KL/Y=
X-Received: by 2002:a05:651c:b06:b0:2fa:cc86:f217 with SMTP id
 38308e7fff4ca-2ff20307f42mr8533711fa.35.1731053345351; Fri, 08 Nov 2024
 00:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org> <20241031-msm8917-v2-4-8a075faa89b1@mainlining.org>
In-Reply-To: <20241031-msm8917-v2-4-8a075faa89b1@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:08:54 +0100
Message-ID: <CACRpkdZ8YFfpqmgoahXBk9b88CGKm6Ny0Am4vvUf1ekUz0bEng@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] pinctrl: qcom: spmi-mpp: Add PM8937 compatible
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:19=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> The PM8937 provides 4 MPPs.
> Add a compatible to support them.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied for v6.13.

Yours,
Linus Walleij


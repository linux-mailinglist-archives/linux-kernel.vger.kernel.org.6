Return-Path: <linux-kernel+bounces-240696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476292712A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD93B1C21358
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B01A0721;
	Thu,  4 Jul 2024 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IbiIdOUI"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65218637
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080195; cv=none; b=YDUa9ZPPG1MWE6/EmAKeUeVvGNgzQyYEeMjwhpR/J2q3vJsdgkZZqvsGZsxZ+omMKdto6JxTN6cda8iCMErlS2TrHWykHO26U9ij+mWIcpeiQwrYj4Rkg1uepIBWgyElU7manlnF6vzRJztl+5ZN7dxxatPQ03qoMZEKAS82sRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080195; c=relaxed/simple;
	bh=u24iGCJle8wB6047zc0I+RZs8YvZ6yx2WYNcbcQDNlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu+NEucfGEpjN7mRsRsDiEBKDc5JRVVD2U29sd0X0dqx0XEJfO6wpX8ywo45eB77MhoQK63sZkwlRKYSVzSTMhRDTg1OjEFEelT+A7xE3/xbkXtDCXImMnULGRVv3kHNhsdjvl0njo59/je0kL5TmlT7MSDJXLvHCufMW1LSwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IbiIdOUI; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so4141141fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720080192; x=1720684992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u24iGCJle8wB6047zc0I+RZs8YvZ6yx2WYNcbcQDNlk=;
        b=IbiIdOUIKN2oVupp9VF5hQi44wzagNO5pqtK/jsW9WD7WbdWiid7Dr3dSHyKey350P
         dl1a0+v8iOtEU6uKbPgGJrmOpRHsHvso7Q8HjWUSoY0oMmnsiShuh1Tz1iC2/clEDoj9
         0+oLO5ct0yaEq+Uo96T7lRIsPilk2mz0Jy0zggC7n73QezZkzj9U1DQYE64EnCXraahU
         KZJIv4kvRmTaplpZn729d5ysl+Cm6tMaRNFFoVWeIQvSVYRyd+O6kd+GlB3d37NzLeym
         Kr+yqIxTKciMOVMNTIynmXvPSEvACa4jzOQ8ZpUQ7qTvoAn0npK0a8gFnhs+IfSZ4aLb
         aytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720080192; x=1720684992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u24iGCJle8wB6047zc0I+RZs8YvZ6yx2WYNcbcQDNlk=;
        b=wl9pBHNeqfuYi5YwRnxdgrCi+VUZAZeA7ruTSoToZVkrEaeIP89dExDPnUNlAchbkV
         ja7JUDJDEvGg3DDZLj/R5k0eVmlyU2SnjRf+dkR9n0N1+NtJuX7j5w0HeJtbx1ZSzlnT
         vhtTluYYaauoa0kbZBrPCrxfigFlsx4obROf2cQTIkVtExjR+sENqbulCSARx6bYo3fP
         aXd9ioZ7+vDMIvVdg4jGjn84SODexQKf+u9a40UejtV2bH+E92IVEST6ykmPsBPFmjo0
         K6RthqRIVa3Trwtp14u+3OQkglsSeyS9QgMeBAwksCuaJfveqXbIXvHE5eQxHOTrmjwt
         Djkg==
X-Forwarded-Encrypted: i=1; AJvYcCWBR5LOx2jPMxrQZqi1rJlSt1bQBd5r2NG5DfrxoAqu4uRTsLIs9jrecdW+JvxAqadXMOtKL+ieaKrJZdFBFNmvE42CXanSBF4M2BhJ
X-Gm-Message-State: AOJu0YxcHOOrA1gClnwi2n8T+75z/Iw7SiRc8rzBxrBrYq7RLClfN4W2
	+1bRas0k1nWbnVG+zAtk8ev+UMrJquf31Y7J9Uhiqe5nCryvP39buzkbNGX6FILAnY9vuL4F4OH
	7IFwKqkd3mdijN73tllak8YnlHogzTi5sRpBQlg==
X-Google-Smtp-Source: AGHT+IF0EDMknjR6sXLPpKbWZIPGUiSupL2hDO53Je9rRxH2mDMZnbcki7Z7suRePmiFrtoavB7I1uEKzuH/HpArOLI=
X-Received: by 2002:a05:651c:b95:b0:2ee:7caf:db5d with SMTP id
 38308e7fff4ca-2ee8ee2a014mr4391111fa.51.1720080192282; Thu, 04 Jul 2024
 01:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
 <20240704045017.2781991-4-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240704045017.2781991-4-yangcong5@huaqin.corp-partner.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Jul 2024 10:02:59 +0200
Message-ID: <CACRpkdaj2quvNdD_UDzyYPK9LyBndDHr0GNb_y8CBFAWakSU+A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: jd9365da: Break some CMDS into helper functions
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	dianders@chromium.org, swboyd@chromium.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 6:50=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:

> These panels have some common cmds (e0h~e3h,80h), let's break
> them into helper functions.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

This is a good start! :)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If you get time one of these days, see if you can add some defines for
the other vendor DCS commands as well, but no hurry with that,
let's merge this series first.

Yours,
Linus Walleij


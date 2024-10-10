Return-Path: <linux-kernel+bounces-359889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A182F9991FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C9B1C26964
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDC41CDA2F;
	Thu, 10 Oct 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEoXIubN"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67251A00F8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587649; cv=none; b=tKiAWv3SWulSzarj4I5Krz3jhe/smk4bEf4kYMuTJ5biaGXmf9+wTdPqXRPeCnRyzSFC6tkaqBGKGl7YYsR5xI/AdJ7hI5DDyEHS+FbSzS/fg1U6FzxOcdBpGGtf6o8TiXQytG2ps9V8j00l+y4EalCsE3J6E/HqDjpKz8LZl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587649; c=relaxed/simple;
	bh=lBkM62Uf8D8hipuH2exP+YuvyI6m5at/29z+OU9H0so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZuSSXPm+F+H6PKQEIsg1U8d/cRNBOj2JjuWxpiNl+O5BYdunL1uyfMkIwC5zPoHkuTbhPp3e0ygy5LZV+236tQ3ECQAYHAAdkSFXRFd/ICnePepJQFl9+ZiWHwiiHh0/URSbcKw4r2pQHm4LGeX0ekpj5QJtD1/XuwiVhn1RGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iEoXIubN; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso13453621fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728587646; x=1729192446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBkM62Uf8D8hipuH2exP+YuvyI6m5at/29z+OU9H0so=;
        b=iEoXIubNWA/00BR6qgdlM6a6CuWLlOjndTB58zlrHD9cPDSkWWGVkwJq4RK04x1pH+
         VB8RxVP4+Mcq/gqvnVJ9MumW9B7AtZJXAKkACuCmMn11dcPktE0JpwZhI6nHGM5DPj/8
         JaHNsV6ewop7NU7HKT04V4WspLcP+R8hkKdMEaAib9pG6B7RdtzLmNJehBC5xBmWN70H
         7YTYaoXEf7ixkX3p4bb6C1qDhPyJibnPrw5ytjg2chQYcD/J0vywotA1/6ioQhFa+gN5
         rSxBnpoQ3d2XNxDvU/bHNDP5ZcqFKlQYHKJZFxffwnYZuk503MDaNPolKIbVOAIk5ctP
         YLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587646; x=1729192446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBkM62Uf8D8hipuH2exP+YuvyI6m5at/29z+OU9H0so=;
        b=mBd9kVC5KXXTlHt5kn3aycgYxGSyCH8PZbITmjXPhchTxsyEdc85gSXSV1XINKt36Z
         k3bZA5q68tOG0PcRJ7xsUaog68ilJhxgYwTr+qybsmnMYX+5SMWW5Q1zl9uqe+2ePgVj
         vjG9pIDdvhvvtKNy1Eh9q0r8CSoBXtbS6s4BLcO5NpMjvGHXlxVDj60KQKaD/cWhhk+E
         xrq+8ABNSpJGTQGjhCQhT0Ln9Cd8YED0HOdTltQJJwjIqosD/ASH0ca/8/W5AVRxzh+K
         +PcWxXs09sVB+AxW5DPgZlVQY1KoU++Mxh1bxqmrJSgVrTuf8SejOyN9m2VwGRAoWzko
         fOcw==
X-Forwarded-Encrypted: i=1; AJvYcCVwg0k2f74C1ihIEG1z8QIUhet0EfDdDUSzQYvnvsAJHQug6M0pldJSKJB7yvmEPMSEgMxwoKYwpW8cn9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxadjPxa2ZOBi3Rk7oNZqbcKph5l4nixCAvP231lKep5ig/2RAf
	C7nZF02v2eMUfBnzPZ5t8ENPErRUWzn0oF68QqFaESO8WdbUClzdo642KX31UxPiXEWGAHvL6TP
	U8RQZfu7i7/aVp1r6uV3x/e5AjFuRmnZ+Yx8bdw==
X-Google-Smtp-Source: AGHT+IGYOggXOh9XepD9Y//uWBU8LvHdBKPWy+BsszcaeSthF4pIcJDZgS3LzuK0LgzQT8i472E+9VsKzKw5ReDQJE0=
X-Received: by 2002:a2e:b8ce:0:b0:2fa:be5c:8ae8 with SMTP id
 38308e7fff4ca-2fb2f482b65mr2900631fa.41.1728587645756; Thu, 10 Oct 2024
 12:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010111830.3474719-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20241010111830.3474719-1-harshit.m.mogalapalli@oracle.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 21:13:54 +0200
Message-ID: <CACRpkdZgA=+ZOq+shF4pWcGZ95=Kj5pxBtvywpGc_kkYWVgqMg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sophgo: fix double free in cv1800_pctrl_dt_node_to_map()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, error27@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:24=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:

> 'map' is allocated using devm_* which takes care of freeing the allocated
> data, but in error paths there is a call to pinctrl_utils_free_map()
> which also does kfree(map) which leads to a double free.
>
> Use kcalloc() instead of devm_kcalloc() as freeing is manually handled.
>
> Fixes: a29d8e93e710 ("pinctrl: sophgo: add support for CV1800B SoC")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Patch applied for fixes!

Yours,
Linus Walleij


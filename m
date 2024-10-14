Return-Path: <linux-kernel+bounces-364652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC6499D770
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1791C21606
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DBB1CC168;
	Mon, 14 Oct 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWq3rNM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF31D2207;
	Mon, 14 Oct 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934041; cv=none; b=uL0ufSPXE0s/RADRHeHAxpRamjNY7ZGaaQjZeBgNA6g2v59Yv3dqYmzP+aEraRsbw8n7jaTSjDX9wyv8+7WbLOkzqLiXyNgjNeZWLwT/ZkRWt5ReJKGwuJG+W6bMwpjeYxtg8w8Gg3iNvMMLb1sExVOD4Y7ju5q+ClRKDW1dQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934041; c=relaxed/simple;
	bh=tQzPQb5VWw3cawctsi84HIWKh2eL1jlGRlFHBbBCF68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsOiPRywRLWJg500W+j4ZBgUNKEEJWsx0i/YOJL5UfKoUxG5U3Vphg5+C2DZ2azMmVD/DsyQE5s9ktu2cPox9Pmh05ZB8dMQy/ijPTisF5UBw08mgVGyqaKKdydyEUTZOw0KSlatlL702DZwfyHEhbMFIuk6OA5r9mlI3f6lfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWq3rNM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EF1C4CEC3;
	Mon, 14 Oct 2024 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728934040;
	bh=tQzPQb5VWw3cawctsi84HIWKh2eL1jlGRlFHBbBCF68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bWq3rNM6yrz4R/mQctp7qZlwuck14t11vNQDLZE2BHhLGFGYoO5JrcuYEhe4zMFI2
	 5Q71iq+8SslrCq4M9lO3nFOapYvSexgduhhXnEIsP8TN536Lh2gVWNKepXYUa6g8bJ
	 3bzChGAMxMDQWDNn05I9IOAWqisZhkbZZziIH3TAP2XI+dk5h5L+2Lqd56wQ9fTq8J
	 VORFa6/3v2zXBfzGhT+tvFMe/l9d/GWKaTV59+7FgK00IhoAnDEbmVTCQrVkPxQkIE
	 ZhGNPj8WFPYmQ4PgUkfvB2353yRJg+d8BU+V/RCaw7VEYXJ7AWXSe9b8klq34+u+FQ
	 LQwZrQ7uyxG0A==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e34339d41bso29362587b3.0;
        Mon, 14 Oct 2024 12:27:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+bD4fBYdL96pTYNqWYBeUNd6e0nsWgHTXgSdUiP4KoK9J7AJqy5lxx4l91lGjOtVqF9PA8aV4rVga@vger.kernel.org, AJvYcCV2G/+Qj84NoaIfBwGEY/AJHNnUN3BXG1riRvOkJ1HXfZdAMGhWs9R3aZxzqeyliQkjUDp8dZU8v+cPPjIj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjif0tmD2Uf2Sgq5UZTt/UYyfQRbh5exzvfX85c/pBSUnsP6Lq
	nadWNhyEDQ7UhjVV+UvWzlUi0It4aJKaq+SOqGpz+oQhC1zVVkixyDeKwh4FIRN2trO2e2els7R
	+GGWTv051sNfGLmbKQA5OsNs5EQ==
X-Google-Smtp-Source: AGHT+IHFxbFOoxL3R+0pc4MYk8c6g6Gw1OP6SSIGjNMlluYLOdAMkWmNh+/64HHDfLcXoB7qqBC+F19FewtdTjaQwF0=
X-Received: by 2002:a05:690c:6c0d:b0:6e3:31ee:23ab with SMTP id
 00721157ae682-6e347a03e92mr95243767b3.25.1728934039744; Mon, 14 Oct 2024
 12:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014180324.536702-1-cenk.uluisik@googlemail.com>
In-Reply-To: <20241014180324.536702-1-cenk.uluisik@googlemail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 14 Oct 2024 14:27:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ8k6rNssQNdve2jzS4yqxShE4+g4t+yopyWSsn-WtEuQ@mail.gmail.com>
Message-ID: <CAL_JsqJ8k6rNssQNdve2jzS4yqxShE4+g4t+yopyWSsn-WtEuQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: rockchip: Add Orange Pi 5b enum
 to Orange Pi 5 entry
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Chris Morgan <macromorgan@hotmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>, 
	Andy Yan <andyshrk@163.com>, Jagan Teki <jagan@edgeble.ai>, 
	Michael Riesch <michael.riesch@wolfvision.net>, Jimmy Hon <honyuenkwun@gmail.com>, 
	Jing Luo <jing@jing.rocks>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 1:03=E2=80=AFPM Cenk Uluisik
<cenk.uluisik@googlemail.com> wrote:
>
> This extends the Xunlong Orange Pi 5 device tree binding
> with an enum for the Orange Pi 5b, which is implemented
> before the device tree.

Please don't send 5 versions in 2 days. Give reviewers a chance to
comment even if you got comments from one reviewer. We're not all on 1
time zone and I don't work weekends. 1 version per 24 hours at most.


Rob


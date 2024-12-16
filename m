Return-Path: <linux-kernel+bounces-447995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDB9F39AA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83721887201
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AD1207DF9;
	Mon, 16 Dec 2024 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL3HtXNT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E984A2F;
	Mon, 16 Dec 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377005; cv=none; b=JJmsYTcXHMFaC0rlN8bwIDfr4PmFNAL08eEqO6W8Nv5MYaJmW8AAXgj1cF2AZaWwT3Xb/LbcOA9svt5biaUtxRLTHxfQgnIhGQPm1WK7Z2Xzc3JmlqMPxMF5xhUx1YLKsOD8POUs0G7H0fMUPE4PhggiPKCiVT9PodPYtyWrxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377005; c=relaxed/simple;
	bh=LTcCZnJCBIAVDCBYyRpRW2C2Mx7jjQ7PnOoCN0T2WVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XK668K++Qc/cRkUrxc5FyMPN4F+eUaZqpTFy4JpgvRemLQsFHK1ZgftCHDJkhSj1B865hgHzQb5xSsc8x0K491XFqe9pnnzvjsG6P32fHstDy9KzK9AGKfeB5UdghqG7s76VfEkzSBfSeO9cjS7NlPXu5LznaIkQa70MUUaHD/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL3HtXNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CEDC4AF0B;
	Mon, 16 Dec 2024 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734377005;
	bh=LTcCZnJCBIAVDCBYyRpRW2C2Mx7jjQ7PnOoCN0T2WVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YL3HtXNTaW12jCadQU0ufYvvqQH935N64bPDYLAdBwi4s5/oNpP0K3Ixlr+s1BeJF
	 Q/51BAk+iCanuuh+jGby3PLol4WbKE9OAMLP6Rxh7Sp9zSlBFIYQbfX/pvy4VfEWh4
	 DPOQAybI005eh1U09IV5e1MHfbnnPWPeoMhAiRjuN+waQm/D1WJ//DNQ76HT/LxclC
	 TcMMNurKvwqtC/4tfKLDlvXkLgrRrYoa4xSykZ04He6B2gOa+7qNr3N2X/jvEwtryU
	 tKWTr3jKdgfHfaIJTjTxxYbOhCna1zneUFWUGEAO8+qNB8W3e93/ZLU8QKraF+Q2sp
	 yyoMddwYX/HVQ==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3a26de697fso3318786276.3;
        Mon, 16 Dec 2024 11:23:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUD5R4M1J8VErHEGGic9D/TeiOD/W36ITrqxNUjGBBoeG7QNCj7XVvtmp9I2kw4GHulbIRkKooQkx/4Sa9p@vger.kernel.org, AJvYcCXwebbKc9BKBhWhHl0VwD0Y2hJwlIyzYLM/yWCRi8nFcBUojUsgD2SW0AhdLkv4PglUTGk63AXEzeMI@vger.kernel.org
X-Gm-Message-State: AOJu0YynY1xTBe3wcZqYXl6lJdp0x8DLKP2Oa3qm/MNWZnkiifTY5zUK
	TXTn/BntmINYem7LrmxDIJY40s3H+5l4X49vsWnYT4RpIqBV6BUZpW2IvcZkJRdf1qZrDhiMSS0
	+eWXqAs05AQGNUCHFNTZpAqzKCA==
X-Google-Smtp-Source: AGHT+IGwkCBQPm10plulVM5kBQzTywdv2iGyB/e588i9eKvMTwG+Wj7fE4qsvRoms6WCvGP/olOcSaEzN3CD9V5VWOo=
X-Received: by 2002:a05:6902:e0a:b0:e4a:fc25:30ca with SMTP id
 3f1490d57ef6-e4afc2536a7mr4832939276.24.1734377004311; Mon, 16 Dec 2024
 11:23:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com> <20241216-of_core_fix-v2-2-e69b8f60da63@quicinc.com>
In-Reply-To: <20241216-of_core_fix-v2-2-e69b8f60da63@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Dec 2024 13:23:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKa62-OGHYb9ZLf_s+iMoyAtdazFeMuoz_1Hvz7Qkzeiw@mail.gmail.com>
Message-ID: <CAL_JsqKa62-OGHYb9ZLf_s+iMoyAtdazFeMuoz_1Hvz7Qkzeiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] of: unittest: Add a test case for API of_find_node_opts_by_path()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 6:41=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> To test of_find_node_opts_by_path() take @path argument with pattern:
>
> "alias-name/node-name-1/.../node-name-N:options", for example:
> "testcase-alias/phandle-tests/consumer-a:testaliasoption"

The test passes with or without patch 1 applied.

Rob


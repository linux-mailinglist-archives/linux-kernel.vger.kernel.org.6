Return-Path: <linux-kernel+bounces-305559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78447963079
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13060B21085
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E861AAE27;
	Wed, 28 Aug 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euah272e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BED1A707A;
	Wed, 28 Aug 2024 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871159; cv=none; b=kGdJbgBPa6QNpglpT8swd6TRYF6iiMoSJ4W9y56Fs4lCxHOW+3lo56K4hgSTJJIA8tRLC9U6vuowC+kfxQfXHTJXrztDQYi2brNTFrQaV3Z2+dr6C3JaiGxT9FymdPKPjnBzP6hPr0QRTASptL9JQECsBzo7oVsvZiXu9DkFMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871159; c=relaxed/simple;
	bh=gi7xPuKoCsJRAG1O+SVQ+ztT/tyFYFHWeOA9vYgyQA0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=hFWPAXVCXOK3QUoj11QvxWG+knx1a0Tb+fsi7VnA8BnJcDVZ0VeADprc4sKe9ON+HSF1evH/a2kuvZB/8hLlU5PcXTwuHWJILFZO+BP33Q0jcTtahdd6SfD+03FmGUJOgYjdFTjrd2cPNIqApP5/hBaNuFdYzVUxV7Oya38d3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euah272e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08188C4CEC0;
	Wed, 28 Aug 2024 18:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724871159;
	bh=gi7xPuKoCsJRAG1O+SVQ+ztT/tyFYFHWeOA9vYgyQA0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=euah272eqs4rRz9hvZCPRXTtnyZaHcGPiRgzvjQ41v1L64gYE0lJX/au5oOj9GF/R
	 nu2+p+ag9soo1Igy/PukJHpQYXvbc+zFSSKBlC10DhyTGflK75t2pTcqg4kfLUCs0R
	 I8so1pAw2ZyWBkdelSptPo7Phb9f4GMej0ZkqHFt8oCjg2EDIEkMt70024bmudvjgq
	 iXDgWoQplEnURYXFbxo7QoL/YFgqOMbdy30+RHOIwxSQQnWsLVqFmw9J5nhXG6wisb
	 tmQOuF0sFCPZeEuOs482Saf+YgqG2gKW3RaUHf4NqkzN0aSQymFt3Ai2cRDQ7cZ80G
	 Ykuz4VfEeJQXQ==
Message-ID: <ad33e8561ca236c5f897003fb40bdc09.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240827061954.351773-1-ganboing@gmail.com>
References: <20240827061954.351773-1-ganboing@gmail.com>
Subject: Re: [PATCH] clk: analogbits: Fix incorrect calculation of vco rate delta
From: Stephen Boyd <sboyd@kernel.org>
Cc: samuel.holland@sifive.com, emil.renner.berthing@canonical.com, mturquette@baylibre.com, paul.walmsley@sifive.com
To: Bo Gan <ganboing@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Aug 2024 11:52:36 -0700
User-Agent: alot/0.10

Quoting Bo Gan (2024-08-26 23:19:54)
> In function `wrpll_configure_for_rate`, we try to determine the best PLL
> configuration for a target rate. However, in the loop where we try values
> of R, we should compare the derived `vco` with `target_vco_rate`. However,
> we were in fact comparing it with `target_rate`, which is actually after
> Q shift. This is incorrect, and sometimes can result in suboptimal clock
> rates. This patch fixes it.
>=20
> Signed-off-by: Bo Gan <ganboing@gmail.com>
> ---

Please add a Fixes tag.

Also, your patch has tons of diff context. Why?


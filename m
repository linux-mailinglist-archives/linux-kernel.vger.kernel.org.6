Return-Path: <linux-kernel+bounces-305644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308769631A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4297B23F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717351AC89D;
	Wed, 28 Aug 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCe1xLA/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22741AC890;
	Wed, 28 Aug 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876419; cv=none; b=JFrRKH8sKOxlWbaqX29FvuC2chD4QNmYZPodkq0XHqApacxlm1/1RMyJBsioofCrF406AzusyudOIN/zdwSVHbI5gTfZzr+Ue3+Vt7SbDLVQQEcskMoYB6sSVk4CPJBmCjoOUe5DxPdjTFhBNINlAJ9LPGgi8cbAQS1Te+XoRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876419; c=relaxed/simple;
	bh=4e6jcRQm7lmPCqaJo4uL67ZbKsIu7ZwwqvdvEAjgsJs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ZesopyJUXqCpZaE7YXRCmxqQmJ7vB8u72p7JfJWB4c3T87Du+IejmGz3rgK8ndjy+SKNRXVl2TmOxJW1dH1BQjk851SOBt3Lm9ajfj6k2BSP1QFrnB9JAqJcFz2ncRVnSpuc0JUUOFaJny52AV+jAiZqXQC8nZ3MMDXHKuC+skA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCe1xLA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B87C4CEC2;
	Wed, 28 Aug 2024 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724876419;
	bh=4e6jcRQm7lmPCqaJo4uL67ZbKsIu7ZwwqvdvEAjgsJs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UCe1xLA/AHkQo3LvAoPCjAxESIGNB8nL3EO6k8MQguXb5S81cvq2ki70LsdZyqfuy
	 n7osLPOerzccB2jJlhN02XFOiGJeW5HyThpY/HxP1XDFUMQpJVD+qolglGBBJAdpH+
	 nycPg15CXdfdf3aPUEcQyfFBtLuvE8Z/Bt4Q3TCamFUUkTLBtHub0atL+w7XpnvpCX
	 V5SFaqfz9MRYKxossKTepbVIddxGd8834l3le2c57QPDEkQxNDMlISsN0FJ3KdN2sK
	 AVtTBVU7OHg/mzQnQIHB35n8b+723v1ETx9Kne3IBWvmbUIRcdOQoJsrKOLE6vyM7s
	 CYhc4HcnLENcA==
Message-ID: <edee9b38ca1b425fb5ce01a167cd005b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240815093853.757487-1-liuyuntao12@huawei.com>
References: <20240815093853.757487-1-liuyuntao12@huawei.com>
Subject: Re: [PATCH] clk: starfive: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@esmil.dk, hal.feng@starfivetech.com, mturquette@baylibre.com, conor.dooley@microchip.com, palmer@rivosinc.com, xingyu.wu@starfivetech.com, liuyuntao12@huawei.com
To: Yuntao Liu <liuyuntao12@huawei.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Aug 2024 13:20:17 -0700
User-Agent: alot/0.10

Quoting Yuntao Liu (2024-08-15 02:38:53)
> We need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
> fails, so use pm_runtime_resume_and_get() instead. this function
> will handle this.
>=20
> Fixes: dae5448a327ed ("clk: starfive: Add StarFive JH7110 Video-Output cl=
ock driver")
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> ---

Applied to clk-next


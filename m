Return-Path: <linux-kernel+bounces-345591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9698B7D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011E8B2609F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25C19CD1E;
	Tue,  1 Oct 2024 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helene.moe header.i=@helene.moe header.b="Bgkh+Nfa"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F619CC0A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773337; cv=none; b=CtYQfcHPvM4EyRT0az8GUiEmJLFHNfeWWvoJGFcnlER/ahb7VuPrMorFj6hS9gQ10hqCHwoPsNDhfSOgFCdKOiIzXJhhpeCFGUDDRD36tHufWyr6PdQY0iGiXKfudqFMUdD+64oHq+ghGPRGwoqYXvx08EWYGDzk5aEVMSLBv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773337; c=relaxed/simple;
	bh=lB/q12JPSaPUA3WAv3k50l5Eoenredy6Lsztq37ipTg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=MIC5Y3Y1A0T8GMbHAmXo/vv7t8BB1XTKQqCuJPp35sMYIswjWuYL4gtmWxzYo4I9wi9B9IiuHeYCgdopTWLU1KUE2K2YShWJ/Svibmp7lrLiOy8Tf0qclUHxwG5Sq9tzTF72LJtYcx96xZ4JFXT7qMpTHdBkAR1V80lnefA+5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helene.moe; spf=pass smtp.mailfrom=helene.moe; dkim=pass (2048-bit key) header.d=helene.moe header.i=@helene.moe header.b=Bgkh+Nfa; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helene.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helene.moe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helene.moe; s=key1;
	t=1727773333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2PdjCDGOk6QxIKmF2vicvMps7T1/RqF8HcaNkYp8E4=;
	b=Bgkh+NfasmTc46ZM68ek6kMrD9a8s0l7K5O6MkLPz4DoLO4pjH2/86MYbl3HpvXctvil+g
	jqNie6UyOaOwzA/TRe5UEMWG2DWEl9eyw5sY8s4X5wRJD/5i2jjxPv08kuJtjmwzdaPeCj
	W3P90QyO/s7LrBk6Djedixj50yuPh33VGlfuxn5WUzS+Y/E6NX89/f36WvLIQZu257M3T4
	2xSnyVK1AQ6J7oDudbYQpdiLHWMGRz80UaYkWZn+ErC2Dil9guSZFPPjQrcalh30xhnSdL
	aXhSIBdhWa3ZGlV5S0ckfAFpz3RetqS21OBoieBnqwUrnEo4JFwo5YNan16NuQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Oct 2024 11:02:11 +0200
Message-Id: <D4KCJ2SLGMWG.1ZGZRDMNDKAVD@helene.moe>
Subject: Re: [PATCH v3 4/5] driver core: Add device probe log helper
 dev_warn_probe()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?utf-8?q?H=C3=A9l=C3=A8ne_Vulquin?= <oss@helene.moe>
To: "Dragan Simic" <dsimic@manjaro.org>, <linux-spi@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>
Cc: <broonie@kernel.org>, <heiko@sntech.de>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
References: <cover.1727601608.git.dsimic@manjaro.org>
 <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
In-Reply-To: <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
X-Migadu-Flow: FLOW_OUT

On Sun Sep 29, 2024 at 11:21 AM CEST, Dragan Simic wrote:
> Some drivers can still provide their functionality to a certain extent ev=
en
> some of their resource acquisitions eventually fail.  In such cases, emit=
ting
> errors isn't the desired action, but warnings should be emitted instead.
>
> To solve this, introduce dev_warn_probe() as a new device probe log helpe=
r,
> which behaves identically as the already existing dev_err_probe(), while =
it
> produces warnings instead of errors.  The intended use is with the resour=
ces
> that are actually optional for a particular driver.
>
> While there, copyedit the kerneldoc for dev_err_probe() a bit, to simplif=
y
> its wording a bit, and reuse it as the kerneldoc for dev_warn_probe(), wi=
th
> the necessary wording adjustments, of course.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Applied and tested on 6.11 for arm64 without noticing any issues.

Tested-by: H=C3=A9l=C3=A8ne Vulquin <oss@helene.moe>


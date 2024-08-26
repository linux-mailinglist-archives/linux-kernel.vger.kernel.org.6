Return-Path: <linux-kernel+bounces-301710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6995F469
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D80B2160E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBA118D65C;
	Mon, 26 Aug 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uyu9IQNB"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF41E892;
	Mon, 26 Aug 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683910; cv=none; b=FeAs/6W8uXoE3Grt2+SKY+9w/08wpDgNEv+dwtZrzuq0SYUQ3bFkGIypuoZQkQHHbmuPJKbjQjFVv/TRngt+hUxTT5tGlDtiTBGYRSB0GJ3mD7L5yrxGVfnBgohxeBVJ2eKNirdWb4jEumZQ2fcBFIL0D630ql0kEktk78V0rKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683910; c=relaxed/simple;
	bh=Szxjzk6JoGyP0xDO7tnLaAD13P/f0YbuG1OSR82F47Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ueQ7s+6zbMZPMNZyGkVrdgHWzG7Kh9X9ujhL3Juv3Gro6qdtb1ouAQVJ9pLaxldyW52dDQsEuAGpNz0EH4BB9IfgBZPeIIogRV6PyE3VhZ3gNSSbuhuzfyShqpJFr3zMYOEyQBoQtqSqnv5gLUudvAG1Hb1s6U1HB2hS93poG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uyu9IQNB; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724683905; bh=eL/IgrmPlGruqcD+c6SF8+WrCSgxfBCidykwEQW8X6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uyu9IQNBNVhSRiIXyA7ysXOPJMpKeeSl11U4DGJ3lmsJHWehSnpfSFkTyr8J/5f98
	 xJ9eNpheD3zvi97t42PixtU6XT2xYDpdTdkJaIKsZQxiX8cThdnffbUKEBby6VZ7sO
	 KyAYJeyEhyU+VSOcN8zfLFze+qnyYRfoOjvW4Xx0=
Received: from localhost.localdomain ([112.64.14.141])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id B59A7830; Mon, 26 Aug 2024 22:45:25 +0800
X-QQ-mid: xmsmtpt1724683525t6kl0279u
Message-ID: <tencent_728616623FAC3980B7FD8B7FC2F049031208@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u8nK+fa9X50ZpOpn1Dl6u4LBoF2AlB3eBM9zAg247CnnrcAsnYN
	 cIZersQZI9EbcEZzV//kBYyhGo6uSQpMKe1D/S8osHMZMkcEJ7IckZQEQyaAwMMaMPLF9dTxVq6d
	 r+VrsGHYkdJX5vUDJJzICLWMVwx4ycQzvsJS7UYn5dKEUH+JhYsOFoMauHLXiN8TvZMTc8GO1DlO
	 Y2iCeFxjZbkMHBuLIB2XdKwsZc47QrNrUO52HVLW/y6DF/xhaxZIirSXnFJRR3gftrM5CV1dmGhO
	 +u7Y6lZH9+M3a54lyW7D86lc02oGOk+cVBc3stYUdSjbjr8S6Z9Ucm3SuPH6A6X7k6EXrWRuy25m
	 xl7zFSeBgMpoDmaydQ9REjLGZVohtTujRMIrZdCl7jofCGjEazkj5q2dz5MNNMAVT6EgLOg+OkSy
	 pdhE1BXcoq8Z7aIUMHhW7NyGTdXgkktR924mY3+eobe/8NmHWPn0GYrdfC2wQUVu+b8sPn+2rbpl
	 t50AbzT8Fxb9XxotUTQHEn5MzrAOmHZUuPEAjjlhAKEe4YTlfQXQbxBUQVKE5c1SyNJMpCzL4pia
	 gFS4RmYoaiHj6f631auzwU9LWVfYv/ZDP+rMlywO2B3JsACXTWIbHw2VgjJvyNmeTsgXs5kJdT8n
	 mvJhYdXO0nJmWOly9Fxc9NpGM0ugOE7LB63WH7/XhhnV68vVUpeg8O3bQgV9tCa3sFXhS9iWGhGu
	 JggZ2cDxxKLC3cNUhs5tS+0d45nYDpXq2H8W4EG88yzftXxMxuHXKyiU+q+jtKmOo/HXM71ucLPO
	 ixa4InuXGvlI04vxqj7o+giNFwtEu96BmFCz++YFeYimZdCJVm2wdcpcd3o9sZXwvNXqlBrL6jsZ
	 uqslTnQ0W4P/xvApo4NoBHHi8+o8KZjbbnV8DRWSdpyf702OGqN5yMN54qKpRe+OpJne+xXfPHUP
	 wLOv7W6c1ArcVbvuZIPyYJrAQx3hVbZRcrGG24L1OLbj/1/yCQkj1uKbRALgemk+tpxaMwQq1UOC
	 t/kxfUtA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: jiping huang <huangjiping95@qq.com>
To: vladimir.zapolskiy@linaro.org
Cc: huangjiping95@qq.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org
Subject: Re: [PATCH] clk: Delete redundant logic.
Date: Mon, 26 Aug 2024 22:45:25 +0800
X-OQ-MSGID: <20240826144525.2411-1-huangjiping95@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6cb9d478-ce85-4b07-82be-a5f517654a78@linaro.org>
References: <6cb9d478-ce85-4b07-82be-a5f517654a78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  I'm very sorry, my submitted description may not have expressed it clearly. 
  Actually, it is, the local variable 'best_crent_rate' is only used in line 2355 \
for the judgment 'best_crent_rate!=parent ->rate'. However, if the \
"if (clk_core_can_round (core))" branch condition in line 2306 is true, \
the value of the local variable "best_crent_rate" will be updated by \
"best_crent_rate=req.best_crent_rate;" in line 2319, otherwise it will \
be directly returned in the "else if" branch in line 2325 and the "else" branch \
in line 2329. 
  In summary, it is unnecessary to store the "parent ->rate" value in "best_crent_rate" in line 2301.



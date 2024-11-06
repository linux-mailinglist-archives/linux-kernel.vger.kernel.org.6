Return-Path: <linux-kernel+bounces-397320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458D29BDA67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F074A1F2401B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F289502B1;
	Wed,  6 Nov 2024 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="d2fqNuW7"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148CF9F8;
	Wed,  6 Nov 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853469; cv=none; b=JiNc7sl4sLqTkLV6iMoXdqA+gJaF+Ui4+s7/l84ZIeHoLA2gFvKC+F7bT80EHMqOHAG6HAsTeOQjESKH2wVyn/x51zfb2lPmjSJgFKKzUMzjefGK0S1ns6tuFtKumZMNZznT8FdNRfS0pp9BSiuZM2BsTW+fGUDY+jIpxwJ/We8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853469; c=relaxed/simple;
	bh=AefjFA+IgfWUhG6dpLMRHB3b1Nw1U0ySkL/AGgDnSEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oYGqWWulI5zz/7XiuQHu/5AZ6puBQ88Of1J4LzfI49kyHMLrP8nj3VQxIG20uS++bg0Pc2ytzezh3bbvksGnbC7Rkst0ZE7ejdY5IZ6s0+8Cx9Gu1JD1+jRXSu0crvi+xpCWOK85W2bmHhhxVzhyPyz6P3+aVbOuy8485e36sdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=d2fqNuW7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730853459;
	bh=MEcFU5Iqsgm3U1kleL1AuXyG0d6sZHwbrluDEXSnsOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=d2fqNuW7b4RXmB3s7G5PSJmu0Z6xCG88TD6MYvWYhkjYPejnPRZYYXKLr9d4Gw9rD
	 P2yyInckCQLVw8ri12qNsZKAKnwTz07MOkRhuVsrmEJztJTZ81n+cAkDXagwI7Qnc+
	 TV8HacgBK9b1iyD656HuSIs00K6kuz3Xfjd6TZeDSGcvcR7w3EGozUkAS7cb9cSvr8
	 YmeyNv0cGwo/NOmbeS2UZalwT9pJNcD8v0KmjIako8kMbDlIV8ahDRxPuPBgijJbDl
	 Xp1w0W9Mj9uKu4fwWQ6ibR/pj9iaO/xUBNmyo/cYrkIM8NfrmicA+49mQJxn8FVHk9
	 koqwVmoXXpIzA==
Received: from [127.0.1.1] (ppp118-210-162-114.adl-adc-lon-bras34.tpg.internode.on.net [118.210.162.114])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CF8176B28B;
	Wed,  6 Nov 2024 08:37:35 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com, 
 linux@roeck-us.net, sylv@sylv.io, linux-hwmon@vger.kernel.org, 
 Joel Stanley <joel@jms.id.au>, 
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
In-Reply-To: <20241104092220.2268805-1-naresh.solanki@9elements.com>
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Message-Id: <173085345571.351006.17162436911260710903.b4-ty@codeconstruct.com.au>
Date: Wed, 06 Nov 2024 11:07:35 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Mon, 04 Nov 2024 14:52:14 +0530, Naresh Solanki wrote:
> Document the new compatibles used on IBM SBP1.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>



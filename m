Return-Path: <linux-kernel+bounces-383251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E173E9B18FE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621A4B219AB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B8822611;
	Sat, 26 Oct 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ld7cVQdV"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D2224CC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955699; cv=none; b=Kdx/2MMnYYUW/apWKV/I57wjiHEl1dSH8oQ6y0mPOvPTHE7bKRYEF0W8yOgImWkqkVuw+xQwVvQOqMTJL24DM4ISeFIk4meRUXcVEnmI2g2QWnkNDI1A8lw3t7DTsxBgwSo8ZOtu14garG8TtFDIdE6u+H0TM3QmeiwrH0bAGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955699; c=relaxed/simple;
	bh=w0P8B50YDhNeAxZCS3uLkcN53TEFHX5/IWCK0uYLaR8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lSHxpL2OSH3ZjsK2owWjMFyqtkKliawyjMw3wAGU7MdUJsw/lgiFfv91FDjZCxI49cNpU3K48Cc/jXIJR5f5lanXquo1atnQUlpXY/s+aEmevPoGNEbSM3ntOnKWh8MQ06JPl8NMBxhFeAWuXV+vgy4Loi0az7vg9CtaVJC1I4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ld7cVQdV; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729955694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0P8B50YDhNeAxZCS3uLkcN53TEFHX5/IWCK0uYLaR8=;
	b=ld7cVQdVDta8I5n4JEyuSkCa8N2OT46ugVMyiwAvswQbdfnuF2FUv2Yiv3l6WfyJCpz5hj
	M6wvf3ACLvHNJXtERzNn6qnAZdTlT1jdJts3EjnUGmTL7yoZn/kseqx6GlvOTPINfIloI9
	QRaBzMik7lN4r5biezTT3Fz6coFqtYI=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] net: Use str_yes_no() and str_no_yes() helper
 functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <671d02b9a3601_ac9fd2942c@willemb.c.googlers.com.notmuch>
Date: Sat, 26 Oct 2024 17:14:40 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Gou Hao <gouhao@uniontech.com>,
 Mina Almasry <almasrymina@google.com>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EED2116F-58F5-4409-8732-6A15C364C085@linux.dev>
References: <20241026112946.129310-2-thorsten.blum@linux.dev>
 <671d02b9a3601_ac9fd2942c@willemb.c.googlers.com.notmuch>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 26. Oct 2024, at 16:54, Willem de Bruijn wrote:
> proto->slab : "yes" : "no" would arguably be even easier than the
> current form, and a conversion could similarly use str_yes_no.

Happy to change this and submit a v2.


Return-Path: <linux-kernel+bounces-384553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A359B2BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901D91C21D45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187F7192D64;
	Mon, 28 Oct 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oyIlGhfJ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3C1925A3;
	Mon, 28 Oct 2024 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108412; cv=none; b=cbsrvn3O1byhIOhlg0aDxrjmhzltLdxUrsP686qkqN0PWTNVYqItMwLSaCVa/JlAV/DlP+b9W2SiMntpjcDo6r2MQRjJiTYkCGOA9lCUmDR+hnrJUCLmkGeaFRkaFujBbLFL59zAnQn6K197WwI4siSClDPTxbdOIhgmcUK9iSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108412; c=relaxed/simple;
	bh=O5kz1xCmlBQBdxeByLow7npJLRRLQ5WbRHyKWS0+WF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lByJhzKJ4QiT51QDMWuKFq3XSD9Q8uGeITLvAvMtbx9x2ab0j3SlWIpcsYEj5MsklpACMPfJEhzdPFHG9AAh5x2L/+YjWwpRsVR8oaG5L9XX7B8VfYqgxVCoOWYYPPnuLW6Jq/6zWo4PYZmdcdibaj/k9L+RAccQ1YrHrRB6z+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oyIlGhfJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4811CFF805;
	Mon, 28 Oct 2024 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730108403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUWnLlSRZVzDl17/Xmn95kNcmJVCVGETdPtoa4YwkzQ=;
	b=oyIlGhfJUjZosoDr3gShNqnj3ltRJvKaxhy54XnBVJLf3SqtwOvLhL60/UfW9dv3BW/DwE
	ZB3zVKSNrvvkL+UEtiQzYkNSciVC4hFGciHWsrv7JDANNFize54gO3nny5BNEUIEc71MW4
	UyBhytJY2ddfXR9S8J3BhmvdMULhCo4vexh/GFa5im7hutEGhle8gBJYfrFu5jnJzx1MpZ
	pwiAQTvW1MoxCY1qsZtvlUCAExy3kBowk3VOELHFgxN71DQXN1HdzqciNzPJgp5SZ/Qb7n
	+sqqhIHJvshVqB17c3Zk5ypnC2vNWpVBd2hbuiusmOeGvi4HMSUa1eCfeQtAGQ==
Message-ID: <47d10f3f-3741-4a84-a1a5-8cd03bc22396@bootlin.com>
Date: Mon, 28 Oct 2024 10:40:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: gpib: Fix error handling paths in
 cb_gpib_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dave Penkler <dpenkler@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-staging@lists.linux.dev
References: <459c267de8c9bf48fcb555364930ae7e3cdc798b.1729940596.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <459c267de8c9bf48fcb555364930ae7e3cdc798b.1729940596.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

Hello Christophe,

On 10/26/24 13:03, Christophe JAILLET wrote:
> If cb_gpib_config() fails, 'info' needs to be freed, as already done in the
> remove function.
> 
> While at it, remove a pointless comment related to gpib_attach().
> 
> Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")

The Fixes tag is not correct.
I guess you did a wrong copy-paste as you sent a patch for the CGBC MFD
driver few minutes before :)

Regards,

Thomas


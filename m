Return-Path: <linux-kernel+bounces-545196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F9A4EB65
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCDE8E5DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F0F2E3399;
	Tue,  4 Mar 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZTbOFcm1"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120A2E3387
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109629; cv=pass; b=PtFW2otuX9mMKG+vuA2opOabZRLLPYaTDGVSFQnS8eOFpEQWx+qS/I87+qYgJjLCzqBQdBMawf1i+6wUoSFEt5+JCtXE3FWmOpManNo7BZmRZ8d4CJSixNAzkklnpahawt5E6kSAdcLeoN4sU3Hhjc0cFdMc7DqxEFLSMhWxxCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109629; c=relaxed/simple;
	bh=jowEScGafDqHehCuuxXQ5RRiB4vq3Q0DU122NO345r8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A3zM77F3IorLLwoIfhKJCLRVt4KORR3XQOkC+A5ndroRbN/uPvze3vJb2Xc3PzXNbKjsSfBS1HFvBnZUEMrMirYlU16OAbptfmw+/zhZTSeR2LNEtNKin4pUEleETkXNa4I/eDoa4wnAb4PlxYPygC+5ZU6hrEQuUH7MflYLmbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZTbOFcm1; arc=none smtp.client-ip=217.70.183.200; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 4CAD540CCF26
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:33:46 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=ZTbOFcm1
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h9D5rqczG3hl
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:34:40 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 226374272D; Tue,  4 Mar 2025 19:34:39 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZTbOFcm1
X-Envelope-From: <linux-kernel+bounces-541418-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZTbOFcm1
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id DE8FC42DF4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:47:38 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 71C55305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:47:38 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BD53AF949
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FCE1F874F;
	Mon,  3 Mar 2025 10:43:12 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F81F4281;
	Mon,  3 Mar 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998589; cv=none; b=KFwbEY+kQtzSuYt3sKY11Q05n+O7roDheEOOZPslfWvDV10N/D6yqgUyAA8swN7RW5BprNStu9e0rP6wX65W13bELjXdU8mjGzeWIHC0EDd4P1qN9PdpnTaVYLy+QXtsLqYW9MD3q4OHe8YQKqBsziBl0VbuTHQOnuNV7h+u/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998589; c=relaxed/simple;
	bh=jowEScGafDqHehCuuxXQ5RRiB4vq3Q0DU122NO345r8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vE4h9ZV6a/LfCwug9mW8hWzK9ep21CAMenwzbgSn1JrquIme1UoU7N33iXQOnIiaqK1wWGgYKnUkRrEFUIoutQQLvCKeDNdTF9wFKMplMPGiVRTYgR4/TrA4wldKvotr+hxQ3D91lW0PYCdg/Zs7lZtbm94rTBo05JjhWtkzbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZTbOFcm1; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85D9F4419B;
	Mon,  3 Mar 2025 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740998585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jowEScGafDqHehCuuxXQ5RRiB4vq3Q0DU122NO345r8=;
	b=ZTbOFcm1NXHdDGcFApkbQVn+GvCtY6pHznZmCM/8Fpoza1+dDfDUmHpHWoXfXcn73CYtNz
	AHMEa1NG0lWQlgUao5wKITGBs/mTFO6CSGThHPHwXSzF2tFHcG90iptSiEYE15hoNhcTQg
	ZmDz3AEcStB4ZIBqxO41pPZQ8Hvc8EtEeryqPnl6gYMmOZN8sGND4gQv3IX9M8cK7OdmJ5
	Yip2F0tgDeWDZwtY1/jYiRsym2VbJhJgGholjkEeLmP1L/8orwNOfD1Ures6wK8eIzP1MZ
	B2H3omjy5L8SC7aL3rquCzr8n2clDF2oeOgcb89rFgnEs5EVck2SApYr7xdcyg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-tegra@vger.kernel.org,  linux-mtd@lists.infradead.org,  Jonathan
 Hunter <jonathanh@nvidia.com>,  Lucas Stach <dev@lynxeye.de>,  Richard
 Weinberger <richard@nod.at>,  Stefan Agner <stefan@agner.ch>,  Thierry
 Reding <thierry.reding@gmail.com>,  Vignesh Raghavendra <vigneshr@ti.com>,
  LKML <linux-kernel@vger.kernel.org>,  kernel-janitors@vger.kernel.org,
  Qasim Ijaz <qasdev00@gmail.com>,  Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [PATCH] mtd: rawnand: tegra: Simplify maximum determination in
 tegra_nand_setup_timing()
In-Reply-To: <d564cafe-d45a-40b5-9a91-a2e2b97c80d6@web.de> (Markus Elfring's
	message of "Fri, 28 Feb 2025 19:33:10 +0100")
References: <d564cafe-d45a-40b5-9a91-a2e2b97c80d6@web.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 11:43:04 +0100
Message-ID: <87pliy9yyv.fsf@bootlin.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepofgrrhhkuhhsrdfglhhfrhhinhhgseifvggsrdguvgdprhgtphhtthhopehlihhnuhigqdhtvghgrhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhhhsehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvsehlhihngigvhigvrdguv
 gdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehsthgvfhgrnhesrghgnhgvrhdrtghhpdhrtghpthhtohepthhhihgvrhhrhidrrhgvughinhhgsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h9D5rqczG3hl
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714310.6844@qU+xCZrgSjFo9FE/GYhU8w
X-ITU-MailScanner-SpamCheck: not spam

Hi,

On 28/02/2025 at 19:33:10 +01, Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 28 Feb 2025 19:19:45 +0100
>
> Reduce nested max() calls by a single max3() call in this
> function implementation.
>
> The source code was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I am sorry, I do not see what gets simplified. max(max(a,b),max(c,d))
looks simpler than max3(a,b,max(c,d)). Does it bring something in terms
of optimization?

Thanks,
Miqu=C3=A8l



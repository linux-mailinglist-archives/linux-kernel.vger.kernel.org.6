Return-Path: <linux-kernel+bounces-545348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF37A4EBE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA62162787
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFED6280401;
	Tue,  4 Mar 2025 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V8rOERi1"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9541E505
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112685; cv=pass; b=UMs+YahKSV/zjkf52x9VHCmGXp0I28wpNZiqUXakgMpWkBsw4ZMphvwztlkqWF+Ppscp6bFJ3bi5O1qxwGkMct12+sL7oKCZmT/SAKwbU7H0Ne1ZHmuggvLlDNfCH/FU71aossvkpmjQDfnp/P9GLDLw7BYGSM8znv/Gv54gdfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112685; c=relaxed/simple;
	bh=KuJNrgV0L41NqM51p8r18I1mt8rIt7jB62RLFcUV8bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OoGQyKoTXTTcIWQrvXItTfnJolqXs7D1gl41Y+pembaQHVaX7cF7QuGCuCasjDHTlh7rwptL0oimKLs09SDGyQCtmB/KHce5XVmh8dISyqHmFslVamhlZYPWe0Y+irA+2D2uDLEmb0GRVxnaPpE/6ICz7uy7dYn3wAzOuF59LjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V8rOERi1; arc=none smtp.client-ip=217.70.183.193; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id D913940CECAC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:24:41 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=V8rOERi1
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f9b2pbLzFyK9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:04:51 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 407624275B; Tue,  4 Mar 2025 18:04:36 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V8rOERi1
X-Envelope-From: <linux-kernel+bounces-541491-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V8rOERi1
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 4F0EA41B6A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:11:19 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id D777B305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:11:18 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DC13BB622
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917341F4162;
	Mon,  3 Mar 2025 11:04:07 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0261F0E28;
	Mon,  3 Mar 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999844; cv=none; b=ks2U9uh5Pr2VusfBhIl8C9TV6zFgpDZ4J6g8hV69t+AbTgxi5ejsI01qj0cTmeJJ8+gbNFZ36BIYdCBJpgl4B1yGMK41zNTA5jQYmje8Y1o+Dne05w23MLqleVvJm56ZNFH6dlo6tFn2QlueC0zR74gf757/s7zr/IKuGAK1DtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999844; c=relaxed/simple;
	bh=KuJNrgV0L41NqM51p8r18I1mt8rIt7jB62RLFcUV8bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bFHHFPJWqrJzjMlCK497H9vCT3WnDso7Tvi3qD9lxfnuQ2wUiEEgyrmSa69UeWGcwNS2wLSSfyxCRxZNm7PNk+LiP6OV+B23CUT6fap//3Fv7mCy1U0hjWCxxyKFu193stZ2hbv49UW0UrhpYQCNxWOmCWi6mcnHcmzAOzvUT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V8rOERi1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6DF9442A0;
	Mon,  3 Mar 2025 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740999836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYg0OhYtGacV1+2euRFkrodD8aiR3ZlFwLFtEbH5bs4=;
	b=V8rOERi1COiXtad2VjJsc+kUj6Z6y0+6M3Z8Aca8oFl51RYAgTUurp8mL0bv5hRvcjIr7m
	qg39TNohItoSwlghPft2YRClrT0x6wBCJRl1A3C2dzF5wliEbC66pUfGzWjKaScV5sDy0a
	r00HZwBNkvTlDKdDhJUqyrr5sFGQUWErqyHpwkkDOC7SvkcH/ZiTIqqURZwdYZ2QvRXxyC
	QGA32FNXcv5XcpWeSE4mME5PIq+XBUKqUhu7C6GeVYgANuYgqCIgph3PvEE4iImy5yUbnd
	MIXeIv/foWBijvuAYDjB/VTcmba/48RTmFzVawX1rfT6eXdxC6ipw2gNY+fh4A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-tegra@vger.kernel.org,  linux-mtd@lists.infradead.org,  Jonathan
 Hunter <jonathanh@nvidia.com>,  Lucas Stach <dev@lynxeye.de>,  Richard
 Weinberger <richard@nod.at>,  Stefan Agner <stefan@agner.ch>,  Thierry
 Reding <thierry.reding@gmail.com>,  Vignesh Raghavendra <vigneshr@ti.com>,
  LKML <linux-kernel@vger.kernel.org>,  kernel-janitors@vger.kernel.org,
  Qasim Ijaz <qasdev00@gmail.com>,  Natalie Vock <natalie.vock@gmx.de>
Subject: Re: mtd: rawnand: tegra: Simplify maximum determination in
 tegra_nand_setup_timing()
In-Reply-To: <0193ac44-e858-4aff-a50f-dd95dbf3de5b@web.de> (Markus Elfring's
	message of "Mon, 3 Mar 2025 11:55:49 +0100")
References: <d564cafe-d45a-40b5-9a91-a2e2b97c80d6@web.de>
	<87pliy9yyv.fsf@bootlin.com>
	<0193ac44-e858-4aff-a50f-dd95dbf3de5b@web.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 12:03:55 +0100
Message-ID: <87h64a9y04.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteehkeelvddvheehtdefkedtjeeutedthfegudekgeefleetkeettdekiefftdeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepofgrrhhkuhhsrdfglhhfrhhinhhgseifvggsrdguvgdprhgtphhtthhopehlihhnuhigqdhtvghgrhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhhhsehnvhhiughirgdrtghomhdpr
 hgtphhtthhopeguvghvsehlhihngigvhigvrdguvgdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehsthgvfhgrnhesrghgnhgvrhdrtghhpdhrtghpthhtohepthhhihgvrhhrhidrrhgvughinhhgsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f9b2pbLzFyK9
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717391.13236@IrseCGhWWJh/dHcY92jy7g
X-ITU-MailScanner-SpamCheck: not spam

On 03/03/2025 at 11:55:49 +01, Markus Elfring <Markus.Elfring@web.de> wrote:

>> I am sorry, I do not see what gets simplified. max(max(a,b),max(c,d))
>> looks simpler than max3(a,b,max(c,d)).
>
> You would eventually like to express that a maximum should be determined
> from three (or even four?) values.

If there was a max4(), why not, but in this case I don't see the point.

> https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/minmax.h#=
L147
>
>
>>                                        Does it bring something in terms
>> of optimization?
> Corresponding effects depend on various factors, don't they?

Ok, so I'll assume the answer to my question is "no".

Thanks,
Miqu=C3=A8l



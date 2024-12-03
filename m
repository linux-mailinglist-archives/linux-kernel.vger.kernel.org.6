Return-Path: <linux-kernel+bounces-429748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326EF9E2327
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EA11690E3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D24E1F75BC;
	Tue,  3 Dec 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Py3QnBBB"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103B1F7071;
	Tue,  3 Dec 2024 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239710; cv=none; b=ctwWWEnRusqpHup6B88WBi28c1W+/z02f4IAqFokE5xTdiUPCzBkcg2bmaJykCFV3uDxaamG2tET+SEP2rt/+HRb1HdhVin3RdLPn/gMFdICairg0woqlgsLnZ6GkK13SEWTyxZnTgG1iVe/FvaPWkQIe9DvADZawUvmaa2e4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239710; c=relaxed/simple;
	bh=yok0CnVrrPPSOiyrfpKdpYMJygt5us6/tJvXQKL2riA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jj3ohOzmWxgymQIeyZCJ7VrDX4jtOU84LMd/4eg0/nL5ECqsARz5in0gYnmGPvzLalibUXfqEGoMSeD6a6/lpRHqNtbMxvs0Z8xzMPoBVupf6Ep5UJkC0qprrPhezxcjl9ATe4KaaVb+ieLLxO5Tg2UZKt1X32+DZDjDNIM05wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Py3QnBBB; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id 2E8A4100686;
	Tue,  3 Dec 2024 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733239706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXfavICdX0pf2jCBeS7KQ/6j01OzZdPaFIC1TGwGLIQ=;
	b=Py3QnBBBNisP8uGRDmzVosE2MOwtzfELAF4PyXfLM9+Ou6W57lxU3hdwiVxZRwCQ3mWx3U
	bv2DHT7/FLF9xty9APbNlVl8/l8vGEHqHNVxu0zAq8AUZydK6HKcMANhuLa5dbDfLR2/QR
	HsRfNEAp6cx/wbmeETgNfjLpSpCz0wA=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 8A20E1005E7;
	Tue,  3 Dec 2024 15:28:25 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 16:28:25 +0100
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: frank-w@public-files.de, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 13/18] arm64: dts: mediatek: mt7988: add i2c to bpi-r4
 board
In-Reply-To: <f47f08c0-0fb4-4826-9b25-1277cabe4bb6@collabora.com>
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-14-linux@fw-web.de>
 <1ad355df-3f2a-4257-9374-1d125e138791@collabora.com>
 <CA7E06EB-D26A-45D0-BF13-9C6B640F27A0@public-files.de>
 <f47f08c0-0fb4-4826-9b25-1277cabe4bb6@collabora.com>
Message-ID: <b12e215af5aa5b6bb2fadbeda1117c94@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 811d2679-12ba-4194-b5ef-2c8c75dd7bf2

Am 2024-12-03 15:22, schrieb AngeloGioacchino Del Regno:
> Il 03/12/24 11:58, Frank Wunderlich ha scritto:
>> Am 3. Dezember 2024 10:40:38 MEZ schrieb AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>:
>>> Il 02/12/24 13:25, Frank Wunderlich ha scritto:
>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>> 
>>>> Add basic i2c nodes to bananapi R4 board.
>>>> 
>>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> 
>>> arm64: dts: mediatek: mt7988a-bpi-r4: Enable I2C controllers
>>> 
>>> Enable the I2C0, I2C2 controllers found on the BananaPi R4 board; 
>>> these
>>> controllers are accessible at ... I don't know, a header on the 
>>> board?
>> 
>> These 2 i2c have directly connected spare devices (pmic on i2c0 and 
>> i2c-mux on i2c2 added in later commits to have it a bit cleaner). I2c1 
>> is on gpio header which i have not added to let user choose if he 
>> wants i2c option or gpio. I can also add i2c1 to r4 board with the 
>> right pinctrl but imho it should be disabled to have gpio function 
>> default.
> 
> And again, you should really add all that information to the commit 
> description,
> as that not only helps me to review your submission, but also helps 
> other people
> checking the commit history....!

this ine i would rephrase like this

     arm64: dts: mediatek: mt7988a-bpi-r4: Enable I2C controllers

     Enable the I2C0, I2C2 controllers found on the BananaPi R4 board.
     Both controllers are not accessible from user and having fixed spare
     devices. I2C0 have a pmic connected, I2C2 is used with 
I2C-multiplexer
     for e.g. SFP cages.
     The missing I2C1 is connected to GPIO header which can have either 
GPIO
     mode or I2C mode.


> Cheers
> 
>> 
>>> After which,
>>> 
>>> Reviewed-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> 
>>> 
>> 
>> 
>> regards Frank


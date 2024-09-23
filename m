Return-Path: <linux-kernel+bounces-335342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B977497E458
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 02:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E141C2101B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED3F2114;
	Mon, 23 Sep 2024 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PwssHF88"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE17E1;
	Mon, 23 Sep 2024 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727051159; cv=none; b=JLWrpv/vVtYdwbxQvEAOPUP03n/FSz1/Rh5Q1404s7l+1tPSpFbfUidDFnrddChLZ3uiuacVRt0M5kmW6e1aUkESyG0Ikopj8WIsV6HKEseyF9p6opKbu5Lv4+PGZPEWZMFNfF7c4nBgnk7U3cdDB42D5mwBOTk5aQ9oqXM9bTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727051159; c=relaxed/simple;
	bh=EqIOqMFVWAdgY7Eswhw2ekPnu8NutI6yqpcFgdPVAmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lHAMMYBx1iYE5V7pdqSW+XsvRTo0v0X1Xm4QfyTAeUBzxkHqfXfDwy8bsULGCAW55RFk5UN6pZp15/0FgNJPx1fAu7ClePBI8ShRnsiT5JrtNyrAdTbf7fVwmEKJiJXIV1+BNnrAbRbp/12ZGS0X2rE1+3sd98vEMrqlj4GdPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PwssHF88; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727051148;
	bh=m2ylV1fvmSR+GVeWeCt0MzBDC2hyi/nxrjXhTegZx/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PwssHF88v24UVY7WeXED4544VQEhvdPzUtxoEPeYJFX0W7RLUsFiup1FXtDCo7cYk
	 IzyUW03mwQhYOjk4Zsl85wL+Wx6uiCp4H+yMmcmnXFgITHwh1sweJpLI1BK53SeHS9
	 Eu060sHr6HGLu1EtgIBFZjnrbjOw6X3Jb8xmCVYMydYkFrQCyLlgyOzE52o1eLSET/
	 l3ZReIG5gxsgicY/BDIn9YFr6fhKpUBjlACHBZ8xUqsDVdC6LzWflxI7f6x7+jvKxq
	 +U9FulKP1t10G0ifPtjTMTM6bEoMVHX8N4t4bdl0yTzB3ZNRjfcRRjzF7ct3nYVhvy
	 cyKFYdssQI2Aw==
Received: from [127.0.1.1] (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id ECF8B640E8;
	Mon, 23 Sep 2024 08:25:45 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20240920-catalina-i2c-mux-fix-2-v1-1-66cce7c54188@gmail.com>
References: <20240920-catalina-i2c-mux-fix-2-v1-1-66cce7c54188@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: catalina: add
 i2c-mux-idle-disconnect to all mux
Message-Id: <172705114554.52616.12455513368806035629.b4-ty@codeconstruct.com.au>
Date: Mon, 23 Sep 2024 09:55:45 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Fri, 20 Sep 2024 17:55:52 +0800, Potin Lai wrote:
> Add the `i2c-mux-idle-disconnect` property to all i2c-mux nodes to
> ensure proper behavior when switching between multiple I2C buses.
> This avoids potential confusion caused by device addresses appearing on
> multiple buses when they are not actively selected.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>



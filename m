Return-Path: <linux-kernel+bounces-346894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D369798CA6D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116031C21FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BFD1FBA;
	Wed,  2 Oct 2024 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Hw0Oovjq"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52A7464;
	Wed,  2 Oct 2024 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831484; cv=none; b=CNTIse5J7q7tSv99wg6t4LN3fIN3VcL5rrTIjWJMDWwusrnY+lv7abGggjVS9EzB/K3yp0PIG5qQSMmR97hmDiesYWvF2/ptaWCXAHGnVXgJ3h7yVjaPht757BN/GI2Rsysa1hpfqUYZekKBP6VMBorpeEpqnF1zkbFXNrY3DG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831484; c=relaxed/simple;
	bh=/l4+KJ7NAMBI5KWjS1YDptySs4gbOG5POc0GGMCNczM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QxIREonwcBCEh7A7TyhFf1apQ2Us53Pq1ZXsnx265pzRDv0oeopk7BrI/vDGQs+llFyGhEgJvh3b6wzSoR0ryTo1pS9aBvFRUm+mDtv6lESvlEnkAITM+Vscdaiz9Tg75NcDwwjyyJnsfbfdyQR48CdwJXUZp4lSP0Q++DuPEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Hw0Oovjq; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727831473;
	bh=R7ianpyjVN3B1nD5oOZXXzjVfCLquaxvQ92VdRcmNZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Hw0Oovjq0FhlSpSOKhxl4cXMyqH92tBOl/m3qKdMddaW7fbXFxpcbCFss8aoVWxlE
	 S9HRupTwKJKjTtM73/QkKEfji1bD6N90DEvHz3gFVSgL8pnAvEfW/rNIYnCFs9IqGd
	 q0lZj9qrKg9w6uIB8CDZLHNPgn+tS+B5XIJh+WgpVq6M6tH5zKocn2fdVncwr/ZKr3
	 BuZVCKbPye7cU8pdcVTj/mnRIidksgcKtatbrsogkO+NRzy/DnNFCg3Qfh35vYmH31
	 1A49NhzpqXzLWMfD8jWL/bJZJx1KxxZOsUy8cS2WmLXsVWk3q9n7Hui8mmBcgOb/IF
	 0Psvf49wypxiA==
Received: from [127.0.1.1] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 800C165013;
	Wed,  2 Oct 2024 09:11:11 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001083021.3462426-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241001083021.3462426-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Remove IO expanders on
 I2C bus 13
Message-Id: <172783147141.796785.17563061044470770294.b4-ty@codeconstruct.com.au>
Date: Wed, 02 Oct 2024 10:41:11 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 01 Oct 2024 16:30:21 +0800, Delphine CC Chiu wrote:
> Remove IO expanders on I2C bus 13 according to schematic change.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>



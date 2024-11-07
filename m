Return-Path: <linux-kernel+bounces-400784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1D79C1263
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6DD285C8E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E5219C8C;
	Thu,  7 Nov 2024 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MOSEdpym"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82B218923;
	Thu,  7 Nov 2024 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022091; cv=none; b=qt0Sud9LQ9f1Niwcq7LPbJfH1lre5vjN5qeo2l29xRV/xAoruidienXqIdSAykV0K06PMbospIHpax+cEG4Jg9TCVOlXBuxX9o75/kKzchXWAkJ1NSiAlGWK5zW4TWihRisPXS/J8dktJKCnOiWeld6X6xGYiQSv/BM7l2hzknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022091; c=relaxed/simple;
	bh=a5ikBA8m6NC2D33iJzAqhIz0i20CmVHm+nEPdvTry1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UgeDye/zHthMlztQYQkPsycbJyGW15BLf9K7LNqkj4g5u9mSrinJ4Ej4JDAvCFTsjeO5aZDBdQ+GlZwUtbdqpMhcIlC/OvDBS9aqYNTdZogBdBY8/DSn1PwHx++QlwdNWZItdl1YrVZq6uks4A1BIR4jpgHuf9NUw2+bfXgK+Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MOSEdpym; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731022087;
	bh=ZJ40w8yoexDu5E/YyKd7BvJVrxVO/pnmp4Ow30xeJfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MOSEdpym3cSejj1E/WLUhFEjkDRfBaivraKLu6SIkw2ly59Jk9vd2lcwz5WfiesyI
	 kgXCVOJWS3wuABPftJ5IP6dzHu++1hOo0jozIOHjCOXRyEhOH9nCg+Z+020e3Oz6iI
	 rvxAQiwdowwjbzpc2mQZBIFBtDRoQHl+YQcW7pOwfoPLPickUcc/Jjh1fSo6a5PAKq
	 SwZ25Si9mle0xl2cXhOFgPEyvEvzGA0e0WR9nUXrCsIKcP6B9G2ueS+8oJB4F7IPGU
	 1Vi/csvgnVJ9olAruS/HdZPSNK39RBxQ8+l1Oq+HU6Xt36Roi1JJh1H7d6Bix45MEj
	 MXYhWH/Q9OXHA==
Received: from [127.0.1.1] (ppp118-210-167-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.167.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7CAD16B9FA;
	Fri,  8 Nov 2024 07:28:05 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241107151431.1045102-1-eajames@linux.ibm.com>
References: <20241107151431.1045102-1-eajames@linux.ibm.com>
Subject: Re: [PATCH] arm: dts: aspeed: Blueridge and Fuji: Fix LED node
 names
Message-Id: <173102208534.28952.3883977704243650358.b4-ty@codeconstruct.com.au>
Date: Fri, 08 Nov 2024 09:58:05 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Thu, 07 Nov 2024 09:14:31 -0600, Eddie James wrote:
> The addressing on PCA LED nodes should be in hexadecimal, not
> decimal.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>



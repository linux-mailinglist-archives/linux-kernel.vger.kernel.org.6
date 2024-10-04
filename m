Return-Path: <linux-kernel+bounces-349795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4098FBA4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E854CB22220
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439991D5AA5;
	Fri,  4 Oct 2024 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fUV/0nbq"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403617C9;
	Fri,  4 Oct 2024 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002390; cv=none; b=hst/BEgrkmlRRJN42BNpiBMF0lWtjgLaODUgljhRZhiDowZx55Un+fYTFmFCi5oprLVs8AqXzhbZ4R6o7bjDxrja8OazdJps7glCmfBR0AnYKKRxFVH4f6wfeLBrZUIRFuNNaw+DMGKQMsTlW1MWAsIe2ZUQkiz8AldLFsAjfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002390; c=relaxed/simple;
	bh=3drSta6plRTZrIEGdBYGg0j5Q/K9PwFk3FzL0iCczNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QMVcXmP1pG6AEWK8Dxu4EWLeZBOd6Nz6GqfMmVvm0pGVD23w8vdVfraf9c9J2LdzU8je4/wHCqLDNVOz5eNeG9GxTvjFr9AZ3EbCzon42hL8P/hCqdlYZ4AYdcE5Zdf7qygMWu3xZUarRE8qRqvSGML64IMos2TmF0K9ZtujJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fUV/0nbq; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1728002379;
	bh=fgqfWcf//PfvrUPXmMD6/c14iNKvBJ71j3hHyMRQopY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fUV/0nbqcYaX1gZ6wxy3i9O+e43vTx7HlT4Hi8QHQPB1sEHom2b/md0AJKJwfF0tB
	 8rikvHjTDlljkhvxsSVN+1ap4YG9JnRBjkeUMfiZSpRASy+IuHGVYQH7iPNyA7lt5Q
	 1yHIEPwkPCNg4k2qwdUN+TYEcdPCneiQi4buAof8hEi+/ZLeZYPJ6n7exTXym/kkZT
	 Z2T/3DK6FmVvfCkZTp64cxxR2od6kcsIgNq/E15il/LQcDC3mZf1NXeuuIIfuCoto3
	 6mfqEW1K7G98mICOtNxxRnLvr59RW5TRBl3GpWler8UiibJDobbf/10szvkhoB6Sb0
	 c8XXvQCh3zOIw==
Received: from [127.0.1.1] (ppp118-210-174-36.adl-adc-lon-bras34.tpg.internode.on.net [118.210.174.36])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B33CE64BDC;
	Fri,  4 Oct 2024 08:39:36 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v3 0/9] Add I2C mux devices for yosemite4
Message-Id: <172800237675.81323.9277417561111727144.b4-ty@codeconstruct.com.au>
Date: Fri, 04 Oct 2024 10:09:36 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Thu, 03 Oct 2024 15:42:41 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> - v3
>  - Merge the remove mctp property patch to patch 02.
>  - Order the patch to correct compatible string of max31790 before patch
>    06.
> - v2
>  - Remove mctp property on I2C Bus 15.
>  - Add required properties for IOE on fan boards.
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>



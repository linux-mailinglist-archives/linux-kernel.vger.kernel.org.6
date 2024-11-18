Return-Path: <linux-kernel+bounces-412296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3909D0739
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDCA1F219F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 00:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB11139D;
	Mon, 18 Nov 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="D0YsSmzh"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8338B;
	Mon, 18 Nov 2024 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731888765; cv=none; b=OHg35JmCfwg2wpPhc/2/Xe70QbaN8S4bgLeO/NxvkUloH01qQSwppgTdMKvulXs9gAZ1EJF1bz3ixVEVMG1v/J1wPcWt3hpnlnVZY7n1wwVQa+qFqrVq7ndA1fpii3LucFaM5UD8XLJutmFEvztt72OtSDFx3FQcE279BBlOyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731888765; c=relaxed/simple;
	bh=CxbIkIRDUTFB6TvCqFZ4TKh00IZg2USzkP0odthd6h8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DHtxXeQV0P3qqSsdPSHrRFg7zmXCXxK6LpKl53z3YhaZCoWrCez4kQNYzB9EAmIL4VERRaSXgpOCq9MCJgLxILJW40Ns5R8/OIUEeqKNvMNKEB2gRLgVKmdAJNff3pt36rBxhKL5Vmft1xJExwFM7Z+wkMihCwk1Evb/bMA1i5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=D0YsSmzh; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731888754;
	bh=lB3rlRLKTOOVAVSWBuHAcyZgBv2WqxsLN/5q+wlDRHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=D0YsSmzhuneD2/YXxuFfsBSJGvvThF5tlHvNwSyuiTJhE/WL+D3jng9ibaYsMirtW
	 6f2jGSWeFg5Vr63flpDTVJ018C+EmQh5eFMCo7qVI3rZd07VZq4jY/7hO/2DhkTH1g
	 wLzm09ObOZ0GQwyK5BwEoQY7o7kZoXgNp6yLea2ZH5fgHlmra8lldBZ8BcZhisZ6sq
	 7qTROwhTZKO5ORygntXw+ed+npPNAvYVcryGfD5+EcYt60q+9ynBBQN/XzRSwKTs9t
	 ovQhWGgO+U3HtwFze0JrFuyH5RnCYiCt1l8Co0s8m1DgF6jooke3C9Keoxv0BnWqK+
	 IvCUL7Cm2nDqA==
Received: from [127.0.1.1] (58-7-148-107.dyn.iinet.net.au [58.7.148.107])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4CE276625E;
	Mon, 18 Nov 2024 08:12:33 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241115222721.1564735-1-eajames@linux.ibm.com>
References: <20241115222721.1564735-1-eajames@linux.ibm.com>
Subject: Re: [PATCH v2] arm: dts: aspeed: Blueridge and Rainer: Add VRM
 presence GPIOs
Message-Id: <173188875323.217268.13798052651518745663.b4-ty@codeconstruct.com.au>
Date: Mon, 18 Nov 2024 10:42:33 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Fri, 15 Nov 2024 16:27:21 -0600, Eddie James wrote:
> Add GPIO line names to the GPIO expander to describe DCM and
> VRM presence detection lines.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>



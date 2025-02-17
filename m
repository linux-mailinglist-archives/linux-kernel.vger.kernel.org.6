Return-Path: <linux-kernel+bounces-516874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED28A37921
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F421F16CA27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61217DDAD;
	Mon, 17 Feb 2025 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FfU3qebS"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335551C36;
	Mon, 17 Feb 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739751023; cv=none; b=JGqhTHrDEw8YfCYruZyyzg5KwiHQT/+nSwQFnVJVgKV0Lxsod64UXLYt3lisbQItSd8r+gAWxDvfg1JsW8LnIGr/xXb/CDl2f2oEOqtXyyp3RTmQUc7BKO3p/+2wSZ94HPKwmNTei9yzIHh53+K1k8f52VcHOUplSvNzdBdMgvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739751023; c=relaxed/simple;
	bh=hUfcodhA/M2POha2V37GKzU6bKlv4j9t6vOc7/H2LlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GpNHHKeTDEPuOmjoQWe2W1J+LJtPYd3fwHbyMABIhmdiV91U+HfCC0QoloE7s5OuPmHA9DT9FvD3NKJRXTDtqTt7TmplocPm0nKuHl5LPc7jcumJIKQdSmuN3tEfciyR06V6DO/qeR3uBCK4piomMDOEWENUvCbYxzFCtRx/tlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FfU3qebS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739751013;
	bh=JcU/Mrdr18cGs3dTnCLq4um8s+90+rSXo/XjDVljqqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FfU3qebSurQNgcxzYBYi8q46USfa5cym7WWDYWfYGlOG+JJkETsZRLR5jcu7jDH+Z
	 VXszDdoBHfNr9qcdQGZVmwlHuy/EHjbLACc06SRFlOWNrDOvbXuR1Qk1FNrdUkizKL
	 ef8/noP7BTqMblsLm3qEnKxNkoOvVv0uZNGwyL8pQtig/RUUK7391c8bwuQO4UEHy5
	 LQWGMzlQiCc2L2WMms7mGCGX5ryTXMKnI0boqITdXMqjv5oBD9PcaS3mjWu64VSvCV
	 LX6qMGvh/EYLaRvLLV1DKBIk5AfPmvRl9VOWnG2H2ybmHzoZdvg1ZL7yOyXIAz+u8o
	 2FKb+V+lCD7TA==
Received: from [127.0.1.1] (ppp118-210-174-88.adl-adc-lon-bras34.tpg.internode.on.net [118.210.174.88])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C910C72F1E;
	Mon, 17 Feb 2025 08:10:09 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20250213-bletchley-dts-fix-v1-1-c953315eb894@gmail.com>
References: <20250213-bletchley-dts-fix-v1-1-c953315eb894@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: bletchley: remove unused
 ethernet-phy node
Message-Id: <173975100971.56771.12087846830640085961.b4-ty@codeconstruct.com.au>
Date: Mon, 17 Feb 2025 10:40:09 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 13 Feb 2025 15:12:58 +0800, Potin Lai wrote:
> Remove the unused `ethernet-phy` node and the `phy-handle` property
> from the Bletchley device tree. This fixes warnings reported by the
> kernel DTB checks.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>



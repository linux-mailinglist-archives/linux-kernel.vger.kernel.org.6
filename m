Return-Path: <linux-kernel+bounces-317269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8F96DBBA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB351C236FE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F87F19D06B;
	Thu,  5 Sep 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="iXl7jMKh"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7B1D551;
	Thu,  5 Sep 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546375; cv=none; b=PLg919CVBPbRbZqbQqNAVD2pzb9YV3OZhyQLmRlEvi49bSLx54DM3KK5nPKjym+3uLQ6jCPsl5uAiMyvLsmcMhUPCkD+naSmv40MMwhwigRYL9PVCzNSBcNbJ8g57il8DwSMOULIrDxQcST9X9HOixOxNbp3f14fWIkr3q6+DdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546375; c=relaxed/simple;
	bh=mQD2mFfNuZhHKI/T+P7yQlscPdXQiqObJ1h4qf2fLO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2kESbe68JrRAEI5I6C367qTkrusW+VuvdtT5y7ue6eKFidQm9RZ9DIWfkxV0npFsw02BGHQawAyoKIxO25r2bIDunnqj/sc9kAsm7XLbpa5OUbAo04JpzLv6LTO9CAhZvG2XVYOI1Fmhp6gK47Cf6J/jscYf6NM3X0VYEsP1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=iXl7jMKh; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id BAAAE1F9E3;
	Thu,  5 Sep 2024 16:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725546360;
	bh=0zf2HoKYznFnphkWJAchIZMm+w2OxCvnYqzP6Cz+V+c=; h=From:To:Subject;
	b=iXl7jMKhgJxHRrEeIfX4vCFRRDQ/vkO/ExDPxPjNHnJQVr1zdQ95rg3IANHEn8Hz7
	 e3prQ4J0b1h/8u63AI72R/2K8broI6qkDXt3uIiNxtvi2lZTsLx52lc5FybMXi9Tn7
	 eDTZNPBmYAqqoleAZK9HksM2mghr9wqmvtu7/k2J2Yn3KXWx9eqF2bx81w0Xi9SVra
	 KXkjry3GVT5ynQjPDhUnOnnHGU8LRE8197IaivmugeUsvgLaFK3w+WlFbAM1dO749c
	 4+95ao9XjaBzoyb6ePk1Fb8hOU/kq6nKqFmDdTR2RrshUYopQAfAh9c1FFJN84nFeD
	 8g+iSn7sp9dSw==
Date: Thu, 5 Sep 2024 16:25:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Parth Pancholi <parth105105@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Parth Pancholi <parth.pancholi@toradex.com>
Subject: Re: [PATCH v2] usb: typec: tcpci: support edge irq
Message-ID: <20240905142554.GA40671@francesco-nb>
References: <20240905065328.7116-1-parth105105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905065328.7116-1-parth105105@gmail.com>

On Thu, Sep 05, 2024 at 08:53:28AM +0200, Parth Pancholi wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> TCPCI USB PHY - PTN5110 could be used with SOCs that only support
> the edge-triggered GPIO interrupts such as TI's K3 device AM69.
> Move the interrupt configuration to the firmware which would
> allow to accommodate edge triggered interrupts for such SOCs.
> In order to support the edge interrupts, register irq line in advance
> and keep track of occurrence during port registering.
> 
> When the edge interrupts are used, it is observed that some of the
> interrupts are missed when tcpci_irq() is serving the current
> interrupt. Therefore, check the status register at the end of
> tcpci_irq() and re-run the function if the status is not clear
> i.e. pending interrupt.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>



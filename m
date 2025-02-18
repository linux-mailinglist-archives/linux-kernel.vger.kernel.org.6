Return-Path: <linux-kernel+bounces-520332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E4A3A8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146273A58DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78DA1BCA05;
	Tue, 18 Feb 2025 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ojJkG+AC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F71B85CC;
	Tue, 18 Feb 2025 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910279; cv=none; b=XYUrFKyUES2Mk9qEwQk4X1vHB3mkPrSzEuJsT7daHODlk624v6CvIVzg4UTO6SXV4NrUH7Dg6TUDc3eaGwGF17Q/6+P+yf5kfJgh2O2z02WXpi9pem5agAZQaFkYZRuM/KmgT11GT7peeEZXqd0YJimHP2mqKo+wHpBsxfborvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910279; c=relaxed/simple;
	bh=4DkPl/uIKWli6sVtAuJSieBXxIdn9s6IGRaS2Pr9ilM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OICD8K0sS1dOoDbajcuVGXvL1nLXPnwtLyLQezKuikXnxdB+/FW4nMnqqv6hZ0Fut/xZtw8Pjl58SGl3Unej+6MOGXiOf6utZ/MHUYkZB8r5IFv4XYYsRylQwHx486uGT1jy8Ajl16vGgODQszrEvMCOsOQ/OT/LCIKmJ2KcUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ojJkG+AC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 52511411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739910276; bh=ybkMF4J/vHwO4z2dt7srdkkRKShhkd5wEGE0vV1SgEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ojJkG+ACpvQ/kuXxSMeCbR/PvjoclHReIf6Y6dPCwa7erzzJ8ZgGeOY6jROB/Yc2v
	 YgtQf7A2u6DkKokLa3ZiIeM3Hu/aAsvJpL/2GwfbcpHHYZOqi11Y9PVKKjHdIYOqq+
	 Dx+Yv9Yn1G3WYSShpLbZPq3vbmYT+oCavpuhtQneV7m3TlUtee7UNvBkBTdMGN3DkG
	 wGc71yY91sGYtuDI8bdijchRg/DWZndFJSR0vm2YZ10QWxdSBTvGUpvmIcg0EgP9HX
	 wCIKHRZNbEBtYDbUrvVQx26OZVtJNJtZOB7x/10NHkPwSKtoaSHx8E7mFepm1lPGX5
	 XCEj2VTt6mbFA==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 52511411AF;
	Tue, 18 Feb 2025 20:24:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Carlos Bilbao
 <carlos.bilbao@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-docs: Add book to process/kernel-docs.rst
In-Reply-To: <20250218154303.45595-1-lorenzo.stoakes@oracle.com>
References: <20250218154303.45595-1-lorenzo.stoakes@oracle.com>
Date: Tue, 18 Feb 2025 13:24:35 -0700
Message-ID: <87y0y3ngqk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:

> Add a reference to my new book, The Linux Memory Manager, an in-depth
> exploration of the memory management subsystem, to
> process/kernel-docs.rst.
>
> This is not yet published, but the full draft is available on pre-order, so
> it seems worthwhile adding it here. The situation is made clear in the
> 'notes' section.
>
> The 'pre-release' was made available in February 2025, and full release is
> scheduled for Fall 2025. The book's ISBN-13 is 978-1718504462.
>
> The document will be updated upon release to reflect this.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  Documentation/process/kernel-docs.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied, thanks.

jon


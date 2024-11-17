Return-Path: <linux-kernel+bounces-412093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1026A9D03CB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB49283E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E1F1B6D11;
	Sun, 17 Nov 2024 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gW/hKWPh"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2451AF0A7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846339; cv=none; b=afomPL6/IpQj2Tyartu9kVmINOAZWeea60JV2AT91+9HN7bRuwMX/klqywmedLjwcCapV3fEpKlrXTmuYGQxI/HUstyy4ErPQKsZmN+ctTbtw8IzVFoxnMQrPl8Odzkic776YLJJdZDb/O72+ey2fU9bv3qemCu8pWq8ktAU/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846339; c=relaxed/simple;
	bh=z/41GgIytr4H4y905ZNreu3d3owANLggyKF1uvAiCA8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mN35JmW09pKZGffc3BMQiLdgg9f/qkkQCFDmzEsYPZf2rYsjewwgh+iAaAXGJj3PzRkGNY8lHZe8h8SKhzBmn+MPkhzkLIx3l2//JT1hy7oKXBxfeTk9c/ocwnMhWIcXnRcbL7CX4izKnFodXbP4g8Ltelb96eF8k3C43HujSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=gW/hKWPh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846335;
	bh=lnPr1gxISBwEUZN23AJ5943nhoG6g13BacvcbTslP1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gW/hKWPhHry/Zusk66iROtpVWKhPKwFNTJncapCHs2oTrLTCts23RyYuiLV97optV
	 qRlA6qdKxSqBSWTt2uRZ5mncVMSmkZErKRslHbnJbHEAspqUJPomPHeENWvLxfKkP9
	 FkA9vb6GfB69HEdLi299L8aW2647RmRJYFu3hcRHQQRjAqd9B8FRJlpjrc0jNhCQWn
	 OmUnYsYu+YTMBLj4dghcgsnh4inU+RlOn08w9atRj39hwlRGXx/14bSspgiVXi640g
	 daRTjYtdFTEQWGuOdKbTvrNkQIiNHYZ+qqs69k0qFYcxwsFzMmJjNePijiWo+6QK0l
	 qTxnIWPBqgwSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XrqjC1Zbyz4xff;
	Sun, 17 Nov 2024 23:25:35 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241113-vdso-powerpc-asm-offsets-v1-1-3f7e589f090d@linutronix.de>
References: <20241113-vdso-powerpc-asm-offsets-v1-1-3f7e589f090d@linutronix.de>
Subject: Re: [PATCH] powerpc/vdso: Remove unused clockmode asm offsets
Message-Id: <173184539749.890800.8297350541963703609.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 13 Nov 2024 09:06:58 +0100, Thomas Weißschuh wrote:
> These offsets are not used anymore, delete them.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/vdso: Remove unused clockmode asm offsets
      https://git.kernel.org/powerpc/c/d7a82238cb8c77d4ed8cc97cd556c5f3e64bc749

cheers


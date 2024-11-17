Return-Path: <linux-kernel+bounces-412076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4089D0387
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3216284481
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6918A950;
	Sun, 17 Nov 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="hSDV47H0"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784215B0F2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846316; cv=none; b=SEL1Ayi4HzvObyAGz+wOw4WRUGwUy1e0LzQ5ccG6MyvPaLXYRN4pKRFfHE/B9tLlRB81kB1q8rEe714JgJzjmztn8usCXqdWh/EHQZRFmMPelbU6Acifdy+cwATFYQDTsSVBI2DVyIwTtG3/4jduD9V1cZpxPVf66zaxBLO9w44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846316; c=relaxed/simple;
	bh=YzY4aou3IaZgHFHev/4ZvsvWYksL/Y5TaYVToMBxg/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q4IKJrplaDhxIYKM6iLXT50hvEo14gwQo0qnT6lX2/avwXZb06s/y9ejSWzI0cr1pFgme5zd1rrJtYrrVjeV9/bp90fREZX8SrD/fBsu1od8pFh9zS7yBR9t8cDzpS40C/KxMxnvJ1/zv7i7TuWQedMT1i8TmiwJ5bJTSPZ640Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=hSDV47H0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846311;
	bh=ZtVZjHZpNMLRUjQi5h35hHsNEqKCZhuH0S+3ozdVAic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hSDV47H0eD+7XS/3nGedPptWFN9AhomQxWk2sNvmdaeUi5uvsKpJcOSDj6II2JPos
	 Xua/MldRgW+De/0LMIn1cW7+mCyZuCI4rtTNooLvXMALcEHH33zb5hRmGLgmE1REXQ
	 onMQEoQU8IqiKQ9M9EiAzxeUQbV7YOzpC800mG/esXdW+c148ufAHxLls/oR02x6YB
	 fncbmELipMtjqabvH9U6Kt3x5Mei5UqTlfXtNzSNZ/O/h7rUDwP/OW7dNrFdlZvJfj
	 1daXFx3yfbMgWD7AMzBkrNXOMFtY56fXINBItNbuL+TGfgtZFsIE+BwXqZueH3wHEc
	 bwsLBlRPz/IZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqhk73vWz4xdm;
	Sun, 17 Nov 2024 23:25:10 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Naveen N Rao <naveen@kernel.org>, David Hunter <david.hunter.linux@gmail.com>
Cc: julia.lawall@inria.fr, skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
In-Reply-To: <20240709143553.117053-1-david.hunter.linux@gmail.com>
References: <20240709143553.117053-1-david.hunter.linux@gmail.com>
Subject: Re: [PATCH] powerpc-km82xx.c: replace of_node_put with __free improves cleanup
Message-Id: <173184539769.890800.11654652895579463795.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 09 Jul 2024 10:35:53 -0400, David Hunter wrote:
> The use of the __free function allows the cleanup to be based on scope
> instead of on another function called later. This makes the cleanup
> automatic and less susceptible to errors later.
> 
> This code was compiled without errors or warnings.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc-km82xx.c: replace of_node_put with __free improves cleanup
      https://git.kernel.org/powerpc/c/4aa5cc1e0012f784bc7f637458e597564833b425

cheers


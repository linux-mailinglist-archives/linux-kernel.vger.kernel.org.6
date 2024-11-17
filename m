Return-Path: <linux-kernel+bounces-412075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463F9D0385
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2530B22026
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F39117BB38;
	Sun, 17 Nov 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fD9cObO+"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACE26AD4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846316; cv=none; b=aQJZXjSGogxK8B9uIVEPTR/0u7XobdrLTGMabtYLZHSCH72nr/Hn65BReciFxDlI2641+j/PNRwFlZrqyfvJZdQe1suXnKEDnxadzXfY0oF51SsTi2qiwBaT9oK1McK+HkYUOGiqGyBLJ+ODYLUD5ThxIJxRDBCyZcvc9Szb5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846316; c=relaxed/simple;
	bh=QS1NV61Dunx7K2E7N8P6NU6re7f64axUJGoaEu8YUK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mmEY6PWaGM1c9an4JXGzSwotcVfogia6YjpVdMD546tJfUHUaFWq3hSI+6CpwoPYy/XfippHrb9nAgeqxRRT9FGxx8Q+XS2rxbC4/REx1qBxQqLg0sKUiplrHacc2mcAuFY6BemKL6FVhXZoI8zTBxphbJ1Hv/aWNGsR9rzR/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=fD9cObO+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846309;
	bh=ZwnTGlAOhqOsDts/gSmhFHjUFoMKSdv4VzJ6Hwaq0no=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fD9cObO+kvzMnKLLcjXuemEJL1Jgv/Eek7eh4bLSECXhKgl4lMnVoJM2ix+7ipnLn
	 jlGKdluyz83UDCpkTn2xxOlu8CYKQnn0pYhAqeoLlhp7FGT/MpSI8KEPgPlsh0X3BY
	 Wq+OfImBZyB6i8TO41Vq0g7WGGv6WANqD3E48kjF+yQ2gd8Qlxdgls8dpRi60WgOpY
	 TB0d5n29yUPjiTN1kUvYNjoM6fpaCcuLod4noJpHUrSv9UeHb4QR22O3u0egG08LU8
	 VpjrWTDakzk9s9cozEH9QeA/q15BQf6gqpcvj0JxqaUV313++vQARpSfiENgcw7LRm
	 m0MR0VNmP+bwA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqhj2NKmz4xdT;
	Sun, 17 Nov 2024 23:25:09 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, David Wang <00107082@163.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20241108162327.9887-1-00107082@163.com>
References: <20241108162327.9887-1-00107082@163.com>
Subject: Re: [PATCH 11/13] powerpc/irq: use seq_put_decimal_ull_width() for decimal values
Message-Id: <173184539748.890800.13994461316487371816.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sat, 09 Nov 2024 00:23:27 +0800, David Wang wrote:
> Performance improvement for reading /proc/interrupts on arch powerpc
> 
> 

Applied to powerpc/next.

[11/13] powerpc/irq: use seq_put_decimal_ull_width() for decimal values
        https://git.kernel.org/powerpc/c/5b881c1f83792f5db421124171b06f1b8f1fe075

cheers


Return-Path: <linux-kernel+bounces-399534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14239C0046
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF31B2299F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6A11D86CB;
	Thu,  7 Nov 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="n+9ol5ZB"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4E1DB929
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969104; cv=none; b=YrHOKlyRy5DJRetdSmyeh6fhOj+v1ABVDo64ETr6GP4UB+ZlfPvO4t3q0ZJsr0WTHjfhscx86uLLhOlhwD8zC23RgeHjnkWKs9z/nJwQ3Vfl1edCBxU2X5laEwnBTMWUDBNGq2Qo0qQPB8tcnKrgyfUEVaT+u4mPkybahVrIKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969104; c=relaxed/simple;
	bh=KmVety4S3tMKVBXbZov2MYMhJzVvHQBcnZc1dUS7ra4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ka/lIr1VnRjxD0GoX4QjdGZNiIZ48NEPkJ+Fb57MKx+BblLJQ/AV0nRDijOQ0zKVJs4EIs/5qfL7FXaFA9D9949f7fdVhuH4t76f8UWbu1ZacAzCGebAQVuJkdOTupU7SPvBkS0NXUSxKu+VOd3+F9J3LdMyB7ATHujs/PBA2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=n+9ol5ZB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730969098;
	bh=6lO1i2T84ndIiemHa44KairFoUH5eTyzgz+EAUTjUz0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n+9ol5ZBXqiUvR60eSXCHaCKSI4AS153n/KbJhPT4eyl+rYuEwngam1ATuqLkvef4
	 dAWK+epBzyvDu9IGJW1Bd81U2DcoGFjsoWiY3cCqLTgynpDhkGBqIk9QcO+3ryVxj/
	 j3qDnzLfa4fQ9dpMmUxraPZAlmqK6BW+7fBa5vWe9eZ77yksIjgd9+qJwKp2MNY0iZ
	 Ud9HElKRW0JzjNJ2eKFBYUVMmTajyGtfXtgxSWnBC4kYjV5FvT+iqNlkTSiEaT6Zgx
	 m2iyrzbxi3qbT5GdT7iFq24VpJAUUnKYiyZtwETE7W4ihLXO8CoIns1NW7zvOEz9wS
	 /3LQl+BY/wGJA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XkbHG43zTz4x1w;
	Thu,  7 Nov 2024 19:44:58 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b6ad2f1ee9887af3ca5ecade2a56f4acda517a85.1728512263.git.christophe.leroy@csgroup.eu>
References: <b6ad2f1ee9887af3ca5ecade2a56f4acda517a85.1728512263.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/vdso: Flag VDSO64 entry points as functions
Message-Id: <173096894628.18315.17865156706800926912.b4-ty@ellerman.id.au>
Date: Thu, 07 Nov 2024 19:42:26 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 00:17:57 +0200, Christophe Leroy wrote:
> On powerpc64 as shown below by readelf, vDSO functions symbols have
> type NOTYPE.
> 
> $ powerpc64-linux-gnu-readelf -a arch/powerpc/kernel/vdso/vdso64.so.dbg
> ELF Header:
>   Magic:   7f 45 4c 46 02 02 01 00 00 00 00 00 00 00 00 00
>   Class:                             ELF64
>   Data:                              2's complement, big endian
>   Version:                           1 (current)
>   OS/ABI:                            UNIX - System V
>   ABI Version:                       0
>   Type:                              DYN (Shared object file)
>   Machine:                           PowerPC64
>   Version:                           0x1
> ...
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/vdso: Flag VDSO64 entry points as functions
      https://git.kernel.org/powerpc/c/0161bd38c24312853ed5ae9a425a1c41c4ac674a

cheers


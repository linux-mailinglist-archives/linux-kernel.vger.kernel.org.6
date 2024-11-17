Return-Path: <linux-kernel+bounces-412092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583409D03C9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16880287BFF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0111B393F;
	Sun, 17 Nov 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Lor/k3St"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774C1ADFFD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846339; cv=none; b=Gk3kjCEe6LSPvzOUiDoKa5JAnEtzAoT7Ed1d5joBqsnAWGI3KxH6f0KI0oArtCiIeIba3m5CTAy8JP1cEsdA3aJLQXzTl9Dxma1pyPwxcoUy5Uj36ISUMJYS692AGtT9S93XXJvrzEpt+scFtFRc+6nPUhpu+a7Ri3ujOby1jts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846339; c=relaxed/simple;
	bh=MissGZEDHAKquqZIOx6jkZkVW9UBSq+5BzEgWffzAEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G7vCENO5QcLCnhJ53wkF0ca6d05Y6jpmZuj0nfC/2GyqJLte5u4hhSNIc5G3yQxoWsxm+cPB06N6edLKfUcBYG0hIGg/C/fZRq3UwzPgAzdQEQzhXuS+/D8VEuJ7WQaNrKjEzVzDY/RhPutvKD+xFYZZ43+8J7fmHnOiU5mvXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Lor/k3St; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846333;
	bh=bpsWnoifT/hIC+01WtPTd1rGqigmxOpuxcKKogn0bFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Lor/k3Stxzn3GSeVIckE9SptJ9kTkY8DrWM7Rx5ov/HyI4pL+Fp8vauVPIEc8HKrf
	 TMARtT/Hq3eFkWIDacFmk6GHrB4ijz20+fdJDXrpK0CqE/pOuNG4gUk2NzebQQUwyB
	 far9PsEyqK1T+9y22QgOcLWwNaFx7TtVXTJC0ic9hPYP/cKAgqCb+vLg0zENteK9FN
	 M4bdYZLSQ9oq+qfPEyvpLY+plhd8KR46vVfgb5jt6+WGz2EkbuESasu1KNT/F2oQmj
	 0g/bR/M3SrGFNrPLkCvaxEHtuFQEkipZxjuOgSoS1XtUn0h0T/89Xucu/AgOMRBcYm
	 S/New/kOv8yyg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj872Wbz4xfb;
	Sun, 17 Nov 2024 23:25:32 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241106212640.341677-1-robh@kernel.org>
References: <20241106212640.341677-1-robh@kernel.org>
Subject: Re: [PATCH] powerpc: 44x: Use for_each_of_range() iterator
Message-Id: <173184539746.890800.10274728574642039643.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 06 Nov 2024 15:26:39 -0600, Rob Herring (Arm) wrote:
> Simplify the ppc44x PCI dma-ranges parsing to use the for_each_of_range()
> iterator.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: 44x: Use for_each_of_range() iterator
      https://git.kernel.org/powerpc/c/817a763a07f2407ca43b2134d067e7c0576f1b79

cheers


Return-Path: <linux-kernel+bounces-302740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD99602B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2FB21BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4881552E4;
	Tue, 27 Aug 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WWQ0eP7+"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2A113774A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742862; cv=none; b=ZJVP5tdyENS1CC7Q0YUA9NJWxC4dcyrlZEOD8oY8Tmz2edqZ6bJkbmsm9vZCGiP1IgJwzwinjHUj9tROduCmw8IwsbJfmrdGIGAX4AK/Phqx7Xmf2ApR30K+B7dls/tAmfwG7IsNFU1nNZGdOn4W9sLpgOMARxLWcchQIl1Qoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742862; c=relaxed/simple;
	bh=yzgmeqUwCFdWvG4NW6LIRn24nL5BtUWVMEiYuIJO6n0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EinAU5C4E8PmJs4HF7GO6kbgnxmzCoH0f2ImFa/7gGsM48MC9arQVQ1POUR6Q4QhugEziGQiwEACvba08oDnkzNhXnMvFylWZJkK3wv2Akq8zqf/7KOF/5VgmPRkumxr71lFXS4UJKG6X85pmhm+EJeTsNiGRtYWmcUG628/JLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=WWQ0eP7+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724742858;
	bh=ZONpfAn4J/I8AE+o3hedBFPBazPggLrLUOTjUJKE6Nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WWQ0eP7+oBBJO3+DnUs2DJ9M8S69phvtVxv2/jblE5Eu0iR6tvd6J4dqTGuJlMEjE
	 NnV5n6u1KHngL34b+GEtJdd4YKRaQkTepc9fYc95UH4EX01n5edKhgNgy14jBkD+ev
	 6MTdTQETC/Bxpp3dyTeQ6hi29kkGU//wKlEe+MPdUR8dd3n5iBHqhZiN5KOESoKKDp
	 5eEWtYZrKLkhFqFM02rqF1dB72xkuLOcRFwjDUvVsmxDFas0BwStfE51i1PNBC9XfH
	 Hv3cWchl+xYQKjVzjCSJE87mEs2lpeQ9iEbT5JFuU7kOuKZ6rdahdXDYZDkeSiUeYW
	 YlYZFsvpY0JgQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtJgs30mkz4x6l;
	Tue, 27 Aug 2024 17:14:17 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: jk@ozlabs.org, arnd@arndb.de, geoff@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240726123322.1165562-1-mpe@ellerman.id.au>
References: <20240726123322.1165562-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark powerpc Cell as orphaned
Message-Id: <172474280308.31690.5184828859229185339.b4-ty@ellerman.id.au>
Date: Tue, 27 Aug 2024 17:13:23 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 22:33:21 +1000, Michael Ellerman wrote:
> Arnd is no longer actively maintaining Cell, mark it as orphan.
> 
> Also drop the dead developerworks link.
> 
> 

Applied to powerpc/next.

[1/2] MAINTAINERS: Mark powerpc Cell as orphaned
      https://git.kernel.org/powerpc/c/db9a63913fc7aa6ea419c9a787bfa18937515037
[2/2] MAINTAINERS: Mark powerpc spufs as orphaned
      https://git.kernel.org/powerpc/c/81695066c76fa74aa00aadbcb360cc7ab9c70c51

cheers


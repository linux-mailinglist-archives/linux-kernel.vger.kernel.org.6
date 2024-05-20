Return-Path: <linux-kernel+bounces-183498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171BB8C99DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A50B1C210B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEEF1C2A5;
	Mon, 20 May 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q9jdyWlY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951E10A24
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716194053; cv=none; b=jA1/S7MlkkzUM+zKB0oT8vb3K/kRFXW1Xl61bVbRcTqvTfsXwjRbUqcB9QoEfPS6yTluQYr1TT2I2cGncPz6XzaC8bvUnsp8gruBd4/dUzWAmJecW2lEryfQ8yPrmxUdCglW+mK2Zu37AvEvumrAUReiyaorzGbHInm67ZcNLTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716194053; c=relaxed/simple;
	bh=X0QZP7FHYL2qFHp4kvF0mccw2Hnpx8h6HCqJxaWfmQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/gB96nXcD96E8n6vkAQ4pt0naD+k1KkscJlTYlhVs65a/jYAVlv0zcHV+WhqhwhcCilvph2W3RYARVMnzQPtGzSUZAtg3ET3UcLG3z5mtOQ5fvM+ybo3Oeo3DM/3ZZCPv63f0KtwNZ4Xj+Urhst7WRDKJjjX7A7Jjy76GzuNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q9jdyWlY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C946940E02A7;
	Mon, 20 May 2024 08:34:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EQKpPft0jyp3; Mon, 20 May 2024 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716194037; bh=IQUAVnMulROKWQYW3iVEILUrAjeOr0Qhmlxvw3jKOBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9jdyWlYgkG5g0ZyFHhFj/37JN8e9nAQQVuiDHldpbpd3nVL6zQrQriLvnTrk6fZq
	 AOEy+gaiW3h9QFlBZJEu9EaI+Suk9WlOkfoAdRYeL0qdwzsW6Zdkh2PbfculJUapfC
	 TeP0tKxBI2snXF9MQ4PqWzOTrYTpvd5ZpyG9nh3NCSep/Uw8zN+epLdkLQyf+3z0ZV
	 1YJwkKx6aQfKMjOr1zAYR9GKC/7BEbHx/9pmvR7R0n6pMmxYFhMizz9sTsa5ukZCHF
	 G5e5sI5jT4I3xP4E6nH8DnZpomd5EnsmUXd5tBL8HP781meH2XExEmGUn6laViyCPb
	 XwgQ5SuJomfBdVJnqiU+pwHYwkRiZdRoP4N+UROweUtIMoVSWLaONraT9mrsIJruq3
	 GgVnOua1+7YzK8jUJmkaDFKVL6ycUPj3Shp9L92RetMBT591QNKm1tVsTLaCVYJH/R
	 bNRvUwYaLBxx9HeAkSncyD8kOLQYuNKIr7H8fA9RzVgyzZz8BBcOTtwVrzPzXEMDJZ
	 Jj+eeAnU/ne/WC3lUymmCet1JyuX5iCb9KXTVnjwFjw/kpPKHfDHUq3Zm+ltBYYpEi
	 klae/bU3dkXmdxGLhMv3GiSIYHeA72e6wrJXG0zYXAOi9ib3UX8AswjHpIslWB4yIW
	 tXJ4Y8uYRwK27aNsVWLwSwUk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5571F40E01F6;
	Mon, 20 May 2024 08:33:46 +0000 (UTC)
Date: Mon, 20 May 2024 10:33:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jordan Niethe <jniethe@nvidia.com>
Cc: linux-kernel@vger.kernel.org, jgross@suse.com, ajay.kaher@broadcom.com,
	alexey.amakhalov@broadcom.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org
Subject: Re: [PATCH] x86/paravirt: Ensure calls to pv_op functions are RIP
 relative
Message-ID: <20240520083334.GAZksK3unOiEJ7FyHv@fat_crate.local>
References: <20240517024224.995517-1-jniethe@nvidia.com>
 <20240517100714.GAZkcsUqHxScXJErxP@fat_crate.local>
 <04079a4c-e5da-4ffb-9527-669abc18d0d9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04079a4c-e5da-4ffb-9527-669abc18d0d9@nvidia.com>

On Mon, May 20, 2024 at 12:08:08PM +1000, Jordan Niethe wrote:
> I'll try and get a minimal reproducing example.

No need. I think we'll hold off on doing anything here until one can
trigger this with a valid kernel config. AFAICT, we build either with
-O2 or -Os...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


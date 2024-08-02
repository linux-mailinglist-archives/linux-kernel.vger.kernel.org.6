Return-Path: <linux-kernel+bounces-272419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624D945BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDD11F22964
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF261DB459;
	Fri,  2 Aug 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zabbadoz.net header.i=@zabbadoz.net header.b="W3k6sIWv"
Received: from mx-01.divo.sbone.de (legacy1.sbone.de [80.151.10.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45DB1DB445;
	Fri,  2 Aug 2024 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.10.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592637; cv=none; b=fy2jEo6klFfsDuzRPkUSNhRRo0nBLu9N6bn3KQDkUhxtam8KkEGNSW1+fJnBm5iPuqxh3rhHiIsxIwZbFa/rvXr8IpHoW9uJf0T66+dIWHkcnhqdcamckhVwANrXN7eUo3mcet0IXohuHmE2xSwvceZQl6qEkbqmJ6944+ujGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592637; c=relaxed/simple;
	bh=BdE9txZihg93zoUJIdYX0o3vhnu2uDuyjz8mtdq00BY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tesL82SeG2V0dYZ+QXdplvLK3Ag3GbilCoJJdOrO0+4PpFq1Jll/4kwtYN5MdBbGymvoB4a5aYg8F6RR3UZikQjRBegdol3vj9ogej1Y+wSbsuNRa3JYpcpResj+pYvkcijbddbJjCaa6bDu8MVpRfDG5ehF5ZJrGV+cOxgL1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.zabbadoz.net; spf=pass smtp.mailfrom=lists.zabbadoz.net; dkim=pass (4096-bit key) header.d=zabbadoz.net header.i=@zabbadoz.net header.b=W3k6sIWv; arc=none smtp.client-ip=80.151.10.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.zabbadoz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lists.zabbadoz.net
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mx-01.divo.sbone.de (Postfix) with ESMTPS id 2A6FBA64808;
	Fri, 02 Aug 2024 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zabbadoz.net;
	s=20240622; t=1722592002;
	bh=BdE9txZihg93zoUJIdYX0o3vhnu2uDuyjz8mtdq00BY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=W3k6sIWvhqXJcuJaRi1RSr5VLTIBnpzWxNHDL1xpZM21JF162KrJ6zgVeVgMsGYoG
	 m4YCS0CJJn6VZnzJq74Ci8g3YkNeBv3wdnVPQgw+6rpHxllZyyRyC/2YEJenqRR176
	 gtBedrJcGfwVxN5sIg57Et+cThKemU/VJrj0rScAAgolSsk0Rhu0ojesJ5JCLPIam7
	 PivBaKsXbIQ02O9yKFCy8/1TLy7LEQi59hBKSUThBf5vE2gPayvha7c7tRlW6wyr7E
	 rjbvTHPDdAMtUkMMOXs80jLzcRkKJh3OMwgBjMtJdbtOZR2QE29BiRnrvsm45LDcQX
	 tNeKgX07qZJFsDPyUObzrdPYL8DF+ZN0cuJwvQ/QBxM8A7vglCLIZO4aTYMT1duIVN
	 cEXSlTsVzuFVIImoIeIwKbLInmxaqQTXHPS57awc58cDlctWhiWuS8D+NqswLx41VV
	 ZRVPCOqrJ94nDtx3l6oCFylqYtyDF1iVjOvCgz5h83mHCqe0e4umCRwYOrmd08dhhU
	 DUP1GwdJf3r0ePsXhjMDREkXzsW0UGcbRqPgnK8zqSFUxiT+6aCTlE9PobBLhJqpn7
	 BmDJT7CfVIM1Y+7X6rflvycTG48N9ihIqf/TekruJDm3efSPDaafSlbUULS7SOkcmz
	 NT6leu2e8nfQFlWe8joy+Ssk=
Received: from content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPS id 5C6192D029D8;
	Fri,  2 Aug 2024 09:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	by content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742]) (amavisd-new, port 10024)
	with ESMTP id qiaa6JdiXyBI; Fri,  2 Aug 2024 09:46:42 +0000 (UTC)
Received: from strong-iwl0.sbone.de (strong-iwl0.sbone.de [IPv6:fde9:577b:c1a9:4902:b66b:fcff:fef3:e3d2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPSA id 59D1C2D029D2;
	Fri,  2 Aug 2024 09:46:41 +0000 (UTC)
Date: Fri, 2 Aug 2024 09:46:40 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
To: Sergey Bostandzhyan <jin@mediatomb.cc>
cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
    devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/2 RESEND] Add DTS for NanoPi R2S Plus
In-Reply-To: <20240801175736.16591-1-jin@mediatomb.cc>
Message-ID: <756p9487-56pr-88p2-6o79-7oron3q8462n@yvfgf.mnoonqbm.arg>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org> <20240801175736.16591-1-jin@mediatomb.cc>
X-OpenPGP-Key-Id: 0x14003F198FEFA3E77207EE8D2B58B8F83CCF1842
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 1 Aug 2024, Sergey Bostandzhyan wrote:

> Hi,
>
> as requested, I am resending the patch series, now with hopefully all
> relevant addresses on To/Cc.
>
> I noticed, that a DTS for the R2S Plus is not yet available, while the
> R2S is already there. The only difference is, that the Plus version has an
> eMMC, so we can reuse the R2S definitions and only add an eMMC block, which
> I copied from the DTS in the friendlyarm/uboot-rockchip repo.

The original has a
 	// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

please don't lose the OR MIT as other projects outside Linux do use the
same dts files;  and the original r2s file also preserved it.


-- 
Bjoern A. Zeeb                                                     r15:7


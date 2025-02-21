Return-Path: <linux-kernel+bounces-525645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B6A3F2AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAB67013A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86252080EA;
	Fri, 21 Feb 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2M5E8KCT"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE74204F87
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136049; cv=none; b=fz0W1qT/V4tVHHCzUWQFmISqiflTRubPhOsLRDKZOTQUGCTYt8nsq5vJdtqSYhnCo6xigOdui8mbvpxNvRcPhbr/DFGnTsI1sPXbajjamxzyZgB9uUvm/J9ia267eBHOW5vVSDcaQgbz+kEPVYyABQZrTWOv7jbgViYIEKrGJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136049; c=relaxed/simple;
	bh=OrLEWszAt2g2+uaXn+6b7I4pNNFvvjaXQB2Xr3LTA2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxyPu44PwrNR5zW5BpG2ZP6tE9JTv58IBzK6CFxaGesMmlhQ6Owam/Dgq7ZEvN1YlgRZw59/ri/G9ix47fpoJYQPmvWWEecZVXmBORW/H7I6g6BaVhxbAHrltu8JDsuPxAakCbYCi8uy7dBW1zRb8KOrPW2Q+/6FoMQb2NL65fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2M5E8KCT; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D0A7843239;
	Fri, 21 Feb 2025 12:07:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740136045;
	bh=OrLEWszAt2g2+uaXn+6b7I4pNNFvvjaXQB2Xr3LTA2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2M5E8KCTzPNGrxqs18aAYCoIl9eUVImV5UHpfOg207LBMzwJYHq1CoQ+EYEvq/9rO
	 dpQSRoMk/9zo7qNj8B4FNOZQJNsqmeHj9AWt43J7ZExMLvvPAEQxoKyGzs+K8z9DEx
	 Ir+VvoMd8L3YLXlACO0Y9QrbmM1CDMUDLzjcp10d18ABnhXJNaqwbabuCruA4iuBJS
	 X//lPVrj7j8NvfhEOAHJZ367reL5bJfnWXqK19e1vAuErHMMZbkOtyelvTSbJFdyk1
	 R/Lpd8AvFuDFWxE1g5kxqJ/tXLRBTFoyLqVlGDNlaciO+07SKvzk3FD8T1TTmdDCa7
	 F/IjpeYoedklA==
Date: Fri, 21 Feb 2025 12:07:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Hector Martin <marcan@marcan.st>, Rob Herring <robh@kernel.org>,
	Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH] iommu/io-pgtable-dart: Only set subpage protection
 disable for DART 1
Message-ID: <Z7hea_LY7u_7_jTw@8bytes.org>
References: <20250219-dart2-no-sp-disable-v1-1-9f324cfa4e70@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-dart2-no-sp-disable-v1-1-9f324cfa4e70@gmail.com>

On Wed, Feb 19, 2025 at 10:13:53AM +0100, Sasha Finkelstein via B4 Relay wrote:
> From: Asahi Lina <lina@asahilina.net>
> 
> Subpage protection can't be disabled on t6000-style darts,
> as such the disable flag no longer applies, and probably
> even affects something else.
> 
> Fixes: dc09fe1c5edd ("iommu/io-pgtable-dart: Add DART PTE support for t6000")
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/iommu/io-pgtable-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.


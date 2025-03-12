Return-Path: <linux-kernel+bounces-558539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB4BA5E75F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1573B46C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1838F1F03C2;
	Wed, 12 Mar 2025 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZV/rRze9"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15201EFFAF;
	Wed, 12 Mar 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818375; cv=none; b=MOvlOAqAa0eWOrm1OYkgTubJG95s1qVGZ2OQALNqDZ2LIOFFX5e8ZxOm6YBfiNTUErvpe9515lQPp0b2Pnxzw8TaVoofk6SMlNCVZ/DyAJZjpg/EDsQYBozyPaRa0ah669v2LaqpoZ+2NExdcDCpvGNHuaaM8e7tEvgtk0AROv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818375; c=relaxed/simple;
	bh=wVXAEMQ1AYcIo0RjMVfy/fifdDq9C9XRRzrJbyO9JKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QW8Hs0ATxsnQOtCsJEwtYC8JUi3PJEbbZHneLlFh9kxOul4icgjkk0BS4trhGnJw0QtT/KUSeQlvJ+hYWpS5CgkNLn5zaPwbtJ4lhMJetAKpD00XuhYDwoYtVYyKUUmp/FN1LzuY7wE2zalSBx1PuzKqiWfEE+gNkryo7HJlZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZV/rRze9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4B3D941063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741818367; bh=R513z6VJ6jIxeMmLAESe2SdL+xy+4HtC5YoWAcZwhwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZV/rRze9ItLVWPyQYtAqqN1EzNhNJVTWWbp8xouH4F5OMEPhPud/0h4ql765zB4V4
	 nWjn3X9X/THPNLXxouQuEobq2czscNtkh7U25rqzbQ+wBn2lPTr0xRx6XbvbqRzmZs
	 TpBPV1sw7qDQi5iNlgo5HPNtTDilHm5TIwQIrhKuuSEl1/RejN0ywtG6mSwgIdmgmI
	 xqUwv4o0XbQSoIEg+xmi95e8FKNURU1A1d0rcp3myRMpp1LjX6n8+VnlxVtLpu/kNw
	 sORV8X5KFE+mdKdV+wpzrJqNI34i0+Pq1xzdyF6CJySrPWjOco0+L2Y7q/II4tsEkl
	 w8uMU5jZccR8w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4B3D941063;
	Wed, 12 Mar 2025 22:26:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Heiko Carstens <hca@linux.ibm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] scripts: get_feat.pl: substitute s390x with s390
In-Reply-To: <20250312155219.3597768-1-hca@linux.ibm.com>
References: <20250312155219.3597768-1-hca@linux.ibm.com>
Date: Wed, 12 Mar 2025 16:26:06 -0600
Message-ID: <875xkdnawx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Heiko Carstens <hca@linux.ibm.com> writes:

> Both get_feat.pl and list-arch.sh use uname -m to get the machine hardware
> name to figure out the current architecture if no architecture is specified
> with a command line option.
>
> This doesn't work for s390, since for 64 bit kernels the hardware name is
> s390x, while the architecture name within the kernel, as well as in all
> feature files is s390.
>
> Therefore substitute s390x with s390 similar to what is already done for
> x86_64 and i386.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  Documentation/features/list-arch.sh | 2 +-
>  scripts/get_feat.pl                 | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon


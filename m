Return-Path: <linux-kernel+bounces-195474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E08D4D55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E461F22C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227F7186E39;
	Thu, 30 May 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="tEdvQrUJ"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB375186E31
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077475; cv=none; b=YNrBZl+TPOYCPU+qomjgJzDAF2xD7f6pOOeiZ6Qs9g4ZQ4oVf6Fotl3hrFuvH+LSMaXT56si6YqAylQrrN6UWee2+uacVqRP9/DqShbPE98ht+puyCFHGIlEKniOvUaEn5ApkZq0ZbBunnK2eWhGFuGB2XnqU3Y0faZRA0310wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077475; c=relaxed/simple;
	bh=QDntA1S0rAkOvUWk+cA+zU1W2OoXJoWTyxaYlclJXLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ns00ovPA8fmIxavFr9oUKUmDbCVUacjZ57TpY8g6X4im4/yLxabvu3XIkT8mH7Pi35kRj0HAXwN3kX8kLXi9Z5Kk4afYaUjvODX5GaBbNgTDxCf1d06tS7lg55BMKM0yw0VvVoaFni+WRKRSurlcMZWoEpnzamIneTOBMMycaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=tEdvQrUJ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: dwmw2@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1717077470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iYx9c1xO6ymLn++WbU9EryJwaaf+Egf1PM7t6JATVVE=;
	b=tEdvQrUJCDGwkhjgDLHFl5013LSVfpYxUEM2V6mB15RlpVz/mJ61stZUY3HwiUaiS6o5dY
	jBffWrjInvuDPufAKBXkY7uQkxel9vH7/VlbxIVbmlYwTtXMsxtnP0oG4G2ZV18TRwHuzL
	2XeaYyPXBzX4JPjqW2+klx6A3Yf0adMBbmhoe5ndCNX8v6lWSLSKv/sXQ+w1aeNxpkORUD
	0O0I4erOTQYs3FM66m6jtek8CT1d952QtfYqzapf8qyCnRiD8O4MZLUwT6gUnjQuHiw0XG
	o4xSA4gqFqFgOvtw88BVWeIo2tgZ3+SzkZK9DdXBXQDILrb0l2piLL2mvkkeBg==
X-Envelope-To: baolu.lu@linux.intel.com
X-Envelope-To: joro@8bytes.org
X-Envelope-To: will@kernel.org
X-Envelope-To: robin.murphy@arm.com
X-Envelope-To: iommu@lists.linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>
Subject:
 device_def_domain_type documentation header does not match implementation
Date: Thu, 30 May 2024 15:57:38 +0200
Message-ID: <14311965.TaHA55BQu8@bagend>
Organization: Connecting Knowledge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3343604.Wtvs3CB2mS";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart3343604.Wtvs3CB2mS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Thu, 30 May 2024 15:57:38 +0200
Message-ID: <14311965.TaHA55BQu8@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

Hi,

While looking into ``drivers/iommu/intel/iommu.c::device_def_domain_type`` 
function I noticed a discrepancy between the documentation header and the 
implementation.

``@startup: true if this is during early boot``
0e31a7266508 ("iommu/vt-d: Remove startup parameter from 
device_def_domain_type()")
removed the ``startup`` function parameter

returns ``IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain``
28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into 
core") 
moved the possible return of ``IOMMU_DOMAIN_DMA`` to ``drivers/iommu/iommu.c``

But neither updated the documentation header.

Cheers,
  Diederik
--nextPart3343604.Wtvs3CB2mS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZliF0gAKCRDXblvOeH7b
bn8AAQCiDxcxgUIErkiC9QpJNmPLh6SlxKa2ytIrBp/fqzJBpAD+OOGPlgXUq0ch
pUs535Ep1y8OsfvhKt16hBWvJC2dIAM=
=/+oC
-----END PGP SIGNATURE-----

--nextPart3343604.Wtvs3CB2mS--





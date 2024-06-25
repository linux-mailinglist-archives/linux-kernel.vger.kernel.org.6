Return-Path: <linux-kernel+bounces-228792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05B9166F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5741F22209
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F983153BF0;
	Tue, 25 Jun 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="bYecgG6/"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017A1494CB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317212; cv=none; b=Jgvn9xhSiNVPFJnMOnoA8KGAkrBiBrEcO6WZWmaBMRSuMqZglTcnycTuMm8h9fs+vGh6KbcKUIT+Gqn5PTSvrkSo6KAGYbtoQiilfQ07B3KAgbg4NnP5jZ9JA7PRpmkKYsySWU5FwR83NbkaMXXCaNKXmzteLZLkVNoVdjYXm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317212; c=relaxed/simple;
	bh=Pr4NMFGDggwcU3MV95a+FwbLA9XmaTL/4lMFXE8uqxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak7/4OeSlHfpT+HeUeeYvJ/h+h1TMsUQhqtcgHbEskp1aiP46eCIOgr0AShwmEwAf6ycMEkYTxWb8hxrqOJpHTvik0EV8Ro7KlGdvIqGZc/IZkxUUIffH7fhbMKny2kCIhQBV3mDBsZ1IqgOAS9Rhcvqytk/h2mbFUNaW/suX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=bYecgG6/; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af01e500c6341f51fa179db0.dip0.t-ipconnect.de [IPv6:2003:f6:af01:e500:c634:1f51:fa17:9db0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D404B1C8886;
	Tue, 25 Jun 2024 14:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1719317208;
	bh=Pr4NMFGDggwcU3MV95a+FwbLA9XmaTL/4lMFXE8uqxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYecgG6/6CxvvjHC+6UInn80B9akCaA7AoPe9k5jRap1AAHUFcI7NvRbqSKjMK6jD
	 3V6rDbWyZr5qqkJvWhgUg0zaLRwfWGqXh5irD1h1JHV2hCnqUHPD+9IzlQgsjfVY+i
	 vdqj7FFjeMJP6O6o+zo2ft84w6k5sHpZQMuAsbwoAzZNgK4h8atuPQUjG5JCBfF1yA
	 O7qBecV0C21kpv6mDgNwFB3ymXpBoSN5jdp3NZMrManO3T6rn9aapHrUqiR/uc1iWS
	 UtsFDrP/VR/NUZV1Is6ObsFKGD2tDMvRyx8nOpv7oIR/Q2XAEs/S8fI4QVq8Rhrj6/
	 8jLfpZD5Nk5Uw==
Date: Tue, 25 Jun 2024 14:06:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Fix missed device TLB cache tag
Message-ID: <Znqy1ljDqv3WWvep@8bytes.org>
References: <20240620062940.201786-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620062940.201786-1-baolu.lu@linux.intel.com>

On Thu, Jun 20, 2024 at 02:29:40PM +0800, Lu Baolu wrote:
>  drivers/iommu/intel/iommu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.


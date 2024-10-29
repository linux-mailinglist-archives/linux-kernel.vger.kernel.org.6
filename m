Return-Path: <linux-kernel+bounces-386546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487E9B44DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED42B2836A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7672A204027;
	Tue, 29 Oct 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="gQRd+3lz"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7EC203700
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191847; cv=none; b=frgqvrwpvYrD3mzKHyj6WNopciwve+CgUmnfBHHcfOeGZf2nC6f3L5+qJW8NIKTd1gO0eRb4FCD82J0/gqFciyKDV0m7k/HpcRxvzzXPGTyrRRvTSO+0TNztSeegRxJE3/UZYdnIM7DtIhUvraq8jidgBwVPH2poAysn4BzvwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191847; c=relaxed/simple;
	bh=wwhCGVSTBuszCIkhkHAr5sc29TXCridB5fyWe2bkSKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bugusCziM6uaAw9wXd7nKlZ0Vv02bjzBLKuY8Njcga8QYsEgiO7F7qo48YPU8ZiqoC4hIHb/AMxK/Bu+lSjI9pem6W9pd+iQ36YODcuGEVAzEpoCu7FmSmXg+/j0dbVJDjl3RTyT7155UG3zAZp0gH6SIqI9/9njTGPrMoV43B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=gQRd+3lz; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9F2912A8D41;
	Tue, 29 Oct 2024 09:50:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730191843;
	bh=wwhCGVSTBuszCIkhkHAr5sc29TXCridB5fyWe2bkSKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQRd+3lzySpeHfTYfqhxFoytqJfq5gL1Ii9Gx4Cgj2E+nQlkLnqlKvtnyRZP6zLO1
	 QCyoPiovjSR02R8exkMLF8zwcrX3xX+f5/7Dnihk7Q68TFJ7QyfS8E0q8GV3/oRNnQ
	 kcyd/laR5AHBN9u06+vrJntBbzpjcmZzhuBM4PEJd3y7fn2eb7SEcqVbs9eDId3eTV
	 GwE+bWIhenH541nAu+HWwuTAEmEy+QRccXuoI60RTO7ky3LnaMNH/keEWFwNSB5cjZ
	 jHRRipHV+JcmbFArZUOzbee5Q3R+CDRPlPXojd33oDDRBCmqUZAeiYRc+iufbUeZAx
	 QKTjaTz83EKew==
Date: Tue, 29 Oct 2024 09:50:42 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] iommu/sysfs: constify the class struct
Message-ID: <ZyCh4tsUadd2g6QB@8bytes.org>
References: <20241018121725.61128-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018121725.61128-1-brgl@bgdev.pl>

On Fri, Oct 18, 2024 at 02:17:25PM +0200, Bartosz Golaszewski wrote:
>  drivers/iommu/iommu-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.


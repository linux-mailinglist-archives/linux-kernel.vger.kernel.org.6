Return-Path: <linux-kernel+bounces-443476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266829EF154
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B5C28CA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672BA23EA73;
	Thu, 12 Dec 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mFBkNUV5"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A622A801
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020771; cv=none; b=sl3qSLkUpkEV181EJWqVd9gn6fqdjz6Bb4zjNakJhKx+vWn5IrUqrydc71e92GQwKKO5jiPWQsbp14b2lnvuOdTVpUTae7f81OvxUYRuwzqe4gk/Q+RJddRuKaGq1rov4OUoHiUdQxJnT6VtYEDiyLPTtliNkM+g/fIxnUILBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020771; c=relaxed/simple;
	bh=Xp5JrddSBs5Q+K9hrJ7xzi5PnxULx5JCdXJ4Nwg/nMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6ogpJ4APcp/1FeYkvt7X96z6sCy1/9AZD1xABVcYD9LcBxN4usyKqAKfE/W1jKztCvOUD6rXMHDHvTuppjQtTa1kQwU5ySdJaCSwrvOy7MZZq/4s2IzYWNV79R56ojCDUapQKmOAJ2zRjXgnBApOsLg4kfR4zhU32pyCc8dfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mFBkNUV5; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E58F92C1F60;
	Thu, 12 Dec 2024 17:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1734020767;
	bh=Xp5JrddSBs5Q+K9hrJ7xzi5PnxULx5JCdXJ4Nwg/nMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFBkNUV5Ee8Dn1kQuqvi5q/23w+2frZIxInZl3Wp60aLDYi43ybQiSCM06z8nhxXT
	 ozJT+ZhUe31o3XKO74gSWIigQZPZiK5zzCvHAe0n4cAzYFIKMRgkr50j8sKMI9CNy2
	 ih9fANumpq/3yFVgqs/KoOjvQc0Qp25PKDFva9LSsQ7jrV+ogmgEaRt7huUo2RRKei
	 x11ZUVEf5RlfT1Bo8tv1S13WTTmicHBHl8yinPsYKwKY96AvcS3SEIGGlUzZ9EMbTG
	 v4gdsY7BCLnv1f5hhI70pzAPnFYikPUtJ9PCl/CrJgCg4Kasdi4yL8FO+XftDb/9xg
	 Wj0H7MhxXjWGA==
Date: Thu, 12 Dec 2024 17:26:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fix for 6.13-rc
Message-ID: <Z1sOndzI5_VxdxXe@8bytes.org>
References: <20241212095025.GA18975@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212095025.GA18975@willie-the-truck>

On Thu, Dec 12, 2024 at 09:50:26AM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

Pulled, thanks Will.


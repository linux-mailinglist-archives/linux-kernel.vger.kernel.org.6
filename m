Return-Path: <linux-kernel+bounces-200537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A413A8FB167
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9D2810B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD860145A14;
	Tue,  4 Jun 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="3OsR7neS"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0673145A0D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501849; cv=none; b=Dtfn3OqttiOYSdSfiPO5yTDQ1YeF5fSVh3czt9tTTD33t5Uk59J8aq6AiSK7xNqxXRomz5jxK0CrFcEjpTYxg6rynnly7mHv/qlFH0BQkf7OXYl9zvNQnb0E4m2Fx7Y6+jTk+2BOePyeuW2dPvkHlbBs/yPOjeMslR579k3Zq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501849; c=relaxed/simple;
	bh=fV3BFykiJp52kE4KHDpVbW3pwpaJRnmS10SClWg01aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRxkjuuAqztmIrHQKJPQaZoAPgIF+e4WZjFD5Iz0uVLasIYKn2rPpw5rkS3AAf2dPBs8F157xIUHAqMywKVb5B3hwwFB3kHL5J4UwauwZjE+7KCAE4B84vhmytltBpwyruOjxSBMXI/Gw6WxrBTvONuAGhKutjgcKBvZGm57eAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=3OsR7neS; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 62B881C7AB5;
	Tue,  4 Jun 2024 13:50:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717501839;
	bh=fV3BFykiJp52kE4KHDpVbW3pwpaJRnmS10SClWg01aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3OsR7neSntHacV0WnO+WOG+KIgcCuGlDw8Vrg2ORGN+HBR7SoKA9g4g60xUMrOZnC
	 cwvkOZRxYlKy4tchm5ZF5YQlskne99JYEr7h91l2w/wopZU/WJAalTXPJ2RvSVLiJO
	 XVJcJzL994oAs1MBFAdtW8vkE8DehPNCU9ZwHN4P3ksA0NhwFQAKBSRdW2hpA7k75Y
	 wqONyYedm+j056R14u0f5Q7WRfb8FyVhM1X/ex0XQdwo+UAm/LRVD4irxZFO549Km/
	 3ZCb4E3p9o2RZYMsBLsoLZ8LkFlmI6xpqt2EyzWow9Rkqpka3T/9TrxEaj+6EShue/
	 AhDBAw7WMnW1g==
Date: Tue, 4 Jun 2024 13:50:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Kun(llfl)" <llfl@linux.alibaba.com>
Cc: Will Deacon <will@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/amd: Fix sysfs leak in iommu init
Message-ID: <Zl7_jphVNJiFZ0_o@8bytes.org>
References: <c8e0d11c6ab1ee48299c288009cf9c5dae07b42d.1715215003.git.llfl@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e0d11c6ab1ee48299c288009cf9c5dae07b42d.1715215003.git.llfl@linux.alibaba.com>

On Thu, May 09, 2024 at 08:42:20AM +0800, Kun(llfl) wrote:
>  drivers/iommu/amd/init.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.


Return-Path: <linux-kernel+bounces-188717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714998CE5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D751282752
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021D86266;
	Fri, 24 May 2024 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhXiuan4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8484FCC;
	Fri, 24 May 2024 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556571; cv=none; b=EumInHy5xXrp8lxT4S3mSoSKtQ4K3pEaRbNJYGguv+GWc9Rp5Ea3ZT0fb8OePlxyVyCW18dEEm0cERdNEghMuTcYPvLCyK8goek9xU0z2QfUsLC/r91Z5V/j8MDAOdO/c04yFSm38SlIJntVTBn9PcENRdRO0oiLqvUgYz97fo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556571; c=relaxed/simple;
	bh=yvRey41cSJ4Tx9YDykOWJwTCnmPWvyr7huBbbI0JBE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNUx8CVGCuIiW8bXAf8klP0FglWjIMzfxA4lgvQZfSovHozFpOmvbxZ/fudw0SmIJRhXnF/U/e6mq2J9uU9tQy/cnFYZSS79BdF2jwf8ZL5pSHfTkld9WLFs+qMTjHfQ830E0ZVv3KnoCcA2MgO+u7z/5xKHD65K5zCKBV3b54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhXiuan4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9D8C2BBFC;
	Fri, 24 May 2024 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716556570;
	bh=yvRey41cSJ4Tx9YDykOWJwTCnmPWvyr7huBbbI0JBE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhXiuan4XxFbIV+CDscdknyvp54IwIuob57viQ+5r1lkUs6hmDRVC2aIJZmg3sG+m
	 Oe07dYaqPbkgCXuS5kgSADrNU8da5eMbHu3SX8D4lXT5a5HBis29zAr2vh64dRFux2
	 PMW0LACWuEZq3ivIVFQ/sgFuEO9q2JVVPxkVxUZE0oyhBYnh8Hrj3s8OAtpaPpbvKT
	 dv0ffKf/NvZEU3PnW6jQkMZ7Qf/qKM2M78udslgaF1QuGgooOtNqKDcWnwzg8+ozWB
	 IEjIzvYCK2Ba2XlAI9I8B0TRdmIKXSuI8w18UjpbNcpNqtrGGjlaw6ek5CRaK9H3PY
	 5J2eRRmiEl6cw==
Date: Fri, 24 May 2024 15:16:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anthony Iliopoulos <ailiop@suse.com>, cve@kernel.org, 
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26821: fs: relax mount_setattr() permission checks
Message-ID: <20240524-denkbar-rechnen-470d602cf601@brauner>
References: <2024041702-CVE-2024-26821-de6b@gregkh>
 <20240514124939.77984-1-ailiop@suse.com>
 <2024052328-favorably-gesture-7495@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024052328-favorably-gesture-7495@gregkh>

> I'll defer to Christian if this CVE should be revoked or not.

As per my other mail, this really isn't a CVE.


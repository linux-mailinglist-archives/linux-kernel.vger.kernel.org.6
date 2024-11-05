Return-Path: <linux-kernel+bounces-397280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0279BD9D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E747284429
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8573216A1A;
	Tue,  5 Nov 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVrWEyZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD021018F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730850251; cv=none; b=gPJNIxYhPhPt0IxSzPhDs4H+mSF6jJPrBtUz9N+K/+C+e0KAFxwgv4AuuL7ip69yKOY7MOAxklbONaHLZ5mDkX3ijYdyHLW7kSr+rF4VsaELXzp9EqhJy409s1h8oTQiAT9ZtnDy0HBuqL9tGgwckamNhudgTQRPZOaiZB3U1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730850251; c=relaxed/simple;
	bh=eOLAW9Eh6GBII0G3MdTF3Wddd7AKrXW/KrBVPzeok5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZ4BEdlu5NHob3rL+Hra6LpgJvhM8FliYVuv7hxoiY4BtkpVRTBoozFw2VxKhLeKohRMpBTHXA8P5MSgB+Hv4NJPE09C9WgyaYZ7Haiyj4J6fWLFYyZJ6apfSQD0QDZ+ryxdZdbTsAjTY6JvA7uybDBsfWv1NVldGAVamiB29Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVrWEyZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C37BC4CECF;
	Tue,  5 Nov 2024 23:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730850250;
	bh=eOLAW9Eh6GBII0G3MdTF3Wddd7AKrXW/KrBVPzeok5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVrWEyZWNbzF8bOmCcWgg+9iIJJcee7LDiN3SrITYFBV2RWLh/OHUdfLheBpadLdF
	 ML+PFMvA24wVIws+92N1tX8zZ5HDT7KeHoh0Id2C/XUbDNITX04sJzGhijZLekw1PD
	 PKt+4GdudGDLg+T0nkrEswi/Qj3SN03Jp18vWYrLetVFy2yNIsfUOrH0wYeQ3Cejv6
	 1uDVF9ZC49Rg8Ap4i+DEN50SgFxPRvuctukJG9sc9y43pjwie+E77dL7f8BEVSBQhA
	 Ade10BRL8l6FLnXqB2y4m+amAR57Asg6t+j9FPpgWubDjPwiq4gSwyYCYuRjcZTlWR
	 3kQSXwzuI6nag==
Date: Tue, 5 Nov 2024 15:44:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Liang <Wentao_liang_g@163.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ionic: fix memory leak in ionic_probe
Message-ID: <20241105154409.62e5afd2@kernel.org>
In-Reply-To: <20241105053433.1614-1-Wentao_liang_g@163.com>
References: <20241105053433.1614-1-Wentao_liang_g@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 13:34:33 +0800 Wentao Liang wrote:
> In line 334, the ionic_setup_one() creates a debugfs entry for
> ionic upon successful execution. However, the ionic_probe() does
> not release the dentry before returning, resulting in a memory
> leak. To fix this bug, we add the ionic_debugfs_del_dev() before
> line 397 to release the resources before the function returns.

If you haven't reposed yet please make sure you CC netdev@ on v2


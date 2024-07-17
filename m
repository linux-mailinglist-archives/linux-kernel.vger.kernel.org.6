Return-Path: <linux-kernel+bounces-255681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981C9343AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043462838C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A2187878;
	Wed, 17 Jul 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2aqrtnH6"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E4186E39;
	Wed, 17 Jul 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250722; cv=none; b=sfYO9uOCnSb6kAsQPszHTrhd1kGGkQx/cneQ66YX6Uz65GV5Kmj1K6dArXC5xzb13LVP9N6MZIuss0qQtmWpYqCf+9ulD15TdhtXr/4NWVfVpOSxnxE1lCh4f45I6x20F3BTdL44DyhDtpNwvOVkGZuZc9Kv+Oy2EjGbphuai3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250722; c=relaxed/simple;
	bh=lXjIxg6kVtCeYggLBHm9cc95YSNPNu7pgmk2sgJVx8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVNmxN5Cf6FUuyWe8OaHWKeryczqAVN70PPCQLUaVwnocFxU2DoqcP746OAItxw6w4/6xw/jwBzPVKYIjFXyJWqRzKi853CRWmyBxBRjw9ghw2XKJDdeL1y5HSM1Jw69/i6Wwl7DetKIILbcVq0luwAUX4NIcdmfEJA/LpBnVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2aqrtnH6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=daRl1O5N6xm4EFwahTrFoL9VEaEGCtggGZYXjyzrFMw=; b=2aqrtnH6m2ZefNNBp4Sx005Eip
	rQ6u+0cG97K7btH3Pnr7QKzOGwWfXVUsKvPyn74zcXojAg0wC1lxDelFgTyNwZNQTEr/fZvHh1r7U
	aFxvzynyxaBU9t3KB2HhcrSSGRibeXhGKWVHkJpBQMQJpXekTtIdKB/6MbMJIN2Q87fO50iqKyynU
	NcVeUvbR3jmFlofa6y9ocEVab3v/MQyZ7EWx+gBzo2dppInDiSJNaGzN4qfLOL725IvGP1n29/OIm
	RKAhA32DuEJA0nwIBUQnF3/oV/Lhk19k8ywf6KBeojHcVUn60JDgiQ3mM27q3uyqLwqup0qUEy/A+
	D7BhAdXw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBwI-0000000EvwM-2r50;
	Wed, 17 Jul 2024 21:11:54 +0000
Date: Wed, 17 Jul 2024 14:11:54 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add detailed explanation for 'N' taint
 flag
Message-ID: <Zpgzmv0-Pll3856E@bombadil.infradead.org>
References: <20240717203521.514348-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717203521.514348-1-bpoirier@nvidia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Jul 17, 2024 at 04:35:21PM -0400, Benjamin Poirier wrote:
> Every taint flag has an entry in the "More detailed explanation" section
> except for the 'N' flag. That omission was probably just an oversight so
> add an entry for that flag.
> 
> Fixes: 2852ca7fba9f ("panic: Taint kernel if tests are run")
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis


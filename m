Return-Path: <linux-kernel+bounces-284505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9989D9501B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A2B1C22087
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBDD17F4F2;
	Tue, 13 Aug 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FcszDFKD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE6187327
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542883; cv=none; b=rjtTrCyjZI21YqAvR4wqSL9tzm9uIOY3UMhI5xrp5PuIauxG25cHBDw33IzU5N3Wa7ekKF/YFEQef4rhWZbo2wmkaWs5XlJktW/Rr62sdXOJZW2zKz3wYKquLASCSLHvzdEanX6xFWJuTGoLfpQlqJgZIzEctP/KLeaenRDA9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542883; c=relaxed/simple;
	bh=u1YpO/v8Sx4bwPpP1ne3NdBxiBQL/QriTgOKf6uGowU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOZ6HgvUMq69urSMvSEIERBna3W9x3JgJTzUyxVsyAVxqqLRO4uZQ48dCOtKEQAM3ydFl/tiSIvIJsxihsBOLX9+svi+JqAArWj0fEXAkoyDG6pqHPTFYf62+VEAkIMlZr9qXHEOU9+7aULcpETyH4OtGvs5dfTaSE5qFMaOfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FcszDFKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2510CC4AF0B;
	Tue, 13 Aug 2024 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723542882;
	bh=u1YpO/v8Sx4bwPpP1ne3NdBxiBQL/QriTgOKf6uGowU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcszDFKDKIzoo7bdELIixAL2tQ4XqCOrsrqU/ICEjSKhCycHMCQHYuEuDK5EeyOxM
	 F+ADRIDpOCCBvJPqB7qr0v5fM5L20JkFF1x0zFfyMuWHUeIMT9hU6vEQzMSBaAqbk8
	 Tv0vzg97A64DJ2nDg3q7Oxb0rApkNI9GjaV0LxXw=
Date: Tue, 13 Aug 2024 11:54:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Eric Sandeen <sandeen@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs show actual source in /proc/mounts
Message-ID: <2024081303-bakery-rewash-4c1a@gregkh>
References: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net>

On Sat, Aug 10, 2024 at 01:25:27PM -0600, Marc Aurèle La France wrote:
> After its conversion to the new mount API, debugfs displays "none" in
> /proc/mounts instead of the actual source.  Fix this by recognising its
> "source" mount option.
> 
> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
> Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers

As this came from a fs tree, I'll let the vfs maintainer take it if they
think it is ok as I know nothing about the fs_parse stuff at the moment,
sorry.

greg k-h


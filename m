Return-Path: <linux-kernel+bounces-563057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43705A6366A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5380A3AE00C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1DA1A840A;
	Sun, 16 Mar 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zibse1rd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE3187FFA;
	Sun, 16 Mar 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742143175; cv=none; b=SWHaIg3Uxfpv8Y3v7e1zm/w2oCODNjv2kDFwNuvKQWqBkU9AixA/RTQnQ1sH2jloUmUVWErVaV65HuiPVJliyynun3qFLztlXC4J3hrY02KIOdTff5VQ0dtVSz86EmrdhhlPppzfFDmsKSFEnLlICNW47Gh7jhFS5o5xc9nURwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742143175; c=relaxed/simple;
	bh=J92TEHW24c/R5Wwa3xtdoSx/C9s8UM9zcXueocCi9bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYJcCkd2ut761tQlGHRsta03g5UxSWgXutwiR0trFsJRcVmUIfqKJ8SZ2hP9nWEJVi716FDHSR4jZ23damY654pB+e5oj99irnaO8QZa9Velb6DniBlnTNBlwYI8o4uQwRe37Oqpe0czJrYSwxkruVQU12RYazbXZdnHJfGqSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zibse1rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8A2C4CEDD;
	Sun, 16 Mar 2025 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742143174;
	bh=J92TEHW24c/R5Wwa3xtdoSx/C9s8UM9zcXueocCi9bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zibse1rdfvQyI7r9oNvGhtr5i5bqOEQ/ZVhgD2QCmZIPdsVRB/3T9EGPDev1EgAB3
	 NX4SUq+nV71kZi6AqYasGvb/WhHvf7720Maqhkkvqk9DGILCR/ffjePeNKnseYWWG7
	 npLzVYIAzh6okW4xxpGXkcRTkVJI0R7Mm5MTpb8uSnwQ6IL4dREBQPYmnQ9xrigk8d
	 m+9bMdhoihpTxEQ1dtBs47XVMDnEGNCgilJJNP6OiK7B9lTI54C61Y3lAwUqe9Your
	 iQ70mYEsXi/FI79uFj8ryqEBp73J3Kl7qozaJWL1n+hy8wtYsBZfOqH5ZrgiMR13A2
	 bPQxE3LN+gqIA==
Date: Sun, 16 Mar 2025 22:09:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Zhou Yanjie <zhouyanjie@wanyeetech.com>,
	linux-phy@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	kernel@pyra-handheld.com, linux-mips@vger.kernel.org
Subject: Re: [PATCH RESEND] phy: ingenic: fix unbalanced regulator_disable()
 warning
Message-ID: <Z9b+wSNdyE1hN+cn@vaman>
References: <96da5fe557f3b2501447358895bd78decc4633ef.1735482146.git.hns@goldelico.com>
 <ab308c135c3ea5e050bbfb0b94a832c8d52d5380.camel@crapouillou.net>
 <AF49A39E-0534-4ADC-8E50-606A636D167A@goldelico.com>
 <c67e2ecbcdf481cddcc4c93716e38049e53d3e93.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c67e2ecbcdf481cddcc4c93716e38049e53d3e93.camel@crapouillou.net>

On 14-03-25, 11:33, Paul Cercueil wrote:
> Vinod, can you take this?

I dont seem to have this in my queue, can you pls post it again

-- 
~Vinod


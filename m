Return-Path: <linux-kernel+bounces-363408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0975799C1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1539283D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8440814B94B;
	Mon, 14 Oct 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKTYpcci"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0213D612;
	Mon, 14 Oct 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892159; cv=none; b=PhiwPQa3KfeabBdms1O3j6aLExfruWgtgTd5kG7dgnmllWejSeUSiunrGoGDbBWP65HFQptY8+4cdQR+9Mblyl84ChnwGG/KeGew110j7+x83CXgCgKk1FK7TgH1V/SVM01KQwJRLm99jIusJwU/f8fLysL8+AQKzK09AfddZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892159; c=relaxed/simple;
	bh=K23Y0tdVKKxj6GO0vDVVjR0PFjnp39PKPKDEECDZYDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEXuHP7DCYSyZ/RfhIIBn0chqEEeuk6I6x26bzqjksYXRoP4KU/y30Z65CDMYUOSaPgvWX2FZTZuJtgndwSApzluRLMDBEyp5YlPo+SyYmtLDzWvZWLPMmR7IPwxNm3NSiAlRbdQa4feP++q1V/TxigE3trHVBV64U9bSaUIiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKTYpcci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804E6C4CEC3;
	Mon, 14 Oct 2024 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728892158;
	bh=K23Y0tdVKKxj6GO0vDVVjR0PFjnp39PKPKDEECDZYDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKTYpcciwqZzzNZb+8Wzu9aKWNP0j/7+E7BtR7Rd3X2UjQI64N/XpccinIAJ5a8+8
	 kmfl7sHFNCoa+6BEdJ6MqW04zkMa/cEsrKS5NfMGD6pja35IIp+wynMYQnSsn91Kam
	 nfIlWyNDlzTpPripz/SojRmcH11J5P9aPbfyLa+r9TYZTfdoXz+wSnB/lzGgFyL+fv
	 LpU3UW6Lfs1r4V2z/0QiwNKQUL1uZbTdvh65QQISKA0fuWSEOnKJDc/LOQDJ8TPidP
	 k439Ps1yR2bpqQ+3bAoZheZgkvQz3ppcvw2eFCAnQ7lmUeVU5vzIdbKaja57hu0NmK
	 Xl+MqXlsuvdYg==
Date: Mon, 14 Oct 2024 09:49:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: devicetree@vger.kernel.org, robh@kernel.org, saravanak@google.com, 
	linux-kernel@vger.kernel.org, upstream+devicetree@sigma-star.at
Subject: Re: [PATCH] [RFC] of: Add debug aid to find unused device tree
 properties
Message-ID: <7aq4nedii5jgrlg54kzyi3plri6ivheeo2kpxxg7q6ofr3wfsc@acsrg5rzzmzg>
References: <20241013200730.20542-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241013200730.20542-1-richard@nod.at>

On Sun, Oct 13, 2024 at 10:07:30PM +0200, Richard Weinberger wrote:
> This is a proof-of-concept patch that introduces a debug feature I find
> particularly useful.  I frequently encounter situations where I'm
> uncertain if my device tree configuration is correct or being utilized
> by the kernel.  This is especially common when porting device trees
> from vendor kernels, as some properties may have slightly different
> names in the upstream kernel, or upstream drivers may not use certain
> properties at all.

In general I don't mind, but I have a comment about above rationale.
It's just wrong. The point of DT is to describe hardware, not the one
given, fixed in time implementation.

What's more, writing bindings mentions this explicit: make binding
complete, even if it is not used.

Best regards,
Krzysztof



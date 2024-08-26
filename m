Return-Path: <linux-kernel+bounces-301828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4012295F62E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42E6B20FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6635194131;
	Mon, 26 Aug 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV+HBdJL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C981547E9;
	Mon, 26 Aug 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688752; cv=none; b=LNM1V5JjObk4xeC2twFwHJSrd25dzRoUJcfEqEd50nUlzeI6kP9YXbR5MU0SUVwqx+Fea9TMosUv2Q+oqVzvB7lmj/A+GbGpAIGz3PcCta1AFTzwYm/SCmNrjC7Ejabv5hhsaj02xmx+J8lRg7lXjbzBggOkD6HsrCBDdK2V5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688752; c=relaxed/simple;
	bh=6DJpmWOUDo869DX1S4D15TNaF1xF5FamBQEd02e/+AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6U3xn73fR7MxeQzTXpAX687nkqI6fo74QBTR9kBu5nn73Yn3eL6MKl0sdg5zYfn8eruufIAgv5M+g8zjHnJ+NB2/3k3CIipxbUo7v1aKUdtmNnSEX4FbWqqojf9kNJD3oxI2LSQjwz9LXLTc/AYi/W6rL67ZSHTzG2Zz15CO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV+HBdJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59217C52FC1;
	Mon, 26 Aug 2024 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688751;
	bh=6DJpmWOUDo869DX1S4D15TNaF1xF5FamBQEd02e/+AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PV+HBdJL8GkttpSnjfKvCyykHDokdpFKTF8Fhl98J2p73UtYE1TJp0hUY7WQorB+E
	 cbR7u3U8fHXkqgE+kY3Z48V+8UmZj3POzxDbYWzvHEFil2ACLaYupB4oVsLwV/ThUJ
	 4GenfoAZ7l4FtuOp+KKLd440Y7R7SnFpKr65+fdTSExqQdPSak8sZeE3n0DzcMEZTZ
	 hxKTbzNSY57fkfzOhpjUguNCgf/n36Tgsl/cLkA7cAC6ZY0/v829DH6+frZmXUBxC6
	 esraS+IjdHqWl+QvFJ6ki6YxUNh7D5Q5QXh+BRLDhR2d5yBC8fVq6A9sWLa9LrTbcw
	 SoQOG5Oy7GcGQ==
Date: Mon, 26 Aug 2024 11:12:29 -0500
From: Rob Herring <robh@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzk@kernel.org
Subject: Re: [PATCH -next v2 0/3] of: Simplify with scoped for each OF child
 loop
Message-ID: <20240826161229.GA326856-robh@kernel.org>
References: <20240826062408.2406734-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826062408.2406734-1-ruanjinjie@huawei.com>

On Mon, Aug 26, 2024 at 02:24:05PM +0800, Jinjie Ruan wrote:
> Use for_each_child_of_node_scoped() to simplify code.
> 
> Changes in v2:
> - Merge them into one patchset as Krzysztof suggested.
> 
> Jinjie Ruan (3):
>   of: overlay: Simplify with scoped for each OF child loop
>   of/platform: Simplify with scoped for each OF child
>   of: resolver: Simplify with scoped for each OF child loop

Applied, thanks!

Rob


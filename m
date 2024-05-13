Return-Path: <linux-kernel+bounces-177435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436068C3E88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C281C215B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B89F1494AC;
	Mon, 13 May 2024 10:02:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F59148FEA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594536; cv=none; b=CDirvmCFYpGZSL776t0UpCuvkaChRbpiAHA/DeNsNwhsQgH9qmBIScc0Ri370mLfQy+lEZcHu+rdCCShPfxy04HDstaiHlOn+pyE6blVg59gCDpknFuLoGaKvKtwBM9uyXThUiI3Yob7rT0On3yYlhqdeWAEKQYcSVWytb64DIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594536; c=relaxed/simple;
	bh=SYcEIxfBwNPFTPph65lP/0ihilEfCBYGFhAT/9HGFBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyUrO+R8JZqf5YfXLUlJ9h0NKzJA+e5YUpEkEBUJWScEUEQjNuViBaOeHC/UDN68sOobB48duR+wNXjcyDOwtwm5U5T/ALiRyynPVBNvyXFa+d20flT8GmapOWTeBGM7lyLPHNfAr/Kvyc3NPG6KCnxHsAuE7cX5yq8lRIJ1e/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D046B1007;
	Mon, 13 May 2024 03:02:32 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2793F762;
	Mon, 13 May 2024 03:02:06 -0700 (PDT)
Date: Mon, 13 May 2024 11:02:04 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Sudeep Holla <sudeep.holla@arm.com>, julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 0/2 v4] drivers: arch_topology: introduce automatic
 cleanup feature
Message-ID: <ZkHlHAj1aPEToEYO@bogus>
References: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240513081304.499915-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513081304.499915-1-vincenzo.mezzela@gmail.com>

On Mon, May 13, 2024 at 10:13:02AM +0200, Vincenzo Mezzela wrote:
> This patch series introduces the automatic cleanup feature using the __free
> attribute. With this modification, resources allocated with __free are
> automatically released at the end of the scope.
>
> In some cases, modifying the structure of loops is necessary to utilize the
> __free attribute effectively. For example:
>
> ```
> struct device_node *t;
>
> do {
>     t = of_get_child_by_name(..);
>     if (t) {
>
>         // some code here
>
>         of_node_put(t);
>     }
>     i++;
>
> } while (t);
>
> //       ^
> //       |
> //  device_node here
> ```
>
> To use the __free attribute here, we need to move the declaration of the device_node
> within the loop, otherwise the automatic cleanup is called only at the end of the
> function, and not at end of each iteration of the loop, being it scope-based.
>
> However, moving the declaration of the device_node within the loop, we can no
> longer check the exit condition in the loop statement, being it outside
> the loop's scope.
>
> Therefore, this work is split into two patches. The first patch moves the exit
> condition of the loop directly within the loop's scope with an explicit break
> statement:
>
> ```
> struct device_node *t;
>
> do {
>     t = of_get_child_by_name(..);
>     if (!t)
>         break;
>
>     // some code here
>
>     of_node_put(t);
>     i++;
>
> } while (1);
> ```
> The second patch eliminates all of_node_put() calls, introducing the __free
> attribute to the device_node.
>
>
> changes in v2:
>     - check loop exit condition within the loop
>     - add cleanup.h header
>
> changes in v3:
>     - split patch in two
>     - fix misalignment
>     - fix checkpatch warnings
>     - replace break with return statement where possible
>
> changes in v4:
>     - fix commit subject
>     - fix coding style
>

Looks good now to me.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

It is merge window now, so there is a chance that it may get lost. You
may have to post it again at -rc1. Greg can then pick it up for v6.11

--
Regards,
Sudeep


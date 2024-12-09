Return-Path: <linux-kernel+bounces-438381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C169EA070
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1961668D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F031531EF;
	Mon,  9 Dec 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmZGLU36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91731991A5;
	Mon,  9 Dec 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776798; cv=none; b=HquBXpXsjjvwxSBSSBfNcFbgo+RFjEhi+VgA9KFU4+adnAs99sHwyOixXHCu6DOea0KfqzpchXX2QnsxYH7FLhEIVu/djRm48EmgTJZ2V/B+Fk2FQbckRqlZm6iSgqV0vZtgbx3M82dLiFwhD7WnjWslhVgdkLRifmaVGdZRAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776798; c=relaxed/simple;
	bh=fFJ76UoJhie9GWIhUrvHqJfBebzJhhe10estH3UO9Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke15qr9/XglBlXvLRK6mYnvYEqBE6JLu7Ofn+HyqsRLAxKjYYVE+YRlLPWKVzA249p2Kf+5c+tmM9N0kgCO4PmyzJIUPL4lcc/Chl2Cvki8qFUAYZ0oSrC+EgdCV+NkZwcFH4spY8QcPEVjO1DGfhhdHY8sNaUFSbULPb54YWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmZGLU36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307BEC4CED1;
	Mon,  9 Dec 2024 20:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776797;
	bh=fFJ76UoJhie9GWIhUrvHqJfBebzJhhe10estH3UO9Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmZGLU36+2VA9r4MpKqGzjlhZ0859mvCRBgs/OSksfCE16IuiqERESml2JD7B92Ro
	 E+m7OlDywVER40yzHyk+4laOqHYQjPqyjpIt+BZCUtGBrzwIdgT7S2uBwbc6Dbwm2W
	 l0HfAmCZErmHmy3gJiqVIvvWAFQ0jNhrR9OZe75mIBX3ojdcvi3SS/c/dPaQqhA8Np
	 P7BfHp0c1u/TPA03bHLk46uzpDPUcekf/G95bfaOkhTQa8eAR0+u8rMug7qXUHnhvG
	 ezNH5s+c9XaWKFmpJQcLRKls9pz6hVxjr2OlyJIX5L7oV4BDw3d76jYIXuw+meQFBn
	 wMvotQ3mUAHzw==
Date: Mon, 9 Dec 2024 14:39:55 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] of: Hide of_default_bus_match_table[]
Message-ID: <20241209203955.GA938291-robh@kernel.org>
References: <20241204194806.2665589-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204194806.2665589-1-swboyd@chromium.org>

On Wed, Dec 04, 2024 at 11:48:05AM -0800, Stephen Boyd wrote:
> This isn't used outside this file. Hide the array in the C file.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v1 https://lore.kernel.org/r/20241204000415.2404264-1-swboyd@chromium.org
>  * Move of_default_bus_match_table into function so it isn't unused in
>    different configs
> 
>  drivers/of/platform.c       | 23 +++++++++++------------
>  include/linux/of_platform.h |  2 --
>  2 files changed, 11 insertions(+), 14 deletions(-)

Applied, thanks.

Rob


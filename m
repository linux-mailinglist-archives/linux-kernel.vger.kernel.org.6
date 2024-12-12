Return-Path: <linux-kernel+bounces-443444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BC69EF0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC97A17667B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EBA23FD16;
	Thu, 12 Dec 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo3M0O7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7053365;
	Thu, 12 Dec 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020126; cv=none; b=O1ymiXAkGPwNYiTvIpKyIVhMElNWPN5y3jVXT8JAjSsuKu3/7hkWkQrXNEpL7/iE2Iadnuqaj9h03NFuNrlqSeJiiJsCU08nklBdUngFTXayz3Ae9BGSWUxGfdqiFEomiR29l6EHkaerN6rdgyPlv4KU5vY5dyNJySTKzMOjSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020126; c=relaxed/simple;
	bh=US0sNSA9+vWU77C0dKGx5HEPtf3IqHGi45uXTp6uT90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bqvVlwUcPTvCFeERVbICXImnGxOcfvb9MssNRG6j4jjzqc0Jb5DrPWQG27Ek2C0PChz1X3SNvtc+wcwpArYMbHED6TFJv5pZQfDOl/OretOe5roKMyt5unVr/N2UvgS/UiJUcfgPhO9Ew+6yFnqYLWNbyyOiempG6eIOg9eft3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo3M0O7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C380AC4CECE;
	Thu, 12 Dec 2024 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734020126;
	bh=US0sNSA9+vWU77C0dKGx5HEPtf3IqHGi45uXTp6uT90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bo3M0O7NEW5DrPsa+237O22XtQJZW9dTotn6RtDp6LWegudmtbYElUOb0y9R041UG
	 643Kb6M1zNYDFRdRKdUfVg65klYDRBVhNHuRQBulAPSSSwnJYZp+8mG6in53Cc7DxX
	 iVxeLqwMJpXwgHVj/Fu8fne8LxtofEKK/PkuDCMi45i7rvue7UO56qehqi1o0lem2K
	 RAtPmxHOLbgbqf8kt4YvRl/BDPvCg2P3VO6H/olO99JX7VoBVk272msh9SzXNxDjKA
	 cgb3anQh+slDUqL1MTZZ32GhUEDqp6mmu+72Sq4lBcuZpetk7sn6O1cnoOYZOEtWop
	 wVhHYLRvHkxGQ==
Date: Thu, 12 Dec 2024 10:15:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
	corbet@lwn.net, linux-mediatek@lists.infradead.org,
	danielwinkler@google.com, korneld@google.com, andrew+netdev@lunn.ch,
	horms@kernel.org
Subject: Re: [net-next v1] net: wwan: t7xx: Fix FSM command timeout issue
Message-ID: <20241212161524.GA3345429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212105555.10364-1-jinjian.song@fibocom.com>

On Thu, Dec 12, 2024 at 06:55:55PM +0800, Jinjian Song wrote:
> When driver processes the internal state change command, it use
> asynchronous thread to process the command operation. If the main
> thread detects that the task has timed out, the asynchronous thread
> will panic when executing te completion notification because the
> main thread completion object is released.

s/it use/it uses an/
s/te/the/
s/is released/has been released/


Return-Path: <linux-kernel+bounces-290823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293A95592A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADEC3B21667
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC41553B7;
	Sat, 17 Aug 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDAUB2o/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7868CA6B;
	Sat, 17 Aug 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723915337; cv=none; b=UjRvmIjju2XIKuyUsMP6aJNOx5sRMax1b1zN4MvBNFcH6pTNMrmzxXCXtuky+JD5zGFb0fNyYVOUI+4AW3YGOqAfUDpEiMDjCLlyiPckpQ73PfXF36pHPncoO5WMBEqVW6xToc6Q0LeCVKqfj/AOaZuvFIZWSy6ttZTR9XTilOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723915337; c=relaxed/simple;
	bh=n57V2n6qB1p2CRm5lVFnsktoLwCp4LRoBmc16trGWxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLKJPRRGpqtjSUaq+s32umJ/f9z7z3W+Vv4xSiz+0Vxfd6iU6/lWv69SyKZM5G11BIJf9hg0OJgx5viD96rlYYDI821jgW0p7hnf/ddMzSWRw2zMMEUlhJqUy/uhIacMABXJHad3EBEVJDq0Sa6vlMF+IIh3RrdnLyxkWmzSoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDAUB2o/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D7EC116B1;
	Sat, 17 Aug 2024 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723915337;
	bh=n57V2n6qB1p2CRm5lVFnsktoLwCp4LRoBmc16trGWxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDAUB2o/HaPbZUa5DNABVPBfH6N39PG5QZxN/42MqPF8/VWSWZny3HOjTh/NO7N8a
	 98Ygpd2dQJmOprmTRb9ip/OP+9KHr4yDZwoMYC6RrlHXxH0fRQu5MiJZQkbfH+eXQ4
	 8u6y/GH16Y7c1kfurzl4laqz72765KPYPPSi7RoNUON912AVHEVCrAvIKoXgbcyIek
	 gwVivp9bTAdu4ul3AvNwdZtqEg8QwhtHMIM0bpvqWInZ8SBQyM750XBSUquNkrmnb3
	 BIpUOAws0R+zMRjrvvOMvfmWs25+4ScjMKArGtTnn1idrf7XeU/IgTz8ewdSX5uyps
	 4f4Z7sp06rIWw==
Date: Sat, 17 Aug 2024 22:52:13 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	tiwai@suse.de, broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 3/3] soundwire: intel: add probe-time check on link id
Message-ID: <ZsDcRWviIZPu0/DH@vaman>
References: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
 <20240816023331.6565-4-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816023331.6565-4-yung-chuan.liao@linux.intel.com>

On 16-08-24, 10:33, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> In older platforms, the number of links was constant and hard-coded to
> 4. Newer platforms can have varying number of links, so we need to add
> a probe-time check to make sure the ACPI-reported information with
> _DSD properties is aligned with hardware capabilities reported in the
> SoundWire LCAP register.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod


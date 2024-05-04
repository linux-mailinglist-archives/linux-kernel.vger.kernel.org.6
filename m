Return-Path: <linux-kernel+bounces-168660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6948BBBA1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F59C1F21F80
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AD22EE9;
	Sat,  4 May 2024 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsLDu2wt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649CF1C695;
	Sat,  4 May 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714827386; cv=none; b=E014eDqp8JsldcCZd0IKtOTH3mPCFKHZKN6zTv6LJ5MclLVucJsulJnOH7ZGXl9Buz5wfJLkbWQMyySROWe5u8+igzjVc2UURuPtd7S3MN1c0fv41Su6l2cz1wZ9NIi6Q+PtdtGjTCOiUtI88bCLreJwZ2+pqfL3MeBQfQBKTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714827386; c=relaxed/simple;
	bh=/S4G8XfJkMpXGtDusfPkIrZMVnvP5OxcQ6MlRbPqAHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP/8hlZq5h37zKZrn3ywnsx4c82wQkUO7shmrkCJVDM3qOCYzraq9DxI+J0wHT+ixf4muq5BU/iSm3S+RxWq3m6iMEthXfkGT9Xp6SwwyiMNUbzO3wGsTBF6LDVa93rLcynwJfCMZSaeIO23K51Qt0x83ovi71FgrjWyPySPoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsLDu2wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE462C072AA;
	Sat,  4 May 2024 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714827385;
	bh=/S4G8XfJkMpXGtDusfPkIrZMVnvP5OxcQ6MlRbPqAHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsLDu2wtbbytY8Ch0AKfpA4OSEON8edqnyWuKkQ09denVcmCnV7iWA0YDwPOFq63l
	 70ntRUHR3gIeHsjaPQxaeBv26IUK3q0wAjVtf57t5NKYApUrlJ684S5JEaT4rZM8s+
	 RacWf45lG5h+qtfmSm4wCgp6rJfLcT5Ze9diOk5G9t20ZfT+o8a3SXbsl/O3AZcSuC
	 KZQJUFhcuilMfFTjncyHgsUCk0SZhlkFFGqfjLFsk/XPpKkL7WGJCGFZqA3fzMoC0z
	 lCzsGMhVcOu5/F5YyVPc1ing5l4ZWtMNPijiEfd3oOL6hhMhPfcFm7IJKDgFFb/BUS
	 daHChHerP5FsA==
Date: Sat, 4 May 2024 18:26:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: fix usages of device_get_named_child_node()
Message-ID: <ZjYwdHKKNrQDxpKd@matsya>
References: <20240429004935.2400191-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429004935.2400191-1-yung-chuan.liao@linux.intel.com>

On 29-04-24, 00:49, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The documentation for device_get_named_child_node() mentions this
> important point:
> 
> "
> The caller is responsible for calling fwnode_handle_put() on the
> returned fwnode pointer.
> "
> 
> Add fwnode_handle_put() to avoid leaked references.

This fails on sdw/next for me

-- 
~Vinod


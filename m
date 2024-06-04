Return-Path: <linux-kernel+bounces-200197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F42298FACAF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77253B236B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA01420D1;
	Tue,  4 Jun 2024 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXeYsUYv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DE1411F8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487753; cv=none; b=UxdBy8PtHAsddMTeC2CKwqts5m+S2px7VggLght1ioZRw+gdyWae4dIAIDMCOD5R1DPN9bxLwNBYe7IUKHKyhTk16OuDAch5z9513BmAHG6StrQlwAjDgc/eXWz0w+mlDu2V9U9gM7641EeuVh1xbMg7kMM/IqbwxjMg2K1hVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487753; c=relaxed/simple;
	bh=dxxQOqEppx7Ss+3/yHWJmVBhwR0KThGNQpkJ6bD/wjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc5ON1/ySHvBgloJDMhMZpWeGJe1P0I5RH0+a9zwY2R8byw1h7olM0/hcqJZGNc9BPUz6h+FmhA62CvIEStXjesgqiuuLaHCo9f09LtBo/I1avWuhJ5E51niCy0sTuZJ+qj3EdzBna562nPblBlfbVwZRbS0VyJBh9FEsyBOOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXeYsUYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782CBC2BBFC;
	Tue,  4 Jun 2024 07:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487753;
	bh=dxxQOqEppx7Ss+3/yHWJmVBhwR0KThGNQpkJ6bD/wjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXeYsUYvVb44sEaPLppo/yOShAz9VCmRSlKkFuY9qvs6avo8raPDINO468vPlt/SV
	 owdhRSzKd7tEkNYLGjw2tx5jmsFu7gnvRg5PoF2OGIUekQVSJVQUA3WUKJYtNqx4FK
	 RMZxj7X438woqZZ20c+mCfUvClUcBhS97kFBYezOHbxqVaKeArJDzzBkmfHk81GNhO
	 Hq+8NqJhiGd3cQ/JaHoa6o9oZWZ8Cef9nZrPqfVrXAcztCSc+wn9RROHvbz2Nu2Cs7
	 aLwcWqQ+zlC0LDE4YwN0QMSAiT4/hgLScsuOLZmCyrwfY+LMJZMrbjAqht4ln4DUHK
	 r0R7WJ6QQiN0g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEP1M-000000005UG-06Nb;
	Tue, 04 Jun 2024 09:55:52 +0200
Date: Tue, 4 Jun 2024 09:55:52 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: bus: suppress probe deferral errors
Message-ID: <Zl7IiAp11qP8ndLq@hovoldconsulting.com>
References: <20240603123127.30477-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603123127.30477-1-johan+linaro@kernel.org>

On Mon, Jun 03, 2024 at 02:31:27PM +0200, Johan Hovold wrote:
> Use dev_err_probe() to avoid logging errors on probe deferral:
> 
> 	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -517

The error message here should just be removed as it is already logged by
driver core and does not provide any additional information.

I've sent a v2 here:

	https://lore.kernel.org/lkml/20240604075213.20815-1-johan+linaro@kernel.org/

Johan


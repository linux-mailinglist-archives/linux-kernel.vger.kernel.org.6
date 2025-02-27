Return-Path: <linux-kernel+bounces-535690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CEEA4760C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621243AEB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B721CFFB;
	Thu, 27 Feb 2025 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+ENGLIW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FC15B102;
	Thu, 27 Feb 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638639; cv=none; b=oxfA07EkzSYjjS4OwazVT873o7rmuvUm2QApMa6zHfNCqOujkXIOY8xouK/52dt4IVFtfR9NOUddHYOgZE9BPrE8N+45NTsDYxDgMyoYRoFgj5LvNMV9BwAfBAmRXAY7ijB84FakJgTNXJEyeU8Ta2JxyhDIWeDOFsS7Hyf3J5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638639; c=relaxed/simple;
	bh=LAL9C2dIDVV/qqvptvhJffwvfvQ3/+Dly709lYEcfPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZtdd/2/CMKcN4iSepYoCNLG6BUocTlZmn/CBxDTHIPXxQDIUcQXuDWTAe+4kZY4tF0MU1xMpXq8gYym7nBo/ysYCSG4yPhfSsPQaLJycLygzQLP1ytaFgEFXm2DitX+y7sJgSwLi4xGIoTVs2SkSSo0HDZAvvwaBPi7IOGMT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+ENGLIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010EFC4CEDD;
	Thu, 27 Feb 2025 06:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740638638;
	bh=LAL9C2dIDVV/qqvptvhJffwvfvQ3/+Dly709lYEcfPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+ENGLIWr4oOnN1MItJV4ynASZm2aLcMeEtL8ZnzgbJQTWmtBFnMysxiXYIC1Zlii
	 ajrdKJzsOORqkOk7UKt2+GRxYriDBqLI4L1NPE+5Armcx7Ph64efpy5uSkyCHyE7QH
	 oYr44U2XCCoJz5DInLhTg/rPN1pGMWz6nZUxeXErNH/jI3epoycQeNkQ1thfRR8M/X
	 y2M9I/YHiy4hUIQ8MVQxThOlCSZDoMo9JtoIB+DUco680PGX789H9ugvzhJ5g6LG04
	 eUTqMHuEkrFfiE1RSIeaVnwtyGfySE3mvm30qM1iV6sUZY2d9j2gihFxq5ShSqwn1d
	 s3lTXSUdyy9hg==
Date: Thu, 27 Feb 2025 12:13:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, broonie@kernel.org, tiwai@suse.de,
	linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: Re: [PATCH v2 09/16] soundwire: cadence: add BTP/BRA helpers to
 format data
Message-ID: <Z8AJqo6K7j3176cS@vaman>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
 <20250224064451.33772-10-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224064451.33772-10-yung-chuan.liao@linux.intel.com>

On 24-02-25, 14:44, Bard Liao wrote:
> +
> +static unsigned int sdw_cdns_write_pdi0_buffer_size(unsigned int actual_data_size)
> +{
> +	unsigned int total;
> +
> +	total = SDW_CDNS_BRA_HDR + SDW_CDNS_BRA_HDR_CRC + SDW_CDNS_BRA_HDR_CRC_PAD;
> +
> +	total += actual_data_size;
> +	if (actual_data_size & 1)
> +		total += SDW_CDNS_BRA_DATA_PAD;
> +
> +	total += SDW_CDNS_BRA_DATA_CRC + SDW_CDNS_BRA_DATA_CRC_PAD;
> +
> +	return total * 2;
> +}
> +
> +static unsigned int sdw_cdns_write_pdi1_buffer_size(unsigned int actual_data_size)
> +{
> +	unsigned int total;
> +
> +	total = SDW_CDNS_BRA_HDR_RESP +	SDW_CDNS_BRA_HDR_RESP_PAD +
> +		SDW_CDNS_BRA_FOOTER_RESP + SDW_CDNS_BRA_FOOTER_RESP_PAD;
> +
> +	return total * 2;
> +}

Argument is unused, why not define this as a static value?

> +
> +static unsigned int sdw_cdns_read_pdi0_buffer_size(unsigned int actual_data_size)
> +{
> +	unsigned int total;
> +
> +	total = SDW_CDNS_BRA_HDR + SDW_CDNS_BRA_HDR_CRC + SDW_CDNS_BRA_HDR_CRC_PAD;
> +
> +	return total * 2;
> +}

Here as well
-- 
~Vinod


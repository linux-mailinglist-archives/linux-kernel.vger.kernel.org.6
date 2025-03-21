Return-Path: <linux-kernel+bounces-571628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A3A6BFDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924757A1D89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028C22A81F;
	Fri, 21 Mar 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT+nYsxd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F31CF8B;
	Fri, 21 Mar 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574447; cv=none; b=XaeovVP6T5Cox+tuha6IrHCtzPBdnaYT+5pX2tmaZ7KC+vZsznzxKBNAxvkw6b8ioZ6b7Tml7biYt7YkFgZ5PN77DqxDq55aOwLT0SBPRiQqUqrLFtsVkwlmNySeGr4bF0QVCsojEN1SPpUtoorvQ451BiBtnLrrf40qEaOd21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574447; c=relaxed/simple;
	bh=FYSzolyzTzvIgZRABQCzk1QSRx77QWGdVf/vIRf3dD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeCxd9oRuu2vM25zHCTidD+V2OyBaDL/GV8ACx7rkCfgD/tUSz20b1HrHkJcdgWijJd7RV48AQxCMSHfqM51jiuGVAak9rq/N8TbRiryNny8nNwijacOT9Lwf1ZVRdQ78FI7OXDtZM1oZ63P7WLv8fmPZ79pf374Qs8i6vUsxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT+nYsxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5348C4CEE3;
	Fri, 21 Mar 2025 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742574446;
	bh=FYSzolyzTzvIgZRABQCzk1QSRx77QWGdVf/vIRf3dD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GT+nYsxdu7jZvfga8VdSzN3Yi3//t0jg7wgC6YJNImvHplOt3u3vZGWXVejwblhDt
	 BmC4sXASaozbyJAvjg+LONYZ0/dNU0HiDaDyLZefAJq8hTYU81NFLeCLXpm0I2oGOz
	 b76+I1mtonJaxyWgyEjhH39R3n7zic7ffe3OadyJ2Zf7HJR2G+W6jUZSgraKVCEQeb
	 UsHXSZNI5XBaOqBaKultdHJtkHmMyONqpTjzuT0RrGYAwlVgIb3LF9j7tJ95oy+I4x
	 fUW0wwYlJVHU4mz/vBR6n9uefWEVnvswPycmkhGmBzkSbHENuRVerioY6Uu6GqTALj
	 yOsPYPRN3jgaw==
Date: Fri, 21 Mar 2025 11:27:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] of: address: Expand nonposted-mmio to non-Apple
 Silicon platforms
Message-ID: <174257444287.3482399.2065941130302894765.robh@kernel.org>
References: <20250319-topic-nonposted_mmio-v1-0-dfb886fbd15f@oss.qualcomm.com>
 <20250319-topic-nonposted_mmio-v1-1-dfb886fbd15f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-topic-nonposted_mmio-v1-1-dfb886fbd15f@oss.qualcomm.com>


On Wed, 19 Mar 2025 15:25:57 +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The nE memory attribute may be utilized by various implementations,
> not limited to Apple Silicon platforms.
> 
> Drop the early CONFIG_ARCH_APPLE check.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/of/address.c | 6 ------
>  1 file changed, 6 deletions(-)
> 

Applied, thanks!



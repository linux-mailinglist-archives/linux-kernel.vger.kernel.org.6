Return-Path: <linux-kernel+bounces-571629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5476BA6BFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A279A188CE95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7D22ACFA;
	Fri, 21 Mar 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogXi6D+b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD41CF8B;
	Fri, 21 Mar 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574457; cv=none; b=DEuonhzU5bMny4RaTzLUbIXbshUjR9YLSa7gLNwHajwlLCI58G8/UimrHD8e8qWTUyzN559tHNbOSZ+um9GAXaqzZB2Hi56jSY7TePMRdwf6NIyZwhl0yLk67VBeS255eIEefBKJMv0Qm3McN3ieolJ0ibowSoA9/4GXo6JqfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574457; c=relaxed/simple;
	bh=B9Bw38MOLq2I504dk43mpE4QCetbxecj08UN41MF8L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5Qhd8foryZA26xz63g3gqkXzbnRJ54ioJ8luaALTYR9Ae7lw6EkgivExs6WbkZ2HPXjrqakYIlum898mKVN2mApUpbYnxAZ5hxcKkj/wbh9NjbxWM90sQ06V56koKU7gSWoP8jzcKEt/ZqjifxbzKH2qGZU/l4kH2DyuCKfpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogXi6D+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46101C4CEE3;
	Fri, 21 Mar 2025 16:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742574456;
	bh=B9Bw38MOLq2I504dk43mpE4QCetbxecj08UN41MF8L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogXi6D+bH3v34ET0fXnsU6+7GiPWh6XpD9ijwS3T544ZiNZYAgjTMzCe2W083qz84
	 QfzJxsOxkYJ0I4QonAUgNVUvehQH716FlivFgmikSJ1wcsEz74Ja7bxH9IACyMW76o
	 DiBvUtl9nT5EDgjEzHcQDqhy7KQ+XGRk3vD9R+khULz4aO+BZOc/ybwRPaVUeLV+2f
	 wne4/uSYfI4slSDvSNrsOHlrLj8XvylG1cYae/mVvjQtBM3+gCDWHU5NOJNduiLIAS
	 dTbpSrWWytYwKl2F0Ii1MoYwydrLc4YVhAwJs3s/MNvQ2SXlbPDpYqNVm4dZajrgYT
	 T9tmEcKbkLV+g==
Date: Fri, 21 Mar 2025 11:27:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	devicetree@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] of: address: Allow to specify nonposted-mmio
 per-device
Message-ID: <174257445191.3482772.4977071100416975917.robh@kernel.org>
References: <20250319-topic-nonposted_mmio-v1-0-dfb886fbd15f@oss.qualcomm.com>
 <20250319-topic-nonposted_mmio-v1-2-dfb886fbd15f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-topic-nonposted_mmio-v1-2-dfb886fbd15f@oss.qualcomm.com>


On Wed, 19 Mar 2025 15:25:58 +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Certain IP blocks may strictly require/expect a nE mapping to function
> correctly, while others may be fine without it (which is preferred for
> performance reasons).
> 
> Allow specifying nonposted-mmio on a per-device basis.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/of/address.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Applied, thanks!



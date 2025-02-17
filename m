Return-Path: <linux-kernel+bounces-518015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907EDA388AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EB31769E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14D2253E4;
	Mon, 17 Feb 2025 15:51:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069342A8B;
	Mon, 17 Feb 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807496; cv=none; b=Ynsbw7pi0YiGBsCOXJilDGQjabl3VeYM9Bw4YyG14oIG7hDUcCZLOq9C/cTkAe9EY44NFJZmrSjj10ni1QGnMCLuZuvkS3bt7vMhWVXOx55TwRfely8wKkn7tri+o/8ctL5+1s3x7KYIaCu4zz8qF63YXuj7yy9Hj/GDZ5Q+NWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807496; c=relaxed/simple;
	bh=iCmCrCd3rKRNLebGOJIWoroZ8I7kJzNd/FMCGL/+mFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8vHzRQqjOFUywWn62bjalrm0E+XNtC2M6fOaBOucovJ4gYj7BAyWSftoIjcgjAx32ITCgwvFfHRTuO7RXnSjMDdnuPltAFsLBCXRCwbD2SZi4SquGLBYsDxxr6Vg7gOeRaG067r4gPz/WWE/UGfPpZknvGPWKo9IWvArwy8h7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAFF0152B;
	Mon, 17 Feb 2025 07:51:53 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5E683F5A1;
	Mon, 17 Feb 2025 07:51:32 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: cristian.marussi@arm.com,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH] firmware: arm_scmi: imx: Correct tx size of scmi_imx_misc_ctrl_set
Date: Mon, 17 Feb 2025 15:51:21 +0000
Message-Id: <173980739601.1667400.18386300454514478201.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123063441.392555-1-peng.fan@oss.nxp.com>
References: <20250123063441.392555-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 23 Jan 2025 14:34:41 +0800, Peng Fan (OSS) wrote:
> 'struct scmi_imx_misc_ctrl_set_in' has a zero length array in the end,
> so sizeof will not count 'value[]', and txsize is smaller than actual
> size for tx,and SCMI firmware will take this protocol error.
> 
> Fix this by enlarge the txsize with 'num * 4' to count in the size of
> data.
> 
> [...]

Applied with some minor changes to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: imx: Correct tx size of scmi_imx_misc_ctrl_set
      https://git.kernel.org/sudeep.holla/c/ab027c488fc4
--
Regards,
Sudeep



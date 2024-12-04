Return-Path: <linux-kernel+bounces-431293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DEE9E3B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C65D168F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1FC1BE86E;
	Wed,  4 Dec 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neemGZuE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD518AE2;
	Wed,  4 Dec 2024 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319972; cv=none; b=aXVohDl1XX4dsyhVMHv6F4bgIIqdRuoEH7zdpkvs1xHDEX500SaSxB5dXTvUPKmK7bL36PNeWp2OjLAX1OArRBmyopUCauLm3EO3NyBLI+d7Xap/YYVSJ62xB2vp9u71U44ShpbsVrHlxcRLkGoBMybxdf3I1JJpcUmm/CZd/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319972; c=relaxed/simple;
	bh=ENM0SClxUt2lPvodmnrHzeLBV9BDJq1owuP9D1ySOsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUn8LiMjSAzzjf4HStMIh6QEkW5hWIn5c6ccqRJLKgrqfiCurh7T5QvRJpLTnJzAtiM+GTioisYS6exDTrum7A5HqOiJjvtTL3BAVHun9tfl6n337iMNVC9mbY+lWpm5bPRZT4CqfR6abNnwUNK4DiH9gQUvMqpAtCnDuK6V8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neemGZuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6395C4CECD;
	Wed,  4 Dec 2024 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733319971;
	bh=ENM0SClxUt2lPvodmnrHzeLBV9BDJq1owuP9D1ySOsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neemGZuEgTiKvdyK2nqqBYB/8qfQ02WQDlv9wzIByn8tp5P7+i8Bvs1enmvuyV708
	 2y+DTLhmxW610fCYgDcKAGG1exv2oRBeJCd+yRhFI3hAakWRmsWRFDbnoxEkUyxJql
	 6ybJkg/fRNts42khtGnjNb6KibyexaOwInuQ2AcYCGUVBUFlYOyDdfT4DP9kl/thF7
	 tf3lDdIN5Ldml9S0Tf7i7Qfz1gitRo4lTNtBsBDGAJAGA5fRtcUweosP505AR1vY0P
	 HbYaYO4wVYkJ+HHS85KZPM/1k8ODE8AfD1lLGjL4v9cGhehM3cwvqdpaYGwe71Kxsp
	 eRmjIsDwlthpg==
Date: Wed, 4 Dec 2024 19:16:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
	daniel@ffwll.ch, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, mripard@kernel.org,
	kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com,
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v18 2/8] phy: Add HDMI configuration options
Message-ID: <Z1BdHzfcnj6XJ9D4@vaman>
References: <cover.1730172244.git.Sandor.yu@nxp.com>
 <64f6885b5a5ca89c8214b3138cb58c3133ac2109.1730172244.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f6885b5a5ca89c8214b3138cb58c3133ac2109.1730172244.git.Sandor.yu@nxp.com>

On 29-10-24, 14:02, Sandor Yu wrote:
> Allow HDMI PHYs to be configured through the generic
> functions through a custom structure added to the generic union.
> 
> The parameters added here are based on HDMI PHY
> implementation practices.  The current set of parameters
> should cover the potential users.

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod


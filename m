Return-Path: <linux-kernel+bounces-214600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05D19086F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188F0B247D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45451922DF;
	Fri, 14 Jun 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOBbUW2t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A2183071
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355816; cv=none; b=BVFaNAjFVj5yxJW9vFpLKAFd2Z1oMkD1j+0XKFXgegtJ4d0el2wEgyabUQ8RCYZCn+pugrwA4xLsYtQNawbzirXXUQQHeuyyhNJlWGVLOaq571+t4oUDRAgNIEH3dyL4DFPSJxqp/SyEnnFFALWBP/5V/LzlOeFXfwyUj+iAuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355816; c=relaxed/simple;
	bh=KIuJLVsexTxXnGcRm8RD4wpPx5+W0XT3fjOvYvBHztA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vFvGcwZpIr+Bed98fEMqi6641Yw+S5pvcDHydH7kb/rDLOuMiW2D8RR/H0035FFWb4t1PIsajNmZ+yqiCklbhm7iE3JCYOYIQYYu9tBnHtjcxy7g/46bnQ8vyf911ib44roPaWpHMfoBxIKRWibGq21A2jUBuEq93Pl/dvk6/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOBbUW2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B71C4AF1D;
	Fri, 14 Jun 2024 09:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718355815;
	bh=KIuJLVsexTxXnGcRm8RD4wpPx5+W0XT3fjOvYvBHztA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YOBbUW2taeg3/bgUAxmmDhq6843XipBOHmu/Cb9+TyKuAEYvrdZc8h1KaqPxlD6aN
	 ikLbib2iUSQU5rAfJQsIYzBjQhLDpIVtbXhw1nAIYtEMB967AmIBWZGVaSdTeQde8C
	 MpRfeM5uCeDNzeOYJnaTg+UR4eVDDFSlEhWkmzbQfzmM79F/coAWUunf4G6pY/39z/
	 29MDtkkA4IcbOp3SPYYLkOYeBy1afYNjwrKoE+HP7KzbBlkpYrdeQqD4hZs8Jr5OX7
	 SKjUoFUGXf4cQ9lZb8n7yuI2X1T3K6VXd5cG2BBN9oNNmTiz5ZPYC4csmGChAFWpoi
	 T2+EEV7CvWK9Q==
From: Lee Jones <lee@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240610153824.218260-1-afd@ti.com>
References: <20240610153824.218260-1-afd@ti.com>
Subject: Re: (subset) [PATCH] mfd: tps65912: Use devm helper functions to
 simplify probe
Message-Id: <171835581511.3023088.2828224462452626753.b4-ty@kernel.org>
Date: Fri, 14 Jun 2024 10:03:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 10 Jun 2024 10:38:24 -0500, Andrew Davis wrote:
> This simplifies probe and also allows us to remove the remove
> callbacks from the core and interface drivers. Do that here.
> 
> 

Applied, thanks!

[1/1] mfd: tps65912: Use devm helper functions to simplify probe
      commit: fe6ba540b2ce777eb4f59991c3ef20ad8a319a1a

--
Lee Jones [李琼斯]



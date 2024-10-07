Return-Path: <linux-kernel+bounces-353739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4819931F9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6435B283CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE591DA62C;
	Mon,  7 Oct 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doX/BxVn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37F1DA617
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316136; cv=none; b=Nm0q31sSdKNIgDR9Mf7ubnx9AaqBLE2jJafUDXUOQ3o/0FwLgjSUVgVHORqcGNTC3SuBUMVPTwgFzEJurttgQIXktfJAbl9j7aWvbpJhU3Gka6VHi2LPBTXHHlab/4rgzigbxFXg0/xXT8fhnUampX1n5eOmUaxNbUXWnrgpn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316136; c=relaxed/simple;
	bh=jtJ4cAo+3G5Xe9E7fqOUi4rinpMDDc7GDlhsd6jiJd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aKb9uFwPGZAgsXFrn+6rBtmoBseMAL/xrytNS0Yctbvph+S1r/qa0sOOaQcpIvl0XiKwV9HM9IUKCGRk9c0RiJgoV1VmzmL9ae7cMQYJCs76GvyM9xyfBkBRsnW2o5Zq2o2ZJsLT8BVL4uWboiN5uB31Att4DWHPVTcxkP/oaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doX/BxVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810D1C4CEC7;
	Mon,  7 Oct 2024 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316135;
	bh=jtJ4cAo+3G5Xe9E7fqOUi4rinpMDDc7GDlhsd6jiJd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=doX/BxVnn0XfGxRTn5PZtlsRSgX78t5XzT1er/VzG8qYGci90MHQ8z/xat9DSNkpW
	 7+x9Cnu+ZgkE0KZ7w7hMn693umZnqscd5Kcv7VhlyeDJhQZASr4aVsd7Gp5LkpGoi1
	 I4g6zrk8WBbonPPx2WaqkAymOYAdiUguHcyI37pcT1q70fDnFuAzqdbVTPO34ucYEE
	 jCtwOgjNe8VRAVXwywxv/M6ooEH8GxI+2ei/4nsj6vaRzMr9OvAQ+StRCzb1QprdbY
	 FPzubOnpGcuNwMLR+i8OVm3AJ+pbJvY+iddbWRmS+rxQZ2sNhr9/aP5L0fvf4Sn6hN
	 fxN8KRb0f3stg==
From: Vinod Koul <vkoul@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
 Sam Edwards <cfsworks@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 Sam Edwards <CFSworks@gmail.com>
In-Reply-To: <20241004034131.1363813-1-CFSworks@gmail.com>
References: <20241004034131.1363813-1-CFSworks@gmail.com>
Subject: Re: (subset) [PATCH v2 0/2] phy: usb: Broadcom BCM4908 USB init
 fixes
Message-Id: <172831613316.134526.5485203085922304367.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 21:18:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 03 Oct 2024 20:41:29 -0700, Sam Edwards wrote:
> This is v2 of my previous patch [1] targeted at resolving a crash-on-boot on
> the BCM4908 family due to a missized table.
> 
> Changes v1->v2:
> - Florian requested this change be broken into an immediate bugfix (w/ the
>   'fixes' tag) and a second patch containing the coding change aimed at
>   preventing this problem from happening again
> 
> [...]

Applied, thanks!

[2/2] phy: usb: update Broadcom driver table to use designated initializers
      commit: d3712b35f3c694cb932f87194caafc714109ea08

Best regards,
-- 
~Vinod




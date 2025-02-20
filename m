Return-Path: <linux-kernel+bounces-523953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE89BA3DD4F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EF9174347
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2400A1D63D8;
	Thu, 20 Feb 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4oJNfQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B918A6CF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063039; cv=none; b=UrWkzVIacxln0mAYLycyBOfv7+mp8ccFV7WCBjhwEFZlOa/5AiuoeB2+0JlLoT6UoeIDbQ/kSpXdmvFK6Jr0BG5JWSS0rrzKVgXQ04gPjp+ndhzSmm7v7UggXQQpsU2lV4Co+BimayJcBb36jXszxH6+IXMTdjjTDMgZZMYwEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063039; c=relaxed/simple;
	bh=Roe3IOEGD/x71xVlb4Zp1cz4Gf1hPmJaCvVjbbTCHUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OjZ8vnE2i6rUfmiZnt9d8kbPeq+RbMWRhC0qxBp1xIRqSod1Woiu7CzCA73w2lHxCXp9CXulu1dm6NuvbpfKbv8uPGV1du/Utn8kfpT7gU20hPqcSAKVSig/Ht7yT1Es/hmISfIoJVaGeGuWND2BtkHjBBRrRSLxHDm6NPlWkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4oJNfQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF87CC4CEDD;
	Thu, 20 Feb 2025 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063039;
	bh=Roe3IOEGD/x71xVlb4Zp1cz4Gf1hPmJaCvVjbbTCHUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O4oJNfQSl/teWbYpGNT82/qLfTyI4z4c+QBkDrXneuTAiAuNf5Yisr2S/Mb8SvGOR
	 kdvQ+e/FfbEuNTaxX0mx/36/nKmpI/kp0QDnu3nRTdO2rKc1CpEbQgLI3yIBgGF1wS
	 HQw1EOsV35KCArQ+6Z7o0jhP/SKhoUGjF3l0u+TGC12jTPHAMC9NYpnDZF3FlPkUj6
	 8M+Ivk4W+R1LiFjCIr06rrYXsuq6H/tZdGdyxfS7AnYTLlomXGyDvorAHU83S4tCal
	 UQ7hAUSSGsEyAipwMF8eCNs3DN8xqX3r/3wUdDiQ97HcGUAY8tlyvA77eSXfM/M324
	 0StzZ0DOBn06g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, 
 Eder Zulian <ezulian@redhat.com>
Cc: Mark Langsdorf <mlangsdo@redhat.com>
In-Reply-To: <20250212184524.585882-1-ezulian@redhat.com>
References: <20250212184524.585882-1-ezulian@redhat.com>
Subject: Re: (subset) [PATCH] mfd: syscon: Add check for invalid resource
 size
Message-Id: <174006303771.786915.13630061685822453274.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 14:50:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Wed, 12 Feb 2025 19:45:24 +0100, Eder Zulian wrote:
> Add a consistency check to avoid assigning an invalid value to
> max_register due to a possible DT misconfiguration.
> 
> 

Applied, thanks!

[1/1] mfd: syscon: Add check for invalid resource size
      commit: 9038eaf3666acde967d9cb481bcea882623fa1d2

--
Lee Jones [李琼斯]



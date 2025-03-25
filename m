Return-Path: <linux-kernel+bounces-576196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D089AA70C42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081FB189F5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB63269D06;
	Tue, 25 Mar 2025 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzKoJZFy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB1269CF8;
	Tue, 25 Mar 2025 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938757; cv=none; b=M+I1oMvxoVpU62o/BblIT2ym+rBeAfxh8Lpf8vFFFI8/4EKMEwtN3VkrVc+OjmsmZ8GsGR4ZZIZQQ8J+OgwasNHZhXt+vbikZtLTcE9XJFCTq0DmKBABOw2AZXTTlDQzLYnu7YLTUCu+wf44EwtvF3fRc2FsCmYpf3Xt6Pi86ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938757; c=relaxed/simple;
	bh=rVZQHP1VFgPMmF7qiernxg6g25VDtAy5R/ucMyM61fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pK1dG6YUIa6WqrGfXm6HyB/bnfhgTfyF1nQvJ5tNrcQyblqmp40AR01fyDubjYiqppFBKLksMlwu/dvtacD3E+JLjYCqhvCpMJpF5mbAY0oLI/jZWo6Oy0iBq5MmvFbhrMpcA+buAvy/w2RTX2BT26zVzGvXbxBKHycytTORXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzKoJZFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01173C4CEE4;
	Tue, 25 Mar 2025 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742938757;
	bh=rVZQHP1VFgPMmF7qiernxg6g25VDtAy5R/ucMyM61fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CzKoJZFyRSX8G43053R/JDulbeK4wHl8owE80Kso34BGDZ85v0O9TijshB1tQ3GTJ
	 Pbn5tZZcu3N4djqcYU9mGbwcRZ1B/UZ4oFvIKgXW3j33XjwTYPuQN348ylYWgy6Axv
	 NpQEvxUjFs81Q3xQKBbbADpL1E4NhKsoF36Bs+lbWeKlnNvdrwC+m5eBrU3wHvXnkc
	 zdFxe0Qpu1erwknlf83dNGnGzTYFq8QZf5zIfC2TkdskfZoRaW+ECn/ig636PCkdoW
	 dQt2RimVb4Seivn4ERksR8jEivs3bm7e/hgBvOEOboLlrCjpa/JQiVUTb8Nhs9Hye7
	 inskh/zY4z9fA==
Date: Tue, 25 Mar 2025 14:39:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net 0/4] Avoid using WARN_ON() on allocation failure in
 device_rename()
Message-ID: <20250325143910.02e183e1@kernel.org>
In-Reply-To: <20250325141723.499850-1-i.abramov@mt-integration.ru>
References: <20250325141723.499850-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 17:17:19 +0300 Ivan Abramov wrote:
> This patch series is based on
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/ and is
> intended for the generic netdev maintainers, as it affects multiple
> networking subsystems.

But there is no dependency between the patches, AFAICT.
Please send them individually to the respective maintainers.
-- 
pw-bot: cr


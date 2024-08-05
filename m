Return-Path: <linux-kernel+bounces-274994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC0947F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C8A283653
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB07A1547C5;
	Mon,  5 Aug 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjgHK/3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED5156C74
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875101; cv=none; b=mUCgO9KlUeSmHg0TeHNucs2rn7gKowmYg9LPdlOlKx/JEeBDhwZF+4v7RZQTJQv+9UfeHQPWtNoQAj18Te8QnTjlmuDkMjbzxOvWH3JE0ZG+kKhlglWjiyw6prOWGUKMVysEbhRNNP8qQuW8iFhGS6F05w/n0kJlslIMOkJlbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875101; c=relaxed/simple;
	bh=ryF7GrtzMkbfdVeDLNad9XUDS1FL6/Kl3NU/26TCmIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pcKSFjvxzg0LEczYENpu3kZavGFCf//Iu88GGBrvJwZrDXK1tY5kmGwpEXr0XNC7pM0RLU3kWWa0BfmwjY2g0bRmiVTS9Joauw8kUhcIv3JoOKpl/Oseqkx6TLZFn7XX2sShRv5wAnyT5YBSys3GSj8M2NGBlhOljV/kpKSv4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjgHK/3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F781C32782;
	Mon,  5 Aug 2024 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722875100;
	bh=ryF7GrtzMkbfdVeDLNad9XUDS1FL6/Kl3NU/26TCmIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bjgHK/3cAxULjmV/kKBzZvl4cepAEFKAJ5iWd1PiKl95RKJhxCP5JpQptYoXoxHxU
	 C48n+p8Px48y9B3xGcTMvAIdJ3nLrvt4y+IOYr/TtC6mcMb3djmwFQ3FhZn2GPbHRY
	 fwtfNevne1SuqU0pvy9Hf3oG0yGEpHPGn8AOZKzeYj620zvB/R4+eQE2IE/E8wVWJf
	 hKb7cAqUKRy83Vpus7xqcjC/68yv/+62SPkGCii2mKn1HKNdsdj6iw4j2OD/q7hxZJ
	 yPbgMW7H3K+Sn8g8yrUrXR/iOAYiNkJZ+WlCS2QzS2Ui16109vbpLfp4fz8St+ec5L
	 33/CpfwOOzXcg==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, p.zabel@pengutronix.de, sjakhade@cadence.com, 
 rogerq@kernel.org, thomas.richard@bootlin.com, theo.lebrun@bootlin.com, 
 robh@kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20240716102442.1605280-1-s-vadapalli@ti.com>
References: <20240716102442.1605280-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v3] phy: cadence-torrent: add support for three or more
 links using 2 protocols
Message-Id: <172287509695.465699.4333434090979215764.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 21:54:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 16 Jul 2024 15:54:42 +0530, Siddharth Vadapalli wrote:
> The Torrent SERDES can support at most two different protocols (PHY types).
> This only mandates that the device-tree sub-nodes used to represent the
> configuration should describe links with at-most two different protocols.
> 
> The existing implementation however imposes an artificial constraint that
> allows only two links (device-tree sub-nodes). As long as at-most two
> protocols are chosen, using more than two links to describe them in an
> alternating configuration is still a valid configuration of the Torrent
> SERDES.
> 
> [...]

Applied, thanks!

[1/1] phy: cadence-torrent: add support for three or more links using 2 protocols
      commit: 5b7b83a9839be643410c31d56f17c2d430245813

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>



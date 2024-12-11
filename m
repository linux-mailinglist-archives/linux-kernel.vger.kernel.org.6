Return-Path: <linux-kernel+bounces-441250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DED9ECBBE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D6F168308
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2602163A7;
	Wed, 11 Dec 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGeAkrV3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B34238E2A;
	Wed, 11 Dec 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918802; cv=none; b=Zgd9+wWu0/oJWnEUrvsKJRkQ+geWMT8cl60aq+vv+zWu4LyfNj0T/t744KEyCjnLYL/dZEiCqf8YkvRDZy9q33bISPFuANB/9yKUWjtpNjONXyEfHB8Yu9GaasnedSruDhpdNr27HEISMvwS6HT7kNhdrxb2VLdpTI/wky0mgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918802; c=relaxed/simple;
	bh=pz6E4MM8uu6qFR81tOsB8zWIkdX7kJlWA6QAWbSj828=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a71ItOj9AxPZvlGJcGnP8b+rcsSJ63GxqpDekRXY5mfkW/WqPPISjqU853zRwfXR5TzG8I6DS32e9zZB071ElRT3bbFt3cvTU4j3MaiYL8tsWuN8r08tUt8IQBRTOswKdklPD1acKDO/FaSx7vtKBjYnMT8U65cQgWDCVvT5brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGeAkrV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB72C4CED2;
	Wed, 11 Dec 2024 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733918801;
	bh=pz6E4MM8uu6qFR81tOsB8zWIkdX7kJlWA6QAWbSj828=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EGeAkrV39l2sRE27yvcxdxdVnQb8PTUdp7zAcNfkufkTxrw6Ju4/9nF4VfMD4AEGd
	 k8nrPqqxN/V9RojRFhrTHE6inHPvcVk24kkVWAv8ccCwztajIHI0QXw+Z8l94IBwxA
	 avwGsm6um/5BjlC1fm/OMKxhJyT3Fq9gBrpDSf4VbdkR3jng7tfgpuYccQV5HgOBo2
	 XE4I7mauxdM5EgEqlxumb486H2Bobro+Qw0prdTDMAqy+Nk89pgnGoBrRZZ/R6uDPd
	 DzjdL0X9XDp9w62nRcKLxigqvPLzpBb5v2y8kUxKxE0E4fsjHq5WfzseG8fF9X1Vgo
	 E7k0HuKF9t32g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, wens@csie.org, Dragan Simic <dsimic@manjaro.org>
Cc: linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <cover.1731415409.git.dsimic@manjaro.org>
References: <cover.1731415409.git.dsimic@manjaro.org>
Subject: Re: [PATCH 0/2] Use devm_register_power_off_handler() where
 appropriate
Message-Id: <173391880034.747721.14412327221387015230.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 12:06:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 12 Nov 2024 13:46:46 +0100, Dragan Simic wrote:
> This is a tiny series that simplifies the code a bit in a couple of MFD
> drivers by using devm_register_power_off_handler(), which is a purpose-
> specific wrapper for devm_register_sys_off_handler().
> 
> No intended functional changes are introduced.
> 
> Dragan Simic (2):
>   mfd: axp20x: Use devm_register_power_off_handler()
>   mfd: stpmic1: Use devm_register_power_off_handler()
> 
> [...]

Applied, thanks!

[1/2] mfd: axp20x: Use devm_register_power_off_handler()
      commit: c8729f5dc9aacd4bad8ac93487c2f5ee1c409f2c
[2/2] mfd: stpmic1: Use devm_register_power_off_handler()
      commit: d893a7ed58430259cbc939cd001e24833df93a75

--
Lee Jones [李琼斯]



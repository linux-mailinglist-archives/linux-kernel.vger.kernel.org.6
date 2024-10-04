Return-Path: <linux-kernel+bounces-350988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F6C990CB5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AABB238FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6242139DA;
	Fri,  4 Oct 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7a9JpTu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB41DACB5;
	Fri,  4 Oct 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066124; cv=none; b=KT8KSc2xEntIi2PHCIk+Gfhi1C+cr6ugXA9/p69YjAUNI5Vdx1SO++5NcTQTweq3dTg7ghlYjZ61BtTS8xBTbxBK8NMOXBQfjaFDHH84Zm12ybpGJV5vA5wgAHzfU2T4jA0lBMKaE5WphGVouxBvul9BDdiUpiqjNfU+ap41fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066124; c=relaxed/simple;
	bh=6Nl2kstfP0z1D+O3PHmAJpklNDEwiLQIuzpBg/IOej4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=milg9AJv74NtYIGPNZ31FsQyqzIbgKwUUwLsQvYw+jL6M3x3YeYNm7fgMTqYd/PBpAVK1kM/fOFly4YJGaYh/DlvauJuV+FBxC+vX/y6kgrAtMJy7AEHqK/w+jivGZ5NDX9tphqVhm3mguB6dTuXlk9cz+dLwJlF5+cu8cR8wiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7a9JpTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96A9C4CECC;
	Fri,  4 Oct 2024 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066124;
	bh=6Nl2kstfP0z1D+O3PHmAJpklNDEwiLQIuzpBg/IOej4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k7a9JpTu0jJTeh5r7lc9TDz5oPFmtPT2fcj7URLD+uGlRqh3dcstDUTCgUcR2QfhX
	 QXsKYM/OxKB7DQXCVbTcA7+K0cDSHEa5j3WT+GBAlTh0hYulf2d4CVAgeE9sG8eBbf
	 csxdhjty0UGHBfa1NCpounqdietSVaxM8Gc/dy0WhgycEuGtNmDYLTIvO6+/+9q5cl
	 Bax7qpsYBc1VadM1obyxxNiVUsCUr1IlDl50PhpNW1VrsqeiRx3h6ySvcjfSBOqd/8
	 BU5q+dRRUGio+v6/UKhyR0t8m7DldW8JMSOUvXcxvHARjNNl3mtLk1jPFScfbGIa6a
	 xpS9bZD1eEdng==
Date: Fri, 4 Oct 2024 11:22:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ingo van Lil <inguin@gmx.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Dan Murphy
 <dmurphy@ti.com>, Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net] net: phy: dp83869: fix memory corruption when
 enabling fiber
Message-ID: <20241004112202.60ef2bcc@kernel.org>
In-Reply-To: <20241002161807.440378-1-inguin@gmx.de>
References: <20241002161807.440378-1-inguin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 18:18:07 +0200 Ingo van Lil wrote:
> When configuring the fiber port, the DP83869 PHY driver incorrectly
> calls linkmode_set_bit() with a bit mask (1 << 10) rather than a bit
> number (10). This corrupts some other memory location -- in case of
> arm64 the priv pointer in the same structure.
> 
> Since the advertising flags are updated from supported at the end of the
> function the incorrect line isn't needed at all and can be removed.
> 
> Fixes: a29de52ba2a1 ("net: dp83869: Add ability to advertise Fiber connection")
> Signed-off-by: Ingo van Lil <inguin@gmx.de>

Applied, thanks!
-- 
pw-bot: accept


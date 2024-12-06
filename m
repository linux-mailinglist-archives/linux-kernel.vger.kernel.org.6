Return-Path: <linux-kernel+bounces-435154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC619E726C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B59D2839B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5FE20125C;
	Fri,  6 Dec 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAxHjcIr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FED13AA5F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497734; cv=none; b=XVwyPBxqRjoQrCl6NGdwA8GTJ0zcAO8422sZZddG/8/TX8ISMZl10/AweLmiD5OVfil6YfHYONjOLOL2EBapgz5gW/ToHVbmATAUbiWI9YiRjxoMpPq2lgnxJsR/evCrHGwJEYcfsqlYVRJbJqwNWra36J2uBHUuPa8gUMIAi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497734; c=relaxed/simple;
	bh=X2DFbcfifLoFen+Ra01s5FegQTebcs9sJl+7t0SB9Hw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JpqFyEl04IhZj8nchrMthH+ZIS0aWdapv2aZ347K2mLs2p1SYMcsQU3UT0dAbmZSAjuP5tKH8yRc5dRykhxYXSviEdeFf+46eCfs4naCZHRbWOHzm/NP+aTufCrNYgYu19w8eEgsZwmgRiTGrI85swTfmb+BT0gDMULXRuvaVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAxHjcIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442F4C4CED1;
	Fri,  6 Dec 2024 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733497734;
	bh=X2DFbcfifLoFen+Ra01s5FegQTebcs9sJl+7t0SB9Hw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lAxHjcIrMCwVXDzbd/Fs8nycOCLReNZA37YFWNJPh964Vx2BV2ITra5Uv0nKpBfy6
	 mmiC+C97GljNlzAXZ1e1YWeckTkYwTK+EcGfBzN6aYWkcdhMfr9OWjS57XtREW/fBn
	 PG/usixa3pvP6Y4kjgvC+sZLKZVfZKD5bPxwq86carDoofyqlGVSd64uZagQ5Wq8TI
	 cWtYk3rXQsWpIRA23yXDdbkk2nK0rwEgjlRTrcl+0SdzQW+q/twbPb1Mz8sAwgNg50
	 dmpnl3V81GOMXufNYkc2pQXnWWBFakbcJmaHlugfosmwzg+PatIN7GcNdb2Ary8BWI
	 n0Cox4DTp802g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,
  <mwalle@kernel.org>,  <cmiquel.raynal@bootlin.com>,
  <thierry.reding@gmail.com>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <jonathanh@nvidia.com>,  <kyarlagadda@nvidia.com>,
  <smangipudi@nvidia.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: Add support for spansion s25fs512s1
In-Reply-To: <20241126185834.1130949-3-va@nvidia.com> (Vishwaroop A.'s message
	of "Tue, 26 Nov 2024 18:58:33 +0000")
References: <20241126185834.1130949-1-va@nvidia.com>
	<20241126185834.1130949-3-va@nvidia.com>
Date: Fri, 06 Dec 2024 15:08:51 +0000
Message-ID: <mafs0frn04zng.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 26 2024, Vishwaroop A wrote:

> Add support for the spansion s25fs512s1 SPI NOR flash. This device has
> a 64MB size (SZ_64M), dual/quad read capabilities and apply
> s25fs_s_nor_fixups to handle specific chip behavior.
>
> Erasing, reading and writing this flash device has been validated on
> the Jetson AGX Orin platform using mtd_debug and dd utilities.

Please read https://docs.kernel.org/driver-api/mtd/spi-nor.html for
requirements for adding new flashes. Also, see if you even need a new
entry at all, or the generic SFDP-based driver works for you already. If
not, explain in your patch why.

Same applies to patch 3/3.

-- 
Regards,
Pratyush Yadav


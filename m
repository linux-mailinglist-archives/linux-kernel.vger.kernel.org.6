Return-Path: <linux-kernel+bounces-190691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACA8D016E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A5DB25B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34E15ECFA;
	Mon, 27 May 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiZxRfwf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5715ECE7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816434; cv=none; b=g5EQM0Nb8H052SOdfM3Fj784QC6WOCzNL/QzHXRaeHVfrGAgNKbpB8YTQNrijHPzXeiB6HCmqVqXveiErhrvDbOqz3vVXYUjsnhyEOoyc6iCC8cDSC+94SVy56SueelCC8eomRHylb+Bx/araeRLHgBIP12dXGOYILHHErriqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816434; c=relaxed/simple;
	bh=ZyDOV+M5aNRQcxoeRg24V5eddc/YAovsvaL/j6YVyGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMP6cuCplhjvGIWSmlJGFvgU2t3sxT5y4K8H55rtMnnnyPgE472rbpxRFBkXJM6eRWfkzdPHxZ8V545yfBjPrh4LkY9pQOCZQ61rKM04cDRwbkVRKWDocdPuEJxoCYFERVK+BsB+UbkECwghk5FiAxVWZaviTEB+wshzIlgfh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiZxRfwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24221C2BBFC;
	Mon, 27 May 2024 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716816433;
	bh=ZyDOV+M5aNRQcxoeRg24V5eddc/YAovsvaL/j6YVyGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CiZxRfwfJp8nIKYRU8dJ5T6vBGq+Bt0Mkn28mthMikZxjE1870baR737ift0Y+t0R
	 uukJ4B6ZoozamSouwyN8VhzVFaLY/afL7Vu+ajw0eiBl9pHbppFk42Sfv1JdO5Opyg
	 LOWpQUrPcypzvWmy3vFRPR3dWLrZ34AaEgPu336YDaBBgCZ+DG8pC0rCImd+gS7b4l
	 uLVRVXRXjuGjp3NCyP3cY/NGxdfvydmMD6Qlt4AqES/KFIxpezDi7Lc4OrmdWTbZfw
	 Jrg70BgDbsSu/Jd8V9BuEwlixKcnzyhu2niHteXuBh46vQUM/yR4vKfnyoFTlw43K0
	 4X8xpfRj+CBGw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Ricardo Ribalda <ribalda@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 3/6] mtd: spi-nor: remove .setup() callback
In-Reply-To: <20240419141249.609534-4-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 19 Apr 2024 16:12:46 +0200")
References: <20240419141249.609534-1-mwalle@kernel.org>
	<20240419141249.609534-4-mwalle@kernel.org>
Date: Mon, 27 May 2024 15:27:10 +0200
Message-ID: <mafs0jzjfe66p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Fri, Apr 19 2024, Michael Walle wrote:

> With the removal of the Xilinx flashes, there is no more flash driver
> using that hook. The original intention was to let the driver configure
> special requirements like page size an opcodes.  This is already
> possible by other means and it is unlikely a flash will overwrite the
> (more or less complex) setup function.

Just for comparison, I checked if U-Boot does anything with the setup
hook that we might also need. It looks like it mostly uses it for
handling non-uniform erases on Spansion flashes, since U-Boot doesn't
have proper support for them. This shouldn't be needed by Linux since it
can already do those erases.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav


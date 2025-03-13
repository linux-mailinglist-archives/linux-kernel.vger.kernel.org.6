Return-Path: <linux-kernel+bounces-559474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24BA5F42E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D286B19C022A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356E266F0B;
	Thu, 13 Mar 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQaer/FU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8A335BA;
	Thu, 13 Mar 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868506; cv=none; b=G3hvCu3nBuKZCs6Ym09Xpab7DSFU0b1uHRPWkY6l9ORvcmi06WFCU9qLZMmxJYAnlpla7sXeFWZRNSK4UanfgivKck8uJfCVyTdPxIEb3vV/Z9U0xk6T9I4OdzbgRmDT6wjGb6B/AT2lyGTSIkXPd/ln9sioDgn80+M9zDlZApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868506; c=relaxed/simple;
	bh=QufmZPS8ox6XEcE14PIgRsf+OlqSGddamexQokuBYxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqt3pDJSf+mx/zUEaG5XpbMxH3MD0ie1edTYQvoUiyDzuZ5TtLtPy3TEQ2AEPs3Ug8Iv2LN7w1zgnZMD/HlYNnX5ufYE+we3lxG3R63XakI+Ce7mUUiBibuTN58+TrLqgY/pZs+GxNTxT0nojKEjaSu2durM8oRRDTIV13Fm6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQaer/FU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC21C4CEDD;
	Thu, 13 Mar 2025 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741868506;
	bh=QufmZPS8ox6XEcE14PIgRsf+OlqSGddamexQokuBYxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQaer/FU51ED/keQqTzTmhBCZOzp0ncteR9klAlqZafCk0PI/ZZPp7G9/7dYxD1/D
	 iBaEtDuhyTfhuVIf7ETP+0xPlUUdyi5RQ/oDcqzluCQUU+1XWeUrCC6Rfd+Jt9D8FX
	 4XjKvKxOn0pAKAgvNallCLfLd6R8p0eWyRfAmh9s3aE2mj15bL4VTY39xFHUzFmTTL
	 XUsjXTsSjJfpFC6guhJKpjEVRKwS3tywLKoFBnUlJ9rgYYGdCXjxCOX39j0VLc0p9y
	 wWD8nu3p5AIOZ6wXIeqR14EHQaRR2Lmip2vd8EeWAHvw3TPgdHdEntZSJSYNYp7b83
	 H8h28d6PMoLbA==
Date: Thu, 13 Mar 2025 13:21:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Eric <eric.4.debian@grabatoulnz.fr>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jian-Hong Pan <jhp@endlessos.org>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-ide@vger.kernel.org,
	Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
Message-ID: <Z9LN1HiFrGxmO6Ba@ryzen>
References: <Z8l61Kxss0bdvAQt@ryzen>
 <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen>
 <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen>
 <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen>
 <9670400b-4723-4028-b5ae-5005ed3766c1@grabatoulnz.fr>
 <95783730-0a77-40a0-9933-509eaa0ba558@grabatoulnz.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95783730-0a77-40a0-9933-509eaa0ba558@grabatoulnz.fr>

Hello Eric,

On Wed, Mar 12, 2025 at 10:39:37PM +0100, Eric wrote:
> 
> With the patch you asked me to test, the SSD is properly detected at reboot,
> both by the UEFI and the kernel.

Thanks a lot for testing!

Interesting that DIPM is enabled on both, but only causes a problem on
Samsung.


Kind regards,
Niklas


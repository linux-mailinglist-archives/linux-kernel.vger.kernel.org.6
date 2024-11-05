Return-Path: <linux-kernel+bounces-396389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A19BCC77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B8283B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E34D1D5165;
	Tue,  5 Nov 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJt5Btd5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653DA1D5159
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808810; cv=none; b=nM+Su01GWK0TiUgcgeclNg1+HtWuA2dlu/Nx62NkjRA7jF93NIIKZ7oKoGXPAIFkq11bf01DHkEYC6E9ZfLy6ML42TApZ2frWP0+MZoTWyv1unqmtiEXVV/YksFMpYKxB5yPLBP+zWw0AXBSPHfenvipeSnA2ccH+52/iWQvH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808810; c=relaxed/simple;
	bh=PrSC39GPtgWvrvJL3ikp63b5f02E1c5YdGEZakf5zQg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=oR1d35Li1KBBJ9GMOXHi17vhGBzAa1KIkXWzVmH+MTB+4c68yvAiEbNrnpVcp/FO/OQDbgoIN5n+5juxHHBm5huqxeRYygtQeYN8VH2OK/wRy/zWDRo+ZiQMUx5UGWzeLanDIHCWVYAlV61O1+MKB6JISdiicJpy/L3sU3CTNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJt5Btd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EC7C4CED2;
	Tue,  5 Nov 2024 12:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730808810;
	bh=PrSC39GPtgWvrvJL3ikp63b5f02E1c5YdGEZakf5zQg=;
	h=Date:From:To:cc:Subject:From;
	b=UJt5Btd5R/upSi0XKbBUslHDE+0T0bGwcOmY9Q/uYSw5UFdQ/+MyBHuNvBwZAH/9i
	 x+6QNQdfOpt7K5/jB1NdEQIpy3FVHz0sBzJE41I1ERWPlqxA4k8RJKj/mp50vPFPTK
	 PxwXViQrIovcLA/l3o1+AXktQ8HyNw8B6BzjNXARau55RpY8HUNCfubBB82h59YZa/
	 qboRZn/wjERIBLksPjEhT4/d2bwE+Y09sC5z5HabmWaHG5avXAgXYtuItjqG5WgNGh
	 f90IDW2HFVbtEzbPiqTMxmWqpqkTyTsp6kJXcp3vDryTrkLguuYaLF3uMza0QiM2v0
	 w51q1T88SXIJw==
Date: Tue, 5 Nov 2024 13:13:27 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2411051310180.20286@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-20241105

to receive 

=====
- report buffer sanitization fix for HID core (Jiri Kosina)
=====

----------------------------------------------------------------
Jiri Kosina (1):
      HID: core: zero-initialize the report buffer

 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jiri Kosina
SUSE Labs



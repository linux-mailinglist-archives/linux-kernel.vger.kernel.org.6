Return-Path: <linux-kernel+bounces-343348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A1B9899EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2661F21A04
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EDB13B59B;
	Mon, 30 Sep 2024 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UEIXulHc"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58212AF16
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727672403; cv=none; b=gBJXOISJo/nZc/2ft3+N7OD+w6//5nDuJlKieYGnIZPM4BWTc0XUQASrdwTp1WFN1b5vOym+CRigW0z3e1wmXIQB511RskOv4IKtSnDLchcdB7+R7IjSMx4rAQ9r6VF44JLGYeVwZcxTCTDdtXJt/eYclJHzVUEcwTeBXtTf92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727672403; c=relaxed/simple;
	bh=Xg+5OUHzvGJDGnwi7oSEVY3RnFR9MPU+iYKPO4MFJDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nGw4rb3pKbno94yYnf+yO5zTlHOGtR1lQniPKtFxo78VlpRQXsw/MRMf3lgb0hVi3ko3BNzUSG0mhkMZlRtibLlmU8yRjtm4SkzCB+nXt/PVsmJXlHb1kCzK3UuTxLfPMeKkBB71kPIoB8NJ0vU4gX/L5+xuOo0JYLnnKFpRRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UEIXulHc; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 30 Sep 2024 00:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727672396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3BLemO7sS3aMVH4+gPXT9eyXDJ6Xvmp5pzb1asfWkyU=;
	b=UEIXulHcVTXIG2iS/5kLRSzxDLQh+HMO1u6bMDpiCGKBAzSw/A3fshaihhoN5+PMDbM+u+
	yIpPk9zW+kq6UCoUoOpoY+duVkYoE5KQb4QqgAG/Ase5/8lEHZRzF3dPJFF5kOk4Kk6Gm1
	u9NZFoHqZ2Ysp6tMDxl65E2oCi4NoAU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs big endian fixup
Message-ID: <afdmrsibtwc655t55tnlysfbetlb57nrdmk3k2ke6o6aebssqh@3g3mhqsvaswx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

This fixes the build on big endian

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-30

for you to fetch changes up to 2007d28ec0095c6db0a24fd8bb8fe280c65446cd:

  bcachefs: rename version -> bversion for big endian builds (2024-09-29 23:55:52 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.12-rc2

Fix build on big endian.

----------------------------------------------------------------
Guenter Roeck (1):
      bcachefs: rename version -> bversion for big endian builds

 fs/bcachefs/bcachefs_format.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Return-Path: <linux-kernel+bounces-390663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A629B7CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDD91F227E4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CB61A0B12;
	Thu, 31 Oct 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CA1kQjJy"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984CE1A073F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385237; cv=none; b=GEeu2WeuiPA2GcoaCPAA6wN9RRfqFFElZ5KdG5diVD6lJRtQdGL4HsRZeOPfAPOFaCr0crAZq+qEjyMMK4fD9atFnsfo46cLmt0NaSs8QTTl+W0+MUDezqT8dghWf/P4lmJHF+SSaKiuiiG8UQeCNocY7on0BVBrXwqPLndVngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385237; c=relaxed/simple;
	bh=nSMaax40XyfiwxwEeqqE+KE7sXHDPcwsDszirrcERWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuM5QuFXCpOv2dT4GhDQi2F0SK+Y1yMImzaJnP1mAvc+RU06lDfHpBVCkn/pf0S/n1NGCuHAWt5ATxnfBRcNTed+w7NFQHZoVyUqPGCKRNuhqAJME6Qmjog7HWJXlXJbmvEah1xIh5MqWFXbrhT3XUhlynSY1MSl/EM79KIf8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CA1kQjJy; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49VEXiFK026371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730385227; bh=rYNcBFVUCNMCg+1QFWoc6LBLc7Cq0qljFBcwRg7uBw8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=CA1kQjJyr6785TsuDnk1aBplGD5NL3hihNtMFldwqvbDNWoLm0HsqMgHZvKAXLwDz
	 PEC/S6KOryZh8I5CZKVWYraUTd6zKtcOX2vD4Tw0egU/WG1Ry2DM5UHam7FxhRalTF
	 4grTw8Pid5XarqFmRKK54CgDVl28UYE1HTQDWYdwbUOsrExKWEmcunYNdQI0qjSIN0
	 EQdCKfBWzfULcKbKegDAtOPrmnQ347n42INzghDGcxMH8fvuDZwz+/Ko+lzOSPTHV8
	 qxFAJ8+s4VhmVNXwcYUXP4r+SSqyVyGQFF0LL9C3ftLqML4iTWW/ZUw/PCz8Hl8JRA
	 BMb3YkypVlmTQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7A56415C032A; Thu, 31 Oct 2024 10:33:44 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Jeongjun Park <aha310510@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, akpm@osdl.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ext4: prevent data-race that occur when read/write ext4_group_desc structure members
Date: Thu, 31 Oct 2024 10:33:37 -0400
Message-ID: <173038521048.99135.17276287567851231611.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003125337.47283-1-aha310510@gmail.com>
References: <20241003125337.47283-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 03 Oct 2024 21:53:37 +0900, Jeongjun Park wrote:
> Currently, data-race like [1] occur in fs/ext4/ialloc.c
> 
> find_group_other() and find_group_orlov() read *_lo, *_hi with
> ext4_free_inodes_count without additional locking. This can cause data-race,
> but since the lock is held for most writes and free inodes value is generally
> not a problem even if it is incorrect, it is more appropriate to use
> READ_ONCE()/WRITE_ONCE() than to add locking.
> 
> [...]

Applied, thanks!

[1/1] ext4: prevent data-race that occur when read/write ext4_group_desc structure members
      commit: 902cc179c931a033cd7f4242353aa2733bf8524c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


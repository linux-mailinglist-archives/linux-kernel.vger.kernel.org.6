Return-Path: <linux-kernel+bounces-260176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D793A426
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F52A284148
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961C157A72;
	Tue, 23 Jul 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U8Hx6A/S"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6A156C6C;
	Tue, 23 Jul 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750808; cv=none; b=tIC2Gnv/0jzfXtxn1kOXoie/0qdc8+C5nBOy+q8ZD/B8EC4PH9DmFRKMLIM4tztU1QAmkxgpdEQcwuGq16fGr8/Vo4yBUHrWS4ioAkUMhb7U+be6glEbK8MbtQK99GpiNF9oCJZNrEhs8mpezAJmFoE6hG/ZPqxq17w03I4hLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750808; c=relaxed/simple;
	bh=7ywyqkkF5MqKA00APXlJ4HjoUAu4Qg1q3SKV80O1gZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kELcCD+PpAIkbELNlwpr/U8vTLv3NYA459qvntXHn8PIb6fEZYQcAXzTNYowdT/Ld7CFyi/jR/XMJe03zJfo9L6cLCe3C5v3mGbpMLxBizEzZNMmc2ey2AVnAVxIEWYtHzTLIPwsy3UcmKneS2Vi8GtmIXsa1ppBZz0TtQGOKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U8Hx6A/S; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721750804;
	bh=7ywyqkkF5MqKA00APXlJ4HjoUAu4Qg1q3SKV80O1gZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U8Hx6A/SoskBj3aYoyWmsy797rA3qThdPClB/SD4Tj583SBwF9s7P2vfR4UGlyULr
	 OxKNwWb1g4kvM0ixW1L96RHj1a9suG6QYvonJhTVgLSehhOLXY1m+ZKSDSr26Vkgvm
	 rcdkTN43AeB3yemf2ZaTeiyv4tu24gXZBCE9sJbRV2DvbPjn0NfmGDVpu+W0bUSSta
	 Yt8bAYeYWkL2qmQnUf9/1U6mml3OdQGGrlmhI5p2Z0+8MftudQRcfx/JqUemX9gckL
	 OAhiUbQ7bO2jn/gFHaNJ8hJoyjzV06tzqrDl9FpQpetOplXmKpbkQgAXSeBQaJrJ5Y
	 fUxIWvt8uBuWw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0197C37804D4;
	Tue, 23 Jul 2024 16:06:43 +0000 (UTC)
Date: Tue, 23 Jul 2024 18:06:42 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, ojeda@kernel.org, Danilo Krummrich <dakr@redhat.com>,
 lyude@redhat.com, robh@kernel.org, lina@asahilina.net, mcanal@igalia.com,
 airlied@gmail.com, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
Message-ID: <20240723180642.73502856@collabora.com>
In-Reply-To: <edda856e-3102-495a-8cc6-b79f5f114833@arm.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
	<fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com>
	<4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
	<edda856e-3102-495a-8cc6-b79f5f114833@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

On Mon, 15 Jul 2024 10:12:16 +0100
Steven Price <steven.price@arm.com> wrote:

> I note it also shows that the "panthor_regs.rs" would ideally be shared.
> For arm64 we have been moving to generating system register descriptions
> from a text source (see arch/arm64/tools/sysreg) - I'm wondering whether
> something similar is needed for Panthor to generate both C and Rust
> headers? Although perhaps that's overkill, sysregs are certainly
> somewhat more complex.

Just had a long discussion with Daniel regarding this panthor_regs.rs
auto-generation, and, while I agree this is something we'd rather do if
we intend to maintain the C and rust code base forever, I'm not
entirely convinced this is super useful here because:

1. the C code base is meant to be entirely replaced by a rust driver.
Of course, that's not going to happen overnight, so maybe it'd be worth
having this autogen script but...

2. the set of register and register fields seems to be pretty stable.
We might have a few things to update to support v11, v12, etc, but it
doesn't look like the layout will suddenly become completely different.

3. the number of registers and fields is somewhat reasonable, which
means we should be able to catch mistakes during review. And in case
one slip through, it's not the end of the world either because this
stays internal to the kernel driver. We'll either figure it out when
rust-ifying panthor components, or that simply means the register is
not used and the mistake is harmless until the register starts being
used

4. we're still unclear on how GPU registers should be exposed in rust,
so any script we develop is likely to require heavy changes every time
we change our mind

For all these reasons, I think I'd prefer to have Daniel focus on a
proper rust abstraction to expose GPU registers and fields the rust-way,
rather than have him spend days/weeks on a script that is likely to be
used a couple times (if not less) before the driver is entirely
rewritten in rust. I guess the only interesting aspect remaining after
the conversion is done is conciseness of register definitions if we
were using some sort of descriptive format that gets converted to rust
code, but it comes at the cost of maintaining this script. I'd probably
have a completely different opinion if the Mali register layout was a
moving target, but it doesn't seem to be the case.

FYI, Daniel has a python script parsing panthor_regs.h and generating
panthor_regs.rs out of it which he can share if you're interested.

Regards,

Boris 


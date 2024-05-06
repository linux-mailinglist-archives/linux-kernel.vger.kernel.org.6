Return-Path: <linux-kernel+bounces-169497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777B8BC98D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C257128111C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B214198A;
	Mon,  6 May 2024 08:28:55 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1D4316B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984134; cv=none; b=OSWPHQAkDjW8/SAEorc23NCDoKede76Ng4r7qwBCboj9cj9o1FP6hyEH6NnHByZ2TU62atFFs6ENVx0wZWayy6+eSZ5PcI8zpF8O7n92c+7v5ypFAtgTa6WmC87YCAVvFn1g6qUSc67C2X+j1FW/sQ/MZqXTANUKGE0UvQk8smQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984134; c=relaxed/simple;
	bh=rUHPCTqUM/oicbrHabDgygiU0JacnwgNZpiBuiQe6E8=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D+WqCMRCLLJjeXZV+/+vYYHC4gj5ozsbCC0FwkUc3rTaa5TzlZnzmXE1TroDfMGWA1BW3o5FC2yzXo6WKtiU8DNCB8uTp45fZzH6+QKTgai24Iyfa/KrCJ+gtrXqQH74yRGybT/WS6o7MRScRoFR0ZWnobhlPrk51Mqh6UMrE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:e8fd:353d:bf09:e9f2])
	by albert.telenet-ops.be with bizsmtp
	id KkUl2C00D1j6xkh06kUlYV; Mon, 06 May 2024 10:28:45 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s3tiH-009yNP-CM
	for linux-kernel@vger.kernel.org;
	Mon, 06 May 2024 10:28:45 +0200
Date: Mon, 6 May 2024 10:28:45 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.9-rc7
In-Reply-To: <20240506070440.1369025-1-geert@linux-m68k.org>
Message-ID: <941213c9-68c5-db48-cbaf-f47b81e1d559@linux-m68k.org>
References: <CAHk-=wiT0EJV+X-=-dMmL+q3_kyQCxV-WPxb8m8Q6dtWOxjCcg@mail.gmail.com> <20240506070440.1369025-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 May 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.9-rc7[1] to v6.9-rc6[3], the summaries are:
>  - build errors: +2/-9

   + /kisskb/src/arch/sh/kernel/return_address.c: error: no previous prototype for 'return_address' [-Werror=missing-prototypes]:  => 14:7

sh4-gcc13/sh-allmodconfig (seen before)

   + {standard input}: Error: invalid operands for opcode: 1099 => 1099, 610

sh4-gcc13/sh-allyesconfig (ICE, seen before)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/dd5a440a31fae6e459c0d6271dddd62825505361/ (all 138 configs)

> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e67572cd2204894179d89bd7b984072f19313b03/ (all 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds


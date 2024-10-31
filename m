Return-Path: <linux-kernel+bounces-390558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8254A9B7B63
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A439C1C20DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065719D890;
	Thu, 31 Oct 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZPr7c9r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r/WF7NtE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42819CC2D;
	Thu, 31 Oct 2024 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380222; cv=none; b=lpbIbNsxJb8Slsize8DrqveMzxPEyKe8uuil8plDPeRhnMkNA9y1LiAJ9qStGNq6LVrHdv54HMsOQCND6FEw1og9mMTlOn2TVPe2Ll2ckVGIP0QOVwfP3rrGVCyFHuFCmPGJiG+Ad2DfmXSVLFJ5TYv0zOZCT89V1oH5O0uNIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380222; c=relaxed/simple;
	bh=Khel1CjCqD6GywqHIRkJC23AjuuARNeWjnIoyg8t5ys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VLR2+SVlKDczaRHKq+CrQgVQcEmSM0jFlYlJgRYsb1S96N9iXzS4nhQdDbcWNDlMqYFWlGTYyn1GD1R/GotuxSZAuyVoIdUXhMPQe8b4eIDf0A6P65FLm4n9jYs6zkMiDJSpwR2GVhFJiWjXPcEs6zvUYSlG7mxjSKknz37Ijgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZPr7c9r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r/WF7NtE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730380218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9KzjzVNQ8Kocvxcj31qY9sIt3lmgpdIUIkiScgCA4Y=;
	b=cZPr7c9reVDeCHTlZwoxBPVYMZlN3G/dTVTQdkTTDaJ89tpKCtPo8EkeU27J1U2NKhv801
	5lQ0w7+al8WvIbp5qPeOp/1W71eF8XFHZovHvM873GgwnxRq/Wbt0xNjgYs67PA6+YUmqW
	YiJm4SpGCaaksFnT/OFSdM3lHs0Sp5MutH9zzBB5TdFzfp+a8x9ghckGs0o8Tax/4jQUOG
	w/PEpAZwP+Jg6A7cJMeQab4KduJXxkwIUpec86VkGxT0qh71AYiixi0+C9gztjf/KqJdG3
	xU/vFXaYaRr3/+M/M+lvpCJ0JLpb3TE7ckYAMlPLqIoWf5ffv2uobiVI/rLJ4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730380218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9KzjzVNQ8Kocvxcj31qY9sIt3lmgpdIUIkiScgCA4Y=;
	b=r/WF7NtEoHc5yMmmmEgyNRfuKPAwN6UMWQX7pGgI8kOncV4SLVrtCGL1KPWEVsxsmKVtXe
	sWw/W+y07XAozBDQ==
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Chen Wang
 <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Peter Zijlstra <peterz@infradead.org>, Inochi Amaoto
 <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Yangyu Chen <cyy@cyyself.name>,
 Anup Patel <apatel@ventanamicro.com>, Hal Feng
 <hal.feng@starfivetech.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Sophgo
 SG2044 ACLINT SSWI
In-Reply-To: <20241031-armored-marbled-36cfb6d599e3@spud>
References: <20241031060859.722258-1-inochiama@gmail.com>
 <20241031060859.722258-2-inochiama@gmail.com>
 <esuteqvz37blehx6wa5cj5ixlglcbullhuls3rcvjtuiviqqpb@ojho3arlnwst>
 <20241031-armored-marbled-36cfb6d599e3@spud>
Date: Thu, 31 Oct 2024 14:10:18 +0100
Message-ID: <87ikt8wh8l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 31 2024 at 12:38, Conor Dooley wrote:
> On Thu, Oct 31, 2024 at 02:14:40PM +0800, Inochi Amaoto wrote:
>> On Thu, Oct 31, 2024 at 02:08:57PM +0800, Inochi Amaoto wrote:
>> > Sophgo SG2044 has a new version of T-HEAD C920, which implement
>> > a fully featured T-HEAD ACLINT device. This ACLINT device contains
>> > a SSWI device to support fast S-mode IPI.
>> > 
>> > Add necessary compatible string for the T-HEAD ACLINT sswi device.
>> > 
>> > Link: https://www.xrvm.com/product/xuantie/C920
>> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>> 
>> Hi, Conor,
>> 
>> Could you review it again? I have updated the description of
>> the binding and mark the device is T-HEAD specific.
>
> Only thing I would say is that
> title: Sophgo sg2044 ACLINT Supervisor-level Software Interrupt Device
> should probably be
> title: T-Head c900 ACLINT Supervisor-level Software Interrupt Device
> or similar, since this isn't Sophgo's IP.
>
> w/ that,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> (dunno if Thomas is willing to change that on application)

Yes


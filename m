Return-Path: <linux-kernel+bounces-438449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186AC9EA16D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBC31637AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5519D093;
	Mon,  9 Dec 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EXgZrKVO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582317BB38
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781184; cv=none; b=d0cYA7UEQNuJQ25SFfxhjF469Cub6yiRRjVHLbLKy8yJjKFysUslp5KmQTLPizhLWWs3Jcs7t9L92cEtC25f7KD1j5o1B4Y0hecLgC4eZX1zkWNondMQ+J2H04hsmFy3DFrnrd5kNYRuUGFkhIlK3KbPrkiqjOIIIvomCsySrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781184; c=relaxed/simple;
	bh=nDRbvwgDis8K9krF8V48nsZeihB3uzY4cT/A+0Ot294=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IuAbN2fjicg60VuKgQSyxLuDRtB1e6CRdCMmHOCJDe2dNrI+PL7CR2S8WAW3LJWAZOohpMZo2lZ+bpRv4hGSgqZNjcSCPTIWW17WkDslRGNKPDPW5k5ryBMHjXZ2afOVZpqqsSTI/70qhp1xrHtITfDSdO/t/szoBIPaj5CS41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EXgZrKVO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nDRbvwgDis8K9krF8V48nsZeihB3uzY4cT/A+0Ot294=; b=EXgZrKVOh7oFX8mTp7zgvEEwNL
	YDDykC78KpqVcBkBR3Kl7W74cV3pjjj0k2zRVjdnO5Yj5FvKr3eOenMpFp1XwFIuO6xxYHG9DRYNG
	Cg779zB/nZ3pi+9QPTso1CVk608kf2mEyrcVjFRRBXJH3VPnBU0HDf/jbyq49ebjMfrF7ygiXqVCR
	Bekbe/GwzLrP0ZevQ8d/oAQzSIjuGffbqlK9Fuc1okkp3vhN2WXnoboe2dlxOZ/ioMBYEibWMpLjR
	MvLCmMrHD2xwC277kCn1LJsB1/ig8ZScLW+SimF+SDHwELL88zczevN7v7eSnv++IbwstOGAKcb3D
	dpfbYBDA==;
Received: from [2001:8b0:10b:5:5f6a:61e1:248b:7168] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKlgX-00000003Zr1-2VRo;
	Mon, 09 Dec 2024 21:52:57 +0000
Date: Mon, 09 Dec 2024 21:52:57 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Borislav Petkov <bp@alien8.de>
CC: Damien Le Moal <dlemoal@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BEXTERNAL=5D_=5BPATCH=5D_x86=3A_Fix_build_r?=
 =?US-ASCII?Q?egression_with_CONFIG=5FKEXEC=5FJUMP_enabled?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241209171818.GGZ1cmWjBZJJE-mg-o@fat_crate.local>
References: <20241208235332.479460-1-dlemoal@kernel.org> <20241209102929.GBZ1bGiT-DGK8uDdo4@fat_crate.local> <7ee6d1aff2da6f79e08c9a3134bc8519e991f0f4.camel@infradead.org> <20241209162247.GFZ1cZVycGCYJwnMxw@fat_crate.local> <9b8f82c0c38093f0092f1015b641c30f2f478e17.camel@infradead.org> <20241209171818.GGZ1cmWjBZJJE-mg-o@fat_crate.local>
Message-ID: <16E951B7-155C-4E84-BFC3-CAA9EC765960@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 9 December 2024 17:18:18 GMT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Mon, Dec 09, 2024 at 05:07:06PM +0000, David Woodhouse wrote:
>> I suspect it would be less ugly overall if we #ifdef out the whole of
>> the preserve_context code path when CONFIG_KEXEC_JUMP isn't enabled,
>> rather than only the various parts of it that actually cause compile
>> failures, leaving a very confusing set of nonsense dead code actually
>> being compiled in=2E
>
>$ git grep CONFIG_KEXEC_JUMP *=2E[chS] | wc -l
>10
>
>That's mostly C code=2E You want to push the ifdeffery into the asm?

Already had to=2E The question is whether I'm content to follow the existi=
ng precedent and put the ifdef around just the two lines of code which don'=
t compile otherwise, or whether I want to clean it up and elide the whole o=
f the unreachable code paths=2E


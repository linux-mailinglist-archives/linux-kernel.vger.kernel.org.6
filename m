Return-Path: <linux-kernel+bounces-245809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57DE92B9B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7193E282521
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C0158DB7;
	Tue,  9 Jul 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jT5qXmts"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8D13A25F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528807; cv=none; b=R9PDJOgl4z5l90Csqsq+rOknFRTonTFLmO6VBPxEgWmwhMUM1pLtC9Tc3QrePbISpusg9g0zOkf9FaG3/CweOA8jkbQGD+xlMs97xrSwnoGbq3htlbx0S1qBQGiV8jq7YRGp690OfCmxHbfkEhoKBC1jS9rNZStvxqJq5oMGPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528807; c=relaxed/simple;
	bh=aOnoJ9nz2Vw5f5WUg3rs+rnntjGfT9KmwDhTcul6V9g=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=EV4VZcypIrABrhkrNnCvvzyep0QPd6LDImS7tlUYb6YMlcn8tTsnVeALoXYI0hJssFDTPawLwDSDxSrbAbhSYjBtq1B9qCOXsDnAQrqo/zXsPlgPqwTRbPkvPnEIZiC3RPlUka0eNBUh2WJVMjHmUZv5c8jgFsysqaxZibRUz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jT5qXmts; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1720528796; bh=aOnoJ9nz2Vw5f5WUg3rs+rnntjGfT9KmwDhTcul6V9g=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=jT5qXmtsYmdjN/LQVTiJAi2xCjJcQRqs0aQbJ9ZwtUF9DUWuCXhl4BhaOCr/irhVg
	 M9eefv1v1TvTCYcY/cjiM+g95eqwk9a9X8z6p1J65BcbkGfFZ/GwEROir421/utqbn
	 dfz5VnogBkikEwZFr0/e1+zJvJD7nc9zpslw39+A=
Received: from smtpclient.apple ([223.104.41.144])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 872B6A35; Tue, 09 Jul 2024 20:33:50 +0800
X-QQ-mid: xmsmtpt1720528430twbm52cni
Message-ID: <tencent_30E109FE684F391AE15AC6F4854034C2F00A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujqOeQ4Dt7MYw7Pph1E0apGJ+7z2yDzbL0fhzdSHzR/YbDMALmZE
	 7Ny6DM7LhGTjAIk91hknCE4eoJpjGvQ4sec50QFCtg1qs4asjVlWmXFnpoKF+tRqIHXYaWdCzNTs
	 1NOaCp8IEm4/XxLWp5qDRxpTO1bwX+SEE+A5Fvy/c66U/guGTtlB1XxypgIG42ULgY6KtrCUS+1c
	 kK/WZAMAruUTs58JSnhH3ZFBh1egYNB65hCgKCLJapdNsUd04/xgSBuxCCFqm+quAZvOoUBOjgjv
	 4SJO/MZLKk6UvL6J+sJQnrbfUz8kDdCf+Us2Ql8MBm9h5gcKDepfbx4jim60SoVO5TnCn0TMhdvx
	 vkFEbmFyIcoWAGSXiDSl5vZ/jiENwnhY9gOfCCp5gaJ585XZD+PWfoXaHvY0C4/UEoWOABYKnFGv
	 1vGQYbA73r2yz7ip70cAaCLbo0zqFn9rodhOcy3l2e4Dokeg0Ed0KqvAdp+MRjgIusbiYB0nxdUH
	 nIcCUNACMjNZYXxKiZ8WFBXR9tCbabZ0qLu6f0QeL1gBERNoCfuWkmSwEkKRVy8Ti1eW1cWt8fyf
	 STay72S1/JkCRtpGzMJ5uCmbaiQQxokfE1OU3aRzm1GbXUFudbVBHDWhykkPq/iMM6mS5dJL6bVd
	 X7a4dTPKMWlcPYw6iZfWvIaTc7lSko/Y8G7u++82ojLZVzp8Ne8lJWuJEapOAwoEqKJv/0tB+BCW
	 iKdDyTJYXwhIDqLyVxR18Wjv+Hln85GZ4yvVp+/34WzjvW3YvvT3bwaz+OHAMRgR+eTD2/9zw/QX
	 4dcpxZO0l6K/ck8ImXn2wxfiB9YJ0Zk2c395DXh9I+Ze1nQZEi41L+qR+AG7Cjt9myBGRLA1iks1
	 UlA7wltDliVlVH1N32eOZFW9blImo6WFSJs08EB5HPRja+VXxYNcsKoYjuAFGMRO+Rr9kNA6rxZl
	 PcMsDMReE9ZTzjhH1sJuO7IJTyshOnc7DTE8e3CGTjIggL8GydA3g5tnArOdW/zQ6NRjivZVmOvt
	 TDRUYcCrJYJhle9I+kvSuNJmNw94Q=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH -fixes] dma-mapping: add default implementation to
 arch_dma_{set|clear}_uncached
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240709114629.GB6959@lst.de>
Date: Tue, 9 Jul 2024 20:22:35 +0800
Cc: iommu@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <B81ACB86-A23B-4AC5-971A-25C7C6E3A1AB@cyyself.name>
References: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
 <20240709111901.GC4421@lst.de>
 <tencent_651BC4D11C9730062064ACB186AF4A904005@qq.com>
 <20240709114629.GB6959@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jul 9, 2024, at 19:46, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Tue, Jul 09, 2024 at 07:39:29PM +0800, Yangyu Chen wrote:
>> The reason is that some optimizations failed to apply after adding
>> some passes. I will fix the compiler later. Whatever, we should not
>> rely on this optimization to get the code being successfully =
compiled.
>=20
> The Linux kernel relies on constant propagation and dead code
> eliminiation a lot to make code simpler and more readable.

Actually, the compiler is patched LLVM with -O2 optimization. I didn=E2=80=
=99t
turn off the optimization.

You can see what we did for the compiler here[1] and compile the
kernel with `-march=3Drv64imac_zicond_zicldst` added to KBUILD_CFLAGS.
I added conditional load/store pass as Intel did for the x86 APX
extension, which appeared last year (called hoist load/store in
LLVM if you want to search the PR), and then LLVM failed to optimize
this.

The only failed symbol on the kernel with `ARCH=3Driscv defconfig`
is `arch_dma_set_uncached` since the compiler requires all possible
values to be known. I think a pattern like in kernel/dma/direct.c:349
for symbol `arch_dma_clear_uncached`, which uses `if
(IS_ENABLE(CONFIG_ARCH_HAS_xxx)) xxx` is acceptable. But for the
symbol `arch_dma_set_uncached`, a complex analysis is needed for a
value set in a block of branches. I think we should not rely on such
compiler optimization in such a complex pattern.

In addition, patching this way can also make this symbol safer to use.

[1] =
https://github.com/cyyself/llvm-project/tree/zicldst-support-bugless-v3

Thanks,
Yangyu Chen=



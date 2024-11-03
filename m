Return-Path: <linux-kernel+bounces-393702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2789A9BA432
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29591F21989
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA016130C;
	Sun,  3 Nov 2024 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZhOnLPsc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3BC158D9C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730612448; cv=none; b=n34IJL7P/6SCmmKmvkV0+76ANdYopBElOBGEecn3BA5nrq+RGxYcvMr/V0fkMNuWLLHJyxM14XeyfaJ8T0bRvxp3N65bgQRodAsXkBKbvS67kprI8XQYJnjN5k8EDavQYGgR7QT9c+LbUisJzolNCvgSnuFZphT/CXI6pw0MdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730612448; c=relaxed/simple;
	bh=Ox3/MnuN2bbw3l9r0WFnjX55/uhhh1VM1mDuKtnilfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLCcSEiLptnV9LxF33lPT4IZ/x6HuhjlACahbokOmjw5f+skcK+rtvv6p0yOhGWxcAQRMCYPe7mBb+YJJmxn46LpjMJDEmrKu4c3YzRPx3zk1KPEUWiJxwFEXz2zFfz/VBzYgygajNVR8+JAwYoBO4upJwonDMXjZUaa4IGuTts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZhOnLPsc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=00LBfdePtVjoMz5Goiqj3TfM6d1ERcfKYUF+vI7ZIfk=; b=ZhOnLPscHbI4A3YfoBJDDqT7L5
	LiKex09k9Y8n51FyefJ4Wh87pP9OJJVORyZW3FPqmqttlNCZc44eKYAgpC0lf6ZTwyOUfWlEGc27c
	1x0vrOfb2MOOAuqh7/9x8cgOd5GpYbjMVP0QNuTc9oqQM4Tvagkpwj+hzr61o84NLVtvsTR+YykFT
	CCioXSDzqcEdqhLp6G1DUHnTRxaNFF61Lp8DKrYTclRGFlQ1hKyuk+50C8lAqvmotZVSZMsCvKh6D
	LcPGX4VuTZviCLqEQw4mzBn4HbD6uToP8v7/onJ9Fqh65abb7vlZRLSj/GYw9w9GmmW8bGaiKDNhA
	/h8dAFsQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLb-0000000B4NT-41Fo;
	Sun, 03 Nov 2024 05:40:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLa-0000000FvL6-2v0A;
	Sun, 03 Nov 2024 05:40:22 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH 0/7] x86/kexec: Add exception handling for relocate_kernel
Date: Sun,  3 Nov 2024 05:35:25 +0000
Message-ID: <20241103054019.3795299-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

Page faults in relocate_kernel() are extremely painful to debug. Provide a
basic exception handler which will just dump the exception information and
registers to a serial port.

It's disabled by default and has to be enabled with #define DEBUG.

While I was at it, I also stopped swap_pages from actually swapping pages
in the case of a plain kexec without preserve_context. Unless I'm missing
something, that's just a pointless waste of time.

David Woodhouse (7):
      x86/kexec: Clean up and document register use in relocate_kernel_64.S
      x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S
      x86/kexec: Only swap pages for preserve_context mode
      x86/kexec: Debugging support: load a GDT
      x86/kexec: Debugging support: Load an IDT and basic exception entry points
      x86/kexec: Debugging support: Dump registers on exception

 arch/x86/kernel/relocate_kernel_64.S | 265 ++++++++++++++++++++++++++++++++---
 1 file changed, 246 insertions(+), 19 deletions(-)



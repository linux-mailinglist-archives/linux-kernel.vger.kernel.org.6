Return-Path: <linux-kernel+bounces-291993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B53D9569E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684C21C22817
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171216728E;
	Mon, 19 Aug 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH7yaaGP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29631662E7;
	Mon, 19 Aug 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068254; cv=none; b=ORMYli5edU1/Q1RBDSVAxMTD5Pah/aEgkZIsHJBo7X3kM4ct0CALWlF96DcSyp4xZQ1VTrQuH1bFYT0wrSpyu+LlxZiQr1V3I6BqgXuMng+BS1gleimugoNDBJP+rNpS8CK+yrLyPtCspAgSdenRgPpB0ILhezM2lKBxLvJSXok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068254; c=relaxed/simple;
	bh=620CqvVhgEg8yAKm2hSicXxxTSPtUohR0aIsNsb7RzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT/Q56tmknOtdOikVogwKGiqV0hw34jVgbqYSaTSUEYrqWaESYzJlxYU/eklDxYf8BIYRcfboBrSvBNdibGdqkD3myar9PYTCYHhL1AHOomkzqDHZed8OresdUqWiBxxppVKQMLDkyWgBpMJiFH86PldXgZ+DaPVLP1Jq2KLVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH7yaaGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69E4C32782;
	Mon, 19 Aug 2024 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724068253;
	bh=620CqvVhgEg8yAKm2hSicXxxTSPtUohR0aIsNsb7RzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nH7yaaGPw0HJC4yk91YY/FnupXtb/Gi/wXc7UV3gQSNw/QEe3VrlAVKy/ksLlYh4s
	 pSJaBPezIl6IbeITHf+VHSXGDM23Nvw1X6z0ANpe4JQBW+iet9GCxAy7XMcsH4r+9V
	 xf+18cTw3rplHMNAdoAnsf0r6cauMhZA9O9qcta0fIVzIW7mqNz8fRDu8+dZsezVIZ
	 oIb7YocEGhdV8q79AwYqU2hvyXxhbKF4EWXeDgBxPKGZ/1GQfoORr3NO8uFeAY7P9d
	 G2LJ580EjNIX+mhdpgD/o12RoNX/61a7GllsrSicslJuNZjYJVSZMW0NvkNiMxV7jb
	 LyKvo3nFMauLg==
Date: Mon, 19 Aug 2024 13:50:46 +0200
From: Alexey Gladkov <legion@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v3 03/10] x86/tdx: Allow MMIO from userspace
Message-ID: <ZsMxlu8_D4ZxFFqR@example.org>
References: <cover.1722862355.git.legion@kernel.org>
 <cover.1723807851.git.legion@kernel.org>
 <2a79d86c268d934644b8e4a5a8c59b4699fa0015.1723807851.git.legion@kernel.org>
 <kzd355wuaf5bphybast36u3svr76glvxr5fni6vfiiwbc7zotv@uikypstswh6h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kzd355wuaf5bphybast36u3svr76glvxr5fni6vfiiwbc7zotv@uikypstswh6h>

On Mon, Aug 19, 2024 at 01:46:34PM +0300, Kirill A. Shutemov wrote:
> On Fri, Aug 16, 2024 at 03:43:53PM +0200, Alexey Gladkov wrote:
> > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > 
> > The MMIO emulation is only allowed for kernel space code. It is carried
> > out through a special API, which uses only certain instructions.
> > 
> > This does not allow userspace to work with virtual devices.
> > 
> > Allow userspace to use the same instructions as kernel space to access
> > MMIO. So far, no additional checks have been made.
> > 
> > Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> And you seem to lost Reviewed-by from Thomas:
> 
> https://lore.kernel.org/all/874j867mnd.ffs@tglx

No. I removed it because the patch changed a lot after his review. I
didn't want to mislead anyone.

-- 
Rgrds, legion



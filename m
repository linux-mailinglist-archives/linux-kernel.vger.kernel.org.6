Return-Path: <linux-kernel+bounces-576209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF5A70C64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0977A5B45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642F1A8F60;
	Tue, 25 Mar 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIf3IP0a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57141DD0F6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939451; cv=none; b=cWOaSMjc6f6vge8RboJ6nJE91rNjGGenLIdz5OqlCkrZkCmm+ehqmL0EDaoWz2C0MlpfDh9oXosbOGVxbsT4aw+DI4qbt3x1PGTNMZRbb5M4pZ2EsK6oLhsiyzeuHe2+GN1QHCQtORAUgpVUGucClOUPws8hvKFbjNFLRMktuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939451; c=relaxed/simple;
	bh=0ncrgXVqzHkxnPeTIlTB/YOt4C74bI7yxW8wiQjRYBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So63YIgZoG2m1kYTjEBRYDxbE/DvfOXYIB/xM/y1FeBRBndTFGuYkUAGgjl/GFaAf2YpyzVF2qFRaiMNWQu5tD2a1IKZ46XFUgdJ1VPcchj0p2wfvPEGRcCJSnMhYo0DKdudfFzVqLWsN7QKbvDbQGZgb2d8dYogbbT6RRDI9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIf3IP0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F62C4CEE4;
	Tue, 25 Mar 2025 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939451;
	bh=0ncrgXVqzHkxnPeTIlTB/YOt4C74bI7yxW8wiQjRYBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIf3IP0amQt+GvTLu92ZiT3I8K9Vw89xVR8/1jMSjvxevaAmgcjhXIt21Y7lz+xyf
	 huquTqEjKnSGiAbaubL74VG7YQ6O41UYDk376Vqv7Vo4PdcUKYNqj2LizFM5/Wu+Zc
	 AwJSi0rjQ1qKrlbyirbf6izQ040ZOqh/y3j0nMyekzq1BvNZqZWbRjpzEwrACAocSH
	 a0T9yREUhrhC52HY8HU9b0navj2w8wFizOwgBiKYAh0ssY42ehM2LuF4AUKj+BzEMK
	 T/oLI6kbCIXHeqXxQgV4f1kiTHLOF+1Xv2BOWJxJOUh/4niiBQ9J3FyktTpHusQ2yy
	 HQH1BPgRnu9Cw==
Date: Tue, 25 Mar 2025 22:50:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip 1/2] x86/hweight: Fix false output register
 dependency of POPCNT insn
Message-ID: <Z-MlMardXbnknUzS@gmail.com>
References: <20250325164854.199420-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325164854.199420-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Sandy/Ivy Bridge and later Intel processors, the POPCNT instruction
> appears to have a false dependency on the destination register. Even
> though the instruction only writes to it, the instruction will wait
> until destination is ready before executing. This false dependency
> was fixed for Cannon Lake (and later) processors.
> 
> Fix false dependency by clearing the destination register first.
> 
> The x86_64 defconfig object size increases by 779 bytes:
> 
> 	    text           data     bss      dec            hex filename
> 	27341418        4643015  814852 32799285        1f47a35 vmlinux-old.o
> 	27342197        4643015  814852 32800064        1f47d40 vmlinux-new.o

I don't think adding an instruction for an old-microarchitecture 
weakness that has been fixed in new hardware already is worth bloating 
the kernel.

Cannon Lake was released in 2018, 7 years ago.

It will be 1-2 years until such a change percolates to Linux users, and 
by that time the microarchitecture with the fix (Cannon Lake) will be a 
decade old, and a majority of Intel CPU users will be using it.

So I don't think this particular change is worth it, unless the false 
dependency can be quantified to have a huge impact on pre-Cannon-Lake 
CPUs - which I don't think it is.

Thanks,

	Ingo


Return-Path: <linux-kernel+bounces-379655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD9F9AE1A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07CDB23955
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546441C1758;
	Thu, 24 Oct 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYkvypPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF551B85E2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763757; cv=none; b=DQ7dgAGEip1dgElHylcM9JUzjcvfIA6rywgElRXnO6Iv8brnbZJ9YZiB7oTDRUSf5pN1azer7B9/4zEkSRP2oJ+TbhVxIyL/ar1PdC4zZuOonpLiA76rTEOYuPQvvs3bSv60pWzl8TqcbYAtpWDEV82zxeo73AH6ASyqR6CoJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763757; c=relaxed/simple;
	bh=tcrxRLl/OzaRuQ9o5aYtoKewuGdB+2CJagNfVM2lzvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihUL4wpgW7hJm8mS2rvEaZe2RmiJAA4UPYgm6YnCwPDjvzGviery3TjiYQnyf+lqAAsqQnhq6C3OJpd2MFNNDGNDVoxD1vbf/s9Mii9PJnFH2JBvp3odlyIpsaacRDbUQU4q2iA6Qhj/XoE62sldl9dVibn6hdrvgY/axj8uBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYkvypPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C08C4CEC7;
	Thu, 24 Oct 2024 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729763757;
	bh=tcrxRLl/OzaRuQ9o5aYtoKewuGdB+2CJagNfVM2lzvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYkvypPGLLfC0X6yWs5+WZA8Mtx01XSHuQFMU3Tq/3dIaP84utXxCv8+GuAdoaLO9
	 UEQxElA/GS43x3vgMjK7Q4t1jWyNQGjQViTtS4tMBGbxTkbtmXDmk+hF7JR9D71BKq
	 5F1KCyehLwwgOmpMSBrd35yupJIMGuDMA3WgO21U=
Date: Thu, 24 Oct 2024 11:55:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-50063: bpf: Prevent tail call between progs attached to
 different hooks
Message-ID: <2024102419-deserving-veneering-6641@gregkh>
References: <2024102136-CVE-2024-50063-1a59@gregkh>
 <phyhoab337c2vgpfgtrjru2so6luvmymfrugdazacz3sk4to7n@nutpfnn4ivdx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <phyhoab337c2vgpfgtrjru2so6luvmymfrugdazacz3sk4to7n@nutpfnn4ivdx>

On Thu, Oct 24, 2024 at 12:04:45PM +0800, Shung-Hsi Yu wrote:
> On Mon, Oct 21, 2024 at 09:40:04PM GMT, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > bpf: Prevent tail call between progs attached to different hooks
> > 
> > bpf progs can be attached to kernel functions, and the attached functions
> > can take different parameters or return different return values. If
> > prog attached to one kernel function tail calls prog attached to another
> > kernel function, the ctx access or return value verification could be
> > bypassed.
> ...
> > This patch adds restriction for tail call to prevent such bypasses.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-50063 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> 
> I do not know that exact commit that introduced the issue, but given
> that the fix addresses the following BPF program types:
> - BPF_PROG_TYPE_TRACING (v5.5)
> - BPF_PROG_TYPE_EXT (v5.6)
> - BPF_PROG_TYPE_STRUCT_OPS (v5.6)
> - BPF_PROG_TYPE_LSM (v5.7)
> 
> The earliest affected version possible should be v5.5.

So what commit id should we use?  Can you send a patch adding the
".vulnerable" file to the vulns.git repo for us to mark this properly?

thanks,

greg k-h


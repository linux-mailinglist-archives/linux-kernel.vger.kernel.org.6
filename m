Return-Path: <linux-kernel+bounces-374378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8945B9A694A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A945281AED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1791F5829;
	Mon, 21 Oct 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mv784Wue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D3A1F4736
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515497; cv=none; b=eITCZCVbndI4QCX6x9f+wFKNKNZ8GLA9fOqQz3xOoIrV1Ej9XJiAE/4pZNDVlykhjTr/aRKUGcn1E8k0mEK44S0B4MS5iTQGOOWJwJ+uXcWel1XJG3sQpiu1q6Oknv7HPlMYCLrpCyqu+G5EZoTbIk3qYCvuL+4T5J6heoaBnL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515497; c=relaxed/simple;
	bh=3vu0JofoymfUhM6npiay9YuMqWoVk1q7AbGGS4jH0nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODEpBoCC4TEAVnXOOk80gt4ZUyIZbSNuDpZJt8fQkof9cVtcu8beUxCohtKsBLv48TSgWaiXns8tyQQzn/gyerTQx8YwaGa+fFDzs+p/kJcItNNnrWGloX6Smz30eL5D784lYVzpbO2bvdfOs9cQu+cR0nfsejk9iICjjfQ4fa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mv784Wue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C28CC4CEC3;
	Mon, 21 Oct 2024 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729515497;
	bh=3vu0JofoymfUhM6npiay9YuMqWoVk1q7AbGGS4jH0nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mv784WueaXOUo0YGsyhnyW75O3TDGx1Cpewe97uu1JAoyFGvtJP9BIUbpsFyNnE/x
	 Wf9z1TAX05a4bsm9xNOWEtz+R6RNxoGEsJrb7bmKcltAaHS8dJZn7zjygOUXPbfTcZ
	 T0TdzoE23iDN6Opm6uPvnKl9PMIJazQOtd7Nk44k=
Date: Mon, 21 Oct 2024 14:58:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-47722: xen: use correct end address of kernel for
 conflict checking
Message-ID: <2024102152-stinky-tiger-4e51@gregkh>
References: <2024102103-CVE-2024-47722-dc6e@gregkh>
 <11213aab-7ef9-474e-8ada-6397a7e74d7b@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11213aab-7ef9-474e-8ada-6397a7e74d7b@suse.com>

On Mon, Oct 21, 2024 at 02:35:16PM +0200, Juergen Gross wrote:
> On 21.10.24 14:16, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > xen: use correct end address of kernel for conflict checking
> > 
> > When running as a Xen PV dom0 the kernel is loaded by the hypervisor
> > using a different memory map than that of the host. In order to
> > minimize the required changes in the kernel, the kernel adapts its
> > memory map to that of the host. In order to do that it is checking
> > for conflicts of its load address with the host memory map.
> > 
> > Unfortunately the tested memory range does not include the .brk
> > area, which might result in crashes or memory corruption when this
> > area does conflict with the memory map of the host.
> > 
> > Fix the test by using the _end label instead of __bss_stop.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-47722 to this issue.
> 
> I fail to see how an unprivileged user could cause any harm here.
> 
> This bug is affecting the guest only, so only the guest admin can cause
> harm to the guest at will via a special kernel. IMHO nothing CVE-worthy
> here.

Ah, I thought this could affect the host, sorry about that.

> So I'd like to ask for this CVE being revoked.

Now revoked!

thanks for the review.

greg k-h


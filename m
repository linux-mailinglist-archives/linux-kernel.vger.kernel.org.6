Return-Path: <linux-kernel+bounces-200788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360B28FB4F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BD61F263A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599D13D26C;
	Tue,  4 Jun 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b1EHDFBL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64E13D270;
	Tue,  4 Jun 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510361; cv=none; b=CNRK52w9g91EVQ1HFT+4mUdmhlY9zxzurMcpTAVAyt9jrky1uExeXeoISyW+LBv+dNLdUbhSzi674NMj03HFgPxZG3Fo51+VhF71XzLyl+ngEwguQ8ce1SXfiFmyRfHwHuaBu40JzezHhA9+SXsiyN+2nJ3K5obLE4wp6yflzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510361; c=relaxed/simple;
	bh=Y6UmJIt/ZPtSwsx3TQxx71w9xoPH2Deyu6uTfLtpzB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1qWdtrzOKglkv6opUqQ1Sa7XIdSpDKckul20EkjNXuJRDfUpjkPcDSgHcjG5ZAA1+Wz8tgUi+TPJWxIPKpwNWn/5kCtonYYfVIce0ngTK9rEgv8GuQpW2QHmCC//fYflzh8AKLOeb+GDcJamRlDHyKNE6XIUF9T/Q6ZT9ATeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b1EHDFBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A52C4AF08;
	Tue,  4 Jun 2024 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717510360;
	bh=Y6UmJIt/ZPtSwsx3TQxx71w9xoPH2Deyu6uTfLtpzB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1EHDFBLrdPaz0KmFZKdQ/9zHE3q/XoFUu+B/+u18DoLy5YY2n9C4LLsvMW9wUvUj
	 yLzdrZ0oujUE4Ui6mExPQe8BX52r5PmTeX/WhSqqHUwKhhGV56cwXpaBje3wzsn9dp
	 8ZeZ4PQogxB6Fi2v+/uFXl/yOyEx1q5myd9zuZ1Y=
Date: Tue, 4 Jun 2024 15:58:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] alpha: drop pre-EV56 support
Message-ID: <2024060457-graded-editor-5bd4@gregkh>
References: <20240503081125.67990-1-arnd@kernel.org>
 <20240503081125.67990-15-arnd@kernel.org>
 <e0492052-46ff-40e4-96e0-aecb88b68f0f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0492052-46ff-40e4-96e0-aecb88b68f0f@kernel.org>

On Mon, Jun 03, 2024 at 08:02:03AM +0200, Jiri Slaby wrote:
> Cc Greg for awareness too.
> 
> On 03. 05. 24, 10:11, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > All EV4 machines are already gone, and the remaining EV5 based machines
> > all support the slightly more modern EV56 generation as well.
> > Debian only supports EV56 and later.
> > 
> > Drop both of these and build kernels optimized for EV56 and higher
> > when the "generic" options is selected, tuning for an out-of-order
> > EV6 pipeline, same as Debian userspace.
> > 
> > Since this was the only supported architecture without 8-bit and
> > 16-bit stores, common kernel code no longer has to worry about
> > aligning struct members, and existing workarounds from the block
> > and tty layers can be removed.
> 
> Yes!
> 
> For TTY pieces below:
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Nice!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


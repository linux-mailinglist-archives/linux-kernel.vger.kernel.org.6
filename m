Return-Path: <linux-kernel+bounces-345464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E398298B699
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984CE28210F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C61BE22B;
	Tue,  1 Oct 2024 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gzg5NOhJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71E1BD023;
	Tue,  1 Oct 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770319; cv=none; b=g9AMJNIbEe3vJuH6QrAcGTLZb2mZGSvgafdKzYcg/E7H2qY91d8ZWqtijVIIG7CnaYy8CPCF22i6YhYdd4Z/MAmwp9Xi94aHGZUfByHbF3oZe90/+1o2J0Lq60esTMAEOQXEShIeh9KnZr6zSpQe8eF/Ik6rSUTCgtfAQ2bOcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770319; c=relaxed/simple;
	bh=hhHIyX1ZLa1Wtg5PpvQM/gh9ro8zwXaXwLn9YR1AoWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3+aQ2VB/FjbkbOFI1qZQ7hwZtBKWjQ1mUkpGPXNxj4nFSvnnxRjPPISniOXOFhXUkbo08dGkXkAQy2gtp/PwLgVTA6/FyWF5WrJWCZui4b5PddrnHqMQvvxUktzXGgtkzg0W7njMRv3ja6MXp8VFQJ/P/GtT2X7IBhSRE16yFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gzg5NOhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B43C4CEC6;
	Tue,  1 Oct 2024 08:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727770319;
	bh=hhHIyX1ZLa1Wtg5PpvQM/gh9ro8zwXaXwLn9YR1AoWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzg5NOhJZuJdmSW86IXv1b2ik7Z2p+sMPoH+JZcFyf8w55rWW9jYTcGnHXjZBlQmX
	 kDguSmLRA0xP+6/TdpFD3EArANT7oz4FhKuFPcpavma3mhnpOOdTODix+iIZRYrOVq
	 P/JVxjkqNJWWx/5eLoBAtHS6/TDTtTd7GtzbEykI=
Date: Tue, 1 Oct 2024 10:11:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	rostedt@goodmis.org, mingo@redhat.com
Subject: Re: [PATCH 5.4.y 0/2] tracing/kprobes: Backport request about
Message-ID: <2024100111-alone-fructose-1103@gregkh>
References: <20240927214359.7611-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927214359.7611-1-sherry.yang@oracle.com>

On Fri, Sep 27, 2024 at 02:43:57PM -0700, Sherry Yang wrote:
> The new test case which checks non unique symbol kprobe_non_uniq_symbol.tc 
> failed because of missing kernel functionality support from commit 
> b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols"). 
> Backport it and its fix commit to 5.4.y together. Resolved minor context change conflicts.
> 
> Andrii Nakryiko (1):
>   tracing/kprobes: Fix symbol counting logic by looking at modules as
>     well
> 
> Francis Laniel (1):
>   tracing/kprobes: Return EADDRNOTAVAIL when func matches several
>     symbols

As per the documentation, we can't take patches for older kernels and
not newer ones, otherwise you will have regressions when you finally
move off this old kernel to a modern one :)

Please resend ALL of the needed backports, not just one specific kernel.
I'm dropping these from my review queue now.

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-192895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3A08D23A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33104285788
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841016D4FC;
	Tue, 28 May 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K19noRN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635F39852;
	Tue, 28 May 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922978; cv=none; b=HRWXncasruRheTMJ9GCC46TF5+P2OyFIWtdSnf5hZL/Gd5z5DmbLY7heVyeNVWV3cmwDnc1MfNxWWWKjeRzCGFexZTdslwxUpFuPttMXbA8vT6jojtsAM9ZkCmeTK+dYHEheEUM2nHDMVycUVzwEbwWQnykngA3wjOonHqgMf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922978; c=relaxed/simple;
	bh=GD3/dN6ZzfzJRaXladDHQA1hNTErMD4rTa0AbrBxOys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzNKHbGkVNj9cFXr3ZNglL5G6ecr0gkwRAiyT83CWJS8U+AWgQOc2CWQ7drCgG8n85ICYcpNZmIxnjRAMCAwBmO9xzt+zAyLlx4V//vDsagGERwSuyFhcY4APvXOU6oAFgyvC4j/GF79FRVn0OQTE6hDKCO0pvgIlKDuq0fJAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K19noRN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F71C32786;
	Tue, 28 May 2024 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716922977;
	bh=GD3/dN6ZzfzJRaXladDHQA1hNTErMD4rTa0AbrBxOys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K19noRN/T7YC+i1E7Fkaoig7m7TchlX7Ihp54S2kNAmAvFxD77KVCgZp7oBpY/nrE
	 vH9MWNO2aQmpDABcsobPDhIHqyq3jmSTGwQ0RhfWTuQP1x93puLo6ULybvUuu4fFns
	 +Um0sNgoRC2z1kA5bcjukNYj3/wU+18y3tkozg5Q=
Date: Tue, 28 May 2024 21:03:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"Xen.org security team" <security@xen.org>
Subject: Re: CVE-2021-47377: kernel: xen/balloon: use a kernel thread instead
 a workqueue
Message-ID: <2024052826-overpass-manliness-7f2c@gregkh>
References: <2024041747-CVE-2024-26908-4690@gregkh>
 <9fba239d-2e22-425b-b45f-86ecf016c2fd@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fba239d-2e22-425b-b45f-86ecf016c2fd@suse.com>

On Mon, May 27, 2024 at 12:58:16PM +0200, Juergen Gross wrote:
> Hi,
> 
> I'd like to dispute CVE-2021-47377: the issue fixed by upstream commit
> 8480ed9c2bbd56fc86524998e5f2e3e22f5038f6 can in no way be triggered by
> an unprivileged user or by a remote attack of the system, as it requires
> initiation of memory ballooning of the running system. This can be done
> only by either a host admin or by an admin of the guest which might
> suffer the detection of the hanging workqueue.
> 
> Please revoke this CVE.

Ah, good catch, this came in as part of the GSD import, and I missed
that this required that type of permissions.  Now revoked, thanks for
the review!

greg k-h


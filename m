Return-Path: <linux-kernel+bounces-545802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CB3A4F1B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C6716DDC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A124DFE1;
	Tue,  4 Mar 2025 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="n5Dvx1am"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643F1FF7BF;
	Tue,  4 Mar 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131835; cv=none; b=WH/yE+AYW5vUBWdh80R0Ir7q8OYMarX9FYykdR1PRFwa0ZNv7PNqymFnzGLmthSjSAEwpOQAXJcGC2WAMJct+Bh8j8odnBr/7GIh2Jrtq5ods6oiLGizWAGYwRMYfD52J5ChP6c7bL7mmSiprXd6TqfYsl5SYwMlDP6Tv54geqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131835; c=relaxed/simple;
	bh=KJTrKAUFeXqKd7gJGLa34anESOCeXSsRQo75HdiIUuc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XpaLSYNzo88AblanvK3NfjcNDXBuKrRCZI/YjAP6B1JnsffowIrMw57p8xjWTmqdERSqOQdISRXcE6SZaptmXRtUudbe7vVcnpV1QmImvmQVvTCpkDlvEdllJ9LQVmMKkfoimRURC+Ny68uAQa1cbqmSEBG9MpzLmigGqyQlDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n5Dvx1am; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3185BC4CEE5;
	Tue,  4 Mar 2025 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741131834;
	bh=KJTrKAUFeXqKd7gJGLa34anESOCeXSsRQo75HdiIUuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n5Dvx1amUKlj7tZ5ib0hANnaD0kL4bR5H++aFlnZlMavfGt2NvSv6biQs+v5UsvXU
	 qTBHf4/fEDaPUrfNWTEj2itQHGutHHiZOgCv7mvYnRX1j2oTx9CSeqItjR3GkL8Kqz
	 5OpDEIdQBk+dgK8S/UPygPvRVQMGSres/aTiqcsk=
Date: Tue, 4 Mar 2025 15:43:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, ebiederm@xmission.com,
 kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-Id: <20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
In-Reply-To: <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
	<xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
	<Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 19:12:27 +0800 Baoquan He <bhe@redhat.com> wrote:

> On 01/13/25 at 12:01pm, Kirill A. Shutemov wrote:
> > On Fri, Dec 13, 2024 at 05:49:30PM +0800, Yan Zhao wrote:
> > > Hi Eric,
> > > 
> > > This is a repost of the patch "kexec_core: Accept unaccepted kexec
> > > destination addresses" [1], rebased to v6.13-rc2.
> > 
> > Can we get this patch applied?
> 
> This looks good to me. In v1, we have analyzed all other possible
> solutions, however change in this patch seems the simplest and most
> accepatable one. 
> 
> If Eric has no objection, maybe Andrew can help pick this into his tree.

OK, but that patch is the only thing in the world which is older than me.

Yan, can you please refresh, retest and resend?

Also, please consolidate the changelogging into a single email -
a single-patch series with a coverletter is just weird.

Putting the [0/n] info into the singleton patch's changelog is more
reader-friendly, and that's what counts, no?

Thanks.


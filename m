Return-Path: <linux-kernel+bounces-545814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E47FDA4F1D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D606188CF88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892927700D;
	Tue,  4 Mar 2025 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wNRQrFVy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D3BA2D;
	Tue,  4 Mar 2025 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132409; cv=none; b=XjctAS8uReeTikZqVGr34PZKTlEW+0PIQ6DO+OuMWhA8iRwvpdVEr+0askCaVTVqYSwjTs9lUIWuBdHcvn8tE/vHM+IfBzuHExsX3EGm03/HGnvl3iFT2yVHmdfZMrBJwnU7gmU3oqEkuljXnoHWUELFTI2BCP8J2Bwnn9WXRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132409; c=relaxed/simple;
	bh=q4ihMWeSDYGy90QmpRS0XEWYMYyxawUw1y5E7gZ+Sa8=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JaPs3vmmxBsoyuuGh9LTLU2+Iul9qAPo/IAtDrGg7LEUAB/ua3S8QB0VI+LbKaOeuUCQeE3pOOuWcSyvJa7wciC8/QBflfjlhA2ZrtSgvgo1eX0zmyzAaRNuqk8AApAy0npLKac4Vt08KOf1oiPyfsU0Da5Kb2uslcASz007EJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wNRQrFVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515A5C4CEE5;
	Tue,  4 Mar 2025 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741132408;
	bh=q4ihMWeSDYGy90QmpRS0XEWYMYyxawUw1y5E7gZ+Sa8=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=wNRQrFVyFEe0fO6KvuTU05ovjEYjylU6yNMdXwoT+vAT1RwAeJwXDigVUNNXusFvB
	 vbifi5NzMjDZmdMxGVi6hlYr6QwGft/wuXUkjyqoE5jKIt5NwHmfPYOnG1N2zcC3aP
	 T86iJXnZMZq3K8txWYo6bmX1mK0QiOxhTGaXWyW4=
Date: Tue, 4 Mar 2025 15:53:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov"
 <kirill@shutemov.name>, ebiederm@xmission.com, kexec@lists.infradead.org,
 Yan Zhao <yan.y.zhao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-Id: <20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>
In-Reply-To: <20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
	<xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
	<Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
	<20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 15:43:53 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 13 Jan 2025 19:12:27 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > On 01/13/25 at 12:01pm, Kirill A. Shutemov wrote:
> > > On Fri, Dec 13, 2024 at 05:49:30PM +0800, Yan Zhao wrote:
> > > > Hi Eric,
> > > > 
> > > > This is a repost of the patch "kexec_core: Accept unaccepted kexec
> > > > destination addresses" [1], rebased to v6.13-rc2.
> > > 
> > > Can we get this patch applied?
> > 
> > This looks good to me. In v1, we have analyzed all other possible
> > solutions, however change in this patch seems the simplest and most
> > accepatable one. 
> > 
> > If Eric has no objection, maybe Andrew can help pick this into his tree.
> 
> OK, but that patch is the only thing in the world which is older than me.
> 
> Yan, can you please refresh, retest and resend?
> 
> Also, please consolidate the changelogging into a single email -
> a single-patch series with a coverletter is just weird.
> 
> Putting the [0/n] info into the singleton patch's changelog is more
> reader-friendly, and that's what counts, no?

Oh, I remember this patch.

Eric, your feedback has been unusably-by-me enigmatic :(

In fact the whole multi-month review discussion has been quite
indecisive.

Yan, please go back through the discussion and incorporate reviewer
feedback into the changelogs: describe the possible issues which people
have raised and your responses to those.  Then resend and then let us
restart the review process.  With less reviewer latency please!


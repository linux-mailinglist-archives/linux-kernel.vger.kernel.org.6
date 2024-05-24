Return-Path: <linux-kernel+bounces-188595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D88CE411
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F6028256F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D384E09;
	Fri, 24 May 2024 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hIZ1OUEc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30A1AACC;
	Fri, 24 May 2024 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545750; cv=none; b=aeWy/H2dUp0se/+cf/B4KCrrvncLsH7hgg5GO/81ro98GIjonK8FIwGHAeBK0/HyNHpiidQSygB2aa5U/xKgUTMFiUv9X6Vl5etkTY/xA69T5khwGPfiTWpk2OR3/ObYgf/xgkCRJDTQnvbnY+KtDBEYjrXOyVN4oNMBZrAoHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545750; c=relaxed/simple;
	bh=R5rYHQb1TAG58PbBXJgHJ+ttcFuaB23hec7lYtqwcMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvLujUTjsi4X5camy/zPUyrOonEGiNft3lBzORlahe4PE/HG7Ct6KYRt8bcFjifeUql8DKmpnXPjJbU9izTzV/R2zEmUOXMfjw/sRgRwMR/SBtJVxQaUsk6cXyamp1aq285gcH9Eph7DF2go0QydZGa5frq3+ZIDMOhGvA1N2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hIZ1OUEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD570C2BBFC;
	Fri, 24 May 2024 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716545750;
	bh=R5rYHQb1TAG58PbBXJgHJ+ttcFuaB23hec7lYtqwcMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIZ1OUEcDUHvmaS+RVIUyOCw/IBlOk/zRR5YB66EvWu45ufo84U1EvZznCiaRAVZf
	 3BeuhBX6I0HG1yYzKFQOxD6CgJhCyuI1Glg6DNYsWpF1N0VITNFcW0uP3vxTbvZCiZ
	 YdJiefejjI9QmHZQ4xp8g9V8wcpS2bKFX/in52JM=
Date: Fri, 24 May 2024 12:15:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <2024052420-clang-flatterer-366b@gregkh>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlBlorsBMPK0RdnR@dwarf.suse.cz>

On Fri, May 24, 2024 at 12:02:10PM +0200, Jiri Bohac wrote:
> On Tue, May 21, 2024 at 05:31:59PM +0200, Greg Kroah-Hartman wrote:
> > kernel: kexec: copy user-array safely
> > 
> > Currently, there is no overflow-check with memdup_user().
> 
> This is false. 
> Therefore, I'd like to dispute this CVE.
> 
> The overflow check is in the kexec_load_check()
> function called shortly before the memdup_user() call:
> 
> 
> 	SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> 			struct kexec_segment __user *, segments, unsigned long, flags)
> 	{
> 		result = kexec_load_check(nr_segments, flags);
> 		if (result)
> 			return result;
> 	...
> 		ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
> 	...
> 	}
> 
> 	#define KEXEC_SEGMENT_MAX 16
> 	static inline int kexec_load_check(unsigned long nr_segments,
> 					   unsigned long flags)
> 	{
> 	...
> 		if (nr_segments > KEXEC_SEGMENT_MAX)
> 			return -EINVAL;
> 	}

Nice, but then why was this commit worded this way?  Now we check twice?
Double safe?  Should it be reverted?

I'll go revoke this, thanks for the review!

greg k-h


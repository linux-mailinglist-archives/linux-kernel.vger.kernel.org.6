Return-Path: <linux-kernel+bounces-188693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF508CE566
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354E61F218DC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E0086244;
	Fri, 24 May 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D1CZGy2G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AHZAa8I3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D1CZGy2G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AHZAa8I3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6771E49E;
	Fri, 24 May 2024 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554288; cv=none; b=XtQGp8Lc3HxqilAlVG0IlkRyiJ3sQFjXOKpP8xrUsgJVD/gXNKA2/O0BmwuBv8e6ZKpty9+bSS+GWdSSw3cj2/gbjkSSta71ka40LCZKZSvIeKBbFsXTHbEVuGhh4BNxOiH8gkrOl1wVAmqA80y+AIqEtIvWG3zUOb3iNH3eAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554288; c=relaxed/simple;
	bh=fNZjmpb/FVXT/dHFTp9EQxw66F6qlaIwRubDvEf9oN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLtkXBwjF1IRZNbnu75vWrUZyNmidTZCv5mHX8ETgKk3XX9TLdFN09FI4uxg4d/WIbzrftEirX+sZ3iVnlr+xLqpnK7bsDenEeMFblMPtgqvqrKNI20Qmykrg/TpIZRPCU6DLU+pbJvUWReQa7gp9oA7/pEqMrlU5YCGlehvaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D1CZGy2G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AHZAa8I3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D1CZGy2G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AHZAa8I3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 6309E219F5;
	Fri, 24 May 2024 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716554284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH+cIQgHigfiRrL5Re6khJx78pW80kZiWjggQiG0ak=;
	b=D1CZGy2G8ZZEhsMZDJalCQTJFpTGTJrG+NnOg4KcEGVFMxmFi36ybC1hwRTSpQJ+LYwIMq
	IZBWxWYl+1iD+V9aQAQR9U1qdeIPCXHLLDND7gbwybYfzqgZd1DfvWW+1Xk6Ek+azZBvI4
	/FwOoaZ4sdPhIdVB2BzapQ3yBghFPqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716554284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH+cIQgHigfiRrL5Re6khJx78pW80kZiWjggQiG0ak=;
	b=AHZAa8I3zWHJN+eVuoo18Vc3/+iMksugpARn41zA0iKtGVs3qYcLDphnrvSN83/vw2+3mR
	sXcFdw8E8YPLCVBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716554284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH+cIQgHigfiRrL5Re6khJx78pW80kZiWjggQiG0ak=;
	b=D1CZGy2G8ZZEhsMZDJalCQTJFpTGTJrG+NnOg4KcEGVFMxmFi36ybC1hwRTSpQJ+LYwIMq
	IZBWxWYl+1iD+V9aQAQR9U1qdeIPCXHLLDND7gbwybYfzqgZd1DfvWW+1Xk6Ek+azZBvI4
	/FwOoaZ4sdPhIdVB2BzapQ3yBghFPqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716554284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH+cIQgHigfiRrL5Re6khJx78pW80kZiWjggQiG0ak=;
	b=AHZAa8I3zWHJN+eVuoo18Vc3/+iMksugpARn41zA0iKtGVs3qYcLDphnrvSN83/vw2+3mR
	sXcFdw8E8YPLCVBA==
Date: Fri, 24 May 2024 14:38:04 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
 <2024052420-clang-flatterer-366b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052420-clang-flatterer-366b@gregkh>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]

On Fri, May 24, 2024 at 12:15:47PM +0200, Greg Kroah-Hartman wrote:
> Nice, but then why was this commit worded this way?  Now we check twice?
> Double safe?  Should it be reverted?

double safe's good; turning it into a CVE not so much :(
CVE-2023-52822, CVE-2023-52824 and CVE-2023-52820, originally from the same patch
series, seem to be the exact same case.

CVE-2023-52822:

	int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
				     struct drm_file *file_priv)
	{
	...
		if (num_sizes > DRM_VMW_MAX_SURFACE_FACES * DRM_VMW_MAX_MIP_LEVELS ||
		    num_sizes == 0)
			return -EINVAL;
	...
		metadata->num_sizes = num_sizes;
		metadata->sizes =
			memdup_user((struct drm_vmw_size __user *)(unsigned long)
				    req->size_addr,
				    sizeof(*metadata->sizes) * metadata->num_sizes);
	}

CVE-2023-52824 (here the check is in the immediately preceeding statement, could it
be any more obvious?):

	long watch_queue_set_filter(struct pipe_inode_info *pipe,
				    struct watch_notification_filter __user *_filter)
	{
		if (filter.nr_filters == 0 ||
		    filter.nr_filters > 16 ||
		    filter.__reserved != 0)
			return -EINVAL;

		tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
	}


CVE-2023-52820 is a little less obvious to be safe, but I believe it is:

	int drm_mode_create_lease_ioctl(struct drm_device *dev,
					void *data, struct drm_file *lessor_priv)
	{
	...
			object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
						 array_size(object_count, sizeof(__u32)));

	array_size() will safely multiply object_count * 4 and return SIZE_MAX on
	overflow, making the kmalloc inside memdup_user cleanly fail with -ENOMEM.


> I'll go revoke this, thanks for the review!

could you check and revoke all the above as well?

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia



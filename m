Return-Path: <linux-kernel+bounces-188855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B571D8CE7D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FE11C2225F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8212DDA5;
	Fri, 24 May 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tt7E37Ji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707712DD98;
	Fri, 24 May 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564416; cv=none; b=cqPi0Y1E3huKxu1lHtz9OtvVAH3gNdw1e2EyjGELMV5gTdPAV3AX+Hi1jb0EpyKMBLVVBv8kQ0tHT2iTawdyX+NiQ8pIbl2rdEhDsdqGP35VcyhvDPni8BD5fQxQZFFJHZKNmCyX84li++XilMsO2W5HNvr+1K2Qd2J1mb5asQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564416; c=relaxed/simple;
	bh=NLTly/Ziw39O2EegvKrx3fgQaIpoemL3GO1n6sD2/2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ/ihy4ftrj8DjOlaf+OmPWG6lbvMDI3BtMI5bf3YLehw69K68t1jCY3Ih41C1yG7SUyrC5jgsmDNo/ZByClKO7TFSvUvVM7t9fqZiL+xf8/4MdGmOa2NpN5y5v5JftE37ppKzRbjqEGPvSMm+C3Lr3VIpe5lwxnas1GuX4x5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tt7E37Ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDCCC2BBFC;
	Fri, 24 May 2024 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716564416;
	bh=NLTly/Ziw39O2EegvKrx3fgQaIpoemL3GO1n6sD2/2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tt7E37Ji8Nlrkf5LLq3db4+FpfySQAVKAFS21sgYgQ6veuRQXUovU4vxI1W1w+/ZT
	 T8SE7exYq6ze+kSfLxufUmg1HdsXQnimEzxw4G+2AJgouPEOTySKonFdwnstI0fuIC
	 GMcrW30P1EVP9sEXJCAZrp0VN+v3O1zSayi+12ao=
Date: Fri, 24 May 2024 17:26:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <2024052440-irrigate-tightness-4a8a@gregkh>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
 <2024052420-clang-flatterer-366b@gregkh>
 <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>

On Fri, May 24, 2024 at 02:38:04PM +0200, Jiri Bohac wrote:
> On Fri, May 24, 2024 at 12:15:47PM +0200, Greg Kroah-Hartman wrote:
> > Nice, but then why was this commit worded this way?  Now we check twice?
> > Double safe?  Should it be reverted?
> 
> double safe's good; turning it into a CVE not so much :(
> CVE-2023-52822, CVE-2023-52824 and CVE-2023-52820, originally from the same patch
> series, seem to be the exact same case.
> 
> CVE-2023-52822:
> 
> 	int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
> 				     struct drm_file *file_priv)
> 	{
> 	...
> 		if (num_sizes > DRM_VMW_MAX_SURFACE_FACES * DRM_VMW_MAX_MIP_LEVELS ||
> 		    num_sizes == 0)
> 			return -EINVAL;
> 	...
> 		metadata->num_sizes = num_sizes;
> 		metadata->sizes =
> 			memdup_user((struct drm_vmw_size __user *)(unsigned long)
> 				    req->size_addr,
> 				    sizeof(*metadata->sizes) * metadata->num_sizes);
> 	}

Agreed, now rejected.

> CVE-2023-52824 (here the check is in the immediately preceeding statement, could it
> be any more obvious?):
> 
> 	long watch_queue_set_filter(struct pipe_inode_info *pipe,
> 				    struct watch_notification_filter __user *_filter)
> 	{
> 		if (filter.nr_filters == 0 ||
> 		    filter.nr_filters > 16 ||
> 		    filter.__reserved != 0)
> 			return -EINVAL;
> 
> 		tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
> 	}

Yup, now rejected.

> 
> 
> CVE-2023-52820 is a little less obvious to be safe, but I believe it is:
> 
> 	int drm_mode_create_lease_ioctl(struct drm_device *dev,
> 					void *data, struct drm_file *lessor_priv)
> 	{
> 	...
> 			object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
> 						 array_size(object_count, sizeof(__u32)));
> 
> 	array_size() will safely multiply object_count * 4 and return SIZE_MAX on
> 	overflow, making the kmalloc inside memdup_user cleanly fail with -ENOMEM.

Also agreed, now rejected.

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-307358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A22964C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B99C1F220F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CC1B8EB5;
	Thu, 29 Aug 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RdakdhlT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144B1B5EDA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950715; cv=none; b=MXDWhpteFoFj/4aqBCQtqGXHkVVmqfXrlDCDcZmEbaGpRAT2aCHL+QmdZlyNBjD5WUkozmB2iy4RHRLy4BGR93ja+LnNtw29hTVDkMk0hXr54mrih7SyxJpzDZsRhlINfF4Ade1DwpRDUbinqNJa5ZvmQRQIn7aCz5izGu4+p3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950715; c=relaxed/simple;
	bh=pekwcQ8/RWaQOHU+/KJilF5YGUx4SDuVTZoD0o/aQH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0r+dD6mOcAEj1x+Zy7waeshV3jfYZ8cnuAyNfpPnTOdhkmPCl66EDDno3QQjPajcsDT2QxXRCLcTvL9BhSaczS+Uquy2Hm16FmOk5neQAagU5G8m/Jchlw0CPSkQcAqqJvG8BKG7OybHWJh69FhgfIBg8O1YXZmBo3xvZ/A+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RdakdhlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FC5C4CEC1;
	Thu, 29 Aug 2024 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724950714;
	bh=pekwcQ8/RWaQOHU+/KJilF5YGUx4SDuVTZoD0o/aQH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdakdhlT6al2PPds7eU3pZzTu1GObu2GQlKFYGv6GZYfRswtVbMOFdz8v/qNSbwH8
	 E1P9wJoIO/nBIYCmWYNm8SUtqNHrILzpP6eTvJA3OBYqeLn7Eiq3PrwH1SfOlIS/DG
	 8SuoFvyyDSPOLNpwaRd4ZLBqrfTwHqGW3Xm1V2Lo=
Date: Thu, 29 Aug 2024 18:58:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Willem de Bruijn <willemb@google.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, Tao Liu <thomas.liu@ucloud.cn>
Subject: Re: CVE-2022-48936: gso: do not skip outer ip header in case of ipip
 and net_failover
Message-ID: <2024082958-distress-outmatch-ab28@gregkh>
References: <2024082224-CVE-2022-48936-9302@gregkh>
 <z3hh3yrf5wym3obgol6obh3dkmqoc3rwbkj23qcmadf63b47h2@nn2232wngans>
 <2024082854-reassign-uniformed-2c2f@gregkh>
 <jsnwzpmezgju7r7nkcauaicthkzizsqglb6p43zq25cdvdgbgt@dlkgwkch52qi>
 <CA+FuTSeHvADR5qbWnzRpYtpvNcvYrAeXAj8LYczUFLKREDwfpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FuTSeHvADR5qbWnzRpYtpvNcvYrAeXAj8LYczUFLKREDwfpQ@mail.gmail.com>

On Thu, Aug 29, 2024 at 12:53:34PM -0400, Willem de Bruijn wrote:
> On Thu, Aug 29, 2024 at 12:18 PM Michal Koutný <mkoutny@suse.com> wrote:
> >
> > On Wed, Aug 28, 2024 at 09:30:08AM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > What is the security issue here?
> > >
> > > This was assigned as part of the import of the Linux kernel GSD entries
> > > into CVEs as required by the CVE board of directors (hence the 2022
> > > date).  If you don't feel this should be assigned a CVE, just let me
> > > know and I will be glad to reject it.
> >
> > The address of original author bounces back. Willem, could you please
> > help explaining context of the change? (~the questions in my previous
> > message).
> 
> I don't know why this has a CVE.
> 
> The patch reports that the negative effect is a drop due to a corrupted packet.
> 
> According to the CVE report this requires both user input with
> virtio_net_hdr, which is privileged, and a tunnel device configured,
> which again is privileged.
> 

Ok, should it be rejected then?  If so, just let me know.

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-308616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D426965F87
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A9F1F2865A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4EC18EFD2;
	Fri, 30 Aug 2024 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JaL0miD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329917DE35
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014689; cv=none; b=s4oEK6xqXQClYSp22WdaTsOJwtXZve47JXb2oo8u4sXyJ2UuytgLUfDYhMZY4CrzCUJSjrOPsJKSEk40DYwRD8/RFu9rquFdbvQ0P/sd5RLEKhVWZfhDXiM6ndrrYXxoZHtl7Da13sH51CXNFgGVaJ98N+PYG1r2LKR1hj2sulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014689; c=relaxed/simple;
	bh=xmw5OILkY79qOkpSSg5PhobeR5jkLRVZmxi87arky90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmVYoIM8s9WAVbzt7yFDnqjUa4QW7PnuR6mk0jQ2elwHmhmfDlnQvSoxyE6iB9frOvE5IJGWYQpyVKukxbfhcDmKU/kdJD4lhUzyuzZ/CfsSQV87aIKE3HeQW2gGP6QNLA561H7EsMXH8U2ZmhRpEgvPqN3hOhz+20UXsZ7I3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JaL0miD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C43C4CEC2;
	Fri, 30 Aug 2024 10:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725014688;
	bh=xmw5OILkY79qOkpSSg5PhobeR5jkLRVZmxi87arky90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaL0miD6y+yqaCw+a9dFuhSTpLHI/GTB1+QQXBwhBRmKqcOC8/fBH1XUpfMQkgxed
	 JLvKSEUB1WTJYBZ0PujIJyCe3m2m2ZfHfYuc+o1rs7/RPWhA7YoHGwNW7wjPdHnIIV
	 qp0w8kcxgLmZlWen5EDskdAnIi9CenyjWTma30Bc=
Date: Fri, 30 Aug 2024 12:44:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Willem de Bruijn <willemb@google.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, Tao Liu <thomas.liu@ucloud.cn>
Subject: Re: CVE-2022-48936: gso: do not skip outer ip header in case of ipip
 and net_failover
Message-ID: <2024083005-casualty-earmark-4d57@gregkh>
References: <2024082224-CVE-2022-48936-9302@gregkh>
 <z3hh3yrf5wym3obgol6obh3dkmqoc3rwbkj23qcmadf63b47h2@nn2232wngans>
 <2024082854-reassign-uniformed-2c2f@gregkh>
 <jsnwzpmezgju7r7nkcauaicthkzizsqglb6p43zq25cdvdgbgt@dlkgwkch52qi>
 <CA+FuTSeHvADR5qbWnzRpYtpvNcvYrAeXAj8LYczUFLKREDwfpQ@mail.gmail.com>
 <2024082958-distress-outmatch-ab28@gregkh>
 <CA+FuTSdT9Xf0TZm9JAv5tC3WN0UYO_Y9bcAwSsiKyCtwehOE4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FuTSdT9Xf0TZm9JAv5tC3WN0UYO_Y9bcAwSsiKyCtwehOE4g@mail.gmail.com>

On Thu, Aug 29, 2024 at 01:07:36PM -0400, Willem de Bruijn wrote:
> On Thu, Aug 29, 2024 at 12:58 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 29, 2024 at 12:53:34PM -0400, Willem de Bruijn wrote:
> > > On Thu, Aug 29, 2024 at 12:18 PM Michal Koutný <mkoutny@suse.com> wrote:
> > > >
> > > > On Wed, Aug 28, 2024 at 09:30:08AM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > > > What is the security issue here?
> > > > >
> > > > > This was assigned as part of the import of the Linux kernel GSD entries
> > > > > into CVEs as required by the CVE board of directors (hence the 2022
> > > > > date).  If you don't feel this should be assigned a CVE, just let me
> > > > > know and I will be glad to reject it.
> > > >
> > > > The address of original author bounces back. Willem, could you please
> > > > help explaining context of the change? (~the questions in my previous
> > > > message).
> > >
> > > I don't know why this has a CVE.
> > >
> > > The patch reports that the negative effect is a drop due to a corrupted packet.
> > >
> > > According to the CVE report this requires both user input with
> > > virtio_net_hdr, which is privileged, and a tunnel device configured,
> > > which again is privileged.
> > >
> >
> > Ok, should it be rejected then?  If so, just let me know.
> 
> It is a legitimate bug fix, definitely stable material.
> 
> With the fix backported to all these branches, not sure what, if
> anything, more is needed wrt the CVE.

Ok, for now I'll go revoke this as that feels the safest thing to do at
the moment.

The "frankenkernel" distros can decide if they want to pick this up or
not, everyone sane has had it for years now :)

thanks,

greg k-h


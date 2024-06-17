Return-Path: <linux-kernel+bounces-218038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DE590B86D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543551F22C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1118EFF2;
	Mon, 17 Jun 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zJlmg+yQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62F18A94C;
	Mon, 17 Jun 2024 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646477; cv=none; b=YOCbwRcLAJPTX9ynUD4+49EEzpDybO+7mMgEMQ3Uppbg3WimMoIO3DMTqBw/MHNt/2TKt15nDHK1TqsU33KEMtVoniZdjJdBha3NLYE+gPAAnRNhMKqYLEBoQoP1G9RTOO45KVZBbQjuEsfulVh8jimVU/NCJ7dwZGf3G/6o3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646477; c=relaxed/simple;
	bh=JYGZGsnQe/jI3Bsc/LYnsR8/syom7FPI+dvsNdb/eq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxmrfdDuBExsEylkFFEinGPJkbuiOq1bxdkTsA9fgojTm9y9s0nELW0XI9eK/ary1Z4tdVcusr9jylyAGsWW5CYsiT4c+Cnl0DNcci5IWhuOnufSzuVvIAw+lpNNZxfNuKU7NIS1/xDYTUPh7XmG+vjDyeTE5mAHfK7DXRrOXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zJlmg+yQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC75FC2BD10;
	Mon, 17 Jun 2024 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718646477;
	bh=JYGZGsnQe/jI3Bsc/LYnsR8/syom7FPI+dvsNdb/eq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zJlmg+yQBIlNzzawoFGTyYyA+XKz4tHw+MM9ZtHGTkxroXDyK0jvT2zI0chwLTXRZ
	 PTrpFmkFvtd1Ufn0NcuCo987q4NBbQdRjQsXmfqEhHXV2Pr1Bir2LzjfUoy3qh6esh
	 XN2v5OoQA7yNA79Llg3zazEFMPyCgGddjoAZblw8=
Date: Mon, 17 Jun 2024 19:47:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35840: mptcp: use OPTION_MPTCP_MPJ_SYNACK in
 subflow_finish_connect()
Message-ID: <2024061726-overkill-secluded-d14a@gregkh>
References: <2024051756-CVE-2024-35840-99fa@gregkh>
 <ZmFtaijTs6mOpB5B@tiehlicka>
 <2024061750-glade-overstep-7759@gregkh>
 <ZnBdYv9Dls8CTm0G@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnBdYv9Dls8CTm0G@tiehlicka>

On Mon, Jun 17, 2024 at 05:59:30PM +0200, Michal Hocko wrote:
> On Mon 17-06-24 17:43:10, Greg KH wrote:
> > On Thu, Jun 06, 2024 at 10:03:54AM +0200, Michal Hocko wrote:
> > > Hi,
> > > what is the actual security threat here? As far as I can see, the
> > > problem that the commit requested here addresses seems to be rather
> > > functional, rather than responding to an unexpected packet options with
> > > a reset, we actually establish a connection with some garbage parameters
> > > (likely unpredictable). Which is unfortunate but I do not see any
> > > security implications.
> > 
> > Sorry for the delay.  I'm pretty sure this is a data leak as the
> > "garbage" is coming from other kernel data, and as such, was reviewed by
> > us as a vulnerability.
> 
> This is not my area so bear with me, but isn't the garbage coming from a
> remote side of the connection so it is just a garbage? I would
> understand that a misbehavior on the receiving end could be considered
> problematic but I still do not see this happening. Or am I wrong?

I do not know, I thought it was coming from the local kernel memory.
I'll defer here to the network developers to answer it for sure.

thanks,

greg k-h


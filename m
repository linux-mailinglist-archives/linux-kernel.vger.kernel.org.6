Return-Path: <linux-kernel+bounces-306767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639796433F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BED1C22B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF5191496;
	Thu, 29 Aug 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hrru5jh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C221191F63;
	Thu, 29 Aug 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931582; cv=none; b=dZ8CzH/CCbhEvJhBN2qRxaMocsVYEnZy0ugxX0BuJFtKq3T+FDi8ps6jJYoPYw7k/4+M8mN203UfyOoeXRMyibn1BIbJg2JGyRPXCgD4RiVGIEKs3yehPUflMYPZYu43mtstbMXa2O896QnE5fVxUgfLDJVGSeERiZKrF8eJw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931582; c=relaxed/simple;
	bh=pr1UwJ3ih63FObLtm3tIrRqc3tSgJGSJFaEqCPLKscA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8U6mztbd3k3m+j8yAGKKwPS89IPOZuxY5UamTZ+iLip04OAwoy7pqtTykUoOs0KVAkjuangzIVEk820dymH8pCSTeU3cl2IXxh7xwbw1i5kopR+GW85ZxnXfo0xtTNToCrZdJqWi4AojBSc0KuEcarkwq+XwRCm88dM7m6Oj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hrru5jh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A56EC4CEC1;
	Thu, 29 Aug 2024 11:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724931580;
	bh=pr1UwJ3ih63FObLtm3tIrRqc3tSgJGSJFaEqCPLKscA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrru5jh0gtQWMW38tYWKp3/HL0ZCUq1ok61puynovJ24FjFrGEcJ8y+rY8Ag+2vkO
	 mklKzat6fUiwQmenn1NLLtwNbeFpQNEAO1NpFYpxleUpjKGJEivx97iMBE6nNSoeAc
	 Dme4OVmIuiwAHkOpJBN8FEMsrb5ifpvkFF5BcVlU=
Date: Thu, 29 Aug 2024 13:39:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alien Wesley <alienwesley51@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: rtl8192e: Fix Assignment operator '=' in
 rtl_wx.c:681
Message-ID: <2024082932-diabetic-appease-151f@gregkh>
References: <20240825161335.21737-1-alienwesley51@gmail.com>
 <2024082916-savings-upstage-9606@gregkh>
 <8c1960d3-8f0b-4505-99aa-8af55685bbb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1960d3-8f0b-4505-99aa-8af55685bbb3@gmail.com>

On Thu, Aug 29, 2024 at 08:33:41AM -0300, Alien Wesley wrote:
> On 8/29/24 06:52, Greg KH wrote:
> > On Sun, Aug 25, 2024 at 01:13:35PM -0300, Alien Wesley wrote:
> > > Separated assignments for pairwise_key_type and group_key_type
> > > in order to silence the following checkpatch warning.
> > > 
> > > CHECK: Assignment operator '=' should be on the previous line.
> > > 
> > > Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> > Please do not put line numbers in the subject line.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Should I fix up the subject and resend it as v2?

Please do.


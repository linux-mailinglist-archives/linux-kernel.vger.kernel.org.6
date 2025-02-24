Return-Path: <linux-kernel+bounces-528292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA6A415F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABC93A5312
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ACA20B20A;
	Mon, 24 Feb 2025 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rWnZ9qRA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01238DE9;
	Mon, 24 Feb 2025 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380872; cv=none; b=LruCIMM/7RHLWNCcIpSYMyxfOQ2zzT5s7XrFaoRKyns9CTy7mpOjrApAlXS5T0t1usE1AWCLem+X6rpvJoMXzXOgDt8ZNIiHjEFNCLqqpCw4NuxvZTtX4EVyR1K8Ka+2KlaPiOouzDC8CZwnct+10N++9bpR6XPvKvmCAIfdiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380872; c=relaxed/simple;
	bh=l/KXpYBP9o/pd7S757V9Gogf2OWf5kFV8ikH/H87ia8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab/QvabqFFUkpG+lRX9C+YAX9Z7WivnsVTCKYrJacI0J1SVFzbrxpNoLGlFF8J9PCVREqjtP4bs6VpFamXSRwaS6dz992lCv5KRYbN7H7M39/M2gup3C/kRX4l2zGSQtglQXgwWNwvogpqfqiLZhMAlfVl/zcpbdczZL4UZav4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rWnZ9qRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D830C4CED6;
	Mon, 24 Feb 2025 07:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740380871;
	bh=l/KXpYBP9o/pd7S757V9Gogf2OWf5kFV8ikH/H87ia8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWnZ9qRA4eFiqW4nr34aMGgratoBeTwfHMrd7tw+IeRIYftHexSgM3gmy5cIz4d7T
	 Oz4JlvH1AfsHDr2GIEexmvQy0LYbb2ScBW2N98TYHNI2m0Km351z8Q/sJJ8BEcCZ+C
	 fdT7rXiAItN3VZQYP+yv1WkZQu2QiO/JW36Ni4cU=
Date: Mon, 24 Feb 2025 08:07:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Sean Rhodes <sean@starlabs.systems>, quintafeira@tutanota.com,
	Arnd Bergmann <arnd@arndb.de>, Desnes Nunes <desnesn@redhat.com>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] SD Cards detection broken leading to boot
 failures
Message-ID: <2025022429-powdery-possibly-e4e5@gregkh>
References: <1de87dfa-1e81-45b7-8dcb-ad86c21d5352@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1de87dfa-1e81-45b7-8dcb-ad86c21d5352@heusel.eu>

On Sat, Feb 22, 2025 at 10:22:34PM +0100, Christian Heusel wrote:
> Hello everyone,
> 
> on the Arch Linux Forums[1] multiple users reported issues with their SD
> cards not being recognized during boot or that they needed to re-plug
> them in order for them to be recognized.
> 
> One user tracked this down to the following commit:
> 
>     235b630eda07 ("drivers/card_reader/rtsx_usb: Restore interrupt based detection")
> 
> They have also created a report on the kernel bugzilla[1], therefore I
> cc'ed them to this thread. We found that reverting the above commit on
> top of v6.14-rc3 fixes the issue.

Thanks for the report.  Do you want to send a revert for this, or do you
need us to create it?

thanks,

greg k-h


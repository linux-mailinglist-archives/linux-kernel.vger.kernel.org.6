Return-Path: <linux-kernel+bounces-275765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4A94898E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215971F24E79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA391BCA02;
	Tue,  6 Aug 2024 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TgQc37wL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4B1BC9F0;
	Tue,  6 Aug 2024 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926499; cv=none; b=mughXvCq1s98ESiVa8ZfCUP0vGwAgchS3+nDHwLx+pz84CziSgBeWcUb7ZOhOAnbQobA/sdKFYWpICWIK9cyNF8n5ZgONt0rzDr/Qiw2wEH+8jbXEiyM6dnd/aRfNWEwCQCNdhidhSli7lkHNAqpW/yBAFXupX6Yx35ywX+HSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926499; c=relaxed/simple;
	bh=5mKVdRsnXA5UYIjVoLDOjjuGmPqNNMb7XMfE0WDUOlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIuzD2GSuxyG3PRBWXmgAHNNSDYk4D1wDMWr17bPTRg8YFfnZt2UdqENcPlcI0yB+vRAroX2uG0ajRQjfpRrPpUzYDDgY8BGdnBpvuPwt2iG2DM0IAU3dUo653kZPuj5DhHTLzBo2IYeRIGuzPEG1Zljh9guRmLqI/KcmL0wllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TgQc37wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38EDC32786;
	Tue,  6 Aug 2024 06:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722926498;
	bh=5mKVdRsnXA5UYIjVoLDOjjuGmPqNNMb7XMfE0WDUOlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgQc37wLjB3cUyH6ELrWLwFGkGyrKJcsWMDz6E13RXIaxFIvlredF8R1aju8bKwt+
	 tDAS/+5Wg+NhwvXEtG458CJKhvZlCj09hduTyHVM/dzNTA+45OvIl7mOyLXHMq7HvY
	 2qYxOkFCYCadyn6RLO3RwwAFwnyVASy0caXQuFaA=
Date: Tue, 6 Aug 2024 08:41:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cengiz Can <cengiz.can@canonical.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org, security@ubuntu.com
Subject: Re: CVE-2021-47188: scsi: ufs: core: Improve SCSI abort handling
Message-ID: <2024080630-cinema-jukebox-8e5e@gregkh>
References: <2024041034-CVE-2021-47188-092a@gregkh>
 <otjby7on74mc3sx56xynqdnce2d2jmql57jvrgp6wvbo2knqbc@tm3udmcrp7gn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <otjby7on74mc3sx56xynqdnce2d2jmql57jvrgp6wvbo2knqbc@tm3udmcrp7gn>

On Mon, Aug 05, 2024 at 07:48:13PM +0300, Cengiz Can wrote:
> Hello,
> 
> I'm trying to figure out the security impact here:
> 
> > That warning is triggered by the following statement:
> > 
> > 	WARN_ON(lrbp->cmd);
> 
> This is just a fix to silence a warning. How is this worthy of a CVE? What was
> the criteria here?
> 
> If there are security implications of not nullifying `lrbp->cmd`, shouldn't they
> be noted in the CVE description?

CVE descriptions come directly from the kernel changelog text.  If you
wish them to say something else, please submit a patch against that text
and we can apply that.

> If this just a fix to the warning, this CVE should be rejected.

If userspace can trigger a WARN_ON() then the machine can be rebooted if
panic-on-warn is enabled, and so it requires a CVE assignment.

thanks

greg k-h


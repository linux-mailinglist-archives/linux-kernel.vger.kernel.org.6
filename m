Return-Path: <linux-kernel+bounces-296280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F238495A88F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8251283F42
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D77A3D;
	Thu, 22 Aug 2024 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0A4eNVo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6D7F8;
	Thu, 22 Aug 2024 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284918; cv=none; b=Ztmnv3bySw1HREZlmesC5fgeU+ds9dnWvb+M6pPUuDjZQnWBkM6Oew5xCnvZ+UPJiZZvoTCMEhiPAKM2l0Peauzg2lERjNvVBSgTL46ynAH/yUEqAWkroLJoC+dqVyB8rIBJadvqAsjlpWzvTbh3oBaZQj15qRd2iR3ka36nymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284918; c=relaxed/simple;
	bh=PDCLMm/e0nCro3wmjqX34S2KrMwp6LMgCCTpW6mGfMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eELvQbjXmV8pMdCENCeXAX/5V7j6UqHlvarKs8TBfEDNawRFBsTam4Pacq1AciEis5ufP/yJ9+xXw2Jj39yW1F83h+779DENqL+vGWLCFYMQ1LHSp7cmBo7Kh/oiQlmPJ5QS0s5NVWBz9PhlVjnfwXy+rlvYbmx5x5AfKaVMbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0A4eNVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E102AC32781;
	Thu, 22 Aug 2024 00:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724284918;
	bh=PDCLMm/e0nCro3wmjqX34S2KrMwp6LMgCCTpW6mGfMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0A4eNVotd17m0/qjNMGAylfj2lHxEwADwDOu0EvNDGj0RTacl8cYEG7e+W/T0xkz
	 vg6BOs/WaunAhOI/43ay6Rw7rBFGZdzvKF3TnAaB5FyZzgRhWUGE1HGHacvk0QC3th
	 sS5rDNuxM0F6/E7VX8jtHY6TPthfweqV6wfYGbpQ=
Date: Thu, 22 Aug 2024 08:01:55 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: Mike Marshall <hubcap@omnibond.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-42143: orangefs: fix out-of-bounds fsid access
Message-ID: <2024082246-canister-freehand-fc84@gregkh>
References: <2024073031-CVE-2024-42143-5cec@gregkh>
 <20240801145925.2990-2-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801145925.2990-2-ailiop@suse.com>

On Thu, Aug 01, 2024 at 04:59:26PM +0200, Anthony Iliopoulos wrote:
> On Tue, Jul 30, 2024 at 09:48:01AM +0200, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > orangefs: fix out-of-bounds fsid access
> > 
> > Arnd Bergmann sent a patch to fsdevel, he says:
> > 
> > "orangefs_statfs() copies two consecutive fields of the superblock into
> > the statfs structure, which triggers a warning from the string fortification
> > helpers"
> > 
> > Jan Kara suggested an alternate way to do the patch to make it more readable.
> > 
> > I ran both ideas through xfstests and both seem fine. This patch
> > is based on Jan Kara's suggestion.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-42143 to this issue.
> 
> I think this one needs to be disputed as there was no actual out of
> bounds access. The fix is basically just silencing the string
> fortification warning which was due to:
> 
> memcpy(&buf->f_fsid, &ORANGEFS_SB(sb)->fs_id, sizeof(buf->f_fsid));
> 
> and fortify-string complaining as it detects that memory beyond
> sb->fs_id is going to be accessed, which was intentional:
> 
> struct orangefs_sb_info_s {
> 	[...]
> 	__s32 fs_id;
> 	int id;
> 	[...]
> };
> 
> The fix simply made the fs_id and id fields assignment explicit so as to
> avoid the warning.
> 
> Mike, could you confirm that this should not be a CVE?

Sorry for the delay, now rejected.

greg k-h


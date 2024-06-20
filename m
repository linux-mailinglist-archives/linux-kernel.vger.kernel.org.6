Return-Path: <linux-kernel+bounces-222233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2312E90FE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6C91F24A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7668317D371;
	Thu, 20 Jun 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x67+jvKI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB1917C7A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871524; cv=none; b=lHrqwKze9wZKAt9b4GbSOyCH1b6oIXK/FeerEQCbZAfZ3oCi5/oxpBE/3JDK0f9oXY/sKeq38EwPinatLqwzf86WgvPqHeBRVipnOyrnYjl2dLTBsahM8oXOoElhi51DwGeMdbRhGrduyGaDka8sIi4q89W9iaoDqB2senrC6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871524; c=relaxed/simple;
	bh=DsEnrh31D9TxWtVUdPoAbAiK/TeH+aDrI7ueHwLIUcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHZX8m2fv/fgpLOZky2X8cBWAiz/9l7XfWPDYQVP4MRJajXWpM19NmzaBRkcVnLmgFCcnD27kzVDhe7dIDe3Wod2gQ9uYhxAGQ+1+JJUzRRBjSg+nFl3CL1eWwCkqiA678nf1j5FdV88uORCNfcgs9Rj4pIDY8Xvrd8ySjn8oEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x67+jvKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABD4C2BD10;
	Thu, 20 Jun 2024 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718871524;
	bh=DsEnrh31D9TxWtVUdPoAbAiK/TeH+aDrI7ueHwLIUcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x67+jvKI05BVcPUR+m06vFZiTryB3yXPB85H55UVmRKZlofraUtC0Qv6yI/inPAgM
	 Y0ax913vwCh3vBoxwGu/2XNmtRLbzPkLnbCPR8WNkyvMeCwhq35S/84kRNIhz6gbM+
	 91KOVbqb+t9h7pBeBhuyO3ejR5cTwTmVvRY5CDa0=
Date: Thu, 20 Jun 2024 10:18:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	"security@xenproject.org" <security@xenproject.org>
Subject: Re: CVE-2021-47573: xen/blkfront: harden blkfront against event
 channel storms
Message-ID: <2024062034-pork-limes-2c4c@gregkh>
References: <2024061911-CVE-2021-47573-5c43@gregkh>
 <769040d1-fc9c-47a7-a4b5-93c693472624@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769040d1-fc9c-47a7-a4b5-93c693472624@suse.com>

On Thu, Jun 20, 2024 at 09:53:02AM +0200, Juergen Gross wrote:
> On 19.06.24 16:54, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > xen/blkfront: harden blkfront against event channel storms
> > 
> > The Xen blkfront driver is still vulnerable for an attack via excessive
> > number of events sent by the backend. Fix that by using lateeoi event
> > channels.
> > 
> > This is part of XSA-391
> > 
> > The Linux kernel CVE team has assigned CVE-2021-47573 to this issue.
> 
> When issuing XSA-391 the Xen security team already assigned CVE-2021-28711
> to this issue.

Cool, but why was that not documented in the CVE entry itself?  I search
the existing CVE database when assigning CVEs for older things like this
(the import of the GSD database), and if there is no reference in the
CVE entry, then I have to assume that no CVE was assigned to the commit.

I'll go reject this one (and the other ones you pointed out), but can
you please update the CVE json entry with the information and ids of the
fixed commits so that everyone can correctly track these?

Also, the XSA-391 announcement doesn't say anything about them either,
is that intentional?

thanks,

greg k-h


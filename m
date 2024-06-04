Return-Path: <linux-kernel+bounces-200719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D108FB3F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CFCB27A13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894614830F;
	Tue,  4 Jun 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EnlnenKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCE148301;
	Tue,  4 Jun 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508241; cv=none; b=ARICTAXhmukKRd6o1aFnxZPKZQHMWE0nGfOyx6Zy+n+kVMS5AcI/Dy+R0blQRXg/hDJK0NAn76UBYLkbHDFX1QYaGe/r6kJbAm/P3nl7ZttCh+rFI7ud0f4VQGHaXvohHOEcWA1rdJg+20AmOEBJm6PIVZbhY+QKVQRynsxeRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508241; c=relaxed/simple;
	bh=ke+klkmS7qI4DKFNcJKptdZKaAlgmohUbXW843PDesU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oW2f7LSyAHcYE4EIw8XtN4Hhd9DlOdciNHAbC9fkMFjbcaMwP3Jv+dkVEoSwuuuP4PZkK6fLQMlAMPpBa1CUDqq5gxaAMdZwHVyR/xWjZm4puN+OB3pNAenOeFRIrSUyKyvI0+IRnvAOELsUvqKG5xDMPU58ueS9SJkGw3F+uiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EnlnenKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E82C2BBFC;
	Tue,  4 Jun 2024 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717508241;
	bh=ke+klkmS7qI4DKFNcJKptdZKaAlgmohUbXW843PDesU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnlnenKR2Mk0OuYftFx2wpm7fDghlGKPkZL6fcoxAOeRHm1FUKEtQfuRBgBMrJU3P
	 Hl9Z2ofY+WSGL8jNMDku0wxwyOKEUueqI3TxBU2cGycVcGf859Ys08Xej1fG3x6yCf
	 FrzqJyQ29/3O1HT4vkbs3ybfIlk0CT+HstVETjKk=
Date: Tue, 4 Jun 2024 14:57:25 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-cve-announce@vger.kernel.org" <linux-cve-announce@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-35812: usb: cdc-wdm: close race between read and
 workqueue
Message-ID: <2024060417-cavalry-refinance-8f30@gregkh>
References: <2024051741-CVE-2024-35812-c804@gregkh>
 <629491b984d5618417a29c8eaf595f03b9bbe822.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629491b984d5618417a29c8eaf595f03b9bbe822.camel@oracle.com>

On Mon, Jun 03, 2024 at 01:30:46PM +0000, Siddh Raman Pant wrote:
> On Fri, 17 May 2024 15:23:52 +0200, Greg Kroah-Hartman wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > usb: cdc-wdm: close race between read and workqueue
> > 
> > [...]
> > 
> > The Linux kernel CVE team has assigned CVE-2024-35812 to this issue.
> 
> This commit has been reversed in stable trees as it introduces a regression.

Now rejected, thanks for the review!

greg k-h


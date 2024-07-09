Return-Path: <linux-kernel+bounces-245183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB892AF64
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57851F21F54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD612C52F;
	Tue,  9 Jul 2024 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWxv8vHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3916259C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502403; cv=none; b=TGIXz0pIVg4osjRZWu4IP+16bM/Sm3e8e4WBQ2X2UuCL/IvoQVOX51r+ZItv0JBU1l3qQhP5TDsL2ExCxAhMKASTqEkzYZDlE8Xkp32REZM496XOLNWsVeK/UoK0XO7qlWGh/wD3KmIFxAiFDfcwjfsPsgsdoyaEKZTqhlmFekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502403; c=relaxed/simple;
	bh=PAAC1jOWu4VX94zvIyackTS8yXVX7Bf9WFaLYqV5iI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwb2W+zy9ItcShE+DXvkYK/gl4fLJiSObYCpfsKjcCVnFZ6bKnmQCyhHsOjbEBeROoANSBtb0ukXaqHi523BbzY6pB9XoMrpFE+l9dYJrjt0UFU09p9vPYf73evwawHR/DQgz/5h+RTpz02rmnaPp6VVuboYpJiyqHllHE5N+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWxv8vHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8525C32782;
	Tue,  9 Jul 2024 05:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720502403;
	bh=PAAC1jOWu4VX94zvIyackTS8yXVX7Bf9WFaLYqV5iI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWxv8vHn5Vd1Cscj2myGUbEqvxWMMbiulr5CSd2lQBOApud2CMagso/qj/ac/ZvJT
	 vX+T3Cs3+ynR6OPxS/8DdVVYvPXQchxCbhJB4RG1BqJ+L3M60JV2HSbhhXvJVeW9vy
	 WPqMwmLjLOFFbgUao/Oj5rNgV/NM318JkYu0CRMs=
Date: Tue, 9 Jul 2024 07:19:59 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2023-52628: netfilter: nftables: exthdr: fix 4-byte stack
 OOB write
Message-ID: <2024070926-removing-chewer-2426@gregkh>
References: <2024032850-CVE-2023-52628-14fb@gregkh>
 <b8b8f6113ac1e7f1fa07659c32d34b033f775a84.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b8f6113ac1e7f1fa07659c32d34b033f775a84.camel@oracle.com>

On Tue, Jul 09, 2024 at 03:48:29AM +0000, Siddh Raman Pant wrote:
> Is this a duplicate of CVE-2023-4881? It was rejected with the reason:
> 
> > https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-4881
> >
> > ** REJECT ** CVE-2023-4881 was wrongly assigned to a bug that was
> > deemed to be a non-security issue by the Linux kernel security team.

I don't know, where is the information about that older rejected issue?
If this isn't an issue, we will be glad to reject it.

thanks,

greg k-h


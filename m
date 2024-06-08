Return-Path: <linux-kernel+bounces-206983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A29010FB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F371C2167B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0705C15442C;
	Sat,  8 Jun 2024 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mFDtjtan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131714286
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837816; cv=none; b=a2Op7x7KOGSmEe70Rt9XylX+ZwqAFMq1SVPYuKVxSuoOqSWFGVW4+eyte7LkTisOFfhFirlem3Zdr8Rysi9i9fUv4Z2EnjWmqJbzTZKqUFoJ7jr81ueLymMB8pUKWISLJyLK3K+3jN+hEXjCpG3uQEL17iGeLR4hxZSN0bGyh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837816; c=relaxed/simple;
	bh=utttnpxD3Vn/S5byJWZgpeDZt/SzOHLjqWI3OIi4toM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUexD120X2si01PeXy+WHlY7D5AUq8GoENxJbvC53we4uY9um0OAC++rl45vG7oDxBZni7EFUUQo/0uh+lkPho1wbgHLF2G2pu/ufxil8WLothTJe8+dnPsOGrlLo9XDyaqLKS8hkv+2AVxOdpbPnDjnd+0xJ5ICkY5aYn9WXF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mFDtjtan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032E4C2BD11;
	Sat,  8 Jun 2024 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717837815;
	bh=utttnpxD3Vn/S5byJWZgpeDZt/SzOHLjqWI3OIi4toM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFDtjtana84RBlxgu/8qJvWZQizKKzQC8bgzRqSwXiqFDxbgiW9fQF4f6tkiuZJU2
	 oHpU4l7t+elhjfrIY/UDPtdB7C5zOcNfceY/42wxrpujLUrdWIUr+d7wx/sNpVjx7L
	 ooI9wFXQXX2xxutbBvNtLjyvDp7NqY16+9ruWn9c=
Date: Sat, 8 Jun 2024 11:10:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <2024060833-facsimile-confident-f540@gregkh>
References: <20240607122622.167228-1-coxu@redhat.com>
 <26jkoqavu54xo4ctbpxfibhdlbc5kezu2kkyl5fbb7r6oizvo4@cmq5yaeszfqq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26jkoqavu54xo4ctbpxfibhdlbc5kezu2kkyl5fbb7r6oizvo4@cmq5yaeszfqq>

On Sat, Jun 08, 2024 at 09:26:43AM +0800, Coiby Xu wrote:
> The subject prefix should be "[PATCH v5 0/7]". I'm sorry if it causes
> any confusion.

It will probably break our tools (b4) that want to look this up, so you
might want to fix that for the next version you send out, given that
this one has some 0-day bot issues.

thanks,

greg k-h


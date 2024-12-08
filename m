Return-Path: <linux-kernel+bounces-436249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F499E833F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 03:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2854A165809
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 02:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1A11F931;
	Sun,  8 Dec 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxrSFWSX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D91B95B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626621; cv=none; b=Wqyy42JLhRShbjMZry808douavMWQf7FKqFKPp86mGsnwUdx5zsKvCyNBoSkknN+RLHLbzI9aBUkKQDlTVoZ5JgCXToDYUJgLoxMjluaqunrVpEk/0DtJA3Uq1tej1vtyqwGjlVoP8dsfxFXyN6OLgozac8EslPWS0q1bvK1os8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626621; c=relaxed/simple;
	bh=taprTIXL15AEDOVOvPxHdOS1UgmutfVw78B9EEoz+vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbHyV5jcgCuOo49NWL7ZguxxLIVHjCket3qwwuVUISezFp5+AheWBWBBpz/xu3IbRzl0towsZHwA8PXx93+qdxE77orck8nouOLVJiPXRS4G90TcfvO+hWpzvs7oPnnZsyQZ+cxnt/pJctalWfnQwDaOTBoXHcCeOenz62FBDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxrSFWSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90EDC4CECD;
	Sun,  8 Dec 2024 02:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733626621;
	bh=taprTIXL15AEDOVOvPxHdOS1UgmutfVw78B9EEoz+vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxrSFWSXOKucYi8Zf+1z67tBT88eKNg9cHjrZrcQ6ciS74Zl6rOiGcZ6cRLi0M59t
	 h+r9riRmZgHZdV+cCCD1oJRMFOniU9RfUqaksmjlKwkZaGPj9u7dFbK0u9q4Y30wPb
	 EPiwFhJVBGPE4wGl5ITF7pKhrPvJ3QkKKxfQ0GyFQDPrglOLeKwkm+INIFzP8D0APE
	 pLzWDU/pRgNeJnlH5ye4oWDRf9LzLXcUfYlpgD7NrYBCi+me5D43oVVA+baAfmArdj
	 92CLxHSgmnCwHDR4DABvRD5ZpPYRO5CRAErSyFJdrzEUwnZbNeY6WtpY+Utld1oDKE
	 Rrxz1cQbhq0Ww==
Date: Sat, 7 Dec 2024 19:56:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	fengchun.li@sophgo.com, Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [bug report] WARNING when nvme_probe
Message-ID: <Z1UK-1MQEX_IcoL9@kbusch-mbp.dhcp.thefacebook.com>
References: <PNZPR01MB4528CE2B4B42BD765EC8DDE1FE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB4528980B1F286C5843B70DBFFE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PNZPR01MB4528980B1F286C5843B70DBFFE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>

On Sat, Dec 07, 2024 at 12:26:14PM +0800, Chen Wang wrote:
> On 2024/12/7 12:22, Chen Wang wrote:
> > When I test with latest 6.13-rc1, I see kernel complains as below, but I
> > don't see this in 6.12 serials (6.12-rc1 & 6.12-rc7).
> > 
> > I'm developing PCIe driver and there is a RC switch which has some
> > devices conneted to, including a  nvme device.

Thanks for the report. Should be fixed now with this commit:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=ad0cf42e1fc4810170a8e8e232e85d69073e4d25


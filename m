Return-Path: <linux-kernel+bounces-185107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D7D8CB09B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C571F2387B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8B2142E6A;
	Tue, 21 May 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="us7cW/DE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECF142E7C;
	Tue, 21 May 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302534; cv=none; b=UzqDyV7Si9eovAJyio17jKEip+5WrilC2htDZRYg4PW6Q9ZKVonXgJkW+QPUUNHAL4MZel0aNVxya0x26uPtTviGp01NeYmKJSRfqmcceL38i9sXTbirzCij4F0S3zdKxfni9x1rm/BTrYwP87TFApCxjVgqjmQ3T5WQTd1sTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302534; c=relaxed/simple;
	bh=jqRppYoUU1XIgdcBdLNzyzVT8stpiXxdprmvRRM5LZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPpxYvAy4JF0ElCAXv4tc0qpwj9E03k+9ddAc9CwZkc1yrRMZaJO0+FyDq7mU6rin89LNLX8DnfyX8dGt48JECcpQwyW60E3NHcZxno2IekeIY3LJCiwe2cmsKZAsU0kujvJCF0LFX0x/+NR/55gjqmTgr0BDtiqukgbR6tJ+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=us7cW/DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3179DC2BD11;
	Tue, 21 May 2024 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716302534;
	bh=jqRppYoUU1XIgdcBdLNzyzVT8stpiXxdprmvRRM5LZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=us7cW/DEmuWVdpTzxhboLIpHoTLmnHWi1ny+P0km6OlkICC7Tx4fOfqZlbR6y2CHO
	 BTkRH4eIe8vOhLGg4uYS7LaEFT/JzUDCpNnMqFFzyDtdLvVac8zD69BkAPs6z+F/Eq
	 qcEsnolDIvZvZ2yeTMuiug9kr/K8hzO9IS9fGI04=
Date: Tue, 21 May 2024 16:40:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-27429: netrom: Fix a data-race around
 sysctl_netrom_obsolescence_count_initialiser
Message-ID: <2024052105-pulsate-reborn-119a@gregkh>
References: <2024051722-CVE-2024-27429-878c@gregkh>
 <ZkxdqOUek_MHqIMn@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkxdqOUek_MHqIMn@tiehlicka>

On Tue, May 21, 2024 at 10:39:04AM +0200, Michal Hocko wrote:
> This and couple of others are all having the same pattern. Adding
> READ_ONCE for an integer value with a claim that this might race with
> sysctl updates. While the claim about the race is correct I fail to see
> how this could have any security consequences. Even if a partial write
> was observed which sounds _more_ than theoretical these all are merely
> timeouts and delays.
> 
> Is there anything I am missing?

Nope, you are right, our fault, I'll go revoke this now.

Thanks for the review, it's much appreciated!

greg k-h


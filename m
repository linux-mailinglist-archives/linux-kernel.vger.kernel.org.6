Return-Path: <linux-kernel+bounces-302555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7E1960035
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44030282A15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42B3CF5E;
	Tue, 27 Aug 2024 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9qvI9oH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A625634
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731809; cv=none; b=MRhYXjaNMiIh5zkd3ToYG9ou8sSnCXUgf6zIvcZGe+WImFqG9/YA3mHRXwG+Hc6LjQyXxDElZ29bsZ99zxasaEAFb2Hm2beKOzp0e4ZXQfWHciv/ELoPndLmVPXM7ViUfClgjV6LngGovp0BWj0cJuIqKwqKZPtxp32zCL31rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731809; c=relaxed/simple;
	bh=WBGmxdTNYrDMD/MZtZv/WG7UnRj4G6OgQJKos5ikc6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBzKW5YkSD58m43EU7tmcGyi7fNo7w0+eLkNwEBq5TT0ZeHcS2tmEquYP95oT8BK5gTe1LkSveuezhLz8kVEk9HiiUF2WbVdsNSmtJDbTblRD8H/xK0TOQw9YsZUwcLGRPZB9DYm3400aIvY9PTsxUaRR8C+fRuNEU2HREpUKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9qvI9oH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4514C8B7DB;
	Tue, 27 Aug 2024 04:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724731808;
	bh=WBGmxdTNYrDMD/MZtZv/WG7UnRj4G6OgQJKos5ikc6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d9qvI9oH2+mEalnSJwCGQNHtNdfCNtQT/lo+z4XtZ82FlYDbYNedLN2oJCxkqfAp7
	 Phg0BRpfyMp3xXZOYGvkilUlpnpuKa/6Q5OiEBr1fr/ECkixxDkzqEAK1nkJj/Yhbi
	 cKt8zUmwcWrZgAAH3G7HGtDXlo59qj6aHV3y3TL3FAEXFXsD7IrkXE/06BW4Cl34SP
	 jkM87ZHboReMMnpYdEaCOzmZ0o7FG1d2gFjzAjgwTDSMEhIfCS5rsR4mJZld3huTCD
	 HEJwwE/vQTFTVFvCiQXp5Qa/MbI0cxluD6Mpn2yN9h5tXCx1VQ4ivvlgjcIQsWVn+I
	 hS+sBGORwxsIg==
Message-ID: <a7585769-5e2d-4ecd-8dd4-2f8f04243c05@kernel.org>
Date: Tue, 27 Aug 2024 13:10:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: Increase bsize variable from unsigned short to
 unsigned int
To: Li Wang <liwang@redhat.com>, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Cc: Jan Stancek <jstancek@redhat.com>, John Garry <john.g.garry@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240827032218.34744-1-liwang@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240827032218.34744-1-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 12:22, Li Wang wrote:
> This change allows the loopback driver to handle larger block sizes
> and increases the consistency of data types used within the driver.
> Especially to mactch the struct queue_limits.logical_block_size type.
> 
> Also, this is to get rid of the LTP/ioctl_loop06 test failure:
> 
>   12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
>   13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
>   ...
>   18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
>   19 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
> 
> Link: https://lists.linux.it/pipermail/ltp/2024-August/039912.html
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Jan Stancek <jstancek@redhat.com>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



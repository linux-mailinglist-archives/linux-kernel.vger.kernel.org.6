Return-Path: <linux-kernel+bounces-570540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB148A6B1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9FC8A690C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E129B16F858;
	Thu, 20 Mar 2025 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE9G4r2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38877215049
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514385; cv=none; b=Pc4v0LcmjEoW2XDDgHJo2epR430Nwt+nsQDMKa5mb1hSPRDEJhdsodPG8Z9ankGncE9HmsHVSn6TlZ4IJSMsmEWjX6wjR7efeWdtNNupQvLLNdfXwHwEnhbB93rNaUeg0ULmRAYeriX1hUWDJdfAxBpY0AsMvsHyG7yGXai3YwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514385; c=relaxed/simple;
	bh=RR8TtsKpaLzaO3XBBr43rbBxYIcpZrwww8eR0XZ1kds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG5GjlzPKB+H3uhZ6AWsShJC/Zd0uIym1WSi83EzcpDcovElddmaNYjE1n0P/x8sw/hBd9w551HYZVaOX26qzOtLy6v4KQLdGwRf1htMuxLPs2oPwbkx8sd3SPPm7icSll8vrHtqv3nHVA91T5K1D2C0I6aCfIpgFT6Vc05Yd9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE9G4r2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDCBC4CEDD;
	Thu, 20 Mar 2025 23:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742514384;
	bh=RR8TtsKpaLzaO3XBBr43rbBxYIcpZrwww8eR0XZ1kds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XE9G4r2XCGTN8UxhBlE8hxSv0ytimVWMHi+N6Wvr0dsQ0+tUkkGBdguoLCZ8Z3b5o
	 qAsbaCCTFK5stz+KAHHGBk0njuMkm/YxScJ2/zJPkArDPbK5yvLTfqdwY29nBpvrGe
	 Dx3xgQrUxBBtukMaZGic1lJm7bZE0iQANYchHeEYB2SwKX2Xg45288nPDbxvjvnbgc
	 ehWRHwYgwCNgk6kIedIGqWFMIQV5kO8U7sye7vY/AkZjnhBaWaJ8rqiigl1fN+EMFk
	 GpQdgAbOuQ+XISTKCDlzwMyYlfJOOXCo6HISS/c0vhpkE+OSVCFAbpRtcc/P1H6hZR
	 9Fj5NgEqrgeWg==
Date: Thu, 20 Mar 2025 16:46:22 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: fix resource leak in copy_file()
Message-ID: <ddhqswvpl43jfuaj26hwxmac5gvgxhr4lv2cpsk3k5x62cjjf7@6ewsreyaclap>
References: <20250320233131.9555-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320233131.9555-1-qasdev00@gmail.com>

On Thu, Mar 20, 2025 at 11:31:31PM +0000, Qasim Ijaz wrote:
> Close open file descriptors on error paths in copy_file() to prevent
> resource leaks when open(), fstat(), fchmod(), or sendfile() fail.
> 
> Fixes: 5a406031d071 ("objtool: Add --output option")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Hi,

Thanks for the patch, but objtool is a short running process, so we
generally don't care about memory leaks.

-- 
Josh


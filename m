Return-Path: <linux-kernel+bounces-318346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8DF96EC17
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E341C20A1E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D264594D;
	Fri,  6 Sep 2024 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XERADb/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FE17C9B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608193; cv=none; b=m2Y7lgTnbX7WMy78F+I9q+BYQCx2A936cr2i0DPWcHWWDn6F3L+n1d8wxLvt5KhJY7p50WTc2Q+SAMBmB1f3Koix8WM0+11A/vVpGEGWvzfNbOUIZOKQjUulcF8X4kv5JorMuRBPipUkaItdgKxWaSuAUPExFHDUmn8zOGWwvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608193; c=relaxed/simple;
	bh=FDc0+lXuF6FOw0FODkffnmNktw2U7JEIw+Vb+hKDhU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/SbynvYmeRKShYr4RtcWYI+2X4/6ESLrrIt2mYIr8IGZ+1bZPtVi3EYc3XbhLz5vV3pk5fxcN4Z4AGdNyRQsi9G5tCUTf9XwQg6YvfBjDOccxU5YYAY2u8v5zG9AB87dtRZCwtv+A6SrLg0cwih3L2g2+SzLdrJAucsFl8Dd1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XERADb/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C4FC4CEC4;
	Fri,  6 Sep 2024 07:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725608193;
	bh=FDc0+lXuF6FOw0FODkffnmNktw2U7JEIw+Vb+hKDhU8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XERADb/3p8gBXNmWkUyrWaKX/mIq50EVPSo5I5iKq0VfU+/DJoVm2wO2jGd0DC6Nj
	 XwgcexMU3ttP5J9W+pATVMsWFnFNhGdkNR7nBP4vRi6bVz5TufuppmP27ziFESmixw
	 E9dW3xBUTolmZrQhPv21o2ZTykrqswg8eZoRkPydX/SmIY4vTKxzRX3qbICJE6JAAa
	 ujoV7Nc0eztB6loBhENLM+DiO/P4paCPVKzfNNkscJ4MKMOwwe9nneBY9y/Nx37g4K
	 /PGGDMc1I1A4crPDEEz3uAzPU5MUjQWCZD4KO4Na+6jRD3UmtG5XmEo2cK/ieqrZwS
	 MZbzh2Mz0R4mA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A73A2CE0B78; Fri,  6 Sep 2024 00:36:29 -0700 (PDT)
Date: Fri, 6 Sep 2024 00:36:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhu Qiyu <qiyuzhu2@amd.com>
Cc: leobras@redhat.com, linux-kernel@vger.kernel.org,
	neeraj.upadhyay@kernel.org, riel@surriel.com, tglx@linutronix.de,
	thorsten.blum@toblux.com
Subject: Re: [PATCH] locking/csd_lock: fix csd_lock_wait_toolong() error
 warning
Message-ID: <376c9882-802f-499f-992b-9c84054f9f63@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ba64c1a2-c334-4e04-8641-7a7d2abaee5c@paulmck-laptop>
 <20240905075930.234337-1-qiyuzhu2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905075930.234337-1-qiyuzhu2@amd.com>

On Thu, Sep 05, 2024 at 07:59:30AM +0000, Zhu Qiyu wrote:
>   I planned to wait for the test results before reply. After discussing with neeraj, I believe that there will be a positive experimental result after applying this patch, and if there are any experimental results, I will update further. For now, I agree with this patch.

Thank you, Zhu Qiyu!

							Thanx, Paul


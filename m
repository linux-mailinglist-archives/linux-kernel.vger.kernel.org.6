Return-Path: <linux-kernel+bounces-400302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEAA9C0B92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E72281DEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD4F21A706;
	Thu,  7 Nov 2024 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf2THvOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8C21A6F6;
	Thu,  7 Nov 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996535; cv=none; b=d4l1P+gLS9di/QUfc9AfXamWdM0silYn3PkORSvaHL4ySt5Y2Tq/AlaZFkrqM01XEz+hA8Pmt7A69HMzG1lXDdtk+fwaSnpL7SzL6cYYWd0mEf9nkdKEuRq3KQelBOzmmlIqbpgLSlQCSz7UHEFTIGSfAfhshFsI8m2B2g/JhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996535; c=relaxed/simple;
	bh=TXX4DIVM2lc+EbnPW8Wu1p4EWXMRBzuNGuosi6Xy3ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flf7I2RNNaBSRcBv3EechhKUyaf5Aln7nPNh+H2EZcadxFM+Zo2qcKGsybpbXaZgIpHiAyfwajpUtNznv0vIV1Lrr2ZvsmZyzTbwk0JlRzK7hPGjC9WpgeMXMWaoTGi/hWmloVvhmzS6POs0zEQrovcaRahMDqfzuzIUUTYjJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf2THvOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F44C4CECC;
	Thu,  7 Nov 2024 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730996535;
	bh=TXX4DIVM2lc+EbnPW8Wu1p4EWXMRBzuNGuosi6Xy3ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gf2THvOpNoR58Bsc12DoRpnnHxTpBmBBWwK+DPciPhTQbLSlrCzKruWT1ytWLj3xx
	 fJYCwBY/Yyal6MBzujgv8e4EPyI8JShRTp4njtezFjsGskv467VlhhEJr27U2uN+1t
	 qy0oUXSn9ZbZcJnWd0x/jhq7RD8ZSL3TyUYtAKhIE9A0lF5zzEns6lXm6KPXNa0uk2
	 m5gS/db2pWEBHpvjVAyioKVbcwpgsCy7tr/kGJWg4RmrR6o7/RJRjaFtQ9sVfnB4eU
	 +2tghoyZp6YMZEVNL4M8BdKqdwAP4IX54gMn+kwYMXdsWnEpOEEd0riz0MnXBoFK3Z
	 pglRFhEp093XA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t95Gy-000000003mK-3jQc;
	Thu, 07 Nov 2024 17:22:16 +0100
Date: Thu, 7 Nov 2024 17:22:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH v2] USB: serial: ftdi_sio: Fix atomicity violation in
 get_serial_info()
Message-ID: <ZyzpOJGb3UiGDWzR@hovoldconsulting.com>
References: <20241107113534.402265-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107113534.402265-1-chenqiuji666@gmail.com>

On Thu, Nov 07, 2024 at 07:35:34PM +0800, Qiu-ji Chen wrote:
> Our static checker found a bug where set_serial_info() uses a mutex, but
> get_serial_info() does not. Fortunately, the impact of this is relatively
> minor. It doesn't cause a crash or any other serious issues. However, if a
> race condition occurs between set_serial_info() and get_serial_info(),
> there is a chance that the data returned by get_serial_info() will be
> inconsistent.
> 
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> Fixes: 3ae36bed3a93 ("fdti_sio: switch to ->[sg]et_serial()")
> ---
> Similar issues have been submitted or confirmed: 
> https://lore.kernel.org/all/20241002125845.785464707@linuxfoundation.org/ 
> https://lore.kernel.org/all/20241106095819.15194-1-chenqiuji666@gmail.com/
> ---
> V2:
> Revised the description, placed the reference link below "---".
> Used the correct patch prefix.
> Thanks Johan Hovold for helpful suggestion.

Applied for -next, thanks.

Johan


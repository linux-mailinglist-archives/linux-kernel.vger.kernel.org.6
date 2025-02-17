Return-Path: <linux-kernel+bounces-517749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9746EA38523
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F22167010
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CC21C9F9;
	Mon, 17 Feb 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E60OH1gX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62802179BC;
	Mon, 17 Feb 2025 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800329; cv=none; b=FQPFXpTgorGZSsb42m5T6WjCISA1ZjMqdkymhem9LZ6j7feeNVqPFqKwE0aeG2YbNNHruEutOc4cZKfIwbovLgWVO6vH/yDetFogsFNCnv/IQLkjkvABj99okDo3EiGYPHl8b9a7ZGLtxQDI1VRb7+o6bjFkYOmJd5+706tlsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800329; c=relaxed/simple;
	bh=dk+4Bdm4TSj5u/V4NiBQIblx2mw2lCSFWo0dOUa0rtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYMHHkBB8VmEHml6SNzK3e840PHiPzgZJnjesbbvZhrhnofrgTCvV5I7cRI2yQ/PuNPCmI3PkXvIsDE72vJu9ZIez6ZfjmsGS9DuclMHppnMv9sjvdWJHuAcbqvqU9rS+T77TYNFXJO3Gd8GWCnlqq6QnhnvPzQWIWkj7eEcqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E60OH1gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B486CC4CED1;
	Mon, 17 Feb 2025 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739800329;
	bh=dk+4Bdm4TSj5u/V4NiBQIblx2mw2lCSFWo0dOUa0rtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E60OH1gXA5aQjK3LZFBT5xHF1BW8IaBO/NZ38rAQhAaCuA9wvab4WMNy4RSw003hk
	 QkDmRmuM33eqveAL3Uf6z6RWfz94tEmfB+EgISN9ytSGXCkHWe4ZEzDJIzRNWf/p/2
	 Ve/m9zlPvSPXngIKI2vrpL4EA9T5WwE9iUfyIhoI=
Date: Mon, 17 Feb 2025 14:52:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] usb: core: Don't use %pK through printk
Message-ID: <2025021733-strudel-curator-bfaf@gregkh>
References: <20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de>
 <20250217-restricted-pointers-usb-v1-1-78da55158832@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217-restricted-pointers-usb-v1-1-78da55158832@linutronix.de>

On Mon, Feb 17, 2025 at 02:20:51PM +0100, Thomas Weiﬂschuh wrote:
> Restricted pointers ("%pK") are not meant to be used through printk().
> It can unintentionally expose security sensitive, raw pointer values.
> 
> Use regular pointer formatting instead.
> 
> Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

So really this is just a revert of 2f964780c03b ("USB: core: replace %p
with %pK"), right?

Why not express it that way, and explain _why_ it's somehow now ok to
use %p when previously it wasn't?

thanks,

greg k-h


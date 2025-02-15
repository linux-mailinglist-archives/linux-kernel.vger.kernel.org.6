Return-Path: <linux-kernel+bounces-516060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B647A36C85
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B0F16DC05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8661991C1;
	Sat, 15 Feb 2025 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gpfoG/MI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9018B484
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739605760; cv=none; b=u2RYgGO7bmx7gQ5/VmrJkPlUXFrHIO6KmuG1TyLL7NsjanJ64/A+FBHBFrZ/FQ3CZ/PbMfERNusiqokR7Zje0op+m4+4ifW6jHcEdw2/oH6Q6phb+/9AOEpeMpXY8RMjLYeVtg+xtxcFf6JcxZzAVdVgPBzgYtOZIuIYmn+ZcRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739605760; c=relaxed/simple;
	bh=zITtdRtv83mDnxnLpflzS2ILvIHOdQJih91TzlHgmdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDZPy1YfzgbTwjmr8rZVHHpqfM6C1YLPeLlC3zoL2Ns72SUwnMGLdIFjuPIGSriYdiGMzioaB2F5k5pP87rH6LAl7efJk3+bnTrJcgqHso3CY/cExNtvzB2tQ4RDgJ3xaytTEEBogL47w+H73srqk0RAypTNkf+lnYllXtJuLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gpfoG/MI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D9EC4CEDF;
	Sat, 15 Feb 2025 07:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739605759;
	bh=zITtdRtv83mDnxnLpflzS2ILvIHOdQJih91TzlHgmdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpfoG/MIK/ZcICeaUnpAhha8Y02YYiE7lll5hRzFSDv89E+hYdWyaKC4h9e3WaH2z
	 DAv8mrhfsni8oR7DNT/HOcvvnclL3p0Sq4jJXHbRugzuGds/n4XZpVgCP4/VREgu1x
	 /sue/wwPzMbTRK4yihCKzos1FXahiHb9geVbxbLg=
Date: Sat, 15 Feb 2025 08:49:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Current state of the 'const bin_attribute' constification
Message-ID: <2025021550-drainer-underwent-550e@gregkh>
References: <fae9a4c4-a497-4990-89e0-aceb05e58502@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fae9a4c4-a497-4990-89e0-aceb05e58502@t-8ch.de>

On Fri, Feb 14, 2025 at 05:36:19PM +0100, Thomas Weißschuh wrote:
> Hi Greg,
> 
> most of the patches for the 'const bin_attribute' work have gone in
> through the maintainer trees. A few series have not been picked up:
> 
> https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net
> https://lore.kernel.org/r/20250125-sysfs-const-bin_attr-dmi-v2-0-ece1895936f4@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net
> https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-fsi-v1-1-b717f76a0146@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-habanalabs-v1-1-b35463197efb@weissschuh.net
> https://lore.kernel.org/r/20241222-sysfs-const-bin_attr-input-v1-1-1229dbe5ae71@weissschuh.net
> https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-mokvar-v1-1-d5a3d1fff8d1@weissschuh.net
> https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-pcmcia-v1-1-ebb82e47d834@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net
> https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-rapidio-v1-1-0f47f4719683@weissschuh.net
> https://lore.kernel.org/r/20241122-sysfs-const-bin_attr-rci2-v1-1-3db1ec9aa203@weissschuh.net
> 
> Do you want to take these directly?

Thanks, I'll pick them up next week.

> Then I can send the removal of the transition machinery.

Please send that now so I can queue that up too.

thanks,

greg k-h


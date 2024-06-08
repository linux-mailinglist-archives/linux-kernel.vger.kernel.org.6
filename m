Return-Path: <linux-kernel+bounces-207019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E87901158
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 13:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1977282AA9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7064E178380;
	Sat,  8 Jun 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nx4eyENp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24FD155758;
	Sat,  8 Jun 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717846768; cv=none; b=Yz9NiS6JW/fGSDNdiD74Ke7dg/y/+liKinbJvuSL3exOfwvskV6xr36KNd10AVHFcZrAbxuUMrbSmHlerRM1fmAoc3KfU6fkVcNUnSkBjQivluZS+XPoyYDiviNFaTGVmSR5iy/8SCOyA1quW6CHxOcXeF2XhBAsqVWFcKgJHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717846768; c=relaxed/simple;
	bh=hESuc5jTKHJYwPbjzd8756nTEyiEv2rREPyzDuxJeis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ync4eSuASn7DbEPIvQgGXtrpM02B8b+NK0t9a5UWxCiM9yGSZelopBaDjM3m7GQDbfmg4U4GJVfFo4ogzXO6J0I3qjI1RGnVghPmrEYjxCJ0bLXMrCeKm9DLyh8B+2tywV6ovzqu5rjSxpKMqhG9VT9BHn9qwIN1tQ2PdRxtDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nx4eyENp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59D0C2BD11;
	Sat,  8 Jun 2024 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717846768;
	bh=hESuc5jTKHJYwPbjzd8756nTEyiEv2rREPyzDuxJeis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nx4eyENpPZRFrQlgSt9ifmD5RT9BN9IJoaO4Gw4o9PPgZbP7AwJdHoOFb8vSt/HvY
	 wJYqC5l6JoRWuyEC1JBG/wxxSyfF4ksEi029T9BrIzcNIN0QGzeCRleDuvRia+c5jD
	 drnXVbyLjXMK9N7Z11iDhDyDeGp4ZaYSwXOpR4Tg=
Date: Sat, 8 Jun 2024 13:39:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: iio: adc: stm32-adc: harden against NULL pointer deref in
 stm32_adc_probe()
Message-ID: <2024060807-quintet-pogo-3c8f@gregkh>
References: <2024052159-CVE-2023-52802-81ce@gregkh>
 <20240605145123.78220-1-iivanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605145123.78220-1-iivanov@suse.de>

On Wed, Jun 05, 2024 at 05:51:23PM +0300, Ivan T. Ivanov wrote:
> Hi,
> 
> I could we drop this CVE? 
> 
> of_match_device() can not return NULL in this case.
> 
> Even commit message agree on this:
> 
> " ... In practice there is no known reasonable way to trigger this, but
> in case one is added in future, harden the code by adding the check ..."

Ugh, our fault, sorry about that, now rejected.

Thanks again for the review!

greg k-h


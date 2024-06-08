Return-Path: <linux-kernel+bounces-207018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A1B901156
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 13:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0549F1C20FE6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3E155758;
	Sat,  8 Jun 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3fX9huc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463774C65;
	Sat,  8 Jun 2024 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717846671; cv=none; b=LEuRHQOQcoKn/Edh0F1sVOyp9+4WB2rwUt+ojmiWI7NlsFsg+FblNFg4nGWeZ3ltntOKJioZHFH9s8YUxKIiEItto/9+OnsVzuVP5ZI3wVk9wFkShljAAaSOtELNMyYVi5oMEsl8R8+mpu1s4FrB69fpovjIcRc446jRugalCtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717846671; c=relaxed/simple;
	bh=GszVp9XVHF6Of3OMjqONaXPF2paZbpxJyg1BfTVgpVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btTAg/iNFomoXCrWViDOq1M6ww79uFMNuebEi2m7qNnY5JKykvl/47rHQQXvhmRLP5puZ08R768jqkAGXXvnQw6NwIVCMe8j6qHdnAVam8KHrHldIWrWSSo0DIfOxn8UaO5rKJicCGx3mkhrOy5rxg4cRQAMXSZO85aPwLuOTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3fX9huc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606D9C2BD11;
	Sat,  8 Jun 2024 11:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717846670;
	bh=GszVp9XVHF6Of3OMjqONaXPF2paZbpxJyg1BfTVgpVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3fX9hucK00kQpmhEtXf6LQfo0/57roxsskuXA8p2845DVYnUbVgPz7iLswTMjnDl
	 qcOP0odbD/1BqA2sAhwswInAeWB6J0bPz7UiKxif6J/9HBNKQLRq+1dZM84BZeQM3e
	 jKf7BYqSPDmmisikXQYi3H3Bf8vh64ebQJbaOg7A=
Date: Sat, 8 Jun 2024 13:37:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: pwm: Fix double shift bug
Message-ID: <2024060807-monument-unlocked-781b@gregkh>
References: <2024052146-CVE-2023-52756-f694@gregkh>
 <20240605144305.78002-1-iivanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605144305.78002-1-iivanov@suse.de>

On Wed, Jun 05, 2024 at 05:43:05PM +0300, Ivan T. Ivanov wrote:
> Hi,
> 
> I could argue that this is not CVE at all. It changes just bit positions.
> 
> -	PWMF_REQUESTED = 1 << 0,
> -	PWMF_EXPORTED = 1 << 1,
> +	PWMF_REQUESTED = 0,
> +	PWMF_EXPORTED = 1,
> 
> ie. before fix they 1 and 2 and after the fix 0, 1.
> 
> All call sites are using set/test_bit() on unsigned long flags.
> 
> Yes, double shift do not look right, but I don't see how
> this could lead to malfunction, let alone a CVE.

It could be an issue if the values were larger than 5 as the commit
says, but that's not the case here, so you are correct and this has now
been rejected as a cve.

Thanks for the review!

greg k-h


Return-Path: <linux-kernel+bounces-512614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168EA33B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C59188AAA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20136211464;
	Thu, 13 Feb 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wwBF2vEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61C210F5B;
	Thu, 13 Feb 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440060; cv=none; b=eAzoB+QqVmZWeL9Crq2MQ1ChFKx0yKYT8y3AdrqcM1M/F7WY5GBMUpYH/fSUIsdjLjHOYoOqXJoYKtJQWgkrirDzRQOfK9eYOWiISeAqTJVjnTNxrcR4RBslRM0Bj7EF2zbZS63mPsE/buZM8iGgnBSajK2SGERoarfk4Z8eWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440060; c=relaxed/simple;
	bh=IdTti4DK2JAgX7yyitUoJaoRdhgKEdmEW6WOnrGZpi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj7osk8TYJqE1U7wdJKi6M7duJoCWHozc7uq+2Pi97rG2/cH+XmuBo16GiPPjPXgML3kcUKAIQsrXuw/lSfZgt3DLGJ5YWJxIH081iTWQiarfC1TX5MSQf2piFXEpgikG9MFam8GBmnCIx+4stGNcev8pX01eW1omno3faSC2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wwBF2vEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AD3C4CEE6;
	Thu, 13 Feb 2025 09:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739440059;
	bh=IdTti4DK2JAgX7yyitUoJaoRdhgKEdmEW6WOnrGZpi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wwBF2vEO3L0pfnOJVHbGXrV1gssyl5Iucvja0uqDMmb5uLq2kqxTkmm6Gds1SYu+u
	 0wQiLIY79BaNfBPvdNa+VsmjjVZYeyHSMxyqfozgkJWW3jJpQ5WXq6A0adMl6R9xPX
	 SJ76wo/kvr5axwtAJAJ8fGQY7WlkmwkWw+kBqBLk=
Date: Thu, 13 Feb 2025 10:47:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: vulab@iscas.ac.cn, linux-sound@vger.kernel.org, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Julia Lawall <Julia.Lawall@inria.fr>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: hda: Add error check for snd_ctl_rename_id() in
 snd_hda_create_dig_out_ctls()
Message-ID: <2025021323-paparazzi-ahead-22ec@gregkh>
References: <20250213070546.1572-1-vulab@iscas.ac.cn>
 <491e74f2-b503-4486-a8e0-b4eddc16b2be@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <491e74f2-b503-4486-a8e0-b4eddc16b2be@web.de>

On Thu, Feb 13, 2025 at 08:26:09AM +0100, Markus Elfring wrote:
> > Check the return value of snd_ctl_rename_id() in
> > snd_hda_create_dig_out_ctls(). Ensure that potential
> > failures are properly handled.
> 
> I would prefer a change description variant without the word “potential”
> for this issue.
> https://cwe.mitre.org/data/definitions/252.html
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot


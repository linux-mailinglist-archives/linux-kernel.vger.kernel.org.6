Return-Path: <linux-kernel+bounces-403133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E949E9C317C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 10:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6AD281A96
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380F2153820;
	Sun, 10 Nov 2024 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FyJA0tos"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5D14D6F6;
	Sun, 10 Nov 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731231661; cv=none; b=Tg9UcrAmZoBUIlpg+l0V7dZc0YmG3XaCnmwcUZ4XsAzsTZpjw4H2T9SEm3WuTlHVXgZgcRyIYJnhHQ1pLQkffE66u1cU5fHjEqDURZdezHQkVK54zjEnCzvc+9LCaBAA1ceopI1jhDNP774XTTMzzAkFR/JJS+ddgl//vC6vUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731231661; c=relaxed/simple;
	bh=e0akP6Dp9VssLV8Ge1X9qSf7GSDKHgH8n4C2cc93ftI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXUFy5DArkyZ3c8cFaleNAjcofiaubbEMgsPVQPvDEBDtuWV2s7DU9877cOGK80MuNFGqLC9I43z5j9G1t2LxXc2oMivkJiam5uw4K1Q6Q7L0hNCT/2UHmJB0HpMimHG/DI8g8O4HA+WDaRyGU2YVJZ7UOPfFtTkS3yjMIk5DkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FyJA0tos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8674DC4CECD;
	Sun, 10 Nov 2024 09:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731231661;
	bh=e0akP6Dp9VssLV8Ge1X9qSf7GSDKHgH8n4C2cc93ftI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyJA0tos2bLpH3VkQxQwsPaYO5df095+tSIqJ+0AKbsWrzEKcXjLlKnDvlwOGjmDR
	 tcQZvCoHhyfywpfKOzAg+iYTSRHFtRsVn1CKpZYFGQU93Y/rD1094/0w1trq5i7BGk
	 uP+xJfHYgs3ss4fN1DvmwIC4EppAptt6ZPFA9vQs=
Date: Sun, 10 Nov 2024 10:40:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org, kpsing@google.com,
	ciprietti@google.com, melotti@google.com, sanjay.k.kumar@intel.com
Subject: Re: CVE-2024-49993: iommu/vt-d: Fix potential lockup if
 qi_submit_sync called with 0 count
Message-ID: <2024111012-proofs-tinsmith-9569@gregkh>
References: <2024102138-CVE-2024-49993-5b57@gregkh>
 <20241029114008.2436272-1-jackmanb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029114008.2436272-1-jackmanb@google.com>

On Tue, Oct 29, 2024 at 11:40:08AM +0000, Brendan Jackman wrote:
> Hi Greg,
> 
> > Currently, there is no impact
> > by this bug on the existing users because no callers are submitting
> > invalidations with 0 descriptors.
> 
> I think this CVE could be discarded, the count arg is always hard-coded to 1.
> The buggy function isn't even exposed to modules so I think even if we care
> about out-of-tree code we should be OK here. (But based on [1] it sounds like
> out-of-tree code is probably out-of-scope for kernel CVEs anyway?)
> 
> [1] https://docs.kernel.org/process/cve.html#invalid-cves

Yes, out-of-tree code is on its own, for obvious reasons (i.e. we have
no idea what they are doing, and they know exactly what we are doing...)

> FWIW, I don't have any burning desire to kill this CVE in particular, I'm just
> testing the water to see if this is one reasonable way we could share some
> triage effort among consumers of kernel CVEs...

Yes, you are right, this one should be rejected, and that's now done,
thanks for the review.

greg k-h


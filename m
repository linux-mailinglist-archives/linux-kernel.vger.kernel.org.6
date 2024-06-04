Return-Path: <linux-kernel+bounces-200717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DB8FB3ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7661C2162C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD629146D7F;
	Tue,  4 Jun 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPy1U1Wk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4E146A8C;
	Tue,  4 Jun 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508228; cv=none; b=X5Ui71V5U3Y3iwj3tDmNkxgKb0bIUnF3fDlHciSV/+tPypWGVORwqlDujiIWMScCm1jav6O0MfxpLrwZzYkHV0kBUIcIq5+DJhAkzOU6sSgNX2dubYqUoKIM4gFRYX6U9wVY+7dl1SRBgFpyG75CBorfJEC720AzvknJaz2liTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508228; c=relaxed/simple;
	bh=SuQvMSZ0VaKoTSQlIpx3nCfb7mEfk7fB5zR5M39QExs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPghw806xOqRJeCcOAblxHwCbCQCUuwltiSTFfI8LkMqW2QOECCZSBIvDhDHXm36c0ELSdMzKSOw8E2+KiKtonnYO5rk7dOwsO6qtxjNdQ0CxWi7hNd6VZ4N+Ar0nO9KzUrmv2eZlQlR1+ZKOjKer1UddIo4M2B5ABL2cXyNVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPy1U1Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB04C3277B;
	Tue,  4 Jun 2024 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717508227;
	bh=SuQvMSZ0VaKoTSQlIpx3nCfb7mEfk7fB5zR5M39QExs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPy1U1Wk9cgQv0yfxqrhSyEFRFdMZtqaqlVEaoE4rnpzqVyFPrs/EQ0eblOkkCE6R
	 xZAit4SGTTnblSLTNjpvmRXL99PWILD9BU8gbYLTAip9VfxcvCWVZQk7CbRQp5TK17
	 o1OP5l8OvhX9QQShkwLDHmH+8GXYZh8oXaL3YcR4=
Date: Tue, 4 Jun 2024 14:56:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35941: net: skbuff: add overflow debug check to
 pull/push helpers
Message-ID: <2024060401-geography-shucking-21d2@gregkh>
References: <2024051919-CVE-2024-35941-1a9e@gregkh>
 <Zl7z_Yz0cIbsr53Y@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl7z_Yz0cIbsr53Y@tiehlicka>

On Tue, Jun 04, 2024 at 01:01:17PM +0200, Michal Hocko wrote:
> AFAICS this patch is not fixing any security bug. It adds debugging
> output and triggers a WARN_ON with CONFIG_DEBUG_NET (which could panic
> the system with panic_on_warn which has been broadly considered a CVE
> material by the kernel CVE team).
> 
> Please drop this CVE.

Ick, I thought we had weeded that one out, sorry about that.  Now
rejected.

greg k-h


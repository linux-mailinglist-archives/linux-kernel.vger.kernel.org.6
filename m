Return-Path: <linux-kernel+bounces-217870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C625090B56C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AA9281F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CB13C825;
	Mon, 17 Jun 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W8D89Vke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1E13C81B;
	Mon, 17 Jun 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638994; cv=none; b=OdgCtSAYowKHB5wObZVYuYhuHDPlqfWOnel4kJUG94LUlDTyw7wfO9UkTRMQo4uVFSA0xPJyMzUBPl10EMLOCpmr3gkn/JJFVlOdxlKKx+IcyltfPgWXNznWb82Ksf6sM/3M/gQH4ukV6SEyJca8wQpE771n7lfaaEPyrdJakOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638994; c=relaxed/simple;
	bh=uYHMHuHKbjppL3jA7IC9Moc/s3o4qLpggY3MnBJKtX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej2of8y5E0/eWCAIupwJiburD7iLj5QRJz7CxJdw3wx5lZiam3wyGgy1fSy1z3cSsLPF8DHRXSg7SNgCSWa+cM21aowSupdRKIMzxSdaCZo7CK8rqtn8maFkXKIiOlMpqU2GVVBQBuOsXe7Xyh85BHn1zEWSIIK1ovJoCmMmc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W8D89Vke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18652C2BD10;
	Mon, 17 Jun 2024 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718638993;
	bh=uYHMHuHKbjppL3jA7IC9Moc/s3o4qLpggY3MnBJKtX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8D89VkeF41caGIyw+Hy2T6FMLuMv9tmpvMjIObfvMoUXfhrfH0mit/A5EfsjWpDP
	 x1+JlQJYj+lhm48dIFFrHEl0r00OsF5dzqMXn8qqfpOeFKNWohHwagd3lZEWgatrgW
	 Bh8n7q1uYR1Qp99YvCnAi1Xh55t5KJpTE88cugHY=
Date: Mon, 17 Jun 2024 17:43:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35840: mptcp: use OPTION_MPTCP_MPJ_SYNACK in
 subflow_finish_connect()
Message-ID: <2024061750-glade-overstep-7759@gregkh>
References: <2024051756-CVE-2024-35840-99fa@gregkh>
 <ZmFtaijTs6mOpB5B@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmFtaijTs6mOpB5B@tiehlicka>

On Thu, Jun 06, 2024 at 10:03:54AM +0200, Michal Hocko wrote:
> Hi,
> what is the actual security threat here? As far as I can see, the
> problem that the commit requested here addresses seems to be rather
> functional, rather than responding to an unexpected packet options with
> a reset, we actually establish a connection with some garbage parameters
> (likely unpredictable). Which is unfortunate but I do not see any
> security implications.

Sorry for the delay.  I'm pretty sure this is a data leak as the
"garbage" is coming from other kernel data, and as such, was reviewed by
us as a vulnerability.

Do you not see it as such?

thanks,

greg k-h


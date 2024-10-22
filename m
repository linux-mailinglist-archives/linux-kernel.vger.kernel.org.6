Return-Path: <linux-kernel+bounces-375613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A29A982F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EA81F23AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EE130AF6;
	Tue, 22 Oct 2024 05:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jvBrUj0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DADF84DF8;
	Tue, 22 Oct 2024 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574077; cv=none; b=NbTVkOG7G/4bBQXJum2nAomYQEpibnCjeqqCmDNyWdBfVguPB3G8quOtLw2ZICQ3AhVscjVUXSFB+OnHHoI671bz9sPqM/HrJ8u9pcRrCZ1dTCQK+25K0ExvFsCMnr1+2E69zESLoJ9EktA6oGiYp5+DnznTqJQYUcqLU49kDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574077; c=relaxed/simple;
	bh=1jkNlwMF4vkDOF+NAig94pV+JFYv3I+EouVkRAryLIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+CPL47l9bVq04XnEIncJPa3UMa9xIxZJJ6MQJtw8pxN2g4c4tAQiN9KUyCjuq+LBBMHhG14w1X0p8oaA41naFFrvkklyaIH8iT33dT65tqGj7EACyvOEOyndDKbj29gDjqJJ+nClssrdswAfbKtsesSUDZTLjdEMNFCi4gYZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jvBrUj0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52F9C4CEC3;
	Tue, 22 Oct 2024 05:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729574076;
	bh=1jkNlwMF4vkDOF+NAig94pV+JFYv3I+EouVkRAryLIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvBrUj0rq78ucLBXAjb54jQLXXn05hvFy3MMulvN4EsytoOEKhLsItEwy+6fqDxVp
	 PaPA4+IUQs8viN2t7ZoC8ebM3DqxHYnpNCdjNeZ346/d6fbpkpqyjLzY5BmkUtmo0j
	 /QVZfmybmRt9qh50yLR23d+NKWRQyZEEhRv1CaRA=
Date: Tue, 22 Oct 2024 07:14:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: robh@kernel.org, heikki.krogerus@linux.intel.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, badhri@google.com, kyletso@google.com,
	rdbabiera@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org
Subject: Re: [RFC v4 0/2] Add support for time DT property in TCPM
Message-ID: <2024102250-citric-dropout-17c7@gregkh>
References: <20240925031135.1101048-1-amitsd@google.com>
 <cf0f9a77-4981-48af-8fda-76e57f8a54fa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf0f9a77-4981-48af-8fda-76e57f8a54fa@google.com>

On Mon, Oct 21, 2024 at 04:01:10PM -0700, Amit Sunil Dhamne wrote:
> Hi,
> 
> I had a process related question. Once an RFC patchset gets a Reviewed-by
> tag, do I need to send a formal [PATCH] or is an RFC patch sufficient for
> being accepted?

You need to send a real series (and please do not top-post), for it to
be considered for being accepted.

thanks,

greg k-h


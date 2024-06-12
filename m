Return-Path: <linux-kernel+bounces-212256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE31905D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E5BB2287F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2B612C470;
	Wed, 12 Jun 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="coeMWT35"
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355244315D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226169; cv=none; b=X4HxX4MPdVpDr/tdpe+gxwcubl8OvQYC5ldlqpa3L3DQfMkj1NUJRn59y82NP1tCYV+QdHpqIlIgnQJjxB78/aiJcpX9VWkJqbZIVl8VxRehB1OVSTq5IITbmLg52rpWYxXR7AE3Bmd39pHz0uMHN46MujBQIdHEVno8wVJeg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226169; c=relaxed/simple;
	bh=ZGi6j70z+U+okCcP86mNO61UTOQpTQZu7f8h0MPMOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6JqcrCOWocnu0xBsnplLiAhxlPgiMk+UwCu+dhmC3nT2UIO+4s1xGmEYKItDVn8haWHOtEsATGB/QCril9d4db8PZwm0IrSDqgluun060pcwTArNPiLU5IP2ns6xbvXYiLU4gLbu27MG15/9l7WPLOBJL/q5hQVhaxnxL/trRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=coeMWT35; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=yCmrzEiID1d7fBr18T8wzcPvEeuHgKP/DqXaO8p4zIk=; b=coeMWT35Qu08XTWOoQwC2CiT11
	1HeWCiXRYDFbGznhbzKp65msZI05WtPgkv9vd+4NyBaTLkx47jw+GhKSTKvHQWcozbWC8Dan0X+GK
	sqn0oK5QHVgZGT/qf7YMl7N4YWnSDs/1IBTL+ANYV0yncGbaf1e/8KYPlCckYctX5wM4Zmh9yuksK
	q4U1pqDGkB9/EWWpz1DzLAYNmV4wNVRdGXPSRPlr+7nHT4osgVZQ0i0CSQFoyTMfr2MGx4kRE3IRq
	rTP+1lBSdNozBziO203EdDG2yLEmXARsuoWvHxazcddNvPJX0hkc9lJwnMbOGWBRuHg6S5oyU0SNW
	h38fH1pGm4SiCK45Tnvjw1OQ8OaSkuvDm+kClklcyHla8csgCcYdBGv3nBMDkDFZfwQb0B2ng8qT2
	9pNlhxSvJstgtV8bs2IHR086esQgOGPiYcgqYJOv4bRj2bOf4t0NT7LlEuPIi8JgsHvUIJnm4eAFX
	/f8D4F9oYOZMiI55lI8bB3Mj;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1sHV75-00GPm2-2u;
	Wed, 12 Jun 2024 21:02:36 +0000
Date: Wed, 12 Jun 2024 14:02:31 -0700
From: Jeremy Allison <jra@samba.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
Message-ID: <ZmoM59t82BCy8h3b@jeremy-HP-Z840-Workstation>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
 <20240516154920.221445-4-stuart.w.hayes@gmail.com>
 <ZmoLL8c_ujmjzSHQ@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmoLL8c_ujmjzSHQ@kbusch-mbp.dhcp.thefacebook.com>

On Wed, Jun 12, 2024 at 02:55:11PM -0600, Keith Busch wrote:
>On Thu, May 16, 2024 at 10:49:19AM -0500, Stuart Hayes wrote:
>> Add code to shut down devices asynchronously, while ensuring that each
>> device is shut down before its parents & suppliers, and allowing devices
>> that share a driver to be shutdown one at a time if necessary.
>>
>> Add /sys/kernel/async_shutdown to allow user control of this feature:
>>
>>   safe: shut down all devices synchronously, unless driver prefers async
>> 	shutdown (driver opt-in) (default)
>>   on:	shut down all devices asynchronously, unless disabled by the driver
>> 	(driver opt-out)
>>   off:	shut down all devices synchronously
>>
>> Add async_shutdown to struct device_driver, and expose it via sysfs.
>> This will be used to view or change driver opt-in/opt-out of asynchronous
>> shutdown, if it is globally enabled.
>>
>>  async:   driver opt-in to async device shutdown (devices will be shut down
>>           asynchronously if async_shutdown is "on" or "safe")
>>  sync:    driver opt-out of async device shutdown (devices will always be
>>           shut down synchronously)
>>  default: devices will be shutdown asynchronously if async_shutdown is "on"
>>
>> This can dramatically reduce system shutdown/reboot time on systems that
>> have multiple devices that take many seconds to shut down (like certain
>> NVMe drives). On one system tested, the shutdown time went from 11 minutes
>> without this patch to 55 seconds with the patch.
>
>I've successfully tested this out on a few systems, and noticing a very
>decent shutdown time on my nvme systems. I also like the current
>solution here, as the two-pass method was harder to follow.
>
>So I think just remove the extra options that Christoph mentioned and
>always use the driver's preferred shutdown method, then this would all
>look good to me.

Yes, I have tested this patch on my systems and am greatly in
favour of this instead of the two-pass version I was trying
to make work. It is easy to understand and fixes the problem
for my NVME issue.

Jeremy.


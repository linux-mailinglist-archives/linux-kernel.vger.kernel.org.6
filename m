Return-Path: <linux-kernel+bounces-280264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB43194C7D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BBC1F23A21
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904F8BFC;
	Fri,  9 Aug 2024 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JK50byOm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB8610D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165259; cv=none; b=ctOMp10Koufh4Q17pSb0Xy630HHajrFVPrpSFteZW0+LMMJAwuHdws+SnOwDy4kRG4w23h6rdONJFiVQourOBgzvOEsdwiITLRKNxJrlMwNvqYI6DT+lHqxzjONTZplZYYVyoJGeJyctNG9V8rhcHuQ9tqNYLsaRm1y+ie5O61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165259; c=relaxed/simple;
	bh=TzrW3y6SzsbNFighfe8q6Qkw+b/AgGKoiKBOEDWYo2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if+79NYiYgcik6HvMSy5lCpikYgbmSe5sxVBN8QcIcTmIpTfSQPFugL4v8JX7XSCBrAaz1aCrgmFI/JAkcKpUW0grQtYnulHZh4PD08sL6n8Qn22N3nbzb2F9sGRuohyWkxSXEDE/MRLTUy0NpMQbN3GZDymE8jT4p4csrNwWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JK50byOm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723165256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUh2ZcyYR28eZFFdQirdhBUZopZzvCQuM/XbmHwKiM8=;
	b=JK50byOmQxxOIcx3FX4aPWuI4GzJYlaMM047a4eeO9RNEEz4ZXeLg3KtteThw+4QRH/qUy
	LEE7N+0LDcrX9RUaMdjdO68d2w4CKW1tCNTEz9PuFiCmnbOBoddYTEo5d/6yxpUwL5z5FL
	BWxVZNIOX9EgsidGU2kUj9/+CWeKd2I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-5hjdLnQtP42zcJyK7MW5VA-1; Thu,
 08 Aug 2024 21:00:54 -0400
X-MC-Unique: 5hjdLnQtP42zcJyK7MW5VA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44FB31945104;
	Fri,  9 Aug 2024 01:00:53 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B4BB19560A3;
	Fri,  9 Aug 2024 01:00:49 +0000 (UTC)
Date: Fri, 9 Aug 2024 03:00:44 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Artem Savkov <asavkov@redhat.com>, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] selftests/alsa/Makefile: fix relative rpath usage
Message-ID: <20240809010044.GA28665@asgard.redhat.com>
References: <20240808145639.GA20510@asgard.redhat.com>
 <83d4e1a3-73fc-4634-b133-82b9e883b98b@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d4e1a3-73fc-4634-b133-82b9e883b98b@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Aug 08, 2024 at 02:20:21PM -0600, Shuah Khan wrote:
> Wouldn't make sense to fix fix this in selftests main Makefile
> instead of changing the all the test makefiles

As of now, the usage of rpath is localised, so it is relatively easy
to evaluate the effect/prudence of such a change;  I am not so confident
in imposing rpath on all of the selftests (and, if doing so, I would
rather opt for runpath, to leave out an ability to override the search
path via LD_LIBRARY_PATH, if such need arises);  in that case it is possibly
also worth to add -L$(OUTPUT) to the CFLAGS as well, as the compile-time
counterpart.  But, again, I was trying to avoid the task of evaluating
the possible side effects of such a change, considering the variability
in environments and setups selftests are run.

> Same comment on all other files.

> It would be easier to send these as series

I hesitated to do so due to the fact that different selftests are seemingly
maintained by different people.

> please mentioned the tests run as well after this change.

I have checked the ldd output after the change remained the same (and that ldd
is able to find the libraries used when run outside the directory the tests
reside in) and did a cursory check of the results of the run of the affected
tests (but not so sure about the BPF selftests, as they don't compile as-is
due to numerous "incompatible pointer types" warnings that are forced
into errors by -Werror and the fact that it hanged the machine I tried
to run them on).

> thanks,
> -- Shuah
> 
> 



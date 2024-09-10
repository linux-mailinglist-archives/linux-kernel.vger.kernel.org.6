Return-Path: <linux-kernel+bounces-323018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D3B9736AA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481471C249C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE2018FDD5;
	Tue, 10 Sep 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmOWnQYw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346A18D63B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969661; cv=none; b=i1Pggm7+GfeXEtuMizef9or6rAAG/TMvEKEOm+0jnnFf1ihPwCxPKoBN1+jEaymadc8AfOzjrGUObwGYTfXR42v2feLvpTPbNsM/tSbLnFxg7qX/M1A7Z8ttMupH1bZ4hBrAwztTqGW7f5vghBJ0IA5BIkjkhSzfMqDhpNdP2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969661; c=relaxed/simple;
	bh=/vOHCO942n2Qv9J3oYvN5GzswnXaoFijd3MfPeam82A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwinUA5D9RtqMou6CKVhTKJ+7jWRk5B/01cKXu+LcZsZfdXON7y0QpsGHyyES9YrRp35+aMlivuJyq+usTniLumS3LlZrg4i1oaos+wmTNua1ATL1bx5OaUatB0pncHOFFtKt/yKwCkkKH1yfRujnOg3XqCI2ysAt57f+f0kRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmOWnQYw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725969658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RlZExaP6F0u3XxUyqkrn+EYxXKiG1XXlKjipw5WW1Yw=;
	b=DmOWnQYwGxcuTFUe+HMbAhaQhpxoI82jQu2imX15z7QqSq8vRpKs5fak0+ppLMlPhFMhAF
	UYIXchcKIX/UZcKfOj/rWwPrD2sKrl/A/L/vSNouKTpIJvjUeHsSoLyoxMfAo18s775XDd
	3OMKE0gsiijIVldny4+mVt6JMm7ek1g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-okXjDirvMNOE_Iqbz0FFTQ-1; Tue,
 10 Sep 2024 08:00:54 -0400
X-MC-Unique: okXjDirvMNOE_Iqbz0FFTQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C7C51955F10;
	Tue, 10 Sep 2024 12:00:53 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC54D19560A3;
	Tue, 10 Sep 2024 12:00:51 +0000 (UTC)
Date: Tue, 10 Sep 2024 14:00:49 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ptp: Limit time setting of PTP clocks
Message-ID: <ZuA08ew8aNb8P_n4@localhost>
References: <20240909130905.962836-1-mlichvar@redhat.com>
 <Zt8YyCrQL1XBQk0g@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt8YyCrQL1XBQk0g@hoboy.vegasvil.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Sep 09, 2024 at 08:48:24AM -0700, Richard Cochran wrote:
> > diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> > index c56cd0f63909..bd7c5f534be6 100644
> > --- a/drivers/ptp/ptp_clock.c
> > +++ b/drivers/ptp/ptp_clock.c
> > @@ -100,6 +100,9 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
> >  		return -EBUSY;
> >  	}
> >  
> > +	if (!timespec64_valid_settod(tp))
> > +		return -EINVAL;
> 
> Why not perform the test earlier, in SYSCALL_DEFINE2(clock_settime, ...) ?

It would be more code as there are also the 32-bit compat variants of
the functions. The adjtime function would probably need to handle
missing gettime.

The limit would apply to all clocks, not just PTP clocks. If nothing
else, I suspect it would change returned errors for other clocks
trying to set the an unacceptable timespec value.

-- 
Miroslav Lichvar



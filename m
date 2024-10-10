Return-Path: <linux-kernel+bounces-358097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDEE997A22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DACD1C21C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAC05028C;
	Thu, 10 Oct 2024 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Ks3IgI/F"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92291405F7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523331; cv=none; b=U75ngU1XBRYENCpYoeYaYqWdCjJbghpP/Ysb9qipaKyIecyOO+TjuofUZjCUa3DLCojDImpfm1hj6D4uPPyStrQnMiil8MhiCnRA4YvyL/PJ7rqtOUj/KGbpgiD4lAc7VDwgbBISO5gA4jxdI6FfuDNFohLV80QrcItv/AVgRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523331; c=relaxed/simple;
	bh=A3hY1tK2VR73qEGd+zuZ6YuMptqXhnn0I+SNQyz6PGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3OSGaScXfQAw+yIWq4wF6LNqGrSbp+8oPrNBpCORNnCMDYwdtNt0RFKfT1j1uUV5DJe2Tn5wmH8yhcGF8Adx0ZWaB299BRYbrZOMIw8TYXWbyXFhYEAVOW7fYVNIWvZzu7ZmWkb57eYkFbqY4D24Dbk+neflWXuPTS+9RoXiP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Ks3IgI/F; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=eSUf5cX/woWuMXZxwBnga4zQwKSZFiE1b9cTJZrpF5I=; b=Ks3IgI/F/oIH7TXk
	RCX+SNRTVzOJt3aeOhSd1cZgJmqghOXEsVsI0MskCeYZBCv9AsRh2vtME53cmnaImHgZdKt2t18Mv
	fDJ7RlWwMTx1bITJLSBiFBn7Xfa/HH0sRMXFa/otZaRslJSgO0uTPXGNTYw2M8m9WITrfTbYNU0yK
	5NNA2OYJ2DTKTiqmb/0VUXqOuNd1lSXV97o6UJQw8vk+81VGIm26d9O1kLi3QUMqLKGIqgoWP8lN6
	EEM0KbBAs7BjxmV/HPl7Dv65dgrCM0irWOdzqa4lC9+8AdzAxIaoTcVTdUkUFO7bPlW09aTtXmx4M
	GLL51+9JkijMgIuEOw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1syhsO-00A76f-1e;
	Thu, 10 Oct 2024 01:22:00 +0000
Date: Thu, 10 Oct 2024 01:22:00 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: John Stultz <jstultz@google.com>, tglx@linutronix.de
Cc: sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Remove unused clocksource_change_rating
Message-ID: <ZwcsOMV6kofmpduf@gallifrey>
References: <20241009003032.254348-1-linux@treblig.org>
 <CANDhNCr=+x3fJo1dhyWnSGGLtexXLcTuHj8OEPqbj_TcDWdEPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCr=+x3fJo1dhyWnSGGLtexXLcTuHj8OEPqbj_TcDWdEPA@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 01:20:51 up 154 days, 12:34,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* John Stultz (jstultz@google.com) wrote:
> On Tue, Oct 8, 2024 at 5:30 PM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > clocksource_change_rating() has been unused since 2017's commit
> > 63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific clocksource code")
> >
> > Remove it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Thanks for submitting this cleanup!
> 
> Untested, but
> Acked-by: John Stultz <jstultz@google.com>

Hmm the test robot got an unused warning on __clocksource_change_rating
I think that's because it's an allnoconfig and that needs moving inside
the ifdef.

I'll look at it.

Dave
> thanks
> -john
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


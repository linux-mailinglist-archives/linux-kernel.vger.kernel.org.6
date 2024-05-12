Return-Path: <linux-kernel+bounces-177005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38878C3862
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427DEB21455
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405E2209F;
	Sun, 12 May 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="slWq8uBA"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE76380
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547036; cv=none; b=Tm24+P9Y+dluvSC2leEf/rkXFPiJI8attvTZSq0BO6cYw8wHTG9J/5xjufmGUuWax7E2VxFrBeJqStfBL1oTug0Hez6a6Y259ce68QB/NbSJX4IuYC328ZMBNvsz1B99Jmfhm6QeR/8uylL5G0snrrTXJ/tUX5mVrqkwRt3L+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547036; c=relaxed/simple;
	bh=R82jH/CTzlPxLDQ6HiMBIPXQURxxCmUDu8oOAGiCJ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXcjxD07SymSH2CT8GloqfiRCRz+j0a7hwMU3I4/ABRzEE/+Nx224fk7tvlrXTuNb1TOSGAcCt8QlA29evMlFWhOZCS0/giBk2AerGqQwaMALokIp/nNOSArVQZKAb0QG/9HXErDsRB2YouEmqriQ21IFy59DxV3GxdpSq48YUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=slWq8uBA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=bCl1PyZjFro/Rm4AJnAJ16YD5mtSBLN9tWzUw4P6UJk=; b=slWq8uBAkTUH6YqI
	PthKskQ9dsu83sTwxjyTTMnaHflfKDG2o7JhYQxS6rHqdyhmwx7+Za+7vSIRWTekVAY3446oGag9a
	1ty2LpN0DJH0gvk5y9l6x0UGnii4nVnPBaek3V2z7OG/4yFG5sM5KMx1//9AYjj75efoTlXKlON8Y
	QxzasnxhsYZ2InZoMSEg1PXuGjaUkuaXvhYohNEXGbERdqdeYPXCjGphXFNe/IMnAcnwXJRpHjOTT
	fOGmPSFfvQq9ImvahV9MbYoOcDyU7styOmr+t9hWda1q/q6MSnIbTuJZ+TkPwqSgXfY8kJ+HTHrDO
	wgKz6EXFMC+Jf0WYow==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s6G9I-000cZr-1J;
	Sun, 12 May 2024 20:50:24 +0000
Date: Sun, 12 May 2024 20:50:24 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Inquiry Regarding Handling of Kernel Crashes
Message-ID: <ZkErkG77vLkcVaUZ@gallifrey>
References: <CAHhAz+hcVRU8=SkkoHGRDN5zRvB2HY1-1Y2NQmNwR=07ObSFrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHhAz+hcVRU8=SkkoHGRDN5zRvB2HY1-1Y2NQmNwR=07ObSFrQ@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:42:25 up 4 days,  7:56,  1 user,  load average: 0.09, 0.03, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Muni Sekhar (munisekharrms@gmail.com) wrote:
> Dear Linux Kernel Community,

Hi,

> I hope this email finds you well. I am currently engaged in testing
> device drivers in Linux kernel mode, and I have encountered various
> types of kernel crashes during my testing process.
> 
> Among these, some examples of kernel crashes include OOPS, lockups and others.
> 
> I have a few questions regarding the handling of kernel crashes during testing:
> 
> When encountering a kernel crash during testing, is it advisable to
> continue testing without rebooting the system? Or is it preferable to
> reboot the system after each kernel crash and then resume testing?

Rebooting is best.

> Can the first kernel crash, whether it is an OOPS,  or any other type
> crash, potentially lead to subsequent crashes of the same or different
> types? If so, should debugging efforts focus only on the first kernel
> crash, or should all subsequent crashes also be considered and
> addressed?

Yes - not all failures do that, but some will cause follow on crashes;
looking at the first crash normally gives the most reliable idea
of what went wrong. But keep all the logs, anything might help you figure
it out.

> In the event that the system needs to be rebooted after a kernel
> crash, how can user space test utilities be informed that a kernel
> crash has occurred? Additionally, how can the system be configured to
> automatically reboot in the event of a kernel crash?

See Documentation/admin-guide/kernel-parameters.txt  there are 
quite a few useful ones, in particular:
     oops=panic   will cause a panic after an oops
which when you combine it with
     panic=30

   means an oops will then cause a panic which causes a reboot.

You could also consider using a 'crash kernel' - on a panic
that lands in a fresh kernel that just saves a memory snapshot
that you can then try and debug.

Turning on a watchdog as well is good; some kernel bugs just hang
rather than giving a nice oops.

> I would greatly appreciate any insights or best practices you can
> share regarding the handling of kernel crashes during testing. Your
> expertise and guidance on this matter would be invaluable to my
> testing efforts.
> 
> Thank you very much for your time and assistance. I look forward to
> your response.

Good luck!

Dave

> 
> 
> -- 
> Thanks,
> Sekhar
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


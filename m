Return-Path: <linux-kernel+bounces-415223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E09D3311
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2641B24173
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2B14F9F8;
	Wed, 20 Nov 2024 05:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="OAKc1CMB"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACB804
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732078914; cv=none; b=tbT27cow0gtrCipy3mCDfdxt7fgWulpi0kpCyWaHdxUBNWl+8f+lum1Em0YIqn/h6de6u6RyNYnwXdp7i1DNbD5VeKQsgvJ/6z19P6IeSl+6oHEdGZHavk/KQ1rkLDUZ5+YTqRUWTeDbifgyPAcRreMEdYXIyMHStxwivViyRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732078914; c=relaxed/simple;
	bh=riEVPnazOYnDoX3cVti81jHrHIBh3bH4tiA+d43f+j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my6KQBb78kcvLtuno22z6r1JgpaHb0YNSWBvTW7nw8upEB4UQmemEMAd1dqgk82snJqlVqVnzWGyocXrzzKw6nWxC2SXtyfpQ2BJweM4/G53S8ynZQaE3TuQk6Km0qqURWVrTOGtx9/pheRlrgb1KqvjqYmG1pJNJRmIl0sSX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=OAKc1CMB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38246333e12so3037241f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1732078911; x=1732683711; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6HydsuI/unfNveieXYP/c+VW8XNja8pi+DLngjCRrs=;
        b=OAKc1CMBGKurysDRW/Aq0EahJgNCpaje4NiWgTugoKfYPaZPQFBesdy9pEq7Yk8McR
         st1s7pwidnPGfxPMxrjSxGSN2o2SYZ1Gpa7DfE3lAt0FMjNMMA/qJxJwzN6vgDS4GB78
         xWbCzvEf17ft7rN5bMv8do3Qcuy1vKVhnnK4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732078911; x=1732683711;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6HydsuI/unfNveieXYP/c+VW8XNja8pi+DLngjCRrs=;
        b=jnVfHW34W268DjXQH9m1wSpKWlJMVGYfotHbgfix6l3lu5qaPVeCACUvC7KIJzfvdb
         3960I1To7onkpqSO1lSbgjBvJiLsttAPVcyIhcWKMmIjjukuEwuoHnyDJex30XjOOTLZ
         ATMIEVynkvRAQ9yXfOpj6TP2+UdqCp//G/AihZ7CQGZQAesSUisFU8/zBrWFVLBT+7GJ
         faeLeUXEG7SjLiI8uLAOK5cSnjpzQsIsIw0RpmdsaX4MbjoaqJi4EMWy38ZpizenXwCp
         uctiQKLbvpC/dSTv0qAqkIsokgtBzS4rNfqD8wxfl5Ru+sz66bOATn6OlU+/RbIvlIlT
         PP3w==
X-Forwarded-Encrypted: i=1; AJvYcCWoU2xrFSBgL54zBw1zsS0QYrbeNg6NoEwqwvP4GXkMXi36w6FrNPVXIvNJ9TLvYNoMJhIG6nDj6lhKgzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5988Byjxj74LVoyhSvqDvAeJHWzIMm0/JKXoaJPVHBuiOqcmB
	Cm5u/OxfSqKNteZYGaYqkmgTXP2Ox99TqAcVd3Kpf1si3n9/itbPZXV0AfdZeeJlOawou+zs2af
	I
X-Google-Smtp-Source: AGHT+IEcpsmHkHV7Q8/PXY2y/1L2/UyUrp8bZ68lMvR/vKxnjx7g3UNVB8H2JsCBqOD74EWa26O13g==
X-Received: by 2002:a05:6000:1a85:b0:382:504d:31d with SMTP id ffacd0b85a97d-38254b13fcdmr1056288f8f.40.1732078911323;
        Tue, 19 Nov 2024 21:01:51 -0800 (PST)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490529fsm1026522f8f.4.2024.11.19.21.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 21:01:49 -0800 (PST)
Date: Wed, 20 Nov 2024 05:01:47 +0000
From: Chris Down <chris@chrisdown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 06/11] printk: console: Introduce sysfs interface for
 per-console loglevels
Message-ID: <Zz1tOxW6PO_2OeSA@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
 <2024111508-native-subtype-2990@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2024111508-native-subtype-2990@gregkh>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Thanks for looking this over :-) All not mentioned points in this reply are 
acked.

Greg Kroah-Hartman writes:
>> diff --git a/Documentation/ABI/testing/sysfs-class-console b/Documentation/ABI/testing/sysfs-class-console
>> new file mode 100644
>> index 000000000000..40b90b190af3
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-console
>> @@ -0,0 +1,47 @@
>> +What:		/sys/class/console/
>> +Date:		October 2024
>
>It's no longer October 2024 :(

What would you recommend? When I sent them it was, and it doesn't seem 
realistic to think that it's going to be less than one month from me sending 
the patches to when it gets merged, no?

>> +What:		/sys/class/console/<C>/loglevel
>> +Date:		October 2024
>> +Contact:	Chris Down <chris@chrisdown.name>
>> +Description:	Read write. The current per-console loglevel, which will take
>> +		effect if not overridden by other non-sysfs controls (see
>> +		Documentation/admin-guide/per-console-loglevel.rst). Bounds are
>> +		0 (LOGLEVEL_EMERG) to 8 (LOGLEVEL_DEBUG + 1) inclusive. Also
>> +		takes the special value "-1" to indicate that no per-console
>> +		loglevel is set, and we should defer to the global controls.
>
>-1 is odd, why?  That's going to confuse everyone :(

I originally had it that you had to send "unset" instead of -1, but in 
discussion with Petr it was suggested to change it to -1.

Petr, what do you think?

>> +	if (console->classdev)
>> +		device_unregister(console->classdev);
>
>How could this be NULL?

I think it's from an earlier version of the patch where we would still continue 
setup even if we couldn't allocate it. I'm okay removing it.

>> +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
>> +			     char *buf)
>> +{
>> +	struct console *con = dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%d\n", READ_ONCE(con->level));
>
>While I admire the use of READ_ONCE() properly, it really doesn't matter
>for sysfs as it could change right afterwards and no one cares.  So no
>need for that here, right?

I'm not sure I understand, could you clarify? From my reading of the code it 
looks like we need this to avoid tearing.


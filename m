Return-Path: <linux-kernel+bounces-409806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DF9C91E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C396F282916
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB616199EA2;
	Thu, 14 Nov 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="N8+swpX9"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549217A583
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610424; cv=none; b=RUiSLm7KyPcIoSJ7h1hlvgGATCNkjITCK2/wWM3+Tc88fe58fSN2nslJ7gEhl4wCfUCoIt4HLChjsmLYshaQq2kmWcN0tpE2H/j+clHzWB7IjEyym9H1NGxvQAC8XeZtrosnFs1nhD8+/qF4MDYTMozPu2uwiadrSptad8fA81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610424; c=relaxed/simple;
	bh=tz3mfkESkPyqASsRsCPxQA6MA3WhhXIEYgcrIe+Urjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+0CXPD+fu860TDh3ZcCHcqbXOU5vp2sZaYTERsos2K7uiVDtJtYLKpVlFwUd5/PexDBUmo9g7MykAXyQjKb03hhvRb4Vv+F60YD/1gJ7Fqijd+nQBxB1OcJIjR07coGr80QHP0ZS8KzsVS58FuB5rwrpE5bDiXRX1deu2IlJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=N8+swpX9; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ee645cf763so508096eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1731610422; x=1732215222; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ufhpjA/2LU07dlO5I+XHzfd39z4rT/d3jRzAPAKWts=;
        b=N8+swpX9vjUFKrVdffrYWK/O/DZLWmk5BbJhkCuYBrhKu0VeLueTVc3E8Q/wo2w4wu
         F9dHD/55guR2jMRpaeaK3YYDUan3nM/iWTqYu+LaeL7o1bbkGRCPDcOIA7XFHbU7ps6J
         erM0A2GYEOI+VRNWL2y9YZn0vXd1V/ih+URYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731610422; x=1732215222;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ufhpjA/2LU07dlO5I+XHzfd39z4rT/d3jRzAPAKWts=;
        b=Xcb9HP1fJUiUJX+MUaiLju7J74RAwkNSax/9puEkff2n+14cni5R1HSwiE6+R7+0BB
         9gfpl6FbGiPmgA25FnKv31rQDPsTOxKGRgTAtiw2VWSgeDp1AtHurLwZl4H6XQ252r2r
         A8SGl5D8sl0iUjrnLevYBfL8XGJX/CzIrky/1AjD/1Vo6C6Xsri1Av/6Sua84vUVwap8
         ixkhGsVL935kyPfdWsmoW2JgOtI0N/8NBe70xoL8xO7tC3aXHQpp4FvtGCv/YYNntwGT
         DAP6cF/4iyMGcKecT/AedYucrc2P4mVr/plBvuht5yoe/Z3HHkorVsr0nAnn0NJEojiK
         7A/A==
X-Gm-Message-State: AOJu0YyaRK1FPy0RgcC2svajRTjwEq8c2pmd9KIjYkDMDzNAkopxjaNH
	Jgp6Ko+z5s62LmuTFMKP7aWLYIax4JW21RralYBjEWbwPhUzfYbFTweTyjTsyCGlSWYSMUdRlhk
	DAFo=
X-Google-Smtp-Source: AGHT+IFOYEw3DZ5fccxnzFUneu9xm7/Y3MyJbuywIExFo1o0nHSHYbGCB7I5VP3iggEtrMYTFZpdWA==
X-Received: by 2002:a05:6358:7b94:b0:1c3:9adb:acc8 with SMTP id e5c5f4694b2df-1c6cd128fd1mr23277555d.23.1731610421751;
        Thu, 14 Nov 2024 10:53:41 -0800 (PST)
Received: from localhost ([163.114.130.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa19cefsm9089021cf.40.2024.11.14.10.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:53:41 -0800 (PST)
Date: Thu, 14 Nov 2024 13:53:40 -0500
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: syslog warning: was: Re: [PATCH v6 04/11] printk: Support
 toggling per-console loglevel via syslog() and cmdline
Message-ID: <ZzZHNIL6o0Ep1vfA@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
 <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>
 <ZzYv7SznkX34Wulr@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZzYv7SznkX34Wulr@pathway.suse.cz>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Petr Mladek writes:
>I see this warning during every boot because rsyslogd() modifies the
>global loglevel.
>
>[...]
>
>I am not sure if we have already discussed this in the past.
>But I would prefer the compromise after all.

I initially implemented that way until v4, but during the v3 review, as I 
understood it you recommended changing it to use !ignore_per_console_loglevel 
based on the assumption that SYSLOG_ACTION_CONSOLE_{ON,OFF} wasn't widely used. 
Maybe I misunderstood what was intended?

Happy to revert to the previous approach with warn_on_local_loglevel(), just 
let me know :-)


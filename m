Return-Path: <linux-kernel+bounces-409844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0779C926B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0246A2843F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2C19DFB4;
	Thu, 14 Nov 2024 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="mWhMMrE5"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B418A931
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612505; cv=none; b=kggOSpCs+e1eGOJvqXftlPCFDRgffjDlBSF6TJ8HUk92yxJ9qG+rLeDpPhhYDew1bOL/0/QqWWIMGWqrPP/p/GlGFEMlg9aN+pGoei3j1VR6wFX7mvglhF+/9t9hvVuiskt1xb2fpBCTS3uQJ6IeW/vPWj/vsiAldkH+ZO5jpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612505; c=relaxed/simple;
	bh=F7Mi+XMXZibhLFSPUsTjAjWl5op8YFTJDlUSlBUzySs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8Cef1DUX5gN2PC0ZB0LtYIg7Ir/IhY9Fi1B5uhJheW1vrYZMlC2CmgjLH7kQsIUncOJQIn/+r6jVTjWn8W3qcsxuAcucjrBs/Tv9i8gu1ZX4RQfL0nnaf+jPoSw8b8Lc3qJ5DGfXIKJIMl7e0lK/VauMPf9f4Pgz8IuEJj4zXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=mWhMMrE5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b14df8f821so71334085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1731612503; x=1732217303; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obe53CEzUW4cfZ3OgtlAtAeRMzZEw2tbXl8+grHrRTs=;
        b=mWhMMrE5o1F8MfeTHiAAIe5idyRWkF9SHkHTqF5gQRxrlCrNczQnth8Ypw4ftRAYjO
         wFD1eoaB9QvjtztZSNRMAt21E5wBG+uvYMunEl92Cy84dU273a+phuOk40rHttu4WqT7
         Yn5ltg92vTDZ0Ditq55LUfMmGruw+zUH6uNAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731612503; x=1732217303;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obe53CEzUW4cfZ3OgtlAtAeRMzZEw2tbXl8+grHrRTs=;
        b=kPC1ZJ8uvZzkwhhJ+NKQJMlboGzaMtUAVpq3NFwMTuvMDntlQ0Mm6UuWo+FMCvcNY1
         TL/nlBiVGM3eIuRafaXbZ/tuHlt9m44BdB64/LCa7FRf9iEcwBkJsx3DsgFkYVCObhTb
         E8JYlZYTcnAH1gxiftbac9TzfmfEF099tfnVKcJHAhVrqra9kCFhEoCQU6+JrbxJ8ePB
         AtR/0NMnvVBcBCvTFpFc8nBOL491O2d4NlbfUI/e6Vp39X0UV8yxO2GSyGgDMsWsVl6M
         JLLLyevhu9CcaNS5CbTS0RSzb2Sy2g3u0/taRQLmggA5piDLP8zPJSKC9EL464mxj2r4
         Rz4Q==
X-Gm-Message-State: AOJu0YzONTBJbCLkBOlZQ8dz9zWV30VIoMwk7BApM62tvaVKhFRn28iE
	xsPIvZZxUA72WbHLYenPSFq/UcwQx7bXkIrIIi9UM3Lz3LDnsMaECcvJ5PoKUq0=
X-Google-Smtp-Source: AGHT+IExsOCCQP++BLuw6D/sjhJPo9+xebQIah8xNRSiGImAapw9/8XUW/QBHRKSGFrNTIN87N0DMQ==
X-Received: by 2002:a05:620a:1a91:b0:7b1:572a:cd27 with SMTP id af79cd13be357-7b3622cef0dmr14182585a.18.1731612502980;
        Thu, 14 Nov 2024 11:28:22 -0800 (PST)
Received: from localhost ([163.114.130.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca67582sm81428085a.123.2024.11.14.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:28:22 -0800 (PST)
Date: Thu, 14 Nov 2024 14:28:22 -0500
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: Conflict with FORCE_CON: Re: [PATCH v6 04/11] printk: Support
 toggling per-console loglevel via syslog() and cmdline
Message-ID: <ZzZPVp8_ZHbGgn5z@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
 <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>
 <ZzM0T5b4uKIN0PM7@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZzM0T5b4uKIN0PM7@pathway.suse.cz>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Petr Mladek writes:
>On Mon 2024-10-28 16:45:40, Chris Down wrote:
>> A new module parameter (ignore_per_console_loglevel) is added, which can
>> be set via the kernel command line or at runtime through
>> /sys/module/printk/parameters/ignore_per_console_loglevel. When set, the
>> per-console loglevels are ignored, and the global console loglevel
>> (console_loglevel) is used for all consoles.
>>
>> During sysrq, we temporarily disable per-console loglevels to ensure all
>> requisite messages are printed to the console. This is necessary because
>> sysrq is often used in dire circumstances where access to
>> /sys/class/console may not be trivially possible.
>
>I have just pushed a patchset which removed the console_loglevel
>manipulation from sysrq, see
>https://lore.kernel.org/r/20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com
  
Noted, so would you like me to change this to be based on current 
printk/for-next, or is another branch preferred?


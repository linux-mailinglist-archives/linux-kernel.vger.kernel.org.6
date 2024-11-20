Return-Path: <linux-kernel+bounces-415903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7729D3DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD45FB2524C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2171AB515;
	Wed, 20 Nov 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PMbEnRBE"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A91684B0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113927; cv=none; b=CKqoR7VOlkyenewNx6f4zj0DkOVwBERjSY6amXDfQCF779T5EnTM3vzM5uyOSb0fGC+UkZaTrTn/o62XqWfqLgqfy0MuQh3422HrfixwZi95Vjbo7Nm1W87ScXeySKPhItkpPNMhAuB8gg5rk2kPk9RvcPF0BIsKN3A8EKbsX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113927; c=relaxed/simple;
	bh=itt3ykCXSp04bD1HY7ifpkmmieDGS5TkTnifzBexpCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcUv6CrVywiNP1IFW0/XQBC4MHmDTaRiJQ7/j0xcdD+R1AOeCbw3M6FpXzvq045hwH/Sub6nlaFoyc9XbvMR77JGn9bMO6aX0j6aExbse5vLtLqi2aEh+Suux8UObvxHGrw4dZQ5eKLCOHeo26KtLuOncB76cKR2XZEf0MEwIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PMbEnRBE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43163667f0eso39573475e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732113923; x=1732718723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsw+2ZqyGm2ytU+C3+p8h/86m2O0idGE19yYQgijiHw=;
        b=PMbEnRBEuSRps+ueKYQ35n/89KwOR+T2ZH+SGMX7yYgHDs9uAoRqtj79fqmGWKSuwR
         jCt6EAHsM3Cv87zys7pmO3N2qJmVOYDgZIgaUP2UMwDn7Eg3fprl2W1alNtxSRKf+hX1
         Si2tvmgBEwf5kW3HFc84horwYAJjhmaeKFhhKR26lCu6kCWpRN+U3ocN8HIv7ja956gr
         BT7dNpkZlyVcscHz6OMKXpyyUO8DG8tKuqInG62TibHqsId+xOwtp68ZVTjHVdsWov5Z
         VKKOTQhp/ASuOn9wO50QYVhjE0qWyGiCvcO8q6rS/rEJCpZYPxMRlQH29zKJgxKTUCnM
         kDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732113923; x=1732718723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsw+2ZqyGm2ytU+C3+p8h/86m2O0idGE19yYQgijiHw=;
        b=RF16+B2nKGhNvxS0ifONQOErX32bIhB+AtBrEcmf7sn4eLl9c5guaYVRsUtZGiqmli
         WV5HpFhBxFhEK/QRBH3aAbUwyNnanfeqJys+yidlEcoqrbbnlkcfCIw1POG5JO5Soo5a
         uwwQGk3Ld/epcnzfjzSG3KchpdaAL54dzsMn90uTNqN3ModIMRy7FE9AeGzw87sToQ/O
         FfDfwOemHzUgg4qYxIRTeg/LDN5bdTyhpS0Nn9eHuSv4LEAUk0XgFhNjoRwmRMGBJ/lT
         Lqtv/SCUG8++qri4fz87saMbHJtqS4gblVJBdmblUp0PkboqmjJ//j+ciYfapt6DPuZk
         llOw==
X-Forwarded-Encrypted: i=1; AJvYcCVIcb6x8/i/5p2WWcfMc303Hpjd5ATQ4mxMvjsfROa/huHBmDyHlUa5h1VTuymxhCAtXRt/hrqZyCsGSs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmNrZKncC4gpj8+ewXTL2Icsbl9MJUoplpz/SlhmLMKyrogOQ7
	vFrkfyPlROR/AQ93xP9B2Lnk3KV0p7qQsBolk5KmZZMC/f4jPtzG53ru1ENOo+4=
X-Google-Smtp-Source: AGHT+IHTsDtr37+GY/NVaATYfurLPl1dtLFxV/QhHOBHWevYVWU8krDxBDAu1Wi7DXHM0P/ojs1bkw==
X-Received: by 2002:a05:600c:3b0c:b0:432:d875:c298 with SMTP id 5b1f17b1804b1-433489b820emr28159835e9.14.1732113922827;
        Wed, 20 Nov 2024 06:45:22 -0800 (PST)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45bdba0sm21420895e9.14.2024.11.20.06.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:45:22 -0800 (PST)
Date: Wed, 20 Nov 2024 15:45:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 06/11] printk: console: Introduce sysfs interface for
 per-console loglevels
Message-ID: <Zz32AF4l3MZiQAzM@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
 <2024111508-native-subtype-2990@gregkh>
 <Zz1tOxW6PO_2OeSA@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz1tOxW6PO_2OeSA@chrisdown.name>

On Wed 2024-11-20 05:01:47, Chris Down wrote:
> Thanks for looking this over :-) All not mentioned points in this reply are
> acked.
> 
> Greg Kroah-Hartman writes:
> > > diff --git a/Documentation/ABI/testing/sysfs-class-console b/Documentation/ABI/testing/sysfs-class-console
> > > new file mode 100644
> > > index 000000000000..40b90b190af3
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-console
> > > @@ -0,0 +1,47 @@
> > > +What:		/sys/class/console/
> > > +Date:		October 2024
> > 
> > It's no longer October 2024 :(

I am not sure what people do. But I suggest to use whatever is the
actual month. I could update it when pushing the patch.


> What would you recommend? When I sent them it was, and it doesn't seem
> realistic to think that it's going to be less than one month from me sending
> the patches to when it gets merged, no?
> 
> > > +What:		/sys/class/console/<C>/loglevel
> > > +Date:		October 2024
> > > +Contact:	Chris Down <chris@chrisdown.name>
> > > +Description:	Read write. The current per-console loglevel, which will take
> > > +		effect if not overridden by other non-sysfs controls (see
> > > +		Documentation/admin-guide/per-console-loglevel.rst). Bounds are
> > > +		0 (LOGLEVEL_EMERG) to 8 (LOGLEVEL_DEBUG + 1) inclusive. Also
> > > +		takes the special value "-1" to indicate that no per-console
> > > +		loglevel is set, and we should defer to the global controls.
> > 
> > -1 is odd, why?  That's going to confuse everyone :(
> 
> I originally had it that you had to send "unset" instead of -1, but in
> discussion with Petr it was suggested to change it to -1.
>
> Petr, what do you think?

I personally prefer -1. It is a number attribute. And I think that -1
is self explanatory enough.

Best Regards,
Petr


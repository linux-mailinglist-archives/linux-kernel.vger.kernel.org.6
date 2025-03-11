Return-Path: <linux-kernel+bounces-556153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F68A5C188
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99DB3AABF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943ED2571BC;
	Tue, 11 Mar 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X0hm4EI7"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B112571BA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696817; cv=none; b=LC+WAaBntQ48kGdKfJAYwB9sedKQVkYYnY5l+V/Fb6HxkldLriN5bJnEoNiQSIOuII2q2frgh54jsg3QU4fmxYaiGxWtVEIIbgplNB48Ycz5x12sDSvlr3C33VL4cSyeuC72gEiC/gkQh4vcDR+En7FHPlPk9MSqyfNMg5igzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696817; c=relaxed/simple;
	bh=eFLglormP4BRNTD9McBheIkazL8hunpP5eO6YCoRoD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLHm4oN5Cko3+sZloKJ81MvdRmnJ4+sT1DUiovoVj2WSP4C4fx+5Z6vAHeZ/HUttoOOCPQ1O8FKp4bqLZZl/QXUijHUL6tXwM1zdUYw0iTv/i9p2Vu471JNk+fqN/kBbHiCP+ivpOvjiaBRsacB8jpYm27vncqYKj7F7BX7X9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X0hm4EI7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39140bd6317so1970811f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696813; x=1742301613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aISzCXBUSpl9Jdl7q1Wak8jR4Cx9Bei2SZjKv/F88EM=;
        b=X0hm4EI7PM4g/EBVtBGHE2kYgtPVj6vYqP0/VUrsQA1FSRTiojMeYsRNxAf61iPZLX
         mLSQS+mJ5FeiqKU0MEIuWNC8Yr8NbT9Qi0OZ5GAr67gbh0ocRTobC+qwZdqbn8EwFJ2D
         x2YAftG3oN68T220lo24HNP9Vc63BBl0jMF4m90ZnlbpOme0N5IX0VShW0MMlhodgCPI
         QMAOarzY8o06cQOtkh3w4EjWSSFigImIr+NiLxAJj7JwHlyuNbfongbuVSKXk/LUwMe4
         TAq2QnNKDFHOSOVNfLayZU6qLDrmECMsZufinD4gpE4hrKO0CSAauyRJNhzTW1ZDNJDG
         fspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696813; x=1742301613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aISzCXBUSpl9Jdl7q1Wak8jR4Cx9Bei2SZjKv/F88EM=;
        b=ElctF1KQjV245YtIEG0tOPAmDImNrXbNuVDJ0yLZIYKHmOqSkrK74vvyEezygRDgB/
         zMyUIqkefLSecdUKhNyryMbqxC8VLRvK+VHRB6xqnczUtgH+RUTL2AVU7be8cYoseB3Q
         6mRRURExxSHt1ewmCDBiI9dDPm4z6GZGAD0MWsC29MEC1FwsaLS9za+Ej/WXIY+p77Yn
         c7o2+ZmNp8covMA5aFPbXCDB8+jIFl1Qw8NmIjnSsz1VwnWdrVepHY/87riwTldkypVW
         S5+DuMUsmYjBaVD5AQYSzThNa7MgkH4k6bqpnOudBSAmlyW4Rs2uZN/qUL9d9hVLV7sx
         88NA==
X-Forwarded-Encrypted: i=1; AJvYcCUwBkqhdgLCRn2kYj89djdPwI3p/mTL3mGWXAG48rY7wpMmpOGwe/7W05GpslBouKjt6wQkAXsAPqUiW8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9M14U7AnQcjsQRTZDSYBGw0MEm+UdRlAB5haacKBJGD2BQuk
	gHy4aCkAf/K3TS91E3xB5fUbT3XxzDG2dyRuztwWtrkJa7HDpWyMApNrpXP3MK0=
X-Gm-Gg: ASbGnctGxAHkL9lWyaBBjE/YJ63Af37Ld5hHXJWMbD0m8rYkAZOHxSBZffskTuT0een
	M9Cghi9uJc0CN5jpyBJDPsO4/yv034L0z6mg700QcQ+EP1YVkPH5+hXJOQT/rtY48VaD3f9M9VJ
	S2OZF2TnilmZbYuvjnelg4z1lPE1aAyt2UHsdSyf8V7FCVnRbmk+SoJKCVEi1rlrV4948AWqbhc
	othOOjClHwsz9dfJZjDxmhP201lvLTgWxT0O5OcfxMTfJxi/myWyhi4dq9VBrau54RHBO04WTDa
	0+pgeJJY0y4Sf3+g1Cptb4841L5TELSKpavNeEKetAQADqs=
X-Google-Smtp-Source: AGHT+IH+hqLaIb0ak3/PDp2FI+P/Br6EuYDT0bw+M1n8JTY5wRGCazId9C1SCJxp8KfNPqmCL4R8NQ==
X-Received: by 2002:a05:6000:186b:b0:391:231b:8e0d with SMTP id ffacd0b85a97d-39132dc5632mr17143565f8f.39.1741696813238;
        Tue, 11 Mar 2025 05:40:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031e3sm17759906f8f.82.2025.03.11.05.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:40:12 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:40:10 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
Message-ID: <Z9AvKmM4Li57-E2E@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
 <Z9AShs1dEO0jrgjL@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9AShs1dEO0jrgjL@pathway.suse.cz>

On Tue 2025-03-11 11:38:00, Petr Mladek wrote:
> On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> > Hello, I've being working on some patches that help to clarify the suspend/resume
> > of printk machinery. The last patch on this patchset address one issue regarding
> > suspended consoles and blanking.
> > 
> > This is a part one patchset that I would like to see merged before I send more patches
> > that will rework the suspend flag (a global suspend flag istead of per console) and
> > the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
> > register the console instead of using this flag.
> > 
> > Please review!
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Looks good to me. I could fix the typos when pushing.
> 
> Well, there is one more thing. It seems that the simple graphic logger
> was merged for 6.14-rc1. And the console_stop()/console_start() API
> is used also in drivers/gpu/drm/clients/drm_log.c.
> 
> It is actually the code which motivated this rename, as already
> pointed out by John, see
> https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
> 
> Well, I am going to update these two locations when pushing this
> as well. Let's just get this change done.

And I did as mentioned above.

JFYI, the patcheset has been committed into printk/linux.git,
branch for-6.15-console-suspend-api-cleanup.

Best Regards,
Petr


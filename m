Return-Path: <linux-kernel+bounces-409673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E509C8FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4531A1F25EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9101B7DA6D;
	Thu, 14 Nov 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lx4AmKPH"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB48F62
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602311; cv=none; b=tyqZ5YvO2wpZLDqSUxv3+4+OrF5vfg5F27GULxGASvRUyle0+JC0x4sQSgGem0eSIhpknKSU37owFm1KVmhdZq4Pfdo49kg5pHi3pJxxOhKOqOMYNI3cEi0vSon1VYz6HG0fWHtc0+wntJm5LsUpYhPK2vccskdnYV8Jrcwebrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602311; c=relaxed/simple;
	bh=lqeH1zOhlOhBWaUc8yUdHwDldzrFy1lfpJt1bIlb5tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIAoOKzSSlw5Bga0Zfb79mDmOyLtXUo+gUtu+2srcwhuhjpzULm9gHEq+ZX/pk6NWxBtWM6P0UyQMCPJLQ2f1dOOPOlY35JHeNy0xxKy2YzEzZLIYLAFXge+OpMUbchmHc/xwnCMrIz5vN8StXwOtZjgcxSfgkqs5TRLru302I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lx4AmKPH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da6801c6dso727511e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731602307; x=1732207107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRu7zJYmMzVIcE9qc6qdQ1q4KbK1InSaWfP8qMtLhZE=;
        b=Lx4AmKPH17+L5xq7Tkyhd4d5KnARa2BsE0V6n6ikVviqiZdHzk1CFEzw4KHkIH+v7e
         DnCWk0/2Pzym2qXfGq6rI8OZZ5TzdKfbrMfvHxE8yJoniETv7AP7BXQShxNDJkhC/47n
         JLZfUQA0nEARhyl3Yl2E4fOl1f+7ySvqXs9r6w9Zi0+LIoL1gNIBHJYkx9bYWokJJke6
         3sG8LFgO8JpCr1XA3rYkNaseddaIvkHSwmvDSl9CD7qs73IfpyY+PxlNmVDPZGVAgDPl
         sJR3B8pGkzBmUo2/h47O5hVorlSwKMxRlp+zdDydgnpaRU4nrZHzJauHsimqLXpRW045
         ScMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602307; x=1732207107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRu7zJYmMzVIcE9qc6qdQ1q4KbK1InSaWfP8qMtLhZE=;
        b=TcDi7oHD5m8ttXyHMRhkrnFwyLBg6JFjFeiG79reJQJMx8fW8vHfucOp9zbO7cf6qn
         dH797gFmgHV4rqZzT8Bhtxp2Bg580IS/F8lS5+qEcDLE+SyfYmNTyncDU2gjaDwRSevy
         apQvHHnZeQd2kGSCYZOG2JgM6BwW3i01fXpbZHT9uh2Ey7tM9OeKGOZ0kjV1/oHOLWz6
         TTzAh44PbBI9KXx23uuRRCHBebsA2XPkOsuIZAsYyb2I8e2KFUJ8Q2PCJzm9WO4UatU6
         BjvetrutrRjLSV4JY0aMfTBMWz+pPeDUWBtRyfclZWKQjMBRVcKSamQU38X9C5xpaIe7
         bvVQ==
X-Gm-Message-State: AOJu0Yyms4/O+nerV8TjDmC+DNx4vAnU/MdA6MUeNA7dg0c41CXoK8QF
	1Glk/24dL1zvxolUCHoVPlwNuDmCjGXzcwj0tpNCrN73MN7Y/sMTUN02sjSfGfE=
X-Google-Smtp-Source: AGHT+IG+k7qacxiZ/K/ETIObbmqtJWnsuud2gGW16wZcxzpxu+sqzR6WcQBT4PFejLX35uRHzWMC/A==
X-Received: by 2002:a05:6512:3407:b0:52e:faf0:40c with SMTP id 2adb3069b0e04-53d9fe72e70mr4512023e87.3.1731602306845;
        Thu, 14 Nov 2024 08:38:26 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78918sm25491415e9.17.2024.11.14.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:38:26 -0800 (PST)
Date: Thu, 14 Nov 2024 17:38:23 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 11/11] printk: Purge default_console_loglevel
Message-ID: <ZzYnf7aJK_vyHjCK@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <3326b5ea5d95bd580c6e4dea9f5703d83e3f913a.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3326b5ea5d95bd580c6e4dea9f5703d83e3f913a.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:46:01, Chris Down wrote:
> default_console_loglevel (then DEFAULT_LOGLEVEL) was created in Linux
> 0.99.13 (September 1993) to power what we now call
> SYSLOG_ACTION_CONSOLE_{ON,OFF}. It was originally hardcoded to 7.
> 
> In Linux 2.3.12 (March 1997), Chris Horn made it configurable by sysctl
> through kernel.printk.
> 
> Its demise came about in July 2009 in commit 1aaad49e856c ("printk:
> Restore previous console_loglevel when re-enabling logging"), which
> replaces default_console_loglevel with the previously used
> console_loglevel. However, the documentation was never updated, and we
> still kept on telling users that this sets the default value for
> console_loglevel, even though this hasn't been true for over 15 years.
> 
> Purge both the documentation and all remaining references to
> default_console_loglevel. It will still be initialised in the sysctl
> array.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


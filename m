Return-Path: <linux-kernel+bounces-418365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D89D60DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3080B27EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97C1DE8A7;
	Fri, 22 Nov 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZxPR1yB/"
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929113A878
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287068; cv=none; b=WItGUI3yHRYsrBN3fYokTuG+H1AA43f0zzpUF0sAir6PSCnwvnWDwz5+UiQ1N7hwaSpTHum4jDM7VuQSh7pV02UwZqHvAHutkDfCyQHhDiNtHcum93eqQg8V37gS6HTgbWiwB1S/e65zQTTxam8fxcCce8y0DoRmuFb1nVXn7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287068; c=relaxed/simple;
	bh=da/B3C3m95B9xDN7inCPJver2jyI9WY4gvWq4YtWhFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOeQNWz5x/xGKi3AA/L+HEHBRtocUB/uGfZcLdu70Pm8bhaTJK11evpo/c8WuVACRIZGcBjVn83eqtUdZCxD9OHjGR0qGJXcBL+3fg9G8ySDCygt75NCaCbEeiRh1FTs73UGvTOcdMQcf4qxe/tzoCVEJj1JpXuGBuA3Twj+8fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZxPR1yB/; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xvyhd0W8fzbr5;
	Fri, 22 Nov 2024 15:50:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732287056;
	bh=Dw83SL5Y8yup9QeWhRY3Xv+H570yVpAemu+fQwUxJwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxPR1yB/99EMPpelBHdCWInnXjSxUxn8CxobKR87WOV/XW8j4P2i/WrLRNt3tk3Pm
	 PwdepQSQuLCaAzIfcdHDKM5tasTYMdPYLpz5ZRscRNi4N8kGaH50/8TPen3EyKDgJ6
	 Cu2uU2k/vW0zhArwJAuMwtubKMwDV38J+e5CnuqY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xvyhc0l95zs22;
	Fri, 22 Nov 2024 15:50:56 +0100 (CET)
Date: Fri, 22 Nov 2024 15:50:56 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v21 6/6] samples/check-exec: Add an enlighten "inc"
 interpreter and 28 tests
Message-ID: <20241122.ahY1pooz1ing@digikod.net>
References: <20241112191858.162021-1-mic@digikod.net>
 <20241112191858.162021-7-mic@digikod.net>
 <d115a20889d01bc7b12dbd8cf99aad0be58cbc97.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d115a20889d01bc7b12dbd8cf99aad0be58cbc97.camel@linux.ibm.com>
X-Infomaniak-Routing: alpha

On Thu, Nov 21, 2024 at 03:34:47PM -0500, Mimi Zohar wrote:
> Hi Mickaël,
> 
> On Tue, 2024-11-12 at 20:18 +0100, Mickaël Salaün wrote:
> > 
> > +
> > +/* Returns 1 on error, 0 otherwise. */
> > +static int interpret_stream(FILE *script, char *const script_name,
> > +			    char *const *const envp, const bool restrict_stream)
> > +{
> > +	int err;
> > +	char *const script_argv[] = { script_name, NULL };
> > +	char buf[128] = {};
> > +	size_t buf_size = sizeof(buf);
> > +
> > +	/*
> > +	 * We pass a valid argv and envp to the kernel to emulate a native
> > +	 * script execution.  We must use the script file descriptor instead of
> > +	 * the script path name to avoid race conditions.
> > +	 */
> > +	err = execveat(fileno(script), "", script_argv, envp,
> > +		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
> 
> At least with v20, the AT_CHECK always was being set, independent of whether
> set-exec.c set it.  I'll re-test with v21.

AT_EXECVE_CEHCK should always be set, only the interpretation of the
result should be relative to securebits.  This is highlighted in the
documentation.

> 
> thanks,
> 
> Mimi
> 
> > +	if (err && restrict_stream) {
> > +		perror("ERROR: Script execution check");
> > +		return 1;
> > +	}
> > +
> > +	/* Reads script. */
> > +	buf_size = fread(buf, 1, buf_size - 1, script);
> > +	return interpret_buffer(buf, buf_size);
> > +}
> > +
> 
> 


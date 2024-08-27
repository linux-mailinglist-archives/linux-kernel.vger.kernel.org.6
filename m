Return-Path: <linux-kernel+bounces-303268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F19609F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE61FB21176
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A241A0AE6;
	Tue, 27 Aug 2024 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ec/ZnRaB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6E19D08C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761276; cv=none; b=i4kfsj7LI28K5197bu/UgJU1ioac6D50aGxSkboyLMpxvbO3GPmd0UzyVsZ8YQjgKdrkCAk/LuI4FVMsAc5DuGHNhsCVQM7HcCYJDZ2xwDZlyP06ab1l58GlfCL3q9tWw7ydIK4HeSStE9M5yyIlN48WPOCxXa5U3vzOqvQlnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761276; c=relaxed/simple;
	bh=zqP7nmzov1dbLqfLz7+Ykop5fNFzzyMYWDULnqtJVvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVoGsGHxhPBNysFo1XpNromN6PF7E0EfSu6qi6X0RwLFds12xpyEaHztTbrNKZAdx9RasEcuqMSNFSs1NvyynBRWhbUQXnC0CC5Epfqfvxn93B2RDkOGoc2byE+VP6HVGygJNAf9mKeMsBFzZtt1rGcok6aLPr1Vn6xxtYt/0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ec/ZnRaB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a868b8bb0feso595315966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724761271; x=1725366071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESGuVDgjoV+wHk/fIbDXqc9sSVQ6KI1Je89U0UjUKnE=;
        b=Ec/ZnRaBAt6Vw58u5cRvpa/t20hh0FNjzSMIEgZ3n7sdDnsfEysXYGdSkaq+dTiiOc
         QSVcSHKJPYenN885gxj8yJ/+exKdBdlGBVjrgBivUJwe590oV8jWRmUcm34IwUNQH9cH
         4+xZNo2FGU8s9oTUsQHTHeeAMl4hR/PCp/v17ENs40NutFgenkDJOb+0UD1EEfmLBRKG
         J9iKS9d3ZiQinczY0GgYhpWzSgdsfWE3gmZqSwkw+JC/i8x1LOMMZzq0HHjEpIGXsqIO
         At54zn8Ffq0p3do0r9rrRizM9EbsERucPbWiNp2A9Y+HBpwiFrvwDPyIbQiXAtcmhPNe
         1IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761271; x=1725366071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESGuVDgjoV+wHk/fIbDXqc9sSVQ6KI1Je89U0UjUKnE=;
        b=dB7NC+0e/UActqPPoZxFye7LotCR4MavEXZVZerMpgexcfCn6JSTgmdPn27w78VQUV
         ePJGU6c/r6TEvrXYpe9oW5En7uuHOkM7lnsCkRKFOCrOanyEfxNy1VVY7perbEbAzRc6
         94kfClQyaN0rJB57WLd0F6F46eWBY1HspPb/l1AkEq++r+Pcny7unvVa0ROP7jasVzMx
         W/M0IY4F0hFOPiLjEANNLmyZfpE83mNMBWlPuNJSOIfUf+JIcOM02yPbziDmxRK4beHR
         JjISsHbwIaNDe7vP1aRNNbXflHmVq9zYn/QjtB5fmuTuaB0x96BqCzj63tHUmktQT8X6
         mvnw==
X-Forwarded-Encrypted: i=1; AJvYcCXfuZFHojqznDn7L53R/Y0kfgmjiBcJfsFKb3lNwghV+OBx/0qR3rTyCkTJ/pOSLRHMeKOaX77kFv5MHkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UlXsvm7mR8Qpd65x/+LiIWJBPQZrw8gRXkKAFE7l/KAPe9Ut
	ozmogjzHuh+CP9XkkqDakvYifhXvi1lKtj4FF+sjgI9w7fIAxpEs0UQppOBN1i8=
X-Google-Smtp-Source: AGHT+IHaNtFHT72LPlSK9saIx6YWp6jDZkM2cJ5GDNfKoU972aNgUqXgTPwbdqo/1QnhlclEOjCHEg==
X-Received: by 2002:a17:907:983:b0:a80:f7d8:5bbe with SMTP id a640c23a62f3a-a86e35a9b1cmr221376766b.0.1724761271098;
        Tue, 27 Aug 2024 05:21:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e591c015sm102632966b.191.2024.08.27.05.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:21:10 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:21:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 04/17] printk: nbcon: Add context to usable()
 and emit()
Message-ID: <Zs3EtcYLJgOeZrTs@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827044333.88596-5-john.ogness@linutronix.de>

On Tue 2024-08-27 06:49:20, John Ogness wrote:
> The nbcon consoles will have two callbacks to be used for
> different contexts. In order to determine if an nbcon console
> is usable, console_is_usable() must know if it is a context
> that will need to use the optional write_atomic() callback.
> Also, nbcon_emit_next_record() must know which callback it
> needs to call.
> 
> Add an extra parameter @use_atomic to console_is_usable() and
> nbcon_emit_next_record() to specify this.
> 
> Since so far only the write_atomic() callback exists,
> @use_atomic is set to true for all call sites.
> 
> For legacy consoles, @use_atomic is not used.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


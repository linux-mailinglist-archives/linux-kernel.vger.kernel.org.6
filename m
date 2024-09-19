Return-Path: <linux-kernel+bounces-333493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E1597C996
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CEE1C21A67
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361FB19DF69;
	Thu, 19 Sep 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hq6aECeD"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6E19CCF4
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750675; cv=none; b=HG/yedplyJ+jRJwvo9vlarkM91FL0nCuj0KUoA83yHmpEerf0xsaQZbCQB/jtRPtaQKTuS3AJ5DacXWlZ4OZm8qfcJeuqi8gxxXjsk1exTqX5mgyZudMXVTqJKE9NhSTFyWzy9afiSd12XJ6hZ5OjqblTVkRPWmNRlScCXeyoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750675; c=relaxed/simple;
	bh=76ELJO2trC1AW62eOoSKaxfwlQZw6rut1Tua7Zv1+cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ4DDzKcOcATsuOdEOwlMGVXpACxzhNs3rKuE78iwzDVxFZ2zShdPQbvd9VuEK7hCoiklLqQUXXryUjwxFsJAFqu8wPyXT57wkaXJi4BL1GG3pb2Ecu5Sr6wKTm+T2XLVU0uBWzt6a5pBS1IAw+wlWtDUQy6rDInLzrEfQSCB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hq6aECeD; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f759688444so6624241fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726750672; x=1727355472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fpL5nrSfWFIRQTaDmvo3b1v9flOhJaDZgUF3bcUIUyc=;
        b=Hq6aECeDvaTnhEO3mmxdMBndV33kFS9r3tIOjTPHKJhYr8F5fkIr+Mq6pQrzKyla2z
         EHruX7MZthDo9INLHrVQt68rbnPBdFS4NatQvpLxdM6KjI3iFRuX3QheXxj+gju5WIxF
         j8pUQb34ZpsrZNZbZ7fYFzf11wgamM9+AdArUeQ55CgjkbHgATbYLKbnMEvYf5hSjIKr
         mUgy9OwKkd7xDDtD2c5UB3+V9tvKpka/49blNKvhFknQEvZpiMyMLgqr1zl+rX14X0vM
         O2PpJ0u/4q61UajfvVS3BADj3lHRxLuVrasJHI3r6OgaZwahYWq4pySaDtFif7RmtKVA
         EjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726750672; x=1727355472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpL5nrSfWFIRQTaDmvo3b1v9flOhJaDZgUF3bcUIUyc=;
        b=thy9Q7BPgOPH+VW3MN7E6Q/bXY63FZLnxCfoJvp+GWr0Hl8mQlh0j3Skyv1UNbyo8A
         7orc3ktSkBoe+Ol7CLgBV+S/Wv6zR/pMJ+/Tl2fXiFGiSfwF7L8uo5NdqxoVD9jPNzKu
         uTddLbkrAOHFimN9Kjku500AOewKdYr4YQJSdtoOvWol6EygBaFVjj3C1s5wUB14eoPu
         C4PZmzD2e4rAVd/hGblJn2UJv+5Bed8I6HeNZlng10OEnuEmXeAayJCVCRReWo+eLQF+
         +LdEZBE1U4vK9GqFUE2F3nliTapig5UXQ4Wu8vmTs7yE8Kdixpjv9/qoIXJwoFzNMhta
         IvoA==
X-Gm-Message-State: AOJu0YwxFxaxVvwzPk95oKQzIHbKa7mlgn8I2g5hOGaBPt6hwTLpcXc8
	DfXe5IppOtRhk5XCzLdhKJ/jV8PCGEPgL1eW3PUXxHwbAp13wy9FOS5olTd3bmQ=
X-Google-Smtp-Source: AGHT+IG4h95qe6GKSksmnJpvKJM8XOEJO8HMQY3bFlHGG7ixgB+TFNte/YhFDrha1wGPiRsX+C3SXQ==
X-Received: by 2002:a2e:bea6:0:b0:2ef:22ad:77b5 with SMTP id 38308e7fff4ca-2f787f447c9mr138932411fa.29.1726750671610;
        Thu, 19 Sep 2024 05:57:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601017sm79331225ad.85.2024.09.19.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 05:57:50 -0700 (PDT)
Date: Thu, 19 Sep 2024 14:57:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-kernel@vger.kernel.org, Raul E Rangel <rrangel@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yuntao Wang <ytcoode@gmail.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] init: Don't proxy `console=` to earlycon
Message-ID: <ZuwfvyiOMAzciZX2@pathway.suse.cz>
References: <20240911123507.v2.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911123507.v2.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>

On Wed 2024-09-11 12:35:14, Raul E Rangel wrote:
> Today we are proxying the `console=` command line args to the
> `param_setup_earlycon()` handler. This is done because the following are
> equivalent:
> 
>     console=uart[8250],mmio,<addr>[,options]
>     earlycon=uart[8250],mmio,<addr>[,options]
> 
> Both invocations enable an early `bootconsole`. `console=uartXXXX` is
> just an alias for `earlycon=uartXXXX`.
> 
> In addition, when `earlycon=` (empty value) or just `earlycon`
> (no value) is specified on the command line, we enable the earlycon
> `bootconsole` specified by the SPCR table or the DT.
> 
> The problem arises when `console=` (empty value) is specified on the
> command line. It's intention is to disable the `console`, but what
> happens instead is that the SPRC/DT console gets enabled.
> 
> This happens because we are proxying the `console=` (empty value)
> parameter to the `earlycon` handler. The `earlycon` handler then sees
> that the parameter value is empty, so it enables the SPCR/DT
> `bootconsole`.
> 
> This change makes it so that the `console` or `console=` parameters no
> longer enable the SPCR/DT `bootconsole`. I also cleans up the hack in
> `main.c` that would forward the `console` parameter to the `earlycon`
> handler.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

It like this approach. It works well:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

I could take it via the printk tree for 6.13. From my POV, it is too
late for 6.12. I am sorry I have been busy with the printk rework :-(

I am going to wait few days for another eventual review or taker.

Best Regards,
Petr


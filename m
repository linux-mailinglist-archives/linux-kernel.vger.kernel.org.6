Return-Path: <linux-kernel+bounces-261051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F194993B232
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0079284933
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16974158D63;
	Wed, 24 Jul 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TTJ+tKYM"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB22613D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829736; cv=none; b=RAsfGzwGQBhvc52t9IR/e+25kgDUvnixk22g4W1u59pcC5vVGXNTmzKccWRT7GZzmlpaBtEvk2UzrM4TeZf7IsFC+Rq2aQ5pBL1FJcX9CNWdBqN62xElp+z/bcG0hOOKCw5nbJnlpfFay3K9wdmv+ZFKMrBhmx2xcyRpobwV0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829736; c=relaxed/simple;
	bh=wGbOuea6NOYUqz/tr1aRIds7z8JFvKE6US9qQL9rVoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxqtB+KRurhikAzWyqbIpvtN773mjCVaRA1r9PNqA44mVdMvf8GKA0xKn+Oei3fakn2AL4cypDztumgsT6qGsBXWPAlDuSWd5nzrpywDK7n9pd37BY9HQNcWta3DrVC8hU2Zy+Q3X5PBj2ifubHpGIwTbqtExo/kgD54MWoVZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TTJ+tKYM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f04c1e58eso4640403e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721829732; x=1722434532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03Mi73DYQ+AbiAWB0TbqqqyX+xcerskNuxokfmAHRtQ=;
        b=TTJ+tKYMguH+v+39GYlVEN6WkN/Pbi6VOE07xaPtXD8r1c5eWJVUmzeLSvayYCy+oL
         F0Oa5iuhH6uD7ZqTCo91cs9JUj56MImYTa1AIQOraOCXh+sECSoH3854kDvNMExhLR8v
         g9kmFfDCzRYL84/6VpPXCa7diO4qdj9Q7HSepwYyKsJBmI++/kgqRi8gqLSYnpwL+R9z
         P07ddqpl38f1g7kX4JiE1lSosjNJXsHw+wIdaG/oFbNlTIffAY6ZqpN5rbTH99asxuUn
         GMK1nZ1ixCa/mYN0pn2IS0Z4N4Qrzd/PNNA5vKS7DHATaEYd5+luzUv1X8Guu/WS/zsB
         RR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829732; x=1722434532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03Mi73DYQ+AbiAWB0TbqqqyX+xcerskNuxokfmAHRtQ=;
        b=H0WoC2yzUd6+Xp8Cslk/GiPMJKfSM08wpysy4b7pDrI+cwPOTtwCeFhwbWiuVMgPQm
         hqMBK2MRGZKLfIGLiRg/chx+aafmzfs1KnyPxDsOe1oVY7HwQzsSZvIiP8EK/Nx69d4+
         L+uSJROUN+helnWOQjvKf2ALMfoQn58dIlm18eYhMRJhvwjwsMh30pqM79RGTu16oGaq
         iE8VsxTiO+55plVfRP75h6bR6BiPL8AwUuHgQvCTGFHnc5YtltXZZKMJ7L2PnxUQnWR2
         En7zpWercwTr59PD7glDZeMnpnBI8xv7zKy/4caEkM1+/hUP0eHYCKS2aUQUKVbS5JWX
         4LBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVquRws1kGnr10/clU3LHbnICNIlkcduA59vIXuBl8zsJs5mxumB1JVd4jQp9EgtpfZAza3ndr8q/u82zPE9Ijn4JXTS49NUqY0rLXG
X-Gm-Message-State: AOJu0YwIi4+YCzt0VPuvfBFKksqyDIO9Eja4eb5fpbQwhVgoV+GP8+Km
	pwbM5kPJiJ5nW62lbYxy2+lIKnqaORJEn+Gd/um/LYkn995TcRzaOrNqHXlOY9w=
X-Google-Smtp-Source: AGHT+IEut+zftTEoUgoGJWMwhaJAFLWg/pjaiJRLKgG/u9m02dE6H+2MerckWbRJ73b6hEaScPDGEQ==
X-Received: by 2002:a05:6512:4011:b0:52c:9877:71b7 with SMTP id 2adb3069b0e04-52fcdaa8ea8mr2910247e87.59.1721829730773;
        Wed, 24 Jul 2024 07:02:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8c0218sm646875566b.128.2024.07.24.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:02:10 -0700 (PDT)
Date: Wed, 24 Jul 2024 16:02:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vsprintf: add missing MODULE_DESCRIPTION() macro
Message-ID: <ZqEJYJScuEJpo778@pathway.suse.cz>
References: <20240531-md-vsprintf-v1-1-d8bc7e21539a@quicinc.com>
 <ZmmG_dQaTpq4TkGE@pathway.suse.cz>
 <9614c130-d90a-4023-87fd-0b3b12516021@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9614c130-d90a-4023-87fd-0b3b12516021@quicinc.com>

On Tue 2024-07-23 11:53:34, Jeff Johnson wrote:
> On 6/12/2024 4:31 AM, Petr Mladek wrote:
> > On Fri 2024-05-31 19:42:25, Jeff Johnson wrote:
> >> make allmodconfig && make W=1 C=1 reports:
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_printf.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_scanf.o
> >>
> >> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> >>
> >> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > 
> > JFYI, the patch has been comitted into printk/linux.git,
> > branch for-6.11.
> > 
> > Best Regards,
> > Petr
> 
> Hi Petr,
> I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
> Will you be able to have this pulled during the merge window?
> I'm trying to eradicate all of these warnings before 6.11 rc-final.

The pull request is still being discussed, see
https://lore.kernel.org/r/CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com

If the printk rework part is not acceptable then I'll send these
trivial changes separately.

Best Regards,
Petr

PS: I have sent the pull request late because I have had vacation
    previous two weeks.


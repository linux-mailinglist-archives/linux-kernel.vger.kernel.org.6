Return-Path: <linux-kernel+bounces-182259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DBF8C88DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A5F1C20C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4166CDCF;
	Fri, 17 May 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yfnw/FDz"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30116CDC8
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957731; cv=none; b=d4j3Xq/XYVi8CbbAeG3tCi0qp7N1ljEv99ikgSd4jicAqh/9XBIR+nrwtMNRIKGi+okE6z8wjCuZRL+6c06PZZjRbfUghIVoAgqco9NGAVOnM46muCSr1WMkh3X+id+V4+rF1S9J1AjgMeQj/PQUtRrqHhOuV/dbgV+OseIU6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957731; c=relaxed/simple;
	bh=4AIZl25R5Unl610mzuXwn3kSDloG6vVF/8Yo41fLbnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN5Zf65XIS+8TcHnqGA6flqb4JAvhmJoQAdNwjtBGNRvCrtjXSpn3b3T7k1rDR6fuaZrl9MGBhQ1UuMKTsJWKXtxjNvfkp6ls+B+ZZ9Hx1ItJfqrxxiTHc5kIXKkkALCECXwQ1zU4QCI0RU1wQnyso7L7F9ybmE21uhSvwM1DMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yfnw/FDz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e271acb015so27127011fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715957727; x=1716562527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLG6EOpwjYm1F4We2llMufvd5cMuzZw1+H13dITQCjE=;
        b=Yfnw/FDz/J790i+HtA+d0XQAJ1v0ojE3MYyKQFYPeg8fy+4vzOYykouP6R5I5D3qTh
         //Mcmzz+7fEx2950u02bZe3mnPkd3efIdOtqVwRN18BaySi2/J6mRyMDBkwA3gDeGRLz
         VwCOYJf9zp36rSvxOpop7oyhrFsLsDAbV0yUgyZx/NhsQtA6h6VXjdRXwNpOlE+Ogb1f
         LQH2F0VO7u1YY+2y7j7DXwQb6u5+cZk5deCERSR8SdTHR20QW4XQwWkXQ9bA+LkGQsBQ
         6ZKfx0IfeFOPsb8zCJPkmu3OVk+VUJ9Y3CwgKarzqC5qvOdZ7zRtwwHNkqda2MAwJnmP
         wfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957727; x=1716562527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLG6EOpwjYm1F4We2llMufvd5cMuzZw1+H13dITQCjE=;
        b=m5KLUtDYeeldPXwf9POz/GLD5UIUq8gs93OqWQABOkdKtUhsli8LQacHshEg5bGivf
         MkYAjYfey70hpjTWGVBo1TbmZ23WRaPbF785Vf/8wEhKhic9l2I89T0S9HZL2fKwB4h8
         GdP9+E0rABb33CY2jksQ0BzmLqejldR7icKm15zHpDVSVCgnMlPKMNL9LDRbhNi2qSFk
         icPkq4PaR+BV01UTAvn/uzNxE6pE4x/1nwFrSz1q5e29g9C8psZLCZ0O60g2we5dKa4F
         1bEil2ORuGwuwoHGvcfKWFO2KIhX6NIMB80m57INuqAyj2HfXJC/kbCfykPIo2gK5Rnt
         Oojg==
X-Forwarded-Encrypted: i=1; AJvYcCVqlCiarXvp7YDJpY1GwneUZcxPAj8lGOTfNxD3SckZH4hkSnY182mQJB1PBFAtD6AK6w1+ZADcVR0dUNyczvJtMZ7S+HE87lUHuDHF
X-Gm-Message-State: AOJu0YxeyMDypzkBnskQKsRFqQ3lr9KqVVgWjap+iZCkI++LPGe4tRMM
	m/s47QgXs6VnAnii1nadq6I6l5FgztK26bNvp7moJWLLAyPf5AsKDyQMUNdQZdA=
X-Google-Smtp-Source: AGHT+IE0igap5EiffpCF8kfgcOv9EsfFGBLBjt4XSf1N9O8xdj5M6Ff+zKTB9RqaNwB9WEAAhyMH6g==
X-Received: by 2002:a2e:8748:0:b0:2e5:6795:f556 with SMTP id 38308e7fff4ca-2e56795f5edmr135982211fa.43.1715957726902;
        Fri, 17 May 2024 07:55:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42018b5e1e8sm174210685e9.5.2024.05.17.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:55:26 -0700 (PDT)
Date: Fri, 17 May 2024 16:55:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 10/30] console: Improve
 console_srcu_read_flags() comments
Message-ID: <Zkdv3QjzaXUBRg1I@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-11-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-11-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:19, John Ogness wrote:
> It was not clear when exactly console_srcu_read_flags() must be
> used vs. directly reading @console->flags.
> 
> Refactor and clarify that console_srcu_read_flags() is only
> needed if the console is registered or the caller is in a
> context where the registration status of the console may change
> (due to another context).
> 
> The function requires the caller holds @console_srcu, which will
> ensure that the caller sees an appropriate @flags value for the
> registered console and that exit/cleanup routines will not run
> if the console is in the process of unregistration.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Sounds good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


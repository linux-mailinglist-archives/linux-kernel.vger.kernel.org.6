Return-Path: <linux-kernel+bounces-400186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0529C0A17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC1E1C2217F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7062F2139C9;
	Thu,  7 Nov 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BIMFfSZJ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA038DC8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993261; cv=none; b=SB/Y/E0YMWWZhk3nhRMkKfBiNUVddlt9L5Oex3xEAd+4f4H35YzGig6DcJQgjkTB3CWO5T1A1G5ADEFNdq52rMtQfBqLazFslPsIRILHUAhFnGZRAaKVzomtrbuLxvbwsx2PHIbsOKMpKpVi2aLGzxEyKW76dZNf92D7dsFg/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993261; c=relaxed/simple;
	bh=yeEs8ewcT1y5GOWSZzmD4QBXT7Wjzlhjh9Jhri8akIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwNnqpRywz+MfORIf22uEO2ht/4dH4I6BRsc7YWYJ0mnoK3iu2e0MOEIrO7GATPNFsrh8U1GxUI/GfBokZE2yRHomO0JV/k3YaLPy1K/pTCoPvPpLsJUBxL1SCIHPg6OX1XZXWRC4AnEJMBBHL1+HxkdZuowGfHOnEZbHs741oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BIMFfSZJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431616c23b5so6930375e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730993257; x=1731598057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRf6zRXQpzxdtNWRFDWwDeLUqj/9Qnay3bDxbM8rYgE=;
        b=BIMFfSZJSjc3Gg1cSeYQv48X1zqtmJpCF3R395C4PLDqDkeSHwyjcNB7Gv2qI1ZcfI
         jugajtMZxumCDzRsz2W/PcJE8uw5eVAPhVK98WWaB2MEx+UZe8K25o+E7y17Yw40YI2m
         tnJZUHZjCGaFiBOmBB+f7puCtOIGAduKa1mVg4nutuTPpb+FSkSE8jZa9Ew5p5LX8Pcw
         w/d3mv+cCAeUubC/rH6dyENtJMGgOMXa+so91TbtB3HXhiyf4Uo3wf3PagpAr413JAmf
         R4PkvnI5L7xKQvT9bIqYmI1MMnTGk1jbCNcZly820ewXJSgvYlrCi6pM4dmkbd6CbuzT
         QLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730993257; x=1731598057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRf6zRXQpzxdtNWRFDWwDeLUqj/9Qnay3bDxbM8rYgE=;
        b=KxMkuVeZLVwBdFCahIKRnz1h1GjOUDcQwTcwFQRJKNy1gkviYKrtfxI+DiJ/JkAug5
         yE2YddK1pfjLSVpIRXQszGYJVAv1TFvz2hI/0QWFcdi4lkIFQkweB9upxyc3gooGnU6F
         brw54snHByrx3F3WIRCl4hE/zVIkPD8dqS82Tj57cltACErBIPftq3qBe9QhVPtTWAFs
         XMAhoCNGg/H4Yl9SWlaK+R/Zh//dWNpWvhWYMknK6+W9Nb9ydNlXG1uZyC0AVgrGEEnf
         dR41Ztz/Eaouk1Sk8UXqx2GFsCuRvpe2uRusYmc8AoNiFgyOTzaw8Ct3EIPDh2eIdrBk
         XhLA==
X-Forwarded-Encrypted: i=1; AJvYcCU4yOyixvJkU8VfNmImNhSuf/Yr+TcM3pcXKrZHNeGt/C/ooUChrcVkNlLuoyKcdchwscheEqFJ3Iyk64o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPndmBoOuishBiEeesFrw7uTH/xxSjc9PdTp1d3kl8lpuvwekx
	SLBXHpFTk9SUQuB3vghGwHF6vA/06LOk+iJf6bSLURrcVtyL2rdLeW4yWIy6ShQ=
X-Google-Smtp-Source: AGHT+IG+kN+CsW6tgOY32VUnqA+N8WhRRJS/ykFS7g26dVcf3olFI7/ILrD9W+sOKvYmLQRqPPGUEw==
X-Received: by 2002:a05:600c:1c85:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-432b5f9be4cmr3793255e9.8.1730993257414;
        Thu, 07 Nov 2024 07:27:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b34csm28978925e9.14.2024.11.07.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:27:36 -0800 (PST)
Date: Thu, 7 Nov 2024 16:27:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tty: sysrq: Use printk_force_console context on
 __handle_sysrq
Message-ID: <ZyzcZvQQJ0YHWTk5@pathway.suse.cz>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
 <20241105-printk-loud-con-v2-2-bd3ecdf7b0e4@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-printk-loud-con-v2-2-bd3ecdf7b0e4@suse.com>

On Tue 2024-11-05 16:45:09, Marcos Paulo de Souza wrote:
> By using the printk_force_console the loglevel workaround can be removed.
> The workaround existed to always send the sysrq header message to all
> consoles not matter what was the current loglevel, but it won't work for
> deferred messages, since the loglevel can be restore before the message
> is printed, suppressing the message that wasn't supposed to be
> suppressed by the workaround.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


Return-Path: <linux-kernel+bounces-170078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAD38BD198
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2481C21D25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A00155341;
	Mon,  6 May 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cQFpOZH5"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14BB15535E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009796; cv=none; b=s4w9GcY0BGGIk39pWB0t4/SmTDxN0WPdbwmda0YqVKw/XW1SZi9WKtvgjj474iCot/f84cQMd8sIwGiEnShWjFbLIDuZqG0wJYuyOUFcXog53YCA6mZg9x9ffoVElEF3mp5YSNHKDGxuNosFJXkYeAsPIArbe6041i4TxePZc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009796; c=relaxed/simple;
	bh=okolZHTegM6x+ttsho59LkzT+8+G6g01I/qGFOeSb1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTK5+oqpoOWnnL9glmWMoJdtwaYRa7EY9kmsuvCjq39Z9LcIP8waZ5Hf2d7yFD5UCKnNsj1qUpwBW53RBxoOMVzzNSG3qOJY7IW/aA+y++ji7gXu3NX7zzQsLnyuwd7ei7CUOryw0QO9ufx1Mms0qCxNXyJtzcO1ScEZV0KTAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cQFpOZH5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b79451153so17563485e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715009793; x=1715614593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgNpmP+KnJqaBxDJdkx9mmwg/WMduzGDywLz1udliyw=;
        b=cQFpOZH5Xpzym7IOsT74wRI3xbCyAlwMdjKhDrUwSQkh3C6YmrBWl84NQNRZmfINMs
         JUkE26V2JcrNSE5moXI+qSVg3YcsTvo9jXI6QLvk8FNOuOeAw6A6o+L8HjozxigwyYp/
         k4k1wYHcFVbmvO0DJlZNG3Q8s8KWLlY5n+MpkhY7lPwIcWlPOixgRrQXxFpnPU7Nburh
         Gj3SCMhK2k+yLHioZ372OOb43rKXJ8I4nw6RORWJGV1tToFgzHdCLYx5tLw0w+Yj9o4L
         riur0ex102/RYl7UW8fwIdSUVGbC1GBT10VyLWXDchWzg+ObsTMF8l9HmFXmiyS0PHLp
         ZDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715009793; x=1715614593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgNpmP+KnJqaBxDJdkx9mmwg/WMduzGDywLz1udliyw=;
        b=LL1PwlUI2lvc4jf1KUAAl3LKK4WiAY8hCWgd+FqU9VhllfFGG1GYrQUkOGbeqUnv4p
         enzoxOQ7CqJLDHhN0dPHkc8v0G9rFu/llPNSSk/af80AnNoqj8Zw8Br2YiPjqDAVa5mN
         NpMV0vXO9J4k0vZ4rl0ScjKmd02sLupd11xVNu+PqVLMz0ocUP51oOsID/dPr/fbm660
         bAL73iHaY57KINZsH1S3TE0/oykqgrB0bIxa7Gh0oYtH39Jx5syIBemHv42nEAlqAwiY
         Vld0k8bKKG07EcoqUUxbnLHs1WF7PZzkD7d5KofKZ8kHbbcS0wNpEaCJdqgThHltwMDb
         QB6g==
X-Forwarded-Encrypted: i=1; AJvYcCUq1thKuNbq3O+BVFIP1Q3tCxl8oJmAvIPNI0EAn3ocyHlOrYLwBJHNgf/6ha8UPwJYapsw9aoWkqb0+xoVmuxMTjIp3MDQjbj81XTQ
X-Gm-Message-State: AOJu0YzZrQy8jowq69JHJoiMnJeC4EeZjnTl5NXPXsmiIJt15Pm3C8Nb
	pCz12KxcjcQ9OnBT0Cs0B1eFmSrcTC/89gLGScaKAiGpRiMkpI1EJqxUQT/Hy/g=
X-Google-Smtp-Source: AGHT+IGbZTNMLu6hbhyt1bmjEn3Jajf73supUMbIrefeBp7HlOrwI13gU2mgVw4zZHXxgYrif3Od3g==
X-Received: by 2002:a5d:5742:0:b0:34e:3cb3:6085 with SMTP id q2-20020a5d5742000000b0034e3cb36085mr7080161wrw.62.1715009793016;
        Mon, 06 May 2024 08:36:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id k3-20020adff5c3000000b00349a5b8eba6sm10895265wrp.34.2024.05.06.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:36:32 -0700 (PDT)
Date: Mon, 6 May 2024 17:36:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: yoann.congal@smile.fr
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	x86@kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RESEND v6 3/3] printk: Remove redundant CONFIG_BASE_FULL
Message-ID: <Zjj4_hWkz9-qHnWe@pathway.suse.cz>
References: <20240505080343.1471198-1-yoann.congal@smile.fr>
 <20240505080343.1471198-4-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505080343.1471198-4-yoann.congal@smile.fr>

On Sun 2024-05-05 10:03:43, yoann.congal@smile.fr wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
> 
> CONFIG_BASE_FULL is equivalent to !CONFIG_BASE_SMALL and is enabled by
> default: CONFIG_BASE_SMALL is the special case to take care of.
> So, remove CONFIG_BASE_FULL and move the config choice to
> CONFIG_BASE_SMALL (which defaults to 'n')
> 
> For defconfigs explicitely disabling BASE_FULL, explicitely enable
> BASE_SMALL.
> For defconfigs explicitely enabling BASE_FULL, drop it as it is the
> default.
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am going to take the series via the printk tree. I am sorry
    for the delay. I somehow expected that it would go via some
    arch tree...
    


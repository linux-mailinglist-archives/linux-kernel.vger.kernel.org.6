Return-Path: <linux-kernel+bounces-294236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB23958B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AE21F21B11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A41922FF;
	Tue, 20 Aug 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eFp4TtCi"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1D18EFC9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167295; cv=none; b=FnGxzfcjq12eRCApe4gvKNkaz2ziVuFVu6wY4le+eK1/i4wGQRCgfP4PVdrgv8surkDIqX5PK8MWWJXfj73A9LoLceO8VR46nrWl3KMRMx5r8P3bavrjlyJDwvERNeaWu3+dFRcgelRHrJykZYOJldNxVq9A+rSyMtlfZlDJyPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167295; c=relaxed/simple;
	bh=PyXKtPn2qFPt3UUSSLIZ/J0nOLqOnhMdXopm1PD+uts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0ph4mSw7sd5JHv0MeFszuGY5D8ENlwunP3SO9+K8Q7wDICoH4V6BXyr+QEgMi1pzJgjX9rHw+0Jd7QxdSqSgE2p0hz0zOebxGzjGF22eHlSQdD+rhohpZF0ctFmQ8u4Jv1EC7jzreSjQWahNoTM3RM+BnKTF8QZdgCZLnKXjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eFp4TtCi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8666734767so9644566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724167291; x=1724772091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ilUiBImFJ0xsgblnZ+mMLCQ1afu3IhnNmuVKDa1c/o=;
        b=eFp4TtCi6/nI230NUD8X6oMfBcL4qEs+legpVI2GH3BD4tYBlgChqzgXENgJZyNPPg
         L2wXLAW14HwruuTk76csJPF1ZavM6g5b/iDDRFXyImD1WQjM+fQKckEFwU4xueQj5PDB
         rMtRDZWpKWzXJ3kylHqqZ6Qraj8xLbES6U11NYDb7xSJXN40CT8ky69HazaVCFMI+IBK
         G6XfoMXdbmf0JzvJkLW8oamduky6MQ1fkTeB+Ix5CFXnNfEgk5LtoG5nONEypblXNA4z
         nUTi3f9vMegg/I7+GqtP6VkIURJJ/7ZeHBX737e6jAXO6dqCl0qKVG9xBv6a7LrKeovb
         TK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167291; x=1724772091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ilUiBImFJ0xsgblnZ+mMLCQ1afu3IhnNmuVKDa1c/o=;
        b=tTqgnoChPcCYEciEd83jujiWyTyOrNZAK3ZYwafzSFKble3y9iHZvX12C3irFNNGU6
         fOPsfpqdLvSiFwOhu2rdTxhUtDTpQrRimT5KegOAAm3vIjcsVzn5rCTlbs2O6eKEdDDh
         1HTVnBmPn5SnLW3nS73GAHqN3xlpFI5xZ1mYHewi/eWwp0IU9CnFFY4rEguKwsgzA8jT
         +zFQLfUXboaDmfIHo0vnQMUu6au9gJ1ZDVk1R9weK3sM3kwH/AbRNxLRRFPh7/uJE1js
         QLPHb2yPdShw789SHXmrwLjLvab4S4bsrYexAPPmwNfQi26MK8aIgih7aCrwExSyj6Xz
         fHSw==
X-Forwarded-Encrypted: i=1; AJvYcCVEgiJ6dXFaGTNe4+NZA/ZJZwRpg8cheVtq5KwFVtj3Zg3Xandpzeg30/gYzFskKiwZoWk6UfA7o/Mmnn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkydH75XhE0rtH9CMb/+ICmMIXyiiCjptsjCK+76gbkChPxZFI
	78ib9k33kqDFxVapdk6foaYO7xM+5IdJJmduvR15mBjentIreoSZdhy9LXL0/gU=
X-Google-Smtp-Source: AGHT+IEzEYuFeTrOnBQQgneHGHZzq6FU1jXoJPZqKwBwK1um2wvYVLOW9stmuJfrnBeSXHt8NNKouw==
X-Received: by 2002:a17:907:7d94:b0:a7a:bece:621d with SMTP id a640c23a62f3a-a83928a6071mr1080236566b.3.1724167291064;
        Tue, 20 Aug 2024 08:21:31 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d4b2sm769149766b.220.2024.08.20.08.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:21:30 -0700 (PDT)
Date: Tue, 20 Aug 2024 17:21:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Joel Granados <j.granados@samsung.com>,
	Lukas Wunner <lukas@wunner.de>, Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH printk v8 29/35] printk: Coordinate direct printing in
 panic
Message-ID: <ZsS0efABGgFmXBwB@pathway.suse.cz>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <20240820063001.36405-30-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820063001.36405-30-john.ogness@linutronix.de>

On Tue 2024-08-20 08:35:55, John Ogness wrote:
> If legacy and nbcon consoles are registered and the nbcon
> consoles are allowed to flush (i.e. no boot consoles
> registered), the legacy consoles will no longer perform
> direct printing on the panic CPU until after the backtrace
> has been stored. This will give the safe nbcon consoles a
> chance to print the panic messages before allowing the
> unsafe legacy consoles to print.
> 
> If no nbcon consoles are registered or they are not allowed
> to flush because boot consoles are registered, there is no
> change in behavior (i.e. legacy consoles will always attempt
> to print from the printk() caller context).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


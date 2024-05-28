Return-Path: <linux-kernel+bounces-192060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C7A8D17E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B811C24A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA216B74D;
	Tue, 28 May 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HHxthk5J"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EE16ABDE
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890267; cv=none; b=DUK3YPf4OT6WD+Zngris1iQ2qSmB5htkt8F3UZrKLQM2VjLc7T4excgP+StFZjcM92lAgW0gxsuAClfdawnGbiAcus7G16nvO9kUGRKS22qHMOhIXZGGbYqIUuuU+Wt1F3pfAUBeeHGfS6BBpTTK3+L+tH49qcNjMZ00erPzJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890267; c=relaxed/simple;
	bh=gQ+6diGC/cT1XCTs6Yd4ZS7/4WVjIf0GdpeZRk6oLTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpBhkOOHFbPbUpDs+SjBVlggWjHrylOXPPtUDd+rJKiAF0PmNSiXNuWRvm5gmeMCAbAzPydzOiX4bQbGGzfWh51QKv55Q8/p88zQblSYrPc0zFZHlulAvnSwb+gk5BPFjzIriJ7IKRc6IhGx/+22oyccDlgl0RONqh63EW6zqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HHxthk5J; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so682337a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716890263; x=1717495063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBtb9sxLRDcXGg6T4kpyvvh5LLjVNzW7ck19VAz6oTQ=;
        b=HHxthk5JAKiljWE7jJzVfH5RIq0RTw1/scIFr6GePjNI09VdGyqRKRKBaNz+PSAmCS
         5lYbylccjqMUgT4vff4ANd5AKE1IVi0S47iOIoX4A+s89NGBIi2dQ0kdTZ/KaAFH2wXe
         e9zUfO4hueaAASGqMqDIzKrFg37YBrAnhb1QZU1NujoIKOTw7m7pl7oeAYhS+/2HODG9
         rSl2OGsm3WN7Py/66x1cO+ROcE5EUogWN5yHPoh1+UCOZMel9FZXOS9mrUJWb5LySTHu
         lF9VhHuO5MtViFsGJgDDSyAO2R9s/G00LYnFSKRS6prmr4L3Tq6NglXPmJoKYdruAxrM
         z1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716890263; x=1717495063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBtb9sxLRDcXGg6T4kpyvvh5LLjVNzW7ck19VAz6oTQ=;
        b=ePrISOvCBIm08KP1v5s2bQp5eIMOyvHqTrhgf/NfGuMqpfx56VW7IMwpxiB/H8kJz7
         Jy5vb8b4BT7yDJ2W8m1JCQ6htEu/I92XNW+Hs878WeNZcpAC28fwlm1V/itb/erUKH63
         scebN9scZaXzh4wunxHKs6BMDtZE/2PvgToTnMQGofTePlHyNdMqRRR/JP8N2yhg81iR
         Pz5ncehVa84esvXImvZB493wTbL/m6rVsJnsE9tTqM1odSe9PoRanCfhs8cAggud2gZb
         FsDx7h4CjQP6ooscQyuO8KvHeNoyxgxZ76XJFKO+fmQR3rXcM79jpcmKTLuHhhfvPcU/
         juEw==
X-Forwarded-Encrypted: i=1; AJvYcCUC/WLdkKK8i7rB8NVyDlg1yDT0JCcdMeLnvYuXn12fWT21+Cd+I0fdhXxO59BAj4hAEq5bhAGMgcVldjihM4Af/jSSGnE9aRANP4Fj
X-Gm-Message-State: AOJu0Yw5FzG9UTV9ZqeFMwCUXGnIKW1bNqruqFNVTPZfU1cPeTjlu9hq
	+MliBy3U5tEJeH0DeGJ4ExdSrpsJUUZ9zOt4jrdHzLPgTr/rrBC4bWDG+IA7ha4=
X-Google-Smtp-Source: AGHT+IFtRHPgBtJJ7YKE0h5+al0s2K/7fUJW1PP+OzptxOIgt2QIKDt2V89BSMY/fYT7iIKjsQLB4g==
X-Received: by 2002:a50:cd5e:0:b0:578:55f5:1987 with SMTP id 4fb4d7f45d1cf-57855f519dbmr8679786a12.13.1716890263343;
        Tue, 28 May 2024 02:57:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57861cb2dd8sm5818038a12.81.2024.05.28.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:57:42 -0700 (PDT)
Date: Tue, 28 May 2024 11:57:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v6 26/30] printk: nbcon: Implement emergency
 sections
Message-ID: <ZlWqlUL5ulTcQ1v7@pathway.suse.cz>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
 <20240527063749.391035-27-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527063749.391035-27-john.ogness@linutronix.de>

On Mon 2024-05-27 08:43:45, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In emergency situations (something has gone wrong but the
> system continues to operate), usually important information
> (such as a backtrace) is generated via printk(). Each
> individual printk record has little meaning. It is the
> collection of printk messages that is most often needed by
> developers and users.
> 
> In order to help ensure that the collection of printk messages
> in an emergency situation are all stored to the ringbuffer as
> quickly as possible, disable console output for that CPU while
> it is in the emergency situation. The consoles need to be
> flushed when exiting the emergency situation.
> 
> Add per-CPU emergency nesting tracking because an emergency
> can arise while in an emergency situation.
> 
> Add functions to mark the beginning and end of emergency
> sections where the urgent messages are generated.
> 
> Do not print if the current CPU is in an emergency state.
> 
> When exiting all emergency nesting, flush nbcon consoles
> directly using their atomic callback. Legacy consoles are
> flushed directly if safe, otherwise they are triggered for
> flushing via irq_work.
> 
> Note that the emergency state is not system-wide. While one CPU
> is in an emergency state, another CPU may continue to print
> console messages.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


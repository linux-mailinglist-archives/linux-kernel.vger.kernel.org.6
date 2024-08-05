Return-Path: <linux-kernel+bounces-274855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43BB947D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FD31C21E2C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247314901F;
	Mon,  5 Aug 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UpUcVBrW"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6322BCF7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870222; cv=none; b=Gi4ZTOcEILzQ6H0LEXf0Oxzmhaxirjk64ehL0IOGiwAA7ZvSrIx+/dPGS6vPnUcg0D3raMo27L08bPqaLyLQyZQxmRH2QHVRR+vqImLDrNuQArBgYFtxe5mEfwky67Kdf4CHytjZ1qwyRSgQnUeiCaSM+vnSNze1yaYpnnYKOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870222; c=relaxed/simple;
	bh=2XlFJ0N51fkSf6J3U6qs4Y2Bj7vejk+SFgDCG+1rkZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztk8GDkUVRQ+koXXACAXE1ViQssJU8Fqs2Uw57C8J8Hgx9ani4h/WMS9ymrZ3tDMgmwwlP8KuW+Fv3BSQYUPG1W2F6bO2fqQN7XlXbyGizQWANPN9JPhDVexLOpu78MYCbs7CrR8zl5gsGAnK85QaSzjRn13IvAXIwPFtuxE3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UpUcVBrW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso3436296a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722870219; x=1723475019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MclKyU+JrJj926hqEc/QjYWeITa7gCY+forgWrv5+GM=;
        b=UpUcVBrW4kRKPyZwu2oJRb3GrWxktuLabjbRL2MZE5pxo/DbhoNexhHFIBd13GDdxZ
         EaEy3QM3kOx3vOdZmvKkxJegrGqnN9FnuG0NULFwXHXSMhUWPvrJinT9jqvTQTN/gNN1
         j3vzUgRHzhZhoB2L8QOYl/moY3XVGzfBhdyF53ffmSnLO6ElepOkjTwFzK9dfnj63Vm4
         rPHAHct6ySsp2yJGXdF2WuwalD/ff1WCukZLAZ32FfOKJ0biyHkUiLEUE01WhEVuml5d
         89KKUDFUW8omuPAg8vqe7bSTKskszaiytug1RPsNUyp/619HcKWgsmQCw2KStXvQCNqI
         A6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870219; x=1723475019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MclKyU+JrJj926hqEc/QjYWeITa7gCY+forgWrv5+GM=;
        b=kk+5Xi3nnJ3/v2+x1ZbNK1SaLK6kVjlerhEyAIhAnFoUuuVMFEh3sIsFcejzaj/yqD
         mckvcTl35nzvc3we07o30Q7bA42ZNQVPXzbObjW+kkGp11iW1u4i1DmODhTkFiiKPKrz
         H8eYW4PdvdPdWgt4G1QcN0mlEOPg6T8VMxWvEurQQ3qeLKDIvCQ43WoMbk9/qitiV/dW
         XrLXYGq6xSbUqT++PmSlqR45Szo588wBHC2VbgIFrA7dIrELMyO5hpp9S+FhQ38qBFrY
         wxFeb5RDtW5OoYAxdbVHY8Hc9xH1Ml+wHmvkspDxFPgR2l+IsWFXZqiFSOLUJeoFSLjy
         B+fg==
X-Forwarded-Encrypted: i=1; AJvYcCViNv92dhZugJDUg0zTsl+Q0mGhsjBPeZw2NGUxXcgh8rLA3WyTPLSvp9v9JUhw0y+sx/TwbkaZDtxVgj2JKZ39AzzBbd8UncahmXFD
X-Gm-Message-State: AOJu0Ywj2vE7YBtjILr1ZgAksgC07MxZXLSs9chMrCxl/tTca3H3V2k0
	fsZLD60tGHH+QO9wCLKblzUijHzla0YtwHkhwwk0qvHts/JRqEgOpQDuF3ja3HPSHCA8K5VEzDM
	t
X-Google-Smtp-Source: AGHT+IHpm8xGZFcG0tb4CIaUF9wbG7Qk7Y4gnvkyQb1AoPG4F3aXIdLFWkcbgtDoNDhviR8VRKZbgA==
X-Received: by 2002:a05:6402:60f:b0:5a3:a9f8:cf20 with SMTP id 4fb4d7f45d1cf-5b7f58eb70dmr8447544a12.34.1722870218795;
        Mon, 05 Aug 2024 08:03:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb8e6a780fsm1367373a12.71.2024.08.05.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:03:38 -0700 (PDT)
Date: Mon, 5 Aug 2024 17:03:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 23/35] printk: Add is_printk_legacy_deferred()
Message-ID: <ZrDpyKLcwdBPn2L4@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-24-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-24-john.ogness@linutronix.de>

On Sun 2024-08-04 02:57:26, John Ogness wrote:
> If printk has been explicitly deferred or is called from NMI
> context, legacy console printing must be deferred to an irq_work
> context. Introduce a helper function is_printk_legacy_deferred()
> for a CPU to query if it must defer legacy console printing.
> 
> In follow-up commits this helper will be needed at other call
> sites as well.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


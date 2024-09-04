Return-Path: <linux-kernel+bounces-315148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92F996BED0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC953B2D978
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5201D88BF;
	Wed,  4 Sep 2024 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RAAu4oN7"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41B433BB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456676; cv=none; b=kbLsE7gCs/yC0x3iz7r0ZOYR1cuKPFYDflgT3g4MPfdjCUsH4DB5JezBViFe8AIpL1057M5qK2yRua2vUxmZxZZFJsJ5F91+Mam0lJrmNccMFkVoQpV2YGSDaQvwHWUiE3G8EJpISfz5FveHiFPmv0dKsMDUs+QSw9vSitsbrXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456676; c=relaxed/simple;
	bh=eUtqvTHj3pBbLbztYBD+mtym0DievVmYTEHm5UTttkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWgAAF8NsoP1BCNjEiX+lBMhbOdo79xZ4YUvOlLrg/2ZBrmxoPq1FmNZ1tAlsEdyDuka+RUiCZFdf/dHxXgOz2XpOKXyeWDjaYCEz+yl7xw0dVfv3ryx6mQDfnzHlFSTlWxbHgQ2+oP8INswDLmNzD9pnLrvw/jM8s8P3X7XwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RAAu4oN7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso3559990a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725456672; x=1726061472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgr6oTd7dax0YYHgJjdFWhxSkHqEn6wRiq9zk9zlyD8=;
        b=RAAu4oN7Y7UKMd/wXtuUO8v1WiDeNFAaLHj3dKq+a8VTxvNJSI+BzX+ak/hOb7KpTK
         zw9IjRat01Tw3GddakPN9nbTZdFNQbFOhlBTUZuJ6VVObhYCOphkiM8yebKhPZ5sHCsy
         kDTUiMmqY3ad/o5B6+fFqzptgzE1KRgMs7hDYV4Sfbq1mY9M7Uy0r++lMT11DtaLvj/r
         zz9G45WLsTlCYLgQtymhC/njUiypwe0X3MSJuDiWJTZifx1xuUKPgdiQEUms+BEPbLz0
         d+npqDCSL0CEIqQbDCo7s4hpzlZBTiFHg8joc3aQiP8FP43xnI3Rca1dGsEbfl4vrd+s
         emyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456672; x=1726061472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgr6oTd7dax0YYHgJjdFWhxSkHqEn6wRiq9zk9zlyD8=;
        b=uEsExA/tDyANhumP28Zx1MOoRZe5nz6ntq+mdHVaH48ROHocC0IfztQkVP+rQR6QWx
         s7SUXR4XrtoXaVoS0JduomY2lZyr9Az0975ycUWGvp8aX4Q0MnbrT3dC74dzDkhiO3GV
         aB8Gqn/HQc+L67qx1bKEQ5bbpVv6XwRy0uj/qjJoUoj5A6rKso2S9ZVpLPDoPWPj11n3
         gSwz4OAG+0esjvzEEB54l+SJT6HCxv0GfjCWOulb0k4k63bfJyp+ZECUXAAVwS7/fGJ2
         vD2G/XWTZ2/l/4sPk6B4QW+aXDbLnBN87uwkbFXq6WFliH6xqUowsgUCAPdRHVrEFk6V
         utMA==
X-Forwarded-Encrypted: i=1; AJvYcCW/u5iVExq/QIY5WBE3jtTXlZo+HFTU2HW90AsZ1ALa3VgXY+xxNA5WWETaLfTDiL8IMl9YLHsN6ecRYmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQ4VAGTIh9/nhe5djX15GnZw2OcRcYkxJixzCltu0sL3RSplm
	5kyWAdJdiWVv1DW4LIApXpdcwk3Ic3RlY722AMWr1H2xnbNLLlocLET+H+UroO0=
X-Google-Smtp-Source: AGHT+IE6LQBRVOzDZ8qweHUloTSD5XS8PQtCmUy4Ig2Pf8z837LSCohOUk8iEoiMKTTrhJyS8cy8rQ==
X-Received: by 2002:a17:907:2da4:b0:a7a:9447:3e8c with SMTP id a640c23a62f3a-a89b93dc610mr1067998966b.3.1725456672198;
        Wed, 04 Sep 2024 06:31:12 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3dc8sm808563366b.137.2024.09.04.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:31:11 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:31:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v6 09/17] printk: nbcon: Rely on kthreads for
 normal operation
Message-ID: <ZthhHrESqU9KFXrz@pathway.suse.cz>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
 <20240904120536.115780-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904120536.115780-10-john.ogness@linutronix.de>

On Wed 2024-09-04 14:11:28, John Ogness wrote:
> Once the kthread is running and available
> (i.e. @printk_kthreads_running is set), the kthread becomes
> responsible for flushing any pending messages which are added
> in NBCON_PRIO_NORMAL context. Namely the legacy
> console_flush_all() and device_release() no longer flush the
> console. And nbcon_atomic_flush_pending() used by
> nbcon_cpu_emergency_exit() no longer flushes messages added
> after the emergency messages.
> 
> The console context is safe when used by the kthread only when
> one of the following conditions are true:
> 
>   1. Other caller acquires the console context with
>      NBCON_PRIO_NORMAL with preemption disabled. It will
>      release the context before rescheduling.
> 
>   2. Other caller acquires the console context with
>      NBCON_PRIO_NORMAL under the device_lock.
> 
>   3. The kthread is the only context which acquires the console
>      with NBCON_PRIO_NORMAL.
> 
> This is satisfied for all atomic printing call sites:
> 
> nbcon_legacy_emit_next_record() (#1)
> 
> nbcon_atomic_flush_pending_con() (#1)
> 
> nbcon_device_release() (#2)
> 
> It is even double guaranteed when @printk_kthreads_running
> is set because then _only_ the kthread will print for
> NBCON_PRIO_NORMAL. (#3)
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


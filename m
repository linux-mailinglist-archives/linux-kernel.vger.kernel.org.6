Return-Path: <linux-kernel+bounces-263203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094593D29B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A388C28232E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8F17A5AF;
	Fri, 26 Jul 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JJ8vjpwe"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5236D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995127; cv=none; b=r2qdzVvrK89rVdVuHJnvhsVZH5qyFdhAnm0dNSdJrfTz+9PL2+bl+699ey5XGcO4kI/t1X885iviqckfweISqN4EmLpMUvWZB9fBOoHWQ7OB1p4idxLUqGQM9vq4AUbhXBqmazhvCy1Ax+vSaOVeXYQ6TyxT4dA9+NRAn7cC7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995127; c=relaxed/simple;
	bh=847JiBJN3e1lmZYPDb63gqhhGwwUnOv0ufbYeIvV+E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7wvcoi9QO6ZvvF2pli6WBHIvLorw+Z2aSZXEoAUqezMxS2DAdHvAA5wQdINN/5M2vbK+ole+oCoCKyRpfiawHHSUad3YkwVEtwcme54zFuzW24DmeD63+aUJFsBGh2WsEP3tY8AMYSUZHr3TyjJ8sm/Yi4G04wu3RVjlzsqckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JJ8vjpwe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so194281666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721995123; x=1722599923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYusgImosVkO5aIguxITUgpT7bapYI7CdAvv/Q/sA2U=;
        b=JJ8vjpwexv0NvsiiSeUdrDH0zvdhAMRqa2/QalNFtQdzcecpaAMAoYp+MNWL6vkhoY
         +tRxvp300S8vLDY2WvX5LJ71KsA7UpHNwPaxzb4FsDICjuCrHpc4TEQVexxa6/sZXSwF
         EvEMciy38kVwEwRyt2V3HBe1HZpMVDGD2l4cZuyFWSVwXH15aAVnHXvHrjEi1ap/Qc+l
         YhFVHPIHr16ZBc6kGTdKGFbKlZrKdnphjFAa9b0wZzB4cqttiDJV9byXXrzJyXUccbaS
         mXxlgIaQD0mGTjPQeerN1GUxf0kB7+Fs0QITZReKKKAilvEt9xl+0PzzwRBLfSwGWork
         P3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721995123; x=1722599923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYusgImosVkO5aIguxITUgpT7bapYI7CdAvv/Q/sA2U=;
        b=Ly7AZiMUrpKzt3hNBCs6RJN4fD09Soa2g1zdtvngsFQfbcxnJ9ZoDXf12BWYL/vbSE
         QZ+if7XaoWrGGrEI0UGzfc2yHFGoWnvvFCC4FoLLiAvKEb0FvkOADEQ9dMGxJLfzTjgz
         rv8wOrOZ/98AIfXg7L3MSHDWuzRHvkapl6IjFPb3SfIGeY9JCIKjEiTHVumsl6Yz20LE
         IdYXlc/qJGXtFjDnuV/y11mCI/IN8rvHenMi/E29io0ydKCP566IoF0cLkpckmDyLcHc
         ADl7Z/bvjI5SDUxujGigJj21fhTkyUc7JJ+m8Nj3MEsWI7MqXhepWHtLvvA3CqIKBKy9
         CKVw==
X-Forwarded-Encrypted: i=1; AJvYcCXHMq+egCKL0tqE3x5gqI20aZtFYMaOv5EK7fsu6vWmkL16n/zAjdiaB0VYVrxAqR6YjC5ZPDRyBR+H5jmfF5EQDW2MMcyZfzmfaZ1o
X-Gm-Message-State: AOJu0YyqyWONLTKjL0+Pvb7xV3u/7+uwp19k+coGl8Ld9RcbscTKut5Z
	crX6mFD+Q+424v/7qY/kP+KFGp1MfKa+Etff0sxiBN3RKBsFoOnHRjaXQr9lkM0=
X-Google-Smtp-Source: AGHT+IEX82zC0yPlAN+6To+dmixQ4Lw9yc7KtW7IaXWV5ps4YZckNXSgp3XCDQIAaU1qhu1Afkpakg==
X-Received: by 2002:a17:906:7950:b0:a7a:8e98:890d with SMTP id a640c23a62f3a-a7acb3eedd3mr402333566b.16.1721995122999;
        Fri, 26 Jul 2024 04:58:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad434a3sm165956966b.139.2024.07.26.04.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:58:42 -0700 (PDT)
Date: Fri, 26 Jul 2024 13:58:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 02/19] printk: nbcon: Consolidate alloc() and
 init()
Message-ID: <ZqOPcW9_4-uXEgez@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-3-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:22, John Ogness wrote:
> Rather than splitting the nbcon allocation and initialization into
> two pieces, perform all initialization in nbcon_alloc(). Later,
> the init_seq is calculated and can be explicitly set using
> nbcon_seq_force(). This removes the need for the strong rules of
> nbcon_init() that even included a BUG_ON(). It also more closely
> matches the setup logic of the legacy consoles.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I like this.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


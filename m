Return-Path: <linux-kernel+bounces-213208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EBB907105
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A554282856
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429F142E86;
	Thu, 13 Jun 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H/AdXS2U"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EEDEC4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281967; cv=none; b=k3W1I7nyCH5KDimRnDwXjzMhTBoOz65NxawCIO6KhuzAhWFtO3iwRBFLeZx5zLUJWJmCB59kppurGSwyEC9dbxEjLBKcK8INqjFxLvJ8HpYhzlL84N40o0eJkD0PALcXWn7hqO0du++/fptkc5rq1SmWVJRAV24A2ohOaM30Zjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281967; c=relaxed/simple;
	bh=d8wKRuqd4eEoNvfWvaZlmx6Gfb7PQjrp1pXbsjriDrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIWVqfIDgY33WN/2T5tO8bpDDDJBqC7zlsN+zhyJsSt3hmnTRpeIopFaTOh6+m7dlUeMnN5bfaFu2BXUR6aGi3DCXAIu+n2Vq1cVFw44043EFXinJuTUzkAVNe+u54yFnuNWZuM30bCq13QmKH94+MgKQ9ayh++3mZ36YERzucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H/AdXS2U; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57ca578ce8dso1008839a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718281963; x=1718886763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNjOzX7V7NLV31kN+AM+nPZl2WhUokH/5prW3D0oiVI=;
        b=H/AdXS2US4gad1YKt7fb/ng/BHHf772JkPEv3D4W4wOnrVLkc5g5ZVbGiaRgdxMEux
         L2+62Qvtco+uWz86qwn6nth1AMjxKppnaLDXTiLtG6gVVFHHPbTRHgA6JQizn1juYxpB
         CRYtuu6LRptntV0JQecElR2ieU5uYMqkbRoQd1Xsi+uUvqDh90Vasn3ulv2rTFMcGMuB
         DTjVNyksy3liYy9OYMwpM/a4RnMciH4QmgVgYGW+NXInowA3RGLhHBw1r4stUoR0K/1Y
         EG6aNzQlY0HEwPJaEUqquhiNbhaFki6GBrVYtuSmrfrjZFOapY5jp/bM4siOo9eBcFsj
         CSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718281963; x=1718886763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNjOzX7V7NLV31kN+AM+nPZl2WhUokH/5prW3D0oiVI=;
        b=r6C+V1Rnb1mQ71CTOpcpLJMp9tXS8UUDbTKPePa/viMioQ/sUgvOgdQ8gec3gATDG5
         sUOC5FMBONBVbesNfH1QIMebh1YrevMBsukA6mHoj9ScSajVa5L2CRqEsx62jnrUHAUl
         tb7U2WcYY21Yj1mQd64Z94/fFm0gwoZOCpWEcXAinKB4pc2slM9kr7c+SmPYiyqKVYp0
         VC2cAn/0eNTPt9sFSavdrqpRGD8/LeRNxmfVaBYdr81JblQbXKK4QSBmNAm7mmwxQZUi
         bsZyhEnTD48RYqnrb1M7rR8oc7JdmLLMPPkBrPWG098w1fxM71NH3/AaTe+Sp7/89Ue3
         wXww==
X-Forwarded-Encrypted: i=1; AJvYcCXxfD1TNeVmkgGKH/mdNnjc4clvbUAOyFuRM69HoPlRbxgT2xJYQRvpYkA2rNiXMH6ilhwkFnMXQttc9p0/o0Hek/74cYQSXKtlmSV4
X-Gm-Message-State: AOJu0YwQudjzo1hWy9RKG7RWsQQ+4C1l0u/d2uiLW58ImWmT+8G1ILTz
	ZirfulKrT6xvI4BFCZKU8Oif7+9AA7B8BHPCVtbB8JfL5WXnzr0CpYuMr/Ux6pmVdhcU65/tSD2
	/
X-Google-Smtp-Source: AGHT+IGfG/znufbENzE86o28Iya8W7c+L+hIXsYock4Y5GDqMjWSzbaZyF9WPVklyaBGitKrOvHg1Q==
X-Received: by 2002:a50:c00b:0:b0:57c:765b:83a3 with SMTP id 4fb4d7f45d1cf-57ca977e851mr3511395a12.25.1718281963075;
        Thu, 13 Jun 2024 05:32:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743b026sm851419a12.97.2024.06.13.05.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:32:42 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:32:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 05/18] printk: Atomic print in printk context
 on shutdown
Message-ID: <Zmrm00TEOx-ktxKD@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-6-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:40, John Ogness wrote:
> For nbcon consoles, normally the printing is handled by the
> dedicated console printing threads. However, on shutdown the
> printing threads may not get a chance to print the final
> messages.
> 
> When shutting down or rebooting (system_state > SYSTEM_RUNNING),
> perform atomic printing from the printk() caller context.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Sigh, the checks/logic gets really complicated. But I can't think
of anything better at the moment. And it seems that the check for
the system state is added at the right locations.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


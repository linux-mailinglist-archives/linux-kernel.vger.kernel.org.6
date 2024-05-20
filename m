Return-Path: <linux-kernel+bounces-183720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308348C9D15
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CF41C21108
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE511548EC;
	Mon, 20 May 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dguptPYJ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4756448
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207776; cv=none; b=dwxWKZDgtNSls3hv2DNc2d/8MR7thN8yzHMepwX3JGOa61gUrI42vBr3yT2IEie4woey8aSeHC/imv204QD82+f19b4YnCtcM83yFEOGj36eJ/NP4Uf273ou1LiTJERF+opZ1hYvJCvoYlnw/o4yfu9m+CwtwSyFCAs1Z4neF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207776; c=relaxed/simple;
	bh=FsjGULNLBK+FjzXLWr/t8FWTDIAjnTpWhcTrRa5F9sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+/Zd0chM4e/P2MnzushV289AwsXm/OZ75yUTSH1WOiYKIPC9UDU5yhS16o1wGQ2Rg5CnxUE8hNY0hFNd7xWyEyZyQC+f1uJrOn6oeRM5tcY4PaJwtDOB1QaPxcRC/26wyNWYfX1P9tCuQa93sv5Fgx9x76oKsomjP+AWdDjDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dguptPYJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f57713684so5276778e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716207772; x=1716812572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bREYXSNJx7yr5uTrce/LKMVLb4BxuBwY9vQL2AO1CY=;
        b=dguptPYJ6eEH1U3JgYG8j8UeKVQqMosUTvjzVuQX2lW8WEoyc09NoR1oMcTG6LMoay
         bjqhSoidZKDH6slChBbhHO91Hf0e0IzYsV4kvBNpYHR8zsHD0t4lDNi9hvzm9/E4KIZo
         Ycq6nUEwH8GIKoRLb2pXaLkU/LfVONSFoZByMXDd9hULQ1wcAIlIGLqMdKnunohX8V84
         9znpBAcSeYCRa52dKZ8Apzg02GVPxC/mgC0K4mHMd1OSGPBGxs1WxSwvls8v8nG7MV7k
         iBRnym2VcpMKYvuhrj+vC+L7qU6zc2gpsuJhExZnIeMwX28fqU1dME1Vc/yimTYhaw6d
         KZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716207772; x=1716812572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bREYXSNJx7yr5uTrce/LKMVLb4BxuBwY9vQL2AO1CY=;
        b=angzOSVzCPnUgYOLOJl6ZQDzCZut6L96sZSFruB7VwTwj2Y/aFx76pBtzLTkwcVQ0n
         UV93YbjrRVSoKZYicVyY63+ZfwbOk961q7+WytFoP95jhIfVRXthk0Rsg1C1B3CVxqGC
         IarNVk+OtraPybfTiTsPv6T9VkUC5R9UEgw7aO1RfO4B1VcP8RZ2+n2jKSGPxSE/UQol
         wnoXs8GPHQJLj5z3cHKGOgMSw+MxxLe1BAW4W/WPj40JVe9FGJHz+DKaIn8K1Y6kLPB9
         Lea8hKHs0I2p3AWpQD0fDhx7H2aXAofxfVfcS69uyDEB0EGnCSAq6AncMe1i49U4GPV0
         MVmg==
X-Forwarded-Encrypted: i=1; AJvYcCW/L8w3rS7pY8qH9o4iuJOuv2CDEYWm6jyuyWXUxgiBK5uR8UnwvHwKZwtbLnsiM4SUC75sfF9zNORirZunjnnPoj9krLMZFriN6Qmj
X-Gm-Message-State: AOJu0YyL6jMqJN0SqctLj0+HIANR3A9CU6Ga5HRB6GYvV1cH/7ZiYKxa
	x4dBSJSlqYZFmRbVWNgYgRrqdBZlIeAcZ5F/7+c9j4D5Bq5wulWREV3jBx/UiyY=
X-Google-Smtp-Source: AGHT+IHrIxn8lRvzjOg1Ui/6tQPrN6PSJ3Se90i+uvDj849VnBCvGdQmYRpv36r0fn+9t2zRZhCgVQ==
X-Received: by 2002:a05:6512:3c9e:b0:523:9493:4e63 with SMTP id 2adb3069b0e04-5239493505emr12455625e87.60.1716207771843;
        Mon, 20 May 2024 05:22:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cfa7sm1446680866b.33.2024.05.20.05.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:22:51 -0700 (PDT)
Date: Mon, 20 May 2024 14:22:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v5 12/30] serial: core: Implement processing in
 port->lock wrapper
Message-ID: <ZktAmvpBfk-IrMr9@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-13-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-13-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:21, John Ogness wrote:
> Currently the port->lock wrappers uart_port_lock(),
> uart_port_unlock() (and their variants) only lock/unlock
> the spin_lock.
> 
> If the port is an nbcon console, the wrappers must also
> acquire/release the console and mark the region as unsafe. This
> allows general port->lock synchronization to be synchronized
> with the nbcon console ownership.
> 
> Note that __uart_port_using_nbcon() relies on the port->lock
> being held while a console is added and removed from the
> console list (i.e. all uart nbcon drivers *must* take the
> port->lock in their device_lock() callbacks).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


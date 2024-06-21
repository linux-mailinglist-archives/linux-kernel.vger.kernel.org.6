Return-Path: <linux-kernel+bounces-224620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577E9124DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FF328776B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B478A15279E;
	Fri, 21 Jun 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="br6XBrqI"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1A482ED
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972124; cv=none; b=aIRNbptNTjGslQDKfDqkz7zK7bYGrfvXWW5gANsNI09AwUEP0MhsaE/ONNYMnUutgjVq+fd5Uz2Rb5cPxkgB5GyHrSfhk5pigyGjNS6RlNNEfT2+aNhO5cEabGNxVYTxwTpzRtrZdcrfHrV6ljN7s9BgD0fYmRujOu5/XMvdWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972124; c=relaxed/simple;
	bh=Ul4UPYH/+TY+vUx++IuWcHjMYpRIIfVR+t0N7A/0g94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbQrH8VYwrb2GVA4ZKyEguz7hSnOm7NgOZkmtxc2E8PKysdlawFjP93AK4TcthHb9SC9b2j2GzHpvOMhhXfN9LpeD48WRkOiMZ9iBsx12O/mbWdi6q3OHcFVrZ7MUo0uZ3zFeEejvJqd4BZLGqpgaP+RDnN9IpvwfAmJe1j+9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=br6XBrqI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso27821641fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718972119; x=1719576919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xH4TjJ1vLeO7hvhqxB1jVAlRByyOLroRcKk1YzxwLQ=;
        b=br6XBrqIgFKrlXfFCWa2cyRVqNBbxtwrzvbhZV77Z35bkJ+YKAfa1UVKxThHs64KR1
         9CplcFrFXuDWqr9a4OLgzEM3cdMG2ougs9IcO2kpj4WFYDyC+QqTK0DesC8RV5yw3/7v
         Tmtf6xcS2IUWLsrPVornHpkRb4zjwdtFprb2vbmAQxzJ97rHrbOaxR2YmrLLAro9NWJ4
         CgEqspfaUx71anH5H6mtVSJ0oAdDZ02kOgUY46PBJT2CNOG7guU37g+3r8xHM+nLv/Ut
         HO9J48O6qMuzoK8yFxMdK1UphQIeHikgWgMwURtZVa3dJ+A0KoXQ1MtKjdL/KZ6502Qw
         6/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718972119; x=1719576919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xH4TjJ1vLeO7hvhqxB1jVAlRByyOLroRcKk1YzxwLQ=;
        b=PmQbq3jHvRfMeqZvHpwUu5R8N10jM8I9lbJxQOmSiuN7/ZbWzi+d8krLOirUGTX+4v
         WkPygsb0OQrQmGBZjNaNm5fvgzwDt0s5HxheD2s0m7CNLuGJnlovp4732KFYiiQJd/Fr
         5NbzkVLnO/wvZivM4onayz/YkTjIj/1bf/wt7xk3HVHk9xURqoaPlqPCv2fEwalMZMyS
         EOHKM7VwA9vEIXAUcqllsNTPKGJccO2vSU/TwvvSYtyt2ZV4vPHlB3tvMi5ALwkEMyXE
         aeHKN2eAinpSc6ZsPD5kcrh8mr1XqpXOp2caoSGUG0hWHCJmVJMhEl1KvxEydLhqdM/C
         MldA==
X-Forwarded-Encrypted: i=1; AJvYcCW3tNw60OtYBFKK0YQoI5bqd+iL63IoTnny1VUAs6lbmejyd+X2LU97o9ly+kN2HqViqL8/yNX43ssqeQwuVjaoEGN8eIu7YCZV2qrH
X-Gm-Message-State: AOJu0YytCvJ9zUif7DqV7hP19NsrHURrz+S4FD4uOdQs6P6cF4uw9ZpU
	rkxDGzoxN+1t2gqqgl9xrG9SdxrgHaQB6m46wK8KPsRotkmN8JfMZHpWXnOamk0=
X-Google-Smtp-Source: AGHT+IGTk3TufthfvrmTzsIzthh/R+FGLBg4ydeD9dSFSJdwe3KkpatXVXYn3/PLrKsUx4xzR+4XkQ==
X-Received: by 2002:a2e:7c10:0:b0:2ea:e1fe:2059 with SMTP id 38308e7fff4ca-2ec3ced180emr63245121fa.27.1718972119493;
        Fri, 21 Jun 2024 05:15:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb321c24sm12834335ad.97.2024.06.21.05.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:15:18 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:15:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] serial: core: Revert unusable console quirk
 handling
Message-ID: <ZnVuzXMqoH_HLdhB@pathway.suse.cz>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
 <20240620124541.164931-4-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620124541.164931-4-tony.lindgren@linux.intel.com>

On Thu 2024-06-20 15:45:28, Tony Lindgren wrote:
> There is no point of trying to handle the console quirks in the serial
> core instead of console_setup() currently.
> 
> With the console_setup() related changes, we are now deferring the
> DEVNAME:0.0 style consoles based on the ":" naming only. So the serial
> core console quirk handling would not do anything for the "ttyS" named
> consoles as they are not deferred.
> 
> Also the earlier approach would have depended on further changes to be
> able to drop the serial port quirk handling from console_setup().
> 
> Let's revert the following console quirk handling related serial core
> commits:
> 
> b20172ca6bf4 ("serial: core: Fix ifdef for serial base console functions")
> 4547cd76f08a ("serial: 8250: Fix add preferred console for serial8250_isa_init_ports()")
> a8b04cfe7dad ("serial: 8250: Add preferred console in serial8250_isa_init_ports()")
> a0f32e2dd998 ("serial: core: Handle serial console options")
> 787a1cabac01 ("serial: core: Add support for DEVNAME:0.0 style naming for kernel console")
> 
> Once the console quirk handling is gone, we add back the DEVNAME:0.0
> functionality with a minimal patch.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Link: https://lore.kernel.org/linux-serial/ZnGQ8JAu2OQf0GX8@pathway.suse.cz/
> Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


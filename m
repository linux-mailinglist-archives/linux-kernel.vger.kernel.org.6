Return-Path: <linux-kernel+bounces-171251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF7C8BE1D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A783D2884D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B519156F5D;
	Tue,  7 May 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cbBijtnG"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE348156F37
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084206; cv=none; b=AJ56Z9iw9LFt1Vppz/obHXsNv5bJqcLcpnm8K+ghkm+d0yCHUeGynGsWOPj6aZUxotgKfuTMxLvfrxm6Tl+xG6uCWV/AEdnRNffbradiLM4H5TiPTa1IJ3iQs6OiuVJ+LlUx+Q65bPKglIw6caDsl1iMOJ0TRYRjkyVDt9ZXfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084206; c=relaxed/simple;
	bh=EvgQtJMkLP0D5zJykfm4Bc5R7qTohRoyIUwpSeoDZZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf9YT9OWAMfdPvS7s3T7mLAZZ42+UrTuVk2oIWFtQBVuOqNn2sD1W0G5X/5mm8ZGikbob5LTylZFNLQgdHraxiZ8MMqpRlUJSUkBpp/VVPaU0Fa9JMUYPt8RGKs5+24Cc25vyzoTGxATV1YxZLF+WqV92f0Xa0SFcKWIlMYZBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cbBijtnG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f174e316eso3386089e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715084203; x=1715689003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwE+AFr0efc2lZwJmeqTNz/OlSOucl6QYOlDHD4M8cY=;
        b=cbBijtnGar4aRLCMp7mSM7PH6pjH8bhosd653nc1SnkUffuZe5tOR76V8AS+/Pt8QP
         XIt1CKxDqjRjO3h5B5ly1UdukDcnXqOgcLHxQ+ah/M11dGeyaQME+2hnn3mkD7C5UPyN
         aXVtPgz1bQkq0McaiLOV15IJmy67YQw2szbrRqChWLhjFupM63sCCixyzZ5N88fzuRdJ
         qrpcXKYs45u1lmKJlmiOkG1ikGk/IrC/79KAdmCV0SVVUdSun6TF1QqnQ0uC643r3toM
         1r1gzEKELqvGkBLr7KA75R3B7S4WfJWAm5aj6mZ4icdAlsQ2gj59gW2CcSVdVVC63Ntg
         2p5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715084203; x=1715689003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwE+AFr0efc2lZwJmeqTNz/OlSOucl6QYOlDHD4M8cY=;
        b=i2DV4DeiODoMdwV+Zb6gBqrCK2C9WqaENIVEE+ypVvnLDwcNJJ2AsfB+lkex3qO5jz
         GKmBO7kp+7hbnq+tunYRMETxNp/hFOJBwY/7aHUFGecC0rtZkGRuAqyUdS4XRgTP6v2P
         aLGOmNlFVrtF/wHByJEa+zwg2WWi3eZ0rVE0D4JyrwVYdvbHfaBFq6ebXYGX78yifvE8
         hcFT+yCBzNAgGUwb6VgDFN+zjLlw2VJgpP8NVT7RXQ6sBc3fgpGTZ0+XzFepIA4yiXDJ
         4z8jHVXPM6+D8zwIYsperohvibDxICcvKXNvIuMGCMC8i2rP9Lpzr2byaY5EeYw75M2A
         lj8A==
X-Forwarded-Encrypted: i=1; AJvYcCVYTKhg6bIQNnvoKfQzeyv9eWrowTgmM8AAHfUlYOtqLdEvTM0qkUJqiFI5HC6C3n9TrmZK1N/xNWOqXSAIcpw7PKtjPDx4P2TBCX2F
X-Gm-Message-State: AOJu0Yx5IUV7AjMKXYYIpMoCzQR8/vQA3yfsnkXu29T7nFDZ6RCU7yE+
	v6/o3tOM1Nta76TAMyEcm09gG3MxsM+7h9a0ErLXs4CfnY2+XK0LP/8jlbWQJ34=
X-Google-Smtp-Source: AGHT+IE5SiqVE0dbIs2KPdjOR5ob8s/XKDn3LcIQsx+xisj2GiV3fuLEjr1+e/y5Xn91X+Q3thT1Kw==
X-Received: by 2002:ac2:5473:0:b0:51d:97e8:d2ea with SMTP id e19-20020ac25473000000b0051d97e8d2eamr8768647lfn.30.1715084202942;
        Tue, 07 May 2024 05:16:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d1-20020adfa341000000b0034c124b80f7sm12969153wrb.61.2024.05.07.05.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:16:42 -0700 (PDT)
Date: Tue, 7 May 2024 14:16:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH printk v5 01/30] printk: Add notation to console_srcu
 locking
Message-ID: <ZjobqF84Po92PckA@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-2-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:10, John Ogness wrote:
> kernel/printk/printk.c:284:5: sparse: sparse: context imbalance in
> 'console_srcu_read_lock' - wrong count at exit
> include/linux/srcu.h:301:9: sparse: sparse: context imbalance in
> 'console_srcu_read_unlock' - unexpected unlock
> 
> Fixes: 6c4afa79147e ("printk: Prepare for SRCU console list protection")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


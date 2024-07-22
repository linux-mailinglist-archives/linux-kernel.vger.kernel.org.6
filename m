Return-Path: <linux-kernel+bounces-259035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E1593903E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AFF1C215E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BCC16D9CC;
	Mon, 22 Jul 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZXij3Uip"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CB16CD33
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656727; cv=none; b=lODf0F+DCwu0e9sf4pKqM44h4lGZ4z5+VRu5WuVi+I4mEw01DB6qX0zC+zhhDx6Xeez8vptv0jCwnzmKH8X3vCk0hXZoyg2sWIYra3Wa+pbxcIFE/InUKNPJTRPUi1IEluxBRJlmcVkRvBL36kZtW+lroNAorpah25M1Hw+PPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656727; c=relaxed/simple;
	bh=8OuEqS9mOLWKFhq5PGx35RUWy1TYEDf2dsaa6U/gv+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otmz1Ssm+5uywyWb7AwMgnfcSMDctETMXAlZejBBscQWI7HKsEz2RHq763avQTnCpYI7Nm0p/k7m1KbLqts6b9TUU1yqwQmjEwb+EGll6YWMpyYQREW3lvehcgM4IU43r7uV3aDGXlPTbT/HBJxmWYrVgNKGrP7TdckCRXjVQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZXij3Uip; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36865a516f1so3053248f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721656724; x=1722261524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5dlFxSv3FmJDU7tjADRKa+8ES8BSMLz55RewmO5kow=;
        b=ZXij3UipOiBzoogXL3F0IMg8FJKiz6F1p6hzXvH5b6sxGJ1EzbSH47fCWb+hZUj3v7
         8ufIQkxNABhFXo5jnTEQ5anu+uAdE28UF0WQRBa+/SbSz5+a/ZP6tsDix9F/NjqWBNM7
         ktRxabw+JFTJPDlt4zx04cXt9txgk6HmWPp+g87Jo7bzyCBJP18jzerMWLtI2ekOhprG
         eWZ+4l9pwgec2AVAOUT8NigHW7k2VyuuVuu0BzfotKayK+DG/JT5MdfTM5glAtfYjzGb
         hmVau16/TTHxog21xsoRkVSgpgiboXJA4C+dfy+YswtZcDqKlSeS6YPMumfD75x6xOkf
         QREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721656724; x=1722261524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5dlFxSv3FmJDU7tjADRKa+8ES8BSMLz55RewmO5kow=;
        b=PhU6mQ9jc0vUVPYHgqGlabOQ1iwywQreZNjdNwNVYhEcUagzXER6Yov+5d7iqtulud
         Bqtk+o/ENDaHatbdTXpu29D0ZlC4BtqjRpj3e3YUylcPk+vB0+O8NfmEX/LhpMJtXyZs
         KlAsxfHBQr1W0eXIW3ZxukRwYmee8kr4I6vDA26xSaIBhNh+b5QHuVVyZG3h5Auk9tn3
         n+2jY1uO09Nwexsg5sw7FWxKm9QGyGcEUVFH7cYHtH5RBuWvuj+BMR3lg81RoiZZeluq
         Vk5OefRjUIf64nQT3iP2nMEH9gQoSqQPC7CSyLj6nLSn+BytT2lAM7YKOAphnxLWgA3M
         qtMg==
X-Forwarded-Encrypted: i=1; AJvYcCUh+3txRb30hGrr3+tL8yp1zXNQlDoTlM33OCTtBn+Zy8QCX+Nw/3VCcaZppDkgm41SeS+NRBr7KaTJLs1i/1xF2YKXK0YArAXgo5HK
X-Gm-Message-State: AOJu0Yx7kY4WpxZXd1TuJV6be7uzU+EGUEQ9F/Rry8mWY1j2A66RvBrt
	Dgpk69dLwznQOmslGiLKpsSzqKtGf+otH07/6eOJeoki1bfN6QdfSg6BMDVH0TM=
X-Google-Smtp-Source: AGHT+IF75AIN+2RIZgOvNN1LxGtFJ+siGH546Ar1hpo7piMbmqYC/NjoJ/ZAr2en/66rK6KOJRpccw==
X-Received: by 2002:adf:f303:0:b0:368:3ef7:3929 with SMTP id ffacd0b85a97d-369bae4cfdbmr4886297f8f.22.1721656723976;
        Mon, 22 Jul 2024 06:58:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8c014esm424599266b.133.2024.07.22.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 06:58:43 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:58:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH printk 1/1] printk: nbcon: do not require migration
 disabled for nbcon_get_cpu_emergency_nesting()
Message-ID: <Zp5lcOihG4d6SNjt@pathway.suse.cz>
References: <20240719134818.3311665-1-john.ogness@linutronix.de>
 <20240719134818.3311665-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719134818.3311665-2-john.ogness@linutronix.de>

On Fri 2024-07-19 15:54:18, John Ogness wrote:
> Since entering emergency state disables preemption, there is no
> need for nbcon_get_cpu_emergency_nesting() to explicitly require
> migration disasbled. Either the current CPU is in emergency state
> (and thus preemption is disabled and the nesting level is not
> zero) or the current CPU is not in emergency state and the nesting
> level must by definition be zero, even when migration is enabled
> and the current CPU could change. The current CPU could never
> change to a CPU that is in emergency state.
> 
> Reported-by: Juri Lelli <juri.lelli@redhat.com>
> Closes: https://lore.kernel.org/aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos
> Fixes: 46a1379208b7 ("printk: nbcon: Implement emergency sections")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


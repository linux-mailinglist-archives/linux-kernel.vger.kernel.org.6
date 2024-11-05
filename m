Return-Path: <linux-kernel+bounces-396648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1098B9BD015
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D34DB21BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F101DA60F;
	Tue,  5 Nov 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LzxGx01w"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E973FB1B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819326; cv=none; b=CWOEkb53DfFdEfCHDGgzu4qSRShIln5RX7lkOYzjTDxindiLOdc3VhH02xcIU9gDlxaYFsmibiDvNtxR8BGTWrBHPvxu9rWk2vAwbb7PaJaL26skeTrEyna2rPN8cDnU81vzYh1iLymdP+4QJRXfcde5KA+NhQHNS495a4d+Vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819326; c=relaxed/simple;
	bh=t9EeLKZWl4Q/8ki+8267jQ5gSkawxfzvw/zpjaYn+Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIaFX1XhHREqvScyJXpoE4PtaPuoP7QRMQRFZo/J6OC2YP+JeHjiy4TbLrc8fS/z+Bkf/pLSPHoJpChRa89kqsN1QQuVJHUDx81w3AJV9KUOhQroXtUgiQPq3W+JlgT+hTbGcK47mq5DqUA8tX4SOva0KwpPhgC55ZfWJ6ip5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LzxGx01w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so3217780f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730819319; x=1731424119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUxCkirX3fcz8EKMiWH4Usqr8T0fYPFHcyJ7GQ4yEOw=;
        b=LzxGx01wjHzo7m5Ji8LlQOf0riMguZBrn6lsZjCevGfk67e0rbYTSMSTNM3ZbSx/60
         Sh4qfmpqlARZmOZZUV6InDEbYs17W3koFIZekpBCCs1P0mapcCVrbxEZq7CxCm7QYic0
         1PBf0tX5G9saeiShLJc9ogr11dvBUo+k46wziRD3HdNkXJ2zYSu0Oabk+111URLvFiOi
         JQ5Wcp/XyYky5x3k+86dQITXbPsfMXjEaXnizCPG0BnT6egx6yZZVSN8CANlGPoOZRQo
         w/eUrgHh9Nd5yqMdQ9R6GS6E6qyoCG0MT5Jef1FfZ1dbgtKqz5jzmwwZ1a8KZvpncBmP
         dYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819319; x=1731424119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUxCkirX3fcz8EKMiWH4Usqr8T0fYPFHcyJ7GQ4yEOw=;
        b=MEEeSNaYXWtQqFqC0XAn0UVaS3B30/fphL03OgjM0OSlBN5LUi5KpYAKN8Z3wbWFkb
         ScMDOoKrV2zjd2g3/v9Omn0cjRLfw2NjMWWQczPEsF9T2DMELi9/Efvun6J8XPFfSfD/
         jiBFv+XvsO4zO6CAeoKvU+RAXrFusGLQ+b2QWdEFD0ryhbQLMtDmMsQrmrCbFYAuSHOt
         J/bNZS89VwqsZSwgLjZ5IA/jYvemlM90pnBE4GPQe8Mr+Ts2wc8zRPrXu/yCxEAR/OK4
         0yadnYHBhuFFDhC5vUi8rcskr38IbN5AkTY5En9O6J9pW26SaGAUgAwypoSxrZMflqvc
         SsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFNBwttCL4c65aV39e9crmZf0T419cE89EjxuSZ7EwrfAtSFz3P2Ais6f2hRVD1wKQ1DT7n++7aQKwi1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWH9mMYVWIHXRRW2QqRm4MkRh08EdX4b3lKjnb+kwkqAzCnHEw
	mWkKRc9L56oRoWDP3gYpsXGIs8laFIZVBa2Sw7hyt9lZyiBmqvAY0bb6Vof6zxE=
X-Google-Smtp-Source: AGHT+IEVGh0YDr33UgdsOxz1TsfADySCUretSIOquT5nwmqrcEyxhuoOfsNUsaAlQ8eDwQ4WBC2qnw==
X-Received: by 2002:adf:ee4d:0:b0:37d:45f0:b33 with SMTP id ffacd0b85a97d-381b7056d6amr18907652f8f.9.1730819318758;
        Tue, 05 Nov 2024 07:08:38 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e74casm16378570f8f.65.2024.11.05.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:08:38 -0800 (PST)
Date: Tue, 5 Nov 2024 16:08:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] drm/log: Implement suspend/resume
Message-ID: <Zyo09KEPSijfoYL4@pathway.suse.cz>
References: <20241105125109.226866-1-jfalempe@redhat.com>
 <20241105125109.226866-6-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105125109.226866-6-jfalempe@redhat.com>

On Tue 2024-11-05 13:42:25, Jocelyn Falempe wrote:
> Normally the console is already suspended when the graphic driver
> suspend callback is called, but if the parameter no_console_suspend
> is set, it might still be active.
> So call console_stop()/console_start() in the suspend/resume
> callbacks, to make sure it won't try to write to the framebuffer
> while the graphic driver is suspended.
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

Just to make it clear that I agree with this approach
for this patchset:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am not going to review the rest of the patchset. I believe
    that John did a good job.

    I actually made a quick look at the 2nd patch and the integration
    with the nbcon API looked reasonable. But it was too quick look
    so that my ack would not be much valuable there.
    


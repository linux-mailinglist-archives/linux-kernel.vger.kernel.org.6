Return-Path: <linux-kernel+bounces-303288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB9960A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B671F232FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E11B3F21;
	Tue, 27 Aug 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rdoz710v"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2341A0B1D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761750; cv=none; b=Bb4b0hcwMpbiGlL0cusEAk7NbX6AeaNtbt61Hn4mUReorwz0H+hNz//ompaMGZ2eAEZTQ0qTuszQ06n6V3tjkvF4ZfdiQeWMryJjKXku/vMwap1FBrlNe3qSx8Qsga9RbxnztD4tm3dvZGGNZNPjcb2MiQ9b0+kQR5m6V6Fh6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761750; c=relaxed/simple;
	bh=3uOYE+mIXsJ0wb/dHZbtx+/YyevNfcViCakl9Mm1RrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOkYnNT4XTn6fwch7kEaNLP5TK0YTNz08NXOe3aV9bfJ3Uz08+QRtEWmL5xSMAcbZd7f+b8DU4qrv9eSB5iCCxpuz7ftEPUT5RCW/nZNOn3BoU7ABaUgm6H2uC7PlL51WP4lcWb8D7WWuNq5cR61vjMXd6pyW2k96X1pwTc9uE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rdoz710v; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso7512599e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724761746; x=1725366546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJuH6iwKr9N/qtNQSzjZTkwvjJ/Ru3lKhLtW+b2VSmY=;
        b=Rdoz710vTT83F94AFMBOxDtaYRvpUn2mujnn1pArGa0iQU8HMuz6WdQeje0WdBmyU6
         KPVeJatDk+CRgHl7PjKPDCgk7BwInGENPGOtKaZVvlaeggT6G0V4vPatpY0Lg3UfLiIQ
         4S/+6EGsOILJkBxkky3NVMTNXxYWh1Csp6GpZqJO8oqkSJMoBuACBZCD8VxM73g9jShO
         1+VY33nSs0jZbwnW4kzSv5+9bz5hEZTJ7/PXXikFAeTYDW2B/n1zFMFLY0x5CmXAS9GX
         qHaTuWxmWxpcS0IMUNszWTeCmuKud02kFUInRFbG5eynXrs2p08zr+UiJF894Z7tiL/W
         nITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761746; x=1725366546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJuH6iwKr9N/qtNQSzjZTkwvjJ/Ru3lKhLtW+b2VSmY=;
        b=jogx8++pS/FlNuZh91YAdDpCvsBaRVke1cg5eFrLCtsuIeZ2J+P6G/a34GNjc1kqQE
         WB+c0Xdi02PYfVrTKpl+ige6T3YH2WH3zubZABOLvJveb/nDE70qHwXWS48ekgsuv01Y
         jpuni9Rp16+iMDwVKaM6vdNbSU7AcYAJV+Ie5va2rz3cCxGZ2dGQy9komzqdUitrDCPg
         tOxq0rpS5qipOwXr4GH6CA5ln01MydIBf8hB7jAmHrFI1MmlkBu7CFwA7xoYv1hwIxpY
         Iw8XWBXdPZUnYXVepo8+SCtbpRvIh2J54Xw9MMPTDbnwQSKUgmiwX1PAkozpHMarrWEC
         qV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcg4/5ixgRzq3h7q0f8V+dsT6qP4x2uVWStA5SjFNw7YO0D2A2nIE6XSHjZUDDbVMhO4JQ98BKNiqxj2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhruicPERp+apK+WqCqxa+vHl3NnvE60+Rn57OnV2GWd8CsqiQ
	Jx2AWz6mdU1Nm0dUHHCM4eHIWF6AuZeC/OKg4eZ0vwOb865nYIEqcDQ4A1i7ap8=
X-Google-Smtp-Source: AGHT+IG17teBwKfU5bvr4dbQZLxH8+JlqtDl9IqgJqu8IxELQUdSGZ6HJsa6Lr/P500g6R3TaVlooQ==
X-Received: by 2002:a05:6512:15a8:b0:52c:adc4:137c with SMTP id 2adb3069b0e04-5344e3c9830mr1549194e87.20.1724761746018;
        Tue, 27 Aug 2024 05:29:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549ce94sm104587166b.78.2024.08.27.05.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:29:05 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:29:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 05/17] printk: nbcon: Init @nbcon_seq to
 highest possible
Message-ID: <Zs3Gj-o5_23FMukQ@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827044333.88596-6-john.ogness@linutronix.de>

On Tue 2024-08-27 06:49:21, John Ogness wrote:
> When initializing an nbcon console, have nbcon_alloc() set
> @nbcon_seq to the highest possible sequence number. For all
> practical purposes, this will guarantee that the console
> will have nothing to print until later when @nbcon_seq is
> set to the proper initial printing value.
> 
> This will be particularly important once kthread printing is
> introduced because nbcon_alloc() can create/start the kthread
> before the desired initial sequence number is known.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


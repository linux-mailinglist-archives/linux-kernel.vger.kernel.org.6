Return-Path: <linux-kernel+bounces-219106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE490C9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507E01F21732
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585418A95A;
	Tue, 18 Jun 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUgjzOyx"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7418A93D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708761; cv=none; b=c3Xcd7O1A2v3xmkE5hQ5n6F7pqiLC30sm/MfcIkgH7hoFREY+PCDOEtnYvzrVJs1t14/mNIaxSgvN/qp6NKqvO69SMEA5UiAO9hKXjsI7adXun+ofJXhq56VivJIWl0zjqqR9vVm8i2dfrH9YDto0jXT0wMrqoepjy/eLm3/w9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708761; c=relaxed/simple;
	bh=n5cl1dYQYQevMiCRiKGd6AV+Wnx5d4GEMczd9QBcohk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rclqKX6K1E2KyfUIdgblql4e18d6Hr8GyIP5pH3M827rw6sF2/QwlTujWi3B3WCj1QWigyeZAMNjZ5Y7g2dRH+Yo/XtF3X1WuB/C3bAuKRtlXH0UIy6nc0EdZ4/Y7SSxYuHEMttq7fe5W5qecTa70d5dJpjKnQ0qtYR6tY+0Wz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUgjzOyx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f0e153eddso686492066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718708758; x=1719313558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfMMGdvlfsiEq5DK6BWtCQYn7Wz/1sUVrXCtNdCmAZg=;
        b=NUgjzOyxmL80FeqCnGlu9vMEwmOZkR7FabL8C+efpbkSsQPHaxpv9YnNzgCOY98L+v
         vd+uihYbmzSI+U5KOwnsUd+D3p/ut/3HNjxiG0kGr3VQhGh6rm9HkDwCnOReH4iOwl1M
         FvtjuNVJDd/8JHurqtiVGVrnBAXLPuVxuAtP1JJEHUbGWk2xURfXgiDXHg3ojFeIRmnm
         fPapzhctg6DkXs8zz9vmlkMCjKzTLFfzWggekG9AnQZwuCnmmUAB5kzMEmIb4aj7BVf/
         BEZRVUYE0938TZWs5KmwzkeigZ2luY5+h1MdJs5Xmt+v2/LEC8P7e8gOfdGVhAJhUqz1
         QG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718708758; x=1719313558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfMMGdvlfsiEq5DK6BWtCQYn7Wz/1sUVrXCtNdCmAZg=;
        b=C7ZFxgqofsIUjVaiFHIsMQZxlVv8rpSkcuM5pYiGVDXJ2uQbFP7Iff4hXeL0Yl6DZH
         urjrT25LcXvh6PnpEvxDw2DVBstJtiQkZbjO9M4etN1W6qK4i29SGKfv0Qcspbx98GF2
         DULEMQPzpcn4/BUYA03UReKZR+QzH29g3gIYuY1uS4mowErIZzQaGVAP82eYETv1Br3z
         NMwRNQePkjdR1b+h7hV4c7emEIw6WcRWsuU0kJbW2zABjihEN+FFLEdeJJG5LFT/jCb7
         VpuVhP9ktJgSKSaE5oivUsEmapNMzmxPNOylgzuHJujPDXfMWkVudp2isM4nVvW0iD6H
         wwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsDXVuKgTxy90KBntSfZWOo9NHDpmvjwKyshjndW86zDNvqwVYXht4TAQvkrWd7m8Z+u3iLjWU4JtqEmrwOMDTngbxHeKb1upU3eqv
X-Gm-Message-State: AOJu0Yy54WO7kU2YkQUANUGm77f9lNQW4RvbaMinNenRilhoStHbcgkH
	CJ9uOqOK22LjLxim5AyXuQ/ww4hhxyZy/AG+YHQ6eY5rFiuwfOBQ+ZR1Tc5+
X-Google-Smtp-Source: AGHT+IGkAsPuwFXWJbCeYX8mZPG9jYSFhfnOUVPKQRqrC9lyMrOwm1yZeFYd42ba8PsfHpBCnZhJog==
X-Received: by 2002:a17:906:c091:b0:a6f:5150:b807 with SMTP id a640c23a62f3a-a6f60d3cde2mr815678566b.35.1718708757391;
        Tue, 18 Jun 2024 04:05:57 -0700 (PDT)
Received: from andrea (host-79-51-73-205.retail.telecomitalia.it. [79.51.73.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3ff6sm606347066b.38.2024.06.18.04.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:05:56 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:05:49 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Xu Lu <luxu.kernel@bytedance.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] riscv: Fix local irq restore when flags
 indicates irq disabled
Message-ID: <ZnFqDRXRjoHMaJXW@andrea>
References: <20230725070549.89810-1-luxu.kernel@bytedance.com>
 <mhng-a0239c56-385e-40a9-8a71-45d50e28b45d@palmer-ri-x1c9>
 <CAPYmKFvXf7q_8QzFe4VFL1s-j0P3ZGSZ8nG1q4HmtU4rzek77Q@mail.gmail.com>
 <CAPYmKFvqpe48zaLKrTz085cJcO9fwL+BtHujU4p48onR1Nodfw@mail.gmail.com>
 <329b22c6-435c-424a-8211-b9a029b0897d@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <329b22c6-435c-424a-8211-b9a029b0897d@ghiti.fr>

(merging replies)

> > > However, if local_irq_save() is called when irq is disabled. The SR_IE bit of
> > > flag returned is clear. If some code between local_irq_save() and
> > > local_irq_restore() reenables irq, causing the SR_IE bit of CSR_STATUS
> > > back to 1, then local_irq_restore() can not restore irq status back to disabled.

But doesn't that represent some bogus manipulation of the irq flags? cf.

config DEBUG_IRQFLAGS
	bool "Debug IRQ flag manipulation"
	help
	  Enables checks for potentially unsafe enabling or disabling of
	  interrupts, such as calling raw_local_irq_restore() when interrupts
	  are enabled.

in particular, raw_check_bogus_irq_restore() in raw_local_irq_restore().


> This got lost but this is still correct and needed.

You mean because of the mentioned rtl8723e example? are there other such
instances?  IOW, why do you say that the changes in question are needed?

  Andrea


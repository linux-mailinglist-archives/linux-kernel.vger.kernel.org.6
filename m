Return-Path: <linux-kernel+bounces-510649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F10A31FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBBB7A44F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF99204691;
	Wed, 12 Feb 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhE+aJQ2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D15CB8;
	Wed, 12 Feb 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345417; cv=none; b=CJFn5ODtezDY1uyuZ+Zkk01GRKrynX5D6y9fYx0Cn9WIE1//h/Bgp9vsr5rZ9XHeiuckvw/o6RwVKKUoD4Jt5miPC1NM6iTrNt0b2svnhi962K1cTv4Eb22dj3hSxo451h95Tep9yTeWQsE7enQuOJEiYa0WGHlvdUVs5hT8zZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345417; c=relaxed/simple;
	bh=wS5s9hksR0MLT3HaP0K5gvrOuEBXey9Zmp+b1T/R7+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyJkYbDRF9mNEd7KXE7UErDo19ZkxA+f/My6BBTxbUJ2E31wOiataaZm6//JJWK0VyiR6/ISjlB3VaNVOPBSQ2LBYfZGhp2XmhjCC2uKRWu2LfqEgPYLzP0XPAiOCl1VuBNcnDW4FOUZdvj6FqpjlaHeml30M6YJWNqgby13aGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhE+aJQ2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7d58aa674so325431466b.0;
        Tue, 11 Feb 2025 23:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739345413; x=1739950213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc1QFWT/cgthoMhaz+tPsi61Vk+kKCWwtNLYtiSq6hA=;
        b=hhE+aJQ2llofqBAjEmSldYskFWihg1AXLcOmuEsRaYmEwYslxxyGinNxTuV33T0wro
         M8pptHb1WLBllcyQlViq16jh/jVdURWppiiEA5akKFVm8x72hmNw63nXxygKTIQsIUCd
         CYrz7cO7hWLX9Du2ESvhU65RTdpWgveBmuJx/wrCzLINUlq2emuPCtNDGLrM/BXnM6in
         c3hvc/NTFys9DcXGbJbIXFrRyvteKxcIoO6Hq6yzqB1FFnAZt6YFpcs50OtMOUKcnp9z
         flCWhLtXbaO8qs7O/4ZKQy1m1GxqRHX7I23fM9qSMTjCQxBJ5o3Rl6tYZcWlg71nWku8
         njgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345413; x=1739950213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vc1QFWT/cgthoMhaz+tPsi61Vk+kKCWwtNLYtiSq6hA=;
        b=vmZcFOyXn9ICQC+61mrGyilF7EY7oxuA01iQtjKZeKM4hsEQ0NP96f47VZcKnDycRE
         6slqwKDClVJvzBiilbdrpI4p9VFwVUspARKB2hEH4PEll54pH+MK+OdK2ie5X4yC/ERN
         lJch88Q7pXHiLHtKPBD1hpNssrt/4HfEPpBhtmbJgyOAmrUD+zoWZjnFg9d0DHcQhFp/
         hwltGShSxhiV3hBr+bUxDDcXagABixuqBzD6HYxapEar3qVzC9W5S8vc2FL2wSwULBYm
         BMT3WMCpzrhMd5us+5I3TRjiVkDETD14FEP7CVvPMqVjmKiir3htyVc7yMdyQEgSDGX1
         8R4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8wfHrCyDqlK581TXeC9SZGdImcG8cCKxbG84QVsGV8gFK54ZWiYDhhKrtQkzGCsl+tbQUe0lUHYn0@vger.kernel.org, AJvYcCWAVhgz4kWJ/BZFmPYaBwd8VGY/sskIb0/+awCg8Thgd58a0vpajdyPKTTOY7IfFKAIUYC8bQNhq4AeCO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcNWslH/P0qYXjJrNhD0ZsQqPLil/VViHhi2Wtgt5QWJkZhNZ
	ibzZI6LqDFbDZFaHebMedOa997dSsHKKTMm0Py0Qecim8j+LYr+rTQ+9Hw==
X-Gm-Gg: ASbGncuZ0wJH5dmvmYNShDZGTYYU2r+Y5Ktq+CQOCSuc02IQBBBRf2VZUbDR8lqsj0M
	6fEvuj1T4xqoNUw7zsHiuL70Mf22B38ajCD7A90eYTKw++cV6Ur0tHzZRPrbTTTuklW01xmeOcK
	rRuY3oCraPCaL7ihHdiIo9LV3Ra4qR/U0Hhn4eaQedk4CExbt99gXj3zCe1xnWNM/Vbn6lLguQz
	Jdwtj6Wm9+lvnfZXUMJg1mUUYA2z46WdjZcpgBxWknR85Fk37t7A/TaHpvIq0MDOb3yOOCQOwR4
	essM6F/UtTSPpRcF9bY88WglhFUg7P1D
X-Google-Smtp-Source: AGHT+IHvARJZuyGyIzVt3aHpJBrrqcq+pOl4+qQKuEruKJk2J6TnlkfNeG+CVynG1Qyic0MjEwnMAQ==
X-Received: by 2002:a17:907:da9:b0:ab7:c1d5:14f9 with SMTP id a640c23a62f3a-ab7f337505dmr176444466b.10.1739345412419;
        Tue, 11 Feb 2025 23:30:12 -0800 (PST)
Received: from foxbook (adth118.neoplus.adsl.tpnet.pl. [79.185.219.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab78aab804csm1053924766b.3.2025.02.11.23.30.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Feb 2025 23:30:12 -0800 (PST)
Date: Wed, 12 Feb 2025 08:30:07 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Niklas Neronin
 <niklas.neronin@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] usb: xhci: Skip only one TD on Ring
 Underrun/Overrun
Message-ID: <20250212083007.04383b5d@foxbook>
In-Reply-To: <7bb25848-c80e-4ba8-8790-8628951806b3@linux.intel.com>
References: <20250210083718.2dd337c3@foxbook>
	<20250210084220.3e5414e9@foxbook>
	<7bb25848-c80e-4ba8-8790-8628951806b3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 17:41:39 +0200, Mathias Nyman wrote:
> > +				if (ring_xrun_event) {
> > +					/*
> > +					 * If we are here, we are on xHCI 1.0 host with no idea how
> > +					 * many TDs were missed and where the xrun occurred. Don't
> > +					 * skip more TDs, they may have been queued after the xrun.
> > +					 */
> > +					xhci_dbg(xhci, "Skipped one TD for slot %u ep %u",
> > +							slot_id, ep_index);
> > +					break;  
> 
> This would be the same as return 0; right?

Currently, yes. I know it looks silly, but I thought it would be more
future proof than hardcoding 'return 0' into the loop. The point it to
simply stop iteration, what happens next is none of the loop's business.

I hope gcc is clever enough to do the right thing here.

Regards,
Michal


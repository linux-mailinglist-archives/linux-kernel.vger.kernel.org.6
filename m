Return-Path: <linux-kernel+bounces-281251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E594D4D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E7F1F2153A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F93FB9F;
	Fri,  9 Aug 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mMEHWQsr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HyZO5yer"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0372E62B;
	Fri,  9 Aug 2024 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221404; cv=none; b=YtewPrnbgmOU112nXJ9H01ek149TEKq7qCicJes41NmdQ1OV9oGIzi506+J/hX+SinMxv2BtioKqAQVr/5g/5XKaN6cFjH6wTcIASuHEsS3Avyq52BnMMVWXduSTIDDQA3+RzlmO7/APhDdJu2SnYZ6l9ZxYjxTB4HEPyuOvVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221404; c=relaxed/simple;
	bh=YQ4EoNgLgD60E5wpWFeedbLF+CH99tvArMvwaicBdt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UfvyooWh+fePJZsthuvku270NSByax4TNsr7zFd8RPYpeWdE+FOteouEi4xasxELV9O0AYQdOctRnFNIYJ/xA5OJSjMrEvbY7KUntawQEQmVsZdJIBYbRi+YrlFf+ly22bT+UW3rhKUVIRnsDSs9wcUNUGvlLnsBymedv3dcaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mMEHWQsr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HyZO5yer; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723221395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lad6JRFhSZKJI5gZQ/lmCh/7wQ6Ei1ba803Nv+Zi1RI=;
	b=mMEHWQsrNGVvGvXdR1EZqk2YryIt3d5mhUXLF/9dGvAQg2FoVmbTHpRElX5RLX5asmI61/
	RZJYiq0j3sXnJRYKVXHZsEX8LD2PsJnz8iIdPr0Kl/iDqV4hYTaJ+Zs2s45QFXAJMZHX26
	ZF+lwrhSkBJ6cKQ2tDTtxdT0juPJf3N6kH1UGxtnqANe1DKUi4J3R7eaZYA4R6Lofs+x6+
	yXjABIeqfDaZFYyJsJrHBZ9S0j5FuXX0QBPZY9nF5SaV3sVCg5uzPesYDRXC95p5p6/GTI
	z2G9jHfjlpfZtgZ4ELvK/NFlg58jmA/s2zaEx8Yz5FLzxppwRMf/8BXnSnoWmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723221395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lad6JRFhSZKJI5gZQ/lmCh/7wQ6Ei1ba803Nv+Zi1RI=;
	b=HyZO5yerG78q+JgUWgUaXU8FGvyJL7433wSu5+98e4JpFVtnFBPp1iXDvQ/Dt9szPhVOf4
	3QtnmP3lbSM2a2Cw==
To: Marek Maslanka <mmaslanka@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Marek Maslanka <mmaslanka@google.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Rajneesh Bhardwaj
 <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 2/2] platform/x86:intel/pmc: Enable the ACPI PM Timer
 to be turned off when suspended
In-Reply-To: <20240809131343.1173369-2-mmaslanka@google.com>
References: <28567169-4588-002d-85b8-906d22f12f05@linux.intel.com>
 <20240809131343.1173369-1-mmaslanka@google.com>
 <20240809131343.1173369-2-mmaslanka@google.com>
Date: Fri, 09 Aug 2024 18:36:34 +0200
Message-ID: <87h6bttzzh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 09 2024 at 13:13, Marek Maslanka wrote:
> +#include "../../../../clocksource/acpi_pm.h"

No. 

  include/linux/acpi_pmtmr.h

is the right place for this.


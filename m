Return-Path: <linux-kernel+bounces-356636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4499646C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5681C24056
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88C189B8D;
	Wed,  9 Oct 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rFCKqrWi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jw5ag972"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC541898EA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464832; cv=none; b=ivBzvUfQJw+Y9RVhWO/uWuZC0UKUuVuysFCb/JUsc91QyUoGEaOIVLhKCAhrZE/+vhUnOCOaBw+OCYAX+jAuFJZnFX57Pu5rAWcDqhpjXWLZKAUroW+jZLKwDvKgbEJxjxYZGHUEyKwDqHXFdR9feGwlsIM9Kx+X1XGj3VHEXGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464832; c=relaxed/simple;
	bh=jOeSm0q51RNOoVF/d7UvmUtwoy632DU4CFObhbeogAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=afQirXD7XNDyGOPGZj4jTxFETy1wO4WWRXm6dtG0QyxRIHhqvBczFu3LTjxaKltR6TbZNVuO5UXLlxrVOu1CZ7kOomyjlp/gKGAkdjpOY/RQpNcWOS/WNqJuCbkIA5o3kmIM4dXWwNIdUNZJmELqkme70A7yzSHWWMji1VE168M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rFCKqrWi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jw5ag972; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728464829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xL73I3GcYaobKuOkzn020NkLG8YnUxl7u7/0V/Xf8g=;
	b=rFCKqrWiA95IfRmS26qn6E4B64vu9pQEN/5VsKdiMkSYiqXrZJRNwgghdIJI4rZa8ab91O
	iHITGiX2eUUdrtZ03fJoXdfMzWoZE9VkiQe/hOqxzQNvLkw5B3y1B+6Y8uXHZJSTPcSeYk
	RYrxMNUuY9GTPtc5VQ/LdgV0kv3W9iKS/cukyj8Vh5q4magX3Y6vHqUVIZnKpW5+HbDr36
	Ax+eLuP9psMk/GNDsHbs8h5wlqaIEt3cnOcsNx+/29XPHsmIqcgzCWBH0bLNyf3BZEbDc0
	qC0FQXMSlxInGzt1takz7Ei38nTry7LU0REEKX0G594GcGL3bvpcCA/WiB8nSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728464829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2xL73I3GcYaobKuOkzn020NkLG8YnUxl7u7/0V/Xf8g=;
	b=jw5ag972d1+u4l1nK4xH7oXAWXkhAW0+Pwuxs7ct/RoXGINhFZR9UMBeHcLCQR4VFUz/ld
	HoZ2WHcBP0u5l2DA==
To: Bart Van Assche <bvanassche@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Bart Van Assche
 <bvanassche@acm.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 06/22] x86/acpi: Switch to irq_get_nr_irqs() and
 irq_set_nr_irqs()
In-Reply-To: <20241008202601.3737326-7-bvanassche@acm.org>
References: <20241008202601.3737326-1-bvanassche@acm.org>
 <20241008202601.3737326-7-bvanassche@acm.org>
Date: Wed, 09 Oct 2024 11:07:09 +0200
Message-ID: <87zfndr6f6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 08 2024 at 13:25, Bart Van Assche wrote:
> Use the irq_get_nr_irqs() and irq_set_nr_irqs() functions instead of the
> global variable 'nr_irqs'. This patch prepares for changing 'nr_irqs' from
> an exported global variable into a variable with file scope.

I asked you this before:

 git grep 'This patch' Documentation/process/

Please fix this up all over the place.

Thanks,

        tglx


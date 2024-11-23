Return-Path: <linux-kernel+bounces-419245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A4C9D6B49
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEF6161CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DDD178383;
	Sat, 23 Nov 2024 19:55:51 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6517C2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391751; cv=none; b=B86l+B0hR28W9aKxxLxuwdarvf5YQmYauMSZZyXdlTb0Wiw0QsOSDueQRY3lfslY+Yp0K/YXxvFQ9ECMS+bL4jaB/cbLbHry9vyfU4Hwnqq+RbPKQitzpl472td7ed4IWjDZd22ej+51VQijZ0HThFV2Mc78jc1Cfijh7mnwsHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391751; c=relaxed/simple;
	bh=JXfIhgh8HkAwewLXXElARlOCEMiN1yj3hdYbrmk1qsM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cln/vGeWOrsy0XpMkZGavxi3sezkjBeF9mJuK9FqDmQPHF0zJqTAPVEzAxgYT1VeyuMS5p4LUqA4sF8pEYvjizpWymsslLxalt5rpj4h3OrIbnHDdgpKDrJgK/6BKcU7d6jhgA8TFMKHGlCTS0kKqqMfqxYkGVyAJ5rw+U7SWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id edf28269-a9d4-11ef-827a-005056bdf889;
	Sat, 23 Nov 2024 21:55:46 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:55:46 +0200
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: lee@kernel.org, pavel@ucw.cz, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] leds: bcm6328: Replace divide condition with
 comparison for shift value
Message-ID: <Z0IzQlsP6OMCcXRB@surfacebook.localdomain>
References: <20241019073302.35499-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019073302.35499-1-kdipendra88@gmail.com>

Sat, Oct 19, 2024 at 07:33:01AM +0000, Dipendra Khadka kirjoitti:
> Fixes the following Smatch warnings:
> drivers/leds/leds-bcm6328.c:116 bcm6328_led_mode() warn: replace divide condition 'shift / 16' with 'shift >= 16'
> drivers/leds/leds-bcm6328.c:360 bcm6328_led() warn: replace divide condition 'shift / 16' with 'shift >= 16'

As discussed with Dan (author of smatch), these warnings make no much sense as
"division" by power-of-two numbers in modern world (ISAs, compilers, etc) most
unlikely become a real division instruction with all bad consequences. Even
though, some ISAs can optimize cases where foo / 16; foo % 16 goes together and
this change may break that.

So, please, consider not to send such changes in the future because at least
they are just noise, at most might add a (micro-)rgressions.

https://lore.kernel.org/linux-gpio/20241112201659.16785-1-surajsonawane0215@gmail.com/
https://lore.kernel.org/all/20241121105838.4073659-4-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko




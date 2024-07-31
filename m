Return-Path: <linux-kernel+bounces-269897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53162943838
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D206BB23FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236E16C6AA;
	Wed, 31 Jul 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZsD5LvFM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZiVLey70"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECEC1AA3CC;
	Wed, 31 Jul 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462406; cv=none; b=M98ZGwk/xQfYVcW0U3GzVOMnxitSk1xQffYIcLXsErGQ0+3k0ZZScQ7QJwLuOmSAaofPaPUWFZkr8Y0Vq4QgPmvjuW3iCj5Ob+bBuU4TLTi1QbihwJhEqgrUW/QCgws3CTvN7iQLo0tLu///oxZLBwQGjGqN/8KmeDlh6Z9nRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462406; c=relaxed/simple;
	bh=jz94UU4hVC0ykhl8YwuqabuD2j+eVBJGh+9c1JpDr8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=quVpB8Zv75UvY1ksT7mOVYTNK+i8E396YXqaFRNJYAuAU8xZRqbEO9Obm8QPniioyLg/C5olOcY032OD5RdS2Fqoa/afMhKQRZ6I45LNnG5VK3rIwwnnQ5/f8G8OWkghavL+S3iQPTtIUhET/uIuvBzgpA1dah0BSODW6vSR3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZsD5LvFM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZiVLey70; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722462402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jz94UU4hVC0ykhl8YwuqabuD2j+eVBJGh+9c1JpDr8Q=;
	b=ZsD5LvFM1NAdmnLWVAh7SpIpqT5s5lpBVyUBZ0v6hkHcXNewCuPj/neT9tHZyejH8M3f6i
	CGlOF7lDxTN48DsoXUu7KtPWWlQM38sdmvezPSW98HiKhqa8aPvuiAQYRJAnBcpM8N+1MB
	v+WM+XrxZW3QJ+rwyIGL/EeL48Ye+0KfIZGYNjasTKNT8vBA+PW+YSJbu+B3EUSkfHlgK2
	9swOKmNRrO4mez15gpSju7WZ0JPsJoR5gMXvKibGyru5uy0z0zEKWREi/ocNlkLMb8au/K
	0y4yaela1omgPyL4itF37EgdKTAfGimTPAfeoXb1/XyX/iBgsVff/Mb1sc2ZnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722462402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jz94UU4hVC0ykhl8YwuqabuD2j+eVBJGh+9c1JpDr8Q=;
	b=ZiVLey70a7cqQeUwox1KmykYfbP/wM5Ihkz4PKcHRUv6x/zCDAGeLq60p+y7O0suVVt7h6
	rbX/LpeZ4bMRWlDA==
To: Marek =?utf-8?Q?Ma=C5=9Blanka?= <mmaslanka@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajneesh Bhardwaj
 <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86:intel/pmc: Enable the ACPI PM Timer to
 be turned off when suspended
In-Reply-To: <CAGcaFA2eXzzCVqG-DSWDb1gruV4FemRC3W+dgRub7GgcOyf7yQ@mail.gmail.com>
References: <CAGcaFA2sQNRo9UThN-C1NOLtGUJ3sKzc=pEC9wdDWMi501iLsA@mail.gmail.com>
 <20240730120546.1042515-1-mmaslanka@google.com> <87cymu7tgq.ffs@tglx>
 <CAGcaFA1HJBYacvDAkZAO9HNhT2dZO7OdgcBYb59p7OJkVqQ6Fw@mail.gmail.com>
 <87h6c55xnp.ffs@tglx>
 <CAGcaFA2eXzzCVqG-DSWDb1gruV4FemRC3W+dgRub7GgcOyf7yQ@mail.gmail.com>
Date: Wed, 31 Jul 2024 23:46:42 +0200
Message-ID: <87plqt44l9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31 2024 at 23:41, Marek Ma=C5=9Blanka wrote:
> On Wed, Jul 31, 2024 at 6:33=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On Wed, Jul 31 2024 at 16:44, Marek Ma=C5=9Blanka wrote:
>> > Thanks. I'll try do this in that way. But I need to disable/enable
>> > ACPI PM timer only on suspend/resume, so I'll use suspend/resume
>> > callbacks.
>>
>> Why? What's the point of keeping it running when nothing uses it?
>>
> In case of Intel CPUs the watchdog (iTCO/wdat_wdt) is driven by ACPI PM
> Timer. But it may also be used by others that I don't know about, so I do=
n't
> want to disable it.

Fair enough.


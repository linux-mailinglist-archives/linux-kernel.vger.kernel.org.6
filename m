Return-Path: <linux-kernel+bounces-265773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D793F5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC621C22165
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF36114D6EB;
	Mon, 29 Jul 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cj0uVxbf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K4/IbCtX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4D14901B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257161; cv=none; b=qB49yTwcvW+sEm5URtAmV5KfVQFNw8HxihDtTWNuqYjXMOXBKy6VtcNqEt0rz3NL7XmdrYapdYxD0eqVu+o+Y6o/Rg+LNBdWP7q6w6M1T8F1/76fGwuN9eRzTqHEKB2waUkDmQ5cAPxB+s+s4didlbAl+FfOh9BugFlTOh34x3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257161; c=relaxed/simple;
	bh=AEPbKmM6chkZxgx+hj5vvevuDRXhT/V3tiLE00xF4lQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZThoW6TMe1DoDW3sDVcCqRDEtGCfHDefitqhrk4M54L9+wAtRXLaE2eFJxhkQDMGySyVL1tPj2zJvQen4NEr6KmAPGy4thfiidAzgHOurJU+8D7b088WVQ9SFo8YBTKUm/a1/CxLgkF31Z3mcj3CTJFlYbpnD5HhD0P7IVu+tL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cj0uVxbf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K4/IbCtX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722257158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEPbKmM6chkZxgx+hj5vvevuDRXhT/V3tiLE00xF4lQ=;
	b=cj0uVxbfLl8gqh9KL6ChJOlSuImLEdDlVLHEsMIoEqiJwstgIWzJFXa/VaLiVkTUscnITT
	9TQRIVOyXfv+YSvzD25y1qXusncLVgzu60iaXXVeFyjzKGV8gCm5TG7ebVHD5d3EV6umaM
	J+Q0AfUIVGlO1PqXZeoCwY957pLk0np7HWzTf1T0fsbokaLn5lO0MNdDv+fbDjXek/uZsy
	1CrQRzAi50I2SyNXQZEVC1XHF4Pf7JGZUvxqZ7cf0dvEWEvGoj1wdaA+AALFEiV5HPe8au
	Zt7CuXk+4I75Oz9auCIk6XI/qYfA0KihAw3aC5I4eIjym3l8fhrd/IPU56sJLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722257158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEPbKmM6chkZxgx+hj5vvevuDRXhT/V3tiLE00xF4lQ=;
	b=K4/IbCtXVVj+GLfWdFDa9SPLqek/qSUC1aAlUz6aqmTDzFFvpUAVVY2zNpxGhOYiQE963Y
	lrrHvUyOG49EfYCg==
To: Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, paulmck@kernel.org, rui.zhang@intel.com, Waiman Long
 <longman@redhat.com>, linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4] x86/tsc: Use topology_max_packages() to get package
 number
In-Reply-To: <20240729021202.180955-1-feng.tang@intel.com>
References: <20240729021202.180955-1-feng.tang@intel.com>
Date: Mon, 29 Jul 2024 14:45:57 +0200
Message-ID: <87a5i08iyi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 29 2024 at 10:12, Feng Tang wrote:
> So use topology_max_packages() to replace nr_online_nodes().
>
> Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
> Closes: https://lore.kernel.org/lkml/a4860054-0f16-6513-f121-501048431086@intel.com/
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Waiman Long <longman@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


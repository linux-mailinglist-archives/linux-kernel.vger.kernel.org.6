Return-Path: <linux-kernel+bounces-396611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76019BCF82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA0B1F23162
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C058B1D88D4;
	Tue,  5 Nov 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0sIonHN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E31D6DB5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817256; cv=none; b=JBDaJYJgm5P3YwPyckYNY4q0ZfTiBPBJ4K85pNj5bI7vFwJGToM2WWMp7d0OiQ9yCaDg3eO1rW/qhB1oYoKfUQjHlakSyEOAzaSsoLs1ChuZFeyItGLgW3yJtj0PyLzx1SHfnRuCIuB0DHLfOD5ZuNUFXmUBu8lT0Gyl25BVwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817256; c=relaxed/simple;
	bh=hD+jW50A9v2UTvBQbnXYkf5T9aYfPupW2GIZ6HrLCYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kagDHPTjD2y8nDWNLHELKgpZVxiQvpTsw4KryfWEywt98ZBTJnpOZOgIqnLaElMpjGiYA3emijGZ6d/IyhV2Z/mN8K/OmMoNzCgOASVgnlBsdkbYI0zp8OKtGtWtyF8KcO9WbzyAnjCTZjj7DkmrUZWtRTLsRhjx7b3GrPI7FTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0sIonHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A71C4CECF;
	Tue,  5 Nov 2024 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730817255;
	bh=hD+jW50A9v2UTvBQbnXYkf5T9aYfPupW2GIZ6HrLCYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0sIonHN4p5SG74tmnINRHJZHyDoiGrQIjmZ8fwFqLDpHEXy0XDIhmspKRUmFZM39
	 V/PpzYN8gSuOJsiO2TCAwMvKue/P0BxD3BKCw5Dk7dbs7/4VUhw/6IJsGoHzUSHQGq
	 JprpZ64DddJSMxX/FpYahA7DT46SGbuzywfGnwG2s6PTArrMvvMotd4PSYNW5utEJ/
	 L9ThBMh2f4Sxldsb76a/Fxk+h4t1ZKpCkjGyzW8nlhm230xE/aMGCkj11MNDwccEfx
	 Sfh6JjW5yEmY0AAP3tnUfRSH4wFi4dKwidUVd/5m36sunxTY9gkpvt7pNO2q0n1YNN
	 SrGIUGrJCyABA==
Date: Tue, 5 Nov 2024 15:34:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V7 21/21] alarmtimers: Remove return value from alarm
 functions
Message-ID: <Zyos4hxSBPUXGTdY@2a01cb09803abb1ce3ad97aed0fef98f.ipv6.abo.wanadoo.fr>
References: <20241105063544.565410398@linutronix.de>
 <20241105064214.318837272@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105064214.318837272@linutronix.de>

Le Tue, Nov 05, 2024 at 09:14:58AM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Now that the SIG_IGN problem is solved in the core code, the alarmtimer
> callbacks do not require a return value anymore.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>


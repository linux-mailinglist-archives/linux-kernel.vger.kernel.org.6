Return-Path: <linux-kernel+bounces-346631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76698C6F1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084A51C239AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4B1CDA17;
	Tue,  1 Oct 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTbaJ8nm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA01CC884
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815538; cv=none; b=sS4LHxjEdIBWq60MWQWfDHrBA9CCGPVkfsEoR8hTyVAdBDpS54oTbtRDkSxVCI6S2yXGv2SbmefFCgRckHUlWfxn3U7M/zlMGIi1yT+2O1+U0ONWlLsuuxYgkxJ5W04EWFeoR6EbAkD8qIiAtTasHmOjeCwGSl8flhrhTBMi9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815538; c=relaxed/simple;
	bh=QoDSuZkPYcAilW4IVDpAfN+ojOZ+M71HmuMigA3GyOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGw/wHEaOPqFLEHiacsgWlF7OKnC10jjh7ytdy7n5BPG+bdTYMrUFADF9/lHtnaWoHuXEx/7XoffvlzyuzCXvJW+63O4JxrNzFPkTJq9WB1c7myVm2CqPrTeZXOhnl1xx+ozr8hWK4nOZC7kzbDQZgizOqfySJoy44IimG7IHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTbaJ8nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317B6C4CECD;
	Tue,  1 Oct 2024 20:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727815537;
	bh=QoDSuZkPYcAilW4IVDpAfN+ojOZ+M71HmuMigA3GyOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTbaJ8nm0XWd6/SNWW5HYP88uZzffW2cMlUVvullssjfusIgvmjnZEih5kBVtsMCs
	 s2Gjxijyier0T4P3FWoaCxRF0Dhrm0WlE1P7GpzgRWwSLqT7Npar3EqBqXYF+4aCIe
	 zJstqIzov8sLUWBrkZ9gkqlRlljafznQHq+LMxa+Kblsir8csYbcKvX17Kb5M1F4Pf
	 7wRpCo2vIoIGMBVf7EfRjqePYoaKisE2c/3AOShD5hz3wI9LUakgnGIiHaUtBVd7Ue
	 txAzDMDQCW3f6a7Qrgcb5hBUGU7wNKTGjiH+62Ton7ZRofr/xmJ+ly7TrEMfgxeEEo
	 uaPYjjO0w6XUw==
Date: Tue, 1 Oct 2024 22:45:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 02/15] timers: Move *sleep*() and timeout functions
 into a separate file
Message-ID: <ZvxfbqXxJgjUjut5@pavilion.home>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-2-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-2-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:28AM +0200, Anna-Maria Behnsen a écrit :
> All schedule_timeout() and *sleep*() related functions are interfaces on
> top of timer list timers and hrtimers to add a sleep to the code. As they
> are built on top of the timer list timers and hrtimers, the [hr]timer
> interfaces are already used except when queuing the timer in
> schedule_timeout(). But there exists the appropriate interface add_timer()
> which does the same job with an extra check for an already pending timer.
> 
> Split all those functions as they are into a separate file and use
> add_timer() instead of __mod_timer() in schedule_timeout().
> 
> While at it fix minor formatting issues and a multi line printk function
> call in schedule_timeout().
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>


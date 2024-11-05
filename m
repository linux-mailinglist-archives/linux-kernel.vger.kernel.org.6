Return-Path: <linux-kernel+bounces-396601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D19BCF48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FBA283B01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662151D9A42;
	Tue,  5 Nov 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZumpCcL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877C1D8E05
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816977; cv=none; b=pWkhU7nojA8ka+99yySuAgnXZEvv5dd18eHkdPgC47NnMWUfFybHrgSedd1gh+lEelDphEWsSbSwI2ZfeVvBDQhMHtgfSoBZz/Mqggovrhjc7KNyVnNxdP+vR2h6fskMoIY/Hi3Hib2dTPli0+a42zcoScKmAxLIYiuHrW+s3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816977; c=relaxed/simple;
	bh=5HG0O3i3jJ+7ACrk1vsMhIIIYXyuF/rravbA/KQ+20A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzGyRHv9fSkFGjKFlP0cntzTFKEDjn7FiHBKq8mUiJezELyg9aInejNqUp6OD8kzsvLpbgx+5cCfFQ4QmZNTQmyJoywcfoCQbaNC7aXDUM7eaFk8+KlZDd/NvkvwFu7e1zXXeKCN39e+reIamKzgmru7gG0Pbj4aEoDsO7QI1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZumpCcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CFAC4CECF;
	Tue,  5 Nov 2024 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816977;
	bh=5HG0O3i3jJ+7ACrk1vsMhIIIYXyuF/rravbA/KQ+20A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZumpCcL5Dtt8A9EuvhOEXqdoLdz7adMZlPpH1XuGQ8fmu/fcOcQ4Kb7TJQDdebf/
	 zcGi12vNG3WGAop6VcUNTOi8I1CpwbDTE0ypId9o+PhYuWIXN/f8ht1F3EYpdXrl79
	 U+fJB6myGPfyd/aHiIUA4HRC42ehvoSyIiENaJf5lR+tkl6RdCz3T3b0CruaZu2SA3
	 eIXgD93P/S7MhAredao6fTQqan1FanLn4ey3GQ1d0AghihYdLDM/IvuywQ4B0HxccD
	 PZznxyfQmPgYZtr1BG5G6VAjsnyjo+6BRGHYBywdt4j9OYwPehVZPKjMkg6p415cCG
	 Tsn973poWWePA==
Date: Tue, 5 Nov 2024 15:29:33 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V7 20/21] alarmtimers: Remove the throttle mechanism from
 alarm_forward_now()
Message-ID: <ZyorzSqvanKmFEy2@2a01cb09803abb1ce3ad97aed0fef98f.ipv6.abo.wanadoo.fr>
References: <20241105063544.565410398@linutronix.de>
 <20241105064214.252443020@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105064214.252443020@linutronix.de>

Le Tue, Nov 05, 2024 at 09:14:56AM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Now that ignored posix timer signals are requeued and the timers are
> rearmed on signal delivery the workaround to keep such timers alive and
> self rearm them is not longer required.
> 
> Remove the unused alarm timer parts.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


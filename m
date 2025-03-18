Return-Path: <linux-kernel+bounces-566894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F35A67DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF7D883E59
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC59B20B20D;
	Tue, 18 Mar 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYZSwsia"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D91DC9B4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329492; cv=none; b=gNxjerS7bBAbJpgUp8OYDy2K3btGtPlm+Mq+xhosHI4AUDI9qCps1It4Se/ncGQrx1vImL85eeR5G3IQxXof6ObY3x9x6lmi98On9UDKBChfmoH/1J7YWbdmmF5ge0ZsKla74y/+tfI4BAYRfqKXHTI83fb187KfZFJU5k7nldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329492; c=relaxed/simple;
	bh=KY3HRdb15vZT/e5HPoX5e23ypHvo0iUY3vzHX2ls8P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpZkUub+HRsCW7UCGg1KVOUoCuE+XRsL0IiC410r0myl0Us9PpAhkMdODbHyMncAWwjvLz6slqZN+QtupvNsgnW5MXsopyeS6ya6un19w4Du2WQ3pQ2vCDfMImy069aashPP0UeSMYjTCUaJeTfpwlv65hLaajzHiIr2P++rDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYZSwsia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670E4C4CEDD;
	Tue, 18 Mar 2025 20:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742329491;
	bh=KY3HRdb15vZT/e5HPoX5e23ypHvo0iUY3vzHX2ls8P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYZSwsiakUtFFLP5mXsHmTaeKx5dpYYnpeuWFIUig5e8Hii8odR7KZ6Z0ji3WasgO
	 6PzlsXwJwPP5QJ6Yh+yg+s9ca4D7KajKRdqFyUbyb5ACzsI2LsZp92Koa+YWizGai9
	 w2eXcWcf78nG11e41sCViIKENjpEL0TS/i1D8gpQn4enXN4gIr3r0eMzwK5G1k8EpK
	 oGsuHR+BJscJSVlsg3nMu18L8wtxGYH042+oP7OgALJKEXWic28IVJWF2z1ebufKSx
	 BadoAjAHwNJ7waAm+DV3EfM9LVYT/ThmPF33Ku5t96Ud5gWfrtW+DWBN9Dxlp/SM8u
	 qqAnqqRwvo68g==
Date: Tue, 18 Mar 2025 21:24:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	den-plotnikov@yandex-team.ru, gpiccoli@igalia.com, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, tglx@linutronix.de,
	hpa@zytor.com
Subject: Re: [PATCH v5] x86/split_lock: fix delayed detection enabling
Message-ID: <Z9nWjlIYHXWYJ0eV@gmail.com>
References: <20250318144911.10455-1-davydov-max@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318144911.10455-1-davydov-max@yandex-team.ru>


* Maksim Davydov <davydov-max@yandex-team.ru> wrote:

> If the warn mode with disabled mitigation mode is used, then on each
> CPU where the split lock occurred detection will be disabled in order to
> make progress and delayed work will be scheduled, which then will enable
> detection back. Now it turns out that all CPUs use one global delayed
> work structure. This leads to the fact that if a split lock occurs on
> several CPUs at the same time (within 2 jiffies), only one CPU will
> schedule delayed work, but the rest will not. The return value of
> schedule_delayed_work_on() would have shown this, but it is not checked
> in the code.

So we already merged the previous version into the locking tree ~10 
days ago and it's all in -next already:

  c929d08df8be ("x86/split_lock: Fix the delayed detection logic")

  https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=c929d08df8bee855528b9d15b853c892c54e1eee

Is there anything new in your -v5 patch, other than undoing all the 
changelog cleanups I did for the previous version? ;-)

Thanks,

	Ingo


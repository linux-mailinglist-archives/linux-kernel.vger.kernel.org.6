Return-Path: <linux-kernel+bounces-439296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2459EAD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404CD161F21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A423DE92;
	Tue, 10 Dec 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee/8oLjy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23523DE81;
	Tue, 10 Dec 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824534; cv=none; b=hUING3vYqjF1urrczMU9gp9u3g3vP5pGMxrAb5AeIZqu5ygdLzo+fjNOb0QJCJgs/HtUmEeRSphgxkmMjybbpBoYxIQ0DFsa+kenNID3+2M0PhcmEq+9Aq9sgF9ep7ayFGdO/bJaskkCYAIkjq4LjXLQWPzNQYZU+G5bZE6vek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824534; c=relaxed/simple;
	bh=DFBgpZ+GyeGFvQROTuPH+b8C7qktrfoCAOS1rlm02M0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiiAMzhKsncrAsQwUby4vXUTQHdyWYopmPvh6gHtdLdDFHz9krSem3phT3tp9WPCTP6IS3x6vsbrvklb6DfZk3y3nosoZqEkP68Ej6/9EDhtYg+aI81K2ZBpwDV6KeyHOx0ZEZPPMATbO0rxg8Ql+Uwp5x54QBRd6m1ml72ajT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee/8oLjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853BCC4CED6;
	Tue, 10 Dec 2024 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733824533;
	bh=DFBgpZ+GyeGFvQROTuPH+b8C7qktrfoCAOS1rlm02M0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ee/8oLjyl51YQdZrFeqR8rfpe0OdrQ10Z73U12nZOaBhAK0nLIPxcBymYS48NjwuD
	 fm01yklQ15V+/wri18iBkL4UAhgKgA6QQU4yvuwusdr1ARmAofp8NpeomAR4wZSNAH
	 mxuCvViJ+Haey3J271OKwrkuACQdMvGtBFj5L6LVN2h5KbIiWQXGcp9emCnWMTfRCj
	 6JoPT5WkTb5QXkywha6H5xGu/rSdFML60FY2DsQAAlL5Vm02hL87NccdtecI7lDQe/
	 zMQLR40bztkfBb/TRkzSNrya76uU/8nB+K+0yLbVkXvI9YhWm5xIREg6/CE4WuSev+
	 KTlE4BLYfFHqQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tKwxn-002Dkv-3c;
	Tue, 10 Dec 2024 09:55:31 +0000
Date: Tue, 10 Dec 2024 09:55:30 +0000
Message-ID: <86v7vrsvzh.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Oliver Upton <oliver.upton@linux.dev>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Will Deacon <will@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction: 0000000002000000 [#1] SMP
In-Reply-To: <20241210025127.jmkcpw7ixu4r7hxl@altlinux.org>
References: <20241202153618.GA6834@willie-the-truck>
	<86ttbmt71k.wl-maz@kernel.org>
	<20241202155940.p267a3tz5ypj4sog@altlinux.org>
	<86ser6t6fs.wl-maz@kernel.org>
	<20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
	<20241203092721.j473dthkbq6wzez7@altlinux.org>
	<1847e34fa7724d28aeb22d93752f64f2@huawei.com>
	<20241203221453.mwh6sozyczi4ec2k@altlinux.org>
	<87jzcfsuep.wl-maz@kernel.org>
	<20241206205602.7phcrxqsv4c6oul4@altlinux.org>
	<20241210025127.jmkcpw7ixu4r7hxl@altlinux.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: vt@altlinux.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, oliver.upton@linux.dev, shameerali.kolothum.thodi@huawei.com, will@kernel.org, james.morse@arm.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, wangzhou1@hisilicon.com, glebfm@altlinux.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 10 Dec 2024 02:51:27 +0000,
Vitaly Chikunov <vt@altlinux.org> wrote:
> 
> On Fri, Dec 06, 2024 at 11:56:02PM +0300, Vitaly Chikunov wrote:
> > On Wed, Dec 04, 2024 at 08:51:26AM +0000, Marc Zyngier wrote:
> > > On Tue, 03 Dec 2024 22:14:53 +0000,
> > > Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > On Tue, Dec 03, 2024 at 10:03:11AM +0000, Shameerali Kolothum Thodi wrote:
> > > 
> > > Mark has described what the problem is likely to be. 6.6-stable needs
> > > to have 6685f5d572c22e10 backported, and it probably should have been
> > > Cc: to stable. Can you please apply the following patch to your *host*
> > > machine and retest?
> > 
> > We tested the host with this patch applied over 6.6.63 and 6.13-rc1
> > guest does not Oops anymore.
> > 
> > I'd suggest this is also get backported to 6.12.y branch.
> 
> Please, can someone backport this patch to v6.12 and send to stable? This
> would be really useful to have this fixed and it's noted this is a
> critical bug.

Look: it took you a few good days to simply *report* that the hack I
gave you was helping. Surely you can similarly wait for a few days for
the interested parties to spin proper patches and *test* them?

And if you really cannot wait, feel free to backport this change to
whatever stable release you feel needs to be fixed and post the
result.  I promise that I will review it. After all, you are so far
the only person with both the HW and the problem.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.


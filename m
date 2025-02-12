Return-Path: <linux-kernel+bounces-511248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1355A3284F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCDD1889594
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BCA20FA9D;
	Wed, 12 Feb 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="PYLwVjGf"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37D20ADE6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370246; cv=pass; b=Mk4X8EyftdWNR0AeqDf5saApIW3Se4EHOxaPPk/0ctE/eW1L+qSZHQ1MTO6Kr5ke6fb0LgtuSmiy8uD2LBmi+W2lzcHgjmNXFE9NSKPFYCGqwB1B5tUzqpGaejnbfxhpD1YVHAeO+OJ0aPg4nmT3Z+fRhT3NR0FCvi4cuDCaOWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370246; c=relaxed/simple;
	bh=wqRrAcMAu6pfd4dlB3Mcxlw6wqBNDWQVOnYTsein/18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb5LDc2JrtXxtH2JsMdT9yR/cozOyV2CXMDzgt57hMdXfgzhaFTf59KJsrZPQqOlvpxIlx0EQRx+nCWpwDUxpDDDwi4ZzxZii7jAXD9l6fKTEokZDsttJ5keWTZmT5u90BISDWooKuj3cHsJeDmtKeSxsoyzF+3K9rgCEUwSTB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=PYLwVjGf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739370222; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GaypVFgaOPH3t924XtEWvDqC0xfWSb7PNmDo7mDBRzfnttw9rQtXl+BRDd6DMWfQ9zMOpt1MRYFH+jxJrnKyvBido/1aCpHVfoFrZNngIehQsNRFcYTk/Gi1XXNZz8pkJXWK7GetebmGZvrRKe4PEzzoC6Hfsu1cMgk0ZlgJMGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739370222; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fxdUEI9qV8xByx6gE5E+U8Qx8ei4ZofYMqf3WZkNtmg=; 
	b=lkfJTUv1w4R5oT+lrA/tUR/uFCtLQwFDZmJHTDpMxF8EBwasctkGWtFJaIzoKXSnM0rc1dXMdn3CXD2sQvhICSYmpjzjlCzlr/AgJB1biyt+cMxvTHfaQHaiRJ1Zq+WPKfGTwbKG/OX6D26E9cXxJdsd9ph4Hoe69k9TLJPIjjY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739370222;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=fxdUEI9qV8xByx6gE5E+U8Qx8ei4ZofYMqf3WZkNtmg=;
	b=PYLwVjGfxz9uGOXfF7EbuQw1GSGPBkaig3NYrAYEkJM9h1Pm40nUoodPOMBupe+W
	GnZRP2oFtP3m8CysFiT/SnMOtY3sEA7wVknDTJTwoicVjoy4qb/zJuVri0GSMoZyvHN
	ghARByUCkBnorc8P9v52Md+cdOxB0+o7k3dmw82I=
Received: by mx.zohomail.com with SMTPS id 1739370219270379.880099124141;
	Wed, 12 Feb 2025 06:23:39 -0800 (PST)
Date: Wed, 12 Feb 2025 14:23:35 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panthor: Replace sleep locks with spinlocks in
 fdinfo path
Message-ID: <odudmfgsdnr56qvbkdgwz7sfys4xl53jixjy4zw2xlt6pgmpoy@tyrn6naovaaw>
References: <20250210124203.124191-1-adrian.larumbe@collabora.com>
 <2ec2a848-90f4-49bc-aaaf-8eb256f271db@ursulin.net>
 <ddnsckbpr2fcxby4i2o5xyrt3pdhornzbrvlbivuvzlyhgg66q@ejhkiz33sewn>
 <7ee0205a-6522-465b-8795-3d7b867e2d97@ursulin.net>
 <20250211134120.7e10b504@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211134120.7e10b504@collabora.com>

Hi Boris,

Here are the branch and kernel config I used for reproducing the bug:

https://gitlab.freedesktop.org/larumbe/drm-misc/-/tree/panthor-fdinfo-internalbosizes-10
https://gitlab.collabora.com/-/snippets/426

On 11.02.2025 13:41, Boris Brezillon wrote:
> On Tue, 11 Feb 2025 11:39:49 +0000
> Tvrtko Ursulin <tursulin@ursulin.net> wrote:
> 
> > On 10/02/2025 16:08, Adrián Larumbe wrote:
> > > Hi Tvrtko,  
> > 
> > Thanks!
> > 
> > > [18153.770244] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
> > > [18153.771059] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 203412, name: cat
> > > [18153.771757] preempt_count: 1, expected: 0
> > > [18153.772164] RCU nest depth: 0, expected: 0
> > > [18153.772538] INFO: lockdep is turned off.
> > > [18153.772898] CPU: 4 UID: 0 PID: 203412 Comm: cat Tainted: G        W          6.14.0-rc1-panthor-next-rk3588-fdinfo+ #1
> > > [18153.772906] Tainted: [W]=WARN
> > > [18153.772908] Hardware name: Radxa ROCK 5B (DT)
> > > [18153.772911] Call trace:
> > > [18153.772913]  show_stack+0x24/0x38 (C)
> > > [18153.772927]  dump_stack_lvl+0x3c/0x98
> > > [18153.772935]  dump_stack+0x18/0x24
> > > [18153.772941]  __might_resched+0x298/0x2b0
> > > [18153.772948]  __might_sleep+0x6c/0xb0
> > > [18153.772953]  __mutex_lock_common+0x7c/0x1950
> > > [18153.772962]  mutex_lock_nested+0x38/0x50
> > > [18153.772969]  panthor_fdinfo_gather_group_samples+0x80/0x138 [panthor]
> > > [18153.773042]  panthor_show_fdinfo+0x80/0x228 [panthor]
> > > [18153.773109]  drm_show_fdinfo+0x1a4/0x1e0 [drm]
> > > [18153.773397]  seq_show+0x274/0x358
> > > [18153.773404]  seq_read_iter+0x1d4/0x630  
> > 
> > There is a mutex_lock literally in seq_read_iter.
> > 
> > So colour me confused. What created the atomic context between then and 
> > Panthor code?! I just don't see it.
> 
> Uh, looks like we've leaked an atomic context somewhere, indeed.
> Adrian, do you have a reliable reproducer for this bug?

Adrian Larumbe


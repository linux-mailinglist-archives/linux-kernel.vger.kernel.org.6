Return-Path: <linux-kernel+bounces-402791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7773E9C2C30
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56E4B21D90
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8BC13B586;
	Sat,  9 Nov 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FaUXsK1a"
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41450148FF2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151814; cv=none; b=AR/i1jyVSa0eIsgi5H1UJrhhhvkl4qMizHEFGVan7sb4jXx34Ak6Y+3N0NXdwU13asnwarem9AqaEFXeuR0SHWrzfXB22cIDFlojnN6DrwHw/rg4rN0/5TIdZj586EgSrg7Rog72gcdEHM2QiF2+4Z8IQBXoFfRukvRk4HsHln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151814; c=relaxed/simple;
	bh=c9Vww4CT0SN/2jGjFWdoneL43s1239/xTGQn1r7f53o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jByYskfZIXFnaQxJ5+6ASj8YqQ0RBnHbMYgcxhT5ccj3YgkHoxcaMuFxTt7it+obHDpeD68pQOvQHPWFM8aHELQjGxvyDsOAKqxz5nlJlQ5TfLcwa7wSQDcNBJifi8b/XxRZmzgjiXSM/bnv5WPf0ircTh/nFsnkvt/i890iZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FaUXsK1a; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XltWM67jkz93h;
	Sat,  9 Nov 2024 12:14:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731150895;
	bh=M8sVqSHb9q1m4LHO4Ex5Vu4KLnEMo7PjEHIwnhi+B0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FaUXsK1aoEIN933EGMYl01Vq02XZFF01bYedsFZN65Bz6zMGszPpttHqffjA67mEJ
	 8lSRuoKNdAFxVwiuUgbK2tcO7ASTZWNM8nZUze9Qnk+OLbbt8KmaceHaaSiNAgz1Co
	 o2kygWLzhaOUApBkOFu/5qLRELKng8WLMkjse/Rk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XltWM23tHzksM;
	Sat,  9 Nov 2024 12:14:55 +0100 (CET)
Date: Sat, 9 Nov 2024 12:14:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Paul Moore <paul@paul-moore.com>, Tahera Fahimi <fahimitahera@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 1/3] landlock: Refactor filesystem access mask
 management
Message-ID: <20241109.xie6Quae9chi@digikod.net>
References: <20241109110856.222842-1-mic@digikod.net>
 <20241109110856.222842-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241109110856.222842-2-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Sat, Nov 09, 2024 at 12:08:54PM +0100, Mickaël Salaün wrote:
> Replace get_raw_handled_fs_accesses() with a generic
> landlock_merge_access_masks(), and replace get_fs_domain() with a
> generic landlock_match_ruleset().  These helpers will also be useful for
> other types of access.

Of course I need to update the commit messages with the new names...

> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241109110856.222842-2-mic@digikod.net


Return-Path: <linux-kernel+bounces-249575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC192ED7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B3F1C21ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F16016D9A6;
	Thu, 11 Jul 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="3PIXNsMG"
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C05450FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.3.6.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717802; cv=none; b=OANzLxuZX/Z+JXuDWQ1Q53p2m75C0sa+PpETQolwtnAPbbEvHUnd+WPft3tPpY6AAMzZ8zE+dJdrOb/hEzXeGGMujm0w1Ia9L51qSEgzGO/2GTMMspDsoo+BcqmzU5vj+EQ8+Ebwxct8F4+u3OqFVLw4VHJ9X0HxcyseOGZzZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717802; c=relaxed/simple;
	bh=Dt2jDlu51FJ7yIE+cCPQqiQrbjFfMdXHky1gYYZKq40=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lqBjlOA7f4O1972iZ4uwe8MdoIFX2/daiovWwhug8k2x/cD9mCI03f1dX85aMHn/4fiWWf4vgDGv7TWcb8IAiIg2sgXy2o+tOojXcaYk7VRcXlqidyKduB0jcuNPn8E4k9YdIyi36s186tL/AFQHQ94oEXbIqoYEEpoOaXaMLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=3PIXNsMG; arc=none smtp.client-ip=81.3.6.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id A2F171060136;
	Thu, 11 Jul 2024 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1720717199;
	s=s1; d=bens.haus;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=yfa5gkD1FWLPTfcuSmuGqbkj1N3g5Xuz7kteG9KJtS4=;
	b=3PIXNsMG8O+WfupeA9+q1BO9kIXKR0ZLwWTEylDX5deb5T+GsoxvUm/0V2xwA+F0
	Fmmjt7zdQOYLZhWctLrMp5/TovRC+521ZSkWvGt3ui3wyS61UJq31cAuvAFteSsxt5f
	4Rny0boNURYmLodoD8S6KcVXYP6hC6b66TV22Icy+nQ5m9EOnhgOEqdK2TuQ5uMKeVr
	vmluoVGLnZo9eVQFN2KL4J/gIiNY3RXGzwAw16KRR6VHRyBKzsZYqH0/8tRYwFMWAh4
	OJND7vCAZlmxXD5ftSjvtqdHbtavcp/CFve5zOYGnHSh7YM3aSb17xFEjCqIy1KhlSC
	BZ2SprxjIg==
Date: Thu, 11 Jul 2024 18:59:59 +0200 (GMT+02:00)
From: Ben Schneider <ben@bens.haus>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
	Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <O1XjBTq--3-9@bens.haus>
In-Reply-To: <dce98e50-6b50-4d4e-abe2-8419a675d25e@lunn.ch>
References: <20240603012804.122215-1-ben@bens.haus> <20240603012804.122215-2-ben@bens.haus> <20240605194422.klxtxgyljrrllkzy@pali> <dce98e50-6b50-4d4e-abe2-8419a675d25e@lunn.ch>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jun 5, 2024, 16:44 by andrew@lunn.ch:

> On Wed, Jun 05, 2024 at 09:44:22PM +0200, Pali Roh=C3=A1r wrote:
>
>> So, go ahead with this change with my
>>
>> Reviewed-by: Pali Roh=C3=A1r <pali@kernel.org>
>>
>
> I defer to your knowledge in this matter.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>  Andrew
>

Hi all, just checking in to see if there are any outstanding concerns/issue=
s outstanding with this patch? I am happy to report several more weeks of s=
tability on two A3720 devices. Thanks!

Ben


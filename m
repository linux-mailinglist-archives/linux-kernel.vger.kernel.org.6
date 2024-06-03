Return-Path: <linux-kernel+bounces-199595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9E8D895D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A4A1F238F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DBF13A261;
	Mon,  3 Jun 2024 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="TeXhPvgr"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633E139D04
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441605; cv=none; b=lmT4HG2LyytmsaIG16iC0lWJsqzI1tUbrt9JLWzyaqZUsK9utl1+JnZTufMPhT2LlKv+51l5sy0xo9iYCSsUNvh2RYZcu1LSWJ8qG505sOUDitEu04VYW/l7aQpPDaM654Go+E7kcPeGfUvL6eO4U8FVia23DHOLL22895j79Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441605; c=relaxed/simple;
	bh=PQgb60lAp1YrIzldjkL0RQ1Ba27CtlBEJ/1DJHz3WF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0f02Ggh6zzNOVbJmRdt9KbY+f+Niv6/Jl1LM+C4Ea9WtOhDdD62DUcUNAuBYZO4s04Mq/TrsivPlf+IxCO3YnkBjUi9t6o383QNxItYQIcxOvqhf2GTLo2Nd7Aprl017RteSqcEQNfXZ9xLuYT/5V1zuU4BZBt/c6XLvCzWAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=TeXhPvgr; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VtNW33yCjz9sST;
	Mon,  3 Jun 2024 21:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717441599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQgb60lAp1YrIzldjkL0RQ1Ba27CtlBEJ/1DJHz3WF0=;
	b=TeXhPvgruSv5ixTUVJMfHUXoNIoKlnqEh6HHLY6bA4JfY5T+tTW8BAga20n+MVb7L3iP5j
	5QPbzS9j0dPZWXx8EW7BztkEhDqCL/g7+2nr3koLlz46/R6RK2om/5zwiFcTsWJX+nnL5y
	CHUfpDeCCYNFtBZC+yxcgEixkyKCbWGfMPxQpLB5h65qKywk9Fftuei0BLpzNAAKBR4IjD
	9xg6y0ubPH9C/Jj0BYpVpMcOe3O0RehgkdoQaMrLloCDbCiJq28ppqOtIkpvEeaqDVbyym
	f/AcLwqy0WpzIFNaXfD7U7L1BtOnCN/b+YmE5dnuPgtWlEBf4NOWmWdg89snIg==
From: Ben Walsh <ben@jubnut.com>
To: Dustin Howett <dustin@howett.net>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Kieran Levin <ktl@frame.work>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Mario Limonciello
 <mario.limonciello@amd.com>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] platform/chrome: Fix MEC concurrency problems
 for Framework Laptop
In-Reply-To: <CA+BfgNKcG4ShokZ3ERmg75nJXMRbwJeAH=GnWwHt6A3XRar+gQ@mail.gmail.com>
References: <20240603063834.5580-1-ben@jubnut.com>
 <CA+BfgNKcG4ShokZ3ERmg75nJXMRbwJeAH=GnWwHt6A3XRar+gQ@mail.gmail.com>
Date: Mon, 03 Jun 2024 20:06:36 +0100
Message-ID: <87r0dd26df.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4VtNW33yCjz9sST

Dustin Howett <dustin@howett.net> writes:

> I've tested this patch series on the following devices:
>
> - Chromebook Pixel 2013 ("link")
> - Framework Laptop 11th Gen Intel Core ("hx20"), firmware revision 3.19
> - Framework Laptop AMD Ryzen 7040 Series ("azalea"), firmware revision 3.05
>
> It works as expected.

Very cool! Thanks for looking at this, Dustin.


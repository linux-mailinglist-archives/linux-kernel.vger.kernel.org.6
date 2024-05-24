Return-Path: <linux-kernel+bounces-189024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067878CEA00
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB02281C63
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5423FB2C;
	Fri, 24 May 2024 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="ocYoPQaO"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352571CFB2
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576349; cv=none; b=YihQ4pmaM5OipNt+MAow95gXta7pt3Z2h1CfccPn+F9aRhcRvBYXcKd3SYvVeaED4lRZjfTDMPaLh2OMDjKI3ttJ2WAjQwXIeembuFFhXDpAJdWWf6WXOnxQMCzxSOXR7mrC/vANxLiaAmopKKLEa2JeF1Z6EK4Gbg7w4pr9LYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576349; c=relaxed/simple;
	bh=rsOPZ72Of/AX5AiLQAAdRGqcGHzkGYM86yMIsD5ORcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AoR8WVY2Q9DgKrtqokPH1ypUDJxs5zFGwiJKA1SXaVt2Dzx09VKL5/InkfiSBAr1kfk8Ak1qf3RnljpX1kuSMz3NEosLTYdHBckogpD6sZolD0NWXbeLWcPxueCCYj3JTd2o7kCgFmfpaw46DujHlH/sxvM7OvhBp5BKl2kiJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=ocYoPQaO; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VmDWX2Js8z9srt;
	Fri, 24 May 2024 20:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1716576344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOPZ72Of/AX5AiLQAAdRGqcGHzkGYM86yMIsD5ORcU=;
	b=ocYoPQaOk5lfpB7UZDTIul2WxLYHpQdttxNbbm/rVBZMJYQu5iODZUIzdtiyQ0YrsgHpi7
	eD8PJSud+RTg/rHvXlhQyajK7t+vdHxstfmcRoiOc/6JtuDXVLfAG1/k5oPqnPPYdypinS
	1OIA/UvdCYjyhnoTAHBRAO6MChqTSyv+DmUJnREPS1KmUSqmNUqYtfarmMB+Ezy2Qg3tbe
	5JZVbnMiIMrzXDz2/hGbt1a4CTEA9qYL61iB+s0O1UE0+OKS2U6G7d/y6ChkXrJvjaOl0n
	fw0jU//d7CMctREsvi9ODx2I3LrP07XAbQqUacq7X/fxCqtjagZKJJ75oMsQZg==
From: Ben Walsh <ben@jubnut.com>
To: Dustin Howett <dustin@howett.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Kieran Levin <ktl@frame.work>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Mario Limonciello
 <mario.limonciello@amd.com>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_lpc: Correct ACPI name for
 Framework Laptop
In-Reply-To: <CA+BfgNL7RGWuFK-M=Cpt8nLfroK+Xpqtzs4nQ1Bwnv6iiVd5nQ@mail.gmail.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-6-ben@jubnut.com> <ZkscFnmHeWWma7Nb@google.com>
 <87jzjk1ibr.fsf@jubnut.com> <Zk_63rrDJFhN1Y1q@google.com>
 <87cypb12j9.fsf@jubnut.com>
 <CA+BfgNL7RGWuFK-M=Cpt8nLfroK+Xpqtzs4nQ1Bwnv6iiVd5nQ@mail.gmail.com>
Date: Fri, 24 May 2024 19:45:41 +0100
Message-ID: <878qzz1222.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4VmDWX2Js8z9srt

Dustin Howett <dustin@howett.net> writes:

> On Fri, May 24, 2024 at 1:35=E2=80=AFPM Ben Walsh <ben@jubnut.com> wrote:
>>
>> I could add a new quirk which provides an alternative ACPI match table
>> to be used instead of the default. In the default case the match_table
>> will contain only "GOOG0004" as before. But in the Framework EC case the
>> match table will be "PNP0C09".
>
> My biggest concern with putting PNP0C09 in the direct match table is
> that it would cause cros_ec_lpcs to be loaded for *all* devices with
> an ACPI-compatible embedded controller; it would likely print an error
> and bail out early on, but it would still be unnecessary on 99% of
> platforms.

That's exactly what we're talking about: how to *avoid* putting PNP0C09
in the match table.

My original idea was to put it in the match table, but only allow a
match to proceed if Framework EC is detected by DMI.

My new idea is to not to put it in the match table *at all*, but to
provide a new match table if Framework EC is detected by DMI.


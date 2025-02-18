Return-Path: <linux-kernel+bounces-520300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3887FA3A830
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1274B1671A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0387B1EB5F4;
	Tue, 18 Feb 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0vc5dBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B721B9FA;
	Tue, 18 Feb 2025 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908646; cv=none; b=MwG7T/dbc/kidfwhha4hDeSImybK69H+kK5HMZKCsF9yXN4kJuWNdtTJbsRjTZxUmtP3FRiYdfFYTOD+R90TgM79+pFxsKUB8PmOhpE1bZIR77GELWf63ngH3giOvMlaO6AhBqxNmVN4ciHwJA2ZFbcthdgTC0q4IBFQDtS8w9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908646; c=relaxed/simple;
	bh=iRQcjI0QKpkUb0mihD4fgNopWP6HeKcRJj1IJJYyLvg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QN42WEyVYhUUny9V9q3leDtRndLqFo+AdB4VAKku6bOOo9cnsgZlExLjPLIoxbmjjMYz4K7I1yJJF0+fvm8VWlYu57xZyGPLT1RjgY9lJyVX/zvGMTdx+k73RIQQNx8drImTJGv5xru0vtnPMPcHP15zry2h9vYUqocPwjiTTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0vc5dBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78457C4CEE2;
	Tue, 18 Feb 2025 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739908645;
	bh=iRQcjI0QKpkUb0mihD4fgNopWP6HeKcRJj1IJJYyLvg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=d0vc5dBRzf4DAAhzqqpVLSwN7BaPqmmSth3Dxh88cDgrihmJAHLat83unYF6gYXq4
	 ykTsuWDktjOrgNXz7lyRzwceRIF9k9u6NjEJaL4RwMjqyxm6rwQN2pmWaEqH+Me7XI
	 YNFWjBeedFn6bTk+WtXVo52A8C9cXQwizStMD4FqUUB714mqjWxDvLaLLySYBc8Cew
	 +n0CpQry7kWHAlUX8cPR7NwsE+wMZ7nsktnAwT7e+78+85hGkO0fSUyWcDaCA71v1C
	 UJmbR0ovmnH7/w9YwS7H7c1Z7kT4beE7NQd7XdwUkZ9GJt1M9aP/69385y7MNwISKQ
	 dHxVyivTN8TsQ==
Date: Tue, 18 Feb 2025 20:57:23 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Garg <gargaditya08@live.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    "bentiss@kernel.org" <bentiss@kernel.org>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    Orlando Chamberlain <orlandoch.dev@gmail.com>, 
    Kerem Karabay <kekrby@gmail.com>, 
    "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] HID: hid-appletb-kbd: simplify logic used to
 switch between media and function keys on pressing fn key
In-Reply-To: <8365C1B3-3A38-4F6E-955B-D6BBABA6B00A@live.com>
Message-ID: <4n0465n0-r590-66p4-o4oq-56q1qn6rs2s1@xreary.bet>
References: <8365C1B3-3A38-4F6E-955B-D6BBABA6B00A@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 Feb 2025, Aditya Garg wrote:

> From: Aditya Garg <gargaditya08@live.com>
> 
> This commit simplifies the logic in appletb_kbd_inp_event used for
> switching between the media and function keys on pressing the fn key.
> 
> We now also prevent touching the kbd->saved_mode variable in case the esc
> key only mode is chosen.
> 
> The following small fixes have also been done in this patch:
> 
> - A small comment style error has been fixed
> - Fixed spelling in MODULE_DESCRIPTION
> - I have added myself to MODULE_AUTHOR
> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

What a flood of patchseries :) I don't see any mentions on what are the 
v1->v2->v3->v4 changes, could you please document that?

-- 
Jiri Kosina
SUSE Labs



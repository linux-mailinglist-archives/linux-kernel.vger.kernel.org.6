Return-Path: <linux-kernel+bounces-209347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA83903314
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545B31F27CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68F4171E7C;
	Tue, 11 Jun 2024 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kdrag0n.dev header.i=@kdrag0n.dev header.b="UMuL3E/t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9pUalFU"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E1F171E74;
	Tue, 11 Jun 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088850; cv=none; b=TQQag1sAuu70p5g4tacyfSwXtFpZzrwOPPBiNb76HpKjSpHJm51GysS5gKMS2Z/DxH9zU9SVl1FeVC8ZOjbu7Opgj++HuorclEdAWl9PUTEPZvKrV7pJVk7K2fyKLJciF+ncoK+0rl9c9GpS4NEKRz66iWmPOOk+oBL5IDeNp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088850; c=relaxed/simple;
	bh=/4Ld/EHeInmgDF21XSfDl2NsuMw7Ruxj36buTwtcEio=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GydEx+ZSjG/D2QV8sCuqmsb7UMC4hod7EXyGDPMv9GgMeFVTSzmsJOLzuyrckVsanO4iAwjypagwinDQlEVv/FeFe8OSlD/MHWJjKM8BoWntA5o4TnfHH542IjC3AEbcQiV9hOVr4OyydZiXEUu4E8QjhrFKgZ2wBMvaqdSrPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kdrag0n.dev; spf=pass smtp.mailfrom=kdrag0n.dev; dkim=pass (2048-bit key) header.d=kdrag0n.dev header.i=@kdrag0n.dev header.b=UMuL3E/t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K9pUalFU; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kdrag0n.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdrag0n.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 70A351C000F7;
	Tue, 11 Jun 2024 02:54:07 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 02:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdrag0n.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718088847;
	 x=1718175247; bh=I8Cs+PKmoyx6Obnltn4u18ENg+YH1Z3/eoOHhpjV9GM=; b=
	UMuL3E/tZkxieb5q+rqXq7AHIXFyA3OdWrUCnqyUbylX2ZwI9rPkPBwapWIunl+Z
	b1uk3UGqO1OkIrx31fm3LcHRoBzDD73CCoYtrNItpEugSInOBgFBC0qMFGliyAL3
	ZIrWwEbTC1OFypJNbr6DK+bO/PZqG83j5kcqBvh/+XDH2DDl0QzWITPdVZ/2pmZf
	a6JRSD3TS65r/H6DUHmaCjYwvEWaxN3zIf9bDHnm/kC+DumURyLHwrfU2T9NYyAz
	vS01TsC6f/1xwvq5sCnMLKTCKqM74yTEm6hdV6bOuCKGZqYOg3ffi1EBmDjnz/rM
	+u4nAIU3kr2y++H1ScHPjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718088847; x=
	1718175247; bh=I8Cs+PKmoyx6Obnltn4u18ENg+YH1Z3/eoOHhpjV9GM=; b=K
	9pUalFUaBJYlCJZ/R4LobyJ5gpIxz2Z5GddGz11DDlPkSOge4L3Dl0/CVosYGc4j
	srBWbFbrQfGMTprauCr3Z26nBOtd7fE1Mn2d/a6eHrIhU2a39cRoRboMsv/cRmhl
	d+lupYrw69QePzlqhTdNPiIseoedGbW2HjNojX//VVwfvHaLP1ZA/SKjYcM8bSO0
	d4nBcdAm9zMduIBjCv+1CKkhkoXQCDHc/jelxGEV+/jgctQBMmQa/nayIHgl46cl
	n/gjphk5M92ISmGkw1CVHO1L+i1VqX1emdolUG1OKY8MJ45xQ/xlAP27nfFXLB/H
	kXJXCTZ321yR4Hf9S9MRA==
X-ME-Sender: <xms:jvRnZry1gY1D-TtrW_ncTpM_Mg_r0G6Nq3I758kAvAfhxgBv-pXipg>
    <xme:jvRnZjRlx6JMEDFbPZDw0PXlszVw9MZAnK6KncLKir3sqVlf_ZA2LWvRFPxnI2Jrc
    r09VkAImZwJrSljU_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    ffgrnhhnhicunfhinhdfuceouggrnhhnhieskhgurhgrghdtnhdruggvvheqnecuggftrf
    grthhtvghrnhepjeeiuddtheelueetleehgeefhfeluddugeeliefggeetgefggfekudei
    hfdvheevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epuggrnhhnhieskhgurhgrghdtnhdruggvvh
X-ME-Proxy: <xmx:jvRnZlUnI8--qxwVAiETu0u9kBbqPVZByc6ze9AT0sMpa38p_PONuw>
    <xmx:jvRnZliJjQQXD3ddVPxeJz4xCFBjvRZjp9sNx0PA1m86_hcHmhhvqQ>
    <xmx:jvRnZtBODEPWszeaIY06kcy2j2ADTYrfKJRFESwe3mhWzXPRUkVC5A>
    <xmx:jvRnZuIKsyPlQFv5VkzrvyhywLxl_UUfGU7QipXREDF4w_LNWxpMXA>
    <xmx:j_RnZv0B-HXFfSRCzSBikg4PLNwC7RI_fc_v2GFK_LIYjrSMjoj6dnyn>
Feedback-ID: i2ee147e6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A24BD1700093; Tue, 11 Jun 2024 02:54:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc9a785c-f8f1-474d-ba49-31de63dc5e8d@app.fastmail.com>
In-Reply-To: <2024061112-kilogram-poker-bacf@gregkh>
References: <2024061112-kilogram-poker-bacf@gregkh>
Date: Mon, 10 Jun 2024 23:53:46 -0700
From: "Danny Lin" <danny@kdrag0n.dev>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 =?UTF-8?Q?=C3=8D=C3=B1igo_Huguet?= <ihuguet@redhat.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] .editorconfig: move to Documentation/ directory
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:49 PM, Greg Kroah-Hartman wrote:
> Some editors (like the vim variants), when seeing "trim_whitespace"
> decide to do just that for all of the whitespace in the file you are
> saving, even if it is not on a line that you have modified.  This plays
> havoc with diffs and is NOT something that should be intended.

If trim_trailing_whitespace is the only rule that has actually been a pr=
oblem,
how about removing it and leaving the rest of .editorconfig intact?
The other rules are still useful to have as defaults.

Thanks,
Danny

>
> As the "only trim whitespace on modified files" is not part of the
> editorconfig standard, just move the whole thing off to the
> Documentation/ directory so that those that wish to use such a thing c=
an
> pick it up from there.
>
> Cc: Danny Lin <danny@kdrag0n.dev>
> Cc: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  .editorconfig =3D> Documentation/.editorconfig | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename .editorconfig =3D> Documentation/.editorconfig (100%)
>
> diff --git a/.editorconfig b/Documentation/.editorconfig
> similarity index 100%
> rename from .editorconfig
> rename to Documentation/.editorconfig
> --=20
> 2.45.2


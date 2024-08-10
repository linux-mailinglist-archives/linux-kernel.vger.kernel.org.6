Return-Path: <linux-kernel+bounces-281831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6242694DBD5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C57828220D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A8157490;
	Sat, 10 Aug 2024 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMMuPLZM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D7142E77;
	Sat, 10 Aug 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281061; cv=none; b=p6Sk5S0mnqn+Yi0MfS/CvYvMisraEHDyhIqSbR4CdnkPsD0OWMKS4bpM7SlSzA9vJMLJ0tCjXrTj08KNpVA309GK06RXA3/wDyLI2r8yMwZPwRH86xjlLuDgeraBv73OWlU6p14AedrX90q9UFrE5oeJULU5VDvd2mUf+IL+lMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281061; c=relaxed/simple;
	bh=bC/PiV844NbARK82KUwxcN/Rwh+3sMlT8C39W8WwowQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3tn1+EXBU3LLPCuyML1VRpJvIo/zJvLgxGPw3Bw8iyG21M5l3urTqtDYUscf3N1jO1/Uqj32fXVFBgKuzbfacs255usfM3JmsLh6iIikIsb6S7UtkhdjQHyWrlO2V8iZ3TGQeMZTlpI++xfOHyqWJSbv6lBvDvHaQZ96eNr1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMMuPLZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A378CC32781;
	Sat, 10 Aug 2024 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281060;
	bh=bC/PiV844NbARK82KUwxcN/Rwh+3sMlT8C39W8WwowQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMMuPLZMp21N88Ja97DOhka3c2V/t/Hp9mFOvxHJ4Tq9oDxfQTWwa2CnJPhkPas3M
	 7KAVbM6hplidLKr+fFDnIw3JUgn/W7zxeUiCYChYaeOaVU97ta7qZwTA6mvqrsBoag
	 wYn364Kmvlgj6iLG7BhwWDSK5K6cULFt7xLhgSihk9VAbBmhdls239bg3E2ltnVH65
	 jC+6PMdSTwy/tsZhM+4i11mNrJECfRV2PwcRw8H65toWoYXHnlKxWdj4g4GK/4l4cd
	 Z2AgwhUtWftcE99+9kkKItKV9WJ5Pkkuf/uXngAd9wPTR0dUbFlwg120qk9z0+PGct
	 5JbiS7FPil0gw==
Date: Sat, 10 Aug 2024 05:10:59 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
	nathan@kernel.org, linux-fsdevel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.10 02/16] fs: remove accidental overflow during
 wraparound check
Message-ID: <Zrcuo0XjuFJ0cu-_@sashalap>
References: <20240728004739.1698541-1-sashal@kernel.org>
 <20240728004739.1698541-2-sashal@kernel.org>
 <20240729115418.xzfmanyqtipkuttx@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240729115418.xzfmanyqtipkuttx@quack3>

On Mon, Jul 29, 2024 at 01:54:18PM +0200, Jan Kara wrote:
>On Sat 27-07-24 20:47:19, Sasha Levin wrote:
>> From: Justin Stitt <justinstitt@google.com>
>>
>> [ Upstream commit 23cc6ef6fd453b13502caae23130844e7d6ed0fe ]
>
>Sasha, this commit is only about silencing false-positive UBSAN warning.
>Not sure if it is really a stable material...

I'll drop it, thanks!

-- 
Thanks,
Sasha


Return-Path: <linux-kernel+bounces-246248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2992BF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A751F26509
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF75A34;
	Tue,  9 Jul 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhXmN2A3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767182494
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541933; cv=none; b=hsa23jUkmQpbBmGWt6JU/U7YNyjMDl1My8hWthEUmgqNr3OJU1URPMtG4/i619Ggd7EwAm1SgC/sSt5NmTXhpnjDMghYYMUfPCeckW/AWaciWOPF4Ov8m0auXZZeCc/OpFnsPcGYLh8JFr+iPqDIePIjIcG+T2n+FdjWZztHNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541933; c=relaxed/simple;
	bh=6CxWOEITHjIhWLXILz9JbgNImfhmSiAYeuju8IvNgdY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fGKf6I7wWcDlhrJv5mtmQlAuS9bLPeUmj0pJ7YJpxBR6A/6TzdPL7WxwnxdUCuWDqr6baxfG18KUPpdtdqZ+keAVNTlYRllbXaUHi68sdXgOwp/T7++5WUih2Ff2/+xXxCaPeFnUsw7IU8z7rNSTnS0MOkON5hlr3JjoXrUMMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhXmN2A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BC9C3277B;
	Tue,  9 Jul 2024 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541933;
	bh=6CxWOEITHjIhWLXILz9JbgNImfhmSiAYeuju8IvNgdY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dhXmN2A3Wvh0y2X9vbMZiyQeSdcg1nqJe6GWH3VlzbevWZqh6yyqznzdwXptak8W2
	 OKOhijmjiyHw+BKcffio4QTHn1aZx+UuKa0TIxoRP8EAu/L+yZLSug+XAXHss+RA4B
	 b9IHLQYSUv8uTf8eTX0Jx4qd0chTbdp7iefVrtnXNmsbBaXcHyYqow5cOLUKeeRwZx
	 RdRVWDGHfBrGUio9Q8fZwbN/sFNADfrJtGNXn662ovDKDCHwE/7hCqJEqLn4OnSs3U
	 b1XeExMVPSdRSoZDZbGMU4Q8GomsQG32dwQK5LVr3HJlq7h+15UEucAcWzjG1kSkBH
	 tZ97xTsfv0zqQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,  <linux-kernel@vger.kernel.org>,
  <ath12k@lists.infradead.org>
Subject: Re: crosstool: x86 kernel compiled with GCC 14.1 fails to boot
References: <87y16bbvgb.fsf@kernel.org>
	<917565ee-732a-4df0-a717-a71fbb34fd79@quicinc.com>
	<837cd2e4-d231-411a-8af4-64b950c4066a@quicinc.com>
	<c9b23ee3-6790-404d-80a3-4ca196327546@app.fastmail.com>
	<0e0150ca-fdfa-40cb-ad7f-6ac695b702e4@quicinc.com>
Date: Tue, 09 Jul 2024 19:18:50 +0300
In-Reply-To: <0e0150ca-fdfa-40cb-ad7f-6ac695b702e4@quicinc.com> (Jeff
	Johnson's message of "Tue, 9 Jul 2024 08:29:25 -0700")
Message-ID: <87le2abkt1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 7/8/2024 10:44 PM, Arnd Bergmann wrote:
>> On Tue, Jul 9, 2024, at 05:55, Jeff Johnson wrote:
>>> On 7/8/2024 6:57 PM, Jeff Johnson wrote:
>>>> We tend to enable a lot of debug config options, so I'm wondering if one of
>>>> them is contributing to the issue? Guess I'll turn off a bunch of those
>>>> options and try again.
>>>
>>> OK, with a bunch of debug turned off my image boots.
>>>
>>> Now to find the culprit.
>>>
>>> Current diff between original config and working config:
>> 
>> Nice! I've tried the reverse now, turning on the options
>> you have turned off on top of my defconfig. This version
>> still works for me, booting with a plain
>> 'qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage'
>> and building with my arm64-to-x86 cross compiler.
>
> I picked my favorite to begin with, enabling KASAN (which in turn enabled a
> few others). The resulting kernel did not boot for me (just saw a black screen
> after the GRUB menu). Diff between working and non-working config is below.
>
> I then downloaded and built the config you supplied. With that I have the same
> behavior as my original config, the display is frozen with:
> Loading initial ramdisk ...
>
>
> [jjohnson:laptop 1966] diff .config.old .config

BTW there's also scripts/diffconfig which provides a prettier diff.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


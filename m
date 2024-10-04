Return-Path: <linux-kernel+bounces-350024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB9698FEDE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD0B1C212F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F1113D25E;
	Fri,  4 Oct 2024 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b="EeaRuE8R"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134D6F305;
	Fri,  4 Oct 2024 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029902; cv=none; b=IVLXVLbRTJKNUimGOJcwMZJ6g5hmro98vKOLSRiKJfxlekT4/Kp8WH8FMXJ/cssLyTPhpw7LP0TN8KCTzsYO8qoNnasVPymcmVwSBJz/PHCWfOPE2+uEX+NVd5qvRmKZ4iqTyG+U1AK9Lc8jh2ufCGy3+SqF4msofJ566Hq17U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029902; c=relaxed/simple;
	bh=vEVx02YeXFs1Ck3x9SmNG7bAkUKtAAM5e0JVmiFheKE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=n50SGis27FZmO42oHaius9DXTUK+8ebj44jrrdZ9ADsmqdzturtl9N+DE3iEinUXf1Rzm9nxF8Xz5hY1vJZIrxYzWC3+58iYroUmrG6YP9GpKoZjIIEPEFgUgCguyl9tZKsTXXH14YU0VU4g+u1yarN2HvvS5TI2/iuJoBR7fLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de; spf=pass smtp.mailfrom=tuxedo.de; dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b=EeaRuE8R; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedo.de
Received: from mail.tuxedocomputers.com (localhost [IPv6:::1])
	(Authenticated sender: cs@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id B95CD2FC0064;
	Fri,  4 Oct 2024 10:18:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedo.de; s=default;
	t=1728029890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CpL4Sl5F+f6FBlOiTv4ia09midQCrE4QrZcBntnkKI=;
	b=EeaRuE8RPsGjp8wzk/S3kRhFvF7BTozX6DMp/XJnkHT2lYEoqclf5o5COivn3FaAOA718F
	BJGwsO+naHqt+QhDd9swWSjHnoO3/wtjQtbvGqUc3y2LZgr2IRskf1Uv6VrHDCJLQ1s7aF
	TuK34/uqQ7DMmrDvmFLV3LJFvTRr5O1QmXJEcqa3U27dxhD1Wo3Fln5DdXcvy67wtbC2cf
	gUcAq5QFVZS/VkFNFaUqeyuR3BewVx753bFsidtfsd//Ua/suhjhT0jNOcQL8CyGZ89L+/
	rXAZ7nAYS+iijXgrDyh4nLvpdZXeIZXf9jouVsekjum36C49YNdv6Ppuy+y41g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Oct 2024 10:18:10 +0200
From: Christoffer Sandberg <cs@tuxedo.de>
To: Jerry Luo <jerryluo225@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, christian@heusel.eu,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz,
 regressions@lists.linux.dev, wse@tuxedocomputers.com
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <d348ca06-38ca-474f-8673-dff2248331e5@gmail.com>
References: <87jzfbh5tu.wl-tiwai@suse.de>
 <ea6e5168-238f-41f5-9600-36b75ed990a1@gmail.com>
 <87jzetk2l0.wl-tiwai@suse.de> <b38b5947482a5ca4b55e0ddb908c2f34@tuxedo.de>
 <87seteli51.wl-tiwai@suse.de>
 <d348ca06-38ca-474f-8673-dff2248331e5@gmail.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <dbc783cc2608ac63ffd420b1dc3eeaa9@tuxedo.de>
X-Sender: cs@tuxedo.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit



On 2.10.2024 23:28, Jerry Luo wrote:
> On 10/2/24 10:00 AM, Takashi Iwai wrote:
>> On Wed, 02 Oct 2024 10:21:22 +0200,
>> Christoffer Sandberg wrote:
>>> 
>>> 
>>> On 30.9.2024 09:44, Takashi Iwai wrote:
>>>> On Mon, 23 Sep 2024 21:37:42 +0200,
>>>> Jerry Luo wrote:
>>>>> 
>>>>> Hi Takashi,
>>>>> 
>>>>> On Mon, 16 Sep 2024 19:22:05 +0200,
>>>>> 
>>>>> Takashi Iwai wrote:
>>>>> 
>>>>>      Could you give alsa-info.sh output from both working and
>>>>> non-working
>>>>>      cases?  Run the script with --no-upload option and attach the
>>>>> outputs.
>>>>> 
>>>>>      thanks,
>>>>> 
>>>>>      Takashi
>>>>> 
>>>>> Issue now reappear, output from alsa-info.sh are attached. If they
>>>>> are still
>>>>> needed.
>>>> Thanks.  The obvious difference seems to be the assignment of two 
>>>> DACs
>>>> 0x10 and 0x11 for headphone and speaker outputs.
>>>> 
>>>> Christoffer, how are those on your machines?
>>> I attached alsa-info from the Sirius Gen2 device.
>>> 
>>> Comparing the working/nonworking of Jerry, yeah, the assignment of
>>> 0x10 and 0x11 looks switched around. I don't see what difference this
>>> would make. Also, node 0x22 has "bass speaker" controls in the
>>> non-working version.
>>> 
>>> Comparing the Sirius Gen2 alsa-info with Jerrys, to me it looks like
>>> the non-working version corresponds to our working version.
>>> 
>>> I would expect the non-working version to happen all the time though
>>> with regards to the "bass speaker" controls. Why would this only
>>> happen sometimes?
>> Thanks!  The assignment of DACs depend on the pins and topology, so it
>> can be a bit sensitive.
>> 
>> Now looking more closely at both outputs, I wonder how the commit
>> breaks pang14.  Maybe it has a PCI SSID 2782:12c5 (or 12c3) while the
>> codec SSID is 2782:12b3?  If so, the patch below should fix.

Interesting, you're right, PCI SSID c3/c5 and codec SSID c3/c5 for the 
Siriuses.

I had a look around. In patch_realtek there are some cases where codec 
SSID match is needed as well. Would it be better/safer to directly do 
this immediately or keep it as an exception where it breaks or for known 
sensitive models/brands?

>> 
>> Could you guys try it and verify whether it fixes for Pangolin and
>> doesn't break Sirius?
>> 
>> 
>> Takashi
>> 
> It does seems to fix the issue on Pangolin. It might worth mention
> that the headphone output will have the same issue when the speaker is
> not working. Now they are all good. Thanks!
> 
> 
> Jerry

Tested on our devices, both speakers still active.

That's an ok from my side as well, thanks!

Christoffer


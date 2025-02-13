Return-Path: <linux-kernel+bounces-514014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88260A35156
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FD6188F54C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935EB26E14D;
	Thu, 13 Feb 2025 22:34:04 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A528A2BF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486044; cv=none; b=beMEV4OSIIJ3evkqvltM4yiRrV5DvIInniclBaUsFelhHzxBxo5NEGp0bEGaoC3EckWzBN34LzMTtU701byPP8s9+3vf8p7ylTafRJH1VcHAEfH1LiYycWA32PYRmDQ0OQ+ZnnCDn47Econ2py+96+YUlkfYHSAg+5m76ZpVuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486044; c=relaxed/simple;
	bh=81wnSjILo7L8IbxC+2Cd+JkEGip+G0Mn0ycfSPNnmds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDFHVlOo54/jXEf9nQ8qHQfm/UWRP2/YCxMn+pwoIYL9ix5bqIHNsuH2g53PeT0y3vnzsFamOKHf9W7TNKG2TSkg1mBv1URbLu8ERrpcl5UFvL7g+NYrDc2v1/qsEDLGGE4HemaGCRPpxGBXBHXWq41dG9pykDTySr5u6S2R5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f34101f68eso429494b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486041; x=1740090841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81wnSjILo7L8IbxC+2Cd+JkEGip+G0Mn0ycfSPNnmds=;
        b=JVtYm9POnZ3Wd/0Mo/87Fm3PAlL22IPJNZcGnAwXKljNL8+FI6LPqzbzU049zCpNdA
         lZAqjFIaRaolP0lZfznNIUSBt/doJNTGru1k2N1UQY4smwq+7ugdTRj9o1Ta9BFKJl7I
         JmFvO3wD9znlXdU1vLZEZUx4PgaHu+qiREG0wykr5+H+DrqdLaovMOrHH5rs10eJ9etF
         bXstzJIGGdSrv/Lflvx9KPJEnut4KPjebCwlfHZVAgOWFC6A7OIZ8nI5n88ncrOTaB+g
         ml2h3BVlEBRTf0Hz+v7tGttReyZ7sCRVkvYd1R+OPOdlxNNiPQcm47WSsHqCqXQRyeBq
         FKfw==
X-Forwarded-Encrypted: i=1; AJvYcCXqu1iNwKpLPJ1YFQUf6QxTzzTj7wuYb4FzljuFlzJ7kkMrRB78rrfavlD12BBA0d8R/424FhFLawdT9Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvEM5jb1dkKCGRPDd2hJ9yc6XOHUgo1J6jfbou93NLqshsO9+G
	uVZl+eNRTonDmc8jmi/8h6lyzUd85MZ08gL6lj5VgKWQFmrMSA75
X-Gm-Gg: ASbGncuvTrwPqmkoWJFu/k9lhf/JzY5zUwI9nYTXtF7xTmD3OZDH+6c9AXMMMfCuZwr
	J1A9YmHf8VzxgxRZqT3GiFaeVkVcgk8f7sNHZW8gKiKTpqO4zYzLwJz9ZhGAAiZJaVHI7e1lsgH
	Risd8O4S1Ifgphe2Y17c36pbfR3UmPSvxBJGysXmqspRu2DvhAf+FLEPVo4L06XVU4fz+zv2QlW
	L7tp+yS8iKoHXdo7a9HLd3ybAzid5SDUEtU5p5Xw0OPJhUYW9Z5K24BQBq0Epu4nYK1CAyFS/Hq
	J5npZJ5ZGNoCPfCc
X-Google-Smtp-Source: AGHT+IGwDm5Bd8dSS+OXg1gRfQp7hnq3TpySqSmK3pld9i6zPTZM6FNAnjW9E0HYWYUW0jK44W0EIA==
X-Received: by 2002:a05:6808:1308:b0:3f3:beb3:dd98 with SMTP id 5614622812f47-3f3d8dcbf60mr3345552b6e.14.1739486041598;
        Thu, 13 Feb 2025 14:34:01 -0800 (PST)
Received: from muster.uejji.net ([47.188.205.107])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3da92bb08sm930297b6e.2.2025.02.13.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:34:00 -0800 (PST)
From: John Edwards <uejji@uejji.net>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: John Edwards <uejji@uejji.net>,
	Andrew Wyatt <fewtarius@steamfork.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Handheld gaming PC panel orientation quirks
Date: Thu, 13 Feb 2025 22:33:44 +0000
Message-ID: <20250213223348.93593-1-uejji@uejji.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f67a3650-9b7c-49e0-b5df-5694a5d06a66@suse.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Thomas.

On Thu, Feb 13, 2025 at 1:35 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
>Am 12.02.25 um 20:59 schrieb John Edwards:
>> Hello, Thomas and Hans.
>>
>> On Wed, Feb 12, 2025 at 5:14 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi,
>>>
>>> On 12-Feb-25 12:11 PM, Thomas Zimmermann wrote:
>>>> Hi
>>>>
>>>> Am 12.02.25 um 11:51 schrieb Hans de Goede:
>>>>> Hi Thomas,
>>>>>
>>>>> On 11-Feb-25 2:55 PM, Thomas Zimmermann wrote:
>>>>>> Hi
>>>>>>
>>>>>> Am 24.01.25 um 21:46 schrieb John Edwards:
>>>>>>> Hello.
>>>>>>>
>>>>>>> I am submitting a small number of patches to add panel rotation quirks for
>>>>>>> a few handheld gaming PCs.  These patches were created by the SteamFork
>>>>>>> team and are in daily use by us and/or members of our community.
>>>>>>>
>>>>>>> The following devices are covered by these patches:
>>>>>>> 1: AYANEO 2S
>>>>>>> 2: AYANEO Flip DS, AYANEO Flip KB
>>>>>>> 3: AYANEO Slide, Antec Core HS
>>>>>>> 4: GPD Win 2 (with correct DMI strings)
>>>>>>> 5: OneXPlayer Mini (Intel)
>>>>>>>
>>>>>>> Thank you for your consideration and for taking the time to review these
>>>>>>> patches.
>>>>>> Did you ever receive any response to this series? If not, then
>>>>>>
>>>>>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>> I had the following remark for 3 new entries added in patches 2/5 + 3/5:
>>>>>
>>>>> "Since this '}' is closing the .matches initializer it should be indented 2 tabs"
>>>>>
>>>>> With that fixed, you can add my:
>>>>>
>>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>>
>>>>> to the entire series.
>>>>>
>>>>>> for the series. Let me know if you need assistance for getting the patch files merged.
>>>>> Normally I pickup/merge these panel orientation quirks, but I've been swamped
>>>>> which is why these have just been sitting on the list.
>>>>>
>>>>> Thomas, I would appreciate it if you can merge the set into drm-misc-fixes, with
>>>>> the 3 minor indentation issues fixed.
>>>> Sure, no problem. I'll wait for John to provide an update. Otherwise, I'll fix it myself while merging the series.
>>> Great thank you.
>>>
>>> Note in the review comments I said that we could likely fixup the indentation
>>> issues while merging. If you prefer a new version from John that is fine too,
>>> but we need to make clear to John what we want :)
>> Thank you both for your comments and feedback.  I am more than happy to
>> provide a v3 with the noted changes if requested.
>>
>> We have no other planned changes for this patch series, so if you wish to
>> implement the changes while merging that is also acceptable to us.
>
> Please send an update.

I have just submitted v3 with the requested changes.

Thank you.

John Edwards


>>>>>>> v2:
>>>>>>> - Minor rewording of commit messages
>>>>>>> - Include Tested-by tag for Paco Avelar in AYANEO Flip DS/KB patch
>>>>>>> - Add OneXPlayer Mini (Intel) patch
>>>>>>>
>>>>>>> v1:
>>>>>>> https://lore.kernel.org/dri-devel/20250116155049.39647-2-uejji@uejji.net/
>>>>>>>
>>>>>>> Andrew Wyatt (5):
>>>>>>>      drm: panel-orientation-quirks: Add support for AYANEO 2S
>>>>>>>      drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
>>>>>>>      drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
>>>>>>>      drm: panel-orientation-quirks: Add new quirk for GPD Win 2
>>>>>>>      drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)
>>>>>>>
>>>>>>>     .../gpu/drm/drm_panel_orientation_quirks.c    | 40 ++++++++++++++++++-
>>>>>>>     1 file changed, 38 insertions(+), 2 deletions(-)
>>>>>>>


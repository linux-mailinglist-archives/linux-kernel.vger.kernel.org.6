Return-Path: <linux-kernel+bounces-511833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6FA3304D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA302164B33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044152010E1;
	Wed, 12 Feb 2025 20:01:00 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A13201018
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390459; cv=none; b=p23GSbP2xBi8aZp59YVV6imD13OSFf7jeplr1sHDK+dB7LQxjjP2lmAcMdA1LWtPn9fpzvvQ4luarlx7SgRC3q09btnSUyd7WcKe92lcGvQcTsh6OgSeVuuw01a4Ioy5fz5WGj5vMhKl4kLoNC/8M3Unq74IB2n+Cq3pWmopDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390459; c=relaxed/simple;
	bh=JLgDjgUjkJJbA9a0GDNnLQFCt4WqWv9kBAZ2UXukXzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyvOqW3pnV21mbB3O9kIlUhtEjAKBbSFs98yguoKGe8XI4mQpv8QGZRBeLt8RKh60Ee6AFgsmGYG3Fqez/vnbDqNyPyNxeHprd6IUkuWSpTj07DamSHpsfOXoG1kM354CPaBCF6rBDCXNRZrAC1800rOKypseREDc7Y5oXIQFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-726ea524419so54488a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739390457; x=1739995257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ty55KN5TBvbN+OmRm4Xf1XcryTkekgKbpKoNCFiEowc=;
        b=E3JYGk9eeDhTfyVohHKxN60fVd+wrdyOqjdB+o9eBuTHZ2sXis+4BxXtpiiWAa6G4M
         ko+pxxwb0Ry1shevyitid1sg4wGQhKugtQPjyxcJPHegZ+Z/A7bti8q3I/tP+XfjgX+9
         8l232SAD6tmnPnLwFzZipOX+AedjmR07xFtxFOwWY3AZS5yFdsV5LnIGImiDtycZc677
         b53jAeRNwneayQnVEreugcm5AQnjdljYsnhdXIKGAETFt7d8S3xYxKbMoEv9Whw8ywFN
         525qRdVcqHSogSDDaBef5nNu1cuje9PIA2E/onYcqqpwvIdT2VrWMhtd2gOONYITmNFr
         Npww==
X-Forwarded-Encrypted: i=1; AJvYcCV/KBI+/nsfDjE3H66J/0Kfieri9ZtuR+QhROaYkj3WBY1nW71vMYGdk2Hz0sOrKNlrHs3NVEWs3OpUo+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YySdtJ7EiTcmWjL5CauqzL1/0KOOkvNirPGTJszWRJ4RoEu8Ii5
	FYfqVA20mogoZNNgCJBQoDOzixSfRzgxm9fZuRPedTzWQDXbSKEG
X-Gm-Gg: ASbGncsa7hJPqk9rd8bpub8KY0g/vME2/1B/jSOYULz6q8ThLMvAS4jnYZX9dOrV3DK
	8MWJWzWeoQYEVig2LpFAjGHOHolLS2QnVJFqUY8phYRCf+veXmy/7aZh9qd3Wdz1YNGy7prMpJU
	88VUgO5T9LjKQVnNPJTXzhYnrzsaaNe1DtwMU/xfZma9hKA9HDqrPRjRVypIarZ6tPNwJoIiTCo
	++b0bdblkXE/ePN+x36QFxvG6g2EovpdZ/GHo1Z1P7ywX7cwuZqevh4BZSf0UB1VFu5Pm5v5T56
	dSNUChQUY3IAWS1Y
X-Google-Smtp-Source: AGHT+IGwBXZTwtaL7NNRt+QXA+SEREgwN9UnIGCuP6Ps5/KzjD/6y7JCL5eimEfX4dk7oukXCa/CZQ==
X-Received: by 2002:a05:6870:ed94:b0:29e:43ce:a172 with SMTP id 586e51a60fabf-2b8f8e10fa5mr328542fac.28.1739390456760;
        Wed, 12 Feb 2025 12:00:56 -0800 (PST)
Received: from muster.uejji.net ([47.188.205.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726afa4d12bsm4848401a34.59.2025.02.12.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:00:56 -0800 (PST)
From: John Edwards <uejji@uejji.net>
To: Hans de Goede <hdegoede@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: John Edwards <uejji@uejji.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Wyatt <fewtarius@steamfork.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Handheld gaming PC panel orientation quirks
Date: Wed, 12 Feb 2025 19:59:31 +0000
Message-ID: <20250212195934.91669-2-uejji@uejji.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e64c6778-9698-4970-a3c3-af3aabc232be@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, Thomas and Hans.

On Wed, Feb 12, 2025 at 5:14 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12-Feb-25 12:11 PM, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 12.02.25 um 11:51 schrieb Hans de Goede:
>>> Hi Thomas,
>>>
>>> On 11-Feb-25 2:55 PM, Thomas Zimmermann wrote:
>>>> Hi
>>>>
>>>> Am 24.01.25 um 21:46 schrieb John Edwards:
>>>>> Hello.
>>>>>
>>>>> I am submitting a small number of patches to add panel rotation quirks for
>>>>> a few handheld gaming PCs.  These patches were created by the SteamFork
>>>>> team and are in daily use by us and/or members of our community.
>>>>>
>>>>> The following devices are covered by these patches:
>>>>> 1: AYANEO 2S
>>>>> 2: AYANEO Flip DS, AYANEO Flip KB
>>>>> 3: AYANEO Slide, Antec Core HS
>>>>> 4: GPD Win 2 (with correct DMI strings)
>>>>> 5: OneXPlayer Mini (Intel)
>>>>>
>>>>> Thank you for your consideration and for taking the time to review these
>>>>> patches.
>>>> Did you ever receive any response to this series? If not, then
>>>>
>>>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> I had the following remark for 3 new entries added in patches 2/5 + 3/5:
>>>
>>> "Since this '}' is closing the .matches initializer it should be indented 2 tabs"
>>>
>>> With that fixed, you can add my:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> to the entire series.
>>>
>>>> for the series. Let me know if you need assistance for getting the patch files merged.
>>> Normally I pickup/merge these panel orientation quirks, but I've been swamped
>>> which is why these have just been sitting on the list.
>>>
>>> Thomas, I would appreciate it if you can merge the set into drm-misc-fixes, with
>>> the 3 minor indentation issues fixed.
>>
>> Sure, no problem. I'll wait for John to provide an update. Otherwise, I'll fix it myself while merging the series.
>
> Great thank you.
>
> Note in the review comments I said that we could likely fixup the indentation
> issues while merging. If you prefer a new version from John that is fine too,
> but we need to make clear to John what we want :)

Thank you both for your comments and feedback.  I am more than happy to
provide a v3 with the noted changes if requested.

We have no other planned changes for this patch series, so if you wish to
implement the changes while merging that is also acceptable to us.

Thank you both again.

John Edwards



>>>>> v2:
>>>>> - Minor rewording of commit messages
>>>>> - Include Tested-by tag for Paco Avelar in AYANEO Flip DS/KB patch
>>>>> - Add OneXPlayer Mini (Intel) patch
>>>>>
>>>>> v1:
>>>>> https://lore.kernel.org/dri-devel/20250116155049.39647-2-uejji@uejji.net/
>>>>>
>>>>> Andrew Wyatt (5):
>>>>>     drm: panel-orientation-quirks: Add support for AYANEO 2S
>>>>>     drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
>>>>>     drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
>>>>>     drm: panel-orientation-quirks: Add new quirk for GPD Win 2
>>>>>     drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)
>>>>>
>>>>>    .../gpu/drm/drm_panel_orientation_quirks.c    | 40 ++++++++++++++++++-
>>>>>    1 file changed, 38 insertions(+), 2 deletions(-)
>>>>>
>>
>


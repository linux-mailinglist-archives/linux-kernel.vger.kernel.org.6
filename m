Return-Path: <linux-kernel+bounces-546824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3BFA4FF1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89F81892D75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E624886E;
	Wed,  5 Mar 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuizDh9k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B10247DDD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179393; cv=none; b=nIqr2XsZCv97fWfPUa2atMMOJIdbW5kobx24UebeqeAghVz9V0Suxj1+CGiBrYF3/1EhK6An31kZUEGjsgGo7n135nxSaRe1E4FD6f1CJ2DUWE8V2cpyT7f8FTwwcZlxoDhf1l7nW/cSjXRBJmn2MRpXxI3kYKkwuarYPfL3NME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179393; c=relaxed/simple;
	bh=e1mwfxZUt3ptBte/jqIYvM3cOusxv8qa+gGvqR+6sII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lqwj2/Se03rcoua3FIC7mJJ9RMZU2X9f//whoMFnCfLK2o6ObI4t6ZljIeqb7YU8YvI5gI8nu+QtR4g+LQbpXQIY3cRZBycjc8VwIDOf04Q00qtveRlIo4TlgOH8GEs7yu49U44KTMuEvDNQXfVv5E+Lb4i+9lDHAMZ5rpyQriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuizDh9k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741179390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Za8i7LJ2q5ph41mgejRxdkDOeTZPIJR92M7/oekDxSE=;
	b=LuizDh9kzy4KGMEEAYdBwoY87iT0IxGfae0zPyqRbgjRJJ6kbpIOMW8N9ZRH5Z51fHkcnv
	tbI9s0HN65sthLShHOx84pDsUfrN6WZFsePDoUYpEmH4Ldkbe9Mig9pY1P4rjIjGi53le9
	95jZnCcJ2gHykGm/AtjWU4YUU5oRIZ4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-Im7zQb7pMIyzCGLZkpYAwQ-1; Wed, 05 Mar 2025 07:56:19 -0500
X-MC-Unique: Im7zQb7pMIyzCGLZkpYAwQ-1
X-Mimecast-MFC-AGG-ID: Im7zQb7pMIyzCGLZkpYAwQ_1741179378
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abf497da6c4so506541266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741179378; x=1741784178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Za8i7LJ2q5ph41mgejRxdkDOeTZPIJR92M7/oekDxSE=;
        b=Eb9iywMux0kjsNt6LRcFsv/nbI32WDXZdYc1uiefjz+3YdsarRgR7Nf1VGH50Mh2Lx
         XZDXLfGI13vIlsRz+1MMUYuGpyQ6C+01OvQ/FE3Sj9FrP/suhRgPBjwn1I9MunU61VoN
         ScK/4nmC4XtjyInKijxD1rijHgEzp1Dqp893tmuntZ6YlxYFLKa/eNswqGD6yp9Ddk19
         os+Xw+3W+L67HDUEmQThrhOG4ICfcTQGHsEOjqPq9zDVMAkhZ3+ErojCUloDHqnjGYpP
         KjsSK57g47iAZaHwjixrdSK5OiFIJ51CE+gBe6psejUAmV0nOCe7QAlWejtAtQ/99RVO
         xAJw==
X-Forwarded-Encrypted: i=1; AJvYcCUaZKpRsTbLLZDePxhuxjYItJbwl91QWaxaVw+Eb0EZL5LW85LwfWJdjMwM0HjSdWxr8p239g5LKqAEkPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqxfuZLGsjEeWO/A7MjepQiWtt0h7MItT/au2+ezk9M3adSiZE
	zJRip9Jyi6J85n4yaSm7suES78QRn9JSdK1zWZ8nP6gl2aEtDWiKYDIO6ry9PCT2ol2AfTHw7AA
	jbeSgHPH+Ab4nvv0lGDQ0995V2xYMcmfNO+kLNm0IKRk33TSWR8JKLl041Fm+MA==
X-Gm-Gg: ASbGnct7AQFY3vIphO7KdTs7vrI17/XrBXiWDIuI5cnMBmMqqqlWzWXGIaXHDx7zOWz
	T+RmnmJchEh3ZCovJIEmiZDL4H7/FSOQyXunNiIOXEBE/bQS6ZuanmxKMhDJcWa6vQIRump/u+5
	Bwebw/ROSi+dGoYAkHC9SpePrtsTiv/DqTaV+lwmKbkEM60DMsk/mrsoKWlJDAjcUg3iemCbgOb
	mBFQ8URPW4+Q4GAxuvSPA/iRVAVw2dT1TFbQ57KPYBni7ZvIe0pwfGflo9MVdqmATuypYYkt0o5
	oFN7ipqwxbckCmDNbb2FUg7s3xZXmXklKEqyJ5nNJBvNJj/NGu/1d3NhRULF5q6yGwpHlwNROtq
	lS4vpX9REF0Z7fV0bWY/wt0DYL8y1PmYNzJOtrrf5iBx3C1UOXDpEus7i5l2k7an2ZQ==
X-Received: by 2002:a17:907:d27:b0:abf:4c82:22b1 with SMTP id a640c23a62f3a-ac20d92d645mr264907166b.32.1741179378492;
        Wed, 05 Mar 2025 04:56:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7FU069uMF1dnQAV6+DOZu+Ac8Fl/LVt/1+ht6q83IgFnbpvYl09QsqZR11ilEO2jA0VLHfg==
X-Received: by 2002:a17:907:d27:b0:abf:4c82:22b1 with SMTP id a640c23a62f3a-ac20d92d645mr264905466b.32.1741179378157;
        Wed, 05 Mar 2025 04:56:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1fcc6f986sm239728266b.93.2025.03.05.04.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 04:56:17 -0800 (PST)
Message-ID: <44e18b80-8160-46a7-a891-de9014128d2e@redhat.com>
Date: Wed, 5 Mar 2025 13:56:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Input: atkbd - map F21 key to support touchpad
 toggle keys
To: Werner Sembach <wse@tuxedocomputers.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mario.limonciello@amd.com, ilpo.jarvinen@linux.intel.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303190442.551961-1-wse@tuxedocomputers.com>
 <Z8f1EzASdCfa2h_7@google.com>
 <9f3e1a77-246d-4880-af99-dcbfc94a573f@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9f3e1a77-246d-4880-af99-dcbfc94a573f@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Werner,

On 5-Mar-25 1:18 PM, Werner Sembach wrote:
> Hi Dmitry,
> 
> Am 05.03.25 um 07:54 schrieb Dmitry Torokhov:
>> Hi Werner,
>>
>> On Mon, Mar 03, 2025 at 08:04:34PM +0100, Werner Sembach wrote:
>>> In the default xkeyboard-config used by both X11 and wayland touchpad
>>> toggle is assigned to F21.
>> We have dedicated KEY_TOUCHPAD_TOGGLE that is being used by several
>> platform drivers:
>>
>> dtor@dtor-ws:~/kernel/work $ git grep -l KEY_TOUCHPAD_TOGGLE --
>> drivers/platform/x86/
>> drivers/platform/x86/acer-wmi.c
>> drivers/platform/x86/asus-laptop.c
>> drivers/platform/x86/asus-nb-wmi.c
>> drivers/platform/x86/eeepc-wmi.c
>> drivers/platform/x86/fujitsu-laptop.c
>> drivers/platform/x86/ideapad-laptop.c
>> drivers/platform/x86/msi-wmi.c
>> drivers/platform/x86/toshiba_acpi.c
>>
>> Instead of piling on F21 hacks we should be using it.
> Afaik KEY_TOUCHPAD_TOGGLE is not implemented in userspace, but a patch for xkeboard-configs could probably be enough to change that ... have to look into it.

Quoting from the other reply in this thread I just send
(our email crossed):

Werner, we were using F21 in the past because we could not use evdev
keycodes >= 248 (256 - 8 modifier keys) because of Xorg limitations.

But recently the mapping of things like KEY_TOUCHPAD_TOGGLE /
KEY_TOUCHPAD_ON / KEY_TOUCHPAD_OFF to F2x keys has been moved to
xorg-x11-drv-libinput which gets the full range key-codes from
libinput and can then do this mapping before passing the keys
to the X-server.

So it is no longer necessary to use KEY_F21 and even in the past
we used to do the mapping in udev / hwdb rules not in the kernel
in the kernel we've always (with a few exceptions which are my
fault) used KEY_TOUCHPAD_TOGGLE as that is the correct keycode.

Regards,

Hans




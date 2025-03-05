Return-Path: <linux-kernel+bounces-546674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F192A4FD8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF3F3A5EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4C230BD9;
	Wed,  5 Mar 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW0VeVpf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600F1EB5D4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173913; cv=none; b=MLs/40ZDQvSEPueFCoHYp9PZmXAPx4/JAmPtuoSAQRaMBUPPHYKA4MH8ypuFjbshMsc2pW3y88Zd5iJZr4mik7srV1rv/Xo5GiGQruU19tr3/4qw67eIoPOldHklS9pzZ2+19yhftCSSu3Cwe3TdGc8F98q5bj8+bw8B8neP0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173913; c=relaxed/simple;
	bh=xiH804oufxrxYJTAwlcyfD+RL0wGycJOQj1WxbEh2ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMx0qkbW7bEFYXez3vTXlSRzdgrwJv2QT0ODrRwQ9Hr4+aBeUdx5XdjsATVcD0YdX6wRuE3n2M5JT7Q91yLMpFUgw1TOvgQ0ABsQ0B0ZBk/dsdTFMsIUqkVFyHOyzRsl7CgXPMFTAZJD1PDj/6c10a3W9v+ze6sTLEVs0Sbt6H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bW0VeVpf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741173910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLdBM80iSu/uxRPEIQYDIE15fbxOACwJC7A0CjWSe5Y=;
	b=bW0VeVpfzDJr6inXqOoBXgrSuSg2nXl3SqCRPQhvc3C2eVYS6RlTIS3wcVcKoFpTd1bNDb
	LPjte0xDyWzo6HkafnmSnOwb1hx5b0Fj+AZV/rA0K4coQr8C8V/L8zDA9jL7gw+uGO9DUk
	9eASQSpAHK3rrv6GDVC+7e0BlmxpOqw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-MIShC1k8N5uVwUlAJ-XnoA-1; Wed, 05 Mar 2025 06:25:08 -0500
X-MC-Unique: MIShC1k8N5uVwUlAJ-XnoA-1
X-Mimecast-MFC-AGG-ID: MIShC1k8N5uVwUlAJ-XnoA_1741173907
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab7f6f6cd96so783513366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173907; x=1741778707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLdBM80iSu/uxRPEIQYDIE15fbxOACwJC7A0CjWSe5Y=;
        b=Zhd8agPkslJQl394qSPaxSh7HFpGNpMoLFT08WwOEFxf85+MZ5209iRujr5wPxueGK
         nmY3sRbsT825GoIibxbf/BNzpz7ElMeNcSd0mwfhDGIwzEMjNNSyQBVydxCn47/S8fdr
         juJrhtPA8kDXSjBaVyG+XIdB9dapK+CRoAsU7Atczb54F2M0L5Tycfo8PErw/naw13Jc
         figt5maevdWa4kk3xAuAriTty4ayM+wCO4QkKRR39htHK37XAsqEO3VJpYW7cC0WYldw
         /kNyDwHlPDbFfKOetHraUMsPeWVt6ggg4fiHj8+IFKnRsWucAWweI6tReFUwXXKFhVnI
         XnOg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ71GepNvJs9Ay9uyu60kXY6tKbQ69O/HJgFmiDpLmJ7aZQVeF54b5Jm/Oky2BOmgFqwn/BU7K0bGGgsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+lQltjfuBe8IK2q/8u2yX85mo0LWcrb3k9VgxSwnrp0MK2fW
	1C8kdOc/oH1+xDGAzaWVD3WdZVABstl4GziTyUffEkapcyb3wnxutNCDYOqbTHFYsIz1/fvn8IF
	I3TGCkkUDPt+Ya94uhOaPIGrtW0f1HT754yFvmCwBZBMkdygn6jgJ3D2nQe6gIQ==
X-Gm-Gg: ASbGncujkzyOi4XcwO8KiEgjPQIqiwKgQC4Hm+VCG7ZwFluHrqABjZ03RCpfFRgx4qW
	dd0C+of4zKS8zKfSCp/g381LUMlMx93UCAweckUNkLnppaPOMxnvcwPM70zK7pylzJ6z79vB1DB
	chY7RuXZkUb7yTvZWfZv/p5XRAEALd4L8+OuEW8IdU9Zogp6gn88a5bON+eRdEn5GuNw0EnkUWD
	+Zp0L2XTy/IS+THOjbYozQ37n+w/ps23nYAJrRtvPS+sm3TJufPy6Kb1qrHPeA60qefnwGK4Bx/
	+P8wYzXzUJvNfSRoEKJ5tO3d8FykuRWG97dJgsxtg86kTRtgKfGF1PGL0/s3O1EMMz1t9bQC992
	yOInGm8tYJCTbm5XHyVLFL3XgvIg4lgUUzvdWNUb+dw/3JMTGOfzBhBiXS/pLZ14Dfw==
X-Received: by 2002:a17:907:9451:b0:ac1:e53c:d15a with SMTP id a640c23a62f3a-ac20e1e0852mr245953666b.54.1741173907345;
        Wed, 05 Mar 2025 03:25:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfK0GN8cel3aG2y75MwUH71YyraHg7k6K92jmUWyjDePWKPAfjLCL/CMQnQRRlkAciRT8l1w==
X-Received: by 2002:a17:907:9451:b0:ac1:e53c:d15a with SMTP id a640c23a62f3a-ac20e1e0852mr245951066b.54.1741173906892;
        Wed, 05 Mar 2025 03:25:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf53bf6621sm747600166b.41.2025.03.05.03.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 03:25:06 -0800 (PST)
Message-ID: <1bee0a62-058b-482a-8eec-d45b8aca1614@redhat.com>
Date: Wed, 5 Mar 2025 12:25:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 FN-keys
To: Werner Sembach <wse@tuxedocomputers.com>, mario.limonciello@amd.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250303190442.551961-1-wse@tuxedocomputers.com>
 <20250303190442.551961-2-wse@tuxedocomputers.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250303190442.551961-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Werner,

On 3-Mar-25 8:04 PM, Werner Sembach wrote:
> This small driver does 2 things:
> 
> It remaps the touchpad toggle key from Control + Super + Hangaku/Zenkaku to
> F21 to conform with established userspace defaults. Note that the
> Hangaku/Zenkaku scancode used here is usually unused, with real
> Hangaku/Zenkaku keys using the tilde scancode.

So this control + super + scancode 0x76 sending is also seen on
quite a few other laptops and I think we need a generic fix for this.

I recently noticed that KDE's keyboard-shortcut settings actually has
a  control + super + Hangaku/Zenkaku -> touchpad-toggle key binding
in its default bindings (IIRC). But that cannot work because xkb actually
has no mapping for evdev code 85 / KEY_ZENKAKUHANKAKU if you look in:

/usr/share/X11/xkb/keycodes/evdev and then look for 93 (*) you will
find no mapping. I think this KDE default binding may be from a long
time ago when this did work. Or maybe KDE uses the FOO part of KEY_FOO
as symbolic when there is no xkb mapping ?

*) 85 + 8 all codes there are shifted up 8 compared to the KEY_FOO
defines because codes 0-7 are reserved for modifier.

I hit the same issue years ago on "T-boa Tbook air" laptop and
their I fixed this by mapping Hangaku/Zenkaku -> f21 in
/lib/udev/hwdb.d/60-keyboard.hwdb :

###########################################################
# T-bao
###########################################################

evdev:atkbd:dmi:bvn*:bvr*:bd*:svnT-bao:pnTbookair:*
 KEYBOARD_KEY_76=f21                                    # Touchpad toggle

+ teaching GNOME to also accept Ctrl + Super + XF86TouchpadToggle
as touchpad-toggle:

https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/master/data/org.gnome.settings-daemon.plugins.media-keys.gschema.xml.in?ref_type=heads#L577

Notice that system76 has the same hwdb key mapping for their
Pangolin 12 model which I presume also has something like e.g.
a clevo as base model.

So for now to fix the touchpad on this TUXEDO NB02 you should
simply add a hwdb entry like the above entries.

Longer term I think the right fix for the touchpad toggle for
all laptops which do this would be to make GNOME do what KDE does
and change the touchpad-toggle-static keybinding list which
currently is:

['XF86TouchpadToggle', '<Ctrl><Super>XF86TouchpadToggle']

to:

['XF86TouchpadToggle', '<Ctrl><Super>XF86TouchpadToggle', '<Ctrl><Super>"Something"']

Where "Something" would then be the new mapping. Or maybe just teach
atkbd or xkb or hwdb to map scancode 0x76 to TouchpadToggle by
default then at least in GNOME this will work OOTB and for KDE
a default binding of '<Ctrl><Super>XF86TouchpadToggle'] -> touchpad-toggle
should probably be added there.

> It suppresses the reserved scancode produced by pressing the FN-key on its
> own, which fixes a warning spamming the dmesg log otherwise.

Can you not also suppress this by mapping the key to "unknown" in hwdb?

Regards,

Hans




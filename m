Return-Path: <linux-kernel+bounces-531731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488DEA44436
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83F6189E9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11BD26AA93;
	Tue, 25 Feb 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="gNC8SD6m"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A75825D546;
	Tue, 25 Feb 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496892; cv=none; b=VTWmFo+LKpDt215TNvbqtUryArqWnlbMsw/r0iid2TOGjgEBEH1X3R9YyquY5AQKsuTVl0pNFpYRP1eMMrqYneuP2li5hKMg2FuWR03HJiT1P8eVfsAOnqfmSb0cDTSOpvAF7R7faPpae6J9F/VZ/B9Qdq3fKVWiFBhgb1OdFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496892; c=relaxed/simple;
	bh=FVKv8GrgSmao0OIpGObeXk+FWqUHw2hHv3c8zmGSzsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyyeL4qYVIOxID3EOA/IsYXu8N1VhnfUpM1u8t8ZCSi3nBEbUu7BpC9H0Nnl5wgP1kf7O2nu8VGDz+XxwNs/pts6zO+K0YwPkxTsikM6kA9Mu7AVrnT63IorqzUzbE3v37mHQ5YYypDqpptrr78ULee2lzA5NaByG6Kt4DM2ELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=gNC8SD6m; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 71A952E08DAD;
	Tue, 25 Feb 2025 17:21:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740496886;
	bh=xWuahah/PdOfmDNyuBQXOs+HN3Pjy/JHF3ALg0qBEzc=;
	h=Received:From:Subject:To;
	b=gNC8SD6mrK5kXfFoU60otEoy3g8khZzHUb+PkNCCAD0U5gdfLCGAJfQqE4hekSMjL
	 fX1xWpZlDy1ToU5csyrLVC8J2u4/godvE32l2PT/7k5mADK9QvONlngNVoxAVJvQXC
	 MJ2jkAhMKEPg8OfyMks4nvSBETrNc0EJ2b1ci8ek=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f171.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-30797730cbdso56804081fa.3;
        Tue, 25 Feb 2025 07:21:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Jp8zVWlDj8Q3g5O2aCbXv5xqkHOXpQIKLTR/LHdtAwM6LaiNfkv1JSegXlth2qk73KHg8e/oAEPxeng=@vger.kernel.org,
 AJvYcCWwItNSr7Y+OlkPD7KjikRzgjiIuxtyD12pwTZgdJQcBsdN/d32nrTnuyAE+P2VW1477Xg8KRamHDNuSxd4YUuFKliaXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsx4X9DNIG0T+N2cFNi5YHw6BjU117nMyAyKDl0kwfrp00Vk2Z
	PFwA/oLfwIq/9AfdNzyxCvSZyosYedaZoQncAqJPpt6U4G8nIh2fhXgX8BBHi6CbSgWudeQEf5n
	CjSRlnnM3gm6rnNX/BaN3cEJy9Wc=
X-Google-Smtp-Source: 
 AGHT+IGOxt1nlQx6O/l/QrJKSFe0IYaaYfHThuSDfRPp/NqLUzZ59caD5eWUj8y4EmUIUOdt9SR7HGOm4SNjDqJcifM=
X-Received: by 2002:a2e:9e0d:0:b0:308:f5f0:c438 with SMTP id
 38308e7fff4ca-30a599b8ca7mr54828541fa.31.1740496885703; Tue, 25 Feb 2025
 07:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224223551.16918-1-luke@ljones.dev>
 <20250225142555.14005-1-lkml@antheas.dev>
 <4612ead6-d76f-4a24-ab4e-f45b0178d70a@amd.com>
In-Reply-To: <4612ead6-d76f-4a24-ab4e-f45b0178d70a@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 25 Feb 2025 16:21:14 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpQ2d0bTOmNVn2MCzXfdYylCfDXf_AL-LaupFBFRXcc1ncNj05LlrSWOsQ
Message-ID: 
 <CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: change quiet to low-power
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: luke@ljones.dev, corentin.chary@gmail.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174049688685.14640.17415816087005026662@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> The documentation says to look at platform_profile_choices.  To
> determine what is supported.  FWIW this is exactly what
> power-profiles-daemon does.

Yeah, this one is minor all things considered. Since there is a
justification. Even if user error is not the best of justifications.

But as I maintain a userspace TDP tool, I can tell you that if the
other issue is not fixed, /sys/firmware/acpi/platform_profile is no
longer trustworthy due to being able to occlude platform profiles. So
a mitigation will be needed for all userspace power utilities. But
there is actually very little use currently for
/sys/class/platform-profile as AMD pmf is mostly a NOOP, so I think
this would be premature and should be avoided.

While I do not have a large portfolio of ACPI collections for
Thinkpads, HP, Alienware, and Dell that have WMI drivers, I can see
amd-pmf popping up on a lot of the late 2024 models of GPD, Ayaneo,
Lenovo, and Asus, and going into 2025. So it is worthwhile fixing this
now once and for all.

Antheas


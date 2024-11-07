Return-Path: <linux-kernel+bounces-399886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A27F9C05DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307131F23655
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A34B20F5CB;
	Thu,  7 Nov 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXPj+Qru"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EC15B0F2;
	Thu,  7 Nov 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982617; cv=none; b=pqUItSk2+0P5TpUPoKjx70t3IIq2vFq6ouso1/aArm1PIohIQLDLUwATx3e/FhDcWR/fqJQyhX1JmWTVuGG3qGR9P1DVZDhDgYDIldGhbcr8yHSwnFFZ2Sej6c16R9sUMvyPpASUTvmgqOXBiZo9NxjSrDFWGHmfqt89qJ6XE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982617; c=relaxed/simple;
	bh=NfIAoTUNd65pd8dw7EWW++d7r9favuMrvSigJfSdENk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jFsYagiTtVQ/BKRBKILd9ESCh4n6rn0uWzhJdRLIfPi4IYx+8YQkn6k7oULyFeBOmaf8e6CjHvJuyy28LrCA8ZMI1mkpLqowDBwcwFVcQzeKC5VppwrXT76xvtQSDWaBVTKFAxiBDMy8M+ddJ8Xa6NzZ5gjmiBzZiL/9mPo/FOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXPj+Qru; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43169902057so7475915e9.0;
        Thu, 07 Nov 2024 04:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730982614; x=1731587414; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fO3ZwuBERNsA2ScCR0PdUPyg+cOEjOnSnOglWOrJKY=;
        b=iXPj+QruAXR0CpZhMZzizfHdqq4cWIb54HnmZHKDvu064fx13Pspue2ld2efUehmL6
         7ZkhtfdUiwVcaxJssMcKuoEu9vupCSXH2B2iST/jQ+mN+lSocMTmVsJIcu7UKxrcBchV
         tGZfPFZxYnbXeUSwH19vVr/ghKi89hT1a9N+ExYu+/jGkiDgHzEApzhaHQNq0Cw1NZL9
         ySqb/bInYwTvUkMOT0Pn5FqV0MnqpunbznE4W7+UOh4WB1D32UnsjvCdCEYXcKIfw5qA
         ZCWhPPd3XNJiFaRi/YCrM0OSGcDO1HcsXAiHhe85FcYauWEKKNKVWyC+rOt6lcV3pW0e
         NZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982614; x=1731587414;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3fO3ZwuBERNsA2ScCR0PdUPyg+cOEjOnSnOglWOrJKY=;
        b=t3iF/qYeXfQrL63sIOCNBpQG7H1yAm8ZRxzCq8HKp3Wq76SsyEO9dKsPLdQ0GjL+Zv
         t2tiiOeoyrROL6XGeszqmPejWsjV9rZk5y7Ze9F4Sxwd52cwUIEZuqEMV4K7qzoQw9fy
         oTYCemBWeLze6TqDi1Oqyj2hFct70y4WpMqPSvieXjwcX8mxJroCkC5OCaModjlA7ED/
         QeBzPzD2XkXRVoQ8iXS2wyFCJHoQAelX9leCGSpcCBvSlz1H1VnDkecIdhDhUv0TzTLf
         Vd3lgCnhklQ57uCp5m6EC+FsnKNgWoT2MyzO/eZtSFROlq4jzYhV/sJiSYQUlA63KpoN
         +rSw==
X-Forwarded-Encrypted: i=1; AJvYcCWLSCxQio44zO5CjN7svMvdsXmEr1SpZNdPMJvKivMJe8h2cldMyvtll2Mfl0Sgu7Qu+oifQ4RRZAMm@vger.kernel.org, AJvYcCXGQz/wNDNUmWo8pGCXjZNHmjvEtUnIAlkTgANIVw7rBiF4qFI0gNnB0g64kBxXV8NUrscw9weggdOSi/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7nkyocGAO7YiQrnul1OQIveNA/noti4GtqmTQ3wtPK/h04wr
	RRqVx1zBf43R4BjNUHTkwftqdkUV3S4TyclcpwMmi30/QLxKhlrX
X-Google-Smtp-Source: AGHT+IF4SWGHu+0j8OqusA28zDPmGDFlduj9Dli2AoLdLX7O3CwCE4RNwVm88WYtw6TF6f/4YgBA0A==
X-Received: by 2002:a05:600c:3ba4:b0:431:5ed4:7e7d with SMTP id 5b1f17b1804b1-432b301e7f3mr11457705e9.18.1730982613986;
        Thu, 07 Nov 2024 04:30:13 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b05c1c81sm22973555e9.32.2024.11.07.04.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 04:30:13 -0800 (PST)
Message-ID: <5f54ffd0-b5fe-4203-a626-c166becad362@gmail.com>
Date: Thu, 7 Nov 2024 12:30:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Cercueil <paul@crapouillou.net>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>, linux-usb@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: usb: gadget: Add support for USB MIDI 2.0 function driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Static analysis has found a minor issue in the following commit:

commit 8b645922b22303cec4628dbbbf6c8553d1cdec87
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue Jul 25 08:22:00 2023 +0200

     usb: gadget: Add support for USB MIDI 2.0 function driver

The issue is in function f_midi2_set_alt in 
drivers/usb/gadget/function/f_midi2.c as follows:

         if (intf != midi2->midi_if || alt > 1)
                 return 0;

         if (alt == 0)
                 op_mode = MIDI_OP_MODE_MIDI1;
         else if (alt == 1)
                 op_mode = MIDI_OP_MODE_MIDI2;
         else
                 op_mode = MIDI_OP_MODE_UNSET;


the first if statement will return if alt is 2 or more, so at the 
following cascaded if/else if/else statement alt is either 0 or 1, hence 
the final else that sets op_mode = MIDI_OP_MODE_UNSET can never be 
reached.

Either the last else statement is redundant and can be removed, or the 
first if statement needs to check for alt > 2 rather than > 1. I'm not 
sure which one is the valid fix to make. Any ideas?

Colin


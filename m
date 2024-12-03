Return-Path: <linux-kernel+bounces-430079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA29E2C60
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7D9282F68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0530205AA5;
	Tue,  3 Dec 2024 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdHUPFTE"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FF13DDAA;
	Tue,  3 Dec 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255495; cv=none; b=hrTRLyBeS3MYvmZQt9WP5G1wlsfdFO+Fn8C52h0dduGlcmtUZhtlsguIElrqxOmtX9mhxF3Zs6DvRdHtoTijnc7dAR5XAYHOu9uDP8Dglu9rxvtHgy7BqoEV0VM6dWtZM+6QbRXfFpeEaHsqy4qQHw/hY8oQ0w/rSzIKe6nwZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255495; c=relaxed/simple;
	bh=QrBi+Qjjq5QmYzI3/WYIsd64PH32ZpRt/mgF/DYihjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UQ/1r2pjStKpFnfh4CQeSjGlVwmvxvXTjwaPFZeKioTQRtESITaeS/O3sONxNlgfJlNpBdc5deyboy/L+SFSCHmnL2XZXK0Wi3LT1J+5WeQ1MrkLFRHlY8LKA5ZMNgKMr5ZbEa9ZVL3e0P0qMHpyzZ1LjXoU2hhanOJRU4WuUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdHUPFTE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de5ec22adso7534818e87.3;
        Tue, 03 Dec 2024 11:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733255491; x=1733860291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1tz9xwJu94HYXO75bGMc1Hev6Bo3gyDist3jGFCO6U=;
        b=kdHUPFTE7LldBkUzZuJ4e/f23uh3ULgq7yPfVug65wOd1NZxSjxUC7sDMW8XIYGIy6
         wwEQ+fA0QXt1uQLwlzCKb5iS4MGsSZOptkz3EzI8I464/OYPopNyS1/uLRLN9Yi58cgb
         ciiAopbgIPYd7fNqpDDycAqDa57xgsNrF4bSK4VrItm3fQTj0YeiFBWm48bt12w+hEeX
         cnn4M34mD92VnhHNNS41FU4PNtzIQNGcuNjrI+RXxVohhx5ofwFy4ihe5b/deXMGXxoN
         CH8/KrR80KW80iz9fj2+e5yF3AaEVyQIJPjrTnrWkOIY4WPh1UG7LVJkLnZrhpHv9JyJ
         1ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733255491; x=1733860291;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1tz9xwJu94HYXO75bGMc1Hev6Bo3gyDist3jGFCO6U=;
        b=PDonCGJDljByf2X/KvfVxwqnDE2S3mSCTC1MEB7GxALH2rBMut1zgSfDO97wOBZ6aZ
         recAjpjeuntT6iBeJuJwMCKpD3qJXBitMh42UF5JgC5SZNhEFZuSpSPCAqK5GN6he9Bi
         Dgc1tW+JBAYplH+uAgtHao8n3sXltrY2uLOnNVY817hQ5hG+Vt+/BTmdkYVbIbBR8KYC
         OW7ZKpnJk6TgmVHatiasr++59dyCvUDZ1/6cVoq4CX+KgQr5uMVVY4197EQ0kzvpKoqK
         cQjCwSMqgMoS1JdQb/8/8JUTikQGbfN3Ks+y5i0K12j8wt3eSMSB2Yr7FNmBVfkxWIvc
         0B7w==
X-Forwarded-Encrypted: i=1; AJvYcCVk6DWA60p2lx1GJ5IBmUmqMEDXkN7nbyg6VyxoEazgXkRkbL/K57QshPajtkvcjxeAXr+Pnhs1w2OPESA=@vger.kernel.org, AJvYcCW1Nhckg18wTn+z/+Nq6otVHA3ehGg2VIVijMq376YVRy0rsXm9CZ/RCBRV52V7ZMprQQIAkwbQr+KF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1GUeJgWO85UmS4TTFj46oSZvUfC5258UgxaatY6/JGe/3KBm+
	AJP1ofyjDWxB4heC9vI/H/nWqN6+xAwSbrN3UKyk4SddviOp3OmBE//oqA==
X-Gm-Gg: ASbGncuHw5sx8sAXp2XlBoT12Jw+e3+myUG7RZBEVSBWVyzERr2D9rBYV/KN4DKiN7E
	PhrV/OFm9HHIkO8jpROEyOqQD7CDTUoa311Y+y3ISCngtEr7Amu8fN7fP2bBT4DbG6oBuKnVrpE
	WQ3CD+/wBsCcENeikYKs4HtuxZnwoy/SUZrL7EtW9oBgycBedVvDA/VOaRa+WapvXP/hktbPWXA
	MpW3jtjIPZVES4hUNxxc2GU7qQTH8WAYHMcwPhrdW/djQ3oEXzesFqu2qKgs6Ex
X-Google-Smtp-Source: AGHT+IHMaOrrNi7FwkbZbHQBdyhwM7aZkDVKbAZxVHhUhz8knBqwtIHuWu3nnENcYhidTQkUa9mo6g==
X-Received: by 2002:ac2:4c47:0:b0:539:fed8:321 with SMTP id 2adb3069b0e04-53e12a283b3mr2605148e87.51.1733255491100;
        Tue, 03 Dec 2024 11:51:31 -0800 (PST)
Received: from foxbook (adqz95.neoplus.adsl.tpnet.pl. [79.185.159.95])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1bab1146sm111994e87.123.2024.12.03.11.51.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Dec 2024 11:51:29 -0800 (PST)
Date: Tue, 3 Dec 2024 20:51:23 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1]  usb: xhci: Fix NULL pointer dereference on certain
 command aborts
Message-ID: <20241203205123.05b32413@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

This fixes an issue discovered by code review prompted by this crash:
https://bugzilla.kernel.org/show_bug.cgi?id=219532

It has not been confirmed by the reporter and doesn't agree with some
of his own analysis, but:

1. it is consistent with logs provided by the reporter
2. it looks like a real bug in its own right anyway
3. it is rare enough that it may not happen again soon


I tried to minimize this patch and only address the potential crash.
The code looks like it could use more cleanup, though. Any comments
regarding the following suggestions?

1. It looks like we don't really need to ring the doorbell if cmd_list
   and cur_cmd are empty. Even if commands were no-oped, they are still
   on the list. And if there is anything between enqueue and dequeue
   which is not a link TRB and not on the list, we will have no idea
   how to handle the resulting event. IOW, it's not supposed to happen
   and probably never happening, or we would hear about it.

2. The whole business about turning commands into no-ops doesn't seem
   to happen in mainline today. Only the pending command gets aborted
   and it is removed from the list before the no-op loop runs.

3. xhci->current_cmd seems redundant - is there ever a valid reason for
   it being anything other than xhci->cmd_list first element?

   I find it suspicious that handle_cmd_completion() complains if the
   completed command isn't the first on cmd_list, but not if it doesn't
   match current_cmd and that current_cmd is then left unchanged.

Regards,
Michal


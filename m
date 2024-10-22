Return-Path: <linux-kernel+bounces-376654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0639AB47A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE7F1C22DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0881BC091;
	Tue, 22 Oct 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu8U2R7B"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827A1BBBF7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616150; cv=none; b=qtkairhLjyjqGp4IT8R+9jt8WZJOuEyU+oD+qn6LDNlr6HHGDcs8xjaMnKEIyaznDGW73pDynBTL6Ky2jbIhVlUKLQNAZoKaDbb8Ut+Y8eubf1x0SWaht+LqkUsoFyName6/IfhcoEfkhqKrTEc6V7S8oaOhdFrNkcXlyCfHtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616150; c=relaxed/simple;
	bh=+e6q9Fhz8aSdy1Z2tIYTTgkqd5/0R5U/RO7S+4nqmqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdQaQIIUN+Z1fYmxWWGxaCJDQp1FHhFzi1vwysvvait67zB0g+e2jyMs5wn0LKoS9LRsKRBcTw30wdAwlqBztBwyzrY5VyW0TD53QerExTOASqg6N27qOkSj3Tpq3sWJ3RMcy3wzbKBQToeB8e5R6NbaVIXK74SEBBTA/wpIwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu8U2R7B; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83ab5b4b048so208164539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729616146; x=1730220946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+e6q9Fhz8aSdy1Z2tIYTTgkqd5/0R5U/RO7S+4nqmqA=;
        b=lu8U2R7Bwi4Adgdx/U/ZVYHuTGe6rQkyY3CeAXslvEthQD6fnCcGazQeRd3KpMVq3D
         kHxWOezZgPOh1gU4E21JKOZkY7w8mehyHqmQplBn35aORI+QoC60GkuRjsorhvRBKGMx
         QAvvsulA5w4K+/VFby6spJNecKv9RAndJSqxHG/MSiScdOKbbQjXGUTLOh64eJuEonVL
         MyjETp6W+2K4E4c2p5xcSRvOoOWfbzc5vbL+jat2/7h2dmVVqX/agaxAElOEaaNNKXXK
         82gRWx+IaSX4I7EDg/hNSrZGb6mykmof34C3FOFgvrFL4QuN/x2cZVEltqFd60UpnVXA
         6zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616146; x=1730220946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+e6q9Fhz8aSdy1Z2tIYTTgkqd5/0R5U/RO7S+4nqmqA=;
        b=hG/OcP9hqDftCBNBR2e/2lavGSnEwGIiub5Giv+lcqvfytJ0U2GXjhuBnQy4n8CpkF
         sRA1XMLNgVzDRQBRo5JBPAWjorUhmHTI3Cu5lTZvv/6Rs4IUsjYpqviawtdhMFx42YvR
         vjbTol33I9b4Pwtt9hiynp6tRfgmaqpl6coPq6EvOyD+W8EG97V4T08oiZwsoVcn+W2/
         cv8cNpaAPcEZ6iP4F6iIBeFg98J1gcFrI2339XtcfxMXDl1qlXBzSVZ2bwte8kfTxHDY
         qLXlTOsppqEiJ/6LqphChBraAULuplmnPzzTy3iAQA1CJ8OFvtMLe3EF0+aO/YbDT+S7
         CG8Q==
X-Gm-Message-State: AOJu0YwzhX0rtk81BVLgHku5Kg7cNwHrvvl4l5V6QLUD0nptRN3h2sEN
	302It3xj8VINg5AtnTcNGG7+mzdqBO3Y6aecUgAZ13WYH/C9Cmx455VM7A==
X-Google-Smtp-Source: AGHT+IGDNQ0KQznepv7zqyOItqD3rin06YqQVwyET8jIZSiFKgMxfIX8Egcb9pA38atZkogTYwzGPw==
X-Received: by 2002:a05:6602:3f8a:b0:83a:c296:f5b0 with SMTP id ca18e2360f4ac-83ac296fd5amr1224163839f.9.1729616146011;
        Tue, 22 Oct 2024 09:55:46 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ad1dce110sm173957539f.40.2024.10.22.09.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:55:44 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Thinking about firmware and hardware description for latest Rockchip platforms
Date: Tue, 22 Oct 2024 11:53:46 -0500
Message-ID: <20241022165413.2156-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi.

I was writing this because most of my attempts to contribute to this
site (also with older email shimmyshai00@gmail.com) have been
motivated by the fact that newer fast ARM SoCs like the Rockchip
RK3588 and perhaps now the even better Snapdragon X Elite are potent
enough to be used as at least a low- to moderate-grade desktop
machine. And because of that, my ideal has been to try and help
coordinate the development of both the Linux kernel and a suitable
firmware package to make it possible for a user to load a Linux
distribution ideally from a USB stick in the "normal" way that is as
easy to do as on a regular x86 PC, and not to be merely constrained
to vendor-provided images.

Particularly, in regard to the Rockchip RK3588, I think it really
cool how far the support has progressed and that's very good news on
that front, but one thing I'm starting to think more about (and have
thought of before) is the firmware/boot loader situation, in
particular with regard to the hardware description given to the
kernel.

As you know, the kernel currently uses a separately-provided Device
Tree Blob (DTB) file for configuration, and the kernel source code
basically has to know every board and device that exists. From my
reading of discussions on this topic, this is often pointed out as
being due to the fact that ideally one would want to have "good
firmware" on a device that delivers a clean hardware description, and
typically one deals with "bad" vendor-provided firmware with bad
description methods, while the kernel DTBs provide a good idea of what
such a hypothetical good firmware "should" provide. However, because
of the need to have a specific device tree blob file for each board
along with the kernel, one cannot just use the typical USB stick and
install process at least with the commonly used bootloaders assuming
a PC architecture.

But obviously, that equation changes when you DO have good firmware.
And that's the rub. Because this puts me in a situation that it
doesn't seem hardly ever is discussed, probably because it so rarely
exists - having simultaneous open-source control over the development
of both firmware AND kernel. Namely, I've also been helping maintain a
package for some of the RK3588 boards using the EDK2 Tianocore UEFI
framework, which can be found here:

https://github.com/edk2-porting/edk2-rk3588

This type of firmware seems close to ideal; but it puts one in now an
awkward kind of situation because of the HW description process
mentioned. Namely, this firmware has the option to pass either a
Device Tree Blob (DTB) to the kernel, OR use ACPI configuration as is
used on x86 PC machines.

Now it would seem, then, that the most straightforward approach would
be to simply bake a DTB in for the hardware, but the problem is that
it appears that DTBs are continually revised in kernel development
even for long-supported chips (e.g. the RK3568 and earlier). And that
creates the possibility of breaking backward compatibility, so it
seems there's a chance that if one were to just include a mainline
.DTB into a firmware package there is no guarantee it will remain
compatible forever with every future kernel version. And having a
user have to upgrade firmwares all the time just because new kernels
came out also seems kind of to defeat the purpose of having a
firmware-provided HW description.

And to this I can think only of two options. The first would be to
have a "political change" on the part of the kernel developer team to
agree to "freeze" in some part the DTBs for these platforms (I also
seek to work on firmwares for the earlier RK3568 platform and perhaps
also other RK35xx variants) so that they remain continuously
backwards-compatible indefinitely. But I am not sure that would be
something that'd go over well here.

So that gives the alternative option, which is to do like on x86
systems and start to add some form of ACPI support to the entire
Rockchip driver stack, because the ACPI tables are maintained on the
firmware side. However, it likely will still require a fair bit of
back-and-forth here to do the initial establishment of a full
"standard" of such tables for this kind of setup viz. my discussions
in an early attempt at this on the I2C subsystem, e.g.:

https://lore.kernel.org/lkml/20240321173447.15660-1-shimmyshai00@gmail.com/
https://lore.kernel.org/linux-arm-kernel/20240414000355.10984-1-shimmyshai00@gmail.com/T/

but I never really got through to fleshing it all out, though now I'd
be definitely more interested in reviving the project if that's what
you would be interested in.

So I want to ask you: how should one go about this, or is it not
possible at all?

Thanks,
Shimrra SHAI.


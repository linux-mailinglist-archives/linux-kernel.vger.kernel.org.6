Return-Path: <linux-kernel+bounces-188768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF98CE6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA06B21578
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43B012C486;
	Fri, 24 May 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="odr2+K57"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E012BF38
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559701; cv=none; b=H++tkBpJguGlqqJ2IqbNNKCHR2HLtVSA7jWgH6JxZ5oMmWwYSypk14caWGyl6zkiAIsvByAmNm4NBs1hTUffqLMQ3dydMVGA4Cb2OWlSvE3muvyxAD30xaBJhHsNP9BdPd0ribNagNwrIq1pjF7ErUv+cy2P/6pcbFJioKQmVlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559701; c=relaxed/simple;
	bh=KmSHqkLEACdJA5JkR30IvcQRznw1fQacuNaMNWW7CGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKkNZLuaco8fRr6ae1QO4V/dGDjhUwyb6N7Wh7MQu+Dd9ej+0tk0KiCcxc8ttoFwAvlrICJVpajuBfYzKnwAAduK6uW0N1EqRuPN4nRn6/IEulNC4riSn+JTiLEJa7nii0lWA8KYxzUyegAeA/Ub/NTSynwaVAGsDqTSOT0mG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=fail smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=odr2+K57; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295eb47b48so991014e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1716559695; x=1717164495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw+x2I02cfRHY66/tRD0BbH08xb2ysdRK1VqCkSSMhk=;
        b=odr2+K5794KfAlnHQfv3jmJprvLU5Ldl2F9XkrNTBKpUXH1kX/S1IYvICFpuvUc5ww
         qNF0hJXVdV+DArSgY0DJK17bMPzkjZxqP0TR0k3Vgi4RnQ8KC/47trDn3HlTv9DOfWDR
         WK70Yd1chGEX6XoS+5jxleiE2Nn3r0pW+ry/HHHkdsG8wqtkmtNaqnkHkWadvTGFLrq+
         6xqruHT/1h3nA6pB70+34tV/LrxaPImm5+k2PFUSujN3gA9TghcDB34thG5tiWM2+3l/
         ugawdQLHMBUYSpf+emCoSuocm0nSgI6lNwUZo7DwrxjSQSnc//YV4Y9xF8cxcrCAjwyi
         ed6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559695; x=1717164495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw+x2I02cfRHY66/tRD0BbH08xb2ysdRK1VqCkSSMhk=;
        b=chgPWMXhGyLwu8njeUpBu6hkS6vRuXMhAY2azldjSWLljswJeJZaBKGlGBXwpecN5v
         nz5OZuwcbbxmimPJZSPQ6wbl8p81yHLt2tpKfGxcKZZtXvyh3sVGx8ORqJAghU1GJDcA
         MCPi/14BS9rhhui1ValRw9zsrfiZVxEzZp7txDGb9HefcaBo9VutagtG4xq4unCT9T37
         CARqOMT6u6aQmRV4pelXa9ItMt27QwJwMWubMDj/z3N8MmIXvnMdVjIbz7GPTnaPaCz/
         AFYx00rNgSZm1MCCXxaNhtOqd/Ya5/I/04kQZzdJ5mNXQo2YqYUtJ1bqm6vpR9euy8Mj
         hwjA==
X-Forwarded-Encrypted: i=1; AJvYcCW24AhuXxU0wUXGgmMFV8Yz/RFL3xo7AYjm8wxLk8+Gm45U1MKTUqWzCWRPYYO+ueq69abD2XW5JVHSR6bS1a/ndYCixnDyIrvm7MFh
X-Gm-Message-State: AOJu0YyRnHFwsFgVyJs1U1J/ql1QNODyXBMOr4+Hw7MoRIAKVIIFYcLu
	QNb+mw/a/xCBsvA8VC80lCp/RSfvZxcKXpjuJLzFt4rffVUp72o1bXBz7cIZ4ZY=
X-Google-Smtp-Source: AGHT+IHikd5bcFxVugcTWkXTYj6tWsPERSNIKCxhLOzj5DEmZPLVfbyUeeIG0OEv6qkAYQxT9EkvLg==
X-Received: by 2002:a05:6512:238d:b0:51e:7fa6:d59f with SMTP id 2adb3069b0e04-52966bb200fmr2244010e87.53.1716559695152;
        Fri, 24 May 2024 07:08:15 -0700 (PDT)
Received: from localhost.localdomain ([185.117.107.42])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5296ee4a9cfsm185474e87.75.2024.05.24.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:08:14 -0700 (PDT)
From: =?UTF-8?q?Ram=C3=B3n=20Nordin=20Rodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: parthiban.veerasooran@microchip.com,
	=?UTF-8?q?Ram=C3=B3n=20Nordin=20Rodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
Subject: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Date: Fri, 24 May 2024 16:07:05 +0200
Message-ID: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
Let me first prepend this submission with 4 points:

* this is not in a merge-ready state
* some code has been copied from the ongoing oa_tc6 work by Parthiban
* this has to interop with code not yet merged (oa_tc6)
* Microchip is looking into if rev.b0 can use the rev.b1 init procedure

The ongoing work by Parthiban Veerasooran is probably gonna get at least
one more revision
(https://lore.kernel.org/netdev/20240418125648.372526-1-Parthiban.Veerasooran@microchip.com/)

I'm publishing this early as it could benefit some of the discussions in
the oa_tc6 threads, as well as giving other devs the possibility
massaging things to a state where they can use the rev.b1 chip (rev.b0
is eol).
And I need feedback on how to wrap this up.

Far as I can tell the phy-driver cannot access some of the regs necessary
for probing the hardware and performing the init/fixup without going
over the spi interface.
The MMDCTRL register (used with indirect access) can address

* PMA - mms 3
* PCS - mms 2
* Vendor specific / PLCA - mms 4

This driver needs to access mms (memory map seleector)
* mac registers - mms 1,
* vendor specific / PLCA - mms 4
* vencor specific - mms 10

Far as I can tell, mms 1 and 10 are only accessible via spi. In the
oa_tc6 patches this is enabled by the oa_tc6 framework by populating the
mdiobus->read/write_c45 funcs.

In order to access any mms I needed I added the following change in the
oa_tc6.c module

static int oa_tc6_get_phy_c45_mms(int devnum)
 {
+       if(devnum & BIT(31))
+               return devnum & GENMASK(30, 0);

Which corresponds to the 'mms | BIT(31)' snippets in this commit, this
is really not how things should be handled, and I need input on how to
proceed here.

Here we get into a weird spot, this driver will need changes in the
oa_tc6 submission, but it's weird to submit support for yet another phy
with that patchset (in my opinion).

This has been tested with a lan8650 rev.b1 chip on one end and a lan8670
usb eval board on the other end. Performance is rather lacking, the
rev.b0 reaches close to the 10Mbit/s limit, but b.1 only gets about
~4Mbit/s, with the same results when PLCA enabled or disabled.

I suggest that this patch is left to brew until the oa_tc6 changes are
accepted, at which time this is fixed up.

Ramón Nordin Rodriguez (1):
  net: phy: microchip_t1s: enable lan865x revb1

 drivers/net/phy/microchip_t1s.c | 189 ++++++++++++++++++++++++++++----
 1 file changed, 166 insertions(+), 23 deletions(-)

-- 
2.43.0



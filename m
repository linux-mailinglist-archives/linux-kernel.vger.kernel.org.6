Return-Path: <linux-kernel+bounces-533151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31FA45631
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C2D3A4F95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11626A0CB;
	Wed, 26 Feb 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0FKR1l1"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D189114A62A;
	Wed, 26 Feb 2025 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553332; cv=none; b=YgdQ+q5VgpF//PENbHsonUeoNX2SdVi9er6EKedmnPOwmEKlMMtRp3VvuzNQBSNnJYv4+blPbU0p3YWT1m8J6O+2WQCvBs1C2VyDMSHUpiUv//oI7FxFskbchgbDt1ZYza8rDDNyYA7ow8l0V6CcDo3YPM1011azKwEdkoOJgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553332; c=relaxed/simple;
	bh=uDXwBGdrIm7qpghgbL/Vk7s76fCfqVe+ZETXQbJj50I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dlszCkkLPEJTTZH1HsNieEjQ9/Ssx4JzCNRjVp3kFJ48PlQ1NjFs5r5mTS0llyXRxndxf0Nd8zxk1m30Ei/5xmOW+9bLMRaCoSecfw9pK+Jy90J2Gj3gLndabhNGvqPIBNJujvuMygJOvIf/Wok25UhAFHiNppmyt9NN65ykOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0FKR1l1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb9709b5b5so1175606566b.2;
        Tue, 25 Feb 2025 23:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740553328; x=1741158128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=osOTBz6nbHvhI0Pvfa24RzmveeMFkDOLoGn5I2RqJwk=;
        b=K0FKR1l1exNm7sFBndBYS72nXFwQJpyzVTxhCZjJHcUWy9OKAvsSFR/jiruIBhuR8b
         7BtQ+F5tsV5LQQAjUEXnk5RElpjt6iAs8r8Su2Jtq8czCm07pe1GAzN9Ly9LvJ/ZrE8O
         a+T42HZJud48ksrA0A1bzvfzD5QC/WnEr/7E/mp/nwMbEVaFcsCGvjLJTHWkbukxUVZq
         ZWrXCRaQoqo9PP+E+qJQuErfb3aV1TIMlW4OXSVg5MsriX3heUcawdzJ8Kd3T+I4vbMm
         KzTcreNFaLr/bTeuiGVxJ+sZqk2wit2TZz9W+A+OLR6/16vqEmko4UH+4q0QZ0Ib/stl
         ZyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740553328; x=1741158128;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osOTBz6nbHvhI0Pvfa24RzmveeMFkDOLoGn5I2RqJwk=;
        b=eeHiErMCd6CU9r46akXhFSa7CIQ9bUwHEOXKiRKsLb7ZFIozBCGKA1eSbM9esZWnzh
         /NVO3gMjdjJUQQcs8DgySWUK0YtyOLoF5SXDn+2eNgx5el3/in2NWBfbm+HME3NyPuub
         24LS8tv4M5a1jrk43TwTGbUHabapF2TArY6vNVLVFqzKxrBYLHVrYW6HoNkXf1YZNNVa
         wvEHa9n2IY3F0SF3Dpnmgo3wdISXlvkm/R0W5y25i16bdA4u7c5LeAP793i3h16Jj/Hv
         vWF98E3/HlYkNRFOym+YEkbRKx0oNKR+k6tLneJ6OpYmYtyHxJPvj+g6NbIGnnyo5wl6
         psNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkkdlMIstxIdGe0IC3p5mkNEtNgC0fOqWTKdfsWhjKRBRk1HJU49/KUTSmglTYRHV519lwU+eFJ+sB@vger.kernel.org, AJvYcCWd1g4TsoPUAk4VrLkwCtY2mqA3P+clY9dgATaDEDvWEGRBfP9b8ixe1JzIuVy6dtTfsBAULoTYHMxETVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqu9eUmAjDgSTI5XG3qdIYbtFXZUEnyrqDy7TQCFBwSKSVElXV
	g1N1u1q3WDqry2TuFidqABJMzsdfsH8b/EQAOicfr8gKgV6i2m4/
X-Gm-Gg: ASbGncvGpv3Nbe+r7Kw6ma7gCzBbo17M4gZwJEr3ZOy7W29zJ/IraTYLioEhnl4VuFm
	3nQfi/kKRlManrz4sYwgjmnKIS5lIcSV7ehkUF4S7vXc2upvCxMMd22uIwraL9/tf1PqfPAMSkJ
	X5Q8LqeOAdf3Noinu6bFnh69TDGgpmBrJvFSKybfxb+Yr+r75JwFh3+TDUMGoxM52gFwyMrjrb/
	0r8yBc87qk0pUpbb+LjLXR0Ej8D3ohsO1i4VU9UI5UePfeyMMfhSn79Kednf9cC97aTkfJRK1Yt
	Yv77nVtQr8cWhdQrnReRv70IZLSy6L6moerHhUH/
X-Google-Smtp-Source: AGHT+IF8St3wZwYpwaezxeQoVeAIZceaECyTA0opQxgr8T+fxXChedK4Jz9gF06VKm6aZ5G+PI7uZg==
X-Received: by 2002:a17:907:3f1c:b0:abe:c811:455c with SMTP id a640c23a62f3a-abed0c67b51mr735245066b.12.1740553327527;
        Tue, 25 Feb 2025 23:02:07 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed204647fsm273049266b.124.2025.02.25.23.02.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 23:02:07 -0800 (PST)
Date: Wed, 26 Feb 2025 08:02:02 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] xHCI: Isochronous error handling fixes and
 improvements
Message-ID: <20250226080202.7eb5e142@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

These patches reduce latency of error reporting in some cases related
to 'error mid TD' and Missed Service events and sometimes fix a failure
to give back such TDs altogether until they are cancelled.

Also included are fixes for potential packet loss or memory corruption
due to obscure races. Whether it causes problems IRL is not known and
the worst case would be hard to reproduce, but exactly for this reason
if the worst case actually happens, it could be hard to debug too.

The first three should be safe. The fourth should also be safe, but it
relies on HC functionality Linux never relied on before, so I placed it
towards the end in case it would need some tweaks. I tested it on all
hardware I have and it worked just fine.

The last one is perhaps the most controversial, though it should be
OK with typical "complete -> resubmit" drivers. It's the only one here
which increases latency in some severe error cases. The intent is to
avoid potentially giving back URBs not yet executed by hardware.

New in v3:
- dropped the cleanup patch
- added Don't skip on Stopped - Length Invalid

New in v3:
- fixed spurious empty list warning on xrun
- clear skip flag if one skipped event was the last

Michal Pecio (5):
  usb: xhci: Don't skip on Stopped - Length Invalid
  usb: xhci: Complete 'error mid TD' transfers when handling Missed
    Service
  usb: xhci: Fix isochronous Ring Underrun/Overrun event handling
  usb: xhci: Expedite skipping missed isoch TDs on modern HCs
  usb: xhci: Skip only one TD on Ring Underrun/Overrun

 drivers/usb/host/xhci-ring.c | 55 +++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 10 deletions(-)

-- 
2.48.1


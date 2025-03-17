Return-Path: <linux-kernel+bounces-565085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6542A66087
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4733B3A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ADB203710;
	Mon, 17 Mar 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3hZmg3T"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5151F583E;
	Mon, 17 Mar 2025 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246975; cv=none; b=AjaD07hVh6a8fBjV0ll1KHhXiqGya16c64r1zqJ/qAtZOJ6MqVga6ehEkqyfOiM1QX2Tp5gY8+rEOBSS1zMb4+6zOpuhIs/iG6wgumM27sSr5QM6O7vW/y7qwFPiFV4z1H6E5advGYRYP6cV5Fz/56B2hYlTQQCk+YvWVNkzvMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246975; c=relaxed/simple;
	bh=Qa8QoEh9bDo7NtQBpICcdHs0hz6i/1qhN7Icv/uqqS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Hz0qvLOj1cjk6o7ZR4zzOp9QtxybyXl/ESK+RwGBgt9Sc4UK1PtiGOFdJ/8PAZnrk3MdLmdtnUeYowtG+QkhyH1scFNMiDxKeF/vQ1uSMVMjTfEHYdUv/jZIN3L5fOHcJWi32nKiC5olKwFDx3caFjMlYu4dsLyc6jdbAWqWujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3hZmg3T; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30c44a87b9cso42457761fa.3;
        Mon, 17 Mar 2025 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742246971; x=1742851771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2DvdMulhD2lWgMBe7TR4sBlPK2uKT9yFU9Bypz2sH4=;
        b=A3hZmg3TfjTiDOdEsUUWz/+WZKYb4X9LvemIfOsv3vAS3T3YTpPRjRsm5yAmHhUCpB
         eMz/TfrV0VL0Y2i79UAZWD26rKq2xpgKE2l2SYmKYzZD/YmQhGInN879tGFc/y3T0ut8
         rcmfW98Wh8IDIYdafoRiTOk9rggN/Nh+eLtb10N8HUmsFGM2y01f+2MjXBT/aJR7A1Nz
         u8/xINE4pe/Qws7KjNOumRMsdR/AS4jRdnnhbbChCvjYveXsGp77sJf1GHhULHi2HVVW
         sykEV09Zt5cMcg468zwpRj8Vgrjf/JyAUt7J3gu0Ql99aAdqSVqdzy9XaquWccrxoPz3
         cCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742246971; x=1742851771;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2DvdMulhD2lWgMBe7TR4sBlPK2uKT9yFU9Bypz2sH4=;
        b=j7/2F6kxKPuC8qJVbn2ReWj7GRY/24/LEZn2vECkXEoOF/x3ANjd4i31HQ63zjfPUE
         rnyMpD5U+xRgBDaPuDaHV9pk5eODmQSaXrDByBTodr3sWAujPDFXz6tnZln9TK0U/Bho
         O2eEw7Xma+XgT/plkrDi2Ojb9zHNiq22mcHJXMhN8Waext6F7IVicBqweiXWvMnJwg2b
         12YTTZ8VPGD6RJGlI2h2ZNu0zVkxSGY1404aRutKFy7FbHIYEAOAOVbdhRvewBm756/e
         /O+9RIXpuNLvh3lFmzpjlc/65M07vfb1zfAYnVRB8vZuepuYQDXhwcA/yZZ2yt2jYwht
         rUjg==
X-Forwarded-Encrypted: i=1; AJvYcCUl73AFN30rN68TVL9Jlm6vyifGvHoZB1OP1zdLcXPZ67uDeNz+1kwYkub5luu0gVkyW7EEJ6jzKXqC@vger.kernel.org, AJvYcCXkaUm6aR6Qctzn+Np2YEDvd9llVnEd2Sm2Q7PoPhVzWE3gpsSA4gVrdNVEywlO6Q5VoOFZy6mJ7MQtTCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NaIm14dbIfLet8PjX+Ucb7DhExme0/Qf4HDmvUt5nACOGSxu
	0DVb8S4YFCVsvQX1kj6bsjILN+RuRo0MgTZsHCai6LVGeWodKMz5
X-Gm-Gg: ASbGnctTfkmKZthUInZtTwnVQRgkZnj0Rl29y+5TBTYlPfsS83UF/301NcEFt4VC0YV
	b5TT1rZML4T+XuS61VwbCoPC20XsfkkqQ/1/fbzDej049D72NFDXZEd6P4u/rkUzOYgNwgkRTEs
	sO7VLvuvEVYcroPa/BYGymxLXBwjolQFYIv3DcuRfIXYbr2+YFjaxb5pxAdrGdmR05X07zC4clm
	vR5/ZwTz3UsNnMvYoiX/3X91ycY12Qiw73dqDJqq3nWjcelwqWkFjf5KMo5rvImqju6wBm+pgDv
	dbuNctHuXjK+853xvJwgochKRImzMLcukQUtckcgqhYhm3o3Pm+4eMtvkl0=
X-Google-Smtp-Source: AGHT+IFrJZNMGWxmAGxKGz9lAPn9PjgEvHeGtZ1KxH3uJc86HN7GLtVV2llhcIYOyL+IV64mjm5wrA==
X-Received: by 2002:a2e:3516:0:b0:30c:7a7:e841 with SMTP id 38308e7fff4ca-30c4a8edceamr84492411fa.34.1742246971136;
        Mon, 17 Mar 2025 14:29:31 -0700 (PDT)
Received: from foxbook (adqh54.neoplus.adsl.tpnet.pl. [79.185.141.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1dbf23sm17564911fa.106.2025.03.17.14.29.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Mar 2025 14:29:30 -0700 (PDT)
Date: Mon, 17 Mar 2025 22:29:27 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Kuangyi Chiang <ki.chiang65@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Fix invalid pointer dereference in Etron
 workaround
Message-ID: <20250317222927.5b76518e@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This check is performed before prepare_transfer() and prepare_ring(), so
enqueue can already point at the final link TRB of a segment. And indeed
it will, some 0.4% of times this code is called.

Then enqueue + 1 is an invalid pointer. It will crash the kernel right
away or load some junk which may look like a link TRB and cause the real
link TRB to be replaced with a NOOP. This wouldn't end well.

Use a functionally equivalent test which doesn't dereference the pointer
and always gives correct result.

Something has crashed my machine twice in recent days while playing with
an Etron HC, and a control transfer stress test ran for confirmation has
just crashed it again. The same test passes with this patch applied.

Fixes: 5e1c67abc930 ("xhci: Fix control transfer error on Etron xHCI host")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 60d89cf418da..dc674bc24a89 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3786,7 +3786,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		 * enqueue a No Op TRB, this can prevent the Setup and Data Stage
 		 * TRB to be breaked by the Link TRB.
 		 */
-		if (trb_is_link(ep_ring->enqueue + 1)) {
+		if (last_trb_on_seg(ep_ring->enq_seg, ep_ring->enqueue + 1)) {
 			field = TRB_TYPE(TRB_TR_NOOP) | ep_ring->cycle_state;
 			queue_trb(xhci, ep_ring, false, 0, 0,
 					TRB_INTR_TARGET(0), field);
-- 
2.48.1


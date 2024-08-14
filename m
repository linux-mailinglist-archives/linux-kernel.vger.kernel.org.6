Return-Path: <linux-kernel+bounces-285869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C99513A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4F61C21FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4EC5589B;
	Wed, 14 Aug 2024 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5i3UmOL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08899481C0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611368; cv=none; b=ex0hxk86Qjim4ctNL87HgtE229W1VwYdTIOFCAAYIIS4w+8G6iLF++7U8BhGrcV2Q7dlxdrH2V/TpQmmGb65vo4Hed+2rGG3ZkgJKYjr23H3oA1HSMFigOnZQvz4geXB5RFALHTszPLcUf/OHv4tl19n0cyQYCH+SgyObvRquF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611368; c=relaxed/simple;
	bh=fQ+4wQjUSOIMUBzoFT+7LRlptZG/eGNKq3eM0Uk2564=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T5MHbDqYCOJsl7dxDydOMeg8cUf5f4mBNlUtgHlqVadRUNowvne78kkfKEu6o1nyOCPzk4Ww8sG/OKZKu/o39Hk7Veto+yH4Z+D0DYb5qAHY6PtoN07dvRmsbjpuCW5JV/9nB5s970vPTpHfHRYPhvcmOV0r4JoLEpwXeJPBFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--daiweili.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5i3UmOL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--daiweili.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso9104002276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723611366; x=1724216166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lnvp97S/MR4yUiKbd5n8jwMTfUiZvb9HbFkBv7V13WM=;
        b=N5i3UmOLC0p2KSg28h3iiRhV/p+aNeqtrCXY/GO2g+0lftx6s5VmIDf2SB+dtczuTV
         Qt40UZkYrXLpgtP9nGT7oaApSqjrR51PNZVJZ4v2Z7NEce+JX+z8sRZHtdatrbuY95fC
         j+wnwjAwmPOy5J9bF6grb4X5w1DgzSPg4z43RYcsCFHWffo14DqMzBxaow/BSfP1U0Zd
         MZ3kNZK+9G5BMAnHpbGPx4OtuW8r/AgZZOZ2oPODoelEkQuBBpEoKMdySYnGR9VQy1zs
         Rlaf+Z4ugArdCWqMos5BLLnC1XqcGlgs2/lp+AxGcpQWsgYmA7l1fKxpu4IZQ5bdyIAr
         rrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723611366; x=1724216166;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnvp97S/MR4yUiKbd5n8jwMTfUiZvb9HbFkBv7V13WM=;
        b=gAdx23Qe9kWxZoUz/pX4ICl/ZTzv51p4iKn0CR6Gf+Ow2vOxkVcuaOwEjAZFT0VM7v
         H7FbbQjFgqVOBx4ahHxB5vGUy8aO9ubQl+VYgr1G7ULB6/fgFs7EbjCEpUzHOtQtX8Ba
         YUdtIa9SX4VcWvXteetyyMZehWCXm1oaKms7DkBJDiE0yiQLC+v8fOJJcIwSSdK11pbU
         fclD5sDS5DlK0klgGv8HyFfR/TVnpo2OAzJKMYQ6RZSIYQEQzVsxX/qLAKzJzRGou+sq
         XUf5apZJ51b6qb8DqLudok9nvMHl3zW9FfWdKjXpoDHLnudGqCEXUVPiCBEto9KXqvID
         BxkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPuCq/Q2ahUNNTGIaulHvcvbt5iXoLI3yweQxvR5hiDyhVicErZDiP2L51Q/Ho+HH+L8i9r46E41M3wwIXJXcAr+FZNqxKZ+NJX+mX
X-Gm-Message-State: AOJu0YzLlpo5+PCEm/am8cSb9/g5ThZl6wMZ3mWx0WRFmaUJfAi/nYFO
	y76lMwnBYrwEv9Y+FgxywACO8SMfzPz0XYf5MR4xioE8Mq6K65i/eyg5+gvCyuvfgYxoLPJF0/M
	mBETf0vlH
X-Google-Smtp-Source: AGHT+IG49Fx2xiRVWQlRuoz0zvxLK+LtnKos04NNqOiwZh05DlnfFBZtQGQFWYfG84ZKnZq//Q5fW+6FXooL0w==
X-Received: from ditto.mtv.corp.google.com ([2a00:79e0:2e0b:7:febd:a120:fb9c:be25])
 (user=daiweili job=sendgmr) by 2002:a25:d6d1:0:b0:e03:59e2:e82 with SMTP id
 3f1490d57ef6-e1155bca773mr2220276.10.1723611365685; Tue, 13 Aug 2024 21:56:05
 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:55:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814045553.947331-1-daiweili@google.com>
Subject: [PATCH iwl-net v3] igb: Fix not clearing TimeSync interrupts for 82580
From: Daiwei Li <daiweili@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: vinicius.gomes@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kurt@linutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	przemyslaw.kitszel@intel.com, richardcochran@gmail.com, 
	sasha.neftin@intel.com, Daiwei Li <daiweili@google.com>
Content-Type: text/plain; charset="UTF-8"

82580 NICs have a hardware bug that makes it
necessary to write into the TSICR (TimeSync Interrupt Cause) register
to clear it:
https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/

Add a conditional so only for 82580 we write into the TSICR register,
so we don't risk losing events for other models.

Without this change, when running ptp4l with an Intel 82580 card,
I get the following output:

> timed out while polling for tx timestamp increasing tx_timestamp_timeout or
> increasing kworker priority may correct this issue, but a driver bug likely
> causes it

This goes away with this change.

This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").

Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
Tested-by: Daiwei Li <daiweili@google.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Daiwei Li <daiweili@google.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ada42ba63549..69d7e8b16437 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6984,9 +6984,19 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+			  TSINTR_TT0 | TSINTR_TT1 |
+			  TSINTR_AUTT0 | TSINTR_AUTT1);
 	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires an explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, tsicr & mask);
+	}
+
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
-- 
2.46.0.76.ge559c4bf1a-goog



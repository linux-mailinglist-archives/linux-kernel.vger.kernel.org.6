Return-Path: <linux-kernel+bounces-531292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E5A43EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB95163BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710E267B99;
	Tue, 25 Feb 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An6UgHBE"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F002080D6;
	Tue, 25 Feb 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484741; cv=none; b=ONxzEKqEmqKaWzAb+LmqiNGqrwyO8lz8cyCnzvX8kc1TydCfZGsK1UtwPdPvtaokO45KYcXj/YC5TG7MtvNsnDdaK/pbka0GGKT3WDqDmq7Hxf0etdAjnG0SdNpjg7Q9wJsocA4PSQzWVFK2GfK7hrJMzIqLv3dcScZiavzWnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484741; c=relaxed/simple;
	bh=+pK7W2Q6b1RBgxpzS83X4wpeOlNFidK3MHXGdwxvwts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlpGeFg9sBC6hptssP32dw3MjaJlGJyIJc73mPkGeME6AZpchqDqQR4sg20klBp6/td2tgqPHgN4qhiW49KeaRmYAD3jnKrHpNWtEWzEcDigTs9ALRtrACiU4rHk7K3Xu/ZozjExPg3QrLVkj58gkWYB2H8bcNLPD+ylWRNNXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An6UgHBE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb90c20baeso708906266b.1;
        Tue, 25 Feb 2025 03:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740484738; x=1741089538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f0Viu8zBHLWFqYx5Y6dMfvnL01Pt8+7ZPXp9TuHe/w=;
        b=An6UgHBECsm/8oYGDslahAmuYg2wXW4YLSi8i1WDd0flKW/SwblfkLdiVzbfXdvndM
         2/CDuuve6ESFxAZ6BGi+d5xFC+dFUN95aEnDjo1kGGThTJwSFyFLF4AB/IjsOOxQQjm4
         ba2NRD3N4zVikAVWqcLmGyw6TFIrSZi15nsYNS+FHLHAru88pwOM1bm7sUQCGHA2B4dq
         KBkpkf+rlTJWET1BB07md97ReHXRxprURA+JxHux8iPL8TbH6G5WDhd6vnuh1NdsFVRs
         go1l4NzV6Br68ZMH9vCLCxQItvVVB6Cng6FcwG2xMRC1GPKAgySqw9OZybQOdjvhkp3S
         QWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484738; x=1741089538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f0Viu8zBHLWFqYx5Y6dMfvnL01Pt8+7ZPXp9TuHe/w=;
        b=BIfJLCccfPprwb3CC7uJ9vSVRyXO9LhJOITu3xfXtAcvXvXg4QvWtJEgX5FSSu+mIj
         D6/v39F427sXbnIrlacoAQfp//nm2/7m8uWZ5BPE9FeOJ4c313nMY0Q6BmT2WXGfI3CG
         fAC8lrLdeqXofYy0nLQUoDznuk/113enMFVwJVntWcHpBort0XNutywJ6e7cFC0hBH4f
         Xo14fgSAN1c0V1iEtpHhKMKXlXfY1svkKsgvFTkvaJ4+hV9PHuXicIB7dgiSF9OWpeHB
         pApMOxyN+iUGeg6rmnH+Dk/P2kh8jwZh5s9uWTSbBpI4pwUtJv/1xO2+FVb7ufpvfoyl
         9FTw==
X-Forwarded-Encrypted: i=1; AJvYcCX6EL3GP9JodnDn00RW63JeUSrIanc67sggBYCO0cqW7cTi03Crs2AZ9nlLAoUCJwy1Bf5N4yguu7Htm3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQ+SCf5xaeZrCuLLdgYRTBGUPeTOZmBDpe7R2A/2Bm/OO9wVs
	kAElFQkmROdbyCCEYVyu0Y8GALdjkzTdj+2q/UijhG8ntKY13f+95UjgTg==
X-Gm-Gg: ASbGnctai4gmfEslU39Tg4FCdOE98dmOkej00ApavxK6G+lxpgJK3C566QB+lySbEho
	3VwoaHCvs3SsdfB9svOwoBK+XLA7G75PWfrthiJOOhFTGFjhW4tg0vsVHbQ4B8t17ybRhOoRZby
	FcYSreGQ5NDZh1ulLOxaIoRtGbQb0GnhqFSpiumxt5xPHqAM6aqY0aDEw9uHqsUsfxZxHU8RN1R
	5R6EFijHAuEzII/LevDOh+hWlNDhVst+cr5cHHU34iK9SYQiZgjF7Yz+SvzmtJZeCi5IVII9YYG
	CRSwoOIh5txQNTxT7SMHVPlAdWEPduyL82k1W6jA8AI=
X-Google-Smtp-Source: AGHT+IFUq0UTJdD/U4lVRq7gguWQRgoO8NcZ5BFRILAZiGfNGB/hUE2rS9VpdO/5lwk+MSg8Oaz8KA==
X-Received: by 2002:a17:906:c103:b0:abc:c42:5c7a with SMTP id a640c23a62f3a-abc0da2f10bmr1906178066b.31.1740484737220;
        Tue, 25 Feb 2025 03:58:57 -0800 (PST)
Received: from foxbook (adqm166.neoplus.adsl.tpnet.pl. [79.185.146.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2010f44sm128259166b.111.2025.02.25.03.58.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 03:58:56 -0800 (PST)
Date: Tue, 25 Feb 2025 12:58:54 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] usb: xhci: Apply the link chain quirk on NEC isoc
 endpoints
Message-ID: <20250225125854.622a6433@foxbook>
In-Reply-To: <20250225125750.1b345e2c@foxbook>
References: <20250225125750.1b345e2c@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Two clearly different specimens of NEC uPD720200 (one with start/stop
bug, one without) were seen to cause IOMMU faults after some Missed
Service Errors. Faulting address is immediately after a transfer ring
segment and patched dynamic debug messages revealed that the MSE was
received when waiting for a TD near the end of that segment:

[ 5441.041954] xhci_hcd 0000:0c:00.0: Miss service interval error for slot 1 ep 2 expected TD DMA ffa08fe0
[ 5441.042120] xhci_hcd 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffa09000 flags=0x0000]
[ 5441.042146] xhci_hcd 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffa09040 flags=0x0000]

It gets even funnier if the next page is a ring segment accessible to
the HC. Below, it reports MSE in segment at ff1e8000, plows through a
zero-filled page at ff1e9000 and starts reporting events for TRBs in
page at ff1ea000 every microframe, instead of jumping to seg ff1e6000.

[ 4807.041671] xhci_hcd 0000:0c:00.0: Miss service interval error for slot 1 ep 2 expected TD DMA ff1e8fe0
[ 4807.041999] xhci_hcd 0000:0c:00.0: Miss service interval error for slot 1 ep 2 expected TD DMA ff1e8fe0
[ 4807.042011] xhci_hcd 0000:0c:00.0: WARN: buffer overrun event for slot 1 ep 2 on endpoint
[ 4807.042028] xhci_hcd 0000:0c:00.0: All TDs skipped for slot 1 ep 2. Clear skip flag.
[ 4807.042134] xhci_hcd 0000:0c:00.0: WARN: buffer overrun event for slot 1 ep 2 on endpoint
[ 4807.042138] xhci_hcd 0000:0c:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 31
[ 4807.042144] xhci_hcd 0000:0c:00.0: Looking for event-dma 00000000ff1ea040 trb-start 00000000ff1e6820 trb-end 00000000ff1e6820 seg-start 00000000ff1e6000 seg-end 00000000ff1e6ff0
[ 4807.042259] xhci_hcd 0000:0c:00.0: WARN: buffer overrun event for slot 1 ep 2 on endpoint
[ 4807.042262] xhci_hcd 0000:0c:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 31
[ 4807.042266] xhci_hcd 0000:0c:00.0: Looking for event-dma 00000000ff1ea050 trb-start 00000000ff1e6820 trb-end 00000000ff1e6820 seg-start 00000000ff1e6000 seg-end 00000000ff1e6ff0

At some point completion events change from Isoch Buffer Overrun to
Short Packet and the HC finally finds cycle bit mismatch in ff1ec000.

[ 4807.098130] xhci_hcd 0000:0c:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 13
[ 4807.098132] xhci_hcd 0000:0c:00.0: Looking for event-dma 00000000ff1ecc50 trb-start 00000000ff1e6820 trb-end 00000000ff1e6820 seg-start 00000000ff1e6000 seg-end 00000000ff1e6ff0
[ 4807.098254] xhci_hcd 0000:0c:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 13
[ 4807.098256] xhci_hcd 0000:0c:00.0: Looking for event-dma 00000000ff1ecc60 trb-start 00000000ff1e6820 trb-end 00000000ff1e6820 seg-start 00000000ff1e6000 seg-end 00000000ff1e6ff0
[ 4807.098379] xhci_hcd 0000:0c:00.0: Overrun event on slot 1 ep 2

It's possible that data from the isochronous device were written to
random buffers of pending TDs on other endpoints (either IN or OUT),
other devices or even other HCs in the same IOMMU domain.

Lastly, an error from a different USB device on another HC. Was it
caused by the above? I don't know, but it may have been. The disk
was working without any other issues and generated PCIe traffic to
starve the NEC of upstream BW and trigger those MSEs. The two HCs
shared one x1 slot by means of a commercial "PCIe splitter" board.

[ 4807.162604] usb 10-2: reset SuperSpeed USB device number 3 using xhci_hcd
[ 4807.178990] sd 9:0:0:0: [sdb] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x07 driverbyte=DRIVER_OK cmd_age=0s
[ 4807.179001] sd 9:0:0:0: [sdb] tag#0 CDB: opcode=0x28 28 00 04 02 ae 00 00 02 00 00
[ 4807.179004] I/O error, dev sdb, sector 67284480 op 0x0:(READ) flags 0x80700 phys_seg 5 prio class 0

Fortunately, it appears that this ridiculous bug is avoided by setting
the chain bit of Link TRBs on isochronous rings. Other ancient HCs are
known which also expect the bit to be set and they ignore Link TRBs if
it's not. Reportedly, 0.95 spec guaranteed that the bit is set.

The bandwidth-starved NEC HC running a 32KB/uframe UVC endpoint reports
tens of MSEs per second and runs into the bug within seconds. Chaining
Link TRBs allows the same workload to run for many minutes, many times.

No negative side effects seen in UVC recording and UAC playback with a
few devices at full speed, high speed and SuperSpeed.

The problem doesn't reproduce on the newer Renesas uPD720201/uPD720202
and on old Etron EJ168 and VIA VL805 (but the VL805 has other bug).

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/host/xhci.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 377dad9cd639..2ad31e147d67 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1761,11 +1761,20 @@ static inline void xhci_write_64(struct xhci_hcd *xhci,
 }
 
 
-/* Link TRB chain should always be set on 0.95 hosts, and AMD 0.96 ISOC rings */
+/*
+ * Reportedly, some chapters of v0.95 spec said that Link TRB always has its chain bit set.
+ * Other chapters and later specs say that it should only be set if the link is inside a TD
+ * which continues from the end of one segment to the next segment.
+ *
+ * Some 0.95 hardware was found to misbehave if any link TRB doesn't have the chain bit set.
+ *
+ * 0.96 hardware from AMD and NEC was found to ignore unchained isochronous link TRBs when
+ * "resynchronizing the pipe" after a Missed Service Error.
+ */
 static inline bool xhci_link_chain_quirk(struct xhci_hcd *xhci, enum xhci_ring_type type)
 {
 	return (xhci->quirks & XHCI_LINK_TRB_QUIRK) ||
-	       (type == TYPE_ISOC && (xhci->quirks & XHCI_AMD_0x96_HOST));
+	       (type == TYPE_ISOC && (xhci->quirks & (XHCI_AMD_0x96_HOST | XHCI_NEC_HOST)));
 }
 
 /* xHCI debugging */
-- 
2.48.1


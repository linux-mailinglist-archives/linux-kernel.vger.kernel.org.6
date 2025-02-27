Return-Path: <linux-kernel+bounces-536102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB6A47B86
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24F9189116A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE622AE76;
	Thu, 27 Feb 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grMf7WDG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB4227EAE;
	Thu, 27 Feb 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654706; cv=none; b=QFWCw124vNLA1Xm/dkSWtDHg8WPIIJgVk/S8ziuSNaw9ap62rw0WanezmQCP0cgMVO4MitLgtv9cimA74W6kvEu6qvpT/E20boTHP07cMpqg0FcotTEL/ErLN2Iw+CHAqfHzYp/TRGXIfjl58P13IpzukJhirRqTvxhy970DcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654706; c=relaxed/simple;
	bh=WYcNXhq8z07kt7rSvje6l1piWKilC5UfB5RUxaPs2Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krOuT0yXKBNj0hffLZ0paDKHo50wsMUL8UI9YdqeSvl7DgH9AVTJk8Hjx9IXCpMeqPZy2+V7vZETBEfbda6uy1/5dvNcTU2WPkKRJNWtYkEDOjRlA2qVrQMN2b1pTOlvL9hWTo42CO9SYSdyKoesnBminluZQsm71/gpxqdK0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grMf7WDG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654704; x=1772190704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WYcNXhq8z07kt7rSvje6l1piWKilC5UfB5RUxaPs2Vs=;
  b=grMf7WDGHia405oPvC7x911N5Qvug/5VyBnY/9CJpH8SEDtqoreuWr5j
   Llc29xVy+BDoFKd8r2GZ6BCLENMLEwazGWxM9yhr+XcjzihkYjrub+Awl
   CCPZRT1Zp9jGoav4YkOf5K14O99de9sol65xp/PR69fitZKARsSaHjJ1/
   vDIFfpHOj0N8slHYC7bwk3GHDzw8NPDqcDTnFygeWKTIILV5RCpWDy5h5
   X5s1Km8ZGZg91k+YaZ57o1gAe7k20e8jIl0L+6qk7+dSEnVpzfLXlwzfi
   6prCqOn65Hz9X9UGV7mW/pYmbo7SiSpxBQ4JW51oqjXkrwzbYI8neJwye
   Q==;
X-CSE-ConnectionGUID: EIehWWIzRBO0cDJ5IGCrXg==
X-CSE-MsgGUID: s7sh/6ySQfGZbXkcXAFKMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189788"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189788"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:44 -0800
X-CSE-ConnectionGUID: KsRqtwoPSNGsCFj6Jrn9ew==
X-CSE-MsgGUID: 9q8gbfcPTQ++cmYhRsJjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154178912"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:41 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 01/16] Documentation: driver: add SoundWire BRA description
Date: Thu, 27 Feb 2025 19:11:14 +0800
Message-ID: <20250227111130.272698-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
References: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

The Bulk Register Access protocol was left as a TODO topic since
2018. It's time to document this protocol and the design of its Linux
support.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 Documentation/driver-api/soundwire/bra.rst    | 336 ++++++++++++++++++
 .../driver-api/soundwire/bra_cadence.rst      |  67 ++++
 Documentation/driver-api/soundwire/index.rst  |   2 +
 .../driver-api/soundwire/summary.rst          |   8 -
 4 files changed, 405 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/driver-api/soundwire/bra.rst
 create mode 100644 Documentation/driver-api/soundwire/bra_cadence.rst

diff --git a/Documentation/driver-api/soundwire/bra.rst b/Documentation/driver-api/soundwire/bra.rst
new file mode 100644
index 000000000000..2f3521daf508
--- /dev/null
+++ b/Documentation/driver-api/soundwire/bra.rst
@@ -0,0 +1,336 @@
+==========================
+Bulk Register Access (BRA)
+==========================
+
+Conventions
+-----------
+
+Capitalized words used in this documentation are intentional and refer
+to concepts of the SoundWire 1.x specification.
+
+Introduction
+------------
+
+The SoundWire 1.x specification provides a mechanism to speed-up
+command/control transfers by reclaiming parts of the audio
+bandwidth. The Bulk Register Access (BRA) protocol is a standard
+solution based on the Bulk Payload Transport (BPT) definitions.
+
+The regular control channel uses Column 0 and can only send/retrieve
+one byte per frame with write/read commands. With a typical 48kHz
+frame rate, only 48kB/s can be transferred.
+
+The optional Bulk Register Access capability can transmit up to 12
+Mbits/s and reduce transfer times by several orders of magnitude, but
+has multiple design constraints:
+
+  (1) Each frame can only support a read or a write transfer, with a
+      10-byte overhead per frame (header and footer response).
+
+  (2) The read/writes SHALL be from/to contiguous register addresses
+      in the same frame. A fragmented register space decreases the
+      efficiency of the protocol by requiring multiple BRA transfers
+      scheduled in different frames.
+
+  (3) The targeted Peripheral device SHALL support the optional Data
+      Port 0, and likewise the Manager SHALL expose audio-like Ports
+      to insert BRA packets in the audio payload using the concepts of
+      Sample Interval, HSTART, HSTOP, etc.
+
+  (4) The BRA transport efficiency depends on the available
+      bandwidth. If there are no on-going audio transfers, the entire
+      frame minus Column 0 can be reclaimed for BRA. The frame shape
+      also impacts efficiency: since Column0 cannot be used for
+      BTP/BRA, the frame should rely on a large number of columns and
+      minimize the number of rows. The bus clock should be as high as
+      possible.
+
+  (5) The number of bits transferred per frame SHALL be a multiple of
+      8 bits. Padding bits SHALL be inserted if necessary at the end
+      of the data.
+
+  (6) The regular read/write commands can be issued in parallel with
+      BRA transfers. This is convenient to e.g. deal with alerts, jack
+      detection or change the volume during firmware download, but
+      accessing the same address with two independent protocols has to
+      be avoided to avoid undefined behavior.
+
+  (7) Some implementations may not be capable of handling the
+      bandwidth of the BRA protocol, e.g. in the case of a slow I2C
+      bus behind the SoundWire IP. In this case, the transfers may
+      need to be spaced in time or flow-controlled.
+
+  (8) Each BRA packet SHALL be marked as 'Active' when valid data is
+      to be transmitted. This allows for software to allocate a BRA
+      stream but not transmit/discard data while processing the
+      results or preparing the next batch of data, or allowing the
+      peripheral to deal with the previous transfer. In addition BRA
+      transfer can be started early on without data being ready.
+
+  (9) Up to 470 bytes may be transmitted per frame.
+
+  (10) The address is represented with 32 bits and does not rely on
+       the paging registers used for the regular command/control
+       protocol in Column 0.
+
+
+Error checking
+--------------
+
+Firmware download is one of the key usages of the Bulk Register Access
+protocol. To make sure the binary data integrity is not compromised by
+transmission or programming errors, each BRA packet provides:
+
+  (1) A CRC on the 7-byte header. This CRC helps the Peripheral Device
+      check if it is addressed and set the start address and number of
+      bytes. The Peripheral Device provides a response in Byte 7.
+
+  (2) A CRC on the data block (header excluded). This CRC is
+      transmitted as the last-but-one byte in the packet, prior to the
+      footer response.
+
+The header response can be one of
+  (a) Ack
+  (b) Nak
+  (c) Not Ready
+
+The footer response can be one of
+  (1) Ack
+  (2) Nak  (CRC failure)
+  (3) Good (operation completed)
+  (4) Bad  (operation failed)
+
+Example frame
+-------------
+
+The example below is not to scale and makes simplifying assumptions
+for clarity. The different chunks in the BRA packets are not required
+to start on a new SoundWire Row, and the scale of data may vary.
+
+      ::
+
+	+---+--------------------------------------------+
+	+   |                                            |
+	+   |             BRA HEADER                     |
+        +   |	                                         |
+	+   +--------------------------------------------+
+	+ C |             HEADER CRC                     |
+	+ O +--------------------------------------------+
+	+ M | 	          HEADER RESPONSE                |
+	+ M +--------------------------------------------+
+	+ A |                                            |
+	+ N |                                            |
+	+ D |                 DATA                       |
+	+   |                                            |
+	+   |                                            |
+	+   |                                            |
+	+   +--------------------------------------------+
+	+   |             DATA CRC                       |
+	+   +--------------------------------------------+
+	+   | 	          FOOTER RESPONSE                |
+	+---+--------------------------------------------+
+
+
+Assuming the frame uses N columns, the configuration shown above can
+be programmed by setting the DP0 registers as:
+
+    - HSTART = 1
+    - HSTOP = N - 1
+    - Sampling Interval = N
+    - WordLength = N - 1
+
+Addressing restrictions
+-----------------------
+
+The Device Number specified in the Header follows the SoundWire
+definitions, and broadcast and group addressing are permitted. For now
+the Linux implementation only allows for a single BPT transfer to a
+single device at a time. This might be revisited at a later point as
+an optimization to send the same firmware to multiple devices, but
+this would only be beneficial for single-link solutions.
+
+In the case of multiple Peripheral devices attached to different
+Managers, the broadcast and group addressing is not supported by the
+SoundWire specification. Each device must be handled with separate BRA
+streams, possibly in parallel - the links are really independent.
+
+Unsupported features
+--------------------
+
+The Bulk Register Access specification provides a number of
+capabilities that are not supported in known implementations, such as:
+
+  (1) Transfers initiated by a Peripheral Device. The BRA Initiator is
+      always the Manager Device.
+
+  (2) Flow-control capabilities and retransmission based on the
+      'NotReady' header response require extra buffering in the
+      SoundWire IP and are not implemented.
+
+Bi-directional handling
+-----------------------
+
+The BRA protocol can handle writes as well as reads, and in each
+packet the header and footer response are provided by the Peripheral
+Target device. On the Peripheral device, the BRA protocol is handled
+by a single DP0 data port, and at the low-level the bus ownership can
+will change for header/footer response as well as the data transmitted
+during a read.
+
+On the host side, most implementations rely on a Port-like concept,
+with two FIFOs consuming/generating data transfers in parallel
+(Host->Peripheral and Peripheral->Host). The amount of data
+consumed/produced by these FIFOs is not symmetrical, as a result
+hardware typically inserts markers to help software and hardware
+interpret raw data
+
+Each packet will typically have
+
+  (1) a 'Start of Packet' indicator.
+
+  (2) an 'End of Packet' indicator.
+
+  (3) a packet identifier to correlate the data requested and
+      transmitted, and the error status for each frame
+
+Hardware implementations can check errors at the frame level, and
+retry a transfer in case of errors. However, as for the flow-control
+case, this requires extra buffering and intelligence in the
+hardware. The Linux support assumes that the entire transfer is
+cancelled if a single error is detected in one of the responses.
+
+Abstraction required
+~~~~~~~~~~~~~~~~~~~~
+
+There are no standard registers or mandatory implementation at the
+Manager level, so the low-level BPT/BRA details must be hidden in
+Manager-specific code. For example the Cadence IP format above is not
+known to the codec drivers.
+
+Likewise, codec drivers should not have to know the frame size. The
+computation of CRC and handling of responses is handled in helpers and
+Manager-specific code.
+
+The host BRA driver may also have restrictions on pages allocated for
+DMA, or other host-DSP communication protocols. The codec driver
+should not be aware of any of these restrictions, since it might be
+reused in combination with different implementations of Manager IPs.
+
+Concurrency between BRA and regular read/write
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The existing 'nread/nwrite' API already relies on a notion of start
+address and number of bytes, so it would be possible to extend this
+API with a 'hint' requesting BPT/BRA be used.
+
+However BRA transfers could be quite long, and the use of a single
+mutex for regular read/write and BRA is a show-stopper. Independent
+operation of the control/command and BRA transfers is a fundamental
+requirement, e.g. to change the volume level with the existing regmap
+interface while downloading firmware. The integration must however
+ensure that there are no concurrent access to the same address with
+the command/control protocol and the BRA protocol.
+
+In addition, the 'sdw_msg' structure hard-codes support for 16-bit
+addresses and paging registers which are irrelevant for BPT/BRA
+support based on native 32-bit addresses. A separate API with
+'sdw_bpt_msg' makes more sense.
+
+One possible strategy to speed-up all initialization tasks would be to
+start a BRA transfer for firmware download, then deal with all the
+"regular" read/writes in parallel with the command channel, and last
+to wait for the BRA transfers to complete. This would allow for a
+degree of overlap instead of a purely sequential solution. As a
+results, the BRA API must support async transfers and expose a
+separate wait function.
+
+
+Peripheral/bus interface
+------------------------
+
+The bus interface for BPT/BRA is made of two functions
+
+    - sdw_bpt_send_async(bpt_message)
+
+      This function sends the data using the Manager
+      implementation-defined capabilities (typically DMA or IPC
+      protocol).
+
+      Queueing is currently not supported, the caller
+      needs to wait for completion of the requested transfer.
+
+   - sdw_bpt_wait()
+
+      This function waits for the entire message provided by the
+      codec driver in the 'send_async' stage. Intermediate status for
+      smaller chunks will not be provided back to the codec driver,
+      only a return code will be provided.
+
+Regmap use
+~~~~~~~~~~
+
+Existing codec drivers rely on regmap to download firmware to
+Peripherals. regmap exposes an async interface similar to the
+send/wait API suggested above, so at a high-level it would seem
+natural to combine BRA and regmap. The regmap layer could check if BRA
+is available or not, and use a regular read-write command channel in
+the latter case.
+
+The regmap integration will be handled in a second step.
+
+BRA stream model
+----------------
+
+For regular audio transfers, the machine driver exposes a dailink
+connecting CPU DAI(s) and Codec DAI(s).
+
+This model is not required BRA support:
+
+   (1) The SoundWire DAIs are mainly wrappers for SoundWire Data
+       Ports, with possibly some analog or audio conversion
+       capabilities bolted behind the Data Port. In the context of
+       BRA, the DP0 is the destination. DP0 registers are standard and
+       can be programmed blindly without knowing what Peripheral is
+       connected to each link. In addition, if there are multiple
+       Peripherals on a link and some of them do not support DP0, the
+       write commands to program DP0 registers will generate harmless
+       COMMAND_IGNORED responses that will be wired-ORed with
+       responses from Peripherals which support DP0. In other words,
+       the DP0 programming can be done with broadcast commands, and
+       the information on the Target device can be added only in the
+       BRA Header.
+
+   (2) At the CPU level, the DAI concept is not useful for BRA; the
+       machine driver will not create a dailink relying on DP0. The
+       only concept that is needed is the notion of port.
+
+   (3) The stream concept relies on a set of master_rt and slave_rt
+       concepts. All of these entities represent ports and not DAIs.
+
+   (4) With the assumption that a single BRA stream is used per link,
+       that stream can connect master ports as well as all peripheral
+       DP0 ports.
+
+   (5) BRA transfers only make sense in the context of one
+       Manager/Link, so the BRA stream handling does not rely on the
+       concept of multi-link aggregation allowed by regular DAI links.
+
+Audio DMA support
+-----------------
+
+Some DMAs, such as HDaudio, require an audio format field to be
+set. This format is in turn used to define acceptable bursts. BPT/BRA
+support is not fully compatible with these definitions in that the
+format and bandwidth may vary between read and write commands.
+
+In addition, on Intel HDaudio Intel platforms the DMAs need to be
+programmed with a PCM format matching the bandwidth of the BPT/BRA
+transfer. The format is based on 192kHz 32-bit samples, and the number
+of channels varies to adjust the bandwidth. The notion of channel is
+completely notional since the data is not typical audio
+PCM. Programming such channels helps reserve enough bandwidth and adjust
+FIFO sizes to avoid xruns.
+
+Alignment requirements are currently not enforced at the core level
+but at the platform-level, e.g. for Intel the data sizes must be
+multiples of 32 bytes.
diff --git a/Documentation/driver-api/soundwire/bra_cadence.rst b/Documentation/driver-api/soundwire/bra_cadence.rst
new file mode 100644
index 000000000000..724b231e7b37
--- /dev/null
+++ b/Documentation/driver-api/soundwire/bra_cadence.rst
@@ -0,0 +1,67 @@
+Cadence IP BRA support
+----------------------
+
+Format requirements
+~~~~~~~~~~~~~~~~~~~
+
+The Cadence IP relies on PDI0 for TX and PDI1 for RX. The data needs
+to be formatted with the following conventions:
+
+  (1) all Data is stored in bits 15..0 of the 32-bit PDI FIFOs.
+
+  (2) the start of packet is BIT(31).
+
+  (3) the end of packet is BIT(30).
+
+  (4) A packet ID is stored in bits 19..16. This packet ID is
+      determined by software and is typically a rolling counter.
+
+  (5) Padding shall be inserted as needed so that the Header CRC,
+      Header response, Footer CRC, Footer response are always in
+      Byte0. Padding is inserted by software for writes, and on reads
+      software shall discard the padding added by the hardware.
+
+Example format
+~~~~~~~~~~~~~~
+
+The following table represents the sequence provided to PDI0 for a
+write command followed by a read command.
+
+::
+
+	+---+---+--------+---------------+---------------+
+	+ 1 | 0 | ID = 0 |  WR HDR[1]    |  WR HDR[0]    |
+	+   |   |        |  WR HDR[3]    |  WR HDR[2]    |
+	+   |   |        |  WR HDR[5]    |  WR HDR[4]    |
+	+   |   |        |  pad          |  WR HDR CRC   |
+	+   |   |        |  WR Data[1]   |  WR Data[0]   |
+	+   |   |        |  WR Data[3]   |  WR Data[2]   |
+	+   |   |        |  WR Data[n-2] |  WR Data[n-3] |
+	+   |   |        |  pad          |  WR Data[n-1] |
+	+ 0 | 1 |        |  pad          |  WR Data CRC  |
+	+---+---+--------+---------------+---------------+
+	+ 1 | 0 | ID = 1 |  RD HDR[1]    |  RD HDR[0]    |
+	+   |   |        |  RD HDR[3]    |  RD HDR[2]    |
+	+   |   |        |  RD HDR[5]    |  RD HDR[4]    |
+	+ 0 | 1 |        |  pad          |  RD HDR CRC   |
+	+---+---+--------+---------------+---------------+
+
+
+The table below represents the data received on PDI1 for the same
+write command followed by a read command.
+
+::
+
+	+---+---+--------+---------------+---------------+
+	+ 1 | 0 | ID = 0 |  pad          |  WR Hdr Rsp   |
+	+ 0 | 1 |        |  pad          |  WR Ftr Rsp   |
+	+---+---+--------+---------------+---------------+
+	+ 1 | 0 | ID = 0 |  pad          |  Rd Hdr Rsp   |
+	+   |   |        |  RD Data[1]   |  RD Data[0]   |
+	+   |   |        |  RD Data[3]   |  RD Data[2]   |
+	+   |   |        |  RD HDR[n-2]  |  RD Data[n-3] |
+	+   |   |        |  pad          |  RD Data[n-1] |
+	+   |   |        |  pad          |  RD Data CRC  |
+	+ 0 | 1 |        |  pad          |  RD Ftr Rsp   |
+	+---+---+--------+---------------+---------------+
+
diff --git a/Documentation/driver-api/soundwire/index.rst b/Documentation/driver-api/soundwire/index.rst
index 234911a0db99..ef8d90dfbdde 100644
--- a/Documentation/driver-api/soundwire/index.rst
+++ b/Documentation/driver-api/soundwire/index.rst
@@ -9,6 +9,8 @@ SoundWire Documentation
    stream
    error_handling
    locking
+   bra
+   bra_cadence
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/soundwire/summary.rst b/Documentation/driver-api/soundwire/summary.rst
index 01dcb954f6d7..df78053743b5 100644
--- a/Documentation/driver-api/soundwire/summary.rst
+++ b/Documentation/driver-api/soundwire/summary.rst
@@ -184,14 +184,6 @@ function that provides capabilities information. Bus needs to know a set of
 Slave capabilities to program Slave registers and to control the Bus
 reconfigurations.
 
-Future enhancements to be done
-==============================
-
- (1) Bulk Register Access (BRA) transfers.
-
-
- (2) Multiple data lane support.
-
 Links
 =====
 
-- 
2.43.0



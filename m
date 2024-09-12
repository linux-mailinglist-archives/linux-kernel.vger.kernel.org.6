Return-Path: <linux-kernel+bounces-326481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6EF9768DE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D25BB2432C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02419F420;
	Thu, 12 Sep 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Sd+YwGt+";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="fF1w6HzE"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099771E51D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143313; cv=none; b=pHhsdoaNJrOreii39sBJ9bBUR8ED6+J7ezw5U0HwA0bF5gUYYVez0B/spVlLa+RXFxEL42V1bsgBqT5DoZGSfjFBbyfW+uo7JewWvBGvUlxjpZMbhj3PiVZCOqhXZMukMWkJUsi105olAfv6qrB2YkpKaDNQflhCWbKgs9J1l/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143313; c=relaxed/simple;
	bh=oP+x8vTR6i5LlScGznSHY5Nv6feXOepnr9iiMusFwbE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGwtE3TDeK1IA9AtV4jbeeAKsa7Gj46OhPxUH867smFLVLbdA7r9qvzbP8W1OdmJc5ElrXnkmGLnHJfrPxw+3ENU4ntx3D/44rvu7/4F76BL5bafYrVSn6yA9S8VWgm/JyWUGnFJHAYurSpPLJBLf3PG7OgjJ6lqUfzoLPcTzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Sd+YwGt+; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=fF1w6HzE; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726143309;
	bh=oP+x8vTR6i5LlScGznSHY5Nv6feXOepnr9iiMusFwbE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Sd+YwGt+tlFV3Ao0FyAT7VdVyLAleprzJQFM6pzpsfp02E17Ci1u4qdKJY/Rxeau+
	 7oWuRxf/L+WJ0fi/oCkx2WqWTX5Ed7pHNFRkhS1qnAFpqO3Axi1BlBSjiMOhiGqxnM
	 dx8Z4USKLREam8PlDKfZV+ejUE5Xz+tWN6Y+HcD8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E3E321286089;
	Thu, 12 Sep 2024 08:15:09 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id D75SfnYKynVW; Thu, 12 Sep 2024 08:15:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726143308;
	bh=oP+x8vTR6i5LlScGznSHY5Nv6feXOepnr9iiMusFwbE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=fF1w6HzEY/tm/Y6bSe4tFwhUdZImuVSqH0K0W6zR9CNnGWPOtpE1FEbPV3pbm2/OL
	 EDdBMdwwf+bW4b2fcJ97CFbmT1g8Lv9fTT92Nu3GANo8wzk2oTuOlA455jf3/F+QNt
	 VTwN+mTxpsnV7bw6d+qQ/21ANA5cItEfEp8qnPBk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 384B512860C5;
	Thu, 12 Sep 2024 08:15:05 -0400 (EDT)
Message-ID: <0b334090c4bf21740b19371664ad0d78b66830c4.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Qinkun Bao <qinkun@google.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Dan Williams
 <dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner
 <lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Mikko
 Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org,
  linux-coco@lists.linux.dev, suzuki.poulose@arm.com, sami.mujawar@arm.com,
 Chong Cai <chongc@google.com>
Date: Thu, 12 Sep 2024 08:15:01 -0400
In-Reply-To: <c7157fb7-b8d0-482b-9ec3-d60179a95882@intel.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
	 <20240910170959.GA213064@myrica>
	 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
	 <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
	 <CAOjUGWfgYoXBzUB8wFvO5LDq+=t7hAEksu0EA4Dc7FwbmUJp7A@mail.gmail.com>
	 <f92766c96c993276bec770e8a255bca6cc46c292.camel@HansenPartnership.com>
	 <c7157fb7-b8d0-482b-9ec3-d60179a95882@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-09-11 at 22:23 -0500, Xing, Cedric wrote:
> Hi James,
> 
> I would like to clarify that, even though the log format is
> incompatible with the existing TCG2 log format, nothing prevents TPM
> PCRs from being exposed through the TSM measurement framework.

Well, the PCRs are already exposed through 

/sys/class/tpm/tpm0/pcr-<algo>/<n>

but they don't have much meaning without the log.

> Please note that the existing event types in the TCG2 log format are 
> predominantly BIOS/firmware-oriented, which seldom makes sense for 
> applications in OS runtime. Consequently, most application-specific 
> events have to come under the EV_EVENT_TAG umbrella, which is 
> essentially arbitrary binary data with no specific format. Thus, I
> don't see much value in continuing the TCG2 log into OS runtime IMHO.

And the IMA log, which is runtime and isn't TCG2?

> The proposed log format aims to provide a framework for unambiguous 
> hashing while allowing application-defined events. Its primary design
> objective is to enable application-agnostic kernel/verifier to 
> hash/verify logs without understanding the event records, allowing 
> application-specific appraisers to be built on top (i.e., 
> semantics/storage separation). Both TCG2 and CEL formats rely on 
> event/content type to dictate what part of event data to hash, making
> semantics/storage separation impossible. Therefore, this proposed log
> format cannot accommodate entries from TCG2 or CEL logs due to that 
> design conflict. However, entries of this log can easily be
> encapsulated in TCG2 (as EV_ACTION entries) or CEL-JSON (a new
> content type string needs to be defined, like what systemd is doing
> today) logs.

But that's my complaint.  This specification:

   - Records are lines ending with `\n`.
   - Each record (line) is hashed in its entirety (excluding the
   trailing `\n`) and extended to the RTMR.
   - The log for an RTMR is stored at
   `/sys/kernel/tsm/<MR group name>/<RTMR name>/event_log` and consists
   of these delineated records.
   - Lines that are empty (containing only `\n`) or start with `#` are
   skipped (not hashed or extended).
   
Is completely incompatible with pretty much every current log format. 
Given you have fairly elaborate decorations for the register formats,
what's the problem with simply having a decoration for the log format? 
That way you can use the above incompatible log for your purpose but this
framework can support existing logs and expand to future ones as they come
along.  All this would mean initially to the code is adding the decoration
file (easy) and ensuring that append_event is handled by a log format
specific component, allowing for expansion.

James



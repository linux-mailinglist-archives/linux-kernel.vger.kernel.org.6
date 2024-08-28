Return-Path: <linux-kernel+bounces-305583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6819630D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC0AB24955
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A011A76C4;
	Wed, 28 Aug 2024 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNTKgJE2"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30691A2560
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872530; cv=none; b=gkobQbNVe+64IB6PzDHFRZ9ib5egzWy5k98TZn/RN5oOxZFCgF3Z279vQkWU+j98YmczGiiPPX7Q8AfKgNtt5NgdOcFK7gJRLo6N2Cy42ESlvtLnBWCYtK5BZRcmuOLnv2I6CpEw7UAct75r/f0YjrO1J2xY/KeoM813aQx/8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872530; c=relaxed/simple;
	bh=OFFjWCAkZTfhHUbPhbd2XLr3Ackff1nTe8wOCR3ZCOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUve2bIHvl4WMJ4lw9mQl2X+gSB2zWMn+td3P1rV++fD5rzhQK5gi130qarZd1fiAR0AxziBVXxVbjHkyG1wf4wv70yuGhl/WQWVex61YWg/YNZYSnMrJ4tnjqmFKqAtvMAqzvLR4XikpYEg+wwVzGydojlBqlbR19kzRvUMMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNTKgJE2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so4867776b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724872528; x=1725477328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sP9CnC+tXRoohEWKh7FkX7Mgvs6Et+x7eDaOQdpvFNg=;
        b=UNTKgJE2ELluRyU6Igyve7LV9Xnyl9/LpX3GCiMbpPlWqI/lhy3IQionWEc5qod2jv
         HS37PcY0KQrUtANm4t6d1bEAdF4w7XT9QYdBiug7tRQ0P/12UJzcSkLQO02yn7/FxGWv
         4K7FIz4b7F1QeIsFNhcgGwCJvFMApyZaueUSHJcZ/GWzEVy14EMZAov2I//6T2Igc7Aw
         5hxuVCUwrfsaShNT1t+GWug0il4bp0CsXxjKqhxotWhnicOZECIRJQvcrRBPGogCyL88
         egw6l7SXD2v8BIZFCmTsFEGDZYBcKy8dCOf8DHp68NDexqEBAYj9YlCrZsIwkHw+62CJ
         AvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724872528; x=1725477328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP9CnC+tXRoohEWKh7FkX7Mgvs6Et+x7eDaOQdpvFNg=;
        b=i0E06aRrdZUrp2cy2o2EYTudlaEObObzMXDS4yJ2K7L4qW8aGF7I/BkLwqweoWaS0g
         skP96kbsAey/N/xX4aJ1BPIU8QBQhfHvXwLE1Czo/dBQ65FjVv8TqEQeWaBkfE6Sp4nI
         ASrBSkWkqSCZkMHiEX/qRlOX+GkT3sLGEBnDOvg/nmzEjD0t1fNHmJ3KAWdK+xIfNZro
         ewoiHo8N7+J8zLVxbIEPkAmodwMfP81WbtAkdbv1SWq+yGw64Opbx+F6ceRspTefIQ9F
         dhv0CkdhyOFdjznejWbPcLxRa08Eva+iNKisa0teZAWKkE94nQiZ8eRslIc/dk6vvWOP
         iUMw==
X-Gm-Message-State: AOJu0Yx8yvZ8TUCjF3AbqToLF8D1Fz72sQkjt2MiGEYwxu6D1GwvaWEM
	jeMk5tJO4Q+eeaBrjg+jY9DoLwrkyzHMTKDztyJlnpz5ebLa07D9JCYlHQ==
X-Google-Smtp-Source: AGHT+IEHo9OCeVVv7yEFNiDTUTzYgLedtXJLbHjUeFUHAIDa4qfowMHQb7iYxFYWZYBiKYWeM3dzZQ==
X-Received: by 2002:a05:6a20:ce49:b0:1bd:27b9:b63f with SMTP id adf61e73a8af0-1cce10add5bmr330079637.37.1724872527664;
        Wed, 28 Aug 2024 12:15:27 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3eb8:762:d1b6:97f9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db5f5sm2286216a91.10.2024.08.28.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:15:27 -0700 (PDT)
Date: Wed, 28 Aug 2024 12:15:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Woody Suwalski <terraluna977@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mouse_cypress_ps2: Fix 6.11 regression on xps15z
Message-ID: <Zs93TGkl_ZMjHHAd@google.com>
References: <a8252e0f-dab4-ef5e-2aa1-407a6f4c7204@gmail.com>
 <Zs55AWhUEts-uJ5B@google.com>
 <11bb84ed-4902-b993-57b0-26ad233942e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11bb84ed-4902-b993-57b0-26ad233942e4@gmail.com>

On Tue, Aug 27, 2024 at 10:46:11PM -0400, Woody Suwalski wrote:
> Dmitry Torokhov wrote:
> > Hi Woody,
> > 
> > On Tue, Aug 27, 2024 at 07:44:12PM -0400, Woody Suwalski wrote:
> > > Kernel 6.11 rcN on Dell XPS 15Z:  touch pad has stopped working after the
> > > patch
> > > 
> > > commit 8bccf667f62a2351fd0b2a2fe5ba90806702c048
> > > Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Date:   Fri Jun 28 15:47:25 2024 -0700
> > > 
> > >      Input: cypress_ps2 - report timeouts when reading command status
> > > 
> > > It seems that the first communication is with an invalid packet of 3 NULLs,
> > > and that
> > > status failure used to be ignored. With the above patch it is now returning
> > > an error and
> > > that results in a dead touch pad.
> > > 
> > > The fix is to stop flagging an error for 3-byte null packets, just keep
> > > ignoring them as before.
> > > [    2.338016] [    T591] err: Command 0x00 response data (0x): 00 00 00
> > > [    2.338032] [    T591] ok: Command 0x00 response data (0x): 33 cc a2
> > > ...
> > > [    2.770029] [    T591] ok: Command 0x00 response data (0x): 33 cc a2
> > > [    2.998030] [    T591] ok: Command 0x11 response data (0x): 01 00 64
> > Could you please send me logs with i8042.debug=1 kernel command line
> > option please?  I wonder if we need to wake up the controller...
> > 
> > Thanks.
> > 
> Sure, the dmesg log is attached (for the failing scenario)

Thank you.

> [    0.000000] [      T0] Linux version 6.9.0-pingu+ (root@DellXPS15Z) (gcc (Debian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #24 SMP PREEMPT_DYNAMIC Tue Aug 27 22:33:33 EDT 2024

This is not 6.11, did you patch 6.9 with cypress patches from 6.11?

Anyway, the patch you posted does not make sense. You are doing the
following check:

+        if (!(pktsize == 3 && param[0] == 0 && param[1] == 0 )) {
+            rc = -ETIMEDOUT;
+            goto out;
+        }

trying to ignore "all zeroes" response from the device, however at this
point param array does not contain data from the device, it always
contains all zeroes because of memset() a few lines above. So in effect
you always skipping reporting timeout.

However I think cypress is busted in general as it looks like it times
out all the commands, because it tries to issue them outside of libp2s,
and so noone is actually wakes it up when we get enough response from
the device. To prove this could you please try applying this:

diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index b3c34ebcc4ef..8c0c7100aa4d 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -115,8 +115,9 @@ static int cypress_ps2_read_cmd_status(struct psmouse *psmouse,
 	if (!wait_event_timeout(ps2dev->wait,
 				psmouse->pktcnt >= pktsize,
 				msecs_to_jiffies(CYTP_CMD_TIMEOUT))) {
-		rc = -ETIMEDOUT;
-		goto out;
+//		rc = -ETIMEDOUT;
+//		goto out;
+		pr_err("XXX looks like timeout\n");
 	}
 
 	memcpy(param, psmouse->packet, pktsize);

and let me know if you see "XXX looks like timeout" multiple times
during initialization (essentially for each extended command issued by
the cypress driver)?

Thanks!

-- 
Dmitry


Return-Path: <linux-kernel+bounces-531289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3632A43EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029D03AA4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D11E267B7A;
	Tue, 25 Feb 2025 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBryZq+X"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3281E7C0A;
	Tue, 25 Feb 2025 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484678; cv=none; b=MtzmPFTwowUZp7a0sBTWy9zZljcWMD5U1pk+ghMJ5y60VJdGi6vhNJV4Wr3pZjihqVQ+nVz+OEPl+ahmhlq0PpswJUGDGlR0ZPqVVCt59EPGulx/bVjO21lP0wpatuiooPGzaIp42UzBhRHlPCFwQ1u3JCcO/ygMfwhhEJSsD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484678; c=relaxed/simple;
	bh=L9zvKXRv4c3bXhNyjLzX65AtYdpn8Ffw1O68j1Jvs50=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TMuKkNtA/4oMfg5KbmBoj6aPDXKicnt+TQDVx+13RInSwRe6utLcbi8NRRocyJTKBBwLKpoQ0guij+38mlfw5Ah81q+LgwKROGKxkCCR+Z5abm0luq/MrnXoiDK7lX5qGzfrO7DPnwrl/zcvxVyEPMIQICVdtdK8x4dz76pYkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBryZq+X; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso7513297a12.2;
        Tue, 25 Feb 2025 03:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740484675; x=1741089475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+oQbQtf7tgruZ3SskNuc1XmiV1tLLW5ur3bDpFOqjg=;
        b=hBryZq+XaEyMuRH4WJ6hcC4Do/hy45WcYhFXnRsYFbNvqjcdR6KQdze7MxUxk9NRBJ
         MitpcX6PvtCYtNtLgFxz8D4kX+zk9lhx7SWn6YMapW3Iu7MF1qGCjWrvhBdxLMIrI+Mn
         8G/bljVEfbc2zR3gItIKrQFmkxYSAaVKUKl1ZEe2BJHoqoqudmzyhMdwCFzhsYQLtzUW
         /3LnsP413Ybwin0qgP5un70hTbEw9R94B1zjlRpKpuCCSX7jooxb5hnEH8IEQgh0W+G2
         4kJgOtNMB3TZLK6uUrWsJ3W9EZnTRV7sL/gm06YrbmBBwrAJGpyZKoI7v+FCMejbG3Pi
         HOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484675; x=1741089475;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+oQbQtf7tgruZ3SskNuc1XmiV1tLLW5ur3bDpFOqjg=;
        b=dKMWdObRxfqr6z8pdjRH5BKBJfLDG1JgheYK8a57WHJUzaRMMfngmPPV5/ytBGTTRl
         GR1Gw3QJ1SeNsPPGbcF9ieCODcRQv7QZNyX9jluZpez5uNmDk0Z2lRzs0ga2WU4Gnxjd
         RnXZ2kucZCYzQIgCkiCtPZbm0emURVBB2KuisMJaKPsWx1eXFs5Ge0JyzZ3nVvXSWP+w
         SgCU8zz2PwSRR3vG2/eGO9f7Gynw0KK3MAoX/9UJ/pEBN/uV7n26d59t5jPlq0+fS1V/
         SCxlxK+XhaFvfo/H/o2afrq7e7BVJGSe/eph/ASgGWJfhJNjNxoNJz/tv5VkqOiMJso5
         LddA==
X-Forwarded-Encrypted: i=1; AJvYcCUxCnlTpW+bRvfE6LR8CiRNFopFbUw/sXjddLHnXMUULLiYRUxnbYWlkA58l1aCMNCfrAHSWBdoifGJkic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA3NC58yinox73kHN13xbRCl6VwsFWWhr/+CzKSUSux/tXC6jE
	muc7pf2yC2sXh4Pn0Di+jc2hqAaRO55pdK7D4CBE6vxnP/oxjTMx
X-Gm-Gg: ASbGnctG5qigSNW9dmrOK5D9hvIhDicb0g8/fhiBFlxDBGkZCd81hfKMZrpU20zszIF
	Bk+KtJ940yVTosW0YJIn5fMELrYjtPvamlSn4It2bTmU+cE7eAEHgrh34W0zycyt9L68gNT3D/z
	vBVFPeJ5nhnyzMwh8RUqdb1XJBGMQIrQ8sfSv7w7+HfUHuALyjaCYJNwY0qJGe0NJljcEx2KPiq
	osJX3B0mTLI9WHzsohFTZ5guvwSz484QrvODw76oTD0dk+T9/BniCeTlIBoAHtNfHrT4sMJuVNb
	KZxNDLCdYqQm/sIGoL32WM8rkxCJu1uPwKldzdUk8Ik=
X-Google-Smtp-Source: AGHT+IEvljivfokfnn/Rvjaln73+Fm6SDBkZKg+ngRkTP3BBxizYPRmt9ZxL7LkeNstdm5rUknLCNw==
X-Received: by 2002:a05:6402:530b:b0:5de:ce71:bacb with SMTP id 4fb4d7f45d1cf-5e0b70f334emr14403735a12.16.1740484674877;
        Tue, 25 Feb 2025 03:57:54 -0800 (PST)
Received: from foxbook (adqm166.neoplus.adsl.tpnet.pl. [79.185.146.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e461f3e675sm1083423a12.72.2025.02.25.03.57.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 03:57:54 -0800 (PST)
Date: Tue, 25 Feb 2025 12:57:50 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] xhci: ring queuing cleanups plus a quirk
Message-ID: <20250225125750.1b345e2c@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I was looking at all uses of enqueue/dequeue pointers and I found two
rather complex loops which appear to be doing really simple things.

I don't understand why they were written this way, it seems wasteful
and I see nothing that should go wrong if they are replaced with much
simpler code.

I rewrote them and the driver still works. I exercised Set TR Dequeue
code by starting/stopping isoc streams, using usb-storage with crappy
cable (transaction errors, halts) and also the smartctl -x trick that
results in URB unlinks (both on usb-storage and uas) with some disks.

The third patch is a dedupe. BTW, that comment there about section
6.4.4.1 of the 0.95 spec seems to be wrong, I suspect it should say
that the chain bit cannot be *cleared* because that's how the code
works and what some commit messages say. But I don't have 0.95 spec.

New in v2:
- dropped the patch for obsolete update_ring_for_set_deq_completion()
- added a patch to enable the link chain quirk on one more HC
- don't touch the chain bit in inc_enq_past_link() on quirky HCs
- don't call inc_enq_past_link() unnecessarily

Michal Pecio (3):
  usb: xhci: Apply the link chain quirk on NEC isoc endpoints
  usb: xhci: Simplify moving HW Dequeue Pointer past cancelled TDs
  usb: xhci: Unify duplicate inc_enq() code

 drivers/usb/host/xhci-ring.c | 198 +++++++++++++----------------------
 drivers/usb/host/xhci.h      |  13 ++-
 2 files changed, 86 insertions(+), 125 deletions(-)

-- 
2.48.1


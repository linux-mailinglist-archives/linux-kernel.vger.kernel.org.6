Return-Path: <linux-kernel+bounces-342515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D74988FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C860B213F4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858323749;
	Sat, 28 Sep 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA5ceThN"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DDA1CFBE;
	Sat, 28 Sep 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536159; cv=none; b=U15PpOrpA/dQsOH7R2NSEwY9nDrGa0GFstHSx2s/ttWcng9AGDlwYMr64v3Ngn8joGq1ONt4uNsieUY6juai/yf71E1t/9NTWZk9h+wdH9fhr9j5gVRyQxobnl5VIsVhoHA4PyHNAQEX5qlFAbtOs3unCAIZwOQHuD1mg/nRMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536159; c=relaxed/simple;
	bh=/DNYD4f6f6owALjAlUWB0zBCeXcvCTHGcykcnlTsutY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjRB0lidKpMVH7cvpSy054CyLFPeL5zVtvcJxqv0aKFIgbZRilJ1jrPFOxl1JTXhXs7RRdkQ1hf89JTUXQXxb54Xz3T+k8QzwijJzbiwAuRn3+2iQEDvbBeemyP6E2RGT1ubfuI253v8FH87wR4EJbGcVAjawuDplV4LkUkbLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA5ceThN; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb36237f28so4176156d6.3;
        Sat, 28 Sep 2024 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536156; x=1728140956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhT8ZHt1FQEEPjV96Y/v33ajROrhSQMx4/sIKxSFUgw=;
        b=VA5ceThN4fD9+1GPCgTIgBex0RkxkGwGuj9hK5VngF7zBSu2WVq2itZM3ZxqWMIVH4
         a5PY/lxQd0ruoiY3mZiKRQrkYA3m+SLqUTzR2RhuN3menWFfjRzZ1hP3jQMKMh9B0oJo
         i7ca1GAQm2AuAMzIgU8nkR/TrYg69OkeY0BX+0FDjuYGCcS/XbDpUCEUKi1D12ApT0iE
         2jm7tgj2fwcjYgItT+WPeZhLqHODS1trfgLHgbnRrTDz9AO09DnaeD8Y/3Tb8kP3tOXf
         PpxozqXEX3K8BX9ylGZSWPfye7J2sBZe+t1wlojWp59lm35DQcrGyI5NZU45/hxSFRIQ
         g4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536156; x=1728140956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhT8ZHt1FQEEPjV96Y/v33ajROrhSQMx4/sIKxSFUgw=;
        b=JOqkQ9K05F4U4EFSIUdEt9uuhBep66LjYPQJJyUDyunZOzC9BbTDrDdErTqMvV0r+o
         Rln55tymRoMLb2yORsOa4OXL5hEJmf7pwC8Xb+iQXCC7WWr0Wwz7oRfW84B2unr6JL1A
         w/3V00DN4qT49sBiHcQ5NCcXvIhh10Cdw4XL9I0LqYB/ZjVYYDGm0Kq1HIh4WOzUsVWw
         lBk4NfWu4SQ41qe8tptAWjl58gvShYVQ9eR2QPJ03VgLgxG8gcMMTFd8nDdEcPvA0COZ
         6HejBbaz8qfCmryT54To5PQL4R3LUcv4Rxo/yc0rfOYvfTUSzVp/9875q6Mhnu4FncSR
         0vIw==
X-Forwarded-Encrypted: i=1; AJvYcCWAP0PLo5l89orcaHIyzJusieOsXVuMPZqNrEEAJIctQ08jP1XbukOXljXM4yF79wi3yHNoYrGGB+0=@vger.kernel.org, AJvYcCXcun+HqgfvhBXjF6ced2KheawrOs2WTXTq7iVr+RIJy6mw8SgaC8LB1xHxFCcpFr/D5KMZihjH8oCtCJgF@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZFnnbgy+wGqZh60tt7CtywOv6+aHfH9AFXuMhk8wDpFcBiSH
	PAyoGdbvy9tw46FK9No4g6GNY6NsAS+7mxR/utGCwbmXHmKPal5fjbNmWwGhdLk=
X-Google-Smtp-Source: AGHT+IEuWGDrtLFwTh0FYaZuabDlyY1Jcb9BxIFEGOr21rQwtIKHIpMaE7EedaYGGsvf3p4S6ma1fg==
X-Received: by 2002:ac8:5dd0:0:b0:458:21b2:f9b8 with SMTP id d75a77b69052e-45cadcedf7cmr17959711cf.14.1727536155854;
        Sat, 28 Sep 2024 08:09:15 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:15 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	James Gruber <jimmyjgruber@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	John Keeping <jkeeping@inmusicbrands.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lee Jones <lee@kernel.org>,
	Perr Zhang <perr@usb7.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 00/14] usb: gadget: f_uac: Add support for alt mode settings
Date: Sat, 28 Sep 2024 11:08:51 -0400
Message-ID: <20240928150905.2616313-1-crwulff@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for additional alternate settings for
UAC1/2 gadgets. See references [2] and [3] for discussions on the API.


*** Userspace API ***

* Add the ability to create c_alt.x and p_alt.x directories
  under the function with settings that are available per alternate mode.

  The existing API is preserved and used as defaults when creating c/p_alt.x.
  Subsequent changes to the function-wide settings don't change existing
  c/p_alt.x directories.

  If no directories for c/p_alt.1 exist, alternate setting 1 will continue
  to be created  from the function-wide settings.

  Settings that can be changed per-alt-mode (bAlternateSetting):
  - name               (iInterface     - Interface Descriptor name)
  - chmask             (wChannelConfig - Channel mask)
  - ssize              (bSubframeSize  - Sample size bytes)
  - terminal_type      (wTerminalType  - Terminal Type)
  - sync (OUT only)    (bmAttributes   - Endpoint Synch Type)
  - hs_bint            (bInterval      - Used for HS and above, 0=auto)
  - Terminal names     (see below)

* Add the ability to set terminal name strings. Defaults are the same as
  the hard-coded strings that were present in UAC1/2 functions. These are
  now present as p_/c_ function-wide variants and in p/c_alt.x directories.
  (Note: UAC1 defaults aren't the same as UAC2)
  These are now settable with:
  - it_name     (iTerminal     - Input Terminal name)
  - it_ch_name  (iChannelNames - Input Terminal first channel name)
  - fu_vol_name (iFeature      - Feature Unit, for mute/volume, name)
  - ot_name     (iTerminal     - Output Terminal name)

* UAC1 specific UAPI changes (to bring it up to parity with UAC2)
 - Added support for c_sync (support for USB Out ASYNC mode)
 - Added support for p/c_terminal_type (note that these DO correct the
   order from UAC2 so they follow the device centric view, and align with
   the other c/p options)
 - Added p/c_hs_bint


*** Descriptors ***

* Strings are now dynamically allocated as needed. For simplicity the
  algorithm is O(n^2) and allocates the maximum table size (256) (2KB on
  64-bit systems.) This allows multiple path descriptors to reuse the same
  string ids if they are all named the same.

* Path descriptors (Input Terminal -> <Feature Unit> -> Output Terminal)
  are now created based on differences in settings. Any differences in
  names or chmask will create a new set of terminals.

* Descriptors for each alternate setting are now attached to those settings
  and many global descriptors are removed. Maximum size for each alternate
  setting is calculated for its enpoints. All alternate settings use the
  same set of endpoint numbers though.

* Differences from previously created descriptors with the default settings
  - String IDs are allocated differently. Referenced strings all match but
    have different numbers.
  - Unit/Terminal IDs are allocated differently. Source IDs/Associated
    Terminal numbers are different, but reference the same terminals.
  - UAC2 Terminal descriptors are not quite in the same order.
    Old order was IT, FU, IT, FU, OT, OT. Now it is IT, FU, OT, IT, FU, OT.
    This change in order doesn't really matter, but will show up if you
    look at a diff between the two.
  - UAC1 Endpoint wMaxPacketSize was hard-coded to 200. Calcluated value
    is now 196 for default settings.

* UAC1 Specific Bug Fixes
  - LowSpeed interval is fixed (bInterval was 4 for all speeds)
  - SuperSpeed descriptors are fixed. The old implementation had only
    partial support for SuperSpeed and creates invalid descriptors in
    the default case. (Turning off volume/mute control is the only
    working case for SuperSpeed.)


*** Back-end Functionality ***

* Volume Mute Controls
  - When using a combination of alt modes that requires separate terminals
    the volume/mute functional unit must also be duplicated. This causes
    there to be multiple volume controls on the USB side. In this case,
    there is still only one volume/mute control on the ALSA side and
    all associated instances on the USB side are synchronized. (Changing
    any one of the associated volume/mute controls causes the others to
    be updated to the same value.)


*** Remaining Work ***

* Alternate settings aren't yet updating the u_audio back end so
  the function-wide settings are all that is used by the ALSA interface.
  This effectively means that changing any settings that affect the
  audio samples (ssize/chmask) won't yet pass good audio.

* Testing. Defaults and a few random combination have been tested with
  the Dummy HCD driver (with patch [1] to allow isochronous endpoints) but
  no audio testing has been done yet (just UAPI and descriptor testing.)

These are both pending my having a target that has an up-to-date kernel
for some real hardware testing. This is in-progress but may take a bit
to get working as my current device is running 4.19.168.


*** Deficiencies (not planned to fix) ***

* There appears to be no way to prevent removal of c_alt.x/p_alt.x
  while the function is bound. (This is not unique to these folders,
  as other folders may be removed after a function is bound and UDC set.)
  This doesn't appear to cause any critical failures, but removing
  c_alt.x/p_alt.x while the gadget is active will cause those alt modes
  to no longer function correctly.


*** References ***

[1] https://lore.kernel.org/linux-usb/20220126132249.2133168-1-m.grzeschik@pengutronix.de/

    Patch for partial ISOC support in dummy_hcd. As the patch mentions,
    this is only useful for validating non-ISOC parts of gadgets, but
    does allow them to bind for testing of descriptors at least.

[2] https://lore.kernel.org/linux-usb/CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com/

    Discussion thread on UAPI for adding strings

[3] https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@ivitera.com/

    Discussion thread on UAPI for adding alt modes


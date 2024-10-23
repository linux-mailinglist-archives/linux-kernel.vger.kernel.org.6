Return-Path: <linux-kernel+bounces-377283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC689ABC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33546283CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC1F13B7BE;
	Wed, 23 Oct 2024 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bmNzdM//"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC7132139
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655754; cv=none; b=uqTlVirVFjSpi+npLnYAZfW+SPtd/maQgacG4L0EP7HAS63YwO4oCUP+45DsFZdlp6DRqD7dpGTGHn25HXGrjYnpY417HYFlPtNw0LzTCp0mkEaNJrknoINvragjEkGNIg+/2/EeUUJWoyEMvhKxxd8q0A6ZoR559TUMu+i5Muk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655754; c=relaxed/simple;
	bh=rQK7gWxJRbkk3/XjsQg40ZMmcbV1ZzdgRRVvnvpPn74=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ibP4tI5/FT/6Qf+xQBNZsMSwWN4gpL4n8ergXHRMGxC69NduJmMDl5Ph4tVFDP2k0iOiebLksJ+Z0Fy/iL9ohsAyn0K+fcAlpfFEK4cttmSWWs08zPLcgxNG+DtNhZacJlQ1KAAX9YcGpvZ0/fUK4hmbbS35/HulXuKz4RDx3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bmNzdM//; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3c638cc27so111662307b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729655750; x=1730260550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GmI7Soq3roDCUAnbE0COUFZpGZsP+EnUANl8dSnaRwU=;
        b=bmNzdM//XPpZ6jkGh5C9gEXwgFsP239CdsnQCejuW37rVPeYxb0tzztn8q0YzbbHiF
         ezl/zOz66elITlOEEmeb07y8Iqhv/suUIdZATGuFoMP4erPJt3C16jq2IJcLBiHwPt6j
         tWEjp/tofZFw1EhXFXVolXf8jgLO/4nzjDsFLOU+9tgPqazmyyxddFA2dVpUYuCz02Uj
         KmmO8mElDQMdYltIk0O+ZOoMgcm1B+XF9rdEIweWvEruQCWGmAvVPO7nhoZHwNzj01Yc
         Tgc0SYbUvSrrOIIWxgzH8azWnMDVplrb6Wdr+iSl8TDJ8oQwuwmH4m/bmlkzoDG4+mE4
         sXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729655750; x=1730260550;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmI7Soq3roDCUAnbE0COUFZpGZsP+EnUANl8dSnaRwU=;
        b=Nbh0yaVjirbwyRWCeaMMRESTeO6GJyx5SSWPKBwzg1sYiexRx1LbYQVRcNuaDSLS5x
         tKHn02R3jpCSCEQLbeWLcODTb5C8Ib10BNGoEF2Zts3wAftHjDzLXuJ4DCVEjNwe7hLp
         w2yymNsD/AKAnD5Piz6igTEGRmgIePiSswOcU0E7CEC/R6ossx69/R3CZVcOCW+c1LK5
         NjEAjNtcmVRBBesOIVtPAxeY7CoVJx7wlyFD+PoIFj88NWWQNBuQTpkpBYy4TXIMauGb
         bPEV+cETMy8SzFxrfjbcG6OTi5ZjpbDg9OU5ezHGVLymfsW//iBUJsHXtP8UCfr2EsCd
         V0qw==
X-Forwarded-Encrypted: i=1; AJvYcCXCGyRKzQegIDy8R4TcwQHRz+UeSHKTt6n8TGtc8sTCs6UIzC9mlv/Rsj284pxDEXtGiKqH4cZOEDUhJtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJ0jp4ng6K4Cw/2d3i8or3vzkPQ2xzLfDt9GLDz04n5pqXzQl
	bn4oEkdgzsob8N+QAaFIKV+3m1T8OkScICMJwMp6jhgA7nu19AHWjr0wictimB2sKFpGQKBUvtp
	5cA==
X-Google-Smtp-Source: AGHT+IFwM7FsOs33Bm6JoIK39+oXfBykLbhJ1raXYq//FeA3l6SBgfdQIZAUAQ8v3qbIAYaoTToB5BzkchM=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a05:690c:7488:b0:6e3:1023:3645 with SMTP id
 00721157ae682-6e7f0fd1f99mr182307b3.8.1729655750550; Tue, 22 Oct 2024
 20:55:50 -0700 (PDT)
Date: Tue, 22 Oct 2024 20:55:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMNzGGcC/x3MTQqAIBBA4avIrBvQoT+6SrSwnGoWpWhEIN09a
 fkt3suQOAonGFSGyLck8WeBqRQsuz03RnHFQJpqo4kwOHQXXnIwhuhDQtP0XavnlVpLULIQeZX nX47T+36ptcVUYgAAAA==
X-Mailer: b4 0.13.0
Message-ID: <20241022-pd-dt-time-props-v1-0-fea96f51b302@google.com>
Subject: [PATCH 0/2] Add support for time DT property in TCPM
From: Amit Sunil Dhamne <amitsd@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>, 
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
	Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="utf-8"

USB PD specification defines a bunch of timers that can have a range of
acceptable values instead of specific values. These values have to be
tuned based on the platform. However, TCPM currently sets them to a
default value without providing a mechanism to set platform specific
values.

This patchset adds new DT properties per timer to allow users to define
platform specific values.

The RFC patchset for this was already reviewed and no changes have been
made since. The link is:
https://lore.kernel.org/linux-usb/20240925031135.1101048-1-amitsd@google.com/
Because of this, I have retained the Reviewed-by tags. If you  think
they should be cleared since this is a more formal [PATCH], please
let me know and I'll do so.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
Amit Sunil Dhamne (2):
      dt-bindings: connector: Add properties to define time values
      usb: typec: tcpm: Add support for parsing time dt properties

 .../bindings/connector/usb-connector.yaml          | 35 ++++++++++-
 drivers/usb/typec/tcpm/tcpm.c                      | 73 +++++++++++++++++-----
 2 files changed, 91 insertions(+), 17 deletions(-)
---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241022-pd-dt-time-props-158760bf26a2

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



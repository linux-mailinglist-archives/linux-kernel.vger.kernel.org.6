Return-Path: <linux-kernel+bounces-393666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5919BA3CC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F389281F0F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 03:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B983CDA;
	Sun,  3 Nov 2024 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgQelnFM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E033D8
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730605605; cv=none; b=o2EjSr1EWNi2JvJ0pkH/krMHdsAp5NEdbWXSe731DpTtC/t/NbMlVI04cKQa9rMRhbnZr+N8YLuiY7iBoj9xObsUga8m5Y4xXsmmq1FZiV2WiEeAwd6HaquJ6GFyOMia337ZLKwSdNAkelcAKTGqL4b5xvvtTwtB5UZJVcoxReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730605605; c=relaxed/simple;
	bh=Y8PUlPYSyYfURqxBrhBW27mPXCr/o14+GzZHLQXbQqc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a+iUHy0tqq15AKLLHQtgr3Nrp/TBfYcvnEb0j/gBQfh4tUmHTJ04U7bW9U/btWDV0Mm6qmhrUXY5+LGATkk70mjaF9SoOK7HuK0yH+Uz0HbEGc0+UYkNZFlplYe6cIB3RYNQG90ug4DG3v/Z5EO6QFtKRhusHY3UODfSMXcAic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgQelnFM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea90b6ee2fso2154817b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730605602; x=1731210402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yqrMO7jaI/jLQSZ1khmj67HB8Idd75hZoxXR9Jgd7NE=;
        b=YgQelnFMcAeKbRXX/TxCmGDsBjMKHLgq4sDZMM+2hk+D+SHvB5dGptm9DgMkQ1RvY7
         HdRSNcNGTB5kwQL/ydfk5zR9wJWPqFS4RUnc7dsONgTbI58oEAsjikR8+YkCPLZzRLyG
         t25ET7FQOVlDhZ8+OC1EpvAqjtOtSE1taM4bmyK2zWvxXA4NciV9ZjANc0cBJXDRLdea
         P9He9MLXpKu/bxYZTyE7+zfwFTQFcH+gzazbT0Jh/axdZMv+it0XRj+llMRs/WDXmqxs
         NYf0kIAU9KxgqvlJe9PqM5I3AaP7bFBw4UMbz6+agjZQ2TxGhlfvfBgVwrvPCKI0yyC4
         0WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730605602; x=1731210402;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqrMO7jaI/jLQSZ1khmj67HB8Idd75hZoxXR9Jgd7NE=;
        b=S/eOroSYgZid9HU+4iVCWXNG9SxERRsbGGboRe96W6sCa4QVO4cdjvfwpbnQcRRN9z
         y/NH0RzCb6L8J7+d6YLOOo+Ckw7/br4Rviu7Qv/hiRxRPLZwY7f4J1//Mr2gvT56adpk
         jWkvJOsvvwEcavJ8zfEiU2XdKieHPPsk5KSvT/eCEMj2XXQGSEYEsqUt8jL4XpIoSeyF
         tvFcGu2F80gJ0L+40F5yqeholrlAVZEZeRTBmEdGBaOUbJLdNiuulLsHb3DC/EUY5c6y
         ywDi6kTSzIXXvR4sU8ITrfMvsQMVDoi3aIAjBw3OHLV2YblKE8P2/0d7qBCUtHmrDkSw
         3DCg==
X-Forwarded-Encrypted: i=1; AJvYcCU+9wD2O3LFZSzApmHNBnA7xxseuXNTW/DZpp27pUGiruRnACn687uFHmjsVj8FnkY7LvdLIvuvXdRakmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbXHMqluX2GiDkxOIYe9E9MgTSOWUVLcp+acHD/03eADlxrHbO
	r/2bHR+EJrmT7GKk2RZUrUzZrhBDeHt3KfPPX77ejfVoOHYz4HhDXt0+JyCVYaz0gqhU7c9khSm
	UyQ==
X-Google-Smtp-Source: AGHT+IFzQ+XLUA1KqayCYTQxnRNjwiTTVM+4ZQkOR0Cd+ZD6QXJMpVyAz4IyOMK5iRkGypJY7FXAKdLo4ug=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a05:690c:460b:b0:6ea:7a32:8c14 with SMTP id
 00721157ae682-6ea7a328fe2mr115267b3.7.1730605602048; Sat, 02 Nov 2024
 20:46:42 -0700 (PDT)
Date: Sat,  2 Nov 2024 20:43:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241103034402.2460252-1-amitsd@google.com>
Subject: [PATCH v2 0/3]  Add new time property for battery charger type detection
From: Amit Sunil Dhamne <amitsd@google.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc: dmitry.baryshkov@linaro.org, kyletso@google.com, rdbabiera@google.com, 
	badhri@google.com, linux@roeck-us.net, xu.yang_2@nxp.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

This patchset adds a new time DT property to handle time taken by
battery charger type detection completion.

Note that BC detection is based on
"Battery Charging Specification Revision 1.2".

This patchset depends on the patch series:
 - https://lore.kernel.org/all/20241022-pd-dt-time-props-v1-0-fea96f51b302@google.com/

Changes in v1 -> v2:
  - Fixed the subject line in patch [2]:
    s/maxim,max33359.yaml/maxim,max33359
  - Fixed typo in patch [3] in body:
    s/conroller/controller


Amit Sunil Dhamne (3):
  dt-bindings: connector: Add time property for Sink BC12 detection
    completion
  dt-bindings: usb: maxim,max33359: add usage of sink bc12 time property
  usb: typec: tcpm: Add support for sink-bc12-completion-time-ms DT
    property

 .../bindings/connector/usb-connector.yaml        | 11 +++++++++++
 .../devicetree/bindings/usb/maxim,max33359.yaml  |  1 +
 drivers/usb/typec/tcpm/tcpm.c                    | 16 +++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)


base-commit: 0fc810ae3ae110f9e2fcccce80fc8c8d62f97907
prerequisite-patch-id: c08696694dabcbb86b458a935a9cbbcbabb75672
prerequisite-patch-id: 634924883df820956acb33941b659e8c9ef85d1e
-- 
2.47.0.199.ga7371fff76-goog



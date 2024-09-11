Return-Path: <linux-kernel+bounces-324037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD9197471A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E41C2546D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE9010F2;
	Wed, 11 Sep 2024 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TAd7y5hE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19E382
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726013255; cv=none; b=uOCC+/KqRHRG0Bsv2oOSS/YhlNVu2NUVrspDtFvsijbafwme4Z+qrTVwn4HPjLM+xU8SfhlDo0greegw/hxbKokr+PJPsixcM6vvxfwch44JleYmjAvkT5+J3G9b/6AHT2prX3aAWZOnGvcqaeZ7tr8yk23J2tA8itIZEmkOO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726013255; c=relaxed/simple;
	bh=1+qPxl5D5ppd0QzY1M0HT/kSWhasZOugCZph3VHfXU8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cJjRISmKef2SwE8MQcEC4mijZQqPioHLflcE1K38EQF7RNbb5hv65b3Uqr233rDcI97d7feD4dS1ix7CAHS4iS294rKi6AUJjoeNRx1nKJSToPCmfBc6K6n2W9RNfLzIHV1nJh4BnCHvM/qjRbF6h2Nr8HXb5FVawNSlqKZbEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TAd7y5hE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d6b2b9a534so37920647b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726013253; x=1726618053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oIOVlzzVlgTSeq1zrmd8MwSGHLUCIbq3yQPopLfuC8A=;
        b=TAd7y5hETUt5FxKDUEEujVrMxnoazncymWvHkvlcWrMKkLl1MnYcwaXr5IA59eB/qC
         AnqAfb15jOxsbHC6KGsyf+5wLJ9jov69xkj40tqpYHRfiPPJ2iNFyN99ak95A3sWRExu
         PcHx2qB3B3Kd72B9racl39foAHAeN+n1qdOCBlJfQZhY88bC3GBjl17Hlm5bYC9MZyzH
         wBAvqm5upH1+/X0VEzsIhkj1Rj2AfXf/AU+3UEGXTUzD7yucU9cTrQpkvksjXzpxThbS
         MJrLXI52hzGXceLJJgtBSPJd6nUZod81bIaeK5CCUEPDreM/sLk+kwJgHeZpH1mZAa6l
         /SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726013253; x=1726618053;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIOVlzzVlgTSeq1zrmd8MwSGHLUCIbq3yQPopLfuC8A=;
        b=VzVG4L4J809/BlE9vjk2Bf7XEtxv1vNoJiIEQr44c4geYZEW3VBvwI5gTzGUDCPBgj
         NUCg2qznGrWZ0JGKaB42ou5XRC4ewhdIwComwLGhcjKBhcF9d9byNNt7e6vnOZs574gb
         PgHaPejlGuBO9uaGZvShUac1ywRIS1Ti0+bYiDyyKAaEUkAeQWfqQGbBKvkpVhSIz3pn
         w2vCavzQN6UQtzqiIsVPiQy+qCiwvaVlO4SQg7uqbUWZ/bh9iUNIDxArmlN24Q0tDKCr
         Z4uSJumq3ard1821XbDOOU5UGruSGzx84xTEfWm3DA+zpWgvRpElsKjE8iJYu0jf6gD2
         TrQA==
X-Gm-Message-State: AOJu0YxOpex/hDLOVbOu6PzzHC0Jblp2Zph0gAOCbUmsjrhPjwSLScuE
	iwAC7rycnpV7N8L32EaGk33STVG1OtrAgrdIph3mFg3s42Uy3CQw1qbdrbE7Zd2a8nhotOgSdpi
	cYA==
X-Google-Smtp-Source: AGHT+IF7pSolH1dn9rq6YdhPYaWXBgpvjKt5kuCXOUTmXvZHBfJW0RXJoqxHwCVJhF9SP9tGgTU3Kq5F9vE=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a05:690c:2c12:b0:66a:764f:e57f with SMTP id
 00721157ae682-6dba6e28b59mr187237b3.7.1726013253367; Tue, 10 Sep 2024
 17:07:33 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:07:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911000715.554184-1-amitsd@google.com>
Subject: [RFC 0/2]  Add support for "pd-timers" DT property in TCPM
From: Amit Sunil Dhamne <amitsd@google.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kyletso@google.com, rdbabiera@google.com, 
	Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

USB PD specification defines a bunch of timers that can have a range
of acceptable values instead of specific values. These values have to
be tuned based on the platform. However, TCPM currently sets them to
a default value without providing a mechanism to set platform specific
values.

This patchset adds a new DT property called "pd-timers" to allow users
to define platform specific values.

Amit Sunil Dhamne (2):
  dt-bindings: connector: Add property to set pd timer values
  usb: typec: tcpm: Add support for pd-timers DT property

 .../bindings/connector/usb-connector.yaml     |  23 ++++
 drivers/usb/typec/tcpm/tcpm.c                 | 110 +++++++++++++++---
 include/dt-bindings/usb/pd.h                  |   8 ++
 3 files changed, 123 insertions(+), 18 deletions(-)


base-commit: f299cd11f7539482e87b2d2d527968a26b33f0ec
-- 
2.46.0.598.g6f2099f65c-goog



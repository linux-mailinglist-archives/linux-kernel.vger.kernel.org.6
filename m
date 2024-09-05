Return-Path: <linux-kernel+bounces-317953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900196E5FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B3F1F23018
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD911B2EE8;
	Thu,  5 Sep 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uscC3UhK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929621AF4CC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576888; cv=none; b=tlJ26MSovOhMtRDy3c9r8ls0hBfoSMuOTUOt228HIeCWt0+5wSvliEV0tTZm4XPr/OKWHtIzD3KKdN1CdF9//LNjEjyWp11j1HMVK2SwwO495JqYVqaFBSh13VCralBN+3np4KQCtj8eF9h2WSHyq6dEXKsbFCW1vb9Ic+Xvby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576888; c=relaxed/simple;
	bh=66HkfM54qH2Nm2H1gFAcRpEwHxCJvBes7eCPEKmglRc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZmXII/JRhAXbp3dxPx50M/uwXBKP9W60Hkiup214VjlCXhPiRvT+T0dhsAas5WMNATGbvIbqc8Sg8z9duN0rkolLdPdQ1hBfplWEvhvOWlaJNb4IcSCX9P5+fWdGchSXYyQiS55lE9aqdSlgbeOlsI/FzHsyWJKeK6GXH+Sf9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uscC3UhK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d7124938d1so54600967b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725576885; x=1726181685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qe7sMU7CMyVlg4wYJTFuE3k3+t0pyz81i/MJs7LyMxA=;
        b=uscC3UhKNoPmd3MPgjE5fOU3+Hy8QBBMB2yIluMyiiqxTDwzZa0jJQY/BVdTORienQ
         rClVWr9crNx5fuGq5r2OG75vSa8S4tbSFzaBuCyj9OW5gz0/2IYmjLEZf59fRc5toVhw
         yk03bx1ZYJ7eba78hIHFfjc66vqTboAGiBCW5YPgcknvUWDAW8WN460F7/PG2OoJZB+q
         Idmksy5WhVRPk1/IcJxcFtONTFNpBkVA/MMV4JAolLsM1ekhAJtZvxtTREirW/SqBu3B
         02kvhC5qV61UZ9Qd/jSTlu/Ffihv5wsC/ReTwtzTBhLHLfem+HiIuV9G5aSQv3+OfQQ0
         rZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725576885; x=1726181685;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qe7sMU7CMyVlg4wYJTFuE3k3+t0pyz81i/MJs7LyMxA=;
        b=YPXzD1D70/ee36EjGhjt09XNbmOSWmTbFrtF2QFQwGcn43PBVPOGI4AZ5rf4jap5VT
         TqW+pnFB752BqD0gfHNV6Lqs1eWiedJKZh+OiEHxdXXtq7Xd7jkxCssr5MDMEBuLXuAZ
         1uFNyFdr3y9kkM+rr5c7fS3X/PP5Zj69PxSy32tRgYmMNEOJo4ylMUNxlrG6O1KllFSa
         26rav92L6dPA2H28Mqek0FDv5GsoEwmO3J2B2T3BCIe/ztNlR9JXaxk2bqIjYiSI5Yfo
         /o4vcDNxY8gBuXPi/x4Nr8DF+st+h9dh6VBbm7LEMaPsYBmoQaip2wIcAzYoozZb3SRF
         gbZA==
X-Forwarded-Encrypted: i=1; AJvYcCUE2yP5QN5LrA4sQkufySOlt2ruxUizGt7sBiyqAj3okV1f18ru7Z/uuGhdE7xDgDqzGPn6RsSU0WFnfiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTA7wC1NONGEWoVcfrdBiMh7uS0DB4WsDdSyzlAmM79O/vM6T
	F2u6fHTKF3MRRMy8QJsz5LCVxtoByHk15g+SSc/gkGHidH8dhm/JStUf4Ri07Cj6UQn2IevlsPn
	TqyzVmUuqEEt2rkBngBFFfQ==
X-Google-Smtp-Source: AGHT+IHiipRZUHgv/ccItJEywLs+Y6NOEhbv2U3If2FP89J+ZfWB3UgZkzsVQ/3Z/8ti+VzYO35j3OXX0x55cwfimw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:6711:b0:697:9aae:1490 with
 SMTP id 00721157ae682-6db44d6d24emr479437b3.1.1725576885624; Thu, 05 Sep 2024
 15:54:45 -0700 (PDT)
Date: Thu, 05 Sep 2024 15:54:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK822mYC/x3NQQqDMBBA0avIrDsQo1L1KsWFjmMdaJOQTIsi3
 t3g8m3+PyBxFE7QFwdE/ksS7zLKRwG0ju7NKHM2WGNr05kGk0ZHYUfHitPnx+q9rkhfDUhjECR sm8lWc1sZ++wgd0LkRbb78RrO8wJ4mmU1cwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725576884; l=3321;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=66HkfM54qH2Nm2H1gFAcRpEwHxCJvBes7eCPEKmglRc=; b=3sARxrIPU3ZnudqZCM032OTV/zeA5NEOV9x8KnT2EwXxEkwIH8WeKVME5iPDE6+d9BOosRs+c
 KbiE6RRz0r9BFT+VUJ+dvhdSIogU0jRN2o0Qb14zPIZ6kHgcEZ6giM2
X-Mailer: b4 0.12.3
Message-ID: <20240905-strncpy-net-bluetooth-cmtp-capi-c-v1-1-c2d49caa2d36@google.com>
Subject: [PATCH] Bluetooth: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Karsten Keil <isdn@linux-pingi.de>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings [0]
and as such we should prefer more robust and less ambiguous string interfaces.

The CAPI (part II) [1] states that the manufacturer id should be a
"zero-terminated ASCII string" and should "always [be] zero-terminated."

Much the same for the serial number: "The serial number, a seven-digit
number coded as a zero-terminated ASCII string".

Along with this, its clear the original author intended for these
buffers to be NUL-padded as well. To meet the specification as well as
properly NUL-pad, use strscpy_pad().

In doing this, an opportunity to simplify this code is also present.
Remove the min_t() and combine the length check into the main if.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [0]
Link: https://capi.org/downloads.html [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

For future travelers: skb->data + CAPI_MSG_BASELN + 14 is a byte that
specifies the length of the message to follow, and of course "... + 15"
is the offset of the message itself.

Due to this, we cannot use the more appropriate memtostr_pad() because
we don't know all the sizes at compile time.
---
 net/bluetooth/cmtp/capi.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index f3bedc3b613a..884703fda979 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -248,18 +248,10 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_MANUFACTURER:
-			if (skb->len < CAPI_MSG_BASELEN + 15)
-				break;
-
-			if (!info && ctrl) {
-				int len = min_t(uint, CAPI_MANUFACTURER_LEN,
-						skb->data[CAPI_MSG_BASELEN + 14]);
-
-				memset(ctrl->manu, 0, CAPI_MANUFACTURER_LEN);
-				strncpy(ctrl->manu,
-					skb->data + CAPI_MSG_BASELEN + 15, len);
-			}
-
+			if (!info && ctrl && skb->len > CAPI_MSG_BASELEN + 14)
+				strscpy_pad(ctrl->manu,
+					    skb->data + CAPI_MSG_BASELEN + 15,
+					    skb->data[CAPI_MSG_BASELEN + 14]);
 			break;
 
 		case CAPI_FUNCTION_GET_VERSION:
@@ -276,18 +268,10 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_SERIAL_NUMBER:
-			if (skb->len < CAPI_MSG_BASELEN + 17)
-				break;
-
-			if (!info && ctrl) {
-				int len = min_t(uint, CAPI_SERIAL_LEN,
-						skb->data[CAPI_MSG_BASELEN + 16]);
-
-				memset(ctrl->serial, 0, CAPI_SERIAL_LEN);
-				strncpy(ctrl->serial,
-					skb->data + CAPI_MSG_BASELEN + 17, len);
-			}
-
+			if (!info && ctrl && skb->len > CAPI_MSG_BASELEN + 16)
+				strscpy_pad(ctrl->serial,
+					    skb->data + CAPI_MSG_BASELEN + 17,
+					    skb->data[CAPI_MSG_BASELEN + 16]);
 			break;
 		}
 

---
base-commit: 521b1e7f4cf0b05a47995b103596978224b380a8
change-id: 20240905-strncpy-net-bluetooth-cmtp-capi-c-85b23d830279

Best regards,
--
Justin Stitt <justinstitt@google.com>



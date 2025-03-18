Return-Path: <linux-kernel+bounces-565245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B87A6645B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8562F189C326
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC5913C908;
	Tue, 18 Mar 2025 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W00UpSy9"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976080BEC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259549; cv=none; b=s10BFt/ubtwzxhoydHeTfKOLShDsAOW377CLKomAW7e3V2dgKUff0ivUBPtofX2De5jhzSJGsjlXr3xS4eh+G4nPfE9e+Z2Wu2MthoO0qQUP5pjrrYCWRp8y9YjafVIKkIy/8a/yXypnsDUKQGnpGb/qtfIhQ1W5HVGT14ZGrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259549; c=relaxed/simple;
	bh=+TrQunPa4RQKzXKbpv2Ih+mNfUifzM4uHSUx0JnepJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MHKE1w+9YO83xhPfKbYYT2m4Tph39U56UoISMVn4aUyfPIb6JZszoQmjjH6MCJkyHP7eMQ684hxl6BdYl9z+tUbjAvCSktCotDbz+e6b1u+L+4ctiQXKJcTRgiWYOgGEpiqT8OJsxXqbRGzjCmkKzPdVe+dn1rJBZtd4hercFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W00UpSy9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240a96112fso135759085ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742259547; x=1742864347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibx/syLUqsgb68e3FVqXYSmyF8qos2WbbL99PMBMeQU=;
        b=W00UpSy99qz/bPNftuB89H/SrymZmlJt8qINmbil0j6+lAg9cXG54bNThbjtLpslhO
         X+3Z71fef3qOqXPfjVbY9T8179vjDB7imRRve5XBgTz3plPO+QEXUP1VafPETCgXP+WJ
         Kqulybqlb+yw8ymmFfxxbFlqJfUC1cJTCBlsm5ZpOeQ5yAp6qnPRDWyHUGOLDdOfoXbZ
         7L/spwSCECfjwgjJb8TP2OWUopuru46+8NODvjbgjAcIB3AAoc/TrAmMICWc8d9uwFs1
         LdREdZ2Bc+hdrVbwZfTLHDk+pAilRfVAw5B8JWLSmxtK51DT8wBhimzWy2e4O9p/awfe
         Z20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742259547; x=1742864347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibx/syLUqsgb68e3FVqXYSmyF8qos2WbbL99PMBMeQU=;
        b=TxXCK8gkBaKVZacFyCh2/FpdhHGSGyO8nQb7LEZo5em7KA9wZ8hO+4aMoQIC+U3uRO
         frxCnMG9tIuafbOIRTOJV2llFRD1JPxh9xcS0Vs+fxDEd9sBTXXsPHjZo6Xlc3j4i5mp
         srSkfdDY3wENjZo8ZManzhDAzs3CTg7rvbsPNQGilQVsaPoCAf3I2zrXqLpmGF7m0/6L
         EPNF1h5jRNO+g5LEVmrXCMoT0/D44oppjQek3CGqUxSvBY4oK5tx7pBeYS+GJQ0AuB7O
         WHFZtsVphgCOM2I4+SMP5VQ411OCyL83y6SrCC6ozXzmbEqWRvprcZMCx8BSzcY6Jj9M
         vBEw==
X-Forwarded-Encrypted: i=1; AJvYcCUblyzWIKQBQp0herv7kRm9V3lvnuKE+Cppu4eUvmPyNU2fDlFl/voug8bOJKtdpHgu/N+t/+3o5UxXjYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mch0r0LMBt7zOOoSzBTqJwv6Bzo9+CVBa8hVE/u2sjGJbjxK
	GHOvivxU2ViIERYsCgxy+5bLmqa9S1Aqf/L6ORMdSvV+0/+wBOJ3ehOvI3fACDlIwzppSw==
X-Google-Smtp-Source: AGHT+IFLzivrHPXBcsjy4o0OA17c93DCeQZvflyUk/2mSWWsNQD5DWtxngi7XPr/7/3Rh9vxLSCTYTqR
X-Received: from plblc15.prod.google.com ([2002:a17:902:fa8f:b0:224:cc7:127f])
 (user=elsk job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c411:b0:220:be86:a421
 with SMTP id d9443c01a7336-225e0b185bdmr173153685ad.38.1742259547377; Mon, 17
 Mar 2025 17:59:07 -0700 (PDT)
Date: Tue, 18 Mar 2025 00:59:00 +0000
In-Reply-To: <CAK7LNASqYkDTPNo20Bj1knwsJMrp=nbQyh__=Do67eWq4CKU3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAK7LNASqYkDTPNo20Bj1knwsJMrp=nbQyh__=Do67eWq4CKU3A@mail.gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318005900.2256921-1-elsk@google.com>
Subject: [PATCH v2] setlocalversion: use ${objtree}/include/config/auto.conf
From: HONG Yifan <elsk@google.com>
To: masahiroy@kernel.org
Cc: elsk@google.com, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux@rasmusvillemoes.dk
Content-Type: text/plain; charset="UTF-8"

setlocalversion reads include/config/auto.conf, which is located below
$(objtree) with commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to
some in-kernel build artifacts").

To be consistent, the setlocalversion script should use
${objtree}/include/config/auto.conf as well.

Signed-off-by: HONG Yifan <elsk@google.com>
---
v1: https://lore.kernel.org/lkml/20250312021154.102262-2-elsk@google.com/
v1 -> v2: fixed the other two locations of include/config/auto.conf in
setlocalversion script; also removed incorrect claim in commit message.

 scripts/setlocalversion | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 28169d7e143b..c13fe6e585e9 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -186,16 +186,16 @@ if ${no_local}; then
 	exit 0
 fi

-if ! test -e include/config/auto.conf; then
+if ! test -e ${objtree}/include/config/auto.conf; then
 	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
 	exit 1
 fi

 # version string from CONFIG_LOCALVERSION
-config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' include/config/auto.conf)
+config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' ${objtree}/include/config/auto.conf)

 # scm version string if not at the kernel version tag or at the file_localversion
-if grep -q "^CONFIG_LOCALVERSION_AUTO=y$" include/config/auto.conf; then
+if grep -q "^CONFIG_LOCALVERSION_AUTO=y$" ${objtree}/include/config/auto.conf; then
 	# full scm version string
 	scm_version="$(scm_version)"
 elif [ "${LOCALVERSION+set}" != "set" ]; then
--
2.49.0.rc1.451.g8f38331e32-goog



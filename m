Return-Path: <linux-kernel+bounces-425862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 517BA9DEBF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAAB16348E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019061A3BAD;
	Fri, 29 Nov 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9aAWFHe"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA301A3029;
	Fri, 29 Nov 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903964; cv=none; b=Bh5+nu3D7ujtwaDmXXCvXHy9GJPNGwK+hFxDd/s/HEd96b3ILy2/vBEGIeEyLPQOph2VVueXXuuASMCTt/M3I2C/8K3Ya3kY46nJCVOR7SU35orcmNcQ1ltXHxvmzjAcq+dIdBE0d+WhdYKDHs+GbPICfih+noaP4pmhP4mGCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903964; c=relaxed/simple;
	bh=kqVZcxr2geErHNMu4AkYEihsdaciCYHXfKJSpStpvsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhSXqwAOREPjAqWmwF5DGvtA/lZpPeZY1aJ/I+OGJVPWRdbxrQfWE1bVav2oSofSItn/J+yhwm+Eb9dZ1tsMv/8eSN8Yr4DdcHup1NdfKEJEPzwuf4ga4bagoVM4PhqSHrNVfcZmNkL8u6+8sxc+mRMox5CC2vu41WPcRnUvT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9aAWFHe; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7251331e756so2049252b3a.3;
        Fri, 29 Nov 2024 10:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732903962; x=1733508762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQjvmlBmTnpWwrzaJhwRwR0HEjEbZNM9WpX61TT7FQA=;
        b=O9aAWFHej8eeC3D0S9g0I89a8qQO4br8eGJwdoLHvORFQMdE9RZTTW/0Dq5uZoBrP2
         ncDkAimyhlHWQTpFF/Iugupf8m8geeWZH4FMrNail1+IxntVsgAfUwFgId3G01+ywQ7d
         sXGsissUlK2Tto3njjZeGFOSlWQmr1xElj9HetPyWocJLIvntEjAnYzFauAiQbE++0qJ
         IpyoD/J0ZGlNsezfsUua/+x6Wr9UhQrlipsyrepmqk4bbx4D0+lpQny2WNOsxtjFeV/A
         q7fUIs2l0n/TJsbrhyCXe/9gOJYtOb7z4B+T6ZnLhe2v8H/LKLrInsBGY7fcadzTrdj8
         ub9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732903962; x=1733508762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQjvmlBmTnpWwrzaJhwRwR0HEjEbZNM9WpX61TT7FQA=;
        b=hcVSSPmFmBXb93nXZkg+plPgHaOEvWS0SLMnCLTMlrASWYEm7HQUi0TAIlNXtC6994
         vicWvb+3QKzd3E7TBWY0pcukwuIo23hZ/QQy01J22bYhTpVdrbec3Y37nXEYrhbeSdtt
         hBjLSj1p9fCu+KJ/CJagrSAEpl7xa94VEcbCUUjlCEZXmiYYjSE46jRd2FMnhzt3fKnC
         J9zcWkbaX6YjPdLPhEtKiPo1RKpCcnAOXg1GWCsOi+uRUaVoR9RhwfNlbwLl0OrSy0zm
         F41dflDPxj5c7ln3I1pGJ4S9fn5DNgwGRZQJdrcQ6SVytmSnTzap9olqZ91LqTTAN+Tz
         RvKg==
X-Forwarded-Encrypted: i=1; AJvYcCV+QF0Uzy1vzWUizckf7GMEXpC89j3SoKJUA+Bi4HFaO570fM/oukPRDFkginJGq2+gQEYWgYADwEA=@vger.kernel.org, AJvYcCW9gQeNXgGJOy1UTDWP1Sp641RPBAbvMaGxl8n4upBUshQFs2GhErIvavxtoOvbDYjLfwp/3WyM3EQBHk5m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzh04h/hOmdaNaHrsBK5CdmCPYONtd1gmcl6Ak7BNbDuGTIRjl
	JOQH1CNKsO+PXDBi8eklDoTcd1JrAH9hJC14uv5VMT19N3K9WlY8
X-Gm-Gg: ASbGncv3S9SX8jHHaR0dyYbjquHh6ojfnhPptzr3EhrUKIa/m2XItNkKZB5k89MK3be
	UALFgbMeGnB6zVhU4z71CjJCpBOXrmJGiGk3v2RQ/Hb7lwp32GsotR211XtUNJvN4T+5187T246
	l7HAtsfLd6WhcZ2Z5lcjs5qdPFXtGXJOtQs1FM7Iun3foXNHpthTLiEweQ5lhONtCL+ifs1zLv6
	l3lsbWz6+48EtfvJaEmJAOCogdRz2380Lp2evfXYJIWlnwx2y9lEUiaAObsplQkgJ1aT4Txo74w
	eXzV
X-Google-Smtp-Source: AGHT+IH/K8ZMuW/Bx3jxlL8mjJ+wh9wYspjBuH2mgSskUDwiwkMEladJvo9ngd+NtfbVAj7Go8vStA==
X-Received: by 2002:a05:6a00:3d4e:b0:71e:4930:1620 with SMTP id d2e1a72fcca58-7253001506amr17016895b3a.3.1732903962497;
        Fri, 29 Nov 2024 10:12:42 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761474sm3760595b3a.32.2024.11.29.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:12:42 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	corbet@lwn.net
Cc: geert@linux-m68k.org,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 4/4] Documentation/core-api: min_heap: Add author information
Date: Sat, 30 Nov 2024 02:12:22 +0800
Message-Id: <20241129181222.646855-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129181222.646855-1-visitorckw@gmail.com>
References: <20241129181222.646855-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As with other documentation files, author information is added to
min_heap.rst, providing contact details for any questions regarding the
Min Heap API or the document itself.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 Documentation/core-api/min_heap.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/core-api/min_heap.rst b/Documentation/core-api/min_heap.rst
index 0c636c8b7aa5..683bc6d09f00 100644
--- a/Documentation/core-api/min_heap.rst
+++ b/Documentation/core-api/min_heap.rst
@@ -4,6 +4,8 @@
 Min Heap API
 ============
 
+:Author: Kuan-Wei Chiu <visitorckw@gmail.com>
+
 Introduction
 ============
 
-- 
2.34.1



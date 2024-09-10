Return-Path: <linux-kernel+bounces-323257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37420973A34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB899B23A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42910195F3B;
	Tue, 10 Sep 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlKdy1JM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B5A194C8B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979410; cv=none; b=AUa564Joh+ICYQIKumeZN6LJwVnLlXXYWeq9jY+5l74N06n77N9uETzs5vIkBbepAzNNHjdUpmugCqM85Q+cyfD3Zqu9o37Eq2nIHOgEzCvoUsPhd158uhZXvBgIe/Vl0KB9SX+Lt5rMbulWXqZ8YTZJF2VC1jfJrBBK6zyiaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979410; c=relaxed/simple;
	bh=gXjTEcttA5QttM+LvxBqEoFRUycgUByM82qJ/zmUKxU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DXd6ORdR+FYpUBe6spvmYxUs8i1PKmV3dSVO4S1q5w1oSt1BKfUbhavuHlBYyu6aCKe4+C43TtdmTOKC8MLC1G8RUxy00rDo1xrYLVqsQIW6egwoScRy+lW2RedbfS4qGnTs9eTTZBl4wVb/kXrMEC1Lg+uE+SkAjreq0VzZ/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlKdy1JM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d5fccc3548so118835697b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725979408; x=1726584208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYa30QP8uHW8yVnRTztEeL2KarXkSUIIYXYg/0AlhYM=;
        b=wlKdy1JM0F7qyZAZnV18bHBedb5QuMqc8tnkQRtqrKh6/VO0MXRga7hvr6sz9yqfD2
         vmurD3FIBJ2PhIFxWVawFHU5trBZ7/3y/mwFZX1K9C23JNNubMYmRnlTiav04yYuIsr9
         MOB3GRO79x2FqqJdDh52kjOECaXp+oc1eFb0hFa4xM9w0wO6K1xac32ObqknsZWZVrV7
         rStAES7rIgDa218pPfPRbFcXG0nIi3gKlEh+NfK00sVp7DpmAJS6NZkH//j3KQVxP4Ft
         VXvPIbDnPrwm99iUjHdo89PCx2qMIVeWSamhILV6ljb1ZQkfhPZNtXF087x/OxlwEggH
         TGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979408; x=1726584208;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYa30QP8uHW8yVnRTztEeL2KarXkSUIIYXYg/0AlhYM=;
        b=YOstWG7WE3W7LYPgsICk97qekC0VnbXDVdn/ZVBvHZWvh+doqKGZK5wBjEYLuYO+G/
         ZUuR9383XgH3djlw0MqJS9VMRTOinjnZRe2ntpSBwRpjNA55PE/2YR/BXx5VUQ23BFhH
         8CGTWiDIHT/TPumfyyM32xJHQ1x9JnULo2yCBHcFZvLLjocRD7yFylcznqbe8cgOvBYS
         TndpZqocyt2bRA11rVUMLZiOVsUWXtc2CY4BPhN4blY2df8495+bHZje+u0M7PKx31j2
         XJjIpvIWT2C7KpnSRSI9E9gk4WMduq5heeQhHyQ+xwid45nYVII3E+YF6FgJCKlbVfJS
         /UGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWLVCBGJnidakCJoc48d5beCylNdEJJSVB84BRxC9pW7rr9Z19mtZYSIEtII6VNwQ7aH80EZRoUZHpIfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1s5Zk5M1WJJgpRNPUbKA5GkCT2jqKNEkAP9xzq3hVg9XBIki
	ytJtPBRUx3ax7JyQaD9EodffVMEXyMkmsFrBX26EBUvfR56qaUMj+6XC8NghYJ+Z8/UW6X5UL+E
	+e2caepRKrPTO2SZ+3w==
X-Google-Smtp-Source: AGHT+IGgq1GkAoxcD6zcU6XOH8p/1bFQDbv0Q/GfZfdGV2paIgDh1U8RVYO9slVAAbo1tJutn3CPfqkJY5MrBxZ+
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:20a0:b0:6db:7f4d:f79f with
 SMTP id 00721157ae682-6db951c4d86mr745807b3.0.1725979408305; Tue, 10 Sep 2024
 07:43:28 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910144323.2888480-1-vdonnefort@google.com>
Subject: [PATCH 0/2] ring-buffer/selftest: Meta-page testing improvements
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the comments on the original patch [1] here's a set of 2 patches to
improve the selftest.

[1] https://lore.kernel.org/all/20240628104611.1443542-1-vdonnefort@google.com/

Vincent Donnefort (2):
  ring-buffer/selftest: Verify the entire meta-page padding
  ring-buffer/selftest: Handle meta-page bigger than the system

 tools/testing/selftests/ring-buffer/map_test.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)


base-commit: 2fcd5aff92aab479a9a89cfce2dbc9c6a9455b4f
-- 
2.46.0.598.g6f2099f65c-goog



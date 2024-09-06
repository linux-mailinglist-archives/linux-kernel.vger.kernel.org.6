Return-Path: <linux-kernel+bounces-318277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1807296EB03
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8133B212EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9B145A11;
	Fri,  6 Sep 2024 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpDbag+T"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210512C475
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605495; cv=none; b=Bce4BheAJMlPXtICP+ncEJJt7+YfhiA/QtstRhRVG49zaVPBDyyeNCba8nB8NHe5Osxoh9JDWmkmEfIcvTv7MwSRRDiNI/Cjff+oCk+Ykqqz/DG6ecOskwklOsMEVzKbZmDn1dWVYrZnQY6ZYWU8YLAAntEzzuVlcoMFjGTZzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605495; c=relaxed/simple;
	bh=SLxU/KchM9lZc2iifzYGl0ikYTYXfIHuX2seBA/+tVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJCzKZWCjXgtiYSx0+tQSpTqwnoh3xW7Z0E9fopttBibYCxrUkxeX17Dx04Jhxg3n4Bqp9RmWDxPN3aPHTzAGdpuY3LIz9k4dpS175w6WHI9UP3vve3KS1YoijHVJVlrB5BTcWdK5nAX+T7WBbG8RbahpJKuD/kCbDvQ85e8Hwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpDbag+T; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc6db23c74so23061975ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725605494; x=1726210294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zxPgcan/wlGxIATORmsnmNF0mblZEeZI51ZTLUgDKYk=;
        b=NpDbag+TArpq1AhPCdiUFtwQWEGzVtDHR8tE+LVKBbjY7cb1krGqK2svuXU2z7QuKj
         wZ7WxsMmQadyurdT5bDBy0y6hhAt0ZIrXQ5hLsLAXq5YhXv2/vKJ/Ea8jHALHxPUNNa6
         YtsfL1eaBSo6b1mbDhvB54TUi2zVlXsgIIZt94Xrjw0s36cJwjTcji1ob36fatyu0kti
         6kZwdySaa40Sg+80yBVMK36egrTh+SYJngQvNDha7YfXxngMtuNl325cETABeDtvfOLv
         mnedCer2wR9JKzTbMqjSmB9eaoBzuqh2ZX4nZmsJ6tRs8p/2biWca8f4Iac9KApfxYxS
         xbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605494; x=1726210294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxPgcan/wlGxIATORmsnmNF0mblZEeZI51ZTLUgDKYk=;
        b=tJdcPZze0Lv5/sTC8/dDY1k1B446gdmwMGFjMuv/eaQK8TebH8jns6NHuW+n0voWLh
         LFmGgh8u3g0yfj9kUh0adP+WTKjMJJrq9f3NbvaWVnIz9t1uQX/WeIxFaGT5On73blJM
         BaVM7oEkQEAnL7wLyzGCgWIl6KKzouo5/t+pfLsQiwqYTY+15UCJYdKtMZxg5KvZh19m
         FndmrgWUTVprtIR9sNR8ce+rrdwzaWjgecK9neZf0mmg69Cx0XGeqm/0V8TdPoM7R7RN
         tT6W8QTfGb++z5XubW0gBzGgQllJ7zrYP2PwmpNIkxFueyqsC23JWIewZjpIpkGw25SB
         L+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9RrRunV2ZxphcKxRpkyXRGf0aSzrzZCQd2snlPZIH5qZl+RrSsKxIBhkdqoMNdPzGxU65RFWJhLsJYdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOy7sf6ZfRPLVUij3xF+4AscjmofXhNlpoXAHXeEU6kNvSaAeP
	5jHWe92/dvbv+ksvDR1sWqJsRbyteLczL1/oDPxKeNmrcP2cpBgoO7p4NP3LKLuQTUYa4vwaIg=
	=
X-Google-Smtp-Source: AGHT+IGmwK9ZlhpLJHzZyb89hyaIZmCCVBcaqPhtMO6n7z0xo7Bo5WKyL7fOirbZ9TqadWXU/2jE6TZH4A==
X-Received: from wnliu.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:270f])
 (user=wnliu job=sendgmr) by 2002:a17:903:41cf:b0:205:6a9b:7e3c with SMTP id
 d9443c01a7336-206f0357b15mr663405ad.0.1725605493719; Thu, 05 Sep 2024
 23:51:33 -0700 (PDT)
Date: Fri,  6 Sep 2024 06:51:32 +0000
In-Reply-To: <7bc1bcb1cd875350948f43c77c9895173bd22012.1725334260.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <7bc1bcb1cd875350948f43c77c9895173bd22012.1725334260.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906065132.35917-1-wnliu@google.com>
Subject: Re: [RFC 28/31] x86/alternative: Create symbols for special section entrie
From: Weinan Liu <wnliu@google.com>
To: jpoimboe@kernel.org
Cc: jikos@kernel.org, joe.lawrence@redhat.com, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, mbenes@suse.cz, mpdesouza@suse.com, 
	peterz@infradead.org, pmladek@suse.com, song@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm observing multiple compilation errors when using clang-16 after applying this particular patch.

# CC      init/main.o
<instantiation>:4:1: error: symbol '__bug_table_0' is already defined
__bug_table_0:
^
<instantiation>:4:1: error: symbol '__bug_table_0' is already defined
__bug_table_0:
^
<instantiation>:4:1: error: symbol '__jump_table_0' is already defined
__jump_table_0:
^
<instantiation>:4:1: error: symbol '__bug_table_0' is already defined
__bug_table_0:
^
<instantiation>:4:1: error: symbol '__bug_table_0' is already defined
__bug_table_0:
^
<instantiation>:4:1: error: symbol '__jump_table_0' is already defined
__jump_table_0:
^
<instantiation>:4:1: error: symbol '__jump_table_0' is already defined
__jump_table_0:
^
7 errors generated.

--
Weinan


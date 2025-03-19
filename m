Return-Path: <linux-kernel+bounces-567195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C6BA68328
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E8E421406
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844E824E018;
	Wed, 19 Mar 2025 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frUO3+ZS"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA758F5B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742351189; cv=none; b=Bwg6E2S9x3vb2i5PGMVJL6wrP33OSG6CIRI/Ci+hfphGmsYi35b2R4xZMc+YH5td0TdeOHGI/JiG8AIPcxrGFfGGnY4huFUNHt+yo/UNe2jR2w711mZVtbduNa+RvUo3OJqWuTz6yIdd7Fzi3+NdCJ1Hf1gryZ0uwQyrCSHQEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742351189; c=relaxed/simple;
	bh=uSZSeti960HLGmltEj2aDxv6mJxka17WQJ/9EJpNTAU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GIAflagPjatS0FfQ+Z1GRhhMykMcU2VQgfFXZue7YKS4Cx2gxCROohaV3ly8uGnyatQf/z+gzQaict03bumXRWqaI7vp6Vjl0fBjYBehbgkDrCiKVguHJgkKWh+iAZ6Bvrj9dXHOeYWC1RxkLzC8PP4J2k92HHnZEpTddzAwxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frUO3+ZS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso10490789a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742351185; x=1742955985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U4vsXeepUEeOxZqJcsKC+HZWnLPWtFYoYFR/7gQya3w=;
        b=frUO3+ZSyCXPlDz3EfsUJWka0A0eZP0liDZHcM9hyksKsSjtER+MAkOLacJB3vCn5g
         bYOQmuFX53ycvhLH5K+hTxMhZMhU6bCmmuxv+t1rO/MKbTE3rXzFxExO81ExvJBL6IrX
         MLtnwHe2+RPc0y5DaSjC5JWYlH+1nTKdAtZP/48LO1IC8FA2dLEo6eEQxyiyPAHDsQ7s
         O4dV4Iej/1P6JMe3/9KxyEwh29FhktVMgoZ2eTy53tex12ywW3+FcqzOIFUcAjgX5QCs
         fy4wecIhx/IS8TEQ9kOkXaesAlVBWrdr+NiPzLHH0dH6E3g9qLzWh252FqPnAv1yfQCG
         s07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742351185; x=1742955985;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4vsXeepUEeOxZqJcsKC+HZWnLPWtFYoYFR/7gQya3w=;
        b=OKqzHw+MkD4B9GuRVre2Pol+NZ9OWkkGLLCA4UVXHAoSH8mr/BZyKix5ZdqLfakQw8
         z44h2wpaVuSq/DiDutoHJ0oPw4LtxWTxwxSM11aY2CTImjiv8cA/3hQ05B5rnuaCSESK
         FBBBbZiLLDtg0XR9G+dKroXy7yEkdm2mR/trzdALmwNXq8IAvOXepzPMka1uwlYRwgKG
         CkVAUUEZTprYlsuBChhhxEdQKq9EkPyBa08jyLKOGYHRXkOvaaqdGUNzOYeTR/jA9Bnl
         FQ+TUp+bxGasxUr/dOWUO+A182FQPHW4cxdrs4075LUM91aAMieTlBqFoGFlvZTOrUe2
         kdFg==
X-Forwarded-Encrypted: i=1; AJvYcCVhfUdiOlufRXY+peqyuoh5RsC9gS14mTwP0wSJQ2m8CilLOKFC1Zv6SmPIhq4Xabw/cfgXDDKTzGBFyDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyB84Mw9DQDf/7N9v6JRLYkpfJMw+d3Z2UmqCrMnC4AMX8Nuig
	wl4PNbSg6das8ttBNNWJLG7rEYosGvZkDJQjSwjGCTErXUy9lXPVx3f+4PqvYho3boQCE9+c96+
	2xENlpX+3RLJTkPJq5L3YbHx9h7Kg1iHqm80=
X-Gm-Gg: ASbGncsJvVAL/YgtiFkYme9huG0xMRGGWqPSJd+X6dHNsXLbgeFtZrT6aA7D9d6qMNd
	j5IfDHElYXZnFPFI7wKktzhZvVJOy9sHnngPRD+i50m9KoCz5zPf5Cbht8e+KUax3BM9VFLs/z7
	EjUp3aG6ZP5S0930vEFuufraL1B2AzapS4DnaIrN+OgL9WS70b0LkpXHjA2A==
X-Google-Smtp-Source: AGHT+IFsG3fmL3Hguq5glwa/DW+tCUwqRDNICUy1/upZyz49sCZT2EcJ3eibobo87bcUwByQlvJhIRv/KJBoPaxisNE=
X-Received: by 2002:a05:6402:354c:b0:5e6:1353:1319 with SMTP id
 4fb4d7f45d1cf-5eb80d156f3mr728522a12.12.1742351185221; Tue, 18 Mar 2025
 19:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leonardo Hirata <leo.fthirata@gmail.com>
Date: Tue, 18 Mar 2025 23:26:13 -0300
X-Gm-Features: AQ5f1Jp5fB_vAw4l9MAoMzV08w9YPFb-wDcDpoFxf4kfNEyuUG1HEIG7El-IgKw
Message-ID: <CAN-A22rSAtYqRNA_OtFUViY44fjV=sKRbnYHonEJtm2eSN8vyA@mail.gmail.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtDelete
To: syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000784c0e0630a8bf86"

--000000000000784c0e0630a8bf86
Content-Type: multipart/alternative; boundary="000000000000784c0d0630a8bf84"

--000000000000784c0d0630a8bf84
Content-Type: text/plain; charset="UTF-8"

#syz test

--000000000000784c0d0630a8bf84
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">#syz test</div>

--000000000000784c0d0630a8bf84--
--000000000000784c0e0630a8bf86
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-jfs-Add-check-for-array-bounds-in-dtReadFirst.patch"
Content-Disposition: attachment; 
	filename="0001-jfs-Add-check-for-array-bounds-in-dtReadFirst.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m8fasjvs0>
X-Attachment-Id: f_m8fasjvs0

RnJvbSBkMjAxNWRkZTM4ZDZmNzMwZWFiZGM2MTNlYjI2ZjdjNTlkYWE5Y2FiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZW9uYXJkbyBGZWxpcGUgVGFrYW8gSGlyYXRhIDxsZW8uZnRo
aXJhdGFAZ21haWwuY29tPgpEYXRlOiBUdWUsIDE4IE1hciAyMDI1IDIyOjAzOjU3IC0wMzAwClN1
YmplY3Q6IFtQQVRDSF0gamZzOiBBZGQgY2hlY2sgZm9yIGFycmF5IGJvdW5kcyBpbiBkdFJlYWRG
aXJzdAoKQWRkIGEgY2hlY2sgZm9yIGluZGV4IG91dCBvZiBib3VuZC4KClNpZ25lZC1vZmYtYnk6
IExlb25hcmRvIEZlbGlwZSBUYWthbyBIaXJhdGEgPGxlby5mdGhpcmF0YUBnbWFpbC5jb20+Ci0t
LQogZnMvamZzL2pmc19kdHJlZS5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvamZzL2pmc19kdHJlZS5jIGIvZnMvamZzL2pmc19k
dHJlZS5jCmluZGV4IDhmODUxNzdmMjg0Yi4uNGUyOWY4YzdkNjI0IDEwMDY0NAotLS0gYS9mcy9q
ZnMvamZzX2R0cmVlLmMKKysrIGIvZnMvamZzL2pmc19kdHJlZS5jCkBAIC0yMTI4LDYgKzIxMjgs
MTMgQEAgaW50IGR0RGVsZXRlKHRpZF90IHRpZCwKIAkJCQkJbmV4dF9pbmRleCA9IC0xOwogCQkJ
CWVsc2UgewogCQkJCQlzdGJsID0gRFRfR0VUU1RCTChucCk7CisKKwkJCQkJaWYgKHN0YmxbMF0g
PCAwIHx8IHN0YmxbMF0gPiAxMjcpIHsKKwkJCQkJCURUX1BVVFBBR0UobXApOworCQkJCQkJamZz
X2Vycm9yKGlwLT5pX3NiLCAic3RibFswXSBvdXQgb2YgYm91bmRcbiIpOworCQkJCQkJcmV0dXJu
IC1FSU87CisJCQkJCX0KKwogCQkJCQlsZHRlbnRyeSA9CiAJCQkJCSAgICAoc3RydWN0IGxkdGVu
dHJ5ICopICYgbnAtPgogCQkJCQkgICAgc2xvdFtzdGJsWzBdXTsKLS0gCjIuNDMuMAoK
--000000000000784c0e0630a8bf86--


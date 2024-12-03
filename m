Return-Path: <linux-kernel+bounces-428523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047D9E0F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A36A282F6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299998460;
	Tue,  3 Dec 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmA9psQh"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A70E10F2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185454; cv=none; b=eued3VQ2YSHzR2gvzvF3WURmuCrgChiyfWWHLZReOFFOb5vqOVMiqzOL+xClwhofAufN4NLyA15lPOSr9kOo1cx/RCjOHTmD0UK8QT0N9wPBYnjbXAeIM4b4t7isJ1QmgeDKq18HDpifWNKfIVRZKZZNl5vLrR8LbUPqr2UFQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185454; c=relaxed/simple;
	bh=PdsVFCQYAE/sv+UsjYSnw0UjlyMnxIcK5DXw6edeFJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sV/8cjeiBprG2AkBfLS29QY0Kby9Yd6Lc8ZxYrApu8GI6CpidpNvhkRir4CLo/Ey4sVpUSNltCoa0qKGtwcBFzuIVXPkc7XvTn7CR4INyfU78olu//bcAJGAUmWq3YKfeBLP3aDuAugz84hdx1hTD6cyDba1Z46/tuoLRK7TNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmA9psQh; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72524409ab8so4310305b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 16:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733185452; x=1733790252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TsiFxHi1VF1XagXj5qBJT0OVJosUppxUogJhrvvgIg=;
        b=WmA9psQh5nHzOHdHjsxfwX9yEL1PAe/IzJC6BS2WUQsvL/o8BUvrAD7Kn6oSXVe/Dm
         fSGZuDQAHf4mpKrgQuo05gBAXLn8HYEppHXg/4dC8k+0RHzaPC9jOlR0ajQxGPzuX/Di
         M9sPeRRkgoDsxPPLHtfU41ZOXvwtoW3yuaPDStc8ivAmxkdOk1DwLrHBi8Jw7bmkKLdv
         TwYZW5B8Z1JGxd7V1roVfeV8sph5BlETvU1z2E4Fq/koM5YhXt2nhcI/Ro21egzSHONv
         dNa0U2KgAwGExJbAEomH1eenfr+PEI53YcN+HYgb0HNjvH+GYLLXzKrACtj1dq+InE5q
         HfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185452; x=1733790252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TsiFxHi1VF1XagXj5qBJT0OVJosUppxUogJhrvvgIg=;
        b=kFBkho4uXSAyKcZAnRfCbUZwMv8tTwIDpH9JzSyaqFSrF/anzUgl71nVry/kOXYMmB
         qgcX6IwwygOFOeMoYCbugSKAwNib6tLGl9g1gLAFFuzSK0s3nz3+vxJ7DU2m6OuFhseN
         0ENvgGyKEq0KjIu58zMuKfuYDi4KbmpyvlQGLJFc/0eSXIYqkb2X9PBT2blWhqRz0FpD
         ZC1xyHaiwSrbU0gU2cvq+PpnSZb3pJ8xOGNYasXmzrHbKoVzhx8yjRulm3Blf/6Jlnrl
         Ig2XMHZHb3vC5RHUo3nGFB6qgOaM2cFxi/rYalucU0Ud9Qz4b9IkUP+ZU++77VBq7/Ch
         KIFA==
X-Forwarded-Encrypted: i=1; AJvYcCWEZpqwnTjQocyQxqBNIxVSqlO0iHYzFPYNFHapDebDHROcyKqtUN/Ak+r7um+fwXXqtE08JqIyZmFoAng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuuJJnM9jgjU9HFWIhAh+6ts4tjeO1rdSCxHBcCezxRL707teK
	TYZ5125VVtBxyVEc9H3UZLivav/vk7cp7T/zJDGSqly3qyBhW1O1H+QzL/rzk+/eSAIO/NUuxvQ
	YboxKmw==
X-Google-Smtp-Source: AGHT+IH1YI5TryAw2nTRBP/xW56Am59du2xa6FfKQesWVivnYYo3eiklKbzBqxct7qqAefyOGK+9SC1oss7A
X-Received: from pfbeb28.prod.google.com ([2002:a05:6a00:4c9c:b0:725:44a1:b5c2])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2ea8:b0:724:fac6:35f2
 with SMTP id d2e1a72fcca58-7257fa74556mr456519b3a.9.1733185452519; Mon, 02
 Dec 2024 16:24:12 -0800 (PST)
Date: Mon,  2 Dec 2024 16:23:28 -0800
In-Reply-To: <20241203002328.694071-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203002328.694071-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0
Message-ID: <20241203002328.694071-2-yuanchu@google.com>
Subject: [PATCH v5 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..92db5dcf0212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18894,6 +18894,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/purelifi/plfxlc/
 
+PVMEMCONTROL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/pvmemcontrol/
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.46.0



Return-Path: <linux-kernel+bounces-553650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52131A58CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903C216A5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE31120C019;
	Mon, 10 Mar 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIMYRQWO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0621B2194;
	Mon, 10 Mar 2025 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591856; cv=none; b=hKqk60Ql9eT6XMCR3rY+CUB97tCZQEIq80Wx1D/A5eEhdKEMZPlQ0kOSiR3uIVMLNmjJnYGsOyGoKuMacRj2cVJg6L1VYjQ2GDKliIRel3MUOjfjkImzanv4CCzLam+/LmfyCPfFJqwmk4+4W5kmx7zw/swWKaQ/nwuCNPwTbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591856; c=relaxed/simple;
	bh=84FRLwi3VEAwx0R6siAMlBRl+tmVlak6qHOsl3RR3Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pD1NkckvjhTFJK3nvHg8SoMgMrvL4jJJ+lSAxQR/agIhkcyZFkjBHTna4I4QqY6U8E1OZHRiSgJSTm8P3I1Z3oXcJRdeOeUIN9h0tYeo9L+Gvm9T9Uy/MO1yJdQ36UAG0nFEFTDnH6YQ3+RUSizQGV8WHvC9wKzkxusst7gDeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIMYRQWO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2234e4b079cso65794455ad.1;
        Mon, 10 Mar 2025 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741591854; x=1742196654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmUbl1SNPN33YKejJF44kES5GFJl90ttXQH6Y+6xWoY=;
        b=KIMYRQWOUaj0yAaKVZZ1tMIEI2M/3qGPIoYeA7u0UNa1gGRLIJQD41Q4wBOfY3la37
         OfRepmrWpKXxKFqRxOby1gInloYPX8RKEitjytGOuX9r0cNEbZ3WYg6H92CBkg5mDd/n
         8IZsnRYYnYDD5CUGoyJvLhpJzTD/gRRPytgEiaduDpwc8d19PUj913b8T90oyhbV/eYG
         tPnA9oSzoeuzOpXsgefE42LqNw2uf0DGvSg0UgsH4v8cHPRsqs8tuMzmYSpjsV9Lp4Vx
         I4e1amnGaFSIYKcq1BIm7BtO/WzTAiFxepz8lRTzsVympILWo65C4NhS239QuY9YFqq+
         v6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741591854; x=1742196654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmUbl1SNPN33YKejJF44kES5GFJl90ttXQH6Y+6xWoY=;
        b=N+tsvCdANKZ2F1lKtZy9iTlTR9sVwmXjgLHk3Hga+fmlc5+/cTcY3vobkQSL9a4l9M
         yxMh/BfCsxJE9Gp6XwiqBimAgexrj6xuSu2rl3fq1dV5FoPVXCpfPfSAcZ0SN8N4rgD6
         OAEUOYQ2PU3Vo+2a4udHqwTPVWOfBFj1U93AHYeOPBxrAcSUGYdueXW37bWN14fg2iOc
         HF1/UqIaGnOGPvdIomj+Q5cG0xiw7jZ1b9NHepHl30CzA2+a8TjtYvloHbCE3zNsz6Cf
         6iRVIuDNfZJrKWPanpMI5yNaWCxUpnRbw3ojE9EGPM+fhuQxVdSRCijEzCQOr1g/7Bzw
         TnDg==
X-Forwarded-Encrypted: i=1; AJvYcCVKI0aMZFHaRdCDVMgvSiwYJr6IlA2Php5+6ywtMQMwY1hATmblUSdZwMrnM276Xd6FtR2zjU6ibMw/quAb9Iw=@vger.kernel.org, AJvYcCVg3EuUyYPrnkaJHiMa4bfOeXgGoOcE/01AV8OBsCU3M2aIi/zE/6dxs1OYz5yUvCtVmPeeVsAo/gRwBDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYR0rMETwTpNM6mR7z5VBcN/PN9Jy58UHHGDCXR548XZGti1l/
	yV7hwuNxZnjVXhVtG4ZUMxmlygViaMbl6OERtx0PG/Ky4soeSqLw
X-Gm-Gg: ASbGncs1BF8sio2C1oGBKsW19Gm0Ut2nFX54GyFDIvjcaHPC4J3ObPgI4NmcBTj5EIR
	xt4IuH64iu5dzD2n4xrUprHEmmitg0jviVgX+3P9MbeVbxiCEejx/pbldJ0kJqhXMfJyy9+opYd
	POlQHq7ZVN93odlRq1MdhE2l5PdYRmq2jMOEU26UtLQndnqUHSVvkV0GRIsY2QPKcw2ren4ENLn
	ECHxUHUX3prmMzknUj9NdgsVd32mEP7XncnY+FyA8S7Nkyww+RvW/SzVcAd/0fHuEvy4mnRWlC6
	ktNwBDe+MJfHcSu7OxRGqrU+Bo+2YoQlczQ72CoQpUbcHa7TMj5pOJkxcSdfIpSEJz2HURQytQ=
	=
X-Google-Smtp-Source: AGHT+IGaLXdVookzjXhdP3t9TWNQSkoPex+/Iu3eVAiYGn0yVxQx1WSTeEMykevSKZRXTuYM7jsRtA==
X-Received: by 2002:a17:902:f686:b0:224:1ec0:8a1d with SMTP id d9443c01a7336-22428ab535bmr179596005ad.30.1741591853594;
        Mon, 10 Mar 2025 00:30:53 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:7ad0:37c7:5275:4b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f773sm70840715ad.117.2025.03.10.00.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:30:52 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: ojeda@kernel.org
Cc: alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	jserv@ccns.ncku.edu.tw,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RFC PATCH 0/2] rust: list: Add examples for linked list
Date: Mon, 10 Mar 2025 15:30:38 +0800
Message-ID: <20250310073040.423383-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduce runnable examples for linked list. They also
serve as the unit tests for the methods for "List".
A new initialized method is also introduced for "ListLinks", in order to
provide the ability to create a new "ListLinks" instance, and provide
simplicity for the examples.

If there exists a convenient and proper way to handle the return type
of "ListLinks::new()", e.g. "ListLinks::try_pin_init()" , then the
method won't be needed.

I Hsin Cheng (2):
  rust: list: Implement normal initializer for ListLinks
  rust: list: Add examples for linked list

 rust/kernel/list.rs | 100 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

-- 
2.43.0



Return-Path: <linux-kernel+bounces-305739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E389633A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D67EB221F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FDE1AD3F9;
	Wed, 28 Aug 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYhhewU5"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A945C1C;
	Wed, 28 Aug 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879516; cv=none; b=nOm4G7UzBsn89oNxsnbi5NuSOFO0y8kOfRX6cN2VvKXoUnNFkxxei+i2a4mqaqW9nzCRyaeBmUEoSjfhDSQRvfZaEqfDQC2S18B8zzd4FHiXepTiTzv+1jim+zxMPIrYQxiJh3rrSgsoz7qn6hslDWF+uwgQLsbNLFLY25Ynle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879516; c=relaxed/simple;
	bh=LiM/4SlZZKvIzLtOUn1+Pph3OMk6e3819t28zyfhShE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Upiw4d9R0enSH5NcFARpxKOlXeW04quWFL9DlHKpSriRVoazICVKVmBD1QWbJLE/3oOp8P5bQvX1E4nSA8pRszN2YxZtoAtBJU3oTpBfeSWnMTcbUX5ICixXs/5wnVU3aYwYpnt2C0SRpOI6fxQytVpQApUWf93If5ikwaS8zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYhhewU5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso5283460b3a.3;
        Wed, 28 Aug 2024 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724879514; x=1725484314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zl4Tt9hv3t5C1Kw2+jZBLI0RZikp9LOYZ7LK6MOKeUg=;
        b=GYhhewU5IJZPycPTo5QXZ+JcbNjEXlnaIXkuHSt/1yYk+/t5aeSf3Rt2qEYqm7rEzP
         o85xz00qb66z6m24zGfOUFyi1rmqI+lzeviZMq2oJYgZlBY/+UbtAOfPnKgYNQzpItlF
         U3JxL1WA1iKwTZPF3icvtWIAvqZZQlN/iExFhIzDGBOVzKEzNvmTLlD+KcykKE7lobPR
         gyPyPvZ0rM/9vMVwSj1sK9ojFkzJf7YETeNemM+jF81G0l0C72DUqgCymOAXdzoGq2CM
         v/MADB8pcGbaJuiKnGlCVmlE0IupmvDumCYNeCc68DLj5KTf3s9uFfOm0Io8Cllet8MA
         kfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879514; x=1725484314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zl4Tt9hv3t5C1Kw2+jZBLI0RZikp9LOYZ7LK6MOKeUg=;
        b=LMHyKNrhzS0+IqOPPq4skZqPaG4pIXLhpWglRvglc7f4KBcx9+XS1Z3U/LEdntXmAp
         RVV46cuBJI5l4NIsaJV2esLy1/T1/7newhMPmIqtB0/w/kL0JNoC0A4eGTWgObN1v3WI
         0kdG7feu4jj2Z4kU4IyNAvy1r/+h2EpXL4qaloASA/tXkAxl5Gf7l6rswzxXu2xT33lX
         QxUMRsFZaEjKr0Gc3EFq6Mh6khpzcWf+r67ozfoSNtsipxkXvjgSTkRar2hab6+h9X+R
         OCikAF4OKVqJTeIcfxcee3NTEjjXGjKifYcDe/4PzvmXEU8ZvqWIUQC9VRg4yncHyRIo
         ABhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1+7CGDQyk55YgQ/zLWLSkvMdlucE2GOHloZXMKtPAC8f+DwVQRYVI/aNID/TqJUZ5EYTfOFcvFCyS+rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzePcsPsiGKk53uqnWrdnxX6J4aOXOJXyiZ8aLPgl7ZBga7X593
	Glf4N2xDWMHRrZuDGquFmvgL6uOoOHNf/aOywOYb2ssJmAKaUL1R0SKtoQ==
X-Google-Smtp-Source: AGHT+IGdbDModVPZiD4uT/fzAFriBy75bIqHaVnLzbkm7RRohO8rq7RZuN9nEL7Y3Yio9YNjDu0fng==
X-Received: by 2002:a05:6a21:3318:b0:1c6:fc9f:eb68 with SMTP id adf61e73a8af0-1cce10ddd89mr539160637.50.1724879514437;
        Wed, 28 Aug 2024 14:11:54 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71434250f5asm10513557b3a.69.2024.08.28.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:11:54 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 1/1] MAINTAINERS: Remove Wedson as Rust maintainer
Date: Wed, 28 Aug 2024 18:11:17 -0300
Message-Id: <20240828211117.9422-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828211117.9422-1-wedsonaf@gmail.com>
References: <20240828211117.9422-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I am retiring from the project, so removing myself from MAINTAINERS as I won't
have time to dedicate to it.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..682708bdb940 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19907,7 +19907,6 @@ F:	tools/verification/
 RUST
 M:	Miguel Ojeda <ojeda@kernel.org>
 M:	Alex Gaynor <alex.gaynor@gmail.com>
-M:	Wedson Almeida Filho <wedsonaf@gmail.com>
 R:	Boqun Feng <boqun.feng@gmail.com>
 R:	Gary Guo <gary@garyguo.net>
 R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
-- 
2.34.1



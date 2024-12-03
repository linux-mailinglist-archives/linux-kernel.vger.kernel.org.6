Return-Path: <linux-kernel+bounces-430256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31E9E2E85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22256280D13
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3813620CCDC;
	Tue,  3 Dec 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLRusOH7"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012B20A5D8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262936; cv=none; b=UfW08CUHoyYXRYCWutfBnoBJD7b1kPYfLhFDWQZ962MDfmaLZmQ2dERVYqOy6q3w+clMXvCDlFitroa+ldb0P041O8Wp11R/z0uESNuHEK6hX5nucjMgoFvIPgt/j913I0hMhgkSlw46k7pieihlRSh+civsfx5Tl/i+6bTGHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262936; c=relaxed/simple;
	bh=Hg9fnL3gDvBL63BcSw9k4I1SGZC7TGor3Q6XV0SE8KQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hCzj5QYuJ2LXC5tB/G2WF4uQpW5TrnGkjr532060mDAl8gGlXpuQT3KHBKDEZx5v5qz3SaoYat0GZROLy8xNg5CSY9XENfLBePrWkW1DjoQED4Wq7qr1PK259+q2TuJ4suqmv7E/1g3VNOUFY+7kABwxZOXqjIMDp7O63mAmzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLRusOH7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so3522929a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262933; x=1733867733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nTHnYLNXxRVqIhYw/iiATQBbhG+EPSSwui359ARy6Zw=;
        b=WLRusOH7/TfJgJXCXWOU9T4UeIcWbZQLmbhxbvVt75i/dQPzq5+9fj6LZC2tQbcG9c
         Oq4sxDaDDQV3PjVzxTaI8fxb23Zve73IuOBG408VFtwt8RR0biu3D2pv3V+Y4eir4Eqg
         fEihBdCdseuIE9jwfM+B4iLMwzsZMsY0xke2YNgBsbONwUSFeFfdV+4Vmbu/j5i94kv1
         o0GOz8PNZTc+QITzakL7edZDq6522/S7sxbH6slMUHDUeinnekFNfXXDu/xkg+wsp0xR
         RVhzz+3/tRXJrW4teE6KcJdrdb8gDPriUCMgeBfOAihXJwvBCwNNHPXnyc+hSsCmPyOr
         UtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262933; x=1733867733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTHnYLNXxRVqIhYw/iiATQBbhG+EPSSwui359ARy6Zw=;
        b=fNjN2Z9E+Frv9S3N0eq8aBM76cApFaECj4lW3OGlX2SYjYS58YpzQwiQcVB4uVPhMP
         EYL3dLLjK9MB7k2HNJZykwWh4Ic0OlBBxUML4iqTISffay9xVS3rQQCa1dEoFKhsWWwZ
         Ut6Q1Y8J9gxX4+MKucG1fba5qc+89eIE8qOZ15hGerQzQow+MiFgoImnPJpblvi8mjjF
         K1kMHCtHx9QNOvhelW06+rPP5WHTGkVV0FadI8P8HuH5JWnpEhb7P7W2MafJqorfRkD9
         0lBHtt0HyaXbYDleA/lKl3yF0L8tSp3k54kzboc7QjQ/R+nAV4A4OHwSHq/etCx++Quk
         CKTQ==
X-Gm-Message-State: AOJu0Yye9WhUylvMoMMGJ1BtnFgBek63lU2QJ0/DcQf2QEYcA/fqjRl2
	ofEvfDaHhCa4M6Z7Y3dnf3FHxxs13cbrtSWXpFgHlwZZ6J2i1w71W6StvNIjp5XdkeO4dnPPSrL
	vztbH1QeRSw==
X-Google-Smtp-Source: AGHT+IHDaz8HMetpGTEx2zP5p+74f1udRv1tWE5LibIMiuX7tXSy/Rrh4psSGbjSK29kM4aTfTy5D49IXURipQ==
X-Received: from pfbbv3.prod.google.com ([2002:a05:6a00:4143:b0:725:34dd:498f])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41cd:b0:202:cbf:2d6f with SMTP id d9443c01a7336-215bd193289mr40994015ad.57.1733262933394;
 Tue, 03 Dec 2024 13:55:33 -0800 (PST)
Date: Tue,  3 Dec 2024 21:54:42 +0000
In-Reply-To: <20241203215452.2820071-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203215452.2820071-9-cmllamas@google.com>
Subject: [PATCH v6 8/9] binder: propagate vm_insert_page() errors
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Instead of always overriding errors with -ENOMEM, propagate the specific
error code returned by vm_insert_page(). This allows for more accurate
error logs and handling.

Cc: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 0c54e50841c8..5a221296b30c 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -353,7 +353,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		binder_free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
 		       alloc->pid, __func__, addr - alloc->vm_start, ret);
-		ret = -ENOMEM;
 		break;
 	}
 out:
-- 
2.47.0.338.g60cca15819-goog



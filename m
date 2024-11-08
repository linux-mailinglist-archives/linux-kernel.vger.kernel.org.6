Return-Path: <linux-kernel+bounces-402248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C579C256B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4B2B237DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE720B7E9;
	Fri,  8 Nov 2024 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gZpXBUz"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AE1F26FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093087; cv=none; b=I3Gkzgv6W3hx+WOiayLe7tV37LHffMV1gc4+5T61jZtb0ZYTirnslKDfEUW57iU11oNH/e+pvyQ38C9ZU99cxM12MsDFVBpqGEZATb/mfW14p9FHraW7LjY0WwlryceuhhRPLg6nosEbFHY3FwW6ZNaBEDUwcFeWAscLA8ZVifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093087; c=relaxed/simple;
	bh=oXmo3s4uftDvdjY703eY53QegBRUavVqxslFvZe6qZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPjnHkZxtrAm0wXlW8b4Z0sqwRcZg1FiTKy+SixSv5F29ooUR1pysiXv98ibiy5Sj7YLieC1Yk2tXVXJr5OZ30EfCAYXYZEDwBe/XtZ6RrmxlTRLCbZ6qne07XDMQTmlzvPaLgaW4s1YlfOpKCbkk+N9axz6ZKaDSMFoeW/x9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gZpXBUz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35199eb2bso49755317b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731093085; x=1731697885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDB9tBERWBcfIXqT9RtU/9i5IUOaPQLG2Xfsj/iAwwg=;
        b=2gZpXBUz4lOLgSLFEtH2dMB/Xnka8bkM0okpQjOMyH7zZmAAUN2Iq/gktcOvtBgAl2
         DSE/odAWi8j+HykRuTy/UEIu9xJqnNdTwxZ3Js89s8TOn5+CAa3uZD+64MES5lTMwaUD
         jqtbfteaT2OF54ur9Niyh+LXzjDrLBStMkaXkucuLz5v3g4Wcn51U2nh5zgU6My6Y25h
         HxqaJYknqb3QpwaKsPA1OhcaKWJ493214yBF/dVq5U1aluQKngFw3goReJcl8Nq6Tw7i
         FoHOKNZUsQEY9PwWqLIZES2Vp2yhN6B/cw8N3WioDT9Y/+grzdFAsfafJu0jsG815ag5
         ZCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093085; x=1731697885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDB9tBERWBcfIXqT9RtU/9i5IUOaPQLG2Xfsj/iAwwg=;
        b=H9Dovi/PKtdLBUuDbr+IYh7ofjMdZDVESX8mtMOkZIOsd3OtBt7ZD9uwso6+zgBTQE
         7s452CM9NpJOsrvgJVWjUYANQk1Jg5O98qw/ibhLwkRbrX02/Ob7wcjufYFrVR2K8pER
         zYffT3ztudLHc/JgwqHdpn+vOXo/ioUmtNdRcA/5q/q/+bWolzZLItxdYFERVw1fH3Hh
         09lI7ShVR6Yiqc/RSuM1UFZobDu23AdTQYcmQ9RLw+VeX26xP9l4wX0q1wVQ1x0YDOPE
         R8RM3fVidXBuYzOBGLsz34xivKIGhkVJZjuQrUNiJz2z0L4Yn2jirZ8m5zs+CcIDf4J9
         1lHA==
X-Gm-Message-State: AOJu0Yzdhsw30yiRtk6COFLDnkNUnikx7CFLsvi2VfwkbL4AjVfdmoMc
	OBMf9QRCOgspPmmFY7F9VWJFeIbgqCSG2qtkXTQAxud1sSIYp+0612eFKQKi4iR2lmvFAg1RfKW
	5G7mqseuUHw==
X-Google-Smtp-Source: AGHT+IGKQWTQrVOeGxJLhY6zsmXRHGk6UTdU0M7oaBS0NM4mJiA+JBFfZWaH36l8/W+fVD5IIc5QjZ01KGKgEg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a0d:cf43:0:b0:6e3:1f46:77a6 with SMTP id
 00721157ae682-6eaddd8b07emr400287b3.2.1731093085200; Fri, 08 Nov 2024
 11:11:25 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:50 +0000
In-Reply-To: <20241108191057.3288442-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108191057.3288442-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191057.3288442-9-cmllamas@google.com>
Subject: [PATCH v3 8/8] binder: propagate vm_insert_page() errors
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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 7d2cad9beebb..dd15519e321f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -334,7 +334,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		__free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
 		       alloc->pid, __func__, addr - alloc->vm_start, ret);
-		ret = -ENOMEM;
 		break;
 	}
 out:
-- 
2.47.0.277.g8800431eea-goog



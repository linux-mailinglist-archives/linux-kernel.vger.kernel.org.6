Return-Path: <linux-kernel+bounces-302021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D868B95F8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AAD281B65
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BAC1993B5;
	Mon, 26 Aug 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lt5E/D7y"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532B199244
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695842; cv=none; b=Jzf6HjiHSEhYjqNmcnkUrjzI+0njAL+DZsTRohOfmHP4tQO1tHsYqP/xDkKZDFprT9jus6M9L7FLco/kWFzxYCdSDhzOE4T8PN9IAuQH8W+8bi/VNJl3bnt3weLnVQkNGiAZ4DSFC53Agu4f+X8ATN5I7/hVkdZCV7QJSMsfwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695842; c=relaxed/simple;
	bh=rBirqSx11wJjgEPiT1TIlTne8kGylmF7zSv1EICuWrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FHRE/r9MRJ7CV0NOV+DfYkMLUOcMQEhgTBb1yEMDY3HCBmsU+okUOPhLPXdT1S8EHVAorIxNZtJ/9mQMhe/HHZ94ELvgfPSOZ2S8RTlTyi4/R8epR6uyweQnntg6zK8oaUQgSlldz/feduu01Aw+30EAH33kuaPrcFp2h4xru6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lt5E/D7y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b3fec974e5so87230457b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724695840; x=1725300640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaxxGv7jFfJqyIYiIuAizJBdptFEUd7hS9a99HmhF8g=;
        b=Lt5E/D7yDFwPY0izU4PU2XH6yhGmTc6L9A+16MCzixBxKkzPoaIebTqtE9fjfhwZRb
         4LgVWUp3aXbKuXmz5tAUeCnVOS7l+FtRAFeTtuL4wYi6e+k4No/crJpykIVcUgw8xs3w
         o0bL9vSwlCSzNc6JjT28m9HBEBRlaWICK36k5m2g7GcnyQTSeGGORmHgwsp8d7kzzks1
         kPMoc+ukZJcxiUZEhxH3c0cvzWvnEMx7wmAMWrmBGrMQChFBIObxUZOzMjHAbcedBgmM
         psVud87NIZ4jv5PJMHJGOIwDhF3jhkVcFR38rv/8WR8pDCZ/3VXuBQV0e3kkU/kMVSGj
         Y3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724695840; x=1725300640;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XaxxGv7jFfJqyIYiIuAizJBdptFEUd7hS9a99HmhF8g=;
        b=q1TKFskXH1bGBekjyC1wSTPTVldeaZx+0ToTQIkLoxU2RhvYErN0NaddXS5uyknL/O
         V074Wx4YrFdITO3jUqD711WZ/2hKRL4GJUsAd/c6rVEZzUsfSSV0tENsp0dvrIiIzejs
         M0gqQAcNG8yx16CNNL+3tKtzsv51/dfgbAR0UxWUnVRDJ5doHL+LPJ/st0gG9M4mGtoO
         n66JBKdlson6mvEa9WJviz2egUJWT8JP9ByYsSitOrtn+bdHSs4XeGhyrIHizaaxFqUu
         1p+DF2cbIZTOtUHYThVH4tyDoub1W/hKb79lizTHafZsxkFgZij78/B1w4VaC/EUlSgY
         qM5w==
X-Forwarded-Encrypted: i=1; AJvYcCVZfWcG14L8qyKjU6gG5P/5BI6bq+k6VWOsdJlBHbJGkXqKn6VVSkq6N6y7FbRF1V1YWi5aIhptlLU/Q+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tb+cUTn4MEI49trlJ0ugMc8wSBBvHIug7PAd3Qiz2QW9yFYu
	8bspx35yhfwq0GoBQBY/gElVYUz3t73CTPPhqxq34U6UhyDsn+S4+ihyfUnqz+9LgC6m4Pr7DcQ
	idE63amr0rwQoKgHYjA==
X-Google-Smtp-Source: AGHT+IF8ZV8FsZbdR4VjcVdwhThUJ+yFCGwm3hwa2GL7dij+a+kUwRzolQFuh8av8q6i/+SntdPLY+t9PpMbMqR9
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a05:690c:4a05:b0:6b0:57ec:c5f9 with
 SMTP id 00721157ae682-6c61eed1562mr4756357b3.0.1724695840610; Mon, 26 Aug
 2024 11:10:40 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:10:30 +0000
In-Reply-To: <20240826181032.3042222-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240826181032.3042222-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826181032.3042222-3-manojvishy@google.com>
Subject: [[PATCH v2 iwl-next] v2 2/4] idpf: Acquire the lock before accessing
 the xn->salt
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The transaction salt was being accessed before acquiring the
idpf_vc_xn_lock when idpf has to forward the virtchnl reply.

Fixes: 34c21fa894a1a (=E2=80=9Cidpf: implement virtchnl transaction manager=
=E2=80=9D)
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/=
ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..30eec674d594 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter=
,
 		return -EINVAL;
 	}
 	xn =3D &adapter->vcxn_mngr->ring[xn_idx];
+	idpf_vc_xn_lock(xn);
 	salt =3D FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt !=3D salt) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not matc=
h (%02x !=3D %02x)\n",
 				    xn->salt, salt);
+		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
=20
-	idpf_vc_xn_lock(xn);
 	switch (xn->state) {
 	case IDPF_VC_XN_WAITING:
 		/* success */
--=20
2.46.0.295.g3b9ea8a38a-goog


